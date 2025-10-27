
from faker import Faker

import empresa_fake

# Inicializa os geradores de dados em português e inglês
faker = Faker(['pt_BR', 'en_US'])



def main():
    # Define o número de registros que deseja gerar
    QTD_EMPRESA = 20
    empresas = empresa_fake.EmpresaFake.gera(QTD_EMPRESA, faker=faker)
    empresa_fake.EmpresaFake.salva_csv('dados/empresas.csv', empresas)


if __name__ == '__main__':
    main()