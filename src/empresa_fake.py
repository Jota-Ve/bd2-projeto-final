import random
from typing import Self

import faker as fkr

from .dado_fake import DadoFake


class EmpresaFake(DadoFake):
    CABECALHO = ('nro', 'nome', 'nome_fantasia')


    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker) -> tuple[Self, ...]:
        OPCOES_PARA_NOME_FANTASIA = ("Express", "Digital", "Plus", "Max", "Now", "Original", "One", "Singular", "Store")

        # Lista para armazenar os dados
        dados_empresas: list[Self] = []

        # Geração dos dados
        for i in range(1, quantidade + 1):
            nome = faker.company()
            nome_fantasia = nome + " " + random.choice(OPCOES_PARA_NOME_FANTASIA)
            dados_empresas.append(cls(pk=(i,), dados=(nome, nome_fantasia)))

        return tuple(dados_empresas)
