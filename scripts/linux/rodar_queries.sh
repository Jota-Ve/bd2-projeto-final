#!/bin/bash
set -euo pipefail
trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

# Garante que o script execute a partir da raiz do projeto
cd "$(dirname "${BASH_SOURCE[0]}")/../.."
docker exec -i bd2_postgres psql -U postgres -d streamers < sql/execute_queries.sql