"""--sql
CREATE TABLE pais (
  ddi   SMALLINT PRIMARY KEY,
  nome  TEXT NOT NULL,
  moeda TEXT NOT NULL,
  CONSTRAINT fk_pais_moeda FOREIGN KEY (moeda) REFERENCES conversao(moeda)
);"""

import json
import pathlib
import random
from typing import Any, Literal, Self, TypedDict

import faker as fkr

from src import conversao_fake

from .dado_fake import DadoFake


class _IDD(TypedDict):
    root: str
    suffixes: list[str]

class _Currency(TypedDict):
    name: str
    symbol: str

class _CountrySubset(TypedDict):
    name: dict[Literal['common'], str]
    currencies: dict[str, _Currency]
    idd: _IDD


type T_Pais = dict[Literal['país', 'ddi'], str]
def moeda_para_pais(json: _CountrySubset)  -> dict[str, T_Pais]:
    if not json.get('currencies'):
        return {}

    moeda:     str = next(iter(json['currencies'].keys()))
    nome_pais: str = json['name']['common']
    DDI_pais:  str = json['idd']['root'] + json['idd']['suffixes'][0]

    return {moeda: {'país': nome_pais, 'ddi' : DDI_pais}}


def ler_pais(caminho_arquivo: str|pathlib.Path='./countries.json')  -> dict[str, T_Pais]:
    moeda_pais: dict[str, T_Pais] = {}
    with open(caminho_arquivo, 'r', encoding='utf-8') as arquivo:
        for json_pais in json.load(arquivo):
            moeda_pais.update(moeda_para_pais(json_pais))

    return moeda_pais


class PaisFake(DadoFake):
    CABECALHO = ('ddi', 'nome', 'moeda')

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *conversoes: conversao_fake.ConversaoFake, **kwargs: dict[str, Any]) -> tuple[Self, ...]:

        def seleciona_moeda(conversoes: tuple[conversao_fake.ConversaoFake, ...], moeda_pais: dict[str, T_Pais]) -> str:
            tentativa_atual = 0
            while True:
                tentativa_atual += 1
                if (moeda := random.choice(conversoes).pk[0]) not in moeda_pais:
                    continue
                break

            return moeda

        def seleciona_pais(moeda_pais: dict[str, T_Pais], moeda: str) -> tuple[str, str]:
            pais = moeda_pais[moeda]
            pais_nome: str = pais['país']
            pais_ddi : str = pais['ddi']

            return pais_nome, pais_ddi


        # Lista para armazenar os dados
        paises_gerados: set[Self] = set()
        moeda_pais    : dict[str, T_Pais] = ler_pais()

        # Geração dos dados
        while len(paises_gerados) < quantidade:
            moeda = seleciona_moeda(conversoes, moeda_pais)
            pais_nome, ddi = seleciona_pais(moeda_pais, moeda)
            # Armazena os dados gerados
            paises_gerados.add(cls(pk=(ddi,), dados=(pais_nome, moeda)))

        return tuple(paises_gerados)
