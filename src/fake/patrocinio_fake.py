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
from collections.abc import Sequence
from typing import Any, ClassVar, Self

import faker as fkr

from src.fake import canal_fake, combinacoes, dado_fake, empresa_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class PatrocinioFake(dado_fake.DadoFake):
    CABECALHO = ("nro_empresa_fk", "nro_plataforma_fk", "id_canal_fk", "valor")
    # Valores mínimos e máximos para o valor do patrocínio
    VALOR_MINIMO: ClassVar[float] = 500.0
    VALOR_MAXIMO: ClassVar[float] = 50_000.0

    nro_empresa_fk: int
    nro_plataforma_fk: int
    id_canal_fk: int
    valor: float

    T_pk = tuple[int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_empresa_fk, self.nro_plataforma_fk, self.id_canal_fk)

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

        empresa_canal = combinacoes.combina(empresas, canais, quantidade)

        for empresa, canal in empresa_canal:
            valor: float = faker.pyfloat(min_value=cls.VALOR_MINIMO, max_value=cls.VALOR_MAXIMO, right_digits=2)
            # canal.pk is (nro_plataforma, id_canal)
            nro_plataforma, id_canal = canal.pk
            patrocinios.append(cls(empresa.pk, nro_plataforma, id_canal, valor=valor))

        return tuple(patrocinios)
