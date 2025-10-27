
from collections.abc import Sequence
import pathlib
from faker import Faker

from . import empresa_fake, plataforma_fake

# Inicializa os geradores de dados em português e inglês
faker = Faker(['pt_BR', 'en_US'])


def gera_empresas(quantidade: int) -> None:
    empresas = empresa_fake.EmpresaFake.gera(quantidade, faker=faker)
    empresa_fake.EmpresaFake.salva_csv('dados/empresas.csv', empresas)

def gera_plataformas(quantidade: int, empresas: Sequence[empresa_fake.EmpresaFake]) -> None:
    plataformas = plataforma_fake.PlataformaFake.gera(quantidade, faker, *empresas)
    empresa_fake.EmpresaFake.salva_csv('dados/plataformas.csv', plataformas)


def main():
    # Define o número de registros que deseja gerar
    QTD_EMPRESA = 50
    QTD_PLATAFORMA = 50

    if not pathlib.Path('dados/empresas.csv').exists():
        gera_empresas(QTD_EMPRESA)

    empresas = empresa_fake.EmpresaFake.gera_a_partir_do_csv('dados/empresas.csv')
    gera_plataformas(QTD_PLATAFORMA, empresas)

if __name__ == '__main__':
    # >>> python -m uv run -- python -m src.main
    main()