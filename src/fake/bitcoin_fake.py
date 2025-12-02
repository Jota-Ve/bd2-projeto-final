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
import logging
import random
from collections.abc import Sequence
from typing import Any, Self

import faker as fkr

from . import dado_fake, doacao_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class BitcoinFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_video", "seq_comentario", "seq_doacao", "txid")
    nro_plataforma: int
    id_video: int
    seq_comentario: int
    seq_doacao: int
    txid: str

    T_pk = tuple[int, int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_video, self.seq_comentario, self.seq_doacao)

    T_dados = str

    @property
    def dados(self) -> T_dados:
        return self.txid

    @property
    def tupla(self) -> tuple[int, int, int, int, str]:
        return (self.nro_plataforma, self.id_video, self.seq_comentario, self.seq_doacao, self.txid)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        doacoes: Sequence[doacao_fake.DoacaoFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} pagamentos Bitcoin...")

        # Lista para armazenar os dados
        bitcoins: list[Self] = []

        # Geração de dados fictícios
        doacoes_selecionadas = random.sample(doacoes, quantidade)
        for doacao in doacoes_selecionadas:
            txid: str = faker.sha256()
            bitcoins.append(cls(doacao.nro_plataforma, doacao.id_video, doacao.seq_comentario, doacao.seq_doacao, txid))

        return tuple(bitcoins)
