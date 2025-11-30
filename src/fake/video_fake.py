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
    CABECALHO = ("id_video", "nro_plataforma", "id_canal", "titulo", "datah", "tema", "duracao_segs", "visu_simul", "visu_total")
    # Valores mínimos e máximos para o valor do patrocínio
    DURACAO_MINIMA: ClassVar[int] = 1  # 1 segundo
    DURACAO_MAXIMA: ClassVar[int] = 24 * 60 * 60  # 24 horas
    VISU_SIMUL_MINIMA: ClassVar[int] = 0
    VISU_SIMUL_MAXIMA: ClassVar[int] = 1_000_000
    VISU_OFFLINE_MAXIMA: ClassVar[int] = 10_000_000

    id_video: int
    nro_plataforma: int
    id_canal: int
    titulo: str
    datah: datetime.datetime
    tema: str
    duracao_segs: int
    visu_simul: int
    visu_total: int

    T_pk = int
    T_dados = tuple[int, int, str, datetime.datetime, str, int, int, int]

    @property
    def pk(self) -> T_pk:
        return self.id_video

    @property
    def dados(self) -> T_dados:
        return (self.nro_plataforma, self.id_canal, self.titulo, self.datah, self.tema, self.duracao_segs, self.visu_simul, self.visu_total)

    @property
    def tupla(self) -> tuple[T_pk, *T_dados]:
        return (self.pk, *self.dados)

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
            "Atualidades",
            "Automobilismo",
            "Beleza",
            "Biologia",
            "Carros",
            "Casa e Decoração",
            "Ciência",
            "Cinema",
            "Comédia",
            "Culinária",
            "Curiosidades",
            "Dança",
            "Desafios",
            "Design",
            "Documentários",
            "Economia",
            "Educação",
            "Empreendedorismo",
            "Esportes",
            "Faça Você Mesmo (DIY)",
            "Filosofia",
            "Finanças",
            "Física",
            "Fitness",
            "Fotografia",
            "Futebol",
            "Games",
            "Gastronomia",
            "Geografia",
            "História",
            "Humor",
            "Investimentos",
            "Jardinagem",
            "Jogos de Tabuleiro",
            "Literatura",
            "Maquiagem",
            "Matemática",
            "Meditação",
            "Moda",
            "Música",
            "Natureza",
            "Negócios",
            "Notícias",
            "Nutrição",
            "Pets",
            "Política",
            "Programação",
            "Psicologia",
            "Química",
            "Receitas",
            "Redes Sociais",
            "Reggae",
            "Reviews",
            "Rock",
            "Samba",
            "Saúde",
            "Tecnologia",
            "Viagens",
            "Vlogs",
        ]

        # Lista para armazenar os dados
        videos: list[Self] = []

        # Dicionário para controlar sequencial por plataforma
        # nro_plataforma -> ultimo_id
        seq_por_plataforma: dict[int, int] = {}

        # Geração de dados fictícios
        for canal in random.choices(canais, k=quantidade):
            # Incrementa sequencial da plataforma
            novo_id = seq_por_plataforma.get(canal.nro_plataforma, 0) + 1
            seq_por_plataforma[canal.nro_plataforma] = novo_id

            titulo: str = faker.sentence(nb_words=5, variable_nb_words=True).rstrip(".")
            datah: datetime.datetime = faker.date_time_between(start_date=canal.data)
            tema: str = random.choice(temas_possiveis)
            duracao: int = random.randint(cls.DURACAO_MINIMA, cls.DURACAO_MAXIMA)
            visu_simul: int = random.randint(cls.VISU_SIMUL_MINIMA, cls.VISU_SIMUL_MAXIMA)
            visu_total: int = visu_simul + random.randint(0, cls.VISU_OFFLINE_MAXIMA)

            # Cria a instância e adiciona à lista
            videos.append(cls(nro_plataforma=canal.nro_plataforma, id_video=novo_id, id_canal=canal.id_canal, titulo=titulo, datah=datah, tema=tema, duracao_segs=duracao, visu_simul=visu_simul, visu_total=visu_total))

        return tuple(videos)
