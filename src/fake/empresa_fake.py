"""--sql
CREATE TABLE public.empresa (
        nro serial4 NOT NULL,
        nome text NOT NULL,
        nome_fantasia text NULL,
        CONSTRAINT empresa_pkey PRIMARY KEY (nro)
);"""

import dataclasses
import logging
import pathlib
import random
from typing import Any, Self

import faker as fkr

from . import dado_fake


@dataclasses.dataclass(frozen=True, slots=True, order=True)
class EmpresaFake(dado_fake.DadoFake):
    CABECALHO = ("nro", "nome", "nome_fantasia")
    nro: int
    nome: str
    nome_fantasia: str

    @property
    def pk(self) -> int:
        return self.nro

    @property
    def dados(self) -> tuple[str, str]:
        return (self.nome, self.nome_fantasia)

    @property
    def tupla(self) -> tuple[int, str, str]:
        return (self.pk, *self.dados)

    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: tuple[Any, ...], **kwargs: dict[str, Any]) -> tuple[Self, ...]:
        logging.info(f"Gerando {quantidade:_} empresas...")

        SUFIXO_NOME_FANTASIA = (
            "Soluções",
            "Consultoria",
            "Serviços",
            "Grupo",
            "Labs",
            "Studio",
            "Works",
            "Factory",
            "Tecnologia",
            "Inovação",
            "Digital",
            "Inteligência",
            "Enterprises",
            "Holdings",
            "Partners",
            "Co",
            "Comércio",
            "Distribuidora",
            "Atacado",
            "Varejo",
            "Creative",
            "Design",
            "Agency",
            "Collective",
            "Capital",
            "Investimentos",
            "Finanças",
            "Private",
            "Logística",
            "Transportes",
            "Frete",
            "Operações",
            "Solutions",
            "Services",
            "Systems",
            "Networks",
            "Alimentos",
            "Gastronomia",
            "Culinária",
            "Delícias",
            "Healthcare",
            "Medical",
            "Wellness",
            "Clinic",
            "Imobiliária",
            "Construções",
            "Empreendimentos",
            "Obras",
            "Global",
            "Worldwide",
            "International",
            "Universal",
            "Educação",
            "Treinamento",
            "Academia",
            "Formação",
            "Eco",
            "Verde",
            "Sustentável",
            "Ambiental",
            "Smart",
            "Next",
            "Prime",
            "Edge",
            "Moda",
            "Estilo",
            "Atelier",
            "Boutique",
            "Legal",
            "Jurídico",
            "Assessoria",
            "Advocacia",
            "Consulting",
            "Advisors",
            "Strategies",
            "Solutions",
            "Tech",
            "Hub",
            "Platform",
            "Engine",
        )

        # Lista para armazenar os dados
        empresas: list[Self] = []

        # Geração dos dados
        for i in range(1, quantidade + 1):
            nome: str = faker.unique.company()
            nome_fantasia: str = nome + " " + random.choice(SUFIXO_NOME_FANTASIA)

            # Armazena o dado gerado
            empresas.append(cls(nro=i, nome=nome, nome_fantasia=nome_fantasia))

        return tuple(empresas)

    @classmethod
    def gera_a_partir_do_csv(cls, caminho: str | pathlib.Path) -> tuple[Self, ...]:
        empresas: list[Self] = []

        with open(caminho, encoding="utf-8") as arquivo:
            # Cabecalho
            arquivo.readline()

            for linha in arquivo:
                nro, nome, nome_fantasia = linha.rstrip().split(";")
                empresas.append(cls(nro=int(nro), nome=nome, nome_fantasia=nome_fantasia))

        return tuple(empresas)
