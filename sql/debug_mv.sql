DROP MATERIALIZED VIEW IF EXISTS public.mv_canal_metricas;

CREATE MATERIALIZED VIEW public.mv_canal_metricas AS
WITH patrocinios AS (
    SELECT 
        p.nro_plataforma, 
        p.nome_canal, 
        COUNT(*) as qtd,
        SUM(p.valor) as total
    FROM patrocinio p
    GROUP BY p.nro_plataforma, p.nome_canal
),
inscricoes AS (
    SELECT 
        i.nro_plataforma,
        i.nome_canal,
        COUNT(*) as qtd,
        SUM(nc.valor * cvs.fator_conver) AS total
    FROM
        inscricao i
    JOIN
        nivel_canal nc ON nc.nro_plataforma = i.nro_plataforma
                       AND nc.nome_canal = i.nome_canal
                       AND nc.nivel = i.nivel
    JOIN
        usuario u ON u.nick = i.nick_membro
    JOIN
        pais p ON p.nome = u.pais_resid
    JOIN
        conversao cvs ON cvs.moeda = p.moeda
    GROUP BY
        i.nro_plataforma,
        i.nome_canal
),
doacoes AS (
    SELECT 
        v.nro_plataforma, 
        v.nome_canal, 
        COUNT(*) as qtd,
        SUM(d.valor * cvs.fator_conver) as total
    FROM doacao d
    JOIN comentario co ON d.nro_plataforma = co.nro_plataforma 
                       AND d.id_video = co.id_video 
                       AND d.seq_comentario = co.seq_comentario
    JOIN video v ON co.nro_plataforma = v.nro_plataforma 
                 AND co.id_video = v.id_video
    JOIN usuario u ON co.nick_usuario = u.nick
    JOIN pais pa ON u.pais_resid = pa.nome
    JOIN conversao cvs ON pa.moeda = cvs.moeda
    WHERE d.status <> 'recusado'
    GROUP BY v.nro_plataforma, v.nome_canal
)
SELECT
    c.nro_plataforma,
    c.nome AS nome_canal,
    COALESCE(p.qtd, 0) AS qtd_patrocinios,
    COALESCE(p.total, 0) AS valor_patrocinios,
    COALESCE(i.qtd, 0) AS qtd_inscricoes,
    COALESCE(i.total, 0) AS valor_inscricoes,
    COALESCE(d.qtd, 0) AS qtd_doacoes,
    COALESCE(d.total, 0) AS valor_doacoes,
    (COALESCE(p.total, 0) + COALESCE(i.total, 0) + COALESCE(d.total, 0)) AS valor_total_geral
FROM
    canal c
LEFT JOIN patrocinios p ON c.nro_plataforma = p.nro_plataforma AND c.nome = p.nome_canal
LEFT JOIN inscricoes i ON c.nro_plataforma = i.nro_plataforma AND c.nome = i.nome_canal
LEFT JOIN doacoes d ON c.nro_plataforma = d.nro_plataforma AND c.nome = d.nome_canal;
