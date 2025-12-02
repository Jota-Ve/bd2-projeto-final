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
import logging
import random
from collections.abc import Sequence
from typing import Any, Self

import faker as fkr

from . import dado_fake, doacao_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class MecanismoPlatFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_video", "seq_comentario", "seq_doacao", "seq_plataforma")
    nro_plataforma: int
    id_video: int
    seq_comentario: int
    seq_doacao: int
    seq_plataforma: int

    T_pk = tuple[int, int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_video, self.seq_comentario, self.seq_doacao)

    T_dados = int

    @property
    def dados(self) -> T_dados:
        return self.seq_plataforma

    @property
    def tupla(self) -> tuple[int, int, int, int, int]:
        return (self.nro_plataforma, self.id_video, self.seq_comentario, self.seq_doacao, self.seq_plataforma)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        doacoes: Sequence[doacao_fake.DoacaoFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} pagamentos Mecanismo Plataforma...")

        # Lista para armazenar os dados
        mecanismo_plat: list[Self] = []

        # Geração de dados fictícios
        doacoes_selecionadas = random.sample(doacoes, quantidade)
        for i, doacao in enumerate(doacoes_selecionadas, start=1):
            mecanismo_plat.append(cls(doacao.nro_plataforma, doacao.id_video, doacao.seq_comentario, doacao.seq_doacao, i))

        return tuple(mecanismo_plat)
