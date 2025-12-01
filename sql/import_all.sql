-- import_all.sql
-- Executa importação dos CSVs gerados em sql/seeds/ na ordem de dependências.
-- Ajuste os caminhos se seu projeto estiver em outro local.
-- AVISO: Este arquivo usa comandos psql meta (\copy) e deve ser executado com psql cliente.

-- Se quiser truncar antes, descomente as linhas TRUNCATE abaixo (CUIDADO: apaga dados):
BEGIN;
TRUNCATE TABLE public.patrocinio CASCADE;
TRUNCATE TABLE public.streamer_pais CASCADE;
TRUNCATE TABLE public.participa CASCADE;
TRUNCATE TABLE public.inscricao CASCADE;
TRUNCATE TABLE public.mecanismo_plat CASCADE;
TRUNCATE TABLE public.bitcoin CASCADE;
TRUNCATE TABLE public.paypal CASCADE;
TRUNCATE TABLE public.cartao_credito CASCADE;
TRUNCATE TABLE public.doacao CASCADE;
TRUNCATE TABLE public.comentario CASCADE;
TRUNCATE TABLE public.video CASCADE;
TRUNCATE TABLE public.nivel_canal CASCADE;
TRUNCATE TABLE public.canal CASCADE;
TRUNCATE TABLE public.plataforma_usuario CASCADE;
TRUNCATE TABLE public.empresa_pais CASCADE;
TRUNCATE TABLE public.plataforma CASCADE;
TRUNCATE TABLE public.usuario CASCADE;
TRUNCATE TABLE public.empresa CASCADE;
TRUNCATE TABLE public.pais CASCADE;
TRUNCATE TABLE public.conversao CASCADE;
COMMIT;
-- Substitua o caminho abaixo se necessário
\echo 'Importando CSVs de sql/seeds...'

\copy public.conversao(id_conversao,moeda,nome,fator_conver)     FROM 'sql/seeds/conversao.csv'     WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.pais(id_pais,ddi,nome,id_conversao_fk)          FROM 'sql/seeds/pais.csv'          WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.empresa(nro,nome,nome_fantasia)       FROM 'sql/seeds/empresa.csv'       WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.plataforma(nro,nome,qtd_users,empresa_fund,empresa_respo,data_fund)    FROM 'sql/seeds/plataforma.csv'    WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.usuario(id_usuario,nick,email,data_nasc,telefone,end_postal,id_pais_resid_fk)       FROM 'sql/seeds/usuario.csv'       WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.empresa_pais(nro_empresa,id_pais_fk,id_nacional)  FROM 'sql/seeds/empresa_pais.csv'  WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.plataforma_usuario(nro_plataforma_fk,id_usuario_fk,nro_usuario) FROM 'sql/seeds/plataforma_usuario.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.canal(nro_plataforma_fk,id_canal,nome,tipo,data,descricao,id_streamer_fk,qtd_visualizacoes,qtd_videos_postados)         FROM 'sql/seeds/canal.csv'         WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.nivel_canal(nro_plataforma_fk,id_canal_fk,nivel,nome_nivel,valor,gif)   FROM 'sql/seeds/nivel_canal.csv'   WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.video(id_video,nro_plataforma_fk,id_canal_fk,titulo,datah,tema,duracao_segs,visu_simul,visu_total) FROM 'sql/seeds/video.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.comentario(id_video_fk,id_usuario_fk,texto,nro_plataforma_fk,seq_comentario,datah,online) FROM 'sql/seeds/comentario.csv' CSV DELIMITER ';' HEADER ENCODING 'UTF8';
\copy public.doacao(nro_plataforma_fk_comentario,id_video_fk_comentario,seq_comentario_fk,valor,status) FROM 'sql/seeds/doacao.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.cartao_credito(nro_cartao,bandeira,datah,nro_plataforma_fk_doacao,id_video_fk_doacao,seq_comentario_fk_doacao) FROM 'sql/seeds/cartao_credito.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.paypal(nro_plataforma_fk_doacao,id_video_fk_doacao,seq_comentario_fk_doacao,idpaypal) FROM 'sql/seeds/paypal.csv' CSV DELIMITER ';' HEADER ENCODING 'UTF8';
\copy public.bitcoin(txid,nro_plataforma_fk_doacao,id_video_fk_doacao,seq_comentario_fk_doacao) FROM 'sql/seeds/bitcoin.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.mecanismo_plat(nro_plataforma_fk_doacao,id_video_fk_doacao,seq_comentario_fk_doacao,seq_plataforma) FROM 'sql/seeds/mecanismo_plat.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
-- substituir o \copy public.inscricao(...) por este bloco:
CREATE TEMP TABLE tmp_inscricao (
  nro_plataforma_fk integer,
  id_canal_fk integer,
  id_usuario_fk integer,
  nivel smallint
);

\copy tmp_inscricao FROM 'sql/seeds/inscricao.csv' CSV DELIMITER ';' HEADER ENCODING 'UTF8';

INSERT INTO public.inscricao (nro_plataforma_fk, id_canal_fk, id_usuario_fk, nivel)
SELECT nro_plataforma_fk, id_canal_fk, id_usuario_fk, nivel
FROM tmp_inscricao
ON CONFLICT (nro_plataforma_fk, id_canal_fk, id_usuario_fk) DO NOTHING;

DROP TABLE tmp_inscricao;
-- bloco resiliente para importar participa sem erro em duplicatas
CREATE TEMP TABLE tmp_participa (
  nro_plataforma_fk integer,
  id_video_fk integer,
  id_streamer_fk integer
);

\copy tmp_participa FROM 'sql/seeds/participa.csv' CSV DELIMITER ';' HEADER ENCODING 'UTF8';

INSERT INTO public.participa (nro_plataforma_fk, id_video_fk, id_streamer_fk)
SELECT nro_plataforma_fk, id_video_fk, id_streamer_fk
FROM tmp_participa
ON CONFLICT (nro_plataforma_fk, id_video_fk, id_streamer_fk) DO NOTHING;

DROP TABLE tmp_participa;
\copy public.streamer_pais(id_usuario_fk,nro_passaporte,id_pais_fk) FROM 'sql/seeds/streamer_pais.csv' WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');
\copy public.patrocinio(nro_empresa_fk,nro_plataforma_fk,id_canal_fk,valor)    FROM 'sql/seeds/patrocinio.csv'    WITH (FORMAT csv, DELIMITER ';', HEADER true, ENCODING 'UTF8');

\echo 'Import completed.'
