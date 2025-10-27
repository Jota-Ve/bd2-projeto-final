
import pathlib

from faker import Faker

from . import dado_fake, empresa_fake, plataforma_fake

type T_StrOrPath = str | pathlib.Path

# Inicializa os geradores de dados em português e inglês
faker = Faker(['pt_BR', 'en_US'])


def main(faker: Faker = faker) -> None:
    # Define o número de registros que deseja gerar
    QTD_EMPRESA = 50
    QTD_PLATAFORMA = 50

    CAMINHO_EMPRESAS = 'dados/empresas.csv'
    CAMINHO_PLATAFORMAS = 'dados/plataformas.csv'

    empresas = empresa_fake.EmpresaFake.gera(QTD_EMPRESA, faker=faker)
    dado_fake.DadoFake.salva_csv(CAMINHO_EMPRESAS, empresas)

    plataformas = plataforma_fake.PlataformaFake.gera(QTD_PLATAFORMA, faker, *empresas)
    dado_fake.DadoFake.salva_csv(CAMINHO_PLATAFORMAS, plataformas)


if __name__ == '__main__':
    # >>> python -m uv run -- python -m src.main
    main()