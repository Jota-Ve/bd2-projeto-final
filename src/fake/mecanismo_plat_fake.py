

import dataclasses
import logging
import random
from collections.abc import Sequence
from typing import Any, Self

import faker as fkr

from . import dado_fake, doacao_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class MecanismoPlatFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_video", "seq_comentario",  "seq_plataforma")
    nro_plataforma: int
    id_video: int
    seq_comentario: int
    
    seq_plataforma: int

    T_pk = tuple[int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_video, self.seq_comentario)

    T_dados = int

    @property
    def dados(self) -> T_dados:
        return self.seq_plataforma

    @property
    def tupla(self) -> tuple[int, int, int, int, int]:
        return (*self.pk, self.dados)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        doacoes: Sequence[doacao_fake.DoacaoFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} pagamentos Mecanismo Plataforma...")

        # Lista para armazenar os dados
        mecanismo_plat: list[Self] = []

        # Geração de dados fictícios
        doacoes_selecionadas = random.sample(doacoes, quantidade)
        for i, doacao in enumerate(doacoes_selecionadas, start=1):
            mecanismo_plat.append(cls(*doacao.pk, doacao.nro_plataforma))

        return tuple(mecanismo_plat)
