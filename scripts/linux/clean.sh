#!/bin/bash
# Faz o script parar em qualquer erro, variável indefinida ou falha em pipeline
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

echo -e "\n🧹 Limpando containers, imagens, volumes e redes do projeto...\n"
docker compose down --rmi all -v --remove-orphans
echo -e "\n🧹 ✅ Ambiente limpo. Pronto para rodar novamente do zero!\n"