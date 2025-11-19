--
-- PostgreSQL database dump
--

\restrict 3E0GICBHa3rYtPlQpbfX8RhzWSYWxc8eRf9gPlO0nejhOvve8AOKcIuoupM9yFQ

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-19 05:11:35

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS postgres;
--
-- TOC entry 5297 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';


ALTER DATABASE postgres OWNER TO postgres;

\unrestrict 3E0GICBHa3rYtPlQpbfX8RhzWSYWxc8eRf9gPlO0nejhOvve8AOKcIuoupM9yFQ
\connect postgres
\restrict 3E0GICBHa3rYtPlQpbfX8RhzWSYWxc8eRf9gPlO0nejhOvve8AOKcIuoupM9yFQ

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5298 (class 0 OID 0)
-- Dependencies: 5297
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 909 (class 1247 OID 16388)
-- Name: statusdoacao; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.statusdoacao AS ENUM (
    'recusado',
    'recebido',
    'lido'
);


ALTER TYPE public.statusdoacao OWNER TO postgres;

--
-- TOC entry 912 (class 1247 OID 16396)
-- Name: tipocanal; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipocanal AS ENUM (
    'privado',
    'público',
    'misto'
);


ALTER TYPE public.tipocanal OWNER TO postgres;

--
-- TOC entry 287 (class 1255 OID 477658)
-- Name: rank_inscricoes(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rank_inscricoes(k integer) RETURNS TABLE(nro_plataforma integer, nome_canal text, quantidade_membros bigint, valor_total_inscricoes_usd numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.nro_plataforma,
        i.nome_canal,
        COUNT(i.nick_membro) AS quantidade_membros,
        SUM(nc.valor) AS valor_total_inscricoes_USD
    FROM
        inscricao i
    JOIN
        nivel_canal AS nc
        ON i.nro_plataforma = nc.nro_plataforma
        AND i.nome_canal = nc.nome_canal
        AND i.nivel = nc.nivel
    GROUP BY
        i.nro_plataforma, i.nome_canal
    ORDER BY
        valor_total_inscricoes_USD DESC
    LIMIT k;
END;
$$;


ALTER FUNCTION public.rank_inscricoes(k integer) OWNER TO postgres;

--
-- TOC entry 286 (class 1255 OID 477657)
-- Name: rank_patrocinios(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.rank_patrocinios(k integer) RETURNS TABLE(nro_plataforma integer, nome_canal text, quantidade_patrocinios bigint, valor_total_patrocinios_usd numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.nro_plataforma,
        p.nome_canal,
        COUNT(*) AS quantidade_patrocinios,
        SUM(p.valor) AS valor_total_patrocinios_USD
    FROM
        patrocinio p
    GROUP BY
        p.nro_plataforma,
        p.nome_canal
    ORDER BY
        valor_total_patrocinios_USD DESC
    LIMIT
        k;
END;
$$;


ALTER FUNCTION public.rank_patrocinios(k integer) OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 477655)
-- Name: status_doacao(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.status_doacao(channel_name text DEFAULT NULL::text) RETURNS TABLE(nro_plataforma integer, nome_canal text, total_doacoes_usd numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.nro_plataforma,
        d.nome_canal,
        ROUND(SUM(d.valor * cvs.fator_conver), 2) AS total_doacoes_USD
    FROM
        doacao d
    JOIN comentario c ON d.nro_plataforma = c.nro_plataforma
                      AND d.nome_canal = c.nome_canal
                      AND d.titulo_video = c.titulo_video
                      AND d.datah_video = c.datah_video
                      AND d.nick_usuario = c.nick_usuario
                      AND d.seq_comentario = c.seq
    JOIN usuario u ON c.nick_usuario = u.nick
    JOIN pais p ON u.pais_resid = p.nome
    join conversao cvs ON p.moeda = cvs.moeda
    WHERE
        (channel_name IS NULL OR d.nome_canal = channel_name)
        AND d.status <> 'recusado'
    GROUP BY
        d.nro_plataforma,
        d.nome_canal
    ORDER BY
        total_doacoes_USD DESC;
END;
$$;


ALTER FUNCTION public.status_doacao(channel_name text) OWNER TO postgres;

--
-- TOC entry 283 (class 1255 OID 477654)
-- Name: status_inscricao(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.status_inscricao(user_nick text DEFAULT NULL::text) RETURNS TABLE(nick_usuario text, total_de_canais bigint, total_gasto_usd numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.nick_membro,
        COUNT(i.nick_membro) AS total_de_canais,
        ROUND(SUM(nc.valor * cvs.fator_conver), 2) AS total_gasto_USD
    FROM
        inscricao i
    JOIN
        nivel_canal nc ON i.nro_plataforma = nc.nro_plataforma
                        AND i.nome_canal = nc.nome_canal
                        AND i.nivel = nc.nivel
    JOIN
        usuario u ON u.nick = i.nick_membro
    JOIN
        pais p ON p.nome = u.pais_resid
    JOIN
        conversao cvs ON cvs.moeda = p.moeda
    WHERE
        user_nick IS NULL OR i.nick_membro = user_nick
    GROUP BY
        i.nick_membro
    ORDER BY
        total_gasto_USD DESC;
END;
$$;


ALTER FUNCTION public.status_inscricao(user_nick text) OWNER TO postgres;

--
-- TOC entry 282 (class 1255 OID 477653)
-- Name: status_patrocinio(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.status_patrocinio(company_nbr integer DEFAULT NULL::integer) RETURNS TABLE(nro_empresa integer, nome_fantasia text, nro_plataforma integer, nome_canal text, valor_usd numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        e.nro,
        e.nome_fantasia,
        p.nro_plataforma,
        p.nome_canal,
        p.valor AS valor_USD
    FROM
        patrocinio p
    JOIN
        empresa e ON e.nro = p.nro_empresa
    WHERE
        company_nbr IS NULL OR e.nro = company_nbr
    ORDER BY
        e.nro,
        p.valor DESC;
END;
$$;


ALTER FUNCTION public.status_patrocinio(company_nbr integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 267 (class 1259 OID 48471)
-- Name: video; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.video (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    titulo text NOT NULL,
    datah timestamp without time zone NOT NULL,
    tema text NOT NULL,
    duracao_segs integer NOT NULL,
    visu_simul integer NOT NULL,
    visu_total bigint NOT NULL,
    CONSTRAINT video_duracao_segs_check CHECK ((duracao_segs > 0)),
    CONSTRAINT video_visu_simul_check CHECK ((visu_simul >= 0)),
    CONSTRAINT video_visu_total_check CHECK ((visu_total >= 0))
);


ALTER TABLE public.video OWNER TO postgres;

--
-- TOC entry 285 (class 1255 OID 477656)
-- Name: total_doacoes_lidas(public.video); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.total_doacoes_lidas(video_ref public.video DEFAULT NULL::public.video) RETURNS TABLE(nro_plataforma integer, nome_canal text, titulo text, datah timestamp without time zone, total_doacoes_lidas_usd numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.nro_plataforma,
        v.nome_canal,
        v.titulo,
        v.datah,
        ROUND(SUM(d.valor * cvs.fator_conver), 2) AS total_doacoes_lidas_USD
    FROM
        doacao d
    JOIN
        comentario c ON c.nro_plataforma = d.nro_plataforma
                    AND c.nome_canal    = d.nome_canal
                    AND c.titulo_video  = d.titulo_video
                    AND c.datah_video   = d.datah_video
                    AND c.nick_usuario  = d.nick_usuario
                    AND c.seq           = d.seq_comentario
    JOIN
        video v ON v.nro_plataforma = c.nro_plataforma
                AND v.nome_canal    = c.nome_canal
                AND v.titulo        = c.titulo_video
                AND v.datah         = c.datah_video
    JOIN
        usuario u ON c.nick_usuario = u.nick
    JOIN
        pais p ON u.pais_resid = p.nome
    JOIN
        conversao cvs ON p.moeda = cvs.moeda
    WHERE
        d.status = 'lido'
        AND (video_ref IS NULL OR (v.nro_plataforma = (video_ref).nro_plataforma AND
                                   v.nome_canal     = (video_ref).nome_canal AND
                                   v.titulo         = (video_ref).titulo AND
                                   v.datah          = (video_ref).datah)
            )
    GROUP BY
        v.nro_plataforma,
        v.nome_canal,
        v.titulo,
        v.datah
    ORDER BY
        total_doacoes_lidas_USD DESC;
END;
$$;


ALTER FUNCTION public.total_doacoes_lidas(video_ref public.video) OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 48238)
-- Name: bitcoin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bitcoin (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    titulo_video text NOT NULL,
    datah_video timestamp without time zone NOT NULL,
    nick_usuario text NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    txid text NOT NULL
);


ALTER TABLE public.bitcoin OWNER TO postgres;

--
-- TOC entry 5299 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN bitcoin.txid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bitcoin.txid IS 'TXID do Bitcoin é uma sequência única de letras e números que identifica cada transação na blockchain do Bitcoin. Ele funciona como um recibo digital e permite rastrear detalhes da transação';


--
-- TOC entry 220 (class 1259 OID 48251)
-- Name: bitcoin_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bitcoin_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bitcoin_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5300 (class 0 OID 0)
-- Dependencies: 220
-- Name: bitcoin_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitcoin_nro_plataforma_seq OWNED BY public.bitcoin.nro_plataforma;


--
-- TOC entry 221 (class 1259 OID 48252)
-- Name: bitcoin_seq_comentario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bitcoin_seq_comentario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bitcoin_seq_comentario_seq OWNER TO postgres;

--
-- TOC entry 5301 (class 0 OID 0)
-- Dependencies: 221
-- Name: bitcoin_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitcoin_seq_comentario_seq OWNED BY public.bitcoin.seq_comentario;


--
-- TOC entry 222 (class 1259 OID 48253)
-- Name: bitcoin_seq_doacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bitcoin_seq_doacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bitcoin_seq_doacao_seq OWNER TO postgres;

--
-- TOC entry 5302 (class 0 OID 0)
-- Dependencies: 222
-- Name: bitcoin_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitcoin_seq_doacao_seq OWNED BY public.bitcoin.seq_doacao;


--
-- TOC entry 223 (class 1259 OID 48254)
-- Name: canal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.canal (
    nro_plataforma integer NOT NULL,
    nome text NOT NULL,
    tipo public.tipocanal NOT NULL,
    data date NOT NULL,
    descricao text,
    qtd_visualizacoes bigint,
    nick_streamer text NOT NULL
);


ALTER TABLE public.canal OWNER TO postgres;

--
-- TOC entry 5303 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN canal.qtd_visualizacoes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.canal.qtd_visualizacoes IS 'Derivado: manter via batch/trigger/ETL';


--
-- TOC entry 224 (class 1259 OID 48264)
-- Name: canal_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.canal_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.canal_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5304 (class 0 OID 0)
-- Dependencies: 224
-- Name: canal_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.canal_nro_plataforma_seq OWNED BY public.canal.nro_plataforma;


--
-- TOC entry 225 (class 1259 OID 48265)
-- Name: cartao_credito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cartao_credito (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    titulo_video text NOT NULL,
    datah_video timestamp without time zone NOT NULL,
    nick_usuario text NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    nro_cartao text NOT NULL,
    bandeira text NOT NULL
);


ALTER TABLE public.cartao_credito OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 48279)
-- Name: cartao_credito_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cartao_credito_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cartao_credito_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5305 (class 0 OID 0)
-- Dependencies: 226
-- Name: cartao_credito_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartao_credito_nro_plataforma_seq OWNED BY public.cartao_credito.nro_plataforma;


--
-- TOC entry 227 (class 1259 OID 48280)
-- Name: cartao_credito_seq_comentario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cartao_credito_seq_comentario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cartao_credito_seq_comentario_seq OWNER TO postgres;

--
-- TOC entry 5306 (class 0 OID 0)
-- Dependencies: 227
-- Name: cartao_credito_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartao_credito_seq_comentario_seq OWNED BY public.cartao_credito.seq_comentario;


--
-- TOC entry 228 (class 1259 OID 48281)
-- Name: cartao_credito_seq_doacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cartao_credito_seq_doacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cartao_credito_seq_doacao_seq OWNER TO postgres;

--
-- TOC entry 5307 (class 0 OID 0)
-- Dependencies: 228
-- Name: cartao_credito_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartao_credito_seq_doacao_seq OWNED BY public.cartao_credito.seq_doacao;


--
-- TOC entry 229 (class 1259 OID 48282)
-- Name: comentario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comentario (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    titulo_video text NOT NULL,
    datah_video timestamp without time zone NOT NULL,
    nick_usuario text NOT NULL,
    seq integer NOT NULL,
    texto text NOT NULL,
    datah timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    online boolean NOT NULL
);


ALTER TABLE public.comentario OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 48296)
-- Name: comentario_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comentario_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comentario_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5308 (class 0 OID 0)
-- Dependencies: 230
-- Name: comentario_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentario_nro_plataforma_seq OWNED BY public.comentario.nro_plataforma;


--
-- TOC entry 231 (class 1259 OID 48297)
-- Name: comentario_seq_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comentario_seq_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comentario_seq_seq OWNER TO postgres;

--
-- TOC entry 5309 (class 0 OID 0)
-- Dependencies: 231
-- Name: comentario_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentario_seq_seq OWNED BY public.comentario.seq;


--
-- TOC entry 232 (class 1259 OID 48298)
-- Name: conversao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversao (
    moeda text NOT NULL,
    nome text NOT NULL,
    fator_conver numeric(18,8) NOT NULL,
    CONSTRAINT conversao_fator_conver_check CHECK ((fator_conver > (0)::numeric))
);


ALTER TABLE public.conversao OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 48307)
-- Name: doacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doacao (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    titulo_video text NOT NULL,
    datah_video timestamp without time zone NOT NULL,
    nick_usuario text NOT NULL,
    seq_comentario integer NOT NULL,
    seq_pg integer NOT NULL,
    valor numeric(18,2) NOT NULL,
    status public.statusdoacao NOT NULL,
    CONSTRAINT doacao_valor_check CHECK ((valor > (0)::numeric))
);


ALTER TABLE public.doacao OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 48322)
-- Name: doacao_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doacao_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.doacao_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5310 (class 0 OID 0)
-- Dependencies: 234
-- Name: doacao_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doacao_nro_plataforma_seq OWNED BY public.doacao.nro_plataforma;


--
-- TOC entry 235 (class 1259 OID 48323)
-- Name: doacao_seq_comentario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doacao_seq_comentario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.doacao_seq_comentario_seq OWNER TO postgres;

--
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 235
-- Name: doacao_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doacao_seq_comentario_seq OWNED BY public.doacao.seq_comentario;


--
-- TOC entry 236 (class 1259 OID 48324)
-- Name: doacao_seq_pg_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doacao_seq_pg_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.doacao_seq_pg_seq OWNER TO postgres;

--
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 236
-- Name: doacao_seq_pg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doacao_seq_pg_seq OWNED BY public.doacao.seq_pg;


--
-- TOC entry 237 (class 1259 OID 48325)
-- Name: empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa (
    nro integer NOT NULL,
    nome text NOT NULL,
    nome_fantasia text
);


ALTER TABLE public.empresa OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 48332)
-- Name: empresa_nro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empresa_nro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empresa_nro_seq OWNER TO postgres;

--
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 238
-- Name: empresa_nro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_nro_seq OWNED BY public.empresa.nro;


--
-- TOC entry 239 (class 1259 OID 48333)
-- Name: empresa_pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa_pais (
    nro_empresa integer NOT NULL,
    id_nacional text,
    nome_pais text NOT NULL
);


ALTER TABLE public.empresa_pais OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 48340)
-- Name: empresa_pais_nro_empresa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empresa_pais_nro_empresa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empresa_pais_nro_empresa_seq OWNER TO postgres;

--
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 240
-- Name: empresa_pais_nro_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_pais_nro_empresa_seq OWNED BY public.empresa_pais.nro_empresa;


--
-- TOC entry 241 (class 1259 OID 48341)
-- Name: inscricao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inscricao (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    nick_membro text NOT NULL,
    nivel smallint NOT NULL
);


ALTER TABLE public.inscricao OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 48350)
-- Name: inscricao_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inscricao_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inscricao_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5315 (class 0 OID 0)
-- Dependencies: 242
-- Name: inscricao_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inscricao_nro_plataforma_seq OWNED BY public.inscricao.nro_plataforma;


--
-- TOC entry 243 (class 1259 OID 48351)
-- Name: mecanismo_plat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mecanismo_plat (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    titulo_video text NOT NULL,
    datah_video timestamp without time zone NOT NULL,
    nick_usuario text NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    seq integer NOT NULL
);


ALTER TABLE public.mecanismo_plat OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 48364)
-- Name: mecanismo_plat_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mecanismo_plat_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mecanismo_plat_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5316 (class 0 OID 0)
-- Dependencies: 244
-- Name: mecanismo_plat_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_nro_plataforma_seq OWNED BY public.mecanismo_plat.nro_plataforma;


--
-- TOC entry 245 (class 1259 OID 48365)
-- Name: mecanismo_plat_seq_comentario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mecanismo_plat_seq_comentario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mecanismo_plat_seq_comentario_seq OWNER TO postgres;

--
-- TOC entry 5317 (class 0 OID 0)
-- Dependencies: 245
-- Name: mecanismo_plat_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_comentario_seq OWNED BY public.mecanismo_plat.seq_comentario;


--
-- TOC entry 246 (class 1259 OID 48366)
-- Name: mecanismo_plat_seq_doacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mecanismo_plat_seq_doacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mecanismo_plat_seq_doacao_seq OWNER TO postgres;

--
-- TOC entry 5318 (class 0 OID 0)
-- Dependencies: 246
-- Name: mecanismo_plat_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_doacao_seq OWNED BY public.mecanismo_plat.seq_doacao;


--
-- TOC entry 247 (class 1259 OID 48367)
-- Name: mecanismo_plat_seq_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mecanismo_plat_seq_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mecanismo_plat_seq_seq OWNER TO postgres;

--
-- TOC entry 5319 (class 0 OID 0)
-- Dependencies: 247
-- Name: mecanismo_plat_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_seq OWNED BY public.mecanismo_plat.seq;


--
-- TOC entry 248 (class 1259 OID 48368)
-- Name: nivel_canal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nivel_canal (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    nivel smallint NOT NULL,
    nome_nivel text NOT NULL,
    valor numeric(18,2) NOT NULL,
    gif bytea,
    CONSTRAINT nivel_canal_nivel_check CHECK (((nivel >= 1) AND (nivel <= 5))),
    CONSTRAINT nivel_canal_valor_check CHECK ((valor > (0)::numeric))
);


ALTER TABLE public.nivel_canal OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 48380)
-- Name: nivel_canal_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nivel_canal_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nivel_canal_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5320 (class 0 OID 0)
-- Dependencies: 249
-- Name: nivel_canal_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nivel_canal_nro_plataforma_seq OWNED BY public.nivel_canal.nro_plataforma;


--
-- TOC entry 250 (class 1259 OID 48381)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    ddi integer NOT NULL,
    nome text NOT NULL,
    moeda text NOT NULL
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 56883)
-- Name: participa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participa (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    titulo_video text NOT NULL,
    datah_video timestamp without time zone NOT NULL,
    nick_streamer text NOT NULL
);


