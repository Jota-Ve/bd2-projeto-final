#!/bin/bash
# Faz o script parar em qualquer erro, variável indefinida ou falha em pipeline
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

echo "🔄 Resetando ambiente..."

bash ./scripts/clean.sh
bash ./scripts/build.sh
bash ./scripts/run.sh

echo "✅ Ambiente resetado com sucesso!"