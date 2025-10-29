
import pathlib

from faker import Faker

from src import conversao_fake, pais_fake

from . import dado_fake, empresa_fake, plataforma_fake

type T_StrOrPath = str | pathlib.Path

# Inicializa os geradores de dados em português e inglês
faker = Faker(['pt_BR', 'en_US'])



def main(faker: Faker = faker) -> None:
    # Define o número de registros que deseja gerar
    QTD_EMPRESA    = 1000
    QTD_PLATAFORMA = 1000
    QTD_CONVERSAO  = 160
    QTD_PAIS       = 130

    CAMINHO_EMPRESAS    = 'dados/empresas.csv'
    CAMINHO_PLATAFORMAS = 'dados/plataformas.csv'
    CAMINHO_CONVERSOES  = 'dados/conversoes.csv'
    CAMINHO_PAISES      = 'dados/paises.csv'

    empresas = empresa_fake.EmpresaFake.gera(QTD_EMPRESA, faker=faker)
    dado_fake.DadoFake.salva_csv(CAMINHO_EMPRESAS, empresas)

    plataformas = plataforma_fake.PlataformaFake.gera(QTD_PLATAFORMA, faker, *empresas)
    dado_fake.DadoFake.salva_csv(CAMINHO_PLATAFORMAS, plataformas)

    conversoes = conversao_fake.ConversaoFake.gera(QTD_CONVERSAO, faker=faker)
    dado_fake.DadoFake.salva_csv(CAMINHO_CONVERSOES, conversoes)

    paises = pais_fake.PaisFake.gera(QTD_PAIS, faker, *conversoes)
    dado_fake.DadoFake.salva_csv(CAMINHO_PAISES, paises)

if __name__ == '__main__':
    # >>> python -m uv run -- python -m src.main
    print('')
    main()
    print('')