ALTER TABLE public.participa OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 56893)
-- Name: participa_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.participa_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.participa_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5321 (class 0 OID 0)
-- Dependencies: 270
-- Name: participa_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participa_nro_plataforma_seq OWNED BY public.participa.nro_plataforma;


--
-- TOC entry 251 (class 1259 OID 48400)
-- Name: patrocinio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patrocinio (
    nro_empresa integer NOT NULL,
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    valor numeric(18,2) NOT NULL,
    CONSTRAINT patrocinio_valor_check CHECK ((valor > (0)::numeric))
);


ALTER TABLE public.patrocinio OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 48410)
-- Name: patrocinio_nro_empresa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patrocinio_nro_empresa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patrocinio_nro_empresa_seq OWNER TO postgres;

--
-- TOC entry 5322 (class 0 OID 0)
-- Dependencies: 252
-- Name: patrocinio_nro_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patrocinio_nro_empresa_seq OWNED BY public.patrocinio.nro_empresa;


--
-- TOC entry 253 (class 1259 OID 48411)
-- Name: patrocinio_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patrocinio_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patrocinio_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5323 (class 0 OID 0)
-- Dependencies: 253
-- Name: patrocinio_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patrocinio_nro_plataforma_seq OWNED BY public.patrocinio.nro_plataforma;


