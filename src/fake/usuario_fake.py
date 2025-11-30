"""--sql
CREATE TABLE usuario (
        nick text NOT NULL,
        email text NOT NULL,
        data_nasc date NOT NULL,
        telefone text NOT NULL,
        end_postal text NOT NULL,
        pais_resid text NOT NULL,
        CONSTRAINT usuario_email_key UNIQUE (email),
        CONSTRAINT usuario_pkey PRIMARY KEY (nick),
        CONSTRAINT fk_usuario_pais FOREIGN KEY (pais_resid) REFERENCES pais(nome) ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import datetime
import logging
import random
from typing import Any, Self

import faker as fkr

from . import dado_fake, pais_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class UsuarioFake(dado_fake.DadoFake):
    CABECALHO = ("id_usuario", "nick", "email", "data_nasc", "telefone", "end_postal", "id_pais_resid_fk")
    id_usuario: int
    nick: str
    email: str
    data_nasc: datetime.date
    telefone: str
    end_postal: str
    id_pais_resid_fk: int

    T_pk = int

    @property
    def pk(self) -> T_pk:
        return self.id_usuario

    T_dados = tuple[str, datetime.date, str, str, str, int]

    @property
    def dados(self) -> T_dados:
        return (self.nick, self.email, self.data_nasc, self.telefone, self.end_postal, self.id_pais_resid_fk)

    @property
    def tupla(self) -> tuple[int, *T_dados]:
        return (self.id_usuario, *self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *paises: pais_fake.PaisFake, **kwargs: Any) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} usuários...")

        # Lista para armazenar os dados
        usuarios: list[Self] = []

        # Geração dos dados
        paises_aleatorios = random.choices(paises, k=quantidade)

        # Sequencial de id_usuario
        next_id = 1
        for pais_aleatorio in paises_aleatorios:
            nick: str = faker.unique.user_name()
            email: str = faker.unique.email()
            data_nasc: datetime.date = faker.date_of_birth(minimum_age=12)
            telefone: str = faker.phone_number()
            end_postal: str = faker.address().replace("\n", ", ")
            id_pais: int = pais_aleatorio.id_pais

            # Armazena o dado gerado com id sequencial
            usuarios.append(cls(next_id, nick, email, data_nasc, telefone, end_postal, id_pais))
            next_id += 1

        return tuple(usuarios)
