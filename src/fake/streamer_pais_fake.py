"""--sql
CREATE TABLE streamer_pais (
	nick_streamer text NOT NULL,
	nro_passaporte varchar(9) NOT NULL,
	pais_passaporte text NOT NULL,
	CONSTRAINT streamer_pais_nro_passaporte_key UNIQUE (nro_passaporte),
	CONSTRAINT streamer_pais_pkey PRIMARY KEY (nick_streamer, pais_passaporte),
	CONSTRAINT fk_streamerpais_pais FOREIGN KEY (pais_passaporte) REFERENCES pais(nome) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_streamerpais_usuario FOREIGN KEY (nick_streamer) REFERENCES usuario(nick) ON DELETE CASCADE ON UPDATE CASCADE
);
"""
import dataclasses
import itertools
import random
from collections.abc import Collection
from typing import Any, Self, Unpack

import faker as fkr

from . import dado_fake, pais_fake, usuario_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class StreamerPaisFake(dado_fake.DadoFake):
    CABECALHO = ('nick_streamer', 'nro_passaporte', 'pais_passaporte')
    nick_streamer : str
    nro_passaporte : str
    pais_passaporte : str

    type T_pk = tuple[str, str]
    @property
    def pk(self) -> T_pk: return (self.nick_streamer, self.pais_passaporte)

    type T_dados = str
    @property
    def dados(self) -> T_dados: return self.nro_passaporte

    @property
    def tupla(self) -> tuple[Unpack[T_pk], T_dados]: return (*self.pk, self.dados)


    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: Any, streamers: Collection[usuario_fake.UsuarioFake],
             paises: Collection[pais_fake.PaisFake], **kwargs: Any) -> tuple[Self, ...]:

        assert len(streamers) * len(paises) >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"

        # Lista para armazenar os dados
        streamer_pais: list[Self] = []

        # Geração dos dados
        streamer_x_pais = itertools.product(streamers, paises)
        for streamer, pais in random.sample(tuple(streamer_x_pais), quantidade):
            # Armazena o dado gerado
            streamer_pais.append(cls(streamer.pk, pais.pk, faker.unique.passport_number()))

        return tuple(streamer_pais)
