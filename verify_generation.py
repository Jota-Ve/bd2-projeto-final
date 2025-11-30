
import logging
import sys
from datetime import date, datetime
from faker import Faker
from src.fake.pais_fake import PaisFake
from src.fake.usuario_fake import UsuarioFake
from src.fake.plataforma_fake import PlataformaFake
from src.fake.canal_fake import CanalFake
from src.fake.video_fake import VideoFake
from src.fake.comentario_fake import ComentarioFake
from src.fake.doacao_fake import DoacaoFake
from src.fake.streamer_pais_fake import StreamerPaisFake
from src.fake.participa_fake import ParticipaFake
from src.fake.bitcoin_fake import BitcoinFake
from src.fake.paypal_fake import PaypalFake
from src.fake.cartao_credito import CartaoCreditoFake
from src.fake.mecanismo_plat_fake import MecanismoPlatFake
from src.fake.conversao_fake import ConversaoFake

# Setup logging
logging.basicConfig(level=logging.INFO, format='%(message)s')

def verify():
    faker = Faker()
    
    # 1. Generate Conversao (Dependency for Pais)
    conversoes = ConversaoFake.gera(10, faker)
    logging.info(f"Conversoes generated: {len(conversoes)}")
    
    # 2. Generate Pais
    paises = PaisFake.gera(5, faker, *conversoes)
    logging.info(f"Paises generated: {len(paises)}")
    logging.info(f"Pais Sample: {paises[0]}")
    
    # 3. Generate Usuario
    usuarios = UsuarioFake.gera(10, faker, *paises)
    logging.info(f"Usuarios generated: {len(usuarios)}")
    
    # 3.5 Generate Empresa
    from src.fake.empresa_fake import EmpresaFake
    empresas = EmpresaFake.gera(5, faker)
    logging.info(f"Empresas generated: {len(empresas)}")

    # 4. Generate Plataforma
    plataformas = PlataformaFake.gera(2, faker, *empresas)
    logging.info(f"Plataformas generated: {len(plataformas)}")
    
    # 5. Generate Canal
    # Note: CanalFake needs streamers and plataformas
    canais = CanalFake.gera(5, faker, plataformas=plataformas, streamers=usuarios)
    logging.info(f"Canais generated: {len(canais)}")
    logging.info(f"Canal Sample (Check qtd_videos_postados): {canais[0]}")
    assert hasattr(canais[0], 'qtd_videos_postados'), "CanalFake missing qtd_videos_postados"
    
    # 6. Generate Video
    # Note: VideoFake needs canais. Should generate id_video.
    videos = VideoFake.gera(10, faker, canais=canais)
    logging.info(f"Videos generated: {len(videos)}")
    logging.info(f"Video Sample (Check id_video): {videos[0]}")
    assert hasattr(videos[0], 'id_video'), "VideoFake missing id_video"
    
    # 7. Generate StreamerPais
    # Note: StreamerPaisFake needs streamers and paises. Should use ddi_pais.
    streamer_paises = StreamerPaisFake.gera(5, faker, streamers=usuarios, paises=paises)
    logging.info(f"StreamerPais generated: {len(streamer_paises)}")
    logging.info(f"StreamerPais Sample (Check ddi_pais): {streamer_paises[0]}")
    assert isinstance(streamer_paises[0].ddi_pais, int), "StreamerPais ddi_pais should be int"
    
    # 8. Generate Participa
    # Note: ParticipaFake needs videos and streamers. Should use id_video.
    participacoes = ParticipaFake.gera(5, faker, videos=videos, streamers=usuarios)
    logging.info(f"Participacoes generated: {len(participacoes)}")
    logging.info(f"Participa Sample (Check id_video): {participacoes[0]}")
    assert hasattr(participacoes[0], 'id_video'), "ParticipaFake missing id_video"
    
    # 9. Generate Comentario
    # Note: ComentarioFake needs videos and usuarios. Should generate id_comentario and use id_video.
    comentarios = ComentarioFake.gera(10, faker, videos=videos, usuarios=usuarios)
    logging.info(f"Comentarios generated: {len(comentarios)}")
    logging.info(f"Comentario Sample (Check id_comentario, id_video): {comentarios[0]}")
    assert hasattr(comentarios[0], 'id_comentario'), "ComentarioFake missing id_comentario"
    assert hasattr(comentarios[0], 'id_video'), "ComentarioFake missing id_video"
    
    # 10. Generate Doacao
    # Note: DoacaoFake needs comentarios. Should generate id_doacao and use id_comentario.
    doacoes = DoacaoFake.gera(5, faker, comentarios=comentarios)
    logging.info(f"Doacoes generated: {len(doacoes)}")
    logging.info(f"Doacao Sample (Check id_doacao, id_comentario): {doacoes[0]}")
    assert hasattr(doacoes[0], 'id_doacao'), "DoacaoFake missing id_doacao"
    assert hasattr(doacoes[0], 'id_comentario'), "DoacaoFake missing id_comentario"
    
    # 11. Generate Payments (Bitcoin, Paypal, Cartao, Mecanismo)
    # Note: They need doacoes. Should use id_doacao.
    bitcoins = BitcoinFake.gera(1, faker, doacoes=doacoes)
    logging.info(f"Bitcoin generated: {len(bitcoins)}")
    logging.info(f"Bitcoin Sample: {bitcoins[0]}")
    assert hasattr(bitcoins[0], 'id_doacao'), "BitcoinFake missing id_doacao"
    
    paypals = PaypalFake.gera(1, faker, doacoes=doacoes)
    logging.info(f"Paypal generated: {len(paypals)}")
    
    cartoes = CartaoCreditoFake.gera(1, faker, doacoes=doacoes)
    logging.info(f"Cartao generated: {len(cartoes)}")
    
    mecanismos = MecanismoPlatFake.gera(1, faker, doacoes=doacoes)
    logging.info(f"MecanismoPlat generated: {len(mecanismos)}")
    
    print("\nVERIFICATION SUCCESSFUL: All fake classes generated data with expected schema.")

if __name__ == "__main__":
    verify()
