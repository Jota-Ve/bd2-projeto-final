"""--sql
CREATE TABLE public.doacao (
        nro_plataforma serial4 NOT NULL,
        nome_canal text NOT NULL,
        titulo_video text NOT NULL,
        datah_video timestamp NOT NULL,
        nick_usuario text NOT NULL,
        seq_comentario serial4 NOT NULL,
        seq_pg serial4 NOT NULL,
        valor numeric(18, 2) NOT NULL,
        status public."statusdoacao" NOT NULL,
        CONSTRAINT doacao_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg),
        CONSTRAINT doacao_valor_check CHECK ((valor > (0)::numeric)),
        CONSTRAINT fk_doacao_comentario FOREIGN KEY (nro_plataforma,nome_canal,titulo_video,datah_video,nick_usuario,seq_comentario)
        REFERENCES public.comentario(nro_plataforma,nome_canal,titulo_video,datah_video,nick_usuario,seq) ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import datetime
import logging
import random
from collections.abc import Sequence
from typing import Any, ClassVar, Literal, Self

import faker as fkr

from . import comentario_fake, dado_fake

T_status = Literal["recusado", "recebido", "lido"]


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class DoacaoFake(dado_fake.DadoFake):
    CABECALHO = ("id_doacao", "id_comentario_fk", "seq_doacao", "valor", "status")
    VALOR_MINIMO: ClassVar[float] = 1.00
    VALOR_MAXIMO: ClassVar[float] = 1_000.00

    id_doacao: int
    id_comentario_fk: int
    seq_doacao: int
    valor: float
    status: Literal["recusado", "recebido", "lido"]

    T_pk = int

    @property
    def pk(self) -> T_pk:
        return self.id_doacao

    T_dados = tuple[int, int, float, str]

    @property
    def dados(self) -> T_dados:
        return (self.id_comentario_fk, self.seq_doacao, self.valor, self.status)

    @property
    def tupla(self) -> tuple[int, *T_dados]:
        return (self.id_doacao, *self.dados)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        comentarios: Sequence[comentario_fake.ComentarioFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} doações...")

        # Lista para armazenar os dados
        doacoes: list[Self] = []

        # Dicionário para controlar sequencial por comentário
        # id_comentario -> ultimo_seq
        seq_por_comentario: dict[int, int] = {}

        # Sequencial global para id_doacao
        next_id_doacao = 1

        # Geração de dados fictícios
        for _ in range(quantidade):
            comentario = random.choice(comentarios)

            # Incrementa sequencial da doação
            chave_comentario = comentario.id_comentario
            novo_seq = seq_por_comentario.get(chave_comentario, 0) + 1
            seq_por_comentario[chave_comentario] = novo_seq

            valor: float = round(random.uniform(1.0, 500.0), 2)
            status = random.choice(["recusado", "recebido", "lido"])

            # Cria a instância e adiciona à lista
            doacoes.append(cls(next_id_doacao, comentario.id_comentario, novo_seq, valor, status))
            next_id_doacao += 1

        return tuple(doacoes)
