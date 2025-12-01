WITH faturamento AS (
        SELECT nro_plataforma, nome_canal, total_USD 
        FROM public.q8_rank_faturamento(999999)
        -- GROUP BY nro_plataforma, nome_canal
    UNION ALL
        SELECT nro_plataforma, nome_canal, total_USD 
        FROM public.rank_faturamento(999999)
        

) 

-- GROUP BY nro_plataforma, nome_canal

-- SELECT * FROM faturamento;
, T2 AS (
    SELECT T.nro_plataforma, T.nome_canal, (MAX(total_USD) - MIN(total_USD)) AS diff
    FROM faturamento T
    GROUP BY T.nro_plataforma, T.nome_canal
    -- HAVING SUM(T.diff) <> 0
)

SELECT COUNT(*), (SELECT COUNT(*) FROM T2 WHERE T2.diff = 0) as count_iguais, SUM(T2.diff), SUM(T2.diff) / COUNT(*) --  AS media_diferença
FROM  T2
-- ORDER BY COUNT(T.*);