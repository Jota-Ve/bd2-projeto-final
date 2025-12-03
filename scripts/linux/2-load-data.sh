#!/bin/bash
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

echo -e "\n🏦 Aguardando inicialização do Postgres e criação do banco streamers..."
until docker exec bd2_postgres psql -U postgres -d postgres -q -tAc "SELECT 1 FROM pg_database WHERE datname='streamers'" | grep -q 1; do
  sleep 1
done
echo -e "\n🏦 ✅ Banco streamers pronto!\n"

echo -e "\n📜 Aplicando DDL do Banco de Dados..."
docker exec -i bd2_postgres psql -U postgres -d streamers -q < sql/DDL-streamers.sql
echo -e "📜 ✅ Banco de Dados criado!\n"

docker exec -i bd2_postgres psql -U postgres -d streamers -q < sql/DDL-streamers-optimization.sql
echo -e "📜 ✅ Views, Indicies e Triggers criadas!\n"

echo -e "\n⚙️  Criando funções para responder queries..."
docker exec -i bd2_postgres psql -U postgres -d streamers -q < sql/queries_otimizadas.sql
docker exec -i bd2_postgres psql -U postgres -d streamers -q < sql/queries.sql
echo -e "\n⚙️  ✅ Queries prontas!\n"


# valor padrão
SCALE="1.0"

# se foi passado --scale X, usa X
if [[ "${1:-}" == "--scale" ]]; then
  SCALE="${2:-1.0}"
fi

echo -e "\n🐍🎲 Populando tabelas (scale=$SCALE)...\n"
docker compose exec app uv run python -m src.main --scale "$SCALE"
echo -e "\n🐍🎲 ✅ Dados inseridos no Banco!\n"

bash ./scripts/linux/test-banco.sh

echo -e "\n🏦🎲 ✅ Banco de Dados pronto!\n"