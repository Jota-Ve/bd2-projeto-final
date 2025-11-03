"""--sql
CREATE TABLE public.patrocinio (
        nro_empresa serial4 NOT NULL,
        nro_plataforma serial4 NOT NULL,
        nome_canal text NOT NULL,
        valor numeric(18, 2) NOT NULL,
        CONSTRAINT patrocinio_pkey PRIMARY KEY (nro_empresa, nro_plataforma, nome_canal),
        CONSTRAINT patrocinio_valor_check CHECK ((valor > (0)::numeric)),
        CONSTRAINT fk_patrocinio_canal FOREIGN KEY (nro_plataforma,nome_canal) REFERENCES public.canal(nro_plataforma,nome) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_patrocinio_empresa FOREIGN KEY (nro_empresa) REFERENCES public.empresa(nro) ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import logging
import random
from collections.abc import Sequence
from typing import Any, ClassVar, Self

import faker as fkr

from src.fake import canal_fake, dado_fake, empresa_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class PatrocinioFake(dado_fake.DadoFake):
    CABECALHO = ("nro_empresa", "nro_plataforma", "nome_canal", "valor")
    # Valores mínimos e máximos para o valor do patrocínio
    VALOR_MINIMO: ClassVar[float] = 500.0
    VALOR_MAXIMO: ClassVar[float] = 50_000.0

    nro_empresa: int
    nro_plataforma: int
    nome_canal: str
    valor: float

    T_pk = tuple[int, int, str]

    @property
    def pk(self) -> T_pk:
        return (self.nro_empresa, self.nro_plataforma, self.nome_canal)

    T_dados = float

    @property
    def dados(self) -> T_dados:
        return self.valor

    @property
    def tupla(self) -> tuple[*T_pk, T_dados]:
        return (*self.pk, self.dados)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        empresas: Sequence[empresa_fake.EmpresaFake],
        canais: Sequence[canal_fake.CanalFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:

        logging.info(f"Iniciando geração de {quantidade:_} patrocínios...")

        assert len(empresas) * len(canais) >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"
        # Lista para armazenar os dados
        patrocinios: list[Self] = []
        total = len(empresas) * len(canais)
        n = len(canais)

        # Obter k índices únicos no intervalo [0, total)
        chosen = random.sample(range(total), quantidade)

        for idx in chosen:
            i_emp = idx // n       # índice da empresa
            i_can = idx % n        # índice do canal

            empresa = empresas[i_emp]
            canal = canais[i_can]
            valor: float = faker.pyfloat(min_value=cls.VALOR_MINIMO, max_value=cls.VALOR_MAXIMO, right_digits=2)
            patrocinios.append(cls(empresa.pk, *canal.pk, valor=valor))

        return tuple(patrocinios)
