#!/bin/bash
echo "🔎 Contando linhas em todas as tabelas do schema public (estimativa)..."

docker exec -i bd2_postgres psql -U postgres -d streamers -c "
SELECT relname AS tabela, n_live_tup AS linhas_estimadas
FROM pg_stat_user_tables
ORDER BY relname;
"

echo "📊 Top 10 do faturamento (função rank_faturamento)..."

docker exec -i bd2_postgres psql -U postgres -d streamers -c "
SELECT * FROM rank_faturamento(10);
"

echo "✅ Teste do banco de dados concluído!"