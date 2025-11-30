"""Gerador de CSVs de seed usando os módulos em `src.fake`.

- Gera CSVs em `sql/seeds/` com separador `;`.
- É um gerador tolerante: tenta executar cada fake e, se a chamada falhar por assinatura, registra o erro e continua.

Uso (exemplo):
    python scripts/generate_seed_csvs.py --out sql/seeds --dry-run

Dependências: `faker` (instalar via `pip install faker`).
"""

from __future__ import annotations
import csv
import pathlib
import argparse
import logging
from typing import Sequence, Any

import faker as fkr

# Import dos fakes. Se houver erro de import, o script informa e encerra.
from src.fake import conversao_fake, pais_fake, empresa_fake, empresa_pais_fake, plataforma_fake, usuario_fake, plataforma_usuario_fake, canal_fake, nivel_canal_fake, video_fake, comentario_fake, doacao_fake, cartao_credito, paypal_fake, bitcoin_fake, mecanismo_plat_fake, inscricao_fake, participa_fake, streamer_pais_fake, patrocinio_fake

OUTPUT_DIR_DEFAULT = pathlib.Path("sql") / "seeds"

DEFAULT_COUNTS = {
    "conversao": 100,
    "pais": 100,
    "empresa": 500,
    "empresa_pais": 100,
    "plataforma": 100,
    "usuario": 100000,
    "plataforma_usuario": 100000,
    "canal": 20000,
    "nivel_canal": 20000,
    "video": 50000,
    "comentario": 200000,
    "doacao": 200000,
    "cartao_credito": 100000,
    "paypal": 100000,
    "bitcoin": 100000,
    "mecanismo_plat": 100000,
    "inscricao": 100000,
    "participa": 100000,
    "streamer_pais": 120,
    "patrocinio": 10000,
}


def write_csv(outdir: pathlib.Path, name: str, objs: Sequence[Any], header: Sequence[str]):
    outdir.mkdir(parents=True, exist_ok=True)
    path = outdir / f"{name}.csv"
    with open(path, "w", encoding="utf-8", newline="") as fh:
        writer = csv.writer(fh, delimiter=";")
        writer.writerow(header)
        for o in objs:
            row = []
            for x in o.tupla:
                if x is None:
                    row.append("")
                elif isinstance(x, bytes):
                    # write bytea as hex format acceptable by Postgres: \x<hex>
                    row.append("\\x" + x.hex())
                else:
                    row.append(str(x))
            writer.writerow(row)
    logging.info(f"Wrote {len(objs)} rows to {path}")


def safe_call(klass, qty: int, faker: fkr.Faker, /, *positional, **kw):
    try:
        return klass.gera(qty, faker, *positional, **kw)
    except TypeError as e:
        logging.warning("Signature mismatch calling %s. Error: %s", klass.__name__, e)
    except Exception as e:
        logging.exception("Error generating %s: %s", klass.__name__, e)
    return tuple()


