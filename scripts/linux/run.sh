#!/bin/bash
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

# Garante que o script execute a partir da raiz do projeto
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

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
docker exec -i bd2_postgres psql -v ON_ERROR_STOP=1 -U postgres -d streamers < sql/DDL-streamers.sql
echo "✅ Ambiente pronto!"

echo "🐍 Populando tabelas (scale=$SCALE)..."
docker compose exec app uv run python -m src.main --scale "$SCALE"
echo "✅ Banco populado!"

echo "⚙️ Criando funções para responder queries..."
docker exec -i bd2_postgres psql -U postgres -d streamers < sql/queries.sql
# 3. Atualizar Visão Materializada (para populá-la com os dados gerados)
echo "🔄 Refreshing Materialized View..."
docker exec -i bd2_postgres psql -U postgres -d streamers -c "REFRESH MATERIALIZED VIEW public.mv_canal_metricas;"

# 4. Criar funções otimizadas (sobrescrevendo as anteriores, se houver)
echo "⚡ Creating optimized functions..."
docker exec -i bd2_postgres psql -U postgres -d streamers < sql/queries_otimizadas.sql
echo "✅ Funções criadas!"

echo "🧪 Rodando testes..."
bash ./scripts/linux/test-banco.sh
bash ./scripts/linux/test-triggers.sh

echo "Rodando queries..."
bash ./scripts/linux/rodar_queries.sh

echo "✅ Queries prontas!"
