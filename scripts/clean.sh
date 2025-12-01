#!/bin/bash
echo "🧹 Limpando containers, imagens, volumes e redes do projeto..."
docker compose down --rmi all -v --remove-orphans
echo "✅ Ambiente limpo. Pronto para rodar novamente do zero!"