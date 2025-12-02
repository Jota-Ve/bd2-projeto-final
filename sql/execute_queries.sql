-- Teste das funções otimizadas

\echo '--- Testando rank_faturamento(5) ---'
SELECT * FROM rank_faturamento(5);

\echo '--- Testando rank_patrocinios(5) ---'
SELECT * FROM rank_patrocinios(5);

\echo '--- Testando rank_inscricoes(5) ---'
SELECT * FROM rank_inscricoes(5);

\echo '--- Testando rank_doacoes(5) ---'
SELECT * FROM rank_doacoes(5);

\echo '--- Testando status_patrocinio(NULL) LIMIT 5 ---'
SELECT * FROM status_patrocinio(NULL) LIMIT 5;

\echo '--- Testando status_inscricao(NULL) LIMIT 5 ---'
SELECT * FROM status_inscricao(NULL) LIMIT 5;

\echo '--- Testando status_doacao(NULL) LIMIT 5 ---'
SELECT * FROM status_doacao(NULL) LIMIT 5;

\echo '--- Testando total_doacoes_lidas(NULL) LIMIT 5 ---'
SELECT * FROM total_doacoes_lidas(NULL) LIMIT 5;
