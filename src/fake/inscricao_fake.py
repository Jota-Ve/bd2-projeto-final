"""--sql
CREATE TABLE public.inscricao (
    nro_plataforma_fk integer NOT NULL,
    id_canal_fk integer NOT NULL,
    id_usuario_fk integer NOT NULL,
    nivel smallint NOT NULL,
    CONSTRAINT inscricao_pkey PRIMARY KEY (nro_plataforma_fk, id_canal_fk, id_usuario_fk),
    CONSTRAINT fk_inscricao_nivel FOREIGN KEY (nro_plataforma_fk, id_canal_fk, nivel)
      REFERENCES public.nivel_canal(nro_plataforma_fk, id_canal_fk, nivel) ON UPDATE CASCADE ON DELETE RESTRICT
);
"""

from __future__ import annotations
import dataclasses
import logging
import random
from typing import Any, Sequence

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

    @staticmethod
    def _member_id(membro: usuario_fake.UsuarioFake) -> int:
        # tenta vários atributos comuns (prioriza id_usuario_fk / nro_usuario)
        for attr in ("id_usuario_fk", "nro_usuario", "id_usuario", "id"):
            if hasattr(membro, attr):
                return getattr(membro, attr)
        raise AttributeError("Objeto membro não possui atributo id_usuario_fk/nro_usuario/id_usuario/id")

    @staticmethod
    def _nivel_keys(nivel_obj: Any) -> tuple[int, int, int]:
        """
        Retorna (nro_plataforma, id_canal, nivel) extraídos do objeto nivel_canal.
        Tenta vários nomes de atributo/pk compatíveis com os fakes existentes.
        """
        # nro_plataforma
        nro = None
        if hasattr(nivel_obj, "nro_plataforma"):
            nro = getattr(nivel_obj, "nro_plataforma")
        elif hasattr(nivel_obj, "nro_plataforma_fk"):
            nro = getattr(nivel_obj, "nro_plataforma_fk")
        elif hasattr(nivel_obj, "pk"):
            pk = getattr(nivel_obj, "pk")
            if isinstance(pk, tuple):
                nro = pk[0]

        # id_canal
        id_canal = None
        for a in ("id_canal", "id_canal_fk", "id_canal_fk"):
            if hasattr(nivel_obj, a):
                id_canal = getattr(nivel_obj, a)
                break
        if id_canal is None and hasattr(nivel_obj, "pk"):
            pk = getattr(nivel_obj, "pk")
            if isinstance(pk, tuple) and len(pk) > 1:
                id_canal = pk[1]

        # nivel value
        nivel_val = getattr(nivel_obj, "nivel", None)
        if nivel_val is None and hasattr(nivel_obj, "nivel_canal"):
            nivel_val = getattr(nivel_obj, "nivel_canal")

        if nro is None or id_canal is None or nivel_val is None:
            raise AttributeError("Objeto nivel não possui atributos necessários (nro_plataforma/id_canal/nivel)")
        return int(nro), int(id_canal), int(nivel_val)

    @classmethod
    def gera(
        cls,
        quantidade: int,
        faker: fkr.Faker,
        *args: Any,
        niveis_canais: Sequence[Any],
        membros: Sequence[Any],
        **kwargs: Any,
    ) -> tuple["InscricaoFake", ...]:
        logging.info(f"Iniciando geração de {quantidade:_} inscrições...")

        if quantidade <= 0:
            return tuple()

        if not niveis_canais or not membros:
            logging.warning("Níveis de canal ou membros ausentes — nada a gerar.")
            return tuple()

        max_combs = len(niveis_canais) * len(membros)
        if quantidade > max_combs:
            logging.warning("Quantidade solicitada maior que combinações possíveis (niveis x membros); limitando para evitar duplicatas.")
            quantidade = max_combs

        inscricoes: list['InscricaoFake'] = []

        # estratégia: se o espaço de combinações for pequeno, gere todas e sample; senão amostragem com rejeição
        threshold_full = 2_000_000
        chosen_pairs: set[tuple[int, int]] = set()

        if max_combs <= threshold_full:
            all_pairs = [(i, j) for i in range(len(niveis_canais)) for j in range(len(membros))]
            sampled = random.sample(all_pairs, k=quantidade)
            chosen_pairs.update(sampled)
        else:
            attempts = 0
            max_attempts = max(quantidade * 10, 100000)
            while len(chosen_pairs) < quantidade and attempts < max_attempts:
                i = random.randrange(len(niveis_canais))
                j = random.randrange(len(membros))
                chosen_pairs.add((i, j))
                attempts += 1
            if len(chosen_pairs) < quantidade:
                logging.warning("Não conseguiu amostrar todas as inscrições sem colisões; completando com 'deterministic sampling'.")
                # fallback determinístico para completar
                for i in range(len(niveis_canais)):
                    if len(chosen_pairs) >= quantidade:
                        break
                    for j in range(len(membros)):
                        chosen_pairs.add((i, j))
                        if len(chosen_pairs) >= quantidade:
                            break

        for (i, j) in chosen_pairs:
            nivel_obj = niveis_canais[i]
            membro = membros[j]
            nro_plataforma, id_canal, nivel_val = cls._nivel_keys(nivel_obj)
            member_id = cls._member_id(membro)
            inscricoes.append(cls(nro_plataforma, id_canal, member_id, nivel_val))

        return tuple(inscricoes)
