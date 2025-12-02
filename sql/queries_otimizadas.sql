SET search_path TO public;

-- Consulta 1: Identificar quais são os canais patrocinados e os valores de patrocínio pagos por empresa.
DROP FUNCTION IF EXISTS status_patrocinio(INT);
CREATE OR REPLACE FUNCTION status_patrocinio(company_nbr INT DEFAULT NULL)
RETURNS TABLE( nro_empresa INT, nome_fantasia TEXT, nro_plataforma INT, nome_canal TEXT, valor_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.nro_plataforma,
        p.nome_canal,
        e.nro,
        e.nome_fantasia,
        p.valor AS valor_USD
    FROM
        patrocinio p
    JOIN
        empresa e ON e.nro = p.nro_empresa
    WHERE
        company_nbr IS NULL OR e.nro = company_nbr
    ORDER BY
        p.nro_plataforma,
        p.nome_canal;
END;
$$ LANGUAGE plpgsql;

-- Consulta 2: Descobrir de quantos canais cada usuário é membro e a soma do valor desembolsado por usuário por mês.
DROP FUNCTION IF EXISTS status_inscricao(TEXT);
CREATE OR REPLACE FUNCTION status_inscricao(user_nick TEXT DEFAULT NULL)
RETURNS TABLE(nick_usuario TEXT, total_de_canais INTEGER, total_gasto_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.nick_membro,
        COUNT(i.nick_membro) AS total_de_canais,
        ROUND(SUM(nc.valor * cvs.fator_conver), 2) AS total_gasto_USD
    FROM
        inscricao i
    JOIN
        nivel_canal nc ON i.nro_plataforma = nc.nro_plataforma
                        AND i.nome_canal = nc.nome_canal
                        AND i.nivel = nc.nivel
    JOIN
        usuario u ON u.nick = i.nick_membro
    JOIN
        pais p ON p.nome = u.pais_resid
    JOIN
        conversao cvs ON cvs.moeda = p.moeda
    WHERE
        user_nick IS NULL OR i.nick_membro = user_nick
    GROUP BY
        i.nick_membro
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
        v.nro_plataforma,
        v.nome_canal,
        ROUND(SUM(d.valor * cvs.fator_conver), 2) AS total_doacoes_USD
    FROM
        doacao d
    JOIN comentario c ON d.nro_plataforma = c.nro_plataforma 
                      AND d.id_video = c.id_video 
                      AND d.seq_comentario = c.seq_comentario
    JOIN video v ON c.nro_plataforma = v.nro_plataforma 
                 AND c.id_video = v.id_video
    JOIN usuario u ON c.nick_usuario = u.nick
    JOIN pais p ON u.pais_resid = p.nome
    join conversao cvs ON p.moeda = cvs.moeda
    WHERE
        (channel_name IS NULL OR v.nome_canal = channel_name)
        AND d.status <> 'recusado'
    GROUP BY
        v.nro_plataforma,
        v.nome_canal
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
        v.nro_plataforma,
        v.nome_canal,
        v.titulo,
        v.datah,
        ROUND(SUM(d.valor * cvs.fator_conver), 2) AS total_doacoes_lidas_USD
    FROM
        doacao d
    JOIN
        comentario c ON c.nro_plataforma = d.nro_plataforma 
                     AND c.id_video = d.id_video 
                     AND c.seq_comentario = d.seq_comentario
    JOIN
        video v ON v.nro_plataforma = c.nro_plataforma 
                AND v.id_video = c.id_video
    JOIN
        usuario u ON c.nick_usuario = u.nick
    JOIN
        pais p ON u.pais_resid = p.nome
    JOIN
        conversao cvs ON p.moeda = cvs.moeda
    WHERE
        d.status = 'lido'
        AND (video_ref IS NULL OR (v.nro_plataforma = (video_ref).nro_plataforma AND v.id_video = (video_ref).id_video))
    GROUP BY
        v.nro_plataforma,
        v.nome_canal,
        v.titulo,
        v.datah
    ORDER BY
        total_doacoes_lidas_USD DESC;
END;
$$ LANGUAGE plpgsql;

-- 5. Listar e ordenar os k canais que mais recebem patrocínio e os valores recebidos.
DROP FUNCTION IF EXISTS rank_patrocinios(INT);
CREATE OR REPLACE FUNCTION rank_patrocinios(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, quantidade_patrocinios INTEGER, valor_total_patrocinios_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        mv.nro_plataforma,
        mv.nome_canal,
        mv.qtd_patrocinios,
        mv.valor_patrocinios
    FROM
        public.mv_canal_metricas mv
    ORDER BY
        mv.valor_patrocinios DESC
    LIMIT
        k;
END;
$$ LANGUAGE plpgsql;

-- 6. Listar e ordenar os k canais que mais recebem aportes de membros e os valores recebidos.
DROP FUNCTION IF EXISTS rank_inscricoes(INT);
CREATE OR REPLACE FUNCTION rank_inscricoes(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, valor_total_inscricoes_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
        SELECT
            mv.nro_plataforma,
            mv.nome_canal,
            mv.valor_inscricoes
        FROM
            public.mv_canal_metricas mv
        ORDER BY
            mv.valor_inscricoes DESC
        LIMIT k;
END;
$$ LANGUAGE plpgsql;

-- 7. Listar e ordenar os k canais que mais receberam doações considerando todos os vídeos.
DROP FUNCTION IF EXISTS rank_doacoes(INT);
CREATE OR REPLACE FUNCTION rank_doacoes(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, quantidade_doacoes INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT
        mv.nro_plataforma,
        mv.nome_canal,
        mv.qtd_doacoes
    FROM
        public.mv_canal_metricas mv
    ORDER BY
        mv.qtd_doacoes DESC
    LIMIT
        k;
END;
$$ LANGUAGE plpgsql;

-- 8. Listar os k canais que mais faturam considerando as três fontes de receita: patrocínio, membros inscritos e doações.
-- OTIMIZADA: Usa CTEs para evitar Produto Cartesiano entre as tabelas de fatos (patrocinio, inscricao, doacao)
DROP FUNCTION IF EXISTS rank_faturamento(INT);
CREATE OR REPLACE FUNCTION rank_faturamento(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, 
    -- total_patrocinio_USD NUMERIC, 
    -- total_inscricao_USD NUMERIC, 
    -- total_doacao_USD NUMERIC, 
    total_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        mv.nro_plataforma,
        mv.nome_canal,
        ROUND(mv.valor_total_geral, 2)
    FROM
        public.mv_canal_metricas mv
    ORDER BY
        mv.valor_total_geral DESC
    LIMIT k;
END;
$$ LANGUAGE plpgsql;
