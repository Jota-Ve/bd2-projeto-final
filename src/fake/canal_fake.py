"""--sql
CREATE TABLE canal (
        nro_plataforma serial4 NOT NULL,
        nome text NOT NULL,
        tipo public."tipocanal" NOT NULL,
        "data" date NOT NULL,
        descricao text NULL,
        qtd_visualizacoes int8 NULL,
        nick_streamer text NOT NULL,
        CONSTRAINT canal_pkey PRIMARY KEY (nro_plataforma, nome),
        CONSTRAINT fk_canal_plataforma FOREIGN KEY (nro_plataforma) REFERENCES plataforma(nro) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_canal_streamer FOREIGN KEY (nick_streamer) REFERENCES usuario(nick) ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import datetime
import itertools
import logging
import random
import unicodedata
from collections.abc import Iterator, Sequence
from typing import Any, Literal, Self

import faker as fkr

from src.fake import combinacoes

from . import dado_fake, plataforma_fake, usuario_fake

T_tipo_canal = Literal["privado", "público", "misto"]
T_plataforma_canal = tuple[plataforma_fake.PlataformaFake, str]


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class CanalFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_canal", "nome", "tipo", "data", "descricao", "id_streamer_fk", "qtd_visualizacoes", "qtd_videos_postados")

    nro_plataforma: int
    id_canal: int
    nome: str
    tipo: T_tipo_canal
    data: datetime.date
    descricao: str
    id_streamer_fk: int
    qtd_visualizacoes: int = 0
    qtd_videos_postados: int = 0

    T_pk = tuple[int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_canal)

    T_dados = tuple[str, T_tipo_canal, datetime.date, str, int, int]

    @property
    def dados(self) -> T_dados:
        # include nome as first data element so tupla matches CABECALHO
        return (self.nome, self.tipo, self.data, self.descricao, self.id_streamer_fk, self.qtd_visualizacoes)

    @property
    def tupla(self) -> tuple[*T_pk, *T_dados, int]:
        # include qtd_videos_postados at the end
        return (*self.pk, *self.dados, self.qtd_videos_postados)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        plataformas: Sequence[plataforma_fake.PlataformaFake],
        streamers: Sequence[usuario_fake.UsuarioFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} canais...")

        assert len(plataformas) * len(streamers) >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"

        def _remover_acentos(texto: str) -> str:
            return "".join(c for c in unicodedata.normalize("NFD", texto) if unicodedata.category(c) != "Mn")

        def _nome_aleatorio(separadores: Sequence[str] = ("-", "_", "")) -> str:
            nome = faker.first_name()
            nome_normalizado = _remover_acentos(nome).replace(" ", random.choice(separadores))
            return f"{random.choice(separadores)}{nome_normalizado}{random.choice(separadores)}"

        # 🎮 Termos relacionados a jogos e streaming
        X1: tuple[str, ...] = (
            "Gamer",
            "Play",
            "Stream",
            "Live",
            "Game",
            "XP",
            "Noob",
            "Pro",
            "GG",
            "AFK",
            "Respawn",
            "Loot",
            "Frag",
            "Kill",
            "Shot",
            "Aim",
            "Skill",
            "Boost",
            "Carry",
            "Clutch",
            "Drop",
            "Grind",
            "Quest",
            "Raid",
            "Boss",
            "Arena",
            "Lobby",
            "Ranked",
            "Casual",
            "Hardcore",
            "Speedrun",
            "Meta",
            "Tilt",
            "Buff",
            "Nerf",
            "Patch",
            "Update",
            "Beta",
            "Alpha",
            "Glitch",
            "Pixel",
            "Frame",
            "Lag",
            "Ping",
            "FPS",
            "RPG",
            "MOBA",
            "BR",
            "BattleRoyale",
            "Co-op",
            "Solo",
            "Squad",
            "Clan",
            "Guild",
            "Zone",
            "Nexus",
            "Portal",
            "Rift",
            "Realm",
            "World",
            "Universe",
        )

        # 🧑‍🚀 Estilo e atitude
        X2: tuple[str, ...] = (
            "Ninja",
            "Beast",
            "Ghost",
            "Shadow",
            "Sniper",
            "Hunter",
            "Warrior",
            "Titan",
            "Dragon",
            "Wolf",
            "Fox",
            "Lion",
            "Panda",
            "Shark",
            "Demon",
            "Angel",
            "Alien",
            "Cyborg",
            "Bot",
            "Hacker",
            "Glitcher",
            "Rebel",
            "Savage",
            "Toxic",
            "Chill",
            "Hype",
            "Vibe",
            "Crazy",
            "Mad",
            "Epic",
            "Insane",
            "Clown",
            "Joker",
            "King",
            "Queen",
            "Lord",
            "Master",
            "Sensei",
            "Captain",
            "General",
            "Chief",
            "Doctor",
            "Mister",
            "Sir",
        )

        # 📺 Palavras de mídia e comunidade
        X3: tuple[str, ...] = (
            "TV",
            "Tube",
            "Channel",
            "Cast",
            "Show",
            "Vlog",
            "Cam",
            "Mic",
            "Voice",
            "Talk",
            "Chat",
            "Crew",
            "Squad",
            "Nation",
            "Army",
            "Gang",
            "Bros",
            "Fam",
            "Club",
            "Central",
            "Hub",
            "Base",
            "Zone",
            "Den",
            "Cave",
            "Lab",
            "Studio",
        )

        # Lista para armazenar os dados
        canal: list[Self] = []

        # Geração dos dados
        prefixo_sufixo = itertools.combinations(X1 + X2 + X3, 2)
        nomes_canais: tuple[str, ...] = tuple(f"{prefixo}{_nome_aleatorio()}{sufixo}" for prefixo, sufixo in prefixo_sufixo)
        plataforma_x_canal: Iterator[T_plataforma_canal] = combinacoes.combina(plataformas, nomes_canais, quantidade)

        # sequencial de id_canal por plataforma
        seq_por_plataforma: dict[int, int] = {}

        for plataforma, nome_canal in plataforma_x_canal:
            tipo: T_tipo_canal = random.choice(("privado", "público", "misto"))
            data: datetime.date = faker.date_between(start_date=plataforma.data_fund)
            descricao: str = faker.text() # .replace("\n", r"\\n")
            streamer: usuario_fake.UsuarioFake = random.choice(streamers)

            # extrai nro_plataforma como int
            if hasattr(plataforma, "pk"):
                nro = plataforma.pk[0] if isinstance(plataforma.pk, tuple) else plataforma.pk
            else:
                nro = getattr(plataforma, "nro_plataforma", None)
            if nro is None:
                raise AttributeError("Objeto plataforma sem nro_plataforma/pk")

            next_seq = seq_por_plataforma.get(nro, 0) + 1
            seq_por_plataforma[nro] = next_seq

            # streamer pode ser PlataformaUsuarioFake: use nro_usuario (ou id_usuario_fk como fallback)
            streamer_id = getattr(streamer, "nro_usuario", None) or getattr(streamer, "id_usuario_fk", None) or getattr(streamer, "id_usuario", None)
            if streamer_id is None:
                raise AttributeError("Objeto streamer não possui nro_usuario/id_usuario_fk/id_usuario")

            canal.append(cls(nro, next_seq, nome_canal, tipo, data, descricao, streamer_id, qtd_visualizacoes=0, qtd_videos_postados=0))

        return tuple(canal)
