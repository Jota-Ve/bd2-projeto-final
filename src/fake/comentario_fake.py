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
    CABECALHO = ("nro_plataforma", "nome_canal", "titulo_video", "datah_video", "nick_usuario", "seq", "texto", "datah", "online")
    TAMANHO_TEXTO_MINIMO: ClassVar[int] = 10
    TAMANHO_TEXTO_MAXIMO: ClassVar[int] = 5_000

    nro_plataforma: int
    nome_canal: str
    titulo_video: str
    datah_video: datetime.datetime
    nick_usuario: str
    seq: int
    texto: str
    datah: datetime.datetime
    online: bool

    T_pk = tuple[int, str, str, datetime.datetime, str, int]
    T_dados = tuple[str, datetime.datetime, bool]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.nome_canal, self.titulo_video, self.datah_video, self.nick_usuario, self.seq)

    @property
    def dados(self) -> T_dados:
        return (self.texto, self.datah, self.online)

    @property
    def tupla(self) -> tuple[*T_pk, *T_dados]:
        return (*self.pk, *self.dados)

    @classmethod
    def gera(
        cls, quantidade: int, faker: fkr.Faker, *args: Any, videos: Sequence[video_fake.VideoFake], usuarios: Sequence[usuario_fake.UsuarioFake], **kwargs: Any
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} comentários...")

        # Lista para armazenar os dados
        comentarios: list[Self] = []

        # Geração de dados fictícios
        videos_slecionados: list[video_fake.VideoFake] = random.choices(videos, k=quantidade)
        usuarios_slecionados: list[usuario_fake.UsuarioFake] = random.choices(usuarios, k=quantidade)
        # Contador de comentários por vídeo e usuário para definir a sequência
        videos_e_usuarios: dict[tuple[video_fake.VideoFake, usuario_fake.UsuarioFake], int] = {}

        # Faixas de tamanho (em caracteres)
        faixas = (
            (10, 50),     # muito curto
            (51, 200),    # curto
            (201, 600),   # médio
            (601, 1000),  # longo
            (1001, 5000)  # muito longo
        )

        # Pesos para cada faixa — ajustados para refletir frequência real
        pesos = (35, 50, 10, 4, 1)

        # Escolhe uma faixa com base nos pesos
        faixas_escolhidas = random.choices(faixas, weights=pesos, k=quantidade)

        for video, usuario, faixa_escolhida in zip(videos_slecionados, usuarios_slecionados, faixas_escolhidas, strict=False):
            # Define a chave e atualiza o contador
            chave = (video, usuario)
            videos_e_usuarios[chave] = videos_e_usuarios.setdefault(chave, 0) + 1

            seq: int = videos_e_usuarios[chave]
            # Escolhe um tamanho dentro da faixa
            texto: str = faker.text(max_nb_chars=random.randint(*faixa_escolhida))
            datah: datetime.datetime = faker.date_time_between(start_date=video.datah, end_date="now")
            online: bool = faker.boolean(chance_of_getting_true=20)

            # Cria a instância e adiciona à lista
            comentarios.append(cls(*video.pk, nick_usuario=usuario.pk, seq=seq, texto=texto, datah=datah, online=online))

        return tuple(comentarios)
