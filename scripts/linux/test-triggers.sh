#!/bin/bash
set -e
cd "$(dirname "${BASH_SOURCE[0]}")/../.."
echo "🧪 Testando Triggers..."
docker exec -i bd2_postgres psql -U postgres -d streamers < sql/test-triggers.sql
echo "✅ Teste de Triggers concluído!"
