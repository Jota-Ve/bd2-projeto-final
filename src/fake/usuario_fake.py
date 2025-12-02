
import dataclasses
import datetime
import logging
import random
from typing import Any, Self

import faker as fkr

from . import dado_fake, pais_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class UsuarioFake(dado_fake.DadoFake):
    CABECALHO = ("nick", "email", "data_nasc", "telefone", "end_postal", "id_pais_resid")
    nick: str
    email: str
    data_nasc: datetime.date
    telefone: str
    end_postal: str
    id_pais_resid: int

    T_pk = str
    T_dados = tuple[str, datetime.date, str, str, int]

    @property
    def pk(self) -> T_pk:
        return self.nick

    @property
    def dados(self) -> T_dados:
        return (self.email, self.data_nasc, self.telefone, self.end_postal, self.id_pais_resid)

    @property
    def tupla(self) -> tuple[T_pk, *T_dados]:
        return (self.pk, *self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *paises: pais_fake.PaisFake, **kwargs: Any) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} usuários...")

        # Lista para armazenar os dados
        usuarios: list[Self] = []

        # Geração dos dados
        paises_aleatorios = random.choices(paises, k=quantidade)
        for pais_aleatorio in paises_aleatorios:
            nick: str = faker.unique.user_name()
            email: str = faker.unique.email()
            data_nasc: datetime.date = faker.date_of_birth(minimum_age=12)
            telefone: str = faker.phone_number()
            end_postal: str = faker.address().replace("\n", ", ")
            id_pais_resid: str = pais_aleatorio.pk

            # Armazena o dado gerado
            usuarios.append(
                cls(nick=nick,
                    email=email,
                    data_nasc=data_nasc,
                    telefone=telefone,
                    end_postal=end_postal,
                    id_pais_resid=id_pais_resid)
            )

        return tuple(usuarios)
