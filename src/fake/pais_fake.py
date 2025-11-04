"""--sql
CREATE TABLE pais (
  ddi   SMALLINT PRIMARY KEY,
  nome  TEXT NOT NULL,
  moeda TEXT NOT NULL,
  CONSTRAINT fk_pais_moeda FOREIGN KEY (moeda) REFERENCES conversao(moeda)
);"""

import dataclasses
import json
import logging
import pathlib
from typing import Any, Literal, Self, TypedDict

import faker as fkr

from . import conversao_fake, dado_fake


class _IDD(TypedDict):
    root: str
    suffixes: list[str]


class _Currency(TypedDict):
    name: str
    symbol: str


class _CountrySubset(TypedDict):
    name: dict[Literal["common"], str]
    currencies: dict[str, _Currency]
    idd: _IDD


T_Pais = dict[Literal["país", "ddi"], str]


def moeda_para_pais(json: _CountrySubset) -> dict[str, T_Pais]:
    if not json.get("currencies"):
        return {}

    moeda: str = next(iter(json["currencies"].keys()))
    nome_pais: str = json["name"]["common"]
    DDI_pais: str = json["idd"]["root"] + json["idd"]["suffixes"][0]

    return {moeda: {"país": nome_pais, "ddi": DDI_pais}}


def ler_pais(caminho_arquivo: str | pathlib.Path = "./countries.json") -> dict[str, T_Pais]:
    moeda_pais: dict[str, T_Pais] = {}
    with open(caminho_arquivo, encoding="utf-8") as arquivo:
        for json_pais in json.load(arquivo):
            moeda_pais.update(moeda_para_pais(json_pais))

    return moeda_pais


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class PaisFake(dado_fake.DadoFake):
    CABECALHO = ("nome", "ddi", "moeda")
    nome: str
    ddi: int
    moeda: str

    T_pk = str

    @property
    def pk(self) -> str:
        return self.nome

    T_dados = tuple[int, str]

    @property
    def dados(self) -> tuple[int, str]:
        return (self.ddi, self.moeda)

    @property
    def tupla(self) -> tuple[T_pk, *T_dados]:
        return (self.pk, *self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *conversoes: conversao_fake.ConversaoFake, **kwargs: dict[str, Any]) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} países...")

        def seleciona_pais(moeda_pais: dict[str, T_Pais], moeda: str) -> tuple[str, str]:
            pais = moeda_pais[moeda]
            pais_nome: str = pais["país"]
            pais_ddi: str = pais["ddi"].lstrip("+")
            assert pais_ddi.isnumeric(), f"DDI Inválido: {(pais, pais_nome, pais_ddi)=}"

            return pais_nome, pais_ddi

        # Lista para armazenar os dados
        paises: set[Self] = set()
        moeda_pais: dict[str, T_Pais] = ler_pais()

        conversoes_aleatorias = set(conversoes)
        assert len(conversoes_aleatorias) >= quantidade, f"Não há conversões suficientes para gerar {quantidade} países únicos."

        #TODO: Otimizar essa parte
        # Geração dos dados
        i = 0
        while len(paises) < quantidade:
            i += 1
            if (moeda := conversoes_aleatorias.pop().moeda) not in moeda_pais:
                continue

            pais_nome, ddi = seleciona_pais(moeda_pais, moeda)
            # Armazena os dados gerados
            paises.add(cls(pais_nome, int(ddi), moeda))

        if i > len(paises):
            logging.warning(f"\tOBS: Pulou {i - len(paises)} moedas sem país correspondente")

        return tuple(paises)
