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
import logging
from collections.abc import Sequence
from typing import Any, Self

import faker as fkr

from src.fake import combinacoes

from . import dado_fake, pais_fake, usuario_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class StreamerPaisFake(dado_fake.DadoFake):
    CABECALHO = ("nick_streamer", "nro_passaporte", "ddi_pais")
    nick_streamer: str
    nro_passaporte: str
    ddi_pais: int

    T_pk = tuple[str, int]

    @property
    def pk(self) -> T_pk:
        return (self.nick_streamer, self.ddi_pais)

    T_dados = str

    @property
    def dados(self) -> T_dados:
        return self.nro_passaporte

    @property
    def tupla(self) -> tuple[str, str, int]:
        return (self.nick_streamer, self.nro_passaporte, self.ddi_pais)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        streamers: Sequence[usuario_fake.UsuarioFake],
        paises: Sequence[pais_fake.PaisFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} streamer_pais...")
        assert len(streamers) * len(paises) >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"

        # Lista para armazenar os dados
        streamer_pais: list[Self] = []

        # Geração dos dados
        streamer_x_pais = combinacoes.combina(streamers, paises, quantidade)
        for streamer, pais in streamer_x_pais:
            # Armazena o dado gerado
            streamer_pais.append(cls(streamer.pk, faker.unique.passport_number(), pais.ddi))

        return tuple(streamer_pais)
