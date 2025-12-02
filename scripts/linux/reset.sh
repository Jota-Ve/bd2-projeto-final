#!/bin/bash
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Resetando ambiente..."

bash "$SCRIPT_DIR/clean.sh"
bash "$SCRIPT_DIR/build.sh"

# repassa todos os argumentos recebidos (ex: --scale 0.05) para run.sh
bash "$SCRIPT_DIR/run.sh" "$@"

echo "✅ Ambiente resetado com sucesso!"