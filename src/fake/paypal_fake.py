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
import uuid
from collections.abc import Sequence
from typing import Any, Literal, Self

import faker as fkr

from . import dado_fake, doacao_fake

T_status = Literal["recusado", "recebido", "lido"]


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class PaypalFake(dado_fake.DadoFake):
    _used = set()  # evita duplicatas por execução

    CABECALHO = ("id_doacao_fk", "idpaypal")
    id_doacao_fk: int
    idpaypal: str

    T_pk = int

    @property
    def pk(self) -> T_pk:
        return self.id_doacao_fk

    T_dados = str

    @property
    def dados(self) -> T_dados:
        return self.idpaypal

    @property
    def tupla(self) -> tuple[int, str]:
        return (self.id_doacao_fk, self.idpaypal)

    def gera_idpaypal(self):
        # usa uuid curto para garantir unicidade
        for _ in range(10):
            v = "PAY-" + uuid.uuid4().hex[:8].upper()
            if v not in self.__class__._used:
                self.__class__._used.add(v)
                return v
        # fallback
        v = "PAY-" + uuid.uuid4().hex.upper()
        self.__class__._used.add(v)
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

        # Lista para armazenar os dados
        paypal: list[Self] = []

        # Geração de dados fictícios
        doacoes_selecionadas = random.sample(doacoes, quantidade)
        for doacao in doacoes_selecionadas:
            idpaypal: str = cls.gera_idpaypal()
            paypal.append(cls(doacao.id_doacao, idpaypal))

        return tuple(paypal)
