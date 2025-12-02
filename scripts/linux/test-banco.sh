#!/bin/bash
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

echo -e "\n🧪🏦 Rodando testes no banco..."

echo -e "\n🔎 Contando linhas em todas as tabelas do schema public (estimativa)...\n"
docker exec -i bd2_postgres psql -U postgres -d streamers -c "
SELECT relname AS tabela, n_live_tup AS linhas_estimadas
FROM pg_stat_user_tables
ORDER BY relname;
"

echo -e "\n📊 Top 10 patrocínios (função q1_status_patrocinio)..."
docker exec -i bd2_postgres psql -U postgres -d streamers -c "
SELECT * FROM status_patrocinio() LIMIT 10;
"

echo -e "\n🧪🏦 ✅ Teste do Banco de Dados concluído!"