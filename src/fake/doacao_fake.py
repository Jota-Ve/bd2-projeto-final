"""--sql
CREATE TABLE public.doacao (
    nro_plataforma_fk_comentario integer NOT NULL,
    id_video_fk_comentario integer NOT NULL,
    seq_comentario_fk integer NOT NULL,
    valor numeric(18,2) NOT NULL CHECK (valor > 0),
    status public.statusdoacao NOT NULL,
    PRIMARY KEY (nro_plataforma_fk_comentario, id_video_fk_comentario, seq_comentario_fk),
    FOREIGN KEY (nro_plataforma_fk_comentario, id_video_fk_comentario, seq_comentario_fk)
      REFERENCES public.comentario(nro_plataforma_fk, id_video_fk, seq_comentario) ON UPDATE CASCADE ON DELETE CASCADE
);
"""
import dataclasses
import logging
import random
from typing import Any, ClassVar, Literal, Self, Tuple
from collections.abc import Sequence

import faker as fkr

from . import comentario_fake, dado_fake

T_status = Literal["recusado", "recebido", "lido"]


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class DoacaoFake(dado_fake.DadoFake):
    CABECALHO: ClassVar[tuple[str, ...]] = (
        "nro_plataforma_fk_comentario",
        "id_video_fk_comentario",
        "seq_comentario_fk",
        "valor",
        "status",
    )
    VALOR_MINIMO: ClassVar[float] = 1.00
    VALOR_MAXIMO: ClassVar[float] = 1000.00

    nro_plataforma_fk_comentario: int
    id_video_fk_comentario: int
    seq_comentario_fk: int
    valor: float
    status: T_status

    T_pk = Tuple[int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma_fk_comentario, self.id_video_fk_comentario, self.seq_comentario_fk)

    T_dados = tuple[int, int, int, float, str]

    @property
    def dados(self) -> T_dados:
        return (
            self.nro_plataforma_fk_comentario,
            self.id_video_fk_comentario,
            self.seq_comentario_fk,
            self.valor,
            self.status,
        )

    @property
    def tupla(self) -> tuple[*T_dados]:
        return self.dados

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

        if quantidade <= 0:
            return tuple()

        if not comentarios:
            logging.warning("Nenhum comentário disponível para gerar doações.")
            return tuple()

        # Não permitimos mais de 1 doação por comentário (PK doacao = comentário scope).
        if quantidade > len(comentarios):
            logging.warning(
                "Quantidade solicitada maior que número de comentários; limitando para evitar duplicatas."
            )
            quantidade = len(comentarios)

        selecionados = random.sample(tuple(comentarios), k=quantidade)
        doacoes: list[Self] = []

        for comentario in selecionados:
            nro_plataforma, id_video, seq_comentario = comentario.pk
            valor = round(random.uniform(cls.VALOR_MINIMO, cls.VALOR_MAXIMO), 2)
            status = random.choice(["recusado", "recebido", "lido"])

            doacoes.append(
                cls(
                    nro_plataforma_fk_comentario=nro_plataforma,
                    id_video_fk_comentario=id_video,
                    seq_comentario_fk=seq_comentario,
                    valor=valor,
                    status=status,
                )
            )

        return tuple(doacoes)
