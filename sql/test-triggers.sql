-- Teste de Triggers

-- 1. Teste qtd_users
SELECT 'Teste 1: qtd_users' as teste;
SELECT nro, qtd_users FROM plataforma WHERE nro = 1;
-- Preciso criar um usuario antes
INSERT INTO usuario (nick, email, data_nasc, telefone, end_postal, pais_resid)
VALUES ('novo_user_teste', 'teste@email.com', '2000-01-01', '123456789', 'Rua Teste', 'Brazil')
ON CONFLICT (nick) DO NOTHING;

-- Inserir usuario na plataforma 1
INSERT INTO plataforma_usuario (nro_plataforma, nick_usuario, nro_usuario) 
VALUES (1, 'novo_user_teste', 99999) 
ON CONFLICT DO NOTHING;

SELECT nro, qtd_users FROM plataforma WHERE nro = 1;

-- Deletar
DELETE FROM plataforma_usuario WHERE nro_plataforma = 1 AND nick_usuario = 'novo_user_teste';
SELECT nro, qtd_users FROM plataforma WHERE nro = 1;


-- 2. Teste qtd_videos_postados e qtd_visualizacoes
SELECT 'Teste 2: qtd_videos e qtd_visualizacoes' as teste;
-- Pegar um canal existente
SELECT nro_plataforma, nome, qtd_videos_postados, qtd_visualizacoes FROM canal WHERE nro_plataforma = 1 LIMIT 1;

-- Inserir video
INSERT INTO video (nro_plataforma, id_video, nome_canal, titulo, datah, tema, duracao_segs, visu_simul, visu_total)
VALUES (1, 99999, (SELECT nome FROM canal WHERE nro_plataforma = 1 LIMIT 1), 'Video Teste', NOW(), 'Teste', 60, 10, 100);

SELECT nro_plataforma, nome, qtd_videos_postados, qtd_visualizacoes FROM canal WHERE nro_plataforma = 1 AND nome = (SELECT nome FROM canal WHERE nro_plataforma = 1 LIMIT 1);

-- Atualizar visualizacoes
UPDATE video SET visu_total = 200 WHERE nro_plataforma = 1 AND id_video = 99999;
SELECT nro_plataforma, nome, qtd_videos_postados, qtd_visualizacoes FROM canal WHERE nro_plataforma = 1 AND nome = (SELECT nome FROM canal WHERE nro_plataforma = 1 LIMIT 1);

-- Deletar video
DELETE FROM video WHERE nro_plataforma = 1 AND id_video = 99999;
SELECT nro_plataforma, nome, qtd_videos_postados, qtd_visualizacoes FROM canal WHERE nro_plataforma = 1 AND nome = (SELECT nome FROM canal WHERE nro_plataforma = 1 LIMIT 1);

-- Limpar usuario teste
DELETE FROM usuario WHERE nick = 'novo_user_teste';
