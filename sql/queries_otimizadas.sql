SET search_path TO public;

-- Consuta 1: Identificar quais são os canais patrocinados e os valores de patrocínio pagos por empresa.
DROP FUNCTION IF EXISTS status_patrocinio(INT);
CREATE OR REPLACE FUNCTION status_patrocinio(company_nbr INT DEFAULT NULL)
RETURNS TABLE( nro_empresa INT, nome_fantasia TEXT, nro_plataforma INT, nome_canal TEXT, valor_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        e.nro,
        e.nome_fantasia,
        p.nro_plataforma_fk,
        c.nome AS nome_canal,
        p.valor AS valor_USD
    FROM
        patrocinio p
    JOIN
        empresa e ON e.nro = p.nro_empresa_fk
    JOIN
        canal c ON p.nro_plataforma_fk = c.nro_plataforma_fk AND p.id_canal_fk = c.id_canal
    WHERE
        company_nbr IS NULL OR e.nro = company_nbr
    ORDER BY
        e.nro,
        p.valor DESC;
END;
$$ LANGUAGE plpgsql;

-- Consulta 2: Descobrir de quantos canais cada usuário é membro e a soma do valor desembolsado por usuário por mês.
DROP FUNCTION IF EXISTS status_inscricao(TEXT);
CREATE OR REPLACE FUNCTION status_inscricao(user_nick TEXT DEFAULT NULL)
RETURNS TABLE(nick_usuario TEXT, total_de_canais BIGINT, total_gasto_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        u.nick AS nick_membro,
        COUNT(i.id_canal_fk) AS total_de_canais,
        ROUND(SUM(nc.valor * cvs.fator_conver), 2) AS total_gasto_USD
    FROM
        inscricao i
    JOIN
        nivel_canal nc ON i.nro_plataforma_fk = nc.nro_plataforma_fk
                        AND i.id_canal_fk = nc.id_canal_fk
                        AND i.nivel = nc.nivel
    JOIN
        usuario u ON u.id_usuario = i.id_usuario_fk
    JOIN
        pais p ON p.id_pais = u.id_pais_resid_fk
    JOIN
        conversao cvs ON cvs.id_conversao = p.id_conversao_fk
    WHERE
        user_nick IS NULL OR u.nick = user_nick
    GROUP BY
        u.nick
    ORDER BY
        total_gasto_USD DESC;
END;
$$ LANGUAGE plpgsql;

-- Consulta 3: Listar e ordenar os canais que já receberam doações e a soma dos valores recebidos em doação.
DROP FUNCTION IF EXISTS status_doacao(TEXT);
CREATE OR REPLACE FUNCTION status_doacao(channel_name TEXT DEFAULT NULL)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, total_doacoes_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.nro_plataforma_fk,
        cn.nome AS nome_canal,
        ROUND(SUM(d.valor * cvs.fator_conver), 2) AS total_doacoes_USD
    FROM
        doacao d
    JOIN comentario c ON d.nro_plataforma_fk_comentario = c.nro_plataforma_fk
                      AND d.id_video_fk_comentario = c.id_video_fk
                      AND d.seq_comentario_fk = c.seq_comentario
    JOIN video v ON c.nro_plataforma_fk = v.nro_plataforma_fk AND c.id_video_fk = v.id_video
    JOIN canal cn ON v.nro_plataforma_fk = cn.nro_plataforma_fk AND v.id_canal_fk = cn.id_canal
    JOIN usuario u ON c.id_usuario_fk = u.id_usuario
    JOIN pais p ON u.id_pais_resid_fk = p.id_pais
    JOIN conversao cvs ON p.id_conversao_fk = cvs.id_conversao
    WHERE
        (channel_name IS NULL OR cn.nome = channel_name)
        AND d.status <> 'recusado'
    GROUP BY
        v.nro_plataforma_fk,
        cn.nome
    ORDER BY
        total_doacoes_USD DESC;
END;
$$ LANGUAGE plpgsql;

-- 4. Listar a soma das doações geradas pelos comentários que foram lidos por vídeo.
DROP FUNCTION IF EXISTS total_doacoes_lidas(video);
CREATE OR REPLACE FUNCTION total_doacoes_lidas(video_ref video DEFAULT NULL)
RETURNS TABLE (nro_plataforma INT, nome_canal TEXT, titulo TEXT, datah TIMESTAMP, total_doacoes_lidas_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.nro_plataforma_fk,
        cn.nome AS nome_canal,
        v.titulo,
        v.datah,
        ROUND(SUM(d.valor * cvs.fator_conver), 2) AS total_doacoes_lidas_USD
    FROM
        doacao d
    JOIN comentario c ON d.nro_plataforma_fk_comentario = c.nro_plataforma_fk
                      AND d.id_video_fk_comentario = c.id_video_fk
                      AND d.seq_comentario_fk = c.seq_comentario
    JOIN video v ON c.nro_plataforma_fk = v.nro_plataforma_fk AND c.id_video_fk = v.id_video
    JOIN canal cn ON v.nro_plataforma_fk = cn.nro_plataforma_fk AND v.id_canal_fk = cn.id_canal
    JOIN usuario u ON c.id_usuario_fk = u.id_usuario
    JOIN pais p ON u.id_pais_resid_fk = p.id_pais
    JOIN conversao cvs ON p.id_conversao_fk = cvs.id_conversao
    WHERE
        d.status = 'lido'
        AND (video_ref IS NULL OR (v.nro_plataforma_fk = (video_ref).nro_plataforma_fk AND v.id_video = (video_ref).id_video))
    GROUP BY
        v.nro_plataforma_fk,
        cn.nome,
        v.titulo,
        v.datah
    ORDER BY
        total_doacoes_lidas_USD DESC;
END;
$$ LANGUAGE plpgsql;

-- 5. Listar e ordenar os k canais que mais recebem patrocínio e os valores recebidos.
DROP FUNCTION IF EXISTS rank_patrocinios(INT);
CREATE OR REPLACE FUNCTION rank_patrocinios(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, quantidade_patrocinios BIGINT, valor_total_patrocinios_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
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
DROP FUNCTION IF EXISTS rank_inscricoes(INT);
CREATE OR REPLACE FUNCTION rank_inscricoes(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, quantidade_membros BIGINT, valor_total_inscricoes_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.nro_plataforma_fk,
        c.nome AS nome_canal,
        COUNT(i.id_usuario_fk) AS quantidade_membros,
        SUM(nc.valor) AS valor_total_inscricoes_USD
    FROM
        inscricao i
    JOIN canal c ON i.nro_plataforma_fk = c.nro_plataforma_fk AND i.id_canal_fk = c.id_canal
    JOIN
        nivel_canal AS nc
        ON i.nro_plataforma_fk = nc.nro_plataforma_fk
        AND i.id_canal_fk = nc.id_canal_fk
        AND i.nivel = nc.nivel
    GROUP BY
        i.nro_plataforma_fk, c.nome
    ORDER BY
        valor_total_inscricoes_USD DESC
    LIMIT k;
END;
$$ LANGUAGE plpgsql;

-- 7. Listar e ordenar os k canais que mais receberam doações considerando todos os vídeos.
DROP FUNCTION IF EXISTS rank_doacoes(INT);
CREATE OR REPLACE FUNCTION rank_doacoes(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, quantidade_doacoes BIGINT) AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.nro_plataforma_fk,
        cn.nome AS nome_canal,
        COUNT(*) AS quantidade_doacoes
    FROM
        doacao d
    JOIN comentario c ON d.nro_plataforma_fk_comentario = c.nro_plataforma_fk
                      AND d.id_video_fk_comentario = c.id_video_fk
                      AND d.seq_comentario_fk = c.seq_comentario
    JOIN video v ON c.nro_plataforma_fk = v.nro_plataforma_fk AND c.id_video_fk = v.id_video
    JOIN canal cn ON v.nro_plataforma_fk = cn.nro_plataforma_fk AND v.id_canal_fk = cn.id_canal
    WHERE
        d.status <> 'recusado'
    GROUP BY
        v.nro_plataforma_fk,
        cn.nome
    ORDER BY
        quantidade_doacoes DESC
    LIMIT
        k;
END;
$$ LANGUAGE plpgsql;

-- 8. Listar os k canais que mais faturam considerando as três fontes de receita: patrocínio, membros inscritos e doações.
-- OTIMIZADA: Usa CTEs para evitar Produto Cartesiano entre as tabelas de fatos (patrocinio, inscricao, doacao)
DROP FUNCTION IF EXISTS rank_faturamento(INT);
CREATE OR REPLACE FUNCTION rank_faturamento(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, total_patrocinio_USD NUMERIC, total_inscricao_USD NUMERIC, total_doacao_USD NUMERIC, total_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    WITH patrocinios AS (
        SELECT 
            p.nro_plataforma_fk, 
            p.id_canal_fk, 
            SUM(p.valor) as total
        FROM patrocinio p
        GROUP BY p.nro_plataforma_fk, p.id_canal_fk
    ),
    inscricoes AS (
        SELECT 
            i.nro_plataforma_fk, 
            i.id_canal_fk, 
            SUM(nc.valor) as total
        FROM inscricao i
        JOIN nivel_canal nc ON i.nro_plataforma_fk = nc.nro_plataforma_fk 
                            AND i.id_canal_fk = nc.id_canal_fk 
                            AND i.nivel = nc.nivel
        GROUP BY i.nro_plataforma_fk, i.id_canal_fk
    ),
    doacoes AS (
        SELECT 
            v.nro_plataforma_fk, 
            v.id_canal_fk, 
            SUM(d.valor * cvs.fator_conver) as total
        FROM doacao d
        JOIN comentario co ON d.nro_plataforma_fk_comentario = co.nro_plataforma_fk 
                           AND d.id_video_fk_comentario = co.id_video_fk 
                           AND d.seq_comentario_fk = co.seq_comentario
        JOIN video v ON co.nro_plataforma_fk = v.nro_plataforma_fk 
                     AND co.id_video_fk = v.id_video
        JOIN usuario u ON co.id_usuario_fk = u.id_usuario
        JOIN pais pa ON u.id_pais_resid_fk = pa.id_pais
        JOIN conversao cvs ON pa.id_conversao_fk = cvs.id_conversao
        WHERE d.status <> 'recusado'
        GROUP BY v.nro_plataforma_fk, v.id_canal_fk
    )
    SELECT
        c.nro_plataforma_fk,
        c.nome,
        COALESCE(p.total, 0) AS total_patrocinio_USD,
        COALESCE(i.total, 0) AS total_inscricao_USD,
        ROUND(COALESCE(d.total, 0), 2) AS total_doacao_USD,
        (COALESCE(p.total, 0) + COALESCE(i.total, 0) + ROUND(COALESCE(d.total, 0), 2)) AS total_USD
    FROM
        canal c
    LEFT JOIN patrocinios p ON c.nro_plataforma_fk = p.nro_plataforma_fk AND c.id_canal = p.id_canal_fk
    LEFT JOIN inscricoes i ON c.nro_plataforma_fk = i.nro_plataforma_fk AND c.id_canal = i.id_canal_fk
    LEFT JOIN doacoes d ON c.nro_plataforma_fk = d.nro_plataforma_fk AND c.id_canal = d.id_canal_fk
    ORDER BY
        total_USD DESC
    LIMIT k;
END;
$$ LANGUAGE plpgsql;
