#!/bin/bash
set -e

echo "🔍 Verificando Particionamento (Sharding)..."

# Função para rodar SQL
run_sql() {
    docker exec bd2_postgres psql -U postgres -d streamers -c "$1"
}

echo -e "\n📊 1. Verificando existência das tabelas particionadas:"
run_sql "
SELECT
    parent.relname AS tabela_pai,
    child.relname AS particao,
    pg_get_expr(child.relpartbound, child.oid) AS regra_particao
FROM pg_inherits
JOIN pg_class parent ON pg_inherits.inhparent = parent.oid
JOIN pg_class child ON pg_inherits.inhrelid = child.oid
WHERE parent.relname IN ('inscricao', 'doacao')
ORDER BY parent.relname, child.relname;
"

echo -e "\n📈 2. Contagem de registros por partição (Distribuição de Dados):"
echo "--- INSCRIÇÃO ---"
run_sql "SELECT 'inscricao_p0' as particao, COUNT(*) FROM inscricao_p0 UNION ALL
         SELECT 'inscricao_p1' as particao, COUNT(*) FROM inscricao_p1 UNION ALL
         SELECT 'inscricao_p2' as particao, COUNT(*) FROM inscricao_p2 UNION ALL
         SELECT 'inscricao_p3' as particao, COUNT(*) FROM inscricao_p3;"

echo -e "\n--- DOAÇÃO ---"
run_sql "SELECT 'doacao_p0' as particao, COUNT(*) FROM doacao_p0 UNION ALL
         SELECT 'doacao_p1' as particao, COUNT(*) FROM doacao_p1 UNION ALL
         SELECT 'doacao_p2' as particao, COUNT(*) FROM doacao_p2 UNION ALL
         SELECT 'doacao_p3' as particao, COUNT(*) FROM doacao_p3;"

echo -e "\n✅ Teste de Sharding concluído!"
