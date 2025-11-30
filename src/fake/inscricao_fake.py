"""--sql
CREATE TABLE public.inscricao (
        nro_plataforma serial4 NOT NULL,
        nome_canal text NOT NULL,
        nick_membro text NOT NULL,
        nivel int2 NOT NULL,
        CONSTRAINT inscricao_pkey PRIMARY KEY (nro_plataforma, nome_canal, nick_membro),
        CONSTRAINT fk_inscricao_membro FOREIGN KEY (nick_membro) REFERENCES public.usuario(nick) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT fk_inscricao_nivel FOREIGN KEY (nro_plataforma,nome_canal,nivel) REFERENCES public.nivel_canal(nro_plataforma,nome_canal,nivel)
 ON DELETE CASCADE ON UPDATE CASCADE
);
"""

import dataclasses
import logging
import random
from collections.abc import Sequence
from typing import Any, Self

import faker as fkr

from src.fake import combinacoes

from . import dado_fake, nivel_canal_fake, usuario_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class InscricaoFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_canal_fk", "id_usuario_fk", "nivel")

    nro_plataforma: int
    id_canal_fk: int
    id_usuario_fk: int
    nivel: nivel_canal_fake.T_nivel

    T_pk = tuple[int, int, int]
    T_dados = nivel_canal_fake.T_nivel

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_canal_fk, self.id_usuario_fk)

    @property
    def dados(self) -> T_dados:
        return self.nivel

    @property
    def tupla(self) -> tuple[*T_pk, T_dados]:
        return (*self.pk, self.dados)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        niveis_canais: Sequence[nivel_canal_fake.NivelCanal],
        membros: Sequence[usuario_fake.UsuarioFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Iniciando geração de {quantidade:_} inscrições...")
        assert len(niveis_canais) * len(membros) >= quantidade, f"Combinações possíveis da PK abaixo da quantidade especificada: {quantidade}"

        # Lista para armazenar os dados
        inscricoes: list[Self] = []

        # Ignora níveis de canal repetidos para evitar duplicatas na PK (cada canal tem 5 níveis)
        canais_que_possuem_nivel = {(n.nro_plataforma, n.id_canal) for n in niveis_canais}
        canais_x_membros = combinacoes.combina(tuple(canais_que_possuem_nivel), membros, quantidade)

        NIVEIS_POSSIVEIS: tuple[nivel_canal_fake.T_nivel, ...] = (1, 2, 3, 4, 5)
        # Geração de dados fictícios
        for (nro_plataforma, id_canal), membro in canais_x_membros:
            nivel: nivel_canal_fake.T_nivel = random.choice(NIVEIS_POSSIVEIS)

            # Cria a instância e adiciona à lista
            inscricoes.append(cls(nro_plataforma, id_canal, membro.id_usuario, nivel))

        return tuple(inscricoes)
