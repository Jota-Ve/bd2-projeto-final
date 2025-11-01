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
import itertools
import random
from collections.abc import Collection
from typing import Any, ClassVar, Self, Unpack

import faker as fkr

from src import canal_fake, empresa_fake

from .dado_fake import DadoFake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class PatrocinioFake(DadoFake):
    CABECALHO = ('nro_empresa', 'nro_plataforma', 'nome_canal', 'valor')
    # Valores mínimos e máximos para o valor do patrocínio
    VALOR_MINIMO: ClassVar[float] = 500.0
    VALOR_MAXIMO: ClassVar[float] = 50_000.0

    nro_empresa: int
    nro_plataforma: int
    nome_canal: str
    valor: float

    type T_pk = tuple[int, int, str]
    @property
    def pk(self) -> T_pk: return (self.nro_empresa, self.nro_plataforma, self.nome_canal)

    type T_dados = float
    @property
    def dados(self) -> T_dados: return self.valor

    @property
    def tupla(self) -> tuple[Unpack[T_pk], T_dados]: return (*self.pk, self.dados)


    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, empresas: Collection[empresa_fake.EmpresaFake],
             canais: Collection[canal_fake.CanalFake], **kwargs: Any) -> tuple[Self, ...]:

        assert len(empresas) * len(canais) >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"

        # Lista para armazenar os dados
        patrocinios: list[Self] = []

        # Geração de dados fictícios
        empresas_x_canais = itertools.product(empresas, canais)

        for empresa, canal in random.sample(tuple(empresas_x_canais), quantidade):
            valor: float = faker.pyfloat(min_value=cls.VALOR_MINIMO, max_value=cls.VALOR_MAXIMO, right_digits=2)
            patrocinios.append(cls(empresa.pk, *canal.pk, valor=valor))

        return tuple(patrocinios)