--
-- TOC entry 254 (class 1259 OID 48412)
-- Name: paypal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paypal (
    nro_plataforma integer NOT NULL,
    nome_canal text NOT NULL,
    titulo_video text NOT NULL,
    datah_video timestamp without time zone NOT NULL,
    nick_usuario text NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    idpaypal text NOT NULL
);


ALTER TABLE public.paypal OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 48425)
-- Name: paypal_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paypal_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paypal_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5324 (class 0 OID 0)
-- Dependencies: 255
-- Name: paypal_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_nro_plataforma_seq OWNED BY public.paypal.nro_plataforma;


--
-- TOC entry 256 (class 1259 OID 48426)
-- Name: paypal_seq_comentario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paypal_seq_comentario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paypal_seq_comentario_seq OWNER TO postgres;

--
-- TOC entry 5325 (class 0 OID 0)
-- Dependencies: 256
-- Name: paypal_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_seq_comentario_seq OWNED BY public.paypal.seq_comentario;


--
-- TOC entry 257 (class 1259 OID 48427)
-- Name: paypal_seq_doacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paypal_seq_doacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paypal_seq_doacao_seq OWNER TO postgres;

--
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 257
-- Name: paypal_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_seq_doacao_seq OWNED BY public.paypal.seq_doacao;


