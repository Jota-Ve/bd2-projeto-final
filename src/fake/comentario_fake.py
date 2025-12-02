"""--sql
CREATE TABLE public.comentario (
        nro_plataforma serial4 NOT NULL,
        nome_canal text NOT NULL,
        titulo_video text NOT NULL,
        datah_video timestamp NOT NULL,
        nick_usuario text NOT NULL,
        seq serial4 NOT NULL,
        texto text NOT NULL,
        datah timestamp DEFAULT CURRENT_TIMESTAMP NULL,
        online bool NOT NULL,
        CONSTRAINT comentario_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq),
        CONSTRAINT fk_comentario_usuario FOREIGN KEY (nick_usuario) REFERENCES public.usuario(nick) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_comentario_video FOREIGN KEY (nro_plataforma,nome_canal,titulo_video,datah_video)
            REFERENCES public.video(nro_plataforma,nome_canal,titulo,datah) ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import datetime
import logging
import random
from collections.abc import Sequence
from typing import Any, ClassVar, Self

import faker as fkr

from . import dado_fake, usuario_fake, video_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class ComentarioFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_video", "seq_comentario", "nick_usuario", "texto", "datah", "online")
    TAMANHO_TEXTO_MINIMO: ClassVar[int] = 10
    TAMANHO_TEXTO_MAXIMO: ClassVar[int] = 1_000

    nro_plataforma: int
    id_video: int
    seq_comentario: int
    nick_usuario: str
    texto: str
    datah: datetime.datetime
    online: bool

    T_pk = tuple[int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_video, self.seq_comentario)

    T_dados = tuple[str, str, datetime.datetime, bool]

    @property
    def dados(self) -> T_dados:
        return (self.nick_usuario, self.texto, self.datah, self.online)

    @property
    def tupla(self) -> tuple[int, int, int, str, str, datetime.datetime, bool]:
        return (self.nro_plataforma, self.id_video, self.seq_comentario, self.nick_usuario, self.texto, self.datah, self.online)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        videos: Sequence[video_fake.VideoFake],
        usuarios: Sequence[usuario_fake.UsuarioFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} comentários...")

        # Lista para armazenar os dados
        comentarios: list[Self] = []

        # Dicionário para controlar sequencial por vídeo
        # (nro_plataforma, id_video) -> ultimo_seq
        seq_por_video: dict[tuple[int, int], int] = {}

        # Geração de dados fictícios
        for _ in range(quantidade):
            video = random.choice(videos)
            usuario = random.choice(usuarios)

            # Incrementa sequencial do vídeo
            chave_video = (video.nro_plataforma, video.id_video)
            novo_seq = seq_por_video.get(chave_video, 0) + 1
            seq_por_video[chave_video] = novo_seq

            texto: str = faker.text(max_nb_chars=random.randint(cls.TAMANHO_TEXTO_MINIMO, cls.TAMANHO_TEXTO_MAXIMO)).replace("\n", " ")
            datah: datetime.datetime = faker.date_time_between(start_date=video.datah)
            online: bool = random.choice([True, False])

            # Cria a instância e adiciona à lista
            comentarios.append(cls(video.nro_plataforma, video.id_video, novo_seq, usuario.pk, texto, datah, online))

        return tuple(comentarios)
