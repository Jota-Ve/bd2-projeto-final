#!/bin/bash
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

echo "🔄 Resetando ambiente..."

bash ./scripts/clean.sh
bash ./scripts/build.sh

# repassa todos os argumentos recebidos (ex: --scale 0.05) para run.sh
bash ./scripts/run.sh "$@"

echo "✅ Ambiente resetado com sucesso!"