def generate_all(outdir: pathlib.Path, counts: dict[str, int], dry_run: bool = False):
    faker = fkr.Faker()
    results: dict[str, Sequence[Any]] = {}

    logging.info("Gerando conversoes...")
    conversoes = safe_call(conversao_fake.ConversaoFake, counts.get("conversao", 8), faker)
    results["conversao"] = conversoes

    logging.info("Gerando paises...")
    paises = safe_call(pais_fake.PaisFake, counts.get("pais", 8), faker, *conversoes)
    results["pais"] = paises

    logging.info("Gerando empresas...")
    empresas = safe_call(empresa_fake.EmpresaFake, counts.get("empresa", 20), faker)
    results["empresa"] = empresas

    logging.info("Gerando plataformas...")
    plataformas = safe_call(plataforma_fake.PlataformaFake, counts.get("plataforma", 4), faker, *empresas)
    results["plataforma"] = plataformas

    logging.info("Gerando usuarios...")
    usuarios = safe_call(usuario_fake.UsuarioFake, counts.get("usuario", 120), faker, *paises)
    results["usuario"] = usuarios

    logging.info("Gerando plataforma_usuario...")
    plataforma_usuarios = safe_call(
        plataforma_usuario_fake.PlataformaUsuarioFake,
        counts.get("plataforma_usuario", 200),
        faker,
        usuarios=usuarios,
        plataformas=plataformas,
    )
    results["plataforma_usuario"] = plataforma_usuarios

    logging.info("Gerando empresa_pais...")
    empresa_pais = safe_call(
        empresa_pais_fake.EmpresaPaisFake,
        counts.get("empresa_pais", 30),
        faker,
        empresas=empresas,
        paises=paises,
    )
    results["empresa_pais"] = empresa_pais

    logging.info("Gerando canais...")
    canais = safe_call(canal_fake.CanalFake, counts.get("canal", 80), faker, plataformas=plataformas, streamers=usuarios)
    results["canal"] = canais

    logging.info("Gerando nivel_canal...")
    niveis = safe_call(nivel_canal_fake.NivelCanal, counts.get("nivel_canal", 80), faker, canais=canais)
    results["nivel_canal"] = niveis

    logging.info("Gerando videos...")
    videos = safe_call(video_fake.VideoFake, counts.get("video", 300), faker, canais=canais, plataformas=plataformas)
    results["video"] = videos

    logging.info("Gerando comentarios...")
    comentarios = safe_call(comentario_fake.ComentarioFake, counts.get("comentario", 900), faker, videos=videos, usuarios=usuarios)
    results["comentario"] = comentarios

    logging.info("Gerando doacoes...")
    doacoes = safe_call(doacao_fake.DoacaoFake, counts.get("doacao", 600), faker, comentarios=comentarios)
    results["doacao"] = doacoes

    logging.info("Gerando pagamentos (cartao, paypal, bitcoin, mecanismo_plat)...")
    cartoes = safe_call(cartao_credito.CartaoCreditoFake, counts.get("cartao_credito", 200), faker, doacoes=doacoes)
    paypals = safe_call(paypal_fake.PaypalFake, counts.get("paypal", 200), faker, doacoes=doacoes)
    bitcoins = safe_call(bitcoin_fake.BitcoinFake, counts.get("bitcoin", 200), faker, doacoes=doacoes)
    # mecanismo_plat samples `doacoes`; ensure we don't request more samples than available
    max_mecanismos = len(doacoes) if doacoes else 0
    requested_mecanismos = counts.get("mecanismo_plat", 800)
    mecanismos_count = min(requested_mecanismos, max_mecanismos)
    mecanismos = safe_call(mecanismo_plat_fake.MecanismoPlatFake, mecanismos_count, faker, doacoes=doacoes)
    results.update({"cartao_credito": cartoes, "paypal": paypals, "bitcoin": bitcoins, "mecanismo_plat": mecanismos})

    logging.info("Gerando inscricoes/participacoes/streamer_pais/patrocinios...")
    inscricoes = safe_call(inscricao_fake.InscricaoFake, counts.get("inscricao", 400), faker, niveis_canais=niveis, membros=usuarios)
    participa = safe_call(participa_fake.ParticipaFake, counts.get("participa", 400), faker, videos=videos, streamers=usuarios)
    streamer_paises = safe_call(streamer_pais_fake.StreamerPaisFake, counts.get("streamer_pais", 120), faker, streamers=usuarios, paises=paises)
    patrocinios = safe_call(patrocinio_fake.PatrocinioFake, counts.get("patrocinio", 40), faker, canais=canais, empresas=empresas)
    results.update({"inscricao": inscricoes, "participa": participa, "streamer_pais": streamer_paises, "patrocinio": patrocinios})

    # Escreve CSVs
    if not dry_run:
        for key, objs in results.items():
            if not objs:
                logging.info("Skipping empty %s", key)
                continue
            klass = objs[0].__class__
            header = getattr(klass, "CABECALHO", None)
            if header is None:
                logging.warning("No CABECALHO for %s, skipping CSV write", klass.__name__)
                continue
            write_csv(outdir, key, objs, header)
    else:
        logging.info("Dry-run enabled: não escrevendo CSVs")

    return results


def main():
    parser = argparse.ArgumentParser(description="Gerar CSVs de seed a partir dos fakes")
    parser.add_argument("--out", "-o", default=str(OUTPUT_DIR_DEFAULT), help="Diretório de saída (default: sql/seeds)")
    parser.add_argument("--dry-run", action="store_true", help="Executar geração sem escrever arquivos")
    parser.add_argument('--counts', help='path to counts json', default=None)
    parser.add_argument('--autocreate-missing-pais', action='store_true',
                        help='create minimal country entries for conversions that have no matching country in countries.json')
    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")

    outdir = pathlib.Path(args.out)
    counts = DEFAULT_COUNTS.copy()

    if args.counts:
        import json

        with open(args.counts, encoding="utf-8") as fh:
            counts.update(json.load(fh))

    generate_all(outdir, counts, dry_run=args.dry_run)


if __name__ == "__main__":
    main()
