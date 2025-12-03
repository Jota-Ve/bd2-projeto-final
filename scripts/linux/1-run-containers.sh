#!/bin/bash
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

echo -e "\n🚀 Subindo containers...\n"
docker compose up -d
echo -e "\n🚀 ✅ Containers prontos!\n"