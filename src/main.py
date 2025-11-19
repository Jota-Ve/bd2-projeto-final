
import enum
import logging
import os
import pathlib

import dotenv
from faker import Faker

from .banco import T_tabela_dados, banco, csv_utils
from .fake.bitcoin_fake import BitcoinFake
from .fake.canal_fake import CanalFake
from .fake.cartao_credito import CartaoCreditoFake
from .fake.comentario_fake import ComentarioFake
from .fake.conversao_fake import ConversaoFake
from .fake.doacao_fake import DoacaoFake
from .fake.empresa_fake import EmpresaFake
from .fake.empresa_pais_fake import EmpresaPaisFake
from .fake.inscricao_fake import InscricaoFake
from .fake.mecanismo_plat_fake import MecanismoPlatFake
from .fake.nivel_canal_fake import NivelCanal
from .fake.pais_fake import PaisFake
from .fake.participa_fake import ParticipaFake
from .fake.patrocinio_fake import PatrocinioFake
from .fake.paypal_fake import PaypalFake
from .fake.plataforma_fake import PlataformaFake
from .fake.plataforma_usuario_fake import PlataformaUsuarioFake
from .fake.streamer_pais_fake import StreamerPaisFake
from .fake.usuario_fake import UsuarioFake
from .fake.video_fake import VideoFake

T_StrOrPath = str | pathlib.Path


class QTD(enum.IntEnum):
    """Quantidade de dados/tuplas que deve gerar pra cada classe/tabela."""
    MAXIMA                    = 200_000
    EMPRESA                   = int(MAXIMA * 0.02)
    PLATAFORMA                = 100
    CONVERSAO                 = 160
    PAIS                      = 130
    EMPRESA_PAIS         = min(EMPRESA     * 3,            MAXIMA)
    USUARIO              = min(int(MAXIMA  * 0.10),        MAXIMA)
    PLATAFORMA_USUARIO   = min(int(USUARIO * 2.25),        MAXIMA)
    STREAMER_PAIS        = min(int(USUARIO * 0.085),       MAXIMA)
    CANAL                = min(int(STREAMER_PAIS * 1.40),  MAXIMA)
    PATROCINIO           = min(int(CANAL         * 0.40),  MAXIMA)
    NIVEL_CANAL          = min(CANAL       * 5,            MAXIMA)
    INSCRICAO            = min(int(CANAL   * 1.75)   ,     MAXIMA)
    VIDEO                = min(CANAL       * 63,           MAXIMA)
    PARTICIPA            = min(VIDEO       // 200,         MAXIMA)
    COMENTARIO           = min(VIDEO       * 15,           MAXIMA)
    DOACAO               = min(COMENTARIO  //12,           MAXIMA)
    BITCOIN              = min(DOACAO      // 4,           MAXIMA)
    PAYPAL               = min(DOACAO      // 4,           MAXIMA)
    CARTAO_CREDITO       = min(DOACAO      // 4,           MAXIMA)
    MECANISMO_PLAT       = min(DOACAO      // 4,           MAXIMA)


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
        'video':              (videos        := VideoFake.gera(            QTD.VIDEO,              faker, canais=canais)),
        'participa':          (_             := ParticipaFake.gera(        QTD.PARTICIPA,          faker, videos=videos, streamers=usuarios)),
        'comentario':         (comentarios   := ComentarioFake.gera(       QTD.COMENTARIO,         faker, videos=videos, usuarios=usuarios)),
        'doacao':             (doacoes       := DoacaoFake.gera(           QTD.DOACAO,             faker, comentarios=comentarios)),
        'bitcoin':            (_             := BitcoinFake.gera(          QTD.BITCOIN,            faker, doacoes=doacoes[0:len(doacoes)//4])),
        'paypal':             (_             := PaypalFake.gera(           QTD.PAYPAL,             faker, doacoes=doacoes[len(doacoes)//4:len(doacoes)//2])),
        'cartao_credito':     (_             := CartaoCreditoFake.gera(    QTD.CARTAO_CREDITO,     faker, doacoes=doacoes[len(doacoes)//2:len(doacoes)*3//4])),
        'mecanismo_plat':     (_             := MecanismoPlatFake.gera(    QTD.MECANISMO_PLAT,     faker, doacoes=doacoes[len(doacoes)*3//4:])),
    }

    if str_conexao:
        banco.insere_varios_no_banco(str_conexao, tabelas_e_dados)

    csv_utils.salva_csv(tabelas_e_dados)



if __name__ == '__main__':
    # >>> python -m uv run -- python -m src.main
    dotenv.load_dotenv()
    logging.basicConfig(level=logging.INFO, format='[%(asctime)s]:%(name)s:%(levelname)s:%(module)s:%(funcName)s(): -> %(message)s')
    logging.getLogger('faker.factory').setLevel(logging.INFO)

    main(faker=Faker(['pt_BR', 'en_US', 'es_MX']), str_conexao=os.getenv('PG_CONX'))
