"""--sql
CREATE TABLE public.mecanismo_plat (
	nro_plataforma serial4 NOT NULL,
	nome_canal text NOT NULL,
	titulo_video text NOT NULL,
	datah_video timestamp NOT NULL,
	nick_usuario text NOT NULL,
	seq_comentario serial4 NOT NULL,
	seq_doacao serial4 NOT NULL,
	seq serial4 NOT NULL,
	CONSTRAINT mecanismo_plat_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao),
	CONSTRAINT fk_mecanismo_doacao FOREIGN KEY (nro_plataforma,nome_canal,titulo_video,datah_video,nick_usuario,seq_comentario,seq_doacao)
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
class MecanismoPlatFake(dado_fake.DadoFake):
    CABECALHO = ("id_doacao", "seq_plataforma")

    id_doacao: int
    seq_plataforma: int

    T_pk = int
    T_dados = int

    @property
    def pk(self) -> T_pk:
        return self.id_doacao

    @property
    def dados(self) -> T_dados:
        return self.seq_plataforma

    @property
    def tupla(self) -> tuple[T_pk, T_dados]:
        return (self.pk, self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, doacoes: Sequence[doacao_fake.DoacaoFake], **kwargs: Any) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} pagamentos por Mecanismo da Plataforma...")

        assert len(doacoes) >= quantidade, "Quantidade de doações insuficiente para gerar pagamentos Mecanismo da Plataforma."
        # Lista para armazenar os dados
        mecanismo_plat: list[Self] = []

        # Geração de dados fictícios
        for doacao in random.sample(doacoes, quantidade):
            seq = 1

            # Cria a instância e adiciona à lista
            mecanismo_plat.append(cls(doacao.pk, seq_plataforma=seq))

        return tuple(mecanismo_plat)
