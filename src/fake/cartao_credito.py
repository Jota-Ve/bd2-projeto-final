

import dataclasses
import logging
import random
from collections.abc import Sequence
from typing import Any, Self

import faker as fkr

from . import dado_fake, doacao_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class CartaoCreditoFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_video", "seq_comentario", "nro_cartao", "bandeira")
    nro_plataforma: int
    id_video: int
    seq_comentario: int
    nro_cartao: str
    bandeira: str

    T_pk = tuple[int, int, int]
    T_dados = tuple[str, str]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_video, self.seq_comentario)

    @property
    def dados(self) -> T_dados:
        return (self.nro_cartao, self.bandeira)

    @property
    def tupla(self) -> tuple[*T_pk, *T_dados]:
        return (*self.pk, *self.dados)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        doacoes: Sequence[doacao_fake.DoacaoFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} pagamentos Cartão de Crédito...")

        # Lista para armazenar os dados
        cartoes: list[Self] = []

        # Geração de dados fictícios
        doacoes_selecionadas = random.sample(doacoes, quantidade)
        for doacao in doacoes_selecionadas:
            nro_cartao: str = faker.credit_card_number()
            bandeira: str = faker.credit_card_provider()
            cartoes.append(cls(doacao.nro_plataforma, doacao.id_video, doacao.seq_comentario, nro_cartao, bandeira))

        return tuple(cartoes)
