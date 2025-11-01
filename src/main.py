
import enum
import logging
import os
import pathlib
from collections.abc import Sequence

import dotenv
import psycopg
from faker import Faker

from src import banco

from .canal_fake import CanalFake, DadoFake
from .conversao_fake import ConversaoFake
from .empresa_fake import EmpresaFake
from .empresa_pais_fake import EmpresaPaisFake
from .pais_fake import PaisFake
from .patrocinio_fake import PatrocinioFake
from .plataforma_fake import PlataformaFake
from .plataforma_usuario_fake import PlataformaUsuarioFake
from .streamer_pais_fake import StreamerPaisFake
from .usuario_fake import UsuarioFake

type T_StrOrPath = str | pathlib.Path


class QTD(enum.IntEnum):
    """Quantidade de dados/tuplas que deve gerar pra cada classe/tabela."""

    EMPRESA             = 1_000
    PLATAFORMA          = 1_000
    CONVERSAO           = 160
    PAIS                = 130
    EMPRESA_X_PAIS = min(EMPRESA * PAIS, 1_000)
    USUARIO             = 1_000
    PLATAFORMA_X_USUARIO = min(PLATAFORMA * USUARIO, 1_000)
    STREAMER_X_PAIS = min(USUARIO * PAIS, 1_000)
    CANAL           = min(PLATAFORMA * STREAMER_X_PAIS, 1_000)
    PATROCINIO      = min(EMPRESA * CANAL, 1_000)



class Caminho(enum.StrEnum):
    """Caminho onde os dados/tuplas de cada classe/tabela serão salvos."""

    EMPRESA        = 'dados/empresa.csv'
    PLATAFORMA     = 'dados/plataforma.csv'
    CONVERSAO      = 'dados/conversao.csv'
    PAIS           = 'dados/pais.csv'
    EMPRESA_X_PAIS = 'dados/empresa_pais.csv'
    USUARIO        = 'dados/usuario.csv'
    PLATAFORMA_X_USUARIO = 'dados/plataforma_usuario.csv'
    STREAMER_X_PAIS = 'dados/streamer_pais.csv'
    CANAL           = 'dados/canal.csv'
    PATROCINIO      = 'dados/patrocinio.csv'


def salva_csv(empresas: Sequence[EmpresaFake], plataformas: Sequence[PlataformaFake], conversoes: Sequence[ConversaoFake], paises: Sequence[PaisFake], empresas_x_paises: Sequence[EmpresaPaisFake], usuarios: Sequence[UsuarioFake],
              plataformas_x_usuarios: Sequence[PlataformaUsuarioFake], streamers_x_paises: Sequence[StreamerPaisFake], canais: Sequence[CanalFake], patrocinios: Sequence[PatrocinioFake]):

    DadoFake.salva_csv(Caminho.EMPRESA, empresas)
    DadoFake.salva_csv(Caminho.PLATAFORMA, plataformas)
    DadoFake.salva_csv(Caminho.CONVERSAO, conversoes)
    DadoFake.salva_csv(Caminho.PAIS, paises)
    DadoFake.salva_csv(Caminho.EMPRESA_X_PAIS, empresas_x_paises)
    DadoFake.salva_csv(Caminho.USUARIO, usuarios)
    DadoFake.salva_csv(Caminho.PLATAFORMA_X_USUARIO, plataformas_x_usuarios)
    DadoFake.salva_csv(Caminho.STREAMER_X_PAIS, streamers_x_paises)
    DadoFake.salva_csv(Caminho.CANAL, canais)
    DadoFake.salva_csv(Caminho.PATROCINIO, patrocinios)


def main(faker: Faker, str_conexao: str|None='') -> None:
    """Gera e salva os dados de cada tabela."""
    empresas = EmpresaFake.gera(QTD.EMPRESA, faker=faker)

    plataformas = PlataformaFake.gera(QTD.PLATAFORMA, faker, *empresas)

    conversoes = ConversaoFake.gera(QTD.CONVERSAO, faker=faker)

    paises = PaisFake.gera(QTD.PAIS, faker, *conversoes)

    empresas_x_paises = EmpresaPaisFake.gera(QTD.EMPRESA_X_PAIS, faker, empresas=empresas, paises=paises)

    usuarios = UsuarioFake.gera(QTD.USUARIO, faker, *paises)

    plataformas_x_usuarios = PlataformaUsuarioFake.gera(QTD.PLATAFORMA_X_USUARIO, faker, plataformas=plataformas, usuarios=usuarios)

    streamers_x_paises = StreamerPaisFake.gera(QTD.STREAMER_X_PAIS, faker, streamers=usuarios, paises=paises)

    canais = CanalFake.gera(QTD.CANAL, faker, plataformas=plataformas, streamers=usuarios)

    patrocinios = PatrocinioFake.gera(QTD.PATROCINIO, faker, empresas=empresas, canais=canais)

    if str_conexao:
        with psycopg.connect(str_conexao) as conexao:
            banco.limpa_tabela(conexao, 'empresa')
            banco.limpa_tabela(conexao, 'plataforma')
            banco.limpa_tabela(conexao, 'conversao')

            banco.insere_no_banco(conexao, 'empresa', empresas, commit=False)
            banco.insere_no_banco(conexao, 'plataforma', plataformas, commit=False)
            banco.insere_no_banco(conexao, 'conversao', conversoes, commit=True)

    else:
        salva_csv(empresas, plataformas, conversoes, paises, empresas_x_paises, usuarios, plataformas_x_usuarios, streamers_x_paises, canais, patrocinios)


if __name__ == '__main__':
    # >>> python -m uv run -- python -m src.main
    dotenv.load_dotenv()
    logging.basicConfig(level=logging.INFO, format='[%(asctime)s]:%(levelname)s:%(module)s:%(funcName)s(): -> %(message)s')

    main(faker=Faker(['pt_BR', 'en_US']), str_conexao=os.getenv('PG_CONX'))
