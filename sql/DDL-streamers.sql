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
-- Custom Types
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
-- Tables
--
    DROP TABLE IF EXISTS public.empresa CASCADE;
    CREATE TABLE IF NOT EXISTS public.empresa (
        nro SERIAL PRIMARY KEY,
        nome text NOT NULL,
        nome_fantasia text
    );

    DROP TABLE IF EXISTS public.conversao CASCADE;
    CREATE TABLE IF NOT EXISTS public.conversao (
        id SMALLSERIAL PRIMARY KEY,
        moeda_abrev text NOT NULL UNIQUE,
        moeda_nome text NOT NULL, -- Não tem unique pq pode ter moedas com nomes iguais (ex: Dólar de vários países)
        fator_conver numeric(18,8) NOT NULL CHECK (fator_conver > 0)
    );

    DROP TABLE IF EXISTS public.pais CASCADE;
    CREATE TABLE IF NOT EXISTS public.pais (
        id SERIAL PRIMARY KEY,
        ddi integer NOT NULL,
        nome text NOT NULL UNIQUE,
        id_conversao SMALLSERIAL NOT NULL REFERENCES public.conversao(id) ON UPDATE CASCADE ON DELETE CASCADE
    );

    DROP TABLE IF EXISTS public.empresa_pais CASCADE;
    CREATE TABLE IF NOT EXISTS public.empresa_pais (
        nro_empresa integer NOT NULL REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE,
        id_nacional text,
        id_pais SMALLSERIAL NOT NULL REFERENCES public.pais(id) ON UPDATE CASCADE ON DELETE CASCADE,
        PRIMARY KEY (nro_empresa, id_pais),
        UNIQUE (id_nacional, id_pais)
    );

    DROP TABLE IF EXISTS public.plataforma CASCADE;
    CREATE TABLE IF NOT EXISTS public.plataforma (
        nro SERIAL PRIMARY KEY,
        nome text NOT NULL,
        qtd_users integer NOT NULL DEFAULT 0, -- Derivado
        empresa_fund integer NOT NULL REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE,
        empresa_respo integer NOT NULL REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE,
        data_fund date NOT NULL
    );

    DROP TABLE IF EXISTS public.usuario CASCADE;
    CREATE TABLE IF NOT EXISTS public.usuario (
        nick text PRIMARY KEY,
        email text NOT NULL UNIQUE,
        data_nasc date NOT NULL,
        telefone text NOT NULL UNIQUE,
        end_postal text NOT NULL,
        id_pais_resid SMALLSERIAL NOT NULL REFERENCES public.pais(id) ON UPDATE CASCADE ON DELETE CASCADE
    );

    DROP TABLE IF EXISTS public.plataforma_usuario CASCADE;
    CREATE TABLE IF NOT EXISTS public.plataforma_usuario (
        nro_plataforma integer NOT NULL REFERENCES public.plataforma(nro) ON UPDATE CASCADE ON DELETE CASCADE,
        nick_usuario text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
        nro_usuario integer NOT NULL,
        PRIMARY KEY (nro_plataforma, nick_usuario)
    );

    DROP TABLE IF EXISTS public.streamer_pais CASCADE;
    CREATE TABLE IF NOT EXISTS public.streamer_pais (
        nick_streamer text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
        nro_passaporte character varying(9) NOT NULL UNIQUE,
        id_pais SMALLSERIAL NOT NULL REFERENCES public.pais(id) ON UPDATE CASCADE ON DELETE CASCADE,
        PRIMARY KEY (nick_streamer, id_pais)
    );

    DROP TABLE IF EXISTS public.canal CASCADE;
    CREATE TABLE IF NOT EXISTS public.canal (
        nro_plataforma integer NOT NULL REFERENCES public.plataforma(nro) ON UPDATE CASCADE ON DELETE CASCADE,
        nome text NOT NULL,
        tipo public.tipocanal NOT NULL,
        data date NOT NULL,
        descricao text,
        qtd_visualizacoes bigint DEFAULT 0, -- Derivado
        qtd_videos_postados integer DEFAULT 0, -- Derivado
        nick_streamer text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
        PRIMARY KEY (nro_plataforma, nome)
    );

    DROP TABLE IF EXISTS public.patrocinio CASCADE;
    CREATE TABLE IF NOT EXISTS public.patrocinio (
        nro_empresa integer NOT NULL REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE,
        nro_plataforma integer NOT NULL,
        nome_canal text NOT NULL,
        valor numeric(18,2) NOT NULL CHECK (valor > 0),
        PRIMARY KEY (nro_empresa, nro_plataforma, nome_canal),
        FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE
    );

    DROP TABLE IF EXISTS public.nivel_canal CASCADE;
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

    DROP TABLE IF EXISTS public.inscricao CASCADE;
    CREATE TABLE IF NOT EXISTS public.inscricao (
        nro_plataforma integer NOT NULL,
        nome_canal text NOT NULL,
        nick_membro text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
        nivel smallint NOT NULL,
        PRIMARY KEY (nro_plataforma, nome_canal, nick_membro),
        FOREIGN KEY (nro_plataforma, nome_canal, nivel) REFERENCES public.nivel_canal(nro_plataforma, nome_canal, nivel) ON UPDATE CASCADE ON DELETE CASCADE
    );

    DROP TABLE IF EXISTS public.video CASCADE;
    CREATE TABLE IF NOT EXISTS public.video (
        nro_plataforma integer NOT NULL,
        id_video BIGINT NOT NULL, -- TODO Ver o que fazer com id_video (UUID ?)
        nome_canal text NOT NULL,
        titulo text NOT NULL,
        datah timestamp without time zone NOT NULL,
        tema text NOT NULL,
        duracao_segs integer NOT NULL CHECK (duracao_segs > 0),
        visu_simul integer NOT NULL CHECK (visu_simul >= 0),
        visu_total bigint NOT NULL CHECK (visu_total >= 0),
        PRIMARY KEY (nro_plataforma, id_video),
        UNIQUE (nro_plataforma, nome_canal, titulo, datah),
        FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE
    );

    DROP TABLE IF EXISTS public.participa CASCADE;
    CREATE TABLE IF NOT EXISTS public.participa (
        nro_plataforma integer NOT NULL,
        id_video BIGINT NOT NULL,
        nick_streamer text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
        PRIMARY KEY (nro_plataforma, id_video, nick_streamer),
        FOREIGN KEY (nro_plataforma, id_video) REFERENCES public.video(nro_plataforma, id_video) ON UPDATE CASCADE ON DELETE CASCADE
    );

    DROP TABLE IF EXISTS public.comentario CASCADE;
    CREATE TABLE IF NOT EXISTS public.comentario (
        nro_plataforma integer NOT NULL,
        id_video BIGINT NOT NULL,
        seq_comentario integer NOT NULL, -- TODO: TIMESTAMP em milissegundos ?
        nick_usuario text NOT NULL REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE,
        texto text NOT NULL CHECK (LENGTH(TRIM(texto)) > 0),
        datah timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
        online boolean NOT NULL,
        PRIMARY KEY (nro_plataforma, id_video, seq_comentario),
        FOREIGN KEY (nro_plataforma, id_video) REFERENCES public.video(nro_plataforma, id_video) ON UPDATE CASCADE ON DELETE CASCADE
    );

    DROP TABLE IF EXISTS public.doacao CASCADE;
    CREATE TABLE IF NOT EXISTS public.doacao (
        nro_plataforma integer NOT NULL,
        id_video BIGINT NOT NULL,
        seq_comentario integer NOT NULL,
        valor numeric(18,2) NOT NULL CHECK (valor > 0),
        status public.statusdoacao NOT NULL,
        PRIMARY KEY (nro_plataforma, id_video, seq_comentario),
        FOREIGN KEY (nro_plataforma, id_video, seq_comentario) REFERENCES public.comentario(nro_plataforma, id_video, seq_comentario) ON UPDATE CASCADE ON DELETE CASCADE
    );

    DROP TABLE IF EXISTS public.bitcoin CASCADE;
    CREATE TABLE IF NOT EXISTS public.bitcoin (
        nro_plataforma integer NOT NULL,
        id_video BIGINT NOT NULL,
        seq_comentario integer NOT NULL,
        txid text NOT NULL UNIQUE,
        PRIMARY KEY (nro_plataforma, id_video, seq_comentario),
        FOREIGN KEY (nro_plataforma, id_video, seq_comentario) REFERENCES public.doacao(nro_plataforma, id_video, seq_comentario) ON UPDATE CASCADE ON DELETE CASCADE
    );

    DROP TABLE IF EXISTS public.paypal CASCADE;
    CREATE TABLE IF NOT EXISTS public.paypal (
        nro_plataforma integer NOT NULL,
        id_video BIGINT NOT NULL,
        seq_comentario integer NOT NULL,
        idpaypal text NOT NULL UNIQUE,
        PRIMARY KEY (nro_plataforma, id_video, seq_comentario),
        FOREIGN KEY (nro_plataforma, id_video, seq_comentario) REFERENCES public.doacao(nro_plataforma, id_video, seq_comentario) ON UPDATE CASCADE ON DELETE CASCADE
    );

    DROP TABLE IF EXISTS public.cartao_credito CASCADE;
    CREATE TABLE IF NOT EXISTS public.cartao_credito (
        nro_plataforma integer NOT NULL,
        id_video BIGINT NOT NULL,
        seq_comentario integer NOT NULL,
        nro_cartao text NOT NULL,
        bandeira text NOT NULL,
        PRIMARY KEY (nro_plataforma, id_video, seq_comentario),
        FOREIGN KEY (nro_plataforma, id_video, seq_comentario) REFERENCES public.doacao(nro_plataforma, id_video, seq_comentario) ON UPDATE CASCADE ON DELETE CASCADE
    );

    DROP TABLE IF EXISTS public.mecanismo_plat CASCADE;
    CREATE TABLE IF NOT EXISTS public.mecanismo_plat (
        nro_plataforma integer NOT NULL,
        id_video BIGINT NOT NULL,
        seq_comentario integer NOT NULL,
        seq_plataforma integer NOT NULL,
        PRIMARY KEY (nro_plataforma, id_video, seq_comentario),
        FOREIGN KEY (nro_plataforma, id_video, seq_comentario) REFERENCES public.doacao(nro_plataforma, id_video, seq_comentario) ON UPDATE CASCADE ON DELETE CASCADE
    );
