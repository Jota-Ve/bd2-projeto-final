-- 5. Listar e ordenar os k canais que mais recebem patrocínio e os valores recebidos.

SELECT
    nro_plataforma, nome_canal,
    COUNT(*) AS quantidade_patrocinios,
    SUM(valor) AS valor_total_patrocinios_USD
FROM patrocinio
GROUP BY
    nro_plataforma, nome_canal
ORDER BY
    quantidade_patrocinios DESC, 
    valor_total_patrocinios_USD DESC
LIMIT :k;


-- 6. Listar e ordenar os k canais que mais recebem aportes de membros e os valores recebidos.
SELECT
    I.nro_plataforma, I.nome_canal,
    -- total de membros ativos 
    COUNT(I.nick_membro) AS membros_pagantes,
    -- soma do valor mensal por nivel    
    SUM(N.valor) AS valor_total_USD
FROM inscricao I
JOIN
    nivel_canal AS N
    ON I.nro_plataforma = N.nro_plataforma
    AND I.nome_canal = N.nome_canal
    AND I.nivel = N.nivel
GROUP BY
    I.nro_plataforma, I.nome_canal
ORDER BY
    membros_pagantes DESC,
    valor_total_USD DESC
LIMIT :k;
