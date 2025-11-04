"""--sql
CREATE TABLE public.participa (
	nro_plataforma serial4 NOT NULL,
	nome_canal text NOT NULL,
	titulo_video text NOT NULL,
	datah_video timestamp NOT NULL,
	nick_streamer text NOT NULL,
	CONSTRAINT participa_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_streamer),
	CONSTRAINT fk_participa_streamer FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_participa_video FOREIGN KEY (nro_plataforma,nome_canal,titulo_video,datah_video)
        REFERENCES public.video(nro_plataforma,nome_canal,titulo,datah) ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import datetime
import logging
from collections.abc import Sequence
from typing import Any, ClassVar, Self

import faker as fkr

from src.fake import combinacoes

from . import dado_fake, usuario_fake, video_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class ParticipaFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "nome_canal", "titulo_video", "datah_video", "nick_streamer")
    TAMANHO_TEXTO_MINIMO: ClassVar[int] = 10
    TAMANHO_TEXTO_MAXIMO: ClassVar[int] = 1_000

    nro_plataforma: int
    nome_canal: str
    titulo_video: str
    datah_video: datetime.datetime
    nick_streamer: str

    T_pk = tuple[int, str, str, datetime.datetime, str]
    T_dados = tuple[()]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.nome_canal, self.titulo_video, self.datah_video, self.nick_streamer)

    @property
    def dados(self) -> T_dados:
        return ()

    @property
    def tupla(self) -> tuple[*T_pk, *T_dados]:
        return (*self.pk, *self.dados)

    @classmethod
    def gera(
        cls, quantidade: int, faker: fkr.Faker, *args: Any, videos: Sequence[video_fake.VideoFake], streamers: Sequence[usuario_fake.UsuarioFake], **kwargs: Any
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} Participacoes...")

        total = len(videos) * len(streamers)
        n = len(streamers)
        # Lista para armazenar os dados
        participacoes: list[Self] = []

        videos_streamers = combinacoes.combina(videos, streamers, quantidade)

        for video, streamer in videos_streamers:
            # Cria a instância e adiciona à lista
            participacoes.append(cls(*video.pk, nick_streamer=streamer.pk))

        return tuple(participacoes)
