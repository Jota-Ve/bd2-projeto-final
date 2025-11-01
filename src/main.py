
import enum
import logging
import pathlib

from faker import Faker

from src import canal_fake, patrocinio_fake

from . import (conversao_fake, dado_fake, empresa_fake, empresa_pais_fake,
               pais_fake, plataforma_fake, plataforma_usuario_fake,
               streamer_pais_fake, usuario_fake)

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



def main(faker: Faker) -> None:
    """Gera e salva os dados de cada tabela."""
    empresas = empresa_fake.EmpresaFake.gera(QTD.EMPRESA, faker=faker)
    dado_fake.DadoFake.salva_csv(Caminho.EMPRESA, empresas)

    plataformas = plataforma_fake.PlataformaFake.gera(QTD.PLATAFORMA, faker, *empresas)
    dado_fake.DadoFake.salva_csv(Caminho.PLATAFORMA, plataformas)

    conversoes = conversao_fake.ConversaoFake.gera(QTD.CONVERSAO, faker=faker)
    dado_fake.DadoFake.salva_csv(Caminho.CONVERSAO, conversoes)

    paises = pais_fake.PaisFake.gera(QTD.PAIS, faker, *conversoes)
    dado_fake.DadoFake.salva_csv(Caminho.PAIS, paises)

    empresas_x_paises = empresa_pais_fake.EmpresaPaisFake.gera(QTD.EMPRESA_X_PAIS, faker, empresas=empresas, paises=paises)
    dado_fake.DadoFake.salva_csv(Caminho.EMPRESA_X_PAIS, empresas_x_paises)

    usuarios = usuario_fake.UsuarioFake.gera(QTD.USUARIO, faker, *paises)
    dado_fake.DadoFake.salva_csv(Caminho.USUARIO, usuarios)

    plataformas_x_usuarios = plataforma_usuario_fake.PlataformaUsuarioFake.gera(QTD.PLATAFORMA_X_USUARIO, faker,
                                                                  plataformas=plataformas, usuarios=usuarios)
    dado_fake.DadoFake.salva_csv(Caminho.PLATAFORMA_X_USUARIO, plataformas_x_usuarios)

    streamers_x_paises = streamer_pais_fake.StreamerPaisFake.gera(QTD.STREAMER_X_PAIS, faker,
                                                                  streamers=usuarios, paises=paises)
    dado_fake.DadoFake.salva_csv(Caminho.STREAMER_X_PAIS, streamers_x_paises)

    canais = canal_fake.CanalFake.gera(QTD.CANAL, faker, plataformas=plataformas, streamers=usuarios)
    dado_fake.DadoFake.salva_csv(Caminho.CANAL, canais)

    patrocinios = patrocinio_fake.PatrocinioFake.gera(QTD.PATROCINIO, faker, empresas=empresas, canais=canais)
    dado_fake.DadoFake.salva_csv(Caminho.PATROCINIO, patrocinios)


if __name__ == '__main__':
    # >>> python -m uv run -- python -m src.main

    logging.basicConfig(level=logging.INFO, format='[%(asctime)s]:%(levelname)s:%(module)s:%(funcName)s(): -> %(message)s')

    # Inicializa os geradores de dados em português e inglês
    main(faker=Faker(['pt_BR', 'en_US']))
