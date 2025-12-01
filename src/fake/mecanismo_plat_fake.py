"""--sql
CREATE TABLE public.mecanismo_plat (
    nro_plataforma_fk_doacao integer NOT NULL,
    id_video_fk_doacao integer NOT NULL,
    seq_comentario_fk_doacao integer NOT NULL,
    seq_plataforma integer NOT NULL,
    PRIMARY KEY (nro_plataforma_fk_doacao, id_video_fk_doacao, seq_comentario_fk_doacao, seq_plataforma),
    FOREIGN KEY (nro_plataforma_fk_doacao, id_video_fk_doacao, seq_comentario_fk_doacao)
      REFERENCES public.doacao(nro_plataforma_fk_comentario, id_video_fk_comentario, seq_comentario_fk) ON UPDATE CASCADE ON DELETE CASCADE
);
"""

import dataclasses
import logging
import random
from collections.abc import Sequence
from typing import Any, Self, Tuple

import faker as fkr

from . import dado_fake, doacao_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class MecanismoPlatFake(dado_fake.DadoFake):
    CABECALHO = (
        "nro_plataforma_fk_doacao",
        "id_video_fk_doacao",
        "seq_comentario_fk_doacao",
        "seq_plataforma",
    )

    nro_plataforma_fk_doacao: int
    id_video_fk_doacao: int
    seq_comentario_fk_doacao: int
    seq_plataforma: int

    T_pk = Tuple[int, int, int, int]

    @property
    def pk(self) -> T_pk:
        return (
            self.nro_plataforma_fk_doacao,
            self.id_video_fk_doacao,
            self.seq_comentario_fk_doacao,
            self.seq_plataforma,
        )

    T_dados = Tuple[int, int, int, int]

    @property
    def dados(self) -> T_dados:
        return (
            self.nro_plataforma_fk_doacao,
            self.id_video_fk_doacao,
            self.seq_comentario_fk_doacao,
            self.seq_plataforma,
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
        doacoes: Sequence[doacao_fake.DoacaoFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} mecanismos de plataforma...")

        if quantidade <= 0:
            return tuple()

        if not doacoes:
            logging.warning("Nenhuma doação disponível para gerar mecanismos.")
            return tuple()

        if quantidade > len(doacoes):
            logging.warning("Quantidade solicitada maior que número de doações; limitando para evitar duplicatas.")
            quantidade = len(doacoes)

        selecionadas = random.sample(tuple(doacoes), k=quantidade)
        mecanismos: list[Self] = []

        for i, doacao in enumerate(selecionadas, start=1):
            # seq_plataforma = 1 por doação (ajuste se quiser múltiplos mecanismos por mesma doação)
            seq_plataforma = 1
            mecanismos.append(
                cls(
                    nro_plataforma_fk_doacao=doacao.nro_plataforma_fk_comentario,
                    id_video_fk_doacao=doacao.id_video_fk_comentario,
                    seq_comentario_fk_doacao=doacao.seq_comentario_fk,
                    seq_plataforma=seq_plataforma,
                )
            )

        return tuple(mecanismos)
