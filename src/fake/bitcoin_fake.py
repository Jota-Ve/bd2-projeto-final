"""--sql
CREATE TABLE public.bitcoin (
    txid text NOT NULL UNIQUE,
    nro_plataforma_fk_doacao integer NOT NULL,
    id_video_fk_doacao integer NOT NULL,
    seq_comentario_fk_doacao integer NOT NULL,    
    PRIMARY KEY (nro_plataforma_fk_doacao, id_video_fk_doacao, seq_comentario_fk_doacao),
    FOREIGN KEY (nro_plataforma_fk_doacao, id_video_fk_doacao, seq_comentario_fk_doacao)
      REFERENCES public.doacao(nro_plataforma_fk_comentario, id_video_fk_comentario, seq_comentario_fk) ON UPDATE CASCADE ON DELETE CASCADE
);
"""

import dataclasses
import logging
import random
import uuid
from collections.abc import Sequence
from typing import Any, ClassVar, Self, Tuple

import faker as fkr

from . import dado_fake, doacao_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class BitcoinFake(dado_fake.DadoFake):
    _used: ClassVar[set] = set()

    CABECALHO: ClassVar[tuple[str, ...]] = (
        "txid",
        "nro_plataforma_fk_doacao",
        "id_video_fk_doacao",
        "seq_comentario_fk_doacao",
    )

    txid: str
    nro_plataforma_fk_doacao: int
    id_video_fk_doacao: int
    seq_comentario_fk_doacao: int

    T_pk = Tuple[int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma_fk_doacao, self.id_video_fk_doacao, self.seq_comentario_fk_doacao)

    T_dados = Tuple[str, int, int, int]

    @property
    def dados(self) -> T_dados:
        return (
            self.txid,
            self.nro_plataforma_fk_doacao,
            self.id_video_fk_doacao,
            self.seq_comentario_fk_doacao,
        )

    @property
    def tupla(self) -> tuple[*T_dados]:
        return self.dados

    @classmethod
    def _gera_txid(cls) -> str:
        for _ in range(10):
            v = uuid.uuid4().hex.upper()
            if v not in cls._used:
                cls._used.add(v)
                return v
        v = uuid.uuid4().hex.upper()
        cls._used.add(v)
        return v

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        doacoes: Sequence[doacao_fake.DoacaoFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} pagamentos Bitcoin...")

        if quantidade <= 0:
            return tuple()

        if not doacoes:
            logging.warning("Nenhuma doação disponível para gerar pagamentos Bitcoin.")
            return tuple()

        if quantidade > len(doacoes):
            logging.warning("Quantidade solicitada maior que número de doações; limitando para evitar duplicatas.")
            quantidade = len(doacoes)

        selecionadas = random.sample(tuple(doacoes), k=quantidade)
        bitcoins: list[Self] = []

        for doacao in selecionadas:
            txid = cls._gera_txid()
            bitcoins.append(
                cls(
                    txid=txid,
                    nro_plataforma_fk_doacao=doacao.nro_plataforma_fk_comentario,
                    id_video_fk_doacao=doacao.id_video_fk_comentario,
                    seq_comentario_fk_doacao=doacao.seq_comentario_fk,
                )
            )

        return tuple(bitcoins)
