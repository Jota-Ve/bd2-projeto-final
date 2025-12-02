
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
    CABECALHO = ("id", "ddi", "nome", "id_conversao")
    id: int
    ddi: int
    nome: str
    id_conversao: int

    T_pk = int
    T_dados = tuple[int, str, int]

    @property
    def pk(self) -> T_pk:
        return self.id


    @property
    def dados(self) -> T_dados:
        return (self.id, self.ddi, self.id_conversao)

    @property
    def tupla(self) -> tuple[T_pk, *T_dados]:
        return (self.pk, *self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *conversoes: conversao_fake.ConversaoFake, **kwargs: dict[str, Any]) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} países...")

        def seleciona_pais(moeda_pais: dict[str, T_Pais], moeda: str) -> tuple[str, str]:
            pais = moeda_pais[moeda]
            pais_nome: str = pais["país"]
            pais_ddi: str = pais["ddi"].lstrip("+")
            assert pais_ddi.isnumeric(), f"DDI Inválido: {(pais, pais_nome, pais_ddi)=}"

            return pais_nome, pais_ddi

        # Lista para armazenar os dados
        paises_unicos: set[tuple[str, int, str]] = set()
        moeda_pais: dict[str, T_Pais] = ler_pais()
        logging.debug(f'{moeda_pais=}')
        
        conversoes_aleatorias = set(conversoes)
        assert len(conversoes_aleatorias) >= quantidade, f"Não há conversões suficientes para gerar {quantidade} países únicos."

        #TODO: Otimizar essa parte
        # Geração dos dados
        i = 0
        while len(paises_unicos) < quantidade:
            i += 1
            conversao = conversoes_aleatorias.pop()
            if (moeda_abrev := conversao.moeda_abrev) not in moeda_pais:
                continue

            pais_nome, ddi = seleciona_pais(moeda_pais, moeda_abrev)
            # Armazena os dados gerados (sem ID por enquanto)
            paises_unicos.add((pais_nome, int(ddi), moeda_abrev))

        if i > len(paises_unicos):
            logging.debug(f"\tOBS: Pulou {i - len(paises_unicos)} moedas sem país correspondente")

        # Cria instâncias com ID sequencial
        paises_finais = []
        for id_seq, (pais_nome, ddi, moeda_abrev) in enumerate(paises_unicos, start=1):
            paises_finais.append(cls(id=id_seq, nome=pais_nome, ddi=ddi, id_conversao=conversao.id))

        return tuple(paises_finais)
