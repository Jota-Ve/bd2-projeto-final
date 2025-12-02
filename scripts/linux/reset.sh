#!/bin/bash
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

echo -e "\n🔄 Resetando ambiente..."

bash ./scripts/linux/clean.sh

bash ./scripts/linux/run.sh
# Repassa todos os argumentos recebidos (ex: --scale 0.05) para load-data.sh
bash ./scripts/linux/load-data.sh "$@"

echo -e "\n🔄 ✅ Ambiente resetado com sucesso!"