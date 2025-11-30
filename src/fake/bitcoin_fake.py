"""--sql
CREATE TABLE public.bitcoin (
	nro_plataforma serial4 NOT NULL,
	nome_canal text NOT NULL,
	titulo_video text NOT NULL,
	datah_video timestamp NOT NULL,
	nick_usuario text NOT NULL,
	seq_comentario serial4 NOT NULL,
	seq_doacao serial4 NOT NULL,
	txid text NOT NULL,
	CONSTRAINT bitcoin_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao),
	CONSTRAINT bitcoin_txid_key UNIQUE (txid),
	CONSTRAINT fk_bitcoin_doacao FOREIGN KEY (nro_plataforma,nome_canal,titulo_video,datah_video,nick_usuario,seq_comentario,seq_doacao)
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
class BitcoinFake(dado_fake.DadoFake):
    CABECALHO = ("id_doacao_fk", "txid")

    id_doacao_fk: int
    txid: str

    T_pk = tuple[int]  

    @property
    def pk(self) -> T_pk:
        return (self.id_doacao_fk,)

    T_dados = str

    @property
    def dados(self) -> T_dados:
        return self.txid

    @property
    def tupla(self) -> tuple[int, str]:
        return (self.id_doacao_fk, self.txid)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        doacoes: Sequence[doacao_fake.DoacaoFake],  # cada doacao deve ter id_doacao atribuído
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} pagamentos Bitcoin...")

        # Lista para armazenar os dados
        bitcoins: list[Self] = []

        # Geração de dados fictícios
        doacoes_selecionadas = random.sample(doacoes, quantidade)
        for doacao in doacoes_selecionadas:
            txid: str = faker.sha256()
            bitcoins.append(cls(doacao.id_doacao, txid))
        return tuple(bitcoins)
