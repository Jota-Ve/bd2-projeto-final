
import enum
import logging
import os
import pathlib
from collections.abc import Sequence

import dotenv
import psycopg
from faker import Faker

from src.fake.inscricao_fake import InscricaoFake

from .banco import banco
from .fake.canal_fake import CanalFake
from .fake.conversao_fake import ConversaoFake
from .fake.dado_fake import DadoFake
from .fake.empresa_fake import EmpresaFake
from .fake.empresa_pais_fake import EmpresaPaisFake
from .fake.nivel_canal import NivelCanal
from .fake.pais_fake import PaisFake
from .fake.patrocinio_fake import PatrocinioFake
from .fake.plataforma_fake import PlataformaFake
from .fake.plataforma_usuario_fake import PlataformaUsuarioFake
from .fake.streamer_pais_fake import StreamerPaisFake
from .fake.usuario_fake import UsuarioFake

T_StrOrPath = str | pathlib.Path


class QTD(enum.IntEnum):
    """Quantidade de dados/tuplas que deve gerar pra cada classe/tabela."""

    EMPRESA                 = 5_000
    PLATAFORMA              = 5_000
    CONVERSAO               = 160
    PAIS                    = 130
    EMPRESA_PAIS       = min(EMPRESA    * PAIS,          5_000)
    USUARIO                 = 5_000
    PLATAFORMA_USUARIO = min(PLATAFORMA * USUARIO,       5_000)
    STREAMER_PAIS      = min(USUARIO    * PAIS,          5_000)
    CANAL              = min(PLATAFORMA * STREAMER_PAIS, 5_000)
    PATROCINIO         = min(EMPRESA    * CANAL,         5_000)
    NIVEL_CANAL        = min(CANAL      * 5,             5_000)
    INSCRICAO          = min(CANAL      * USUARIO,       5_000)



class Caminho(enum.StrEnum):
    """Caminho onde os dados/tuplas de cada classe/tabela serão salvos."""

    EMPRESA        = 'dados/empresa.csv'
    PLATAFORMA     = 'dados/plataforma.csv'
    CONVERSAO      = 'dados/conversao.csv'
    PAIS           = 'dados/pais.csv'
    EMPRESA_PAIS   = 'dados/empresa_pais.csv'
    USUARIO        = 'dados/usuario.csv'
    PLATAFORMA_USUARIO = 'dados/plataforma_usuario.csv'
    STREAMER_PAIS   = 'dados/streamer_pais.csv'
    CANAL           = 'dados/canal.csv'
    PATROCINIO      = 'dados/patrocinio.csv'
    NIVEL_CANAL     = 'dados/nivel_canal.csv'
    INSCRICAO       = 'dados/inscricao.csv'


T_tabela_dados = dict[str, Sequence[DadoFake]]

def salva_csv(tabelas_e_dados: T_tabela_dados) -> None:
    for tabela, dados in tabelas_e_dados.items():
        caminho = Caminho[tabela.upper()]
        DadoFake.salva_csv(caminho, dados)


def insere_no_banco(str_conexao: str, tabelas_e_dados: T_tabela_dados) -> None:
    with psycopg.connect(str_conexao) as conexao:
        for tabela in tabelas_e_dados:
            banco.limpa_tabela(conexao, tabela, commit=False)

        for tabela, dados in tabelas_e_dados.items():
            banco.insere_no_banco(conexao, tabela, dados=dados, commit=False)

        conexao.commit()


def main(faker: Faker, str_conexao: str|None='') -> None:
    """Gera e salva os dados de cada tabela."""
    tabelas_e_dados: T_tabela_dados = {
        'empresa':            (empresas      := EmpresaFake.gera(          QTD.EMPRESA,            faker)),
        'plataforma':         (plataformas   := PlataformaFake.gera(       QTD.PLATAFORMA,         faker, *empresas)),
        'conversao':          (conversoes    := ConversaoFake.gera(        QTD.CONVERSAO,          faker)),
        'pais':               (paises        := PaisFake.gera(             QTD.PAIS,               faker, *conversoes)),
        'empresa_pais':       (_             := EmpresaPaisFake.gera(      QTD.EMPRESA_PAIS,       faker, empresas=empresas, paises=paises)),
        'usuario':            (usuarios      := UsuarioFake.gera(          QTD.USUARIO,            faker, *paises)),
        'plataforma_usuario': (_             := PlataformaUsuarioFake.gera(QTD.PLATAFORMA_USUARIO, faker, plataformas=plataformas, usuarios=usuarios)),
        'streamer_pais':      (_             := StreamerPaisFake.gera(     QTD.STREAMER_PAIS,      faker, streamers=usuarios, paises=paises)),
        'canal':              (canais        := CanalFake.gera(            QTD.CANAL,              faker, plataformas=plataformas, streamers=usuarios)),
        'patrocinio':         (_             := PatrocinioFake.gera(       QTD.PATROCINIO,         faker, empresas=empresas, canais=canais)),
        'nivel_canal':        (niveis_canais := NivelCanal.gera(           QTD.NIVEL_CANAL,        faker, canais=canais)),
        'inscricao':          (_             := InscricaoFake.gera(        QTD.INSCRICAO,          faker, niveis_canais=niveis_canais, membros=usuarios)),
    }

    if str_conexao:
        insere_no_banco(str_conexao, tabelas_e_dados)
    else:
        salva_csv(tabelas_e_dados)



if __name__ == '__main__':
    # >>> python -m uv run -- python -m src.main
    dotenv.load_dotenv()
    logging.basicConfig(level=logging.INFO, format='[%(asctime)s]:%(levelname)s:%(module)s:%(funcName)s(): -> %(message)s')

    main(faker=Faker(['pt_BR', 'en_US', 'es_MX']), str_conexao=os.getenv('PG_CONX'))
