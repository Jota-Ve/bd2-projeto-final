-- Consuta 1: Identificar quais são os canais patrocinados e os valores de patrocínio pagos por empresa.
DROP FUNCTION IF EXISTS status_patrocinio(INT);
CREATE OR REPLACE FUNCTION status_patrocinio(company_nbr INT DEFAULT NULL)
RETURNS TABLE( nro_empresa INT, nome_fantasia TEXT, nro_plataforma INT, nome_canal TEXT, valor_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        e.nro,
        e.nome_fantasia,
        p.nro_plataforma,
        p.nome_canal,
        p.valor AS valor_USD
    FROM
        patrocinio p
    JOIN
        empresa e ON e.nro = p.nro_empresa
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
        d.nro_plataforma,
        d.nome_canal,
        ROUND(SUM(d.valor * cvs.fator_conver), 2) AS total_doacoes_USD
    FROM
        doacao d
    JOIN comentario c ON d.nro_plataforma = c.nro_plataforma
                      AND d.nome_canal = c.nome_canal
                      AND d.titulo_video = c.titulo_video
                      AND d.datah_video = c.datah_video
                      AND d.nick_usuario = c.nick_usuario
                      AND d.seq_comentario = c.seq
    JOIN usuario u ON c.nick_usuario = u.nick
    JOIN pais p ON u.pais_resid = p.nome
    join conversao cvs ON p.moeda = cvs.moeda
    WHERE
        (channel_name IS NULL OR d.nome_canal = channel_name)
        AND d.status <> 'recusado'
    GROUP BY
        d.nro_plataforma,
        d.nome_canal
    ORDER BY
        total_doacoes_USD DESC;
END;
$$ LANGUAGE plpgsql;



-- 5. Listar e ordenar os k canais que mais recebem patrocínio e os valores recebidos.
DROP FUNCTION IF EXISTS rank_patrocinios(INT);
CREATE OR REPLACE FUNCTION rank_patrocinios(k INT)
RETURNS TABLE(nro_plataforma INT, nome_canal TEXT, quantidade_patrocinios BIGINT, valor_total_patrocinios_USD NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.nro_plataforma,
        p.nome_canal,
        COUNT(*) AS quantidade_patrocinios,
        SUM(p.valor) AS valor_total_patrocinios_USD
    FROM
        patrocinio p
    GROUP BY
        p.nro_plataforma,
        p.nome_canal
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
        i.nro_plataforma,
        i.nome_canal,
        COUNT(i.nick_membro) AS quantidade_membros,
        SUM(nc.valor) AS valor_total_inscricoes_USD
    FROM
        inscricao i
    JOIN
        nivel_canal AS nc
        ON i.nro_plataforma = nc.nro_plataforma
        AND i.nome_canal = nc.nome_canal
        AND i.nivel = nc.nivel
    GROUP BY
        i.nro_plataforma, i.nome_canal
    ORDER BY
        valor_total_inscricoes_USD DESC
    LIMIT k;
END;
$$ LANGUAGE plpgsql;