--
-- TOC entry 258 (class 1259 OID 48428)
-- Name: plataforma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plataforma (
    nro integer NOT NULL,
    nome text NOT NULL,
    qtd_users integer NOT NULL,
    empresa_fund integer NOT NULL,
    empresa_respo integer NOT NULL,
    data_fund date NOT NULL
);


ALTER TABLE public.plataforma OWNER TO postgres;

--
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN plataforma.qtd_users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plataforma.qtd_users IS 'Derivado: manter via batch/trigger/ETL';


--
-- TOC entry 259 (class 1259 OID 48439)
-- Name: plataforma_empresa_fund_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plataforma_empresa_fund_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plataforma_empresa_fund_seq OWNER TO postgres;

--
-- TOC entry 5328 (class 0 OID 0)
-- Dependencies: 259
-- Name: plataforma_empresa_fund_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_empresa_fund_seq OWNED BY public.plataforma.empresa_fund;


--
-- TOC entry 260 (class 1259 OID 48440)
-- Name: plataforma_empresa_respo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plataforma_empresa_respo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plataforma_empresa_respo_seq OWNER TO postgres;

--
-- TOC entry 5329 (class 0 OID 0)
-- Dependencies: 260
-- Name: plataforma_empresa_respo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_empresa_respo_seq OWNED BY public.plataforma.empresa_respo;


