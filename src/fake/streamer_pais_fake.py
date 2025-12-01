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
    CABECALHO = ("id_usuario_fk", "nro_passaporte", "id_pais_fk")
    id_usuario_fk: int
    nro_passaporte: str
    id_pais_fk: int

    T_pk = tuple[int, int]

    @property
    def pk(self) -> T_pk:
        return (self.id_usuario_fk, self.id_pais_fk)

    T_dados = str

    @property
    def dados(self) -> T_dados:
        return self.nro_passaporte

    @property
    def tupla(self) -> tuple[int, str, int]:
        return (self.id_usuario_fk, self.nro_passaporte, self.id_pais_fk)

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
            # Armazena o dado gerado (use streamer.id_usuario and pais.id_pais)
            streamer_num = getattr(streamer, "nro_usuario", None) or getattr(streamer, "id_usuario_fk", None) or getattr(streamer, "id_usuario", None)
            if streamer_num is None:
                raise AttributeError("Objeto streamer não possui nro_usuario/id_usuario_fk/id_usuario")
            streamer_pais.append(cls(streamer_num, faker.unique.passport_number(), pais.id_pais))

        return tuple(streamer_pais)
