

import abc
import dataclasses
import logging
import pathlib
from collections.abc import Sequence
from typing import Any, ClassVar, Self

import faker as fkr


@dataclasses.dataclass(frozen=True, slots=True, kw_only=True, order=True)
class DadoFake(abc.ABC):
    # Cabeçalho da tabela
    CABECALHO: ClassVar[tuple[str, ...]]

    @property
    @abc.abstractmethod
    def pk(self) -> Any: ...

    @property
    @abc.abstractmethod
    def dados(self) -> Any: ...

    @property
    @abc.abstractmethod
    def tupla(self) -> Any: ...

    @classmethod
    @abc.abstractmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, **kwargs: dict[str, Any]) -> tuple[Self, ...]: ...


    @staticmethod
    def salva_csv(caminho: str|pathlib.Path, fakes: Sequence['DadoFake']) -> pathlib.Path:
        # Cria pasta caso nao exista
        caminho = pathlib.Path(caminho)
        caminho.parent.mkdir(parents=True, exist_ok=True)

        # Salva os dados em um arquivo CSV
        with open(caminho, mode='w', encoding='utf-8') as arquivo_csv:
            arquivo_csv.write(';'.join(fakes[0].CABECALHO) + '\n')

            for fake in fakes:
                arquivo_csv.write(';'.join(map(str, fake.tupla)) + '\n')

        qtd = f'{len(fakes):_}'.rjust(6)
        logging.info(f"{qtd}  linhas geradas com sucesso no arquivo '{caminho}'")
        return caminho
