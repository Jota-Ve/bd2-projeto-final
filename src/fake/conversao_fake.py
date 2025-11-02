"""--sql
CREATE TABLE conversao (
  moeda       TEXT PRIMARY KEY,
  nome        TEXT NOT NULL,
  fator_conver NUMERIC(18,8) NOT NULL CHECK (fator_conver > 0) -- fator_conver é o fator de conversão para dólar
);"""

import dataclasses
import random
from typing import Any, ClassVar, Self

import faker as fkr

from .dado_fake import DadoFake


@dataclasses.dataclass(frozen=True, slots=True)
class ConversaoFake(DadoFake):
    CABECALHO: ClassVar = ('moeda', 'nome', 'fator_conver')
    # Valores mínimos e máximos para o fator de conversão para dólar
    VALOR_MINIMO: ClassVar[float] = 0.01
    VALOR_MAXIMO: ClassVar[float] = 6.50

    moeda: str
    nome: str
    fator_conver: float

    T_pk = str
    @property
    def pk(self) -> T_pk: return self.moeda

    T_dados = tuple[str, float]
    @property
    def dados(self) -> T_dados: return (self.nome, self.fator_conver)

    @property
    def tupla(self) -> tuple[T_pk, *T_dados]:
        return (self.pk, *self.dados)


    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, **kwargs: dict[str, Any]) -> tuple[Self, ...]:

        # Lista para armazenar os dados
        conversoes: list[Self] = []

        # Geração dos dados
        for _ in range(1, quantidade + 1):
            moeda, nome = faker.unique.currency()

            # O fator de conversão do dólar para dólar é sempre 1.0
            fator_conver: float   = 1. if (moeda == 'USD') else random.uniform(cls.VALOR_MINIMO, cls.VALOR_MAXIMO)
            # Armazena o dado gerado
            conversoes.append(cls(moeda, nome, fator_conver))

        return tuple(conversoes)
