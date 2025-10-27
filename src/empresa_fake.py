import pathlib
import random
from typing import Any, Self

import faker as fkr

from .dado_fake import DadoFake


class EmpresaFake(DadoFake):
    CABECALHO = ('nro', 'nome', 'nome_fantasia')


    @classmethod
    def gera(cls, quantidade: int, faker: fkr.Faker, *args: tuple[Any, ...], **kwargs: dict[str, Any]) -> tuple[Self, ...]:
        OPCOES_PARA_NOME_FANTASIA = ("Soluções", "Consultoria", "Serviços", "Grupo",
                                     "Labs", "Studio", "Works", "Factory",
                                     "Tecnologia", "Inovação", "Digital", "Inteligência",
                                     "Enterprises", "Holdings", "Partners", "Co",
                                     "Comércio", "Distribuidora", "Atacado", "Varejo",
                                     "Creative", "Design", "Agency", "Collective",
                                     "Capital", "Investimentos", "Finanças", "Private",
                                     "Logística", "Transportes", "Frete", "Operações",
                                     "Solutions", "Services", "Systems", "Networks",
                                     "Alimentos", "Gastronomia", "Culinária", "Delícias",
                                     "Healthcare", "Medical", "Wellness", "Clinic",
                                     "Imobiliária", "Construções", "Empreendimentos", "Obras",
                                     "Global", "Worldwide", "International", "Universal",
                                     "Educação", "Treinamento", "Academia", "Formação",
                                     "Eco", "Verde", "Sustentável", "Ambiental",
                                     "Smart", "Next", "Prime", "Edge",
                                     "Moda", "Estilo", "Atelier", "Boutique",
                                     "Legal", "Jurídico", "Assessoria", "Advocacia",
                                     "Consulting", "Advisors", "Strategies", "Solutions",
                                     "Tech", "Hub", "Platform", "Engine")

        # Lista para armazenar os dados
        empresas: list[Self] = []

        # Geração dos dados
        for i in range(1, quantidade + 1):
            nome = faker.company()
            nome_fantasia = nome + " " + random.choice(OPCOES_PARA_NOME_FANTASIA)
            empresas.append(cls(pk=(i,), dados=(nome, nome_fantasia)))

        return tuple(empresas)


    @classmethod
    def gera_a_partir_do_csv(cls, caminho: str|pathlib.Path) -> tuple[Self, ...]:
        empresas: list[Self] = []

        with open(caminho, encoding='utf-8') as arquivo:
            # Cabecalho
            arquivo.readline()

            for linha in arquivo:
                valores_linha = linha.rstrip().split(';')
                pk = (valores_linha[0], )
                dados = tuple(valores_linha[1:])
                empresas.append(cls(pk=pk, dados=dados))

        return tuple(empresas)
