SET search_path TO public;

-- Consuta 1: Identificar quais são os canais patrocinados e os valores de patrocínio pagos por empresa.
-- Otimizada: Usa vw_patrocinio_stats
DROP FUNCTION IF EXISTS status_patrocinio(INT);
CREATE OR REPLACE FUNCTION status_patrocinio(company_nbr INT DEFAULT NULL)
RETURNS TABLE( nro_empresa INT, nome_fantasia TEXT, nro_plataforma INT, nome_canal TEXT, valor_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        nro_empresa,
        nome_fantasia,
        nro_plataforma_fk,
        nome_canal,
        valor_USD
    FROM
        vw_patrocinio_stats
    WHERE
        company_nbr IS NULL OR nro_empresa = company_nbr
    ORDER BY
        nro_empresa,
        valor_USD DESC;
END;
$$ LANGUAGE plpgsql;

-- Consulta 2: Descobrir de quantos canais cada usuário é membro e a soma do valor desembolsado por usuário por mês.
-- Otimizada: Usa vw_usuario_stats
DROP FUNCTION IF EXISTS status_inscricao(TEXT);
CREATE OR REPLACE FUNCTION status_inscricao(user_nick TEXT DEFAULT NULL)
RETURNS TABLE(nick_usuario TEXT, total_de_canais BIGINT, total_gasto_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        nick,
        total_canais_inscrito,
        total_gasto_mensal_USD
    FROM
        vw_usuario_stats
    WHERE
        user_nick IS NULL OR nick = user_nick
    ORDER BY
        total_gasto_mensal_USD DESC;
END;
$$ LANGUAGE plpgsql;

-- Consulta 3: Listar e ordenar os canais que já receberam doações e a soma dos valores recebidos em doação.
-- Otimizada: Usa vw_resumo_financeiro_canal
DROP FUNCTION IF EXISTS status_doacao(TEXT);
CREATE OR REPLACE FUNCTION status_doacao(channel_name TEXT DEFAULT NULL)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, total_doacoes_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        nro_plataforma_fk,
        nome,
        total_doacao_USD
    FROM
        vw_resumo_financeiro_canal
    WHERE
        (channel_name IS NULL OR nome = channel_name)
        AND total_doacao_USD > 0
    ORDER BY
        total_doacao_USD DESC;
END;
$$ LANGUAGE plpgsql;

-- 4. Listar a soma das doações geradas pelos comentários que foram lidos por vídeo.
-- Otimizada: Usa vw_detalhe_video_engajamento
DROP FUNCTION IF EXISTS total_doacoes_lidas(video);
CREATE OR REPLACE FUNCTION total_doacoes_lidas(video_ref video DEFAULT NULL)
RETURNS TABLE (nro_plataforma INT, nome_canal TEXT, titulo TEXT, datah TIMESTAMP, total_doacoes_lidas_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        nro_plataforma_fk,
        nome_canal,
        titulo,
        datah,
        valor_doacoes_lidas_USD
    FROM
        vw_detalhe_video_engajamento
    WHERE
        valor_doacoes_lidas_USD > 0
        AND (video_ref IS NULL OR (nro_plataforma_fk = (video_ref).nro_plataforma_fk AND id_video = (video_ref).id_video))
    ORDER BY
        valor_doacoes_lidas_USD DESC;
END;
$$ LANGUAGE plpgsql;

-- 5. Listar e ordenar os k canais que mais recebem patrocínio e os valores recebidos.
-- Otimizada: Usa vw_resumo_financeiro_canal
DROP FUNCTION IF EXISTS rank_patrocinios(INT);
CREATE OR REPLACE FUNCTION rank_patrocinios(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, quantidade_patrocinios BIGINT, valor_total_patrocinios_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    -- Nota: vw_resumo_financeiro_canal não tem contagem de patrocinios, apenas valor total.
    -- Se a contagem for estritamente necessária, precisamos ajustar a view ou fazer join.
    -- O enunciado pede "Listar e ordenar os k canais que mais recebem patrocínio e os valores recebidos."
    -- "Mais recebem" pode ser quantidade ou valor. Assumindo valor para usar a view otimizada, 
    -- ou voltando à query original se quantidade for mandatória.
    -- Vou usar a tabela base para garantir a contagem correta, mas usando o índice idx_patrocinio_valor.
    SELECT
        p.nro_plataforma_fk,
        c.nome AS nome_canal,
        COUNT(*) AS quantidade_patrocinios,
        SUM(p.valor) AS valor_total_patrocinios_USD
    FROM
        patrocinio p
    JOIN canal c ON p.nro_plataforma_fk = c.nro_plataforma_fk AND p.id_canal_fk = c.id_canal
    GROUP BY
        p.nro_plataforma_fk,
        c.nome
    ORDER BY
        valor_total_patrocinios_USD DESC
    LIMIT
        k;
END;
$$ LANGUAGE plpgsql;

-- 6. Listar e ordenar os k canais que mais recebem aportes de membros e os valores recebidos.
-- Otimizada: Usa vw_resumo_financeiro_canal
DROP FUNCTION IF EXISTS rank_inscricoes(INT);
CREATE OR REPLACE FUNCTION rank_inscricoes(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, quantidade_membros BIGINT, valor_total_inscricoes_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        nro_plataforma_fk,
        nome,
        qtd_membros,
        total_inscricao_USD
    FROM
        vw_resumo_financeiro_canal
    ORDER BY
        total_inscricao_USD DESC
    LIMIT k;
END;
$$ LANGUAGE plpgsql;

-- 7. Listar e ordenar os k canais que mais receberam doações considerando todos os vídeos.
-- Otimizada: Usa vw_resumo_financeiro_canal
DROP FUNCTION IF EXISTS rank_doacoes(INT);
CREATE OR REPLACE FUNCTION rank_doacoes(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, quantidade_doacoes BIGINT) AS $$
BEGIN
    RETURN QUERY
    SELECT
        nro_plataforma_fk,
        nome,
        qtd_doacoes
    FROM
        vw_resumo_financeiro_canal
    ORDER BY
        qtd_doacoes DESC
    LIMIT
        k;
END;
$$ LANGUAGE plpgsql;

-- 8. Listar os k canais que mais faturam considerando as três fontes de receita: patrocínio, membros inscritos e doações.
-- Otimizada: Usa vw_ranking_geral
DROP FUNCTION IF EXISTS rank_faturamento(INT);
CREATE OR REPLACE FUNCTION rank_faturamento(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, total_patrocinio_USD NUMERIC, total_inscricao_USD NUMERIC, total_doacao_USD NUMERIC, total_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        nro_plataforma_fk,
        nome_canal,
        total_patrocinio_USD,
        total_inscricao_USD,
        total_doacao_USD,
        total_USD
    FROM
        vw_ranking_geral
    ORDER BY
        total_USD DESC
    LIMIT k;
END;
$$ LANGUAGE plpgsql;
