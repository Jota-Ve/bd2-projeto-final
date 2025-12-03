#!/bin/bash
set -e

echo "🔍 Verificando Colunas Virtuais..."

# Função para rodar SQL
run_sql() {
    docker exec bd2_postgres psql -U postgres -d streamers -c "$1"
}

echo -e "\n🎥 1. Verificando duracao_mins na tabela VIDEO:"
echo "Esperado: duracao_mins = duracao_segs / 60.0"
run_sql "
SELECT 
    titulo, 
    duracao_segs, 
    duracao_mins 
FROM video 
LIMIT 5;
"

echo -e "\n👤 2. Verificando ano_nasc na tabela USUARIO:"
echo "Esperado: ano_nasc = Ano de data_nasc"
run_sql "
SELECT 
    nick, 
    data_nasc, 
    ano_nasc 
FROM usuario 
LIMIT 5;
"

echo -e "\n✅ Teste de Colunas Virtuais concluído!"
