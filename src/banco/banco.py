

import logging
from collections.abc import Sequence

import psycopg
from psycopg import sql

from ..fake.dado_fake import DadoFake


def insere_no_banco(conexao: psycopg.Connection, tabela: str, dados: Sequence[DadoFake], *, commit: bool = True) -> None:
    # Monta os identificadores de tabela e colunas
    tabela_sql = sql.Identifier(tabela)
    colunas_sql = [sql.Identifier(col) for col in dados[0].CABECALHO]
    valores_sql = sql.SQL(', ').join(sql.Placeholder() for _ in colunas_sql)

    query = sql.SQL("""--sql
        INSERT INTO {tabela} ({colunas})
        VALUES ({valores});
    """).format(
        tabela=tabela_sql,
        colunas=sql.SQL(', ').join(colunas_sql),
        valores=valores_sql
    )

    with conexao.cursor() as cursor:
        cursor.executemany(query, (d.tupla for d in dados))
        linhas_inseridas = f'{cursor.rowcount:_}'.rjust(5)
        logging.info(f'{linhas_inseridas} linhas inseridas na tabela {tabela.center(18, '_')}')

    if commit:
        conexao.commit()



def limpa_tabela(conexao: psycopg.Connection, tabela: str, *, commit: bool = True) -> None:
    SQL = sql.SQL("""--sql
        TRUNCATE TABLE {tabela}
        CASCADE;
    """).format(tabela=sql.Identifier(tabela))

    with conexao.cursor() as cursor:
        cursor.execute(SQL)
        logging.info(f'Tabela {tabela.center(18, '_')} TRUNCADA')

    if commit:
        conexao.commit()