--
-- TOC entry 261 (class 1259 OID 48441)
-- Name: plataforma_nro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plataforma_nro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plataforma_nro_seq OWNER TO postgres;

--
-- TOC entry 5330 (class 0 OID 0)
-- Dependencies: 261
-- Name: plataforma_nro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_nro_seq OWNED BY public.plataforma.nro;


--
-- TOC entry 262 (class 1259 OID 48442)
-- Name: plataforma_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plataforma_usuario (
    nro_plataforma integer NOT NULL,
    nick_usuario text NOT NULL,
    nro_usuario integer NOT NULL
);


ALTER TABLE public.plataforma_usuario OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 48450)
-- Name: plataforma_usuario_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plataforma_usuario_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plataforma_usuario_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5331 (class 0 OID 0)
-- Dependencies: 263
-- Name: plataforma_usuario_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_usuario_nro_plataforma_seq OWNED BY public.plataforma_usuario.nro_plataforma;


--
-- TOC entry 264 (class 1259 OID 48451)
-- Name: plataforma_usuario_nro_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plataforma_usuario_nro_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plataforma_usuario_nro_usuario_seq OWNER TO postgres;

--
-- TOC entry 5332 (class 0 OID 0)
-- Dependencies: 264
-- Name: plataforma_usuario_nro_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_usuario_nro_usuario_seq OWNED BY public.plataforma_usuario.nro_usuario;


--
-- TOC entry 265 (class 1259 OID 48452)
-- Name: streamer_pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.streamer_pais (
    nick_streamer text NOT NULL,
    nro_passaporte character varying(9) NOT NULL,
    pais_passaporte text CONSTRAINT streamer_pais_nome_pais_not_null NOT NULL
);


ALTER TABLE public.streamer_pais OWNER TO postgres;

--
-- TOC entry 5333 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN streamer_pais.pais_passaporte; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.streamer_pais.pais_passaporte IS 'Identifica o país do passaporte';


--
-- TOC entry 266 (class 1259 OID 48460)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    nick text NOT NULL,
    email text NOT NULL,
    data_nasc date NOT NULL,
    telefone text NOT NULL,
    end_postal text NOT NULL,
    pais_resid text CONSTRAINT usuario_nome_pais_residencia_not_null NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 5334 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN usuario.pais_resid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.usuario.pais_resid IS 'País de residência';


--
-- TOC entry 268 (class 1259 OID 48487)
-- Name: video_nro_plataforma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.video_nro_plataforma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.video_nro_plataforma_seq OWNER TO postgres;

--
-- TOC entry 5335 (class 0 OID 0)
-- Dependencies: 268
-- Name: video_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.video_nro_plataforma_seq OWNED BY public.video.nro_plataforma;


--
-- TOC entry 4975 (class 2604 OID 56894)
-- Name: bitcoin nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.bitcoin_nro_plataforma_seq'::regclass);


--
-- TOC entry 4976 (class 2604 OID 56895)
-- Name: bitcoin seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN seq_comentario SET DEFAULT nextval('public.bitcoin_seq_comentario_seq'::regclass);


--
-- TOC entry 4977 (class 2604 OID 56896)
-- Name: bitcoin seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN seq_doacao SET DEFAULT nextval('public.bitcoin_seq_doacao_seq'::regclass);


--
-- TOC entry 4978 (class 2604 OID 56897)
-- Name: canal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.canal_nro_plataforma_seq'::regclass);


--
-- TOC entry 4979 (class 2604 OID 56898)
-- Name: cartao_credito nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.cartao_credito_nro_plataforma_seq'::regclass);


--
-- TOC entry 4980 (class 2604 OID 56899)
-- Name: cartao_credito seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN seq_comentario SET DEFAULT nextval('public.cartao_credito_seq_comentario_seq'::regclass);


--
-- TOC entry 4981 (class 2604 OID 56900)
-- Name: cartao_credito seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN seq_doacao SET DEFAULT nextval('public.cartao_credito_seq_doacao_seq'::regclass);


--
-- TOC entry 4982 (class 2604 OID 56901)
-- Name: comentario nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.comentario_nro_plataforma_seq'::regclass);


--
-- TOC entry 4983 (class 2604 OID 56902)
-- Name: comentario seq; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario ALTER COLUMN seq SET DEFAULT nextval('public.comentario_seq_seq'::regclass);


--
-- TOC entry 4985 (class 2604 OID 56903)
-- Name: doacao nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.doacao_nro_plataforma_seq'::regclass);


--
-- TOC entry 4986 (class 2604 OID 56904)
-- Name: doacao seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN seq_comentario SET DEFAULT nextval('public.doacao_seq_comentario_seq'::regclass);


--
-- TOC entry 4987 (class 2604 OID 56905)
-- Name: doacao seq_pg; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN seq_pg SET DEFAULT nextval('public.doacao_seq_pg_seq'::regclass);


--
-- TOC entry 4988 (class 2604 OID 56906)
-- Name: empresa nro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa ALTER COLUMN nro SET DEFAULT nextval('public.empresa_nro_seq'::regclass);


--
-- TOC entry 4989 (class 2604 OID 56907)
-- Name: empresa_pais nro_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais ALTER COLUMN nro_empresa SET DEFAULT nextval('public.empresa_pais_nro_empresa_seq'::regclass);


--
-- TOC entry 4990 (class 2604 OID 56908)
-- Name: inscricao nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.inscricao_nro_plataforma_seq'::regclass);


--
-- TOC entry 4991 (class 2604 OID 56909)
-- Name: mecanismo_plat nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.mecanismo_plat_nro_plataforma_seq'::regclass);


--
-- TOC entry 4992 (class 2604 OID 56910)
-- Name: mecanismo_plat seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq_comentario SET DEFAULT nextval('public.mecanismo_plat_seq_comentario_seq'::regclass);


--
-- TOC entry 4993 (class 2604 OID 56911)
-- Name: mecanismo_plat seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq_doacao SET DEFAULT nextval('public.mecanismo_plat_seq_doacao_seq'::regclass);


--
-- TOC entry 4994 (class 2604 OID 56912)
-- Name: mecanismo_plat seq; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq SET DEFAULT nextval('public.mecanismo_plat_seq_seq'::regclass);


--
-- TOC entry 4995 (class 2604 OID 56913)
-- Name: nivel_canal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_canal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.nivel_canal_nro_plataforma_seq'::regclass);


--
-- TOC entry 5007 (class 2604 OID 56914)
-- Name: participa nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.participa_nro_plataforma_seq'::regclass);


--
-- TOC entry 4996 (class 2604 OID 56915)
-- Name: patrocinio nro_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio ALTER COLUMN nro_empresa SET DEFAULT nextval('public.patrocinio_nro_empresa_seq'::regclass);


--
-- TOC entry 4997 (class 2604 OID 56916)
-- Name: patrocinio nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.patrocinio_nro_plataforma_seq'::regclass);


--
-- TOC entry 4998 (class 2604 OID 56917)
-- Name: paypal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.paypal_nro_plataforma_seq'::regclass);


--
-- TOC entry 4999 (class 2604 OID 56918)
-- Name: paypal seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN seq_comentario SET DEFAULT nextval('public.paypal_seq_comentario_seq'::regclass);


