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
import itertools
import random
from collections.abc import Collection
from typing import Any, Self, Unpack

import faker as fkr

from . import dado_fake, empresa_fake, pais_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class EmpresaPaisFake(dado_fake.DadoFake):
    CABECALHO = ('nro_empresa', 'nome_pais', 'id_nacional')
    nro_empresa: int
    nome_pais: str
    id_nacional: str

    type T_pk = tuple[int, str]
    @property
    def pk(self) -> T_pk: return (self.nro_empresa, self.nome_pais)

    type T_dados = str
    @property
    def dados(self) -> T_dados: return self.id_nacional

    @property
    def tupla(self) -> tuple[Unpack[T_pk], T_dados]: return (*self.pk, self.dados)


    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, empresas: Collection[empresa_fake.EmpresaFake],
             paises: Collection[pais_fake.PaisFake], **kwargs: Any) -> tuple[Self, ...]:

        assert len(empresas) * len(paises) >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"

        # Lista para armazenar os dados
        empresa_pais: list[Self] = []


        # Geração dos dados
        empresas_x_paises = itertools.product(empresas, paises)
        for empresa, pais in random.sample(tuple(empresas_x_paises), quantidade):
            nro_empresa = empresa.nro
            nome_pais   = pais.nome

            #TODO: Usar https://restcountries.com/v3.1/all?fields=currency,name,cca3 para abreviação
            if len(nome_pais_palavras := nome_pais.split()) == 3:
                pais_abreviacao = ''.join(palavra[0] for palavra in nome_pais_palavras).upper()
            else:
                pais_abreviacao = nome_pais[:3].upper()

            id_nacional: str = faker.unique.bothify(text=f'{pais_abreviacao}-#########')

            # Armazena o dado gerado
            empresa_pais.append(cls(nro_empresa=nro_empresa, nome_pais=nome_pais, id_nacional=id_nacional))

        return tuple(empresa_pais)
