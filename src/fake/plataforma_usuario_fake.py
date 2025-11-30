"""--sql
CREATE TABLE plataforma_usuario (
        nro_plataforma serial4 NOT NULL,
        nick_usuario text NOT NULL,
        nro_usuario serial4 NOT NULL,
        CONSTRAINT plataforma_usuario_pkey PRIMARY KEY (nro_plataforma, nick_usuario),
        CONSTRAINT fk_plataforma_usuario_plataforma FOREIGN KEY (nro_plataforma) REFERENCES plataforma(nro) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_plataforma_usuario_usuario FOREIGN KEY (nick_usuario) REFERENCES usuario(nick) ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import logging
import random
from collections.abc import Sequence
from typing import Any, Self

import faker as fkr

from src.fake import combinacoes

from . import dado_fake, plataforma_fake, usuario_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class PlataformaUsuarioFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma_fk", "id_usuario_fk", "nro_usuario")
    nro_plataforma: int
    id_usuario_fk: int
    nro_usuario: int

    T_pk = tuple[int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_usuario_fk)

    T_dados = int

    @property
    def dados(self) -> T_dados:
        return self.nro_usuario

    @property
    def tupla(self) -> tuple[*T_pk, T_dados]:
        return (*self.pk, self.dados)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        plataformas: Sequence[plataforma_fake.PlataformaFake],
        usuarios: Sequence[usuario_fake.UsuarioFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} plataforma_usuario...")
        assert len(plataformas) * len(usuarios) >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"

        # Lista para armazenar os dados
        plataforma_usuario: list[Self] = []

        # Geração dos dados
        plataforma_x_usuario = combinacoes.combina(plataformas, usuarios, quantidade)
        for plataforma, usuario in plataforma_x_usuario:
            # Armazena o dado gerado (use usuario.id_usuario)
            plataforma_usuario.append(cls(plataforma.pk, usuario.id_usuario, random.randint(0, quantidade)))

        return tuple(plataforma_usuario)
