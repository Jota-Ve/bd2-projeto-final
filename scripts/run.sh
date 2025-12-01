#!/bin/bash
# Faz o script parar em qualquer erro, variável indefinida ou falha em pipeline
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

echo "🚀 Subindo containers..."
docker compose up -d

echo "⏳ Aguardando inicialização do Postgres..."
# Aguarda até o Postgres responder
until docker exec bd2_postgres pg_isready -U postgres -d streamers > /dev/null 2>&1; do
  sleep 1
done

echo "📜 Aplicando DDL no banco..."
docker exec -i bd2_postgres psql -U postgres -d streamers < sql/DDL-streamers.sql

echo "✅ Ambiente pronto!"

echo "🐍 Populando tabelas..."
docker compose exec app uv run python -m src.main

echo "⚙️ Criando funções para responder queries..."
docker exec -i bd2_postgres psql -U postgres -d streamers < sql/queries_otimizadas.sql

echo "🧪 Rodando testes..."
bash ./scripts/test-banco.sh

echo "✅ Queries prontas!"