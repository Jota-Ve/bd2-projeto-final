SET search_path TO public;

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Tipos Personalizados
--

CREATE TYPE public.statusdoacao AS ENUM (
    'recusado',
    'recebido',
    'lido'
);

CREATE TYPE public.tipocanal AS ENUM (
    'privado',
    'público',
    'misto'
);

--
-- Tabelas
--

CREATE TABLE IF NOT EXISTS public.empresa (
    nro SERIAL PRIMARY KEY,
    nome text NOT NULL,
    nome_fantasia text
);

CREATE TABLE IF NOT EXISTS public.conversao (
    moeda text PRIMARY KEY,
    nome text NOT NULL,
    fator_conver numeric(18,8) NOT NULL CHECK (fator_conver > 0)
);

CREATE TABLE IF NOT EXISTS public.pais (
    id_pais SERIAL PRIMARY KEY,
    ddi integer NOT NULL,
    nome text NOT NULL UNIQUE,
    moeda text NOT NULL REFERENCES public.conversao(moeda) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.empresa_pais (
    nro_empresa integer NOT NULL REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE,
    id_nacional text,
    nome_pais text NOT NULL REFERENCES public.pais(nome) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (nro_empresa, nome_pais),
    UNIQUE (id_nacional, nome_pais)
);

CREATE TABLE IF NOT EXISTS public.plataforma (
    nro SERIAL PRIMARY KEY,
    nome text NOT NULL,
    qtd_users integer NOT NULL DEFAULT 0, -- Derivado
    empresa_fund integer NOT NULL REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE,
    empresa_respo integer NOT NULL REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE,
    data_fund date NOT NULL
);

CREATE TABLE IF NOT EXISTS public.usuario (
    nick text PRIMARY KEY,
    email text NOT NULL UNIQUE,
    data_nasc date NOT NULL,
    telefone text NOT NULL,
    end_postal text NOT NULL,
    pais_resid text NOT NULL REFERENCES public.pais(nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.plataforma_usuario (
    nro_plataforma integer NOT NULL REFERENCES public.plataforma(nro) ON UPDATE CASCADE ON DELETE CASCADE,
    nick_usuario text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
    nro_usuario integer NOT NULL,
    PRIMARY KEY (nro_plataforma, nick_usuario)
);

CREATE TABLE IF NOT EXISTS public.streamer_pais (
    nick_streamer text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
    nro_passaporte character varying(9) NOT NULL UNIQUE,
    id_pais integer NOT NULL REFERENCES public.pais(id_pais) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (nick_streamer, id_pais)
);

CREATE TABLE IF NOT EXISTS public.canal (
    nro_plataforma integer NOT NULL REFERENCES public.plataforma(nro) ON UPDATE CASCADE ON DELETE CASCADE,
    nome text NOT NULL,
    tipo public.tipocanal NOT NULL,
    data date NOT NULL,
    descricao text,
    qtd_visualizacoes integer DEFAULT 0, -- Derivado
    qtd_videos_postados integer DEFAULT 0, -- Derivado
    nick_streamer text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (nro_plataforma, nome)
);

CREATE TABLE IF NOT EXISTS public.patrocinio (
    nro_empresa integer NOT NULL REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE,
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    valor numeric(18,2) NOT NULL CHECK (valor > 0),
    PRIMARY KEY (nro_empresa, nro_plataforma, nome_canal),
    FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.nivel_canal (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    nivel smallint NOT NULL CHECK (nivel >= 1 AND nivel <= 5),
    nome_nivel text NOT NULL,
    valor numeric(18,2) NOT NULL CHECK (valor > 0),
    gif bytea,
    PRIMARY KEY (nro_plataforma, nome_canal, nivel),
    FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.inscricao (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    nick_membro text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
    nivel smallint NOT NULL,
    PRIMARY KEY (nro_plataforma, nome_canal, nick_membro),
    FOREIGN KEY (nro_plataforma, nome_canal, nivel) REFERENCES public.nivel_canal(nro_plataforma, nome_canal, nivel) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.video (
    nro_plataforma integer NOT NULL,
    id_video integer NOT NULL,
    nome_canal text NOT NULL,
    titulo text NOT NULL,
    datah timestamp without time zone NOT NULL,
    tema text NOT NULL,
    duracao_segs integer NOT NULL CHECK (duracao_segs > 0),
    visu_simul integer NOT NULL CHECK (visu_simul >= 0),
    visu_total integer NOT NULL CHECK (visu_total >= 0),
    PRIMARY KEY (nro_plataforma, id_video),
    UNIQUE (nro_plataforma, nome_canal, titulo, datah),
    FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.participa (
    nro_plataforma integer NOT NULL,
    id_video integer NOT NULL,
    nick_streamer text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (nro_plataforma, id_video, nick_streamer),
    FOREIGN KEY (nro_plataforma, id_video) REFERENCES public.video(nro_plataforma, id_video) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.comentario (
    nro_plataforma integer NOT NULL,
    id_video integer NOT NULL,
    seq_comentario integer NOT NULL,
    nick_usuario text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
    texto text NOT NULL,
    datah timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    online boolean NOT NULL,
    PRIMARY KEY (nro_plataforma, id_video, seq_comentario),
    FOREIGN KEY (nro_plataforma, id_video) REFERENCES public.video(nro_plataforma, id_video) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.doacao (
    nro_plataforma integer NOT NULL,
    id_video integer NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    valor numeric(18,2) NOT NULL CHECK (valor > 0),
    status public.statusdoacao NOT NULL,
    PRIMARY KEY (nro_plataforma, id_video, seq_comentario, seq_doacao),
    FOREIGN KEY (nro_plataforma, id_video, seq_comentario) REFERENCES public.comentario(nro_plataforma, id_video, seq_comentario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.bitcoin (
    nro_plataforma integer NOT NULL,
    id_video integer NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    txid text NOT NULL UNIQUE,
    PRIMARY KEY (nro_plataforma, id_video, seq_comentario, seq_doacao),
    FOREIGN KEY (nro_plataforma, id_video, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, id_video, seq_comentario, seq_doacao) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.paypal (
    nro_plataforma integer NOT NULL,
    id_video integer NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    idpaypal text NOT NULL UNIQUE,
    PRIMARY KEY (nro_plataforma, id_video, seq_comentario, seq_doacao),
    FOREIGN KEY (nro_plataforma, id_video, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, id_video, seq_comentario, seq_doacao) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.cartao_credito (
    nro_plataforma integer NOT NULL,
    id_video integer NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    nro_cartao text NOT NULL,
    bandeira text NOT NULL,
    PRIMARY KEY (nro_plataforma, id_video, seq_comentario, seq_doacao),
    FOREIGN KEY (nro_plataforma, id_video, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, id_video, seq_comentario, seq_doacao) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.mecanismo_plat (
    nro_plataforma integer NOT NULL,
    id_video integer NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    seq_plataforma integer NOT NULL,
    PRIMARY KEY (nro_plataforma, id_video, seq_comentario, seq_doacao),
    FOREIGN KEY (nro_plataforma, id_video, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, id_video, seq_comentario, seq_doacao) ON UPDATE CASCADE ON DELETE CASCADE
);

--
-- Visões (5)
--

-- 1. Informações do Streamer com Estatísticas Agregadas
CREATE OR REPLACE VIEW public.vw_streamer_info AS
SELECT
    u.nick,
    u.pais_resid,
    COUNT(DISTINCT c.nome) AS total_canais,
    COALESCE(SUM(c.qtd_visualizacoes), 0) AS total_visualizacoes_canais
FROM
    public.usuario u
LEFT JOIN
    public.canal c ON u.nick = c.nick_streamer
GROUP BY
    u.nick, u.pais_resid;

-- 2. Estatísticas do Canal (Visualizações, Inscritos, Valor de Patrocínio)
CREATE OR REPLACE VIEW public.vw_canal_stats AS
SELECT
    c.nro_plataforma,
    c.nome AS nome_canal,
    c.qtd_visualizacoes,
    COUNT(DISTINCT i.nick_membro) AS total_inscritos,
    COALESCE(SUM(p.valor), 0) AS valor_total_patrocinios
FROM
    public.canal c
LEFT JOIN
    public.inscricao i ON c.nro_plataforma = i.nro_plataforma AND c.nome = i.nome_canal
LEFT JOIN
    public.patrocinio p ON c.nro_plataforma = p.nro_plataforma AND c.nome = p.nome_canal
GROUP BY
    c.nro_plataforma, c.nome, c.qtd_visualizacoes;

-- 3. Engajamento de Vídeo
CREATE OR REPLACE VIEW public.vw_video_engagement AS
SELECT
    v.nro_plataforma,
    v.id_video,
    v.titulo,
    v.visu_total,
    COUNT(DISTINCT cm.seq_comentario) AS total_comentarios,
    COALESCE(SUM(d.valor), 0) AS total_doacoes
FROM
    public.video v
LEFT JOIN
    public.comentario cm ON v.nro_plataforma = cm.nro_plataforma AND v.id_video = cm.id_video
LEFT JOIN
    public.doacao d ON cm.nro_plataforma = d.nro_plataforma AND cm.id_video = d.id_video AND cm.seq_comentario = d.seq_comentario
GROUP BY
    v.nro_plataforma, v.id_video, v.titulo, v.visu_total;

-- 4. Top Doadores
CREATE OR REPLACE VIEW public.vw_top_donors AS
SELECT
    u.nick,
    u.pais_resid,
    COUNT(d.seq_doacao) AS qtd_doacoes,
    SUM(d.valor) AS total_doado
FROM
    public.usuario u
JOIN
    public.comentario c ON u.nick = c.nick_usuario
JOIN
    public.doacao d ON c.nro_plataforma = d.nro_plataforma AND c.id_video = d.id_video AND c.seq_comentario = d.seq_comentario
GROUP BY
    u.nick, u.pais_resid
ORDER BY
    total_doado DESC;

-- 5. Crescimento da Plataforma
CREATE OR REPLACE VIEW public.vw_platform_growth AS
SELECT
    p.nro,
    p.nome,
    p.qtd_users,
    COUNT(DISTINCT c.nome) AS qtd_canais,
    COUNT(DISTINCT v.id_video) AS qtd_videos
FROM
    public.plataforma p
LEFT JOIN
    public.canal c ON p.nro = c.nro_plataforma
LEFT JOIN
    public.video v ON c.nro_plataforma = v.nro_plataforma AND c.nome = v.nome_canal
GROUP BY
    p.nro, p.nome, p.qtd_users;

--
-- Visões Materializadas (1)
--

CREATE MATERIALIZED VIEW public.mv_canal_metricas AS
WITH patrocinios AS (
    SELECT 
        p.nro_plataforma, 
        p.nome_canal, 
        COUNT(*)::INTEGER as qtd,
        SUM(p.valor) as total
    FROM public.patrocinio p
    GROUP BY p.nro_plataforma, p.nome_canal
),
inscricoes AS (
    SELECT 
        i.nro_plataforma,
        i.nome_canal,
        COUNT(*)::INTEGER as qtd,
        SUM(nc.valor * cvs.fator_conver) AS total
    FROM
        public.inscricao i
    JOIN
        public.nivel_canal nc ON nc.nro_plataforma = i.nro_plataforma
                       AND nc.nome_canal = i.nome_canal
                       AND nc.nivel = i.nivel
    JOIN
        public.usuario u ON u.nick = i.nick_membro
    JOIN
        public.pais p ON p.nome = u.pais_resid
    JOIN
        public.conversao cvs ON cvs.moeda = p.moeda
    GROUP BY
        i.nro_plataforma,
        i.nome_canal
),
doacoes AS (
    SELECT 
        v.nro_plataforma, 
        v.nome_canal, 
        COUNT(*)::INTEGER as qtd,
        SUM(d.valor * cvs.fator_conver) as total
    FROM public.doacao d
    JOIN public.comentario co ON d.nro_plataforma = co.nro_plataforma 
                       AND d.id_video = co.id_video 
                       AND d.seq_comentario = co.seq_comentario
    JOIN public.video v ON co.nro_plataforma = v.nro_plataforma 
                 AND co.id_video = v.id_video
    JOIN public.usuario u ON co.nick_usuario = u.nick
    JOIN public.pais pa ON u.pais_resid = pa.nome
    JOIN public.conversao cvs ON pa.moeda = cvs.moeda
    WHERE d.status <> 'recusado'
    GROUP BY v.nro_plataforma, v.nome_canal
)
SELECT
    c.nro_plataforma,
    c.nome AS nome_canal,
    COALESCE(p.qtd, 0) AS qtd_patrocinios,
    COALESCE(p.total, 0) AS valor_patrocinios,
    COALESCE(i.qtd, 0) AS qtd_inscricoes,
    COALESCE(i.total, 0) AS valor_inscricoes,
    COALESCE(d.qtd, 0) AS qtd_doacoes,
    COALESCE(d.total, 0) AS valor_doacoes,
    (COALESCE(p.total, 0) + COALESCE(i.total, 0) + COALESCE(d.total, 0)) AS valor_total_geral
FROM
    public.canal c
LEFT JOIN patrocinios p ON c.nro_plataforma = p.nro_plataforma AND c.nome = p.nome_canal
LEFT JOIN inscricoes i ON c.nro_plataforma = i.nro_plataforma AND c.nome = i.nome_canal
LEFT JOIN doacoes d ON c.nro_plataforma = d.nro_plataforma AND c.nome = d.nome_canal;

CREATE INDEX idx_mv_metricas_faturamento ON public.mv_canal_metricas(valor_total_geral DESC);
CREATE INDEX idx_mv_metricas_patrocinios ON public.mv_canal_metricas(valor_patrocinios DESC);
CREATE INDEX idx_mv_metricas_inscricoes ON public.mv_canal_metricas(valor_inscricoes DESC);
CREATE INDEX idx_mv_metricas_doacoes_qtd ON public.mv_canal_metricas(qtd_doacoes DESC);

--
-- Índices (5)
--

-- 1. Índice em status de doação (Usado em Q3, Q7, Q8)
CREATE INDEX IF NOT EXISTS idx_doacao_status ON public.doacao(status);

-- 2. Índice em canal de vídeo (Usado em JOINs e Q3)
CREATE INDEX IF NOT EXISTS idx_video_canal ON public.video(nro_plataforma, nome_canal);

-- 3. Índice em vídeo de comentário (Usado em JOINs)
CREATE INDEX IF NOT EXISTS idx_comentario_video ON public.comentario(nro_plataforma, id_video);

-- 4. Índice em membro de inscrição (Usado em Q2)
CREATE INDEX IF NOT EXISTS idx_inscricao_membro ON public.inscricao(nick_membro);

-- 5. Índice em empresa de patrocínio (Usado em Q1)
CREATE INDEX IF NOT EXISTS idx_patrocinio_empresa ON public.patrocinio(nro_empresa);
--
-- Gatilhos
--

-- 1. Atualizar Plataforma.qtd_users
CREATE OR REPLACE FUNCTION public.fn_update_qtd_users() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE public.plataforma SET qtd_users = qtd_users + 1 WHERE nro = NEW.nro_plataforma;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE public.plataforma SET qtd_users = qtd_users - 1 WHERE nro = OLD.nro_plataforma;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_update_qtd_users
AFTER INSERT OR DELETE ON public.plataforma_usuario
FOR EACH ROW EXECUTE FUNCTION public.fn_update_qtd_users();

-- 2. Atualizar Canal.qtd_visualizacoes (quando visualizações de vídeo atualizam)
CREATE OR REPLACE FUNCTION public.fn_update_qtd_visualizacoes() RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.canal
    SET qtd_visualizacoes = (
        SELECT COALESCE(SUM(visu_total), 0)
        FROM public.video
        WHERE nro_plataforma = NEW.nro_plataforma AND nome_canal = NEW.nome_canal
    )
    WHERE nro_plataforma = NEW.nro_plataforma AND nome = NEW.nome_canal;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_update_qtd_visualizacoes
AFTER UPDATE OF visu_total OR INSERT OR DELETE ON public.video
FOR EACH ROW EXECUTE FUNCTION public.fn_update_qtd_visualizacoes();

-- 3. Atualizar Canal.qtd_videos_postados
CREATE OR REPLACE FUNCTION public.fn_update_qtd_videos() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE public.canal SET qtd_videos_postados = qtd_videos_postados + 1
        WHERE nro_plataforma = NEW.nro_plataforma AND nome = NEW.nome_canal;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE public.canal SET qtd_videos_postados = qtd_videos_postados - 1
        WHERE nro_plataforma = OLD.nro_plataforma AND nome = OLD.nome_canal;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_update_qtd_videos
AFTER INSERT OR DELETE ON public.video
FOR EACH ROW EXECUTE FUNCTION public.fn_update_qtd_videos();
