#!/bin/bash
# Faz o script parar em qualquer erro, variável indefinida ou falha em pipeline
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

# Garante que o script execute a partir da raiz do projeto
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

echo "🔨 Construindo imagens..."
docker compose build
echo "✅ Build concluído."