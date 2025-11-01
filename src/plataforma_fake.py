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

from collections.abc import Iterable
import dataclasses
import datetime
import logging
import random
from typing import Any, Self, Unpack

import faker as fkr
import psycopg

from . import empresa_fake

from .dado_fake import DadoFake

@dataclasses.dataclass(frozen=True, slots=True, order=True)
class PlataformaFake(DadoFake):
    CABECALHO = ('nro', 'nome', 'qtd_users', 'empresa_fund', 'empresa_respo', 'data_fund')
    nro: int
    nome: str
    qtd_users: int
    empresa_fund: int
    empresa_respo: int
    data_fund: datetime.date

    type T_pk = int
    @property
    def pk(self) -> T_pk: return self.nro

    type T_dados = tuple[str, int, int, int, datetime.date]
    @property
    def dados(self) -> T_dados:
        return (self.nome, self.qtd_users, self.empresa_fund, self.empresa_respo, self.data_fund)

    @property
    def tupla(self) -> tuple[T_pk, Unpack[T_dados]]:
        return (self.pk, *self.dados)

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
            empresa_fund   = random.choice(empresas).pk
            empresa_respo  = random.choice(empresas).pk
            data_fund     : datetime.date   = faker.date_between(PRIMEIRA_DATA, ULTIMA_DATA)

            # Armazena o dado gerado
            plataformas.append(cls(nro, nome, QTD_USERS, empresa_fund, empresa_respo, data_fund))

        return tuple(plataformas)


    @staticmethod
    def insere_no_banco(conexao: psycopg.Connection, plataformas: Iterable['PlataformaFake'], *, commit: bool = True, preenche_autoincrement: bool=True) -> None:
        SQL_COM_AUTO_INCREMENT = """--sql
            INSERT INTO public.plataforma (nro, nome, qtd_users, empresa_fund, empresa_respo, data_fund)
            VALUES (%s, %s, %s, %s, %s, %s)
            ON CONFLICT (nro) DO NOTHING;
        """
        SQL_SEM_AUTO_INCREMENT = """--sql
            INSERT INTO public.plataforma (nome, qtd_users, empresa_fund, empresa_respo, data_fund)
            VALUES (%s, %s, %s, %s, %s);
        """

        with conexao.cursor() as cursor:
            if preenche_autoincrement:
                cursor.executemany(SQL_COM_AUTO_INCREMENT, (e.tupla for e in plataformas))
            else:
                cursor.executemany(SQL_SEM_AUTO_INCREMENT, (e.dados for e in plataformas))

            logging.info(f'{cursor.rowcount} linhas inseridas na tabela plataforma.')

        if commit:
            conexao.commit()


    @staticmethod
    def limpa_tabela(conexao: psycopg.Connection, *, commit: bool = True) -> None:
        SQL = """--sql
            TRUNCATE TABLE public.plataforma
            CASCADE;
        """

        with conexao.cursor() as cursor:
            cursor.execute(SQL)
            logging.info(f'Tabela plataforma TRUNCADA.')

        if commit:
            conexao.commit()
