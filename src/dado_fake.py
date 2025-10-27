

import abc
import dataclasses
import pathlib
from typing import Any, ClassVar, Self
from collections.abc import Iterable, Sequence

import faker as fkr


@dataclasses.dataclass(frozen=True, slots=True, kw_only=True)
class DadoFake(abc.ABC):
    # Cabeçalho da tabela
    CABECALHO: ClassVar[tuple[str, ...]]

    pk: tuple[Any]
    dados: tuple[Any, ...]


    @classmethod
    @abc.abstractmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, **kwargs: dict[str, Any]) -> tuple[Self, ...]: ...


    @staticmethod
    def salva_csv(caminho: str|pathlib.Path, fakes: Sequence['DadoFake']) -> None:
        # Cria pasta caso nao exista
        caminho = pathlib.Path(caminho)
        caminho.parent.mkdir(parents=True, exist_ok=True)

        # Salva os dados em um arquivo CSV
        with open(caminho, mode='w', encoding='utf-8') as arquivo_csv:
            arquivo_csv.write(';'.join(fakes[0].CABECALHO) + '\n')

            for fake in fakes:
                pk_csv = ';'.join(map(str, fake.pk))
                dados_csv = ';'.join((d if isinstance(d, Iterable) else str(d) for d in fake.dados))
                arquivo_csv.write(';'.join([pk_csv, dados_csv]) + '\n')

        print(f"Arquivo '{caminho}' gerado com sucesso!")
