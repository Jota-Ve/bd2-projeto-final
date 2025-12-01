#!/bin/bash
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

echo "🔄 Resetando ambiente..."

bash ./scripts/linux/clean.sh
bash ./scripts/linux/build.sh

# repassa todos os argumentos recebidos (ex: --scale 0.05) para run.sh
bash ./scripts/linux/run.sh "$@"

echo "✅ Ambiente resetado com sucesso!"