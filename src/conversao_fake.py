"""--sql
CREATE TABLE conversao (
  moeda       TEXT PRIMARY KEY,
  nome        TEXT NOT NULL,
  fator_conver NUMERIC(18,8) NOT NULL CHECK (fator_conver > 0) -- fator_conver é o fator de conversão para dólar
);"""

import random
from typing import Any, Self

import faker as fkr

from .dado_fake import DadoFake


class ConversaoFake(DadoFake):
    CABECALHO = ('moeda', 'nome', 'fator_conver')

    # Valores mínimos e máximos para o fator de conversão
    VALOR_MINIMO = 0.01
    VALOR_MAXIMO = 6.50

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, **kwargs: dict[str, Any]) -> tuple[Self, ...]:

        # Lista para armazenar os dados
        conversoes: list[Self] = []

        # Geração dos dados
        for _ in range(1, quantidade + 1):
            moeda, nome = faker.unique.currency()
            fator_conver: float   = random.uniform(cls.VALOR_MINIMO, cls.VALOR_MAXIMO)
            conversoes.append(cls(pk=(moeda,), dados=(nome, fator_conver)))

        return tuple(conversoes)
