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
import random
from collections.abc import Sequence
from typing import Any, ClassVar, Self

import faker as fkr

from src.fake import combinacoes

from . import dado_fake, usuario_fake, video_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class ParticipaFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_video_fk", "id_streamer_fk")
    TAMANHO_TEXTO_MINIMO: ClassVar[int] = 10
    TAMANHO_TEXTO_MAXIMO: ClassVar[int] = 1_000

    nro_plataforma: int
    id_video_fk: int
    id_streamer_fk: int

    T_pk = tuple[int, int, int]
    T_dados = tuple[()]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_video_fk, self.id_streamer_fk)

    @property
    def dados(self) -> T_dados:
        return ()

    @property
    def tupla(self) -> tuple[int, int, int]:
        return (self.nro_plataforma, self.id_video_fk, self.id_streamer_fk)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        videos: Sequence[video_fake.VideoFake],
        streamers: Sequence[usuario_fake.UsuarioFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} participações...")
        max_combs = len(videos) * len(streamers)
        if quantidade > max_combs:
            logging.warning("Quantidade solicitada maior que combinações possíveis; limitando para evitar duplicatas.")
            quantidade = max_combs

        participacoes: list[Self] = []
        chosen: set[tuple[int, int]] = set()

        # Espaço pequeno: gerar todas combinações e sample sem repetição
        if max_combs <= 2_000_000:
            all_pairs = [(i, j) for i in range(len(videos)) for j in range(len(streamers))]
            sampled = random.sample(all_pairs, k=quantidade)
            for i, j in sampled:
                v = videos[i]
                s = streamers[j]
                streamer_id = getattr(s, "nro_usuario", None) or getattr(s, "id_usuario_fk", None) or getattr(s, "id_usuario", None)
                if streamer_id is None:
                    raise AttributeError("Objeto streamer não possui nro_usuario/id_usuario_fk/id_usuario")
                participacoes.append(cls(v.nro_plataforma, v.id_video, streamer_id))
            return tuple(participacoes)

        # Espaço grande: rejeição com limite de tentativas, depois fallback determinístico
        attempts = 0
        max_attempts = max(quantidade * 10, 100_000)
        while len(chosen) < quantidade and attempts < max_attempts:
            i = random.randrange(len(videos))
            j = random.randrange(len(streamers))
            if (i, j) not in chosen:
                chosen.add((i, j))
            attempts += 1

        if len(chosen) < quantidade:
            logging.warning("Não conseguiu amostrar sem colisões; completando deterministicamente.")
            for i in range(len(videos)):
                for j in range(len(streamers)):
                    if (i, j) not in chosen:
                        chosen.add((i, j))
                        if len(chosen) >= quantidade:
                            break
                if len(chosen) >= quantidade:
                    break

        for i, j in chosen:
            v = videos[i]
            s = streamers[j]
            streamer_id = getattr(s, "nro_usuario", None) or getattr(s, "id_usuario_fk", None) or getattr(s, "id_usuario", None)
            if streamer_id is None:
                raise AttributeError("Objeto streamer não possui nro_usuario/id_usuario_fk/id_usuario")
            participacoes.append(cls(v.nro_plataforma, v.id_video_fk, streamer_id))

        return tuple(participacoes)
