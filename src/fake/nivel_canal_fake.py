"""--sql
CREATE TABLE public.nivel_canal (
        nro_plataforma serial4 NOT NULL,
        nome_canal text NOT NULL,
        nivel int2 NOT NULL,
        nome_nivel text NOT NULL,
        valor numeric(18, 2) NOT NULL,
        gif bytea NULL,
        CONSTRAINT nivel_canal_nivel_check CHECK (((nivel >= 1) AND (nivel <= 5))),
        CONSTRAINT nivel_canal_pkey PRIMARY KEY (nro_plataforma, nome_canal, nivel),
        CONSTRAINT nivel_canal_valor_check CHECK ((valor > (0)::numeric)),
        CONSTRAINT fk_nivel_canal FOREIGN KEY (nro_plataforma,nome_canal) REFERENCES public.canal(nro_plataforma,nome) ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import logging
import random
from collections.abc import Sequence
from typing import Any, ClassVar, Literal, Self

import faker as fkr

from . import canal_fake, dado_fake

T_nivel = Literal[1, 2, 3, 4, 5]


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class NivelCanal(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "nome_canal", "nivel", "nome_nivel", "valor", "gif")
    # Valores mínimos e máximos para o valor do patrocínio
    VALOR_MINIMO: ClassVar[float] = 5.0
    VALOR_MAXIMO: ClassVar[float] = 100.0

    nro_plataforma: int
    nome_canal: str
    nivel: T_nivel
    nome_nivel: str
    valor: float
    gif: bytes | None = None

    T_pk = tuple[int, str, T_nivel]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.nome_canal, self.nivel)

    T_dados = tuple[str, float, bytes | None]

    @property
    def dados(self) -> T_dados:
        return (self.nome_nivel, self.valor, self.gif)

    @property
    def tupla(self) -> tuple[*T_pk, *T_dados]:
        return (*self.pk, *self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, canais: Sequence[canal_fake.CanalFake], **kwargs: Any) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} níveis de canal...")
        assert quantidade % 5 == 0, "A quantidade de níveis de canal deve ser múltipla de 5."
        assert len(canais) * 5 >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"

        # Lista para armazenar os dados
        nivel_x_canais: list[Self] = []
        niveis: dict[T_nivel, tuple[int, int]] = {1: (5, 7), 2: (8, 14), 3: (15, 29), 4: (30, 59), 5: (60, 100)}

        # Geração de dados fictícios
        for canal in random.sample(canais, quantidade // 5):
            for nivel in niveis:
                nome_nivel: str = f"{canal.nome} - Nivel {nivel}"
                valor: float = random.randint(*niveis[nivel]) - random.choice([0.0, 0.01])
                gif: bytes | None = faker.binary(length=2 ** random.randint(7, 11)) if random.random() < 0.9 else None

                # Cria a instância e adiciona à lista
                nivel_x_canais.append(cls(*canal.pk, nivel=nivel, nome_nivel=nome_nivel, valor=valor, gif=gif))

        return tuple(nivel_x_canais)
