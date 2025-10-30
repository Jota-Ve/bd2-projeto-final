
import pathlib

from faker import Faker

from src import conversao_fake, empresa_pais_fake, pais_fake, usuario_fake

from . import dado_fake, empresa_fake, plataforma_fake

type T_StrOrPath = str | pathlib.Path

# Inicializa os geradores de dados em português e inglês
faker = Faker(['pt_BR', 'en_US'])



def main(faker: Faker = faker) -> None:
    # Define o número de registros que deseja gerar
    QTD_EMPRESA        = 1_000
    QTD_PLATAFORMA     = 1_000
    QTD_CONVERSAO      = 160
    QTD_PAIS           = 130
    QTD_EMPRESA_X_PAIS = min(QTD_EMPRESA * QTD_PAIS, 1_000)
    QTD_USUARIOS       = 1_000

    CAMINHO_EMPRESA        = 'dados/empresa.csv'
    CAMINHO_PLATAFORMA     = 'dados/plataforma.csv'
    CAMINHO_CONVERSAO      = 'dados/conversao.csv'
    CAMINHO_PAIS           = 'dados/pais.csv'
    CAMINHO_EMPRESA_X_PAIS = 'dados/empresa_pais.csv'
    CAMINHO_USUARIO        = 'dados/usuario.csv'

    empresas = empresa_fake.EmpresaFake.gera(QTD_EMPRESA, faker=faker)
    dado_fake.DadoFake.salva_csv(CAMINHO_EMPRESA, empresas)

    plataformas = plataforma_fake.PlataformaFake.gera(QTD_PLATAFORMA, faker, *empresas)
    dado_fake.DadoFake.salva_csv(CAMINHO_PLATAFORMA, plataformas)

    conversoes = conversao_fake.ConversaoFake.gera(QTD_CONVERSAO, faker=faker)
    dado_fake.DadoFake.salva_csv(CAMINHO_CONVERSAO, conversoes)

    paises = pais_fake.PaisFake.gera(QTD_PAIS, faker, *conversoes)
    dado_fake.DadoFake.salva_csv(CAMINHO_PAIS, paises)

    empresas_x_paises = empresa_pais_fake.EmpresaPaisFake.gera(QTD_EMPRESA_X_PAIS, faker, empresas=empresas, paises=paises)
    dado_fake.DadoFake.salva_csv(CAMINHO_EMPRESA_X_PAIS, empresas_x_paises)

    usuarios = usuario_fake.UsuarioFake.gera(QTD_USUARIOS, faker, *paises)
    dado_fake.DadoFake.salva_csv(CAMINHO_USUARIO, usuarios)

if __name__ == '__main__':
    # >>> python -m uv run -- python -m src.main
    print('')
    main()
    print('')