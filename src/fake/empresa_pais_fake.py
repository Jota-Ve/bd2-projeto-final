"""--sql
CREATE TABLE public.empresa_pais (
        nro_empresa serial4 NOT NULL,
        id_nacional text NULL,
        nome_pais text NOT NULL,
        CONSTRAINT empresa_pais_pkey PRIMARY KEY (nro_empresa, nome_pais),
        CONSTRAINT empresa_pais_id_nacional_unique UNIQUE (id_nacional,nome_pais),
        CONSTRAINT fk_empresapais_empresa FOREIGN KEY (nro_empresa) REFERENCES public.empresa(nro),
        CONSTRAINT fk_empresapais_pais FOREIGN KEY (nome_pais) REFERENCES public.pais(nome)
);
"""

import dataclasses
import logging
from collections.abc import Sequence
from typing import Any, Self

import faker as fkr

from src.fake import combinacoes

from . import dado_fake, empresa_fake, pais_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class EmpresaPaisFake(dado_fake.DadoFake):
    CABECALHO = ("nro_empresa_fk", "id_pais_fk", "id_nacional")
    nro_empresa_fk: int
    id_pais_fk: int
    id_nacional: str

    T_pk = tuple[int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_empresa_fk, self.id_pais_fk)

    T_dados = str

    @property
    def dados(self) -> T_dados:
        return self.id_nacional

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
        paises: Sequence[pais_fake.PaisFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} empresa_pais...")
        assert len(empresas) * len(paises) >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"

        # Lista para armazenar os dados
        empresa_pais: list[Self] = []

        # Geração dos dados
        empresas_x_paises = combinacoes.combina(empresas, paises, quantidade)
        for empresa, pais in empresas_x_paises:
            nro_empresa = empresa.nro
            id_pais = pais.id_pais

            # TODO: Usar https://restcountries.com/v3.1/all?fields=currency,name,cca3 para abreviação
            nome_pais = pais.nome
            nome_pais_palavras = nome_pais.split()
            if len(nome_pais_palavras) == 3:
                pais_abreviacao = "".join(palavra[0] for palavra in nome_pais_palavras).upper()
            else:
                pais_abreviacao = nome_pais[:3].upper()

            id_nacional: str = faker.unique.bothify(text=f"{pais_abreviacao}-#########")

            # Armazena o dado gerado
            empresa_pais.append(cls(nro_empresa_fk=nro_empresa, id_pais_fk=id_pais, id_nacional=id_nacional))

        return tuple(empresa_pais)
