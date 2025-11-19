-- Consulta 2: Descobrir de quantos canais cada usuário é membro e a soma do valor desembolsado por usuário por mês.
DROP FUNCTION IF EXISTS get_user_membership_stats(TEXT);
CREATE OR REPLACE FUNCTION get_user_membership_stats(user_nick TEXT DEFAULT NULL)
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
DROP FUNCTION IF EXISTS get_channel_donation_stats(TEXT);
CREATE OR REPLACE FUNCTION get_channel_donation_stats(channel_name TEXT DEFAULT NULL)
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
