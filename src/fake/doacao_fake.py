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
    CABECALHO = ("id_doacao", "id_comentario", "valor", "status")
    VALOR_MINIMO: ClassVar[float] = 1.00
    VALOR_MAXIMO: ClassVar[float] = 1_000.00

    id_doacao: int
    id_comentario: int
    valor: float
    status: T_status

    T_pk = int
    T_dados = tuple[int, float, T_status]

    @property
    def pk(self) -> T_pk:
        return self.id_doacao

    @property
    def dados(self) -> T_dados:
        return (self.id_comentario, self.valor, self.status)

    @property
    def tupla(self) -> tuple[T_pk, *T_dados]:
        return (self.pk, *self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, comentarios: Sequence[comentario_fake.ComentarioFake], **kwargs: Any) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} doações...")

        assert len(comentarios) >= quantidade, "Quantidade de comentários insuficiente para gerar doações."
        # Lista para armazenar os dados
        doacoes: list[Self] = []

        # Geração de dados fictícios
        # Seleciona comentários aleatórios sem repetição
        comentarios_selecionados = random.sample(comentarios, quantidade)
        for i, comentario in enumerate(comentarios_selecionados, start=1):
            valor: float = round(random.uniform(cls.VALOR_MINIMO, cls.VALOR_MAXIMO), 2)
            status: T_status = random.choice(["recusado", "recebido", "lido"])

            # Cria a instância e adiciona à lista
            doacoes.append(cls(id_doacao=i, id_comentario=comentario.id_comentario, valor=valor, status=status))

        return tuple(doacoes)
