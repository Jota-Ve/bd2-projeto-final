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
    CABECALHO = ("nro_plataforma", "nome_canal", "titulo_video", "datah_video", "nick_usuario", "seq_comentario", "seq_doacao", "nro_cartao", "bandeira")

    nro_plataforma: int
    nome_canal: str
    titulo_video: str
    datah_video: datetime.datetime
    nick_usuario: str
    seq_comentario: int
    seq_doacao: int
    nro_cartao: str
    bandeira: str

    T_pk = tuple[int, str, str, datetime.datetime, str, int, int]
    T_dados = tuple[str, str]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.nome_canal, self.titulo_video, self.datah_video, self.nick_usuario, self.seq_comentario, self.seq_doacao)

    @property
    def dados(self) -> T_dados:
        return (self.nro_cartao, self.bandeira)

    @property
    def tupla(self) -> tuple[*T_pk, *T_dados]:
        return (*self.pk, *self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, doacoes: Sequence[doacao_fake.DoacaoFake], **kwargs: Any) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} pagamentos de Cartão de Crédito...")

        assert len(doacoes) >= quantidade, "Quantidade de doações insuficiente para gerar pagamentos Cartão de Crédito."
        # Lista para armazenar os dados
        cartao_credito: list[Self] = []

        # Geração de dados fictícios
        for doacao in random.sample(doacoes, quantidade):
            bandeira, _, nro_cartao_e_vencimento, _ = faker.credit_card_full().splitlines()
            nro_cartao: str   = nro_cartao_e_vencimento.split()[0]

            # Cria a instância e adiciona à lista
            cartao_credito.append(cls(*doacao.pk, nro_cartao=nro_cartao, bandeira=bandeira))

        return tuple(cartao_credito)
