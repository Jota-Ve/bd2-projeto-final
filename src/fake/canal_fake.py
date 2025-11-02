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
import random
import unicodedata
from collections.abc import Collection, Sequence
from typing import Any, Literal, Self

import faker as fkr

from . import dado_fake, plataforma_fake, usuario_fake

T_tipo_canal = Literal['privado', 'público', 'misto']


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class CanalFake(dado_fake.DadoFake):
    CABECALHO = ('nro_plataforma', 'nome', 'tipo', 'data', 'descricao', 'nick_streamer', 'qtd_visualizacoes')

    nro_plataforma: int
    nome: str
    tipo: T_tipo_canal
    data: datetime.date
    descricao: str
    nick_streamer: str
    qtd_visualizacoes: int=0

    T_pk = tuple[int, str]
    @property
    def pk(self) -> T_pk: return (self.nro_plataforma, self.nome)

    T_dados = tuple[T_tipo_canal, datetime.date, str, str, int]
    @property
    def dados(self) -> T_dados: return (self.tipo, self.data, self.descricao, self.nick_streamer, self.qtd_visualizacoes)

    @property
    def tupla(self) -> tuple[*T_pk, *T_dados]: return (*self.pk, *self.dados)


    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, plataformas: Collection[plataforma_fake.PlataformaFake],
             streamers: Sequence[usuario_fake.UsuarioFake], **kwargs: Any) -> tuple[Self, ...]:

        assert len(plataformas) * len(streamers) >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"

        def _remover_acentos(texto: str) -> str:
            return ''.join(c for c in unicodedata.normalize('NFD', texto) if unicodedata.category(c) != 'Mn')

        def _nome_aleatorio(separadores: Sequence[str] = ('-', '_', '')) -> str:
            nome             = faker.first_name()
            nome_normalizado = _remover_acentos(nome).replace(' ', random.choice(separadores))
            return f'{random.choice(separadores)}{nome_normalizado}{random.choice(separadores)}'

        # 🎮 Termos relacionados a jogos e streaming
        X1: tuple[str, ...] = ('Gamer', 'Play', 'Stream', 'Live', 'Game', 'XP', 'Noob', 'Pro', 'GG', 'AFK', 'Respawn', 'Loot', 'Frag',
                               'Kill', 'Shot', 'Aim', 'Skill', 'Boost', 'Carry', 'Clutch', 'Drop', 'Grind', 'Quest', 'Raid', 'Boss',
                               'Arena', 'Lobby', 'Ranked', 'Casual', 'Hardcore', 'Speedrun', 'Meta', 'Tilt', 'Buff', 'Nerf', 'Patch',
                               'Update', 'Beta', 'Alpha', 'Glitch', 'Pixel', 'Frame', 'Lag', 'Ping', 'FPS', 'RPG', 'MOBA', 'BR',
                               'BattleRoyale', 'Co-op', 'Solo', 'Squad', 'Clan', 'Guild', 'Zone', 'Nexus', 'Portal', 'Rift', 'Realm',
                               'World', 'Universe')

        # 🧑‍🚀 Estilo e atitude
        X2: tuple[str, ...] = ('Ninja', 'Beast', 'Ghost', 'Shadow', 'Sniper', 'Hunter', 'Warrior', 'Titan', 'Dragon', 'Wolf', 'Fox', 'Lion',
                               'Panda', 'Shark', 'Demon', 'Angel', 'Alien', 'Cyborg', 'Bot', 'Hacker', 'Glitcher', 'Rebel', 'Savage', 'Toxic',
                               'Chill', 'Hype', 'Vibe', 'Crazy', 'Mad', 'Epic', 'Insane', 'Clown', 'Joker', 'King', 'Queen', 'Lord', 'Master',
                               'Sensei', 'Captain', 'General', 'Chief', 'Doctor', 'Mister', 'Sir')

        # 📺 Palavras de mídia e comunidade
        X3: tuple[str, ...] = ('TV', 'Tube', 'Channel', 'Cast', 'Show', 'Vlog', 'Cam', 'Mic', 'Voice', 'Talk', 'Chat', 'Crew', 'Squad',
              'Nation', 'Army', 'Gang', 'Bros', 'Fam', 'Club', 'Central', 'Hub', 'Base', 'Zone', 'Den', 'Cave', 'Lab', 'Studio')


        # Lista para armazenar os dados
        canal: list[Self] = []

        # Geração dos dados
        combinacoes = itertools.combinations(X1 + X2 + X3, 2)
        nomes_canais = (f'{prefixo}{_nome_aleatorio()}{sufixo}' for prefixo,sufixo in combinacoes)
        plataforma_x_canal = itertools.product(plataformas, nomes_canais)

        for plataforma, nome_canal in random.sample(tuple(plataforma_x_canal), k=quantidade):
            tipo: T_tipo_canal                 = random.choice(('privado', 'público', 'misto'))
            data: datetime.date                = faker.date_between(start_date=plataforma.data_fund)
            descricao: str                     = faker.text().replace('\n', r'\\n')
            streamer: usuario_fake.UsuarioFake = random.choice(streamers)

            # Armazena o dado gerado
            canal.append(cls(plataforma.pk, nome_canal, tipo, data, descricao, streamer.pk))

        return tuple(canal)
