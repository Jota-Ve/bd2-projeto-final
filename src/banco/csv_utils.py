"""Módulo com funções para salvar dados em arquivos CSV."""

import enum

from ..fake.dado_fake import DadoFake
from . import T_tabela_dados


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
    VIDEO           = 'dados/video.csv'
    COMENTARIO      = 'dados/comentario.csv'
    DOACAO          = 'dados/doacao.csv'


def salva_csv(tabelas_e_dados: T_tabela_dados) -> None:
    for tabela, dados in tabelas_e_dados.items():
        caminho = Caminho[tabela.upper()]
        DadoFake.salva_csv(caminho, dados)
