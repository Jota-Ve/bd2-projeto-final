

import dataclasses
import logging
import random
from collections.abc import Sequence
from typing import Any, ClassVar, Literal, Self

import faker as fkr

from . import comentario_fake, dado_fake

T_status = Literal["recusado", "recebido", "lido"]


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class DoacaoFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_video", "seq_comentario", "valor", "status")
    VALOR_MINIMO: ClassVar[float] = 1.00
    VALOR_MAXIMO: ClassVar[float] = 1_000.00
    nro_plataforma: int
    id_video: int
    seq_comentario: int
    valor: float
    status: Literal["recusado", "recebido", "lido"]

    T_pk = tuple[int, int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_video, self.seq_comentario)

    T_dados = tuple[float, str]

    @property
    def dados(self) -> T_dados:
        return (self.valor, self.status)

    @property
    def tupla(self) -> tuple[int, int, int, int, float, str]:
        return (*self.pk, *self.dados)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        comentarios: Sequence[comentario_fake.ComentarioFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} doações...")

        # Lista para armazenar os dados
        doacoes: list[Self] = []

        # Dicionário para controlar sequencial por comentário
        # (nro_plataforma, id_video, seq_comentario) -> ultimo_seq
        seq_por_comentario: dict[tuple[int, int, int], int] = {}

        # Geração de dados fictícios
        for comentario in random.sample(comentarios, k=quantidade):
            # Incrementa sequencial da doação
            chave_comentario = (comentario.nro_plataforma, comentario.id_video, comentario.seq_comentario)
            novo_seq = seq_por_comentario.get(chave_comentario, 0) + 1
            seq_por_comentario[chave_comentario] = novo_seq

            valor: float = round(random.uniform(1.0, 500.0), 2)
            status = random.choice(["recusado", "recebido", "lido"])

            # Cria a instância e adiciona à lista
            doacoes.append(cls(*comentario.pk, valor, status))

        return tuple(doacoes)
