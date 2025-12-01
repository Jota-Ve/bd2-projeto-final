#!/bin/bash
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

# valor padrão
SCALE="1.0"

# se foi passado --scale X, usa X
if [[ "${1:-}" == "--scale" ]]; then
  SCALE="${2:-1.0}"
fi

echo "🚀 Subindo containers..."
docker compose up -d

echo "⏳ Aguardando inicialização do Postgres..."
until docker exec bd2_postgres pg_isready -U postgres -d streamers > /dev/null 2>&1; do
  sleep 1
done

echo "📜 Aplicando DDL no banco..."
docker exec -i bd2_postgres psql -U postgres -d streamers < sql/DDL-streamers.sql

echo "✅ Ambiente pronto!"

echo "🐍 Populando tabelas (scale=$SCALE)..."
docker compose exec app uv run python -m src.main --scale "$SCALE"

echo "⚙️ Criando funções para responder queries..."
docker exec -i bd2_postgres psql -U postgres -d streamers < sql/queries_otimizadas.sql

echo "🧪 Rodando testes..."
bash ./scripts/test-banco.sh

echo "✅ Queries prontas!"