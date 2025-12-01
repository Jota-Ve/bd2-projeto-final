#!/bin/bash
# Faz o script parar em qualquer erro, variável indefinida ou falha em pipeline
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

echo "🔨 Construindo imagens..."
docker compose build
echo "✅ Build concluído."