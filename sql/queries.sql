-- Consulta 2: Descobrir de quantos canais cada usuário é membro e a soma do valor desembolsado por usuário por mês.
CREATE OR REPLACE FUNCTION get_user_membership_stats(user_nick TEXT DEFAULT NULL)
RETURNS TABLE(nick_usuario TEXT, total_de_canais BIGINT, total_gasto NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.nick_membro,
        COUNT(DISTINCT i.nome_canal),
        SUM(nc.valor)
    FROM
        inscricao i
    JOIN
        nivel_canal nc ON i.nro_plataforma = nc.nro_plataforma
                       AND i.nome_canal = nc.nome_canal
                       AND i.nivel = nc.nivel
    WHERE
        user_nick IS NULL OR i.nick_membro = user_nick
    GROUP BY
        i.nick_membro;
END;
$$ LANGUAGE plpgsql;

-- Consulta 3: Listar e ordenar os canais que já receberam doações e a soma dos valores recebidos em doação.
CREATE OR REPLACE FUNCTION get_channel_donation_stats(channel_name TEXT DEFAULT NULL)
RETURNS TABLE(nome_canal TEXT, nro_plataforma INT, total_doacoes NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.nome_canal,
        d.nro_plataforma,
        SUM(d.valor) AS total_doacoes
    FROM
        doacao d
    WHERE
        channel_name IS NULL OR d.nome_canal = channel_name
    GROUP BY
        d.nro_plataforma,
        d.nome_canal
    ORDER BY
        total_doacoes DESC;
END;
$$ LANGUAGE plpgsql;
