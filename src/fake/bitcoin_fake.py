
import dataclasses
import logging
import random
from collections.abc import Sequence
from typing import Any, Self

import faker as fkr

from . import dado_fake, doacao_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class BitcoinFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_video", "seq_comentario", "txid")
    nro_plataforma: int
    id_video: int
    seq_comentario: int
    txid: str

    T_pk = tuple[int, int, int]
    T_dados = str

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_video, self.seq_comentario)


    @property
    def dados(self) -> T_dados:
        return self.txid

    @property
    def tupla(self) -> tuple[*T_pk, T_dados]:
        return (*self.pk, self.dados)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        doacoes: Sequence[doacao_fake.DoacaoFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} pagamentos Bitcoin...")

        # Lista para armazenar os dados
        bitcoins: list[Self] = []

        # Geração de dados fictícios
        doacoes_selecionadas = random.sample(doacoes, quantidade)
        for doacao in doacoes_selecionadas:
            txid: str = faker.sha256()
            bitcoins.append(cls(doacao.nro_plataforma, doacao.id_video, doacao.seq_comentario, txid))

        return tuple(bitcoins)
