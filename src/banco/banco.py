"""Módulo com funções para manipulação do banco de dados PostgreSQL."""

import logging
from collections.abc import Sequence

import psycopg
from psycopg import sql

from ..fake.dado_fake import DadoFake
from . import T_tabela_dados


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

    logging.debug(f'query de inserção montada para a tabela {tabela}: {query.as_string(conexao)}')
    with conexao.cursor() as cursor:
        num_tuplas = f'{len(dados)}'.rjust(7)
        logging.info(f'Inserindo {num_tuplas} tuplas na tabela {tabela}...')
        cursor.executemany(query, (d.tupla for d in dados))

    if commit:
        conexao.commit()


def insere_varios_no_banco(str_conexao: str, tabelas_e_dados: T_tabela_dados) -> None:
    with psycopg.connect(str_conexao) as conexao:
        for tabela in tabelas_e_dados:
            limpa_tabela(conexao, tabela, commit=False)
            
        print('')
        logging.info(f'{len(tabelas_e_dados)} tabelas TRUNCADAS.')
        print('')

        for tabela, dados in tabelas_e_dados.items():
            insere_no_banco(conexao, tabela, dados=dados, commit=False)

        conexao.commit()


def limpa_tabela(conexao: psycopg.Connection, tabela: str, *, commit: bool = True) -> None:
    SQL = sql.SQL("""--sql
        TRUNCATE TABLE {tabela}
        CASCADE;
    """).format(tabela=sql.Identifier(tabela))

    with conexao.cursor() as cursor:
        cursor.execute(SQL)
        logging.debug(f'Tabela {tabela.center(18, '_')} TRUNCADA')

    if commit:
        conexao.commit()
