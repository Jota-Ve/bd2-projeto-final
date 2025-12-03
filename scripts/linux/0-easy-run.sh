#!/bin/bash
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

echo -e "\n🔄 resetando ambiente..."

bash ./scripts/linux/4-clean-containers.sh

bash ./scripts/linux/1-run-containers.sh
# Repassa todos os argumentos recebidos (ex: --scale 0.1) para 2-load-data.sh
bash ./scripts/linux/2-load-data.sh "$@"

echo -e "\n🔄 ✅ Ambiente resetado com sucesso!"