"""--sql
CREATE TABLE conversao (
  moeda       TEXT PRIMARY KEY,
  nome        TEXT NOT NULL,
  fator_conver NUMERIC(18,8) NOT NULL CHECK (fator_conver > 0) -- fator_conver é o fator de conversão para dólar
);"""

import dataclasses
import logging
import random
from typing import Any, ClassVar, Self

import faker as fkr

from .dado_fake import DadoFake


@dataclasses.dataclass(frozen=True, slots=True)
class ConversaoFake(DadoFake):
    CABECALHO: ClassVar = ("id", "moeda_abrev", "moeda_nome", "fator_conver")
    # Valores mínimos e máximos para o fator de conversão para dólar
    VALOR_MINIMO: ClassVar[float] = 0.00001
    VALOR_MAXIMO: ClassVar[float] = 4.0

    id: int
    moeda_abrev: str
    moeda_nome: str
    fator_conver: float

    T_pk = int
    T_dados = tuple[str, str, float]

    @property
    def pk(self) -> T_pk:
        return self.id


    @property
    def dados(self) -> T_dados:
        return (self.moeda_abrev, self.moeda_nome, self.fator_conver)

    @property
    def tupla(self) -> tuple[T_pk, *T_dados]:
        return (self.pk, *self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, **kwargs: dict[str, Any]) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} conversões...")

        # Lista para armazenar os dados
        conversoes: list[Self] = []

        # Geração dos dados
        for i in range(1, quantidade + 1):
            moeda_abrev, moeda_nome = faker.unique.currency()

            # O fator de conversão do dólar para dólar é sempre 1.0
            fator_conver: float = 1.0 if (moeda_abrev == "USD") else random.uniform(cls.VALOR_MINIMO, cls.VALOR_MAXIMO)
            # Armazena o dado gerado
            conversoes.append(cls(id=i, moeda_abrev=moeda_abrev, moeda_nome=moeda_nome, fator_conver=fator_conver))

        return tuple(conversoes)
