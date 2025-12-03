#!/bin/bash
# # Faz o script parar em qualquer erro, variável indefinida ou falha em pipeline
# set -euo pipefail
# trap 'echo "❌ Erro na linha $LINENO do script $0"; exit 1' ERR

# docker exec -i bd2_postgres psql -U postgres -d streamers -c "SELECT * FROM public.vw_usuario_conversao LIMIT 5;"

echo "\nQuery 1 -> q1_status_patrocinio()\n"
docker exec -i bd2_postgres psql -U postgres -d streamers -c "SELECT * FROM q1_status_patrocinio() LIMIT 5;"

echo -e "\nQuery 2 -> q2_status_inscricao()\n"
docker exec -i bd2_postgres psql -U postgres -d streamers -c "SELECT * FROM q2_status_inscricao() LIMIT 5;"

echo -e "\nQuery 3 -> q3_status_doacao()\n"
docker exec -i bd2_postgres psql -U postgres -d streamers -c "SELECT * FROM q3_status_doacao() LIMIT 5;"

echo -e "\nQuery 4 -> q4_total_doacoes_lidas()\n"
docker exec -i bd2_postgres psql -U postgres -d streamers -c "SELECT * FROM q4_total_doacoes_lidas() LIMIT 5;"

echo -e "\nQuery 5 -> q5_rank_patrocinios()\n"
docker exec -i bd2_postgres psql -U postgres -d streamers -c "SELECT * FROM q5_rank_patrocinios(5);"

echo -e "\nQuery 6 -> q6_rank_inscricoes()\n"
docker exec -i bd2_postgres psql -U postgres -d streamers -c "SELECT * FROM q6_rank_inscricoes(5);"

echo -e "\nQuery 7 -> q7_rank_doacoes()\n"
docker exec -i bd2_postgres psql -U postgres -d streamers -c "SELECT * FROM q7_rank_doacoes(5);"

echo -e "\nQuery 8 -> q8_rank_faturamento()\n"
docker exec -i bd2_postgres psql -U postgres -d streamers -c "SELECT * FROM q8_rank_faturamento(5);"