--
-- TOC entry 5000 (class 2604 OID 56919)
-- Name: paypal seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN seq_doacao SET DEFAULT nextval('public.paypal_seq_doacao_seq'::regclass);


--
-- TOC entry 5001 (class 2604 OID 56920)
-- Name: plataforma nro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN nro SET DEFAULT nextval('public.plataforma_nro_seq'::regclass);


--
-- TOC entry 5002 (class 2604 OID 56921)
-- Name: plataforma empresa_fund; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN empresa_fund SET DEFAULT nextval('public.plataforma_empresa_fund_seq'::regclass);


--
-- TOC entry 5003 (class 2604 OID 56922)
-- Name: plataforma empresa_respo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN empresa_respo SET DEFAULT nextval('public.plataforma_empresa_respo_seq'::regclass);


--
-- TOC entry 5004 (class 2604 OID 56923)
-- Name: plataforma_usuario nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.plataforma_usuario_nro_plataforma_seq'::regclass);


--
-- TOC entry 5005 (class 2604 OID 56924)
-- Name: plataforma_usuario nro_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario ALTER COLUMN nro_usuario SET DEFAULT nextval('public.plataforma_usuario_nro_usuario_seq'::regclass);


--
-- TOC entry 5006 (class 2604 OID 56925)
-- Name: video nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.video_nro_plataforma_seq'::regclass);


--
-- TOC entry 5017 (class 2606 OID 48678)
-- Name: bitcoin bitcoin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin
    ADD CONSTRAINT bitcoin_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao);


--
-- TOC entry 5019 (class 2606 OID 48680)
-- Name: bitcoin bitcoin_txid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin
    ADD CONSTRAINT bitcoin_txid_key UNIQUE (txid);


--
-- TOC entry 5021 (class 2606 OID 48682)
-- Name: canal canal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT canal_pkey PRIMARY KEY (nro_plataforma, nome);


--
-- TOC entry 5023 (class 2606 OID 48684)
-- Name: cartao_credito cartao_credito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito
    ADD CONSTRAINT cartao_credito_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao);


--
-- TOC entry 5025 (class 2606 OID 48686)
-- Name: comentario comentario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT comentario_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq);


--
-- TOC entry 5027 (class 2606 OID 48688)
-- Name: conversao conversao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversao
    ADD CONSTRAINT conversao_pkey PRIMARY KEY (moeda);


--
-- TOC entry 5029 (class 2606 OID 48690)
-- Name: doacao doacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao
    ADD CONSTRAINT doacao_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg);


--
-- TOC entry 5033 (class 2606 OID 48692)
-- Name: empresa_pais empresa_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT empresa_pais_pkey PRIMARY KEY (nro_empresa, nome_pais);


--
-- TOC entry 5035 (class 2606 OID 48694)
-- Name: empresa_pais empresa_pais_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT empresa_pais_unique UNIQUE (id_nacional, nome_pais);


--
-- TOC entry 5031 (class 2606 OID 48696)
-- Name: empresa empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (nro);


--
-- TOC entry 5037 (class 2606 OID 48698)
-- Name: inscricao inscricao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT inscricao_pkey PRIMARY KEY (nro_plataforma, nome_canal, nick_membro);


--
-- TOC entry 5039 (class 2606 OID 50969)
-- Name: mecanismo_plat mecanismo_plat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat
    ADD CONSTRAINT mecanismo_plat_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao);


--
-- TOC entry 5041 (class 2606 OID 48702)
-- Name: nivel_canal nivel_canal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_canal
    ADD CONSTRAINT nivel_canal_pkey PRIMARY KEY (nro_plataforma, nome_canal, nivel);


--
-- TOC entry 5043 (class 2606 OID 48704)
-- Name: pais pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (nome);


--
-- TOC entry 5065 (class 2606 OID 57092)
-- Name: participa participa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT participa_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_streamer);


--
-- TOC entry 5045 (class 2606 OID 48708)
-- Name: patrocinio patrocinio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio
    ADD CONSTRAINT patrocinio_pkey PRIMARY KEY (nro_empresa, nro_plataforma, nome_canal);


--
-- TOC entry 5047 (class 2606 OID 48710)
-- Name: paypal paypal_idpaypal_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal
    ADD CONSTRAINT paypal_idpaypal_key UNIQUE (idpaypal);


--
-- TOC entry 5049 (class 2606 OID 48712)
-- Name: paypal paypal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal
    ADD CONSTRAINT paypal_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao);


--
-- TOC entry 5051 (class 2606 OID 48714)
-- Name: plataforma plataforma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT plataforma_pkey PRIMARY KEY (nro);


--
-- TOC entry 5053 (class 2606 OID 48716)
-- Name: plataforma_usuario plataforma_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario
    ADD CONSTRAINT plataforma_usuario_pkey PRIMARY KEY (nro_plataforma, nick_usuario);


--
-- TOC entry 5055 (class 2606 OID 48718)
-- Name: streamer_pais streamer_pais_nro_passaporte_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT streamer_pais_nro_passaporte_key UNIQUE (nro_passaporte);


--
-- TOC entry 5057 (class 2606 OID 48720)
-- Name: streamer_pais streamer_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT streamer_pais_pkey PRIMARY KEY (nick_streamer, pais_passaporte);


