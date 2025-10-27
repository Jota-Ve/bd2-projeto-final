"""--sql
CREATE TABLE plataforma (
  nro             SERIAL PRIMARY KEY,
  nome            TEXT NOT NULL,
  qtd_users       INTEGER NOT NULL, -- derivado: atualizar periodicamente
  empresa_fund    SERIAL NOT NULL,
  empresa_respo   SERIAL NOT NULL,
  data_fund       DATE NOT NULL,
  CONSTRAINT fk_plataforma_empresa_fund FOREIGN KEY (empresa_fund) REFERENCES empresa(nro),
  CONSTRAINT fk_plataforma_empresa_respo FOREIGN KEY (empresa_respo) REFERENCES empresa(nro)
);"""

import datetime
import random
from typing import Any, Self

import faker as fkr

from . import empresa_fake

from .dado_fake import DadoFake


class PlataformaFake(DadoFake):
    CABECALHO = ('nro', 'nome', 'qtd_users', 'empresa_fund', 'empresa_respo', 'data_fund')

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *empresas: empresa_fake.EmpresaFake, **kwargs: dict[str, Any]) -> tuple[Self, ...]:
        SUFIXO_NOME_STREAMING = ("Play", "Stream", "Now", "Live", "Plus", "Mais", "Premium",
                                 "Pro", "On", "Aqui", "Direct", "Hub", "Flix", "Cinema", "Filmes", "Shows", "Box", "Canal",
                                 "Station", "Channel", "Originals", "Originais", "Exclusive", "Exclusivo", "Hub", "Portal",
                                 "Plataforma", "Network", "Go", "Ir", "Access", "Portal", "Spot", "Ponto", "Streamline",
                                 "Streamline", "Now+", "Agora+", "Prime", "Select", "Wave", "Onda", "Flow", "Fluxo", "Live+",
                                 "AoVivo", "Broadcast", "LiveStream", "Playground", "PlayLab", "Studio", "Studios", "Pocket",
                                 "PocketTV", "Mini", "Lite", "Realm", "Mundo", "Universe", "Universal", "Stage", "Palco", "Scene",
                                 "Showcase", "Vault", "Arquivo", "Collection", "Library", "Beat", "Ritmo", "Groove", "Vibe",
                                 "Queue", "Fila", "Lineup", "Schedule", "Loop", "LoopTV", "Replay", "OnRepeat", "Cast", "CastTV",
                                 "Radio", "Pod", "PrimeTime", "HoraNobre", "Spotlight", "Highlights", "Sync", "Sincroniza",
                                 "Connect", "Connect+", "Edge", "Next", "Future", "NextGen", "Cine", "CinePlus", "Reel", "Reels",
                                 "Streamers", "Transmit", "Broadcast", "Air", "Gate", "Entrada", "Access+", "Pass", "Verse",
                                 "Universo", "Metaverse", "Worlds", "Crew", "Equipe", "Collective", "Collective+", "Atlas",
                                 "Mapa", "Navigator", "Explorer")

        PRIMEIRA_DATA = datetime.date(1990, 1, 1)
        ULTIMA_DATA = datetime.date.today()
        QTD_USERS = 0

        # Lista para armazenar os dados
        plataformas: list[Self] = []

        # Geração dos dados
        for nro in range(1, quantidade + 1):
            nome          : str             = f'{faker.unique.company()} {random.choice(SUFIXO_NOME_STREAMING)}'
            empresa_fund  : tuple[Any, ...] = random.choice(empresas).pk
            empresa_respo : tuple[Any, ...] = random.choice(empresas).pk
            data_fund     : datetime.date   = faker.date_between(PRIMEIRA_DATA, ULTIMA_DATA)

            # Armazena o dado gerado
            pk = (nro,)
            dados = (nome, QTD_USERS) + empresa_fund + empresa_respo + (data_fund,)
            plataformas.append(cls(pk=pk, dados=dados))

        return tuple(plataformas)
