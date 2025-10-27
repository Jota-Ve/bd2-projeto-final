

"""--sql
CREATE TABLE plataforma (
  nro             SERIAL PRIMARY KEY,
  nome            TEXT NOT NULL,
  qtd_users       INTEGER NOT NULL, -- derivado: atualizar periodicamente
  empresa_fund    SERIAL NOT NULL,
  empresa_respo   SERIAL NOT NULL,
  data_fund       DATE NOT NULL,
  CONSTRAINT fk_plataforma_empresa_fund FOREIGN KEY (empresa_fund) REFERENCES empresa(nro),
  CONSTRAINT fk_plataforma_empresa_respo FOREIGN KEY (empresa_respo) REFERENCES empresa(nro)
);"""

from collections.abc import Sequence
import datetime
import random
from typing import Self

import faker as fkr

from . import empresa_fake

from .dado_fake import DadoFake


class PlataformaFake(DadoFake):
    CABECALHO = ('nro', 'nome', 'qtd_users', 'empresa_fund', 'empresa_respo', 'data_fund')


    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, empresas: Sequence[empresa_fake.EmpresaFake]) -> tuple[Self, ...]:
        OPCOES_PARA_NOME_STREAMING = ("Plus", "Max", "Now", "Originals", "One", "++", "Video", "Flix")
        PRIMEIRA_DATA = datetime.date(1990, 1, 1)
        ULTIMA_DATA = datetime.date.today()

        # Lista para armazenar os dados
        dados: list[Self] = []

        # Geração dos dados
        for nro in range(1, quantidade + 1):
            nome = faker.company() + random.choice(OPCOES_PARA_NOME_STREAMING)
            qtd_users = 0
            empresa_fund = 'random.choice(empresas).pk
            empresa_respo = 'random.choice(empresas).pk
            data_fund = faker.date_between(PRIMEIRA_DATA, ULTIMA_DATA)
            dados.append(cls(pk=(nro,), dados=(nome, qtd_users, empresa_fund, empresa_respo, data_fund)))

        return tuple(dados)