--
-- TOC entry 5059 (class 2606 OID 48722)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 5061 (class 2606 OID 48724)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (nick);


--
-- TOC entry 5063 (class 2606 OID 48726)
-- Name: video video_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo, datah);


--
-- TOC entry 5066 (class 2606 OID 48727)
-- Name: bitcoin fk_bitcoin_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin
    ADD CONSTRAINT fk_bitcoin_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5067 (class 2606 OID 48732)
-- Name: canal fk_canal_plataforma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT fk_canal_plataforma FOREIGN KEY (nro_plataforma) REFERENCES public.plataforma(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5068 (class 2606 OID 48737)
-- Name: canal fk_canal_streamer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT fk_canal_streamer FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5069 (class 2606 OID 48742)
-- Name: cartao_credito fk_cartao_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito
    ADD CONSTRAINT fk_cartao_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5070 (class 2606 OID 48747)
-- Name: comentario fk_comentario_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_usuario FOREIGN KEY (nick_usuario) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5071 (class 2606 OID 48752)
-- Name: comentario fk_comentario_video; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_video FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video) REFERENCES public.video(nro_plataforma, nome_canal, titulo, datah) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5072 (class 2606 OID 48757)
-- Name: doacao fk_doacao_comentario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao
    ADD CONSTRAINT fk_doacao_comentario FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario) REFERENCES public.comentario(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5073 (class 2606 OID 48762)
-- Name: empresa_pais fk_empresapais_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT fk_empresapais_empresa FOREIGN KEY (nro_empresa) REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5074 (class 2606 OID 48767)
-- Name: empresa_pais fk_empresapais_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT fk_empresapais_pais FOREIGN KEY (nome_pais) REFERENCES public.pais(nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5075 (class 2606 OID 48772)
-- Name: inscricao fk_inscricao_membro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT fk_inscricao_membro FOREIGN KEY (nick_membro) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5076 (class 2606 OID 48777)
-- Name: inscricao fk_inscricao_nivel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT fk_inscricao_nivel FOREIGN KEY (nro_plataforma, nome_canal, nivel) REFERENCES public.nivel_canal(nro_plataforma, nome_canal, nivel) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5077 (class 2606 OID 48782)
-- Name: mecanismo_plat fk_mecanismo_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat
    ADD CONSTRAINT fk_mecanismo_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5078 (class 2606 OID 48787)
-- Name: nivel_canal fk_nivel_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_canal
    ADD CONSTRAINT fk_nivel_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5079 (class 2606 OID 48792)
-- Name: pais fk_pais_moeda; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT fk_pais_moeda FOREIGN KEY (moeda) REFERENCES public.conversao(moeda) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5091 (class 2606 OID 57093)
-- Name: participa fk_participa_streamer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_streamer FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5092 (class 2606 OID 57098)
-- Name: participa fk_participa_video; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_video FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video) REFERENCES public.video(nro_plataforma, nome_canal, titulo, datah) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5080 (class 2606 OID 48807)
-- Name: patrocinio fk_patrocinio_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio
    ADD CONSTRAINT fk_patrocinio_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5081 (class 2606 OID 48812)
-- Name: patrocinio fk_patrocinio_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio
    ADD CONSTRAINT fk_patrocinio_empresa FOREIGN KEY (nro_empresa) REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5082 (class 2606 OID 48817)
-- Name: paypal fk_paypal_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal
    ADD CONSTRAINT fk_paypal_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5083 (class 2606 OID 48822)
-- Name: plataforma fk_plataforma_empresa_fund; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT fk_plataforma_empresa_fund FOREIGN KEY (empresa_fund) REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5084 (class 2606 OID 48827)
-- Name: plataforma fk_plataforma_empresa_respo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT fk_plataforma_empresa_respo FOREIGN KEY (empresa_respo) REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5085 (class 2606 OID 48832)
-- Name: plataforma_usuario fk_plataforma_usuario_plataforma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario
    ADD CONSTRAINT fk_plataforma_usuario_plataforma FOREIGN KEY (nro_plataforma) REFERENCES public.plataforma(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5086 (class 2606 OID 48837)
-- Name: plataforma_usuario fk_plataforma_usuario_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario
    ADD CONSTRAINT fk_plataforma_usuario_usuario FOREIGN KEY (nick_usuario) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5087 (class 2606 OID 48842)
-- Name: streamer_pais fk_streamerpais_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT fk_streamerpais_pais FOREIGN KEY (pais_passaporte) REFERENCES public.pais(nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5088 (class 2606 OID 48847)
-- Name: streamer_pais fk_streamerpais_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT fk_streamerpais_usuario FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5089 (class 2606 OID 48852)
-- Name: usuario fk_usuario_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_pais FOREIGN KEY (pais_resid) REFERENCES public.pais(nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5090 (class 2606 OID 48857)
-- Name: video fk_video_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT fk_video_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2025-11-19 05:11:36

--
-- PostgreSQL database dump complete
--

\unrestrict 3E0GICBHa3rYtPlQpbfX8RhzWSYWxc8eRf9gPlO0nejhOvve8AOKcIuoupM9yFQ

