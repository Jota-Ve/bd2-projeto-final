"""--sql
CREATE TABLE public.video (
        nro_plataforma serial4 NOT NULL,
        nome_canal text NOT NULL,
        titulo text NOT NULL,
        datah timestamp NOT NULL,
        tema text NOT NULL,
        duracao_segs int4 NOT NULL,
        visu_simul int4 NOT NULL,
        visu_total int8 NOT NULL,
        CONSTRAINT video_duracao_segs_check CHECK ((duracao_segs > 0)),
        CONSTRAINT video_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo, datah),
        CONSTRAINT video_visu_simul_check CHECK ((visu_simul >= 0)),
        CONSTRAINT video_visu_total_check CHECK ((visu_total >= 0)),
        CONSTRAINT fk_video_canal FOREIGN KEY (nro_plataforma,nome_canal) REFERENCES public.canal(nro_plataforma,nome) ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import datetime
import logging
import random
from collections.abc import Sequence
from typing import Any, ClassVar, Self

import faker as fkr

from . import canal_fake, dado_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class VideoFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "nome_canal", "titulo", "datah", "tema", "duracao_segs", "visu_simul", "visu_total")
    # Valores mínimos e máximos para o valor do patrocínio
    DURACAO_MINIMA: ClassVar[int] = 1  # 1 segundo
    DURACAO_MAXIMA: ClassVar[int] = 24 * 60 * 60  # 24 horas
    VISU_SIMUL_MINIMA: ClassVar[int] = 0
    VISU_SIMUL_MAXIMA: ClassVar[int] = 1_000_000
    VISU_OFFLINE_MAXIMA: ClassVar[int] = 10_000_000

    nro_plataforma: int
    nome_canal: str
    titulo: str
    datah: datetime.datetime
    tema: str
    duracao_segs: int
    visu_simul: int
    visu_total: int

    T_pk = tuple[int, str, str, datetime.datetime]
    T_dados = tuple[str, int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.nome_canal, self.titulo, self.datah)

    @property
    def dados(self) -> T_dados:
        return (self.tema, self.duracao_segs, self.visu_simul, self.visu_total)

    @property
    def tupla(self) -> tuple[*T_pk, *T_dados]:
        return (*self.pk, *self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, canais: Sequence[canal_fake.CanalFake], **kwargs: Any) -> tuple[Self, ...]:
        """Gera uma quantidade de dados/tuplas fictícias para vídeos.
        Args:
            quantidade (int): Quantidade de dados/tuplas a serem geradas.
            faker (Faker): Instância do Faker para geração de dados fictícios.
            canais (Sequence[CanalFake]): Sequência de canais existentes para associar os vídeos.
        Returns:
            tuple[VideoFake, ...]: Tupla contendo os dados/tuplas fictícias geradas.
        """
        logging.info(f"Iniciando geração de {quantidade:_} vídeos...")
        # Possíveis temas para os vídeos
        temas_possiveis: list[str] = [
            "Anarquismo",
            "Animação",
            "Animais",
            "Animes",
            "Antropologia",
            "Arquitetura",
            "Arte",
            "ASMR",
            "Astronomia",
            "Axé",
            "Beleza",
            "Biologia",
            "Blockchain",
            "Blues",
            "Breaking Bad",
            "Call of Duty",
            "Capitalismo",
            "Carros",
            "Chuck Palahniuk",
            "Ciência",
            "Cinema",
            "Clássica",
            "Comédia",
            "Comunismo",
            "Cosplay",
            "Country",
            "Culinária",
            "Cultura Pop",
            "Cultura",
            "Dark Souls",
            "DC Comics",
            "Democracia",
            "Desafios",
            "Desenvolvimento de Software",
            "Design",
            "Disco",
            "Divorced Dad Rock",
            "DIY",
            "Documentários",
            "Dororo",
            "Dragon Ball",
            "Ecologia",
            "Educação",
            "Elden Ring",
            "Eletrônica",
            "Engenharia",
            "Entrevistas",
            "Esportes",
            "Eventos Esportivos",
            "Eventos",
            "Fandoms",
            "Filosofia",
            "Finanças",
            "Física",
            "Fitness",
            "Forró",
            "Fotografia",
            "Funk",
            "Game of Thrones",
            "Gameplay",
            "Hip-Hop",
            "História",
            "Imóveis",
            "Influenciadores",
            "Inteligência Artificial",
            "Investimentos",
            "Isaac Asimov",
            "J-Pop",
            "Jazz",
            "Jogos de Tabuleiro",
            "Jogos",
            "K-Pop",
            "Kassino",
            "Leninismo",
            "Literatura",
            "Lives",
            "Machine Learning",
            "Mangás",
            "Maoismo",
            "Marketing",
            "Marvel",
            "Marxismo",
            "Matemática",
            "Medicina",
            "Moda",
            "Música",
            "Naruto",
            "Natureza",
            "Negócios",
            "Notícias",
            "O Som da Noite",
            "Podcasts",
            "Política",
            "Pop",
            "Programação",
            "Psicologia",
            "Publicidade",
            "Química",
            "Reações",
            "Realidade Aumentada",
            "Realidade Virtual",
            "Redes Sociais",
            "Reggae",
            "Reviews",
            "Rock",
            "Samba",
            "Saúde",
            "Socialismo",
            "Sociologia",
            "Star Wars",
            "Summer Eletro Hits",
            "Tecnologia",
            "Tutoriais",
            "Unboxings",
            "Viagens",
            "Vlogs",
        ]

        # Lista para armazenar os dados
        videos: list[Self] = []

        # Geração de dados fictícios
        for canal in random.choices(canais, k=quantidade):
            titulo: str = faker.sentence(nb_words=5, variable_nb_words=True).rstrip(".")
            datah: datetime.datetime = faker.date_time_between(start_date=canal.data)
            tema: str = random.choice(temas_possiveis)
            duracao: int = random.randint(cls.DURACAO_MINIMA, cls.DURACAO_MAXIMA)
            visu_simul: int = random.randint(cls.VISU_SIMUL_MINIMA, cls.VISU_SIMUL_MAXIMA)
            visu_total: int = visu_simul + random.randint(0, cls.VISU_OFFLINE_MAXIMA)

            # Cria a instância e adiciona à lista
            videos.append(cls(*canal.pk, titulo=titulo, datah=datah, tema=tema, duracao_segs=duracao, visu_simul=visu_simul, visu_total=visu_total))

        return tuple(videos)
