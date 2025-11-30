"""--sql
CREATE TABLE public.cartao_credito (
	nro_plataforma serial4 NOT NULL,
	nome_canal text NOT NULL,
	titulo_video text NOT NULL,
	datah_video timestamp NOT NULL,
	nick_usuario text NOT NULL,
	seq_comentario serial4 NOT NULL,
	seq_doacao serial4 NOT NULL,
	nro_cartao text NOT NULL,
	bandeira text NOT NULL,
	CONSTRAINT paypal_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao),
	CONSTRAINT fk_paypal_doacao FOREIGN KEY (nro_plataforma,nome_canal,titulo_video,datah_video,nick_usuario,seq_comentario,seq_doacao)
        REFERENCES public.doacao(nro_plataforma,nome_canal,titulo_video,datah_video,nick_usuario,seq_comentario,seq_pg) ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import datetime
import logging
import random
from collections.abc import Sequence
from typing import Any, Self

import faker as fkr

from . import dado_fake, doacao_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class CartaoCreditoFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_video", "seq_comentario", "seq_doacao", "nro_cartao", "bandeira")
    nro_plataforma: int
    id_video: int
    seq_comentario: int
    seq_doacao: int
    nro_cartao: str
    bandeira: str

    T_pk = tuple[int, int, int, int]
    T_dados = tuple[str, str]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_video, self.seq_comentario, self.seq_doacao)

    @property
    def dados(self) -> T_dados:
        return (self.nro_cartao, self.bandeira)

    @property
    def tupla(self) -> tuple[int, int, int, int, str, str]:
        return (self.nro_plataforma, self.id_video, self.seq_comentario, self.seq_doacao, self.nro_cartao, self.bandeira)

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

        # Lista para armazenar os dados
        cartoes: list[Self] = []

        # Geração de dados fictícios
        doacoes_selecionadas = random.sample(doacoes, quantidade)
        for doacao in doacoes_selecionadas:
            nro_cartao: str = faker.credit_card_number()
            bandeira: str = faker.credit_card_provider()
            cartoes.append(cls(doacao.nro_plataforma, doacao.id_video, doacao.seq_comentario, doacao.seq_doacao, nro_cartao, bandeira))

        return tuple(cartoes)
