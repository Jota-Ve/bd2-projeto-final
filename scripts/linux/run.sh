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

echo "✅ Ambiente pronto para receber dados!"
