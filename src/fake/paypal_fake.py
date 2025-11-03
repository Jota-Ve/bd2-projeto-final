"""--sql
CREATE TABLE public.paypal (
	nro_plataforma serial4 NOT NULL,
	nome_canal text NOT NULL,
	titulo_video text NOT NULL,
	datah_video timestamp NOT NULL,
	nick_usuario text NOT NULL,
	seq_comentario serial4 NOT NULL,
	seq_doacao serial4 NOT NULL,
	idpaypal text NOT NULL,
	CONSTRAINT paypal_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao),
	CONSTRAINT paypal_idpaypal_key UNIQUE (idpaypal),
	CONSTRAINT fk_paypal_doacao FOREIGN KEY (nro_plataforma,nome_canal,titulo_video,datah_video,nick_usuario,seq_comentario,seq_doacao)
        REFERENCES public.doacao(nro_plataforma,nome_canal,titulo_video,datah_video,nick_usuario,seq_comentario,seq_pg) ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import datetime
import logging
import random
import string
from collections.abc import Sequence
from typing import Any, Literal, Self

import faker as fkr

from . import dado_fake, doacao_fake

T_status = Literal["recusado", "recebido", "lido"]


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class PaypalFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "nome_canal", "titulo_video", "datah_video", "nick_usuario", "seq_comentario", "seq_doacao", "idpaypal")

    nro_plataforma: int
    nome_canal: str
    titulo_video: str
    datah_video: datetime.datetime
    nick_usuario: str
    seq_comentario: int
    seq_doacao: int
    id_paypal: str

    T_pk = tuple[int, str, str, datetime.datetime, str, int, int]
    T_dados = str

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.nome_canal, self.titulo_video, self.datah_video, self.nick_usuario, self.seq_comentario, self.seq_doacao)

    @property
    def dados(self) -> T_dados:
        return self.id_paypal

    @property
    def tupla(self) -> tuple[*T_pk, T_dados]:
        return (*self.pk, self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, doacoes: Sequence[doacao_fake.DoacaoFake], **kwargs: Any) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} pagamentos PayPal...")

        assert len(doacoes) >= quantidade, "Quantidade de doações insuficiente para gerar pagamentos Paypal."
        # Lista para armazenar os dados
        paypal: list[Self] = []

        # Geração de dados fictícios
        for doacao in random.sample(doacoes, quantidade):
            id_paypal: str = ''.join(random.choices(string.ascii_uppercase + string.digits, k=17))  # Gera um id_paypal fictício de 17 caracteres alfanuméricos

            # Cria a instância e adiciona à lista
            paypal.append(cls(*doacao.pk, id_paypal=id_paypal))

        return tuple(paypal)
