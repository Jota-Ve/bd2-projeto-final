
import dataclasses
import logging
from collections.abc import Sequence
from typing import Any, Self

import faker as fkr

from src.fake import combinacoes

from . import dado_fake, empresa_fake, pais_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class EmpresaPaisFake(dado_fake.DadoFake):
    CABECALHO = ("nro_empresa", "id_pais", "id_nacional")
    nro_empresa: int
    id_pais: int
    id_nacional: str

    T_pk = tuple[int, int]
    T_dados = str

    @property
    def pk(self) -> T_pk:
        return (self.nro_empresa, self.id_pais)


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
        logging.info(f"Gerando {quantidade:_} empresa_pais...")
        assert len(empresas) * len(paises) >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"

        # Lista para armazenar os dados
        empresa_pais: list[Self] = []

        # Geração dos dados
        empresas_x_paises = combinacoes.combina(empresas, paises, quantidade)
        for empresa, pais in empresas_x_paises:
            nro_empresa = empresa.nro
            nome_pais = pais.nome
            id_pais = pais.id

            # TODO: Usar https://restcountries.com/v3.1/all?fields=currency,name,cca3 para abreviação
            if len(nome_pais_palavras := nome_pais.split()) == 3:
                pais_abreviacao = "".join(palavra[0] for palavra in nome_pais_palavras).upper()
            else:
                pais_abreviacao = nome_pais[:3].upper()

            id_nacional: str = faker.unique.bothify(text=f"{pais_abreviacao}-#########")

            # Armazena o dado gerado
            empresa_pais.append(cls(nro_empresa=nro_empresa, id_pais=id_pais, id_nacional=id_nacional))

        return tuple(empresa_pais)
