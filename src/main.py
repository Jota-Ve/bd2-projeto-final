
import enum
import logging
import os
import pathlib

import dotenv
from faker import Faker

from src.fake.inscricao_fake import InscricaoFake

from .banco import T_tabela_dados, banco, csv_utils
from .fake.canal_fake import CanalFake
from .fake.conversao_fake import ConversaoFake
from .fake.empresa_fake import EmpresaFake
from .fake.empresa_pais_fake import EmpresaPaisFake
from .fake.nivel_canal_fake import NivelCanal
from .fake.pais_fake import PaisFake
from .fake.patrocinio_fake import PatrocinioFake
from .fake.plataforma_fake import PlataformaFake
from .fake.plataforma_usuario_fake import PlataformaUsuarioFake
from .fake.streamer_pais_fake import StreamerPaisFake
from .fake.usuario_fake import UsuarioFake
from .fake.video_fake import VideoFake

T_StrOrPath = str | pathlib.Path


class QTD(enum.IntEnum):
    """Quantidade de dados/tuplas que deve gerar pra cada classe/tabela."""

    EMPRESA                 = 1_000
    PLATAFORMA              = 1_000
    CONVERSAO               = 160
    PAIS                    = 130
    EMPRESA_PAIS       = min(EMPRESA    * PAIS,          1_000)
    USUARIO                 = 1_000
    PLATAFORMA_USUARIO = min(PLATAFORMA * USUARIO,       1_000)
    STREAMER_PAIS      = min(USUARIO    * PAIS,          1_000)
    CANAL              = min(PLATAFORMA * STREAMER_PAIS, 1_000)
    PATROCINIO         = min(EMPRESA    * CANAL,         1_000)
    NIVEL_CANAL        = min(CANAL      * 5,             1_000)
    INSCRICAO          = min(CANAL      * USUARIO,       1_000)
    VIDEO              = min(CANAL      * 2,             1_000)

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
        'video':              (_             := VideoFake.gera(            QTD.VIDEO,              faker, canais=canais)),
    }

    if str_conexao:
        banco.insere_varios_no_banco(str_conexao, tabelas_e_dados)

    csv_utils.salva_csv(tabelas_e_dados)



if __name__ == '__main__':
    # >>> python -m uv run -- python -m src.main
    dotenv.load_dotenv()
    logging.basicConfig(level=logging.INFO, format='[%(asctime)s]:%(levelname)s:%(module)s:%(funcName)s(): -> %(message)s')

    main(faker=Faker(['pt_BR', 'en_US', 'es_MX']), str_conexao=os.getenv('PG_CONX'))
