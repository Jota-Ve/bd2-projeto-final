
import argparse
import enum
import os
import pathlib
import random

import dotenv
from faker import Faker

from . import logger_setup 
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
QTD_MAXIMA_PADRAO = 200_000

def cria_qtd(escala: float, maxima: int=QTD_MAXIMA_PADRAO):
    maxima_escalonda = int(maxima * escala)

    class QTD(enum.IntEnum):
        """Quantidade de dados/tuplas que deve gerar pra cada classe/tabela."""
        _MAXIMA              = maxima_escalonda
        EMPRESA                   = int(_MAXIMA * 0.02)
        PLATAFORMA                = 100
        CONVERSAO                 = 160
        PAIS                      = 130
        EMPRESA_PAIS         = min(EMPRESA     * 4,             _MAXIMA)
        USUARIO              = min(int(_MAXIMA  * 0.23),        _MAXIMA)
        PLATAFORMA_USUARIO   = min(int(USUARIO * 2.25),         _MAXIMA)
        STREAMER_PAIS        = min(int(USUARIO * 0.082),        _MAXIMA)
        CANAL                = min(int(STREAMER_PAIS * 1.27),   _MAXIMA)
        PATROCINIO           = min(int(CANAL         * 0.63),   _MAXIMA)
        NIVEL_CANAL          = min(CANAL       * 5,             _MAXIMA)
        INSCRICAO            = min(int(CANAL   * 4.75),         _MAXIMA)
        VIDEO                = min(CANAL       * 32,            _MAXIMA)
        PARTICIPA            = min(int(VIDEO   * 0.09),         _MAXIMA)
        COMENTARIO           = min(VIDEO       * 17,            _MAXIMA)
        DOACAO               = min(int(COMENTARIO  * 0.17),     _MAXIMA)
        BITCOIN              = min(int(DOACAO      * 0.57 / 4), _MAXIMA)
        PAYPAL               = min(int(DOACAO      * 1.13 / 4), _MAXIMA)
        CARTAO_CREDITO       = min(int(DOACAO      * 1.97 / 4), _MAXIMA)
        MECANISMO_PLAT       = min(int(DOACAO      * 3.05 / 4), _MAXIMA)

    return QTD


def main(faker: Faker, str_conexao: str|None='', escala: float=1.0) -> None:
    """Gera e salva os dados de cada tabela."""

    qtd = cria_qtd(escala=escala)
    tabelas_e_dados: T_tabela_dados = {
        'empresa':            (empresas      := EmpresaFake.gera(          qtd.EMPRESA,            faker)),
        'plataforma':         (plataformas   := PlataformaFake.gera(       qtd.PLATAFORMA,         faker, *empresas)),
        'conversao':          (conversoes    := ConversaoFake.gera(        qtd.CONVERSAO,          faker)),
        'pais':               (paises        := PaisFake.gera(             qtd.PAIS,               faker, *conversoes)),
        'empresa_pais':       (_             := EmpresaPaisFake.gera(      qtd.EMPRESA_PAIS,       faker, empresas=empresas, paises=paises)),
        'usuario':            (usuarios      := UsuarioFake.gera(          qtd.USUARIO,            faker, *paises)),
        'plataforma_usuario': (_             := PlataformaUsuarioFake.gera(qtd.PLATAFORMA_USUARIO, faker, plataformas=plataformas, usuarios=usuarios)),
        'streamer_pais':      (_             := StreamerPaisFake.gera(     qtd.STREAMER_PAIS,      faker, streamers=usuarios, paises=paises)),
        'canal':              (canais        := CanalFake.gera(            qtd.CANAL,              faker, plataformas=plataformas, streamers=usuarios)),
        'patrocinio':         (_             := PatrocinioFake.gera(       qtd.PATROCINIO,         faker, empresas=empresas, canais=canais)),
        'nivel_canal':        (niveis_canais := NivelCanal.gera(           qtd.NIVEL_CANAL,        faker, canais=canais)),
        'inscricao':          (_             := InscricaoFake.gera(        qtd.INSCRICAO,          faker, niveis_canais=niveis_canais, membros=usuarios)),
        'video':              (videos        := VideoFake.gera(            qtd.VIDEO,              faker, canais=canais)),
        'participa':          (_             := ParticipaFake.gera(        qtd.PARTICIPA,          faker, videos=videos, streamers=usuarios)),
        'comentario':         (comentarios   := ComentarioFake.gera(       qtd.COMENTARIO,         faker, videos=videos, usuarios=usuarios)),
        'doacao':             (doacoes       := DoacaoFake.gera(           qtd.DOACAO,             faker, comentarios=comentarios)),
        'bitcoin':            (_             := BitcoinFake.gera(          qtd.BITCOIN,            faker, doacoes=random.sample(doacoes, k=qtd.BITCOIN))),
        'paypal':             (_             := PaypalFake.gera(           qtd.PAYPAL,             faker, doacoes=random.sample(doacoes, k=qtd.PAYPAL))),
        'cartao_credito':     (_             := CartaoCreditoFake.gera(    qtd.CARTAO_CREDITO,     faker, doacoes=random.sample(doacoes, k=qtd.CARTAO_CREDITO))),
        'mecanismo_plat':     (_             := MecanismoPlatFake.gera(    qtd.MECANISMO_PLAT,     faker, doacoes=random.sample(doacoes, k=qtd.MECANISMO_PLAT))),
    }

    if str_conexao:
        banco.insere_varios_no_banco(str_conexao, tabelas_e_dados)
    else:
        csv_utils.salva_csv(tabelas_e_dados)


def cli():
    parser = argparse.ArgumentParser()
    parser.add_argument("-s", "--scale", type=float, default=1.0, help="Fator de escala para multiplicar QTD")
    args = parser.parse_args()

    return args


if __name__ == '__main__':
    # >>> python -m uv run -- python -m src.main
    dotenv.load_dotenv()
    logger_setup.setup_logging()

    args = cli()
    main(faker=Faker(['pt_BR', 'en_US', 'es_MX']), str_conexao=os.getenv('PG_CONX'), escala=args.scale)
