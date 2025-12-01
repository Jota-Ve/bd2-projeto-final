"""--sql
CREATE TABLE public.cartao_credito (
    nro_cartao text NOT NULL,
    bandeira text NOT NULL,
    datah timestamp without time zone NOT NULL,
    nro_plataforma_fk_doacao integer NOT NULL,
    id_video_fk_doacao integer NOT NULL,
    seq_comentario_fk_doacao integer NOT NULL,
    PRIMARY KEY (nro_plataforma_fk_doacao, id_video_fk_doacao, seq_comentario_fk_doacao),
    FOREIGN KEY (nro_plataforma_fk_doacao, id_video_fk_doacao, seq_comentario_fk_doacao)
      REFERENCES public.doacao(nro_plataforma_fk_comentario, id_video_fk_comentario, seq_comentario_fk) ON UPDATE CASCADE ON DELETE CASCADE
);
"""

import dataclasses
import datetime
import logging
import random
from collections.abc import Sequence
from typing import Any, Self, Tuple

import faker as fkr

from . import dado_fake, doacao_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class CartaoCreditoFake(dado_fake.DadoFake):
    CABECALHO = (
        "nro_cartao",
        "bandeira",
        "datah",
        "nro_plataforma_fk_doacao",
        "id_video_fk_doacao",
        "seq_comentario_fk_doacao",
    )

    nro_cartao: str
    bandeira: str
    datah: datetime.datetime
    nro_plataforma_fk_doacao: int
    id_video_fk_doacao: int
    seq_comentario_fk_doacao: int

    T_pk = Tuple[int, int, int]
    T_dados = Tuple[str, str, datetime.datetime, int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma_fk_doacao, self.id_video_fk_doacao, self.seq_comentario_fk_doacao)

    @property
    def dados(self) -> T_dados:
        return (
            self.nro_cartao,
            self.bandeira,
            self.datah,
            self.nro_plataforma_fk_doacao,
            self.id_video_fk_doacao,
            self.seq_comentario_fk_doacao,
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
        logging.info(f"Iniciando geração de {quantidade:_} pagamentos Cartão de Crédito...")

        if quantidade <= 0:
            return tuple()

        if not doacoes:
            logging.warning("Nenhuma doação disponível para gerar pagamentos.")
            return tuple()

        # evitar duplicatas; limitar se pedido > disponível
        if quantidade > len(doacoes):
            logging.warning(
                "Quantidade solicitada maior que número de doações disponíveis; limitando para evitar duplicatas."
            )
            quantidade = len(doacoes)

        selecionadas = random.sample(tuple(doacoes), k=quantidade)
        cartoes: list[Self] = []

        for doacao in selecionadas:
            nro_cartao: str = faker.credit_card_number()
            bandeira: str = faker.credit_card_provider()
            datah = faker.date_time()
            cartoes.append(
                cls(
                    nro_cartao=nro_cartao,
                    bandeira=bandeira,
                    datah=datah,
                    nro_plataforma_fk_doacao=doacao.nro_plataforma_fk_comentario,
                    id_video_fk_doacao=doacao.id_video_fk_comentario,
                    seq_comentario_fk_doacao=doacao.seq_comentario_fk,
                )
            )

        return tuple(cartoes)
