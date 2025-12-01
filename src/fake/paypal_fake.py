"""--sql
CREATE TABLE public.paypal (
    nro_plataforma_fk_doacao integer NOT NULL,
    id_video_fk_doacao integer NOT NULL,
    seq_comentario_fk_doacao integer NOT NULL,    
    idpaypal text NOT NULL UNIQUE,
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
from typing import Any, ClassVar, Literal, Self, Tuple

import faker as fkr

from . import dado_fake, doacao_fake

T_status = Literal["recusado", "recebido", "lido"]


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class PaypalFake(dado_fake.DadoFake):
    _used: ClassVar[set] = set()  # evita duplicatas por execução

    CABECALHO: ClassVar[tuple[str, ...]] = (
        "nro_plataforma_fk_doacao",
        "id_video_fk_doacao",
        "seq_comentario_fk_doacao",
        "idpaypal",
    )

    nro_plataforma_fk_doacao: int
    id_video_fk_doacao: int
    seq_comentario_fk_doacao: int
    idpaypal: str

    T_pk = Tuple[int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma_fk_doacao, self.id_video_fk_doacao, self.seq_comentario_fk_doacao)

    T_dados = Tuple[int, int, int, str]

    @property
    def dados(self) -> T_dados:
        return (
            self.nro_plataforma_fk_doacao,
            self.id_video_fk_doacao,
            self.seq_comentario_fk_doacao,
            self.idpaypal,
        )

    @property
    def tupla(self) -> tuple[*T_dados]:
        return self.dados

    @classmethod
    def _gera_idpaypal(cls) -> str:
        for _ in range(10):
            v = "PAY-" + uuid.uuid4().hex[:12].upper()
            if v not in cls._used:
                cls._used.add(v)
                return v
        v = "PAY-" + uuid.uuid4().hex.upper()
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
        logging.info(f"Iniciando geração de {quantidade:_} pagamentos Paypal...")

        if quantidade <= 0:
            return tuple()

        if not doacoes:
            logging.warning("Nenhuma doação disponível para gerar pagamentos Paypal.")
            return tuple()

        if quantidade > len(doacoes):
            logging.warning("Quantidade solicitada maior que número de doações; limitando para evitar duplicatas.")
            quantidade = len(doacoes)

        selecionadas = random.sample(tuple(doacoes), k=quantidade)
        paypal_list: list[Self] = []

        for doacao in selecionadas:
            idpaypal = cls._gera_idpaypal()
            paypal_list.append(
                cls(
                    nro_plataforma_fk_doacao=doacao.nro_plataforma_fk_comentario,
                    id_video_fk_doacao=doacao.id_video_fk_comentario,
                    seq_comentario_fk_doacao=doacao.seq_comentario_fk,
                    idpaypal=idpaypal,
                )
            )

        return tuple(paypal_list)
