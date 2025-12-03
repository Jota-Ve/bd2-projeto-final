

import dataclasses
import logging
import random
from collections.abc import Sequence
from typing import Any, Literal, Self

import faker as fkr

from . import dado_fake, doacao_fake

T_status = Literal["recusado", "recebido", "lido"]


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class PaypalFake(dado_fake.DadoFake):
    CABECALHO = ("nro_plataforma", "id_video", "seq_comentario",  "idpaypal")
    nro_plataforma: int
    id_video: int
    seq_comentario: int
    
    idpaypal: str

    T_pk = tuple[int, int, int, int]

    @property
    def pk(self) -> T_pk:
        return (self.nro_plataforma, self.id_video, self.seq_comentario)

    T_dados = str

    @property
    def dados(self) -> T_dados:
        return self.idpaypal

    @property
    def tupla(self) -> tuple[int, int, int, int, str]:
        return (self.nro_plataforma, self.id_video, self.seq_comentario, self.idpaypal)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        doacoes: Sequence[doacao_fake.DoacaoFake],
        **kwargs: Any,
    ) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} pagamentos Paypal...")

        # Lista para armazenar os dados
        paypal: list[Self] = []

        # Geração de dados fictícios
        doacoes_selecionadas = random.sample(doacoes, quantidade)
        for doacao in doacoes_selecionadas:
            idpaypal: str = faker.bothify(text="PAY-????-####", letters="ABCDEFGHIJKLMNOPQRSTUVWXYZ")
            paypal.append(cls(doacao.nro_plataforma, doacao.id_video, doacao.seq_comentario, idpaypal))

        return tuple(paypal)
