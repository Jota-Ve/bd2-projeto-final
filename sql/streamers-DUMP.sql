--
-- PostgreSQL database dump
--

\restrict zK6DGwibaHR7MPu4JMxvwyiXnkXQixbGbuvI8mcXM2rbO6TGThhBGK1Gn8oY3xC

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-28 02:23:54

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
-- TOC entry 5290 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';


ALTER DATABASE postgres OWNER TO postgres;

\unrestrict zK6DGwibaHR7MPu4JMxvwyiXnkXQixbGbuvI8mcXM2rbO6TGThhBGK1Gn8oY3xC
\connect postgres
\restrict zK6DGwibaHR7MPu4JMxvwyiXnkXQixbGbuvI8mcXM2rbO6TGThhBGK1Gn8oY3xC

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
-- TOC entry 5291 (class 0 OID 0)
-- Dependencies: 5290
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5292 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 903 (class 1247 OID 16388)
-- Name: statusdoacao; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.statusdoacao AS ENUM (
    'recusado',
    'recebido',
    'lido'
);


ALTER TYPE public.statusdoacao OWNER TO postgres;

--
-- TOC entry 906 (class 1247 OID 16396)
-- Name: tipocanal; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tipocanal AS ENUM (
    'privado',
    'público',
    'misto'
);


ALTER TYPE public.tipocanal OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16403)
-- Name: bitcoin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bitcoin (
    nome_canal text NOT NULL,
    nro_plataforma integer NOT NULL,
    titulo_video text NOT NULL,
    datah_video timestamp without time zone NOT NULL,
    nick_usuario text NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    txid text NOT NULL
);


ALTER TABLE public.bitcoin OWNER TO postgres;

--
-- TOC entry 5293 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN bitcoin.txid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bitcoin.txid IS 'TXID do Bitcoin é uma sequência única de letras e números que identifica cada transação na blockchain do Bitcoin. Ele funciona como um recibo digital e permite rastrear detalhes da transação';


--
-- TOC entry 220 (class 1259 OID 16416)
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
-- TOC entry 5294 (class 0 OID 0)
-- Dependencies: 220
-- Name: bitcoin_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitcoin_nro_plataforma_seq OWNED BY public.bitcoin.nro_plataforma;


--
-- TOC entry 221 (class 1259 OID 16417)
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
-- TOC entry 5295 (class 0 OID 0)
-- Dependencies: 221
-- Name: bitcoin_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitcoin_seq_comentario_seq OWNED BY public.bitcoin.seq_comentario;


--
-- TOC entry 222 (class 1259 OID 16418)
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
-- TOC entry 5296 (class 0 OID 0)
-- Dependencies: 222
-- Name: bitcoin_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitcoin_seq_doacao_seq OWNED BY public.bitcoin.seq_doacao;


--
-- TOC entry 223 (class 1259 OID 16419)
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
-- TOC entry 5297 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN canal.qtd_visualizacoes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.canal.qtd_visualizacoes IS 'Derivado: manter via batch/trigger/ETL';


--
-- TOC entry 224 (class 1259 OID 16429)
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
-- TOC entry 5298 (class 0 OID 0)
-- Dependencies: 224
-- Name: canal_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.canal_nro_plataforma_seq OWNED BY public.canal.nro_plataforma;


--
-- TOC entry 225 (class 1259 OID 16430)
-- Name: cartao_credito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cartao_credito (
    nome_canal text NOT NULL,
    nro_plataforma integer NOT NULL,
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
-- TOC entry 226 (class 1259 OID 16444)
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
-- TOC entry 5299 (class 0 OID 0)
-- Dependencies: 226
-- Name: cartao_credito_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartao_credito_nro_plataforma_seq OWNED BY public.cartao_credito.nro_plataforma;


--
-- TOC entry 227 (class 1259 OID 16445)
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
-- TOC entry 5300 (class 0 OID 0)
-- Dependencies: 227
-- Name: cartao_credito_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartao_credito_seq_comentario_seq OWNED BY public.cartao_credito.seq_comentario;


--
-- TOC entry 228 (class 1259 OID 16446)
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
-- TOC entry 5301 (class 0 OID 0)
-- Dependencies: 228
-- Name: cartao_credito_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartao_credito_seq_doacao_seq OWNED BY public.cartao_credito.seq_doacao;


--
-- TOC entry 229 (class 1259 OID 16447)
-- Name: comentario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comentario (
    nome_canal text NOT NULL,
    nro_plataforma integer NOT NULL,
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
-- TOC entry 230 (class 1259 OID 16461)
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
-- TOC entry 5302 (class 0 OID 0)
-- Dependencies: 230
-- Name: comentario_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentario_nro_plataforma_seq OWNED BY public.comentario.nro_plataforma;


--
-- TOC entry 231 (class 1259 OID 16462)
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
-- TOC entry 5303 (class 0 OID 0)
-- Dependencies: 231
-- Name: comentario_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentario_seq_seq OWNED BY public.comentario.seq;


--
-- TOC entry 232 (class 1259 OID 16463)
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
-- TOC entry 233 (class 1259 OID 16472)
-- Name: doacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doacao (
    nome_canal text NOT NULL,
    nro_plataforma integer NOT NULL,
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
-- TOC entry 234 (class 1259 OID 16487)
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
-- TOC entry 5304 (class 0 OID 0)
-- Dependencies: 234
-- Name: doacao_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doacao_nro_plataforma_seq OWNED BY public.doacao.nro_plataforma;


--
-- TOC entry 235 (class 1259 OID 16488)
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
-- TOC entry 5305 (class 0 OID 0)
-- Dependencies: 235
-- Name: doacao_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doacao_seq_comentario_seq OWNED BY public.doacao.seq_comentario;


--
-- TOC entry 236 (class 1259 OID 16489)
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
-- TOC entry 5306 (class 0 OID 0)
-- Dependencies: 236
-- Name: doacao_seq_pg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doacao_seq_pg_seq OWNED BY public.doacao.seq_pg;


--
-- TOC entry 237 (class 1259 OID 16490)
-- Name: empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa (
    nro integer NOT NULL,
    nome text NOT NULL,
    nome_fantasia text
);


ALTER TABLE public.empresa OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16497)
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
-- TOC entry 5307 (class 0 OID 0)
-- Dependencies: 238
-- Name: empresa_nro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_nro_seq OWNED BY public.empresa.nro;


--
-- TOC entry 239 (class 1259 OID 16498)
-- Name: empresa_pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa_pais (
    nro_empresa integer NOT NULL,
    id_nacional text,
    nome_pais text NOT NULL
);


ALTER TABLE public.empresa_pais OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16505)
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
-- TOC entry 5308 (class 0 OID 0)
-- Dependencies: 240
-- Name: empresa_pais_nro_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_pais_nro_empresa_seq OWNED BY public.empresa_pais.nro_empresa;


--
-- TOC entry 241 (class 1259 OID 16506)
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
-- TOC entry 242 (class 1259 OID 16515)
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
-- TOC entry 5309 (class 0 OID 0)
-- Dependencies: 242
-- Name: inscricao_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inscricao_nro_plataforma_seq OWNED BY public.inscricao.nro_plataforma;


--
-- TOC entry 243 (class 1259 OID 16516)
-- Name: mecanismo_plat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mecanismo_plat (
    nome_canal text NOT NULL,
    nro_plataforma integer NOT NULL,
    titulo_video text NOT NULL,
    datah_video timestamp without time zone NOT NULL,
    nick_usuario text NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    seq integer NOT NULL
);


ALTER TABLE public.mecanismo_plat OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16529)
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
-- TOC entry 5310 (class 0 OID 0)
-- Dependencies: 244
-- Name: mecanismo_plat_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_nro_plataforma_seq OWNED BY public.mecanismo_plat.nro_plataforma;


--
-- TOC entry 245 (class 1259 OID 16530)
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
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 245
-- Name: mecanismo_plat_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_comentario_seq OWNED BY public.mecanismo_plat.seq_comentario;


--
-- TOC entry 246 (class 1259 OID 16531)
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
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 246
-- Name: mecanismo_plat_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_doacao_seq OWNED BY public.mecanismo_plat.seq_doacao;


--
-- TOC entry 247 (class 1259 OID 16532)
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
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 247
-- Name: mecanismo_plat_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_seq OWNED BY public.mecanismo_plat.seq;


--
-- TOC entry 248 (class 1259 OID 16533)
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
-- TOC entry 249 (class 1259 OID 16545)
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
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 249
-- Name: nivel_canal_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nivel_canal_nro_plataforma_seq OWNED BY public.nivel_canal.nro_plataforma;


--
-- TOC entry 250 (class 1259 OID 16546)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    ddi integer NOT NULL,
    nome text NOT NULL,
    moeda text NOT NULL
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 16554)
-- Name: participa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participa (
    nome_canal text NOT NULL,
    nro_plataforma integer NOT NULL,
    titulo_video text NOT NULL,
    datah_video timestamp without time zone NOT NULL,
    nick_streamer text NOT NULL
);


ALTER TABLE public.participa OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 16564)
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
-- TOC entry 5315 (class 0 OID 0)
-- Dependencies: 252
-- Name: participa_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participa_nro_plataforma_seq OWNED BY public.participa.nro_plataforma;


--
-- TOC entry 253 (class 1259 OID 16565)
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
-- TOC entry 254 (class 1259 OID 16575)
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
-- TOC entry 5316 (class 0 OID 0)
-- Dependencies: 254
-- Name: patrocinio_nro_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patrocinio_nro_empresa_seq OWNED BY public.patrocinio.nro_empresa;


--
-- TOC entry 255 (class 1259 OID 16576)
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
-- TOC entry 5317 (class 0 OID 0)
-- Dependencies: 255
-- Name: patrocinio_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patrocinio_nro_plataforma_seq OWNED BY public.patrocinio.nro_plataforma;


--
-- TOC entry 256 (class 1259 OID 16577)
-- Name: paypal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paypal (
    nome_canal text NOT NULL,
    nro_plataforma integer NOT NULL,
    titulo_video text NOT NULL,
    datah_video timestamp without time zone NOT NULL,
    nick_usuario text NOT NULL,
    seq_comentario integer NOT NULL,
    seq_doacao integer NOT NULL,
    idpaypal text NOT NULL
);


ALTER TABLE public.paypal OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 16590)
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
-- TOC entry 5318 (class 0 OID 0)
-- Dependencies: 257
-- Name: paypal_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_nro_plataforma_seq OWNED BY public.paypal.nro_plataforma;


--
-- TOC entry 258 (class 1259 OID 16591)
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
-- TOC entry 5319 (class 0 OID 0)
-- Dependencies: 258
-- Name: paypal_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_seq_comentario_seq OWNED BY public.paypal.seq_comentario;


--
-- TOC entry 259 (class 1259 OID 16592)
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
-- TOC entry 5320 (class 0 OID 0)
-- Dependencies: 259
-- Name: paypal_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_seq_doacao_seq OWNED BY public.paypal.seq_doacao;


--
-- TOC entry 260 (class 1259 OID 16593)
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
-- TOC entry 5321 (class 0 OID 0)
-- Dependencies: 260
-- Name: COLUMN plataforma.qtd_users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plataforma.qtd_users IS 'Derivado: manter via batch/trigger/ETL';


--
-- TOC entry 261 (class 1259 OID 16604)
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
-- TOC entry 5322 (class 0 OID 0)
-- Dependencies: 261
-- Name: plataforma_empresa_fund_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_empresa_fund_seq OWNED BY public.plataforma.empresa_fund;


--
-- TOC entry 262 (class 1259 OID 16605)
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
-- TOC entry 5323 (class 0 OID 0)
-- Dependencies: 262
-- Name: plataforma_empresa_respo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_empresa_respo_seq OWNED BY public.plataforma.empresa_respo;


--
-- TOC entry 263 (class 1259 OID 16606)
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
-- TOC entry 5324 (class 0 OID 0)
-- Dependencies: 263
-- Name: plataforma_nro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_nro_seq OWNED BY public.plataforma.nro;


--
-- TOC entry 264 (class 1259 OID 16607)
-- Name: plataforma_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plataforma_usuario (
    nro_plataforma integer NOT NULL,
    nick_usuario text NOT NULL,
    nro_usuario integer NOT NULL
);


ALTER TABLE public.plataforma_usuario OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 16615)
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
-- TOC entry 5325 (class 0 OID 0)
-- Dependencies: 265
-- Name: plataforma_usuario_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_usuario_nro_plataforma_seq OWNED BY public.plataforma_usuario.nro_plataforma;


--
-- TOC entry 266 (class 1259 OID 16616)
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
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 266
-- Name: plataforma_usuario_nro_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_usuario_nro_usuario_seq OWNED BY public.plataforma_usuario.nro_usuario;


--
-- TOC entry 267 (class 1259 OID 16617)
-- Name: streamer_pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.streamer_pais (
    nick_streamer text NOT NULL,
    nro_passaporte character varying(9) NOT NULL,
    nome_pais text NOT NULL
);


ALTER TABLE public.streamer_pais OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 16625)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    nick text NOT NULL,
    email text NOT NULL,
    data_nasc date NOT NULL,
    telefone text NOT NULL,
    end_postal text NOT NULL,
    nome_pais_residencia text NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 16636)
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
-- TOC entry 270 (class 1259 OID 16652)
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
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 270
-- Name: video_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.video_nro_plataforma_seq OWNED BY public.video.nro_plataforma;


--
-- TOC entry 4969 (class 2604 OID 17628)
-- Name: bitcoin nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.bitcoin_nro_plataforma_seq'::regclass);


--
-- TOC entry 4970 (class 2604 OID 17629)
-- Name: bitcoin seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN seq_comentario SET DEFAULT nextval('public.bitcoin_seq_comentario_seq'::regclass);


--
-- TOC entry 4971 (class 2604 OID 17630)
-- Name: bitcoin seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN seq_doacao SET DEFAULT nextval('public.bitcoin_seq_doacao_seq'::regclass);


--
-- TOC entry 4972 (class 2604 OID 17631)
-- Name: canal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.canal_nro_plataforma_seq'::regclass);


--
-- TOC entry 4973 (class 2604 OID 17632)
-- Name: cartao_credito nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.cartao_credito_nro_plataforma_seq'::regclass);


--
-- TOC entry 4974 (class 2604 OID 17633)
-- Name: cartao_credito seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN seq_comentario SET DEFAULT nextval('public.cartao_credito_seq_comentario_seq'::regclass);


--
-- TOC entry 4975 (class 2604 OID 17634)
-- Name: cartao_credito seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN seq_doacao SET DEFAULT nextval('public.cartao_credito_seq_doacao_seq'::regclass);


--
-- TOC entry 4976 (class 2604 OID 17635)
-- Name: comentario nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.comentario_nro_plataforma_seq'::regclass);


--
-- TOC entry 4977 (class 2604 OID 17636)
-- Name: comentario seq; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario ALTER COLUMN seq SET DEFAULT nextval('public.comentario_seq_seq'::regclass);


--
-- TOC entry 4979 (class 2604 OID 17637)
-- Name: doacao nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.doacao_nro_plataforma_seq'::regclass);


--
-- TOC entry 4980 (class 2604 OID 17638)
-- Name: doacao seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN seq_comentario SET DEFAULT nextval('public.doacao_seq_comentario_seq'::regclass);


--
-- TOC entry 4981 (class 2604 OID 17639)
-- Name: doacao seq_pg; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN seq_pg SET DEFAULT nextval('public.doacao_seq_pg_seq'::regclass);


--
-- TOC entry 4982 (class 2604 OID 17640)
-- Name: empresa nro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa ALTER COLUMN nro SET DEFAULT nextval('public.empresa_nro_seq'::regclass);


--
-- TOC entry 4983 (class 2604 OID 17641)
-- Name: empresa_pais nro_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais ALTER COLUMN nro_empresa SET DEFAULT nextval('public.empresa_pais_nro_empresa_seq'::regclass);


--
-- TOC entry 4984 (class 2604 OID 17642)
-- Name: inscricao nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.inscricao_nro_plataforma_seq'::regclass);


--
-- TOC entry 4985 (class 2604 OID 17643)
-- Name: mecanismo_plat nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.mecanismo_plat_nro_plataforma_seq'::regclass);


--
-- TOC entry 4986 (class 2604 OID 17644)
-- Name: mecanismo_plat seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq_comentario SET DEFAULT nextval('public.mecanismo_plat_seq_comentario_seq'::regclass);


--
-- TOC entry 4987 (class 2604 OID 17645)
-- Name: mecanismo_plat seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq_doacao SET DEFAULT nextval('public.mecanismo_plat_seq_doacao_seq'::regclass);


--
-- TOC entry 4988 (class 2604 OID 17646)
-- Name: mecanismo_plat seq; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq SET DEFAULT nextval('public.mecanismo_plat_seq_seq'::regclass);


--
-- TOC entry 4989 (class 2604 OID 17647)
-- Name: nivel_canal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_canal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.nivel_canal_nro_plataforma_seq'::regclass);


--
-- TOC entry 4990 (class 2604 OID 17648)
-- Name: participa nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.participa_nro_plataforma_seq'::regclass);


--
-- TOC entry 4991 (class 2604 OID 17649)
-- Name: patrocinio nro_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio ALTER COLUMN nro_empresa SET DEFAULT nextval('public.patrocinio_nro_empresa_seq'::regclass);


--
-- TOC entry 4992 (class 2604 OID 17650)
-- Name: patrocinio nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.patrocinio_nro_plataforma_seq'::regclass);


--
-- TOC entry 4993 (class 2604 OID 17651)
-- Name: paypal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.paypal_nro_plataforma_seq'::regclass);


--
-- TOC entry 4994 (class 2604 OID 17652)
-- Name: paypal seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN seq_comentario SET DEFAULT nextval('public.paypal_seq_comentario_seq'::regclass);


--
-- TOC entry 4995 (class 2604 OID 17653)
-- Name: paypal seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN seq_doacao SET DEFAULT nextval('public.paypal_seq_doacao_seq'::regclass);


--
-- TOC entry 4996 (class 2604 OID 17654)
-- Name: plataforma nro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN nro SET DEFAULT nextval('public.plataforma_nro_seq'::regclass);


--
-- TOC entry 4997 (class 2604 OID 17655)
-- Name: plataforma empresa_fund; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN empresa_fund SET DEFAULT nextval('public.plataforma_empresa_fund_seq'::regclass);


--
-- TOC entry 4998 (class 2604 OID 17656)
-- Name: plataforma empresa_respo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN empresa_respo SET DEFAULT nextval('public.plataforma_empresa_respo_seq'::regclass);


--
-- TOC entry 4999 (class 2604 OID 17657)
-- Name: plataforma_usuario nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.plataforma_usuario_nro_plataforma_seq'::regclass);


--
-- TOC entry 5000 (class 2604 OID 17658)
-- Name: plataforma_usuario nro_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario ALTER COLUMN nro_usuario SET DEFAULT nextval('public.plataforma_usuario_nro_usuario_seq'::regclass);


--
-- TOC entry 5001 (class 2604 OID 17659)
-- Name: video nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.video_nro_plataforma_seq'::regclass);


--
-- TOC entry 5233 (class 0 OID 16403)
-- Dependencies: 219
-- Data for Name: bitcoin; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5237 (class 0 OID 16419)
-- Dependencies: 223
-- Data for Name: canal; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5239 (class 0 OID 16430)
-- Dependencies: 225
-- Data for Name: cartao_credito; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5243 (class 0 OID 16447)
-- Dependencies: 229
-- Data for Name: comentario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5246 (class 0 OID 16463)
-- Dependencies: 232
-- Data for Name: conversao; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.conversao VALUES ('ANG', 'Netherlands Antillean guilder', 4.45333539);
INSERT INTO public.conversao VALUES ('BSD', 'Bahamian dollar', 1.90527693);
INSERT INTO public.conversao VALUES ('VND', 'Vietnamese đồng', 1.70597007);
INSERT INTO public.conversao VALUES ('THB', 'Thai baht', 2.53145652);
INSERT INTO public.conversao VALUES ('GHS', 'Ghanaian cedi', 0.26279525);
INSERT INTO public.conversao VALUES ('TVD', 'Tuvaluan dollar', 3.11922458);
INSERT INTO public.conversao VALUES ('XAF', 'Central African CFA franc', 5.38205015);
INSERT INTO public.conversao VALUES ('RWF', 'Rwandan franc', 2.31633206);
INSERT INTO public.conversao VALUES ('UYU', 'Uruguayan peso', 3.84672247);
INSERT INTO public.conversao VALUES ('SEK', 'Swedish krona', 1.00074712);
INSERT INTO public.conversao VALUES ('BOB', 'Bolivian boliviano', 1.57998939);
INSERT INTO public.conversao VALUES ('MUR', 'Mauritian rupee', 4.16642985);
INSERT INTO public.conversao VALUES ('DKK', 'Danish krone', 5.93164580);
INSERT INTO public.conversao VALUES ('SRD', 'Surinamese dollar', 2.43532223);
INSERT INTO public.conversao VALUES ('STD', 'São Tomé and Príncipe dobra', 0.72189775);
INSERT INTO public.conversao VALUES ('KZT', 'Kazakhstani tenge', 0.25683832);
INSERT INTO public.conversao VALUES ('MVR', 'Maldivian rufiyaa', 0.84765668);
INSERT INTO public.conversao VALUES ('PYG', 'Paraguayan guarani', 0.66513549);
INSERT INTO public.conversao VALUES ('SPL', 'Seborga luigino', 4.85183072);
INSERT INTO public.conversao VALUES ('GIP', 'Gibraltar pound', 4.65923527);
INSERT INTO public.conversao VALUES ('BTN', 'Bhutanese ngultrum', 4.87961699);
INSERT INTO public.conversao VALUES ('GEL', 'Georgian lari', 4.93838540);
INSERT INTO public.conversao VALUES ('UAH', 'Ukrainian hryvnia', 3.28619771);
INSERT INTO public.conversao VALUES ('NIO', 'Nicaraguan córdoba', 4.33090268);
INSERT INTO public.conversao VALUES ('VUV', 'Vanuatu vatu', 4.61888448);
INSERT INTO public.conversao VALUES ('GTQ', 'Guatemalan quetzal', 2.73690825);
INSERT INTO public.conversao VALUES ('UGX', 'Ugandan shilling', 5.64729656);
INSERT INTO public.conversao VALUES ('KES', 'Kenyan shilling', 0.21211163);
INSERT INTO public.conversao VALUES ('JOD', 'Jordanian dinar', 3.99623599);
INSERT INTO public.conversao VALUES ('SDG', 'Sudanese pound', 2.82051039);
INSERT INTO public.conversao VALUES ('XDR', 'Special drawing rights', 3.14292333);
INSERT INTO public.conversao VALUES ('XOF', 'West African CFA franc', 2.66196827);
INSERT INTO public.conversao VALUES ('EGP', 'Egyptian pound', 4.81095122);
INSERT INTO public.conversao VALUES ('BMD', 'Bermudian dollar', 5.37347799);
INSERT INTO public.conversao VALUES ('SOS', 'Somali shilling', 6.01539480);
INSERT INTO public.conversao VALUES ('MYR', 'Malaysian ringgit', 0.54367720);
INSERT INTO public.conversao VALUES ('YER', 'Yemeni rial', 2.71836354);
INSERT INTO public.conversao VALUES ('HUF', 'Hungarian forint', 2.33339866);
INSERT INTO public.conversao VALUES ('AUD', 'Australian dollar', 1.51074673);
INSERT INTO public.conversao VALUES ('ILS', 'Israeli new shekel', 6.41987089);
INSERT INTO public.conversao VALUES ('UZS', 'Uzbekistani soʻm', 3.54558341);
INSERT INTO public.conversao VALUES ('AWG', 'Aruban florin', 3.77073013);
INSERT INTO public.conversao VALUES ('AMD', 'Armenian dram', 3.70255447);
INSERT INTO public.conversao VALUES ('LRD', 'Liberian dollar', 4.10229637);
INSERT INTO public.conversao VALUES ('NIS', 'Israeli new shekel', 0.20274451);
INSERT INTO public.conversao VALUES ('EUR', 'Euro', 6.13866927);
INSERT INTO public.conversao VALUES ('TND', 'Tunisian dinar', 3.18984099);
INSERT INTO public.conversao VALUES ('SZL', 'Swazi lilangeni', 4.42721097);
INSERT INTO public.conversao VALUES ('SCR', 'Seychellois rupee', 1.75969388);
INSERT INTO public.conversao VALUES ('LSL', 'Lesotho loti', 4.65730077);
INSERT INTO public.conversao VALUES ('MKD', 'Macedonian denar', 5.30401457);
INSERT INTO public.conversao VALUES ('CUC', 'Cuban convertible peso', 5.12108056);
INSERT INTO public.conversao VALUES ('BYR', 'Belarusian ruble', 3.58702703);
INSERT INTO public.conversao VALUES ('LAK', 'Lao kip', 6.33901618);
INSERT INTO public.conversao VALUES ('CHF', 'Swiss franc', 3.36776415);
INSERT INTO public.conversao VALUES ('FKP', 'Falkland Islands pound', 1.92574758);
INSERT INTO public.conversao VALUES ('CNY', 'Renminbi', 2.22910750);
INSERT INTO public.conversao VALUES ('MRO', 'Mauritanian ouguiya', 1.53488198);
INSERT INTO public.conversao VALUES ('BDT', 'Bangladeshi taka', 3.55032569);
INSERT INTO public.conversao VALUES ('PHP', 'Philippine peso', 2.26971863);
INSERT INTO public.conversao VALUES ('GMD', 'Gambian dalasi', 1.67126859);
INSERT INTO public.conversao VALUES ('CAD', 'Canadian dollar', 2.55745256);
INSERT INTO public.conversao VALUES ('JPY', 'Japanese yen', 0.59361567);
INSERT INTO public.conversao VALUES ('FJD', 'Fijian dollar', 2.45006974);
INSERT INTO public.conversao VALUES ('KMF', 'Comorian franc', 1.59101037);
INSERT INTO public.conversao VALUES ('SBD', 'Solomon Islands dollar', 1.89589779);
INSERT INTO public.conversao VALUES ('LYD', 'Libyan dinar', 0.34216201);
INSERT INTO public.conversao VALUES ('HTG', 'Haitian gourde', 1.90537715);
INSERT INTO public.conversao VALUES ('GBP', 'Pound sterling', 3.97409738);
INSERT INTO public.conversao VALUES ('IDR', 'Indonesian rupiah', 6.08370491);
INSERT INTO public.conversao VALUES ('BND', 'Brunei dollar', 2.73522105);
INSERT INTO public.conversao VALUES ('MOP', 'Macanese pataca', 4.32856990);
INSERT INTO public.conversao VALUES ('COP', 'Colombian peso', 0.45884253);
INSERT INTO public.conversao VALUES ('BAM', 'Bosnia and Herzegovina convertible mark', 4.37155450);
INSERT INTO public.conversao VALUES ('BZD', 'Belize dollar', 1.20070319);
INSERT INTO public.conversao VALUES ('DJF', 'Djiboutian franc', 4.13760327);
INSERT INTO public.conversao VALUES ('PLN', 'Polish zloty', 1.77133372);
INSERT INTO public.conversao VALUES ('MWK', 'Malawian kwacha', 6.38063548);
INSERT INTO public.conversao VALUES ('CLP', 'Chilean peso', 0.11735531);
INSERT INTO public.conversao VALUES ('PGK', 'Papua New Guinean kina', 6.16839669);
INSERT INTO public.conversao VALUES ('KYD', 'Cayman Islands dollar', 2.49174677);
INSERT INTO public.conversao VALUES ('CVE', 'Cape Verdean escudo', 3.01275686);
INSERT INTO public.conversao VALUES ('ZAR', 'South African rand', 0.93864008);
INSERT INTO public.conversao VALUES ('IQD', 'Iraqi dinar', 5.71106081);
INSERT INTO public.conversao VALUES ('KPW', 'North Korean won', 1.40520223);
INSERT INTO public.conversao VALUES ('MMK', 'Burmese kyat', 4.36024117);
INSERT INTO public.conversao VALUES ('KWD', 'Kuwaiti dinar', 3.89930578);
INSERT INTO public.conversao VALUES ('MNT', 'Mongolian tugrik', 4.00486795);
INSERT INTO public.conversao VALUES ('ISK', 'Icelandic króna', 4.82674119);
INSERT INTO public.conversao VALUES ('USD', 'United States dollar', 1.00000000);
INSERT INTO public.conversao VALUES ('MXN', 'Mexican peso', 2.99227971);
INSERT INTO public.conversao VALUES ('INR', 'Indian rupee', 5.16911188);
INSERT INTO public.conversao VALUES ('PEN', 'Peruvian sol', 4.77273990);
INSERT INTO public.conversao VALUES ('GNF', 'Guinean franc', 6.04804739);
INSERT INTO public.conversao VALUES ('BRL', 'Brazilian real', 0.10640229);
INSERT INTO public.conversao VALUES ('CRC', 'Costa Rican colón', 2.41832309);
INSERT INTO public.conversao VALUES ('IMP', 'Manx pound', 2.93947570);
INSERT INTO public.conversao VALUES ('BIF', 'Burundian franc', 0.91876953);
INSERT INTO public.conversao VALUES ('JMD', 'Jamaican dollar', 1.25262726);
INSERT INTO public.conversao VALUES ('RSD', 'Serbian dinar', 3.59582812);
INSERT INTO public.conversao VALUES ('KGS', 'Kyrgyzstani som', 2.04215567);
INSERT INTO public.conversao VALUES ('XCD', 'Eastern Caribbean dollar', 4.19011593);
INSERT INTO public.conversao VALUES ('NGN', 'Nigerian naira', 6.13577816);
INSERT INTO public.conversao VALUES ('NZD', 'New Zealand dollar', 5.93877966);
INSERT INTO public.conversao VALUES ('RON', 'Romanian leu', 2.74898503);
INSERT INTO public.conversao VALUES ('SLL', 'Sierra Leonean leone', 0.33704028);
INSERT INTO public.conversao VALUES ('TWD', 'New Taiwan dollar', 1.33504332);
INSERT INTO public.conversao VALUES ('TJS', 'Tajikistani somoni', 5.10671680);
INSERT INTO public.conversao VALUES ('BWP', 'Botswana pula', 5.48834325);
INSERT INTO public.conversao VALUES ('HKD', 'Hong Kong dollar', 3.73496618);
INSERT INTO public.conversao VALUES ('BBD', 'Barbadian dollar', 3.56038881);
INSERT INTO public.conversao VALUES ('TOP', 'Tongan paʻanga', 4.86973086);
INSERT INTO public.conversao VALUES ('PKR', 'Pakistani rupee', 1.35340429);
INSERT INTO public.conversao VALUES ('ETB', 'Ethiopian birr', 3.33773855);
INSERT INTO public.conversao VALUES ('NAD', 'Namibian dollar', 2.75830028);
INSERT INTO public.conversao VALUES ('TTD', 'Trinidad and Tobago dollar', 2.17501002);
INSERT INTO public.conversao VALUES ('BHD', 'Bahraini dinar', 3.07266787);
INSERT INTO public.conversao VALUES ('CUP', 'Cuban peso', 4.02329073);
INSERT INTO public.conversao VALUES ('AFN', 'Afghan afghani', 2.05763609);
INSERT INTO public.conversao VALUES ('SHP', 'Saint Helena pound', 3.47513462);
INSERT INTO public.conversao VALUES ('SVC', 'Salvadoran colón', 5.91601898);
INSERT INTO public.conversao VALUES ('PAB', 'Panamanian balboa', 3.44058248);
INSERT INTO public.conversao VALUES ('MGA', 'Malagasy ariar', 0.23151706);
INSERT INTO public.conversao VALUES ('AZN', 'Azerbaijani manat', 5.82824632);
INSERT INTO public.conversao VALUES ('MAD', 'Moroccan dirham', 3.97428062);
INSERT INTO public.conversao VALUES ('MDL', 'Moldovan leu', 2.84131872);
INSERT INTO public.conversao VALUES ('ALL', 'Albanian lek', 5.22155693);
INSERT INTO public.conversao VALUES ('CZK', 'Czech koruna', 6.39845274);
INSERT INTO public.conversao VALUES ('OMR', 'Omani rial', 4.00713343);
INSERT INTO public.conversao VALUES ('SYP', 'Syrian pound', 2.61937670);
INSERT INTO public.conversao VALUES ('DOP', 'Dominican peso', 4.38615658);
INSERT INTO public.conversao VALUES ('KRW', 'South Korean won', 1.16972283);
INSERT INTO public.conversao VALUES ('ARS', 'Argentine peso', 1.79419768);
INSERT INTO public.conversao VALUES ('LKR', 'Sri Lankan rupee', 1.71602244);
INSERT INTO public.conversao VALUES ('ZMW', 'Zambian kwacha', 5.23104378);
INSERT INTO public.conversao VALUES ('AOA', 'Angolan kwanza', 2.15551867);
INSERT INTO public.conversao VALUES ('AED', 'United Arab Emirates dirham', 3.71798988);
INSERT INTO public.conversao VALUES ('LBP', 'Lebanese pound', 1.94088568);
INSERT INTO public.conversao VALUES ('LTL', 'Lithuanian litas', 2.37481685);
INSERT INTO public.conversao VALUES ('GGP', 'Guernsey pound', 5.84213493);
INSERT INTO public.conversao VALUES ('BGN', 'Bulgarian lev', 1.59758586);
INSERT INTO public.conversao VALUES ('JEP', 'Jersey pound', 0.64970704);
INSERT INTO public.conversao VALUES ('IRR', 'Iranian rial', 5.66988401);
INSERT INTO public.conversao VALUES ('TZS', 'Tanzanian shilling', 0.05475276);
INSERT INTO public.conversao VALUES ('SGD', 'Singapore dollar', 5.33802134);
INSERT INTO public.conversao VALUES ('WST', 'Samoan tālā', 2.07131554);
INSERT INTO public.conversao VALUES ('SAR', 'Saudi riyal', 5.07199815);
INSERT INTO public.conversao VALUES ('NOK', 'Norwegian krone', 2.51959310);
INSERT INTO public.conversao VALUES ('QAR', 'Qatari riyal', 4.92598065);
INSERT INTO public.conversao VALUES ('HNL', 'Honduran lempira', 3.31064473);
INSERT INTO public.conversao VALUES ('DZD', 'Algerian dinar', 4.56379233);
INSERT INTO public.conversao VALUES ('KHR', 'Cambodian riel', 5.80417444);
INSERT INTO public.conversao VALUES ('NPR', 'Nepalese rupee', 0.80763305);
INSERT INTO public.conversao VALUES ('HRK', 'Croatian kuna', 6.48265968);
INSERT INTO public.conversao VALUES ('GYD', 'Guyanese dollar', 5.87596720);
INSERT INTO public.conversao VALUES ('TMT', 'Turkmenistan manat', 6.34071191);
INSERT INTO public.conversao VALUES ('TRY', 'Turkish lira', 3.17907716);
INSERT INTO public.conversao VALUES ('VEF', 'Venezuelan bolívar', 2.00762208);
INSERT INTO public.conversao VALUES ('XPF', 'CFP franc', 4.82256854);
INSERT INTO public.conversao VALUES ('ERN', 'Eritrean nakfa', 3.71722341);


--
-- TOC entry 5247 (class 0 OID 16472)
-- Dependencies: 233
-- Data for Name: doacao; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5251 (class 0 OID 16490)
-- Dependencies: 237
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.empresa VALUES (1, 'Albuquerque - EI', 'Albuquerque - EI Systems');
INSERT INTO public.empresa VALUES (2, 'Jones, Smith and Sandoval', 'Jones, Smith and Sandoval Inteligência');
INSERT INTO public.empresa VALUES (3, 'Miller Group', 'Miller Group Academia');
INSERT INTO public.empresa VALUES (4, 'Moraes Sampaio e Filhos', 'Moraes Sampaio e Filhos Creative');
INSERT INTO public.empresa VALUES (5, 'Cassiano Porto S.A.', 'Cassiano Porto S.A. Varejo');
INSERT INTO public.empresa VALUES (6, 'Silva Pires - EI', 'Silva Pires - EI Jurídico');
INSERT INTO public.empresa VALUES (7, 'Cassiano', 'Cassiano Ambiental');
INSERT INTO public.empresa VALUES (8, 'Gilmore, Vincent and Barnes', 'Gilmore, Vincent and Barnes Digital');
INSERT INTO public.empresa VALUES (9, 'Willis and Sons', 'Willis and Sons Services');
INSERT INTO public.empresa VALUES (10, 'Fuller, Horton and Bradley', 'Fuller, Horton and Bradley Solutions');
INSERT INTO public.empresa VALUES (11, 'da Paz Sousa S.A.', 'da Paz Sousa S.A. Empreendimentos');
INSERT INTO public.empresa VALUES (12, 'Brito', 'Brito Prime');
INSERT INTO public.empresa VALUES (13, 'da Mota', 'da Mota Next');
INSERT INTO public.empresa VALUES (14, 'Henry-Rice', 'Henry-Rice Formação');
INSERT INTO public.empresa VALUES (15, 'Wright, Summers and Robinson', 'Wright, Summers and Robinson Holdings');
INSERT INTO public.empresa VALUES (16, 'Myers-Gonzalez', 'Myers-Gonzalez Imobiliária');
INSERT INTO public.empresa VALUES (17, 'Oliveira', 'Oliveira Construções');
INSERT INTO public.empresa VALUES (18, 'Rezende S.A.', 'Rezende S.A. Agency');
INSERT INTO public.empresa VALUES (19, 'Roberts Inc', 'Roberts Inc Serviços');
INSERT INTO public.empresa VALUES (20, 'Barros', 'Barros Jurídico');
INSERT INTO public.empresa VALUES (21, 'James-Ramsey', 'James-Ramsey Distribuidora');
INSERT INTO public.empresa VALUES (22, 'Anderson, Cordova and Green', 'Anderson, Cordova and Green Inteligência');
INSERT INTO public.empresa VALUES (23, 'Pires', 'Pires Tech');
INSERT INTO public.empresa VALUES (24, 'Green-Frazier', 'Green-Frazier Prime');
INSERT INTO public.empresa VALUES (25, 'Russell-Stone', 'Russell-Stone Finanças');
INSERT INTO public.empresa VALUES (26, 'Meyer and Sons', 'Meyer and Sons Partners');
INSERT INTO public.empresa VALUES (27, 'Park-Anderson', 'Park-Anderson Transportes');
INSERT INTO public.empresa VALUES (28, 'Randall-Smith', 'Randall-Smith Transportes');
INSERT INTO public.empresa VALUES (29, 'Ellis, Glover and Snyder', 'Ellis, Glover and Snyder Atacado');
INSERT INTO public.empresa VALUES (30, 'Lucas, Hernandez and Smith', 'Lucas, Hernandez and Smith Solutions');
INSERT INTO public.empresa VALUES (31, 'White PLC', 'White PLC Eco');
INSERT INTO public.empresa VALUES (32, 'Reed, Mcconnell and Garcia', 'Reed, Mcconnell and Garcia Ambiental');
INSERT INTO public.empresa VALUES (33, 'Sales da Conceição - ME', 'Sales da Conceição - ME Transportes');
INSERT INTO public.empresa VALUES (34, 'Mendonça', 'Mendonça Hub');
INSERT INTO public.empresa VALUES (35, 'Mccormick Ltd', 'Mccormick Ltd Platform');
INSERT INTO public.empresa VALUES (36, 'da Rocha', 'da Rocha Engine');
INSERT INTO public.empresa VALUES (37, 'Nelson-Jackson', 'Nelson-Jackson Creative');
INSERT INTO public.empresa VALUES (38, 'Sampaio', 'Sampaio Sustentável');
INSERT INTO public.empresa VALUES (39, 'Ray, Andrews and Wilson', 'Ray, Andrews and Wilson Private');
INSERT INTO public.empresa VALUES (40, 'Harris, Sharp and Mckinney', 'Harris, Sharp and Mckinney Construções');
INSERT INTO public.empresa VALUES (41, 'Nunes', 'Nunes Advisors');
INSERT INTO public.empresa VALUES (42, 'Sanders Group', 'Sanders Group Assessoria');
INSERT INTO public.empresa VALUES (43, 'Melo', 'Melo Services');
INSERT INTO public.empresa VALUES (44, 'Farias Farias e Filhos', 'Farias Farias e Filhos Systems');
INSERT INTO public.empresa VALUES (45, 'Rodrigues', 'Rodrigues Educação');
INSERT INTO public.empresa VALUES (46, 'Souza', 'Souza Consultoria');
INSERT INTO public.empresa VALUES (47, 'das Neves Ferreira - EI', 'das Neves Ferreira - EI Operações');
INSERT INTO public.empresa VALUES (48, 'Teixeira', 'Teixeira Agency');
INSERT INTO public.empresa VALUES (49, 'Adams Ltd', 'Adams Ltd Creative');
INSERT INTO public.empresa VALUES (50, 'Ribeiro - EI', 'Ribeiro - EI Verde');
INSERT INTO public.empresa VALUES (51, 'Porto Duarte Ltda.', 'Porto Duarte Ltda. Works');
INSERT INTO public.empresa VALUES (52, 'Carrillo Group', 'Carrillo Group Labs');
INSERT INTO public.empresa VALUES (53, 'Correia Andrade - ME', 'Correia Andrade - ME Factory');
INSERT INTO public.empresa VALUES (54, 'Rezende Ltda.', 'Rezende Ltda. Distribuidora');
INSERT INTO public.empresa VALUES (55, 'Vieira', 'Vieira Finanças');
INSERT INTO public.empresa VALUES (56, 'Smith-May', 'Smith-May Works');
INSERT INTO public.empresa VALUES (57, 'Mullen-Christensen', 'Mullen-Christensen Assessoria');
INSERT INTO public.empresa VALUES (58, 'Brown Inc', 'Brown Inc Obras');
INSERT INTO public.empresa VALUES (59, 'Warner PLC', 'Warner PLC Design');
INSERT INTO public.empresa VALUES (60, 'Powell-Gilbert', 'Powell-Gilbert Engine');
INSERT INTO public.empresa VALUES (61, 'Gardner Ltd', 'Gardner Ltd Hub');
INSERT INTO public.empresa VALUES (62, 'Barbosa', 'Barbosa Studio');
INSERT INTO public.empresa VALUES (63, 'Garcia - EI', 'Garcia - EI Transportes');
INSERT INTO public.empresa VALUES (64, 'Taylor-Shelton', 'Taylor-Shelton Boutique');
INSERT INTO public.empresa VALUES (65, 'Thomas, Huerta and Compton', 'Thomas, Huerta and Compton Soluções');
INSERT INTO public.empresa VALUES (66, 'Costa', 'Costa Solutions');
INSERT INTO public.empresa VALUES (67, 'Vargas', 'Vargas Academia');
INSERT INTO public.empresa VALUES (68, 'Coleman, Reed and Marshall', 'Coleman, Reed and Marshall Design');
INSERT INTO public.empresa VALUES (69, 'Alves Castro - ME', 'Alves Castro - ME Soluções');
INSERT INTO public.empresa VALUES (70, 'Mcdonald, Morgan and Kelly', 'Mcdonald, Morgan and Kelly Wellness');
INSERT INTO public.empresa VALUES (71, 'Barber Group', 'Barber Group Inteligência');
INSERT INTO public.empresa VALUES (72, 'das Neves Sousa e Filhos', 'das Neves Sousa e Filhos Smart');
INSERT INTO public.empresa VALUES (73, 'Smith and Sons', 'Smith and Sons Engine');
INSERT INTO public.empresa VALUES (74, 'Thompson PLC', 'Thompson PLC Formação');
INSERT INTO public.empresa VALUES (75, 'Porto', 'Porto Smart');
INSERT INTO public.empresa VALUES (76, 'Aguirre, Poole and Beasley', 'Aguirre, Poole and Beasley Legal');
INSERT INTO public.empresa VALUES (77, 'Albuquerque', 'Albuquerque Partners');
INSERT INTO public.empresa VALUES (78, 'Vasconcelos Casa Grande - ME', 'Vasconcelos Casa Grande - ME Formação');
INSERT INTO public.empresa VALUES (79, 'Leão', 'Leão Alimentos');
INSERT INTO public.empresa VALUES (80, 'Rocha S.A.', 'Rocha S.A. Strategies');
INSERT INTO public.empresa VALUES (81, 'Sampaio Duarte - ME', 'Sampaio Duarte - ME Atacado');
INSERT INTO public.empresa VALUES (82, 'Andrade', 'Andrade Alimentos');
INSERT INTO public.empresa VALUES (83, 'Crawford, Rhodes and Walsh', 'Crawford, Rhodes and Walsh Logística');
INSERT INTO public.empresa VALUES (84, 'Peixoto Farias - ME', 'Peixoto Farias - ME Distribuidora');
INSERT INTO public.empresa VALUES (85, 'Dennis-Cunningham', 'Dennis-Cunningham Academia');
INSERT INTO public.empresa VALUES (86, 'Roach, Sanchez and Henson', 'Roach, Sanchez and Henson Culinária');
INSERT INTO public.empresa VALUES (87, 'Stewart, Blackwell and Hubbard', 'Stewart, Blackwell and Hubbard Distribuidora');
INSERT INTO public.empresa VALUES (88, 'Aparecida Brito Ltda.', 'Aparecida Brito Ltda. Alimentos');
INSERT INTO public.empresa VALUES (89, 'Murphy-Anderson', 'Murphy-Anderson Inovação');
INSERT INTO public.empresa VALUES (90, 'Mckay Group', 'Mckay Group Transportes');
INSERT INTO public.empresa VALUES (91, 'Dixon Inc', 'Dixon Inc Operações');
INSERT INTO public.empresa VALUES (92, 'Woods-Turner', 'Woods-Turner Networks');
INSERT INTO public.empresa VALUES (93, 'Garza, Gonzalez and Soto', 'Garza, Gonzalez and Soto Ambiental');
INSERT INTO public.empresa VALUES (94, 'Borges', 'Borges Culinária');
INSERT INTO public.empresa VALUES (95, 'das Neves', 'das Neves Wellness');
INSERT INTO public.empresa VALUES (96, 'Blake-Allen', 'Blake-Allen Inovação');
INSERT INTO public.empresa VALUES (97, 'Sales', 'Sales Verde');
INSERT INTO public.empresa VALUES (98, 'Ferguson Group', 'Ferguson Group Construções');
INSERT INTO public.empresa VALUES (99, 'da Rosa', 'da Rosa Wellness');
INSERT INTO public.empresa VALUES (100, 'Meadows LLC', 'Meadows LLC Boutique');
INSERT INTO public.empresa VALUES (101, 'Novaes', 'Novaes Platform');
INSERT INTO public.empresa VALUES (102, 'Carvalho', 'Carvalho Alimentos');
INSERT INTO public.empresa VALUES (103, 'Freitas - ME', 'Freitas - ME Assessoria');
INSERT INTO public.empresa VALUES (104, 'Jesus S/A', 'Jesus S/A Tech');
INSERT INTO public.empresa VALUES (105, 'Albuquerque Ltda.', 'Albuquerque Ltda. Advisors');
INSERT INTO public.empresa VALUES (106, 'da Mota Nogueira S.A.', 'da Mota Nogueira S.A. Empreendimentos');
INSERT INTO public.empresa VALUES (107, 'Richardson-Williams', 'Richardson-Williams Global');
INSERT INTO public.empresa VALUES (108, 'Macedo Guerra S/A', 'Macedo Guerra S/A Serviços');
INSERT INTO public.empresa VALUES (109, 'Fogaça', 'Fogaça Grupo');
INSERT INTO public.empresa VALUES (110, 'Leon LLC', 'Leon LLC Studio');
INSERT INTO public.empresa VALUES (111, 'Gomes Sá S/A', 'Gomes Sá S/A Sustentável');
INSERT INTO public.empresa VALUES (112, 'Stewart, Sanchez and Gomez', 'Stewart, Sanchez and Gomez Verde');
INSERT INTO public.empresa VALUES (113, 'da Conceição', 'da Conceição Next');
INSERT INTO public.empresa VALUES (114, 'Fogaça Azevedo S.A.', 'Fogaça Azevedo S.A. Transportes');
INSERT INTO public.empresa VALUES (115, 'das Neves S.A.', 'das Neves S.A. Operações');
INSERT INTO public.empresa VALUES (116, 'Gonçalves', 'Gonçalves Gastronomia');
INSERT INTO public.empresa VALUES (117, 'Benjamin-Vargas', 'Benjamin-Vargas Global');
INSERT INTO public.empresa VALUES (118, 'Nielsen-Jones', 'Nielsen-Jones Treinamento');
INSERT INTO public.empresa VALUES (119, 'Dias Novaes Ltda.', 'Dias Novaes Ltda. Operações');
INSERT INTO public.empresa VALUES (120, 'Lima', 'Lima Tech');
INSERT INTO public.empresa VALUES (121, 'Jones-Hall', 'Jones-Hall Platform');
INSERT INTO public.empresa VALUES (122, 'Hall, Gonzalez and Miller', 'Hall, Gonzalez and Miller Agency');
INSERT INTO public.empresa VALUES (123, 'Hill Inc', 'Hill Inc Grupo');
INSERT INTO public.empresa VALUES (124, 'Martinez, Jenkins and Pierce', 'Martinez, Jenkins and Pierce Alimentos');
INSERT INTO public.empresa VALUES (125, 'Martin-Weiss', 'Martin-Weiss Platform');
INSERT INTO public.empresa VALUES (126, 'Câmara Fogaça - EI', 'Câmara Fogaça - EI Alimentos');
INSERT INTO public.empresa VALUES (127, 'Diaz and Sons', 'Diaz and Sons Atelier');
INSERT INTO public.empresa VALUES (128, 'Bennett Ltd', 'Bennett Ltd Comércio');
INSERT INTO public.empresa VALUES (129, 'Monteiro', 'Monteiro Legal');
INSERT INTO public.empresa VALUES (130, 'Price, Salazar and Buchanan', 'Price, Salazar and Buchanan Varejo');
INSERT INTO public.empresa VALUES (131, 'Jackson, Boyd and Douglas', 'Jackson, Boyd and Douglas Delícias');
INSERT INTO public.empresa VALUES (132, 'White and Sons', 'White and Sons Prime');
INSERT INTO public.empresa VALUES (133, 'Andrade - EI', 'Andrade - EI Holdings');
INSERT INTO public.empresa VALUES (134, 'Lopes - EI', 'Lopes - EI Frete');
INSERT INTO public.empresa VALUES (135, 'Farias Ltda.', 'Farias Ltda. Eco');
INSERT INTO public.empresa VALUES (136, 'Garcia Ltd', 'Garcia Ltd Enterprises');
INSERT INTO public.empresa VALUES (137, 'Araújo Melo - EI', 'Araújo Melo - EI Consulting');
INSERT INTO public.empresa VALUES (138, 'Jones LLC', 'Jones LLC Edge');
INSERT INTO public.empresa VALUES (139, 'Nelson-Mcfarland', 'Nelson-Mcfarland Solutions');
INSERT INTO public.empresa VALUES (140, 'Yu, Wright and Taylor', 'Yu, Wright and Taylor Sustentável');
INSERT INTO public.empresa VALUES (141, 'Cassiano Carvalho - EI', 'Cassiano Carvalho - EI Formação');
INSERT INTO public.empresa VALUES (142, 'Allen-White', 'Allen-White Clinic');
INSERT INTO public.empresa VALUES (143, 'Moura Aparecida - EI', 'Moura Aparecida - EI Tech');
INSERT INTO public.empresa VALUES (144, 'Carter-Miller', 'Carter-Miller Construções');
INSERT INTO public.empresa VALUES (145, 'Sims, Pope and Barrett', 'Sims, Pope and Barrett Boutique');
INSERT INTO public.empresa VALUES (146, 'Cortez PLC', 'Cortez PLC Boutique');
INSERT INTO public.empresa VALUES (147, 'Miller, Rose and Conway', 'Miller, Rose and Conway Platform');
INSERT INTO public.empresa VALUES (148, 'Peixoto Ltda.', 'Peixoto Ltda. Delícias');
INSERT INTO public.empresa VALUES (149, 'Castro Vieira S.A.', 'Castro Vieira S.A. Ambiental');
INSERT INTO public.empresa VALUES (150, 'Smith, Austin and Parsons', 'Smith, Austin and Parsons Empreendimentos');
INSERT INTO public.empresa VALUES (151, 'Siqueira', 'Siqueira Tech');
INSERT INTO public.empresa VALUES (152, 'Miller-Ray', 'Miller-Ray Networks');
INSERT INTO public.empresa VALUES (153, 'Hall-Clark', 'Hall-Clark Atelier');
INSERT INTO public.empresa VALUES (154, 'Foster PLC', 'Foster PLC Tecnologia');
INSERT INTO public.empresa VALUES (155, 'Erickson Inc', 'Erickson Inc Design');
INSERT INTO public.empresa VALUES (156, 'Morgan, Bailey and Williams', 'Morgan, Bailey and Williams Ambiental');
INSERT INTO public.empresa VALUES (157, 'Hall, Singh and Welch', 'Hall, Singh and Welch Verde');
INSERT INTO public.empresa VALUES (158, 'Goodwin-Martin', 'Goodwin-Martin Grupo');
INSERT INTO public.empresa VALUES (159, 'Munoz-Escobar', 'Munoz-Escobar Partners');
INSERT INTO public.empresa VALUES (160, 'Cooper and Sons', 'Cooper and Sons Construções');
INSERT INTO public.empresa VALUES (161, 'Mullins-Golden', 'Mullins-Golden Eco');
INSERT INTO public.empresa VALUES (162, 'Nolan Group', 'Nolan Group Alimentos');
INSERT INTO public.empresa VALUES (163, 'Gibbs, Smith and Lee', 'Gibbs, Smith and Lee Culinária');
INSERT INTO public.empresa VALUES (164, 'Guerra', 'Guerra Consultoria');
INSERT INTO public.empresa VALUES (165, 'Campos Abreu - ME', 'Campos Abreu - ME Obras');
INSERT INTO public.empresa VALUES (166, 'Teixeira Lopes S.A.', 'Teixeira Lopes S.A. Tech');
INSERT INTO public.empresa VALUES (167, 'da Costa', 'da Costa Works');
INSERT INTO public.empresa VALUES (168, 'Holt, Carney and Foster', 'Holt, Carney and Foster Capital');
INSERT INTO public.empresa VALUES (169, 'Young-Richardson', 'Young-Richardson Consultoria');
INSERT INTO public.empresa VALUES (170, 'Salazar-Watkins', 'Salazar-Watkins Atacado');
INSERT INTO public.empresa VALUES (171, 'Saunders, Gross and Phillips', 'Saunders, Gross and Phillips Studio');
INSERT INTO public.empresa VALUES (172, 'Costela Nascimento S/A', 'Costela Nascimento S/A Transportes');
INSERT INTO public.empresa VALUES (173, 'Harris and Sons', 'Harris and Sons Sustentável');
INSERT INTO public.empresa VALUES (174, 'Garcia, Jacobs and Patterson', 'Garcia, Jacobs and Patterson Advisors');
INSERT INTO public.empresa VALUES (175, 'Nascimento', 'Nascimento Holdings');
INSERT INTO public.empresa VALUES (176, 'Brown-Evans', 'Brown-Evans Hub');
INSERT INTO public.empresa VALUES (177, 'Lopes Pires S/A', 'Lopes Pires S/A Capital');
INSERT INTO public.empresa VALUES (178, 'Sanchez, Wolf and Clark', 'Sanchez, Wolf and Clark Consulting');
INSERT INTO public.empresa VALUES (179, 'Aguilar Ltd', 'Aguilar Ltd Soluções');
INSERT INTO public.empresa VALUES (180, 'Cassiano Rezende e Filhos', 'Cassiano Rezende e Filhos Boutique');
INSERT INTO public.empresa VALUES (181, 'Araújo Pimenta S.A.', 'Araújo Pimenta S.A. Jurídico');
INSERT INTO public.empresa VALUES (182, 'Watson LLC', 'Watson LLC International');
INSERT INTO public.empresa VALUES (183, 'Albuquerque Freitas - EI', 'Albuquerque Freitas - EI Solutions');
INSERT INTO public.empresa VALUES (184, 'Aparecida', 'Aparecida Distribuidora');
INSERT INTO public.empresa VALUES (185, 'Garcia - ME', 'Garcia - ME Collective');
INSERT INTO public.empresa VALUES (186, 'Green-Curtis', 'Green-Curtis Comércio');
INSERT INTO public.empresa VALUES (187, 'Wagner Inc', 'Wagner Inc Advisors');
INSERT INTO public.empresa VALUES (188, 'Martins', 'Martins Labs');
INSERT INTO public.empresa VALUES (189, 'Thompson-Perez', 'Thompson-Perez Solutions');
INSERT INTO public.empresa VALUES (190, 'Cunha e Filhos', 'Cunha e Filhos Transportes');
INSERT INTO public.empresa VALUES (191, 'Gomes Borges - EI', 'Gomes Borges - EI Inovação');
INSERT INTO public.empresa VALUES (192, 'Costa da Rocha Ltda.', 'Costa da Rocha Ltda. Tecnologia');
INSERT INTO public.empresa VALUES (193, 'Mckinney-Valdez', 'Mckinney-Valdez Frete');
INSERT INTO public.empresa VALUES (194, 'Fuller, Parks and Mcdonald', 'Fuller, Parks and Mcdonald Labs');
INSERT INTO public.empresa VALUES (195, 'Farias - EI', 'Farias - EI Atelier');
INSERT INTO public.empresa VALUES (196, 'Moura Souza Ltda.', 'Moura Souza Ltda. Serviços');
INSERT INTO public.empresa VALUES (197, 'Miller PLC', 'Miller PLC Co');
INSERT INTO public.empresa VALUES (198, 'Caldeira Garcia e Filhos', 'Caldeira Garcia e Filhos Enterprises');
INSERT INTO public.empresa VALUES (199, 'Parker-White', 'Parker-White Logística');
INSERT INTO public.empresa VALUES (200, 'Araújo', 'Araújo Ambiental');
INSERT INTO public.empresa VALUES (201, 'Carr Inc', 'Carr Inc Agency');
INSERT INTO public.empresa VALUES (202, 'da Cunha', 'da Cunha Platform');
INSERT INTO public.empresa VALUES (203, 'Walker, Wagner and Bennett', 'Walker, Wagner and Bennett Private');
INSERT INTO public.empresa VALUES (204, 'Wilson, Mcknight and Thompson', 'Wilson, Mcknight and Thompson Private');
INSERT INTO public.empresa VALUES (205, 'Oliveira e Filhos', 'Oliveira e Filhos Legal');
INSERT INTO public.empresa VALUES (206, 'Fernandes', 'Fernandes Digital');
INSERT INTO public.empresa VALUES (207, 'Schneider, Johnson and Crawford', 'Schneider, Johnson and Crawford Estilo');
INSERT INTO public.empresa VALUES (208, 'Moreira Fernandes e Filhos', 'Moreira Fernandes e Filhos Ambiental');
INSERT INTO public.empresa VALUES (209, 'Brown LLC', 'Brown LLC Assessoria');
INSERT INTO public.empresa VALUES (210, 'Thomas-Phillips', 'Thomas-Phillips Moda');
INSERT INTO public.empresa VALUES (211, 'Duarte', 'Duarte Enterprises');
INSERT INTO public.empresa VALUES (212, 'Jones Group', 'Jones Group Holdings');
INSERT INTO public.empresa VALUES (213, 'Rocha Rodrigues - EI', 'Rocha Rodrigues - EI Moda');
INSERT INTO public.empresa VALUES (214, 'Borges Ltda.', 'Borges Ltda. Obras');
INSERT INTO public.empresa VALUES (215, 'Perez and Sons', 'Perez and Sons Verde');
INSERT INTO public.empresa VALUES (216, 'Machado', 'Machado Digital');
INSERT INTO public.empresa VALUES (217, 'Berry, Anderson and Medina', 'Berry, Anderson and Medina Services');
INSERT INTO public.empresa VALUES (218, 'Carvalho Martins - EI', 'Carvalho Martins - EI International');
INSERT INTO public.empresa VALUES (219, 'Garcia e Filhos', 'Garcia e Filhos Strategies');
INSERT INTO public.empresa VALUES (220, 'Walker, Harper and Ramirez', 'Walker, Harper and Ramirez Private');
INSERT INTO public.empresa VALUES (221, 'Macedo e Filhos', 'Macedo e Filhos Solutions');
INSERT INTO public.empresa VALUES (222, 'Cook Ltd', 'Cook Ltd Labs');
INSERT INTO public.empresa VALUES (223, 'Ferrell-Hartman', 'Ferrell-Hartman Imobiliária');
INSERT INTO public.empresa VALUES (224, 'Burgess-Moon', 'Burgess-Moon Grupo');
INSERT INTO public.empresa VALUES (225, 'Sousa', 'Sousa Estilo');
INSERT INTO public.empresa VALUES (226, 'Pastor', 'Pastor Strategies');
INSERT INTO public.empresa VALUES (227, 'Cunha', 'Cunha Imobiliária');
INSERT INTO public.empresa VALUES (228, 'Viana Ltda.', 'Viana Ltda. Services');
INSERT INTO public.empresa VALUES (229, 'Sullivan-Kelly', 'Sullivan-Kelly Universal');
INSERT INTO public.empresa VALUES (230, 'Oneill and Sons', 'Oneill and Sons Academia');
INSERT INTO public.empresa VALUES (231, 'Correia', 'Correia Eco');
INSERT INTO public.empresa VALUES (232, 'Tucker-Gonzalez', 'Tucker-Gonzalez Universal');
INSERT INTO public.empresa VALUES (233, 'Wood-Dixon', 'Wood-Dixon Prime');
INSERT INTO public.empresa VALUES (234, 'Carey, Henry and Ferrell', 'Carey, Henry and Ferrell Advocacia');
INSERT INTO public.empresa VALUES (235, 'Bennett PLC', 'Bennett PLC Smart');
INSERT INTO public.empresa VALUES (236, 'Ribeiro', 'Ribeiro Solutions');
INSERT INTO public.empresa VALUES (237, 'Araújo e Filhos', 'Araújo e Filhos Moda');
INSERT INTO public.empresa VALUES (238, 'Newman Group', 'Newman Group Finanças');
INSERT INTO public.empresa VALUES (239, 'Anderson, Miller and Martin', 'Anderson, Miller and Martin Partners');
INSERT INTO public.empresa VALUES (240, 'Evans-Rojas', 'Evans-Rojas Assessoria');
INSERT INTO public.empresa VALUES (241, 'Simpson and Sons', 'Simpson and Sons Co');
INSERT INTO public.empresa VALUES (242, 'Bell-Bailey', 'Bell-Bailey Private');
INSERT INTO public.empresa VALUES (243, 'Nunes S.A.', 'Nunes S.A. Collective');
INSERT INTO public.empresa VALUES (244, 'Pires Azevedo e Filhos', 'Pires Azevedo e Filhos Capital');
INSERT INTO public.empresa VALUES (245, 'Hudson, Lin and Smith', 'Hudson, Lin and Smith Wellness');
INSERT INTO public.empresa VALUES (246, 'Robles Group', 'Robles Group Grupo');
INSERT INTO public.empresa VALUES (247, 'Fletcher-Long', 'Fletcher-Long Partners');
INSERT INTO public.empresa VALUES (248, 'Jackson and Sons', 'Jackson and Sons Studio');
INSERT INTO public.empresa VALUES (249, 'Nogueira e Filhos', 'Nogueira e Filhos Construções');
INSERT INTO public.empresa VALUES (250, 'Andrade Martins - EI', 'Andrade Martins - EI Labs');
INSERT INTO public.empresa VALUES (251, 'da Mata S.A.', 'da Mata S.A. Assessoria');
INSERT INTO public.empresa VALUES (252, 'Carvalho Cavalcanti - EI', 'Carvalho Cavalcanti - EI Universal');
INSERT INTO public.empresa VALUES (253, 'da Cruz da Costa S/A', 'da Cruz da Costa S/A Serviços');
INSERT INTO public.empresa VALUES (254, 'Mejia-Silva', 'Mejia-Silva Agency');
INSERT INTO public.empresa VALUES (255, 'Nogueira S/A', 'Nogueira S/A Solutions');
INSERT INTO public.empresa VALUES (256, 'Wang Ltd', 'Wang Ltd Networks');
INSERT INTO public.empresa VALUES (257, 'Wilson, Richards and Hartman', 'Wilson, Richards and Hartman Co');
INSERT INTO public.empresa VALUES (258, 'Cavalcante e Filhos', 'Cavalcante e Filhos Labs');
INSERT INTO public.empresa VALUES (259, 'Brown, Sweeney and Perez', 'Brown, Sweeney and Perez Engine');
INSERT INTO public.empresa VALUES (260, 'White-Arias', 'White-Arias Inteligência');
INSERT INTO public.empresa VALUES (261, 'Thomas, Moore and Leon', 'Thomas, Moore and Leon Clinic');
INSERT INTO public.empresa VALUES (262, 'Dennis PLC', 'Dennis PLC Culinária');
INSERT INTO public.empresa VALUES (263, 'Harmon and Sons', 'Harmon and Sons Comércio');
INSERT INTO public.empresa VALUES (264, 'Bowen-Lozano', 'Bowen-Lozano Capital');
INSERT INTO public.empresa VALUES (265, 'Flores Inc', 'Flores Inc Services');
INSERT INTO public.empresa VALUES (266, 'Phillips-Weaver', 'Phillips-Weaver Gastronomia');
INSERT INTO public.empresa VALUES (267, 'Dias', 'Dias Strategies');
INSERT INTO public.empresa VALUES (268, 'Gomes', 'Gomes Legal');
INSERT INTO public.empresa VALUES (269, 'Adams, Mccullough and Anthony', 'Adams, Mccullough and Anthony Atelier');
INSERT INTO public.empresa VALUES (270, 'Cirino Ltda.', 'Cirino Ltda. Works');
INSERT INTO public.empresa VALUES (271, 'Martins S.A.', 'Martins S.A. Delícias');
INSERT INTO public.empresa VALUES (272, 'Brito - ME', 'Brito - ME Varejo');
INSERT INTO public.empresa VALUES (273, 'Stanley Ltd', 'Stanley Ltd Treinamento');
INSERT INTO public.empresa VALUES (274, 'Macedo S.A.', 'Macedo S.A. Moda');
INSERT INTO public.empresa VALUES (275, 'Padilla-Holmes', 'Padilla-Holmes Tecnologia');
INSERT INTO public.empresa VALUES (276, 'Mendes Novais S.A.', 'Mendes Novais S.A. Atacado');
INSERT INTO public.empresa VALUES (277, 'Câmara Pimenta e Filhos', 'Câmara Pimenta e Filhos Estilo');
INSERT INTO public.empresa VALUES (278, 'Aragão Aragão S.A.', 'Aragão Aragão S.A. Educação');
INSERT INTO public.empresa VALUES (279, 'Nascimento Brito - ME', 'Nascimento Brito - ME Next');
INSERT INTO public.empresa VALUES (280, 'da Cruz', 'da Cruz Tech');
INSERT INTO public.empresa VALUES (281, 'Rodriguez PLC', 'Rodriguez PLC Gastronomia');
INSERT INTO public.empresa VALUES (282, 'Simpson Group', 'Simpson Group Eco');
INSERT INTO public.empresa VALUES (283, 'Pimenta', 'Pimenta Services');
INSERT INTO public.empresa VALUES (284, 'Pereira', 'Pereira Strategies');
INSERT INTO public.empresa VALUES (285, 'Lopez, Wilson and Carr', 'Lopez, Wilson and Carr Operações');
INSERT INTO public.empresa VALUES (286, 'Casa Grande', 'Casa Grande Systems');
INSERT INTO public.empresa VALUES (287, 'Sá', 'Sá Frete');
INSERT INTO public.empresa VALUES (288, 'Salazar-Paul', 'Salazar-Paul Consultoria');
INSERT INTO public.empresa VALUES (289, 'Rios', 'Rios Atelier');
INSERT INTO public.empresa VALUES (290, 'Johnson Ltd', 'Johnson Ltd Atacado');
INSERT INTO public.empresa VALUES (291, 'Torres-Kramer', 'Torres-Kramer Solutions');
INSERT INTO public.empresa VALUES (292, 'Nunes Lima S/A', 'Nunes Lima S/A Tecnologia');
INSERT INTO public.empresa VALUES (293, 'Silveira Fogaça - ME', 'Silveira Fogaça - ME Global');
INSERT INTO public.empresa VALUES (294, 'Walls PLC', 'Walls PLC Transportes');
INSERT INTO public.empresa VALUES (295, 'Duncan-Peterson', 'Duncan-Peterson Soluções');
INSERT INTO public.empresa VALUES (296, 'Lloyd, Robinson and Walker', 'Lloyd, Robinson and Walker Partners');
INSERT INTO public.empresa VALUES (297, 'Teixeira Ltda.', 'Teixeira Ltda. Digital');
INSERT INTO public.empresa VALUES (298, 'Marquez, Saunders and Burns', 'Marquez, Saunders and Burns Operações');
INSERT INTO public.empresa VALUES (299, 'Ramos-Thomas', 'Ramos-Thomas Smart');
INSERT INTO public.empresa VALUES (300, 'Mendonça - ME', 'Mendonça - ME Labs');
INSERT INTO public.empresa VALUES (301, 'Cavalcante', 'Cavalcante Comércio');
INSERT INTO public.empresa VALUES (302, 'Sousa S.A.', 'Sousa S.A. Grupo');
INSERT INTO public.empresa VALUES (303, 'Moura', 'Moura Boutique');
INSERT INTO public.empresa VALUES (304, 'Costela Nunes - EI', 'Costela Nunes - EI Operações');
INSERT INTO public.empresa VALUES (305, 'Mayo-Henderson', 'Mayo-Henderson Global');
INSERT INTO public.empresa VALUES (306, 'Sampaio Silva e Filhos', 'Sampaio Silva e Filhos Solutions');
INSERT INTO public.empresa VALUES (307, 'Vasconcelos', 'Vasconcelos Inteligência');
INSERT INTO public.empresa VALUES (308, 'Johnston Inc', 'Johnston Inc Transportes');
INSERT INTO public.empresa VALUES (309, 'Pereira - EI', 'Pereira - EI Collective');
INSERT INTO public.empresa VALUES (310, 'Pimenta e Filhos', 'Pimenta e Filhos International');
INSERT INTO public.empresa VALUES (311, 'Peixoto', 'Peixoto Inteligência');
INSERT INTO public.empresa VALUES (312, 'Shah Group', 'Shah Group Sustentável');
INSERT INTO public.empresa VALUES (313, 'Leão - ME', 'Leão - ME Alimentos');
INSERT INTO public.empresa VALUES (314, 'Baker, Owens and Peterson', 'Baker, Owens and Peterson Advisors');
INSERT INTO public.empresa VALUES (315, 'Pires Fogaça S.A.', 'Pires Fogaça S.A. Wellness');
INSERT INTO public.empresa VALUES (316, 'Gonçalves e Filhos', 'Gonçalves e Filhos Grupo');
INSERT INTO public.empresa VALUES (317, 'Moreira S/A', 'Moreira S/A Design');
INSERT INTO public.empresa VALUES (318, 'Garcia', 'Garcia Assessoria');
INSERT INTO public.empresa VALUES (319, 'da Conceição e Filhos', 'da Conceição e Filhos Culinária');
INSERT INTO public.empresa VALUES (320, 'Mitchell, Rios and Shaw', 'Mitchell, Rios and Shaw Distribuidora');
INSERT INTO public.empresa VALUES (321, 'Abreu Rezende e Filhos', 'Abreu Rezende e Filhos Partners');
INSERT INTO public.empresa VALUES (322, 'Pimenta Rodrigues Ltda.', 'Pimenta Rodrigues Ltda. Smart');
INSERT INTO public.empresa VALUES (323, 'Carter and Sons', 'Carter and Sons Private');
INSERT INTO public.empresa VALUES (324, 'Green-Burton', 'Green-Burton Systems');
INSERT INTO public.empresa VALUES (325, 'Borges S/A', 'Borges S/A Imobiliária');
INSERT INTO public.empresa VALUES (326, 'Mcgee LLC', 'Mcgee LLC Obras');
INSERT INTO public.empresa VALUES (327, 'White, Rogers and Vega', 'White, Rogers and Vega Investimentos');
INSERT INTO public.empresa VALUES (328, 'Salazar, Williams and Collins', 'Salazar, Williams and Collins Eco');
INSERT INTO public.empresa VALUES (329, 'Padilla, Freeman and Pierce', 'Padilla, Freeman and Pierce Platform');
INSERT INTO public.empresa VALUES (330, 'Barros da Paz Ltda.', 'Barros da Paz Ltda. Creative');
INSERT INTO public.empresa VALUES (331, 'Dillon, Marsh and Scott', 'Dillon, Marsh and Scott Alimentos');
INSERT INTO public.empresa VALUES (332, 'Turner LLC', 'Turner LLC Wellness');
INSERT INTO public.empresa VALUES (333, 'Jones, Mcintosh and Mendoza', 'Jones, Mcintosh and Mendoza Culinária');
INSERT INTO public.empresa VALUES (334, 'Harrison and Sons', 'Harrison and Sons Engine');
INSERT INTO public.empresa VALUES (335, 'Schultz, Davis and Gonzalez', 'Schultz, Davis and Gonzalez Strategies');
INSERT INTO public.empresa VALUES (336, 'Moreira', 'Moreira Atelier');
INSERT INTO public.empresa VALUES (337, 'Costela Pereira S/A', 'Costela Pereira S/A Capital');
INSERT INTO public.empresa VALUES (338, 'Johnson-Beasley', 'Johnson-Beasley Wellness');
INSERT INTO public.empresa VALUES (339, 'Cavalcanti', 'Cavalcanti Sustentável');
INSERT INTO public.empresa VALUES (340, 'Vargas Ltda.', 'Vargas Ltda. International');
INSERT INTO public.empresa VALUES (341, 'Walsh, Hess and Nicholson', 'Walsh, Hess and Nicholson Transportes');
INSERT INTO public.empresa VALUES (342, 'Novaes Cavalcanti S/A', 'Novaes Cavalcanti S/A Inovação');
INSERT INTO public.empresa VALUES (343, 'Aragão', 'Aragão Services');
INSERT INTO public.empresa VALUES (344, 'Campos', 'Campos Global');
INSERT INTO public.empresa VALUES (345, 'Fischer-Serrano', 'Fischer-Serrano Jurídico');
INSERT INTO public.empresa VALUES (346, 'Montenegro - EI', 'Montenegro - EI Serviços');
INSERT INTO public.empresa VALUES (347, 'Cunningham and Sons', 'Cunningham and Sons Solutions');
INSERT INTO public.empresa VALUES (348, 'Gomes S.A.', 'Gomes S.A. Jurídico');
INSERT INTO public.empresa VALUES (349, 'Walker Inc', 'Walker Inc Varejo');
INSERT INTO public.empresa VALUES (350, 'Sampaio Vieira S.A.', 'Sampaio Vieira S.A. Empreendimentos');
INSERT INTO public.empresa VALUES (351, 'Pinto', 'Pinto Culinária');
INSERT INTO public.empresa VALUES (352, 'Montenegro e Filhos', 'Montenegro e Filhos Strategies');
INSERT INTO public.empresa VALUES (353, 'Cunha - ME', 'Cunha - ME Obras');
INSERT INTO public.empresa VALUES (354, 'Vasquez, Camacho and Berger', 'Vasquez, Camacho and Berger Serviços');
INSERT INTO public.empresa VALUES (355, 'Câmara', 'Câmara Hub');
INSERT INTO public.empresa VALUES (356, 'da Mota Viana S.A.', 'da Mota Viana S.A. Solutions');
INSERT INTO public.empresa VALUES (357, 'Camacho PLC', 'Camacho PLC Investimentos');
INSERT INTO public.empresa VALUES (358, 'Rezende da Luz S.A.', 'Rezende da Luz S.A. Logística');
INSERT INTO public.empresa VALUES (359, 'Brock Inc', 'Brock Inc Collective');
INSERT INTO public.empresa VALUES (360, 'Kelley, Lynch and Watts', 'Kelley, Lynch and Watts Grupo');
INSERT INTO public.empresa VALUES (361, 'Davis PLC', 'Davis PLC Gastronomia');
INSERT INTO public.empresa VALUES (362, 'Nascimento Azevedo Ltda.', 'Nascimento Azevedo Ltda. Delícias');
INSERT INTO public.empresa VALUES (363, 'Howe and Sons', 'Howe and Sons Eco');
INSERT INTO public.empresa VALUES (364, 'Baker-Sherman', 'Baker-Sherman Studio');
INSERT INTO public.empresa VALUES (365, 'Câmara S.A.', 'Câmara S.A. Treinamento');
INSERT INTO public.empresa VALUES (366, 'Pires Ltda.', 'Pires Ltda. Ambiental');
INSERT INTO public.empresa VALUES (367, 'Ellison, Hart and Clark', 'Ellison, Hart and Clark Enterprises');
INSERT INTO public.empresa VALUES (368, 'Garcia S.A.', 'Garcia S.A. Comércio');
INSERT INTO public.empresa VALUES (369, 'Cirino', 'Cirino Medical');
INSERT INTO public.empresa VALUES (370, 'Zhang, Baker and Smith', 'Zhang, Baker and Smith Estilo');
INSERT INTO public.empresa VALUES (371, 'Hawkins-Cruz', 'Hawkins-Cruz Alimentos');
INSERT INTO public.empresa VALUES (372, 'Barros S/A', 'Barros S/A Atelier');
INSERT INTO public.empresa VALUES (373, 'Nogueira', 'Nogueira Inteligência');
INSERT INTO public.empresa VALUES (374, 'Flowers, Rodriguez and Harris', 'Flowers, Rodriguez and Harris Empreendimentos');
INSERT INTO public.empresa VALUES (375, 'Carpenter Ltd', 'Carpenter Ltd Wellness');
INSERT INTO public.empresa VALUES (376, 'Pacheco', 'Pacheco Finanças');
INSERT INTO public.empresa VALUES (377, 'Fonseca e Filhos', 'Fonseca e Filhos Healthcare');
INSERT INTO public.empresa VALUES (378, 'Costela Carvalho S.A.', 'Costela Carvalho S.A. Assessoria');
INSERT INTO public.empresa VALUES (379, 'Mendes', 'Mendes Strategies');
INSERT INTO public.empresa VALUES (380, 'da Rosa S/A', 'da Rosa S/A Ambiental');
INSERT INTO public.empresa VALUES (381, 'Smith Inc', 'Smith Inc Soluções');
INSERT INTO public.empresa VALUES (382, 'Moore-Burton', 'Moore-Burton Formação');
INSERT INTO public.empresa VALUES (383, 'Alves', 'Alves Logística');
INSERT INTO public.empresa VALUES (384, 'Smith, Carey and Lopez', 'Smith, Carey and Lopez Serviços');
INSERT INTO public.empresa VALUES (385, 'Gonzalez-Butler', 'Gonzalez-Butler Partners');
INSERT INTO public.empresa VALUES (386, 'Marques da Mota S/A', 'Marques da Mota S/A Comércio');
INSERT INTO public.empresa VALUES (387, 'Fields PLC', 'Fields PLC Inovação');
INSERT INTO public.empresa VALUES (388, 'Allen Group', 'Allen Group Empreendimentos');
INSERT INTO public.empresa VALUES (389, 'Green-Buck', 'Green-Buck Hub');
INSERT INTO public.empresa VALUES (390, 'Brown PLC', 'Brown PLC Academia');
INSERT INTO public.empresa VALUES (391, 'Campos S.A.', 'Campos S.A. Gastronomia');
INSERT INTO public.empresa VALUES (392, 'Reed-Webb', 'Reed-Webb Finanças');
INSERT INTO public.empresa VALUES (393, 'Sampaio S.A.', 'Sampaio S.A. Formação');
INSERT INTO public.empresa VALUES (394, 'Brito Viana S.A.', 'Brito Viana S.A. Imobiliária');
INSERT INTO public.empresa VALUES (395, 'Russell and Sons', 'Russell and Sons Alimentos');
INSERT INTO public.empresa VALUES (396, 'Porto S.A.', 'Porto S.A. Medical');
INSERT INTO public.empresa VALUES (397, 'Mendonça S/A', 'Mendonça S/A Grupo');
INSERT INTO public.empresa VALUES (398, 'Holmes PLC', 'Holmes PLC Formação');
INSERT INTO public.empresa VALUES (399, 'Pinto e Filhos', 'Pinto e Filhos Clinic');
INSERT INTO public.empresa VALUES (400, 'da Paz', 'da Paz Transportes');
INSERT INTO public.empresa VALUES (401, 'Allen, Price and Serrano', 'Allen, Price and Serrano Empreendimentos');
INSERT INTO public.empresa VALUES (402, 'Thompson Ltd', 'Thompson Ltd Global');
INSERT INTO public.empresa VALUES (403, 'Ramos S.A.', 'Ramos S.A. Clinic');
INSERT INTO public.empresa VALUES (404, 'Cardoso Ltda.', 'Cardoso Ltda. Systems');
INSERT INTO public.empresa VALUES (405, 'Alves - EI', 'Alves - EI Wellness');
INSERT INTO public.empresa VALUES (406, 'Quinn Group', 'Quinn Group Advocacia');
INSERT INTO public.empresa VALUES (407, 'Cunha - EI', 'Cunha - EI Labs');
INSERT INTO public.empresa VALUES (408, 'Novaes S/A', 'Novaes S/A Culinária');
INSERT INTO public.empresa VALUES (409, 'Moreira Garcia e Filhos', 'Moreira Garcia e Filhos Inteligência');
INSERT INTO public.empresa VALUES (410, 'Salazar, Davis and Fowler', 'Salazar, Davis and Fowler Distribuidora');
INSERT INTO public.empresa VALUES (411, 'da Costa Camargo S/A', 'da Costa Camargo S/A Agency');
INSERT INTO public.empresa VALUES (412, 'Gonçalves da Luz - ME', 'Gonçalves da Luz - ME Partners');
INSERT INTO public.empresa VALUES (413, 'Strong Ltd', 'Strong Ltd Tech');
INSERT INTO public.empresa VALUES (414, 'Mendes e Filhos', 'Mendes e Filhos Worldwide');
INSERT INTO public.empresa VALUES (415, 'Ruiz-Johnson', 'Ruiz-Johnson Verde');
INSERT INTO public.empresa VALUES (416, 'Melo Costela S.A.', 'Melo Costela S.A. Inovação');
INSERT INTO public.empresa VALUES (417, 'da Rosa Peixoto - ME', 'da Rosa Peixoto - ME Ambiental');
INSERT INTO public.empresa VALUES (418, 'Silva S/A', 'Silva S/A Systems');
INSERT INTO public.empresa VALUES (419, 'Allen and Sons', 'Allen and Sons Advocacia');
INSERT INTO public.empresa VALUES (420, 'Manning, Giles and Davis', 'Manning, Giles and Davis Factory');
INSERT INTO public.empresa VALUES (421, 'Gentry, Willis and Hayes', 'Gentry, Willis and Hayes Comércio');
INSERT INTO public.empresa VALUES (422, 'Camargo', 'Camargo Frete');
INSERT INTO public.empresa VALUES (423, 'Vieira e Filhos', 'Vieira e Filhos Advocacia');
INSERT INTO public.empresa VALUES (424, 'Siqueira Mendes e Filhos', 'Siqueira Mendes e Filhos Gastronomia');
INSERT INTO public.empresa VALUES (425, 'Moraes', 'Moraes Legal');
INSERT INTO public.empresa VALUES (426, 'Mann and Sons', 'Mann and Sons Educação');
INSERT INTO public.empresa VALUES (427, 'Blair-Obrien', 'Blair-Obrien Frete');
INSERT INTO public.empresa VALUES (428, 'Novaes da Costa Ltda.', 'Novaes da Costa Ltda. Logística');
INSERT INTO public.empresa VALUES (429, 'Hansen, Greene and Carter', 'Hansen, Greene and Carter Imobiliária');
INSERT INTO public.empresa VALUES (430, 'Marques Azevedo S/A', 'Marques Azevedo S/A Agency');
INSERT INTO public.empresa VALUES (431, 'Sá - EI', 'Sá - EI Clinic');
INSERT INTO public.empresa VALUES (432, 'Pinto - ME', 'Pinto - ME Universal');
INSERT INTO public.empresa VALUES (433, 'Pereira - ME', 'Pereira - ME Healthcare');
INSERT INTO public.empresa VALUES (434, 'Gomes Fonseca - ME', 'Gomes Fonseca - ME Smart');
INSERT INTO public.empresa VALUES (435, 'Elliott, Clark and Cox', 'Elliott, Clark and Cox Imobiliária');
INSERT INTO public.empresa VALUES (436, 'Powell and Sons', 'Powell and Sons Distribuidora');
INSERT INTO public.empresa VALUES (437, 'Trevino, Mcknight and Mills', 'Trevino, Mcknight and Mills Medical');
INSERT INTO public.empresa VALUES (438, 'da Cunha S.A.', 'da Cunha S.A. Moda');
INSERT INTO public.empresa VALUES (439, 'Howell, Delacruz and Mendez', 'Howell, Delacruz and Mendez Atacado');
INSERT INTO public.empresa VALUES (440, 'Cardoso', 'Cardoso Estilo');
INSERT INTO public.empresa VALUES (441, 'Carroll Inc', 'Carroll Inc Labs');
INSERT INTO public.empresa VALUES (442, 'Martins - ME', 'Martins - ME Formação');
INSERT INTO public.empresa VALUES (443, 'Stewart, Hoffman and Peck', 'Stewart, Hoffman and Peck Sustentável');
INSERT INTO public.empresa VALUES (444, 'Garcia S/A', 'Garcia S/A Obras');
INSERT INTO public.empresa VALUES (445, 'Green PLC', 'Green PLC Treinamento');
INSERT INTO public.empresa VALUES (446, 'Brown, Davis and Nichols', 'Brown, Davis and Nichols Treinamento');
INSERT INTO public.empresa VALUES (447, 'Nguyen, Hendrix and Wilson', 'Nguyen, Hendrix and Wilson Works');
INSERT INTO public.empresa VALUES (448, 'Sullivan, Davis and Miranda', 'Sullivan, Davis and Miranda Atacado');
INSERT INTO public.empresa VALUES (449, 'Bullock, Frost and Stewart', 'Bullock, Frost and Stewart Platform');
INSERT INTO public.empresa VALUES (450, 'Costela Almeida - EI', 'Costela Almeida - EI Clinic');
INSERT INTO public.empresa VALUES (451, 'Campos - EI', 'Campos - EI Eco');
INSERT INTO public.empresa VALUES (452, 'Cassiano e Filhos', 'Cassiano e Filhos Strategies');
INSERT INTO public.empresa VALUES (453, 'Duarte Montenegro e Filhos', 'Duarte Montenegro e Filhos Consulting');
INSERT INTO public.empresa VALUES (454, 'Morrow LLC', 'Morrow LLC Labs');
INSERT INTO public.empresa VALUES (455, 'Davidson-Rodriguez', 'Davidson-Rodriguez Systems');
INSERT INTO public.empresa VALUES (456, 'Pacheco - ME', 'Pacheco - ME Labs');
INSERT INTO public.empresa VALUES (457, 'Silveira', 'Silveira Studio');
INSERT INTO public.empresa VALUES (458, 'Cavalcanti da Luz e Filhos', 'Cavalcanti da Luz e Filhos Universal');
INSERT INTO public.empresa VALUES (459, 'Franco-Fletcher', 'Franco-Fletcher Alimentos');
INSERT INTO public.empresa VALUES (460, 'Pires - ME', 'Pires - ME Sustentável');
INSERT INTO public.empresa VALUES (461, 'Burns-Roth', 'Burns-Roth International');
INSERT INTO public.empresa VALUES (462, 'Nelson, Booker and Lambert', 'Nelson, Booker and Lambert Inteligência');
INSERT INTO public.empresa VALUES (463, 'Freitas - EI', 'Freitas - EI Sustentável');
INSERT INTO public.empresa VALUES (464, 'Dias Gomes e Filhos', 'Dias Gomes e Filhos Advocacia');
INSERT INTO public.empresa VALUES (465, 'Pinto S.A.', 'Pinto S.A. Inovação');
INSERT INTO public.empresa VALUES (466, 'Camargo S/A', 'Camargo S/A Jurídico');
INSERT INTO public.empresa VALUES (467, 'Macedo', 'Macedo Services');
INSERT INTO public.empresa VALUES (468, 'Machado Moraes S.A.', 'Machado Moraes S.A. Comércio');
INSERT INTO public.empresa VALUES (469, 'Camargo - ME', 'Camargo - ME Clinic');
INSERT INTO public.empresa VALUES (470, 'Holden Inc', 'Holden Inc Comércio');
INSERT INTO public.empresa VALUES (471, 'Kemp LLC', 'Kemp LLC Distribuidora');
INSERT INTO public.empresa VALUES (472, 'Novais', 'Novais Frete');
INSERT INTO public.empresa VALUES (473, 'Escobar, Hill and Dennis', 'Escobar, Hill and Dennis Educação');
INSERT INTO public.empresa VALUES (474, 'Correia da Conceição S.A.', 'Correia da Conceição S.A. Finanças');
INSERT INTO public.empresa VALUES (475, 'Griffith Group', 'Griffith Group Inovação');
INSERT INTO public.empresa VALUES (476, 'Love, Morrow and Andrews', 'Love, Morrow and Andrews Works');
INSERT INTO public.empresa VALUES (477, 'Mills, Powers and Wilson', 'Mills, Powers and Wilson Smart');
INSERT INTO public.empresa VALUES (478, 'Caldeira', 'Caldeira Medical');
INSERT INTO public.empresa VALUES (479, 'Mathis-Wilkerson', 'Mathis-Wilkerson Collective');
INSERT INTO public.empresa VALUES (480, 'Vargas-Turner', 'Vargas-Turner Investimentos');
INSERT INTO public.empresa VALUES (481, 'Beck-Mclaughlin', 'Beck-Mclaughlin Comércio');
INSERT INTO public.empresa VALUES (482, 'Marques', 'Marques Formação');
INSERT INTO public.empresa VALUES (483, 'Turner PLC', 'Turner PLC Ambiental');
INSERT INTO public.empresa VALUES (484, 'Diaz-Stephenson', 'Diaz-Stephenson Legal');
INSERT INTO public.empresa VALUES (485, 'Rios Siqueira - ME', 'Rios Siqueira - ME Edge');
INSERT INTO public.empresa VALUES (486, 'da Cunha Novaes - EI', 'da Cunha Novaes - EI Boutique');
INSERT INTO public.empresa VALUES (487, 'Maxwell, Ewing and Brennan', 'Maxwell, Ewing and Brennan Private');
INSERT INTO public.empresa VALUES (488, 'Massey-Taylor', 'Massey-Taylor Atelier');
INSERT INTO public.empresa VALUES (489, 'Azevedo Peixoto - EI', 'Azevedo Peixoto - EI Legal');
INSERT INTO public.empresa VALUES (490, 'Lewis-Ellison', 'Lewis-Ellison Holdings');
INSERT INTO public.empresa VALUES (491, 'Marques - ME', 'Marques - ME Academia');
INSERT INTO public.empresa VALUES (492, 'Ali, Davis and Ray', 'Ali, Davis and Ray Transportes');
INSERT INTO public.empresa VALUES (493, 'Clements, Roberts and Dennis', 'Clements, Roberts and Dennis Capital');
INSERT INTO public.empresa VALUES (494, 'Gonçalves Pires e Filhos', 'Gonçalves Pires e Filhos International');
INSERT INTO public.empresa VALUES (495, 'Young, Caldwell and Conrad', 'Young, Caldwell and Conrad Obras');
INSERT INTO public.empresa VALUES (496, 'Barbosa S.A.', 'Barbosa S.A. Works');
INSERT INTO public.empresa VALUES (497, 'Fonseca', 'Fonseca Serviços');
INSERT INTO public.empresa VALUES (498, 'Alexander Ltd', 'Alexander Ltd Works');
INSERT INTO public.empresa VALUES (499, 'Peterson PLC', 'Peterson PLC Advocacia');
INSERT INTO public.empresa VALUES (500, 'Lee and Sons', 'Lee and Sons Atacado');
INSERT INTO public.empresa VALUES (501, 'Barber-Powers', 'Barber-Powers Moda');
INSERT INTO public.empresa VALUES (502, 'Freitas S/A', 'Freitas S/A Universal');
INSERT INTO public.empresa VALUES (503, 'Hayes LLC', 'Hayes LLC Collective');
INSERT INTO public.empresa VALUES (504, 'Costela Araújo S.A.', 'Costela Araújo S.A. Strategies');
INSERT INTO public.empresa VALUES (505, 'da Conceição Ltda.', 'da Conceição Ltda. Hub');
INSERT INTO public.empresa VALUES (506, 'Montenegro Novais Ltda.', 'Montenegro Novais Ltda. Soluções');
INSERT INTO public.empresa VALUES (507, 'da Conceição da Costa S.A.', 'da Conceição da Costa S.A. Holdings');
INSERT INTO public.empresa VALUES (508, 'Hunt-Garrett', 'Hunt-Garrett Healthcare');
INSERT INTO public.empresa VALUES (509, 'Farias', 'Farias Capital');
INSERT INTO public.empresa VALUES (510, 'Hernandez-Wade', 'Hernandez-Wade Enterprises');
INSERT INTO public.empresa VALUES (511, 'Estes, Horton and Morris', 'Estes, Horton and Morris Atacado');
INSERT INTO public.empresa VALUES (512, 'Campos Cavalcanti S/A', 'Campos Cavalcanti S/A Legal');
INSERT INTO public.empresa VALUES (513, 'Azevedo - ME', 'Azevedo - ME Medical');
INSERT INTO public.empresa VALUES (514, 'Townsend Group', 'Townsend Group Solutions');
INSERT INTO public.empresa VALUES (515, 'Wu, Sanchez and Moran', 'Wu, Sanchez and Moran Alimentos');
INSERT INTO public.empresa VALUES (516, 'Santos', 'Santos Transportes');
INSERT INTO public.empresa VALUES (517, 'Chandler and Sons', 'Chandler and Sons Labs');
INSERT INTO public.empresa VALUES (518, 'Hays, Daniels and Johnson', 'Hays, Daniels and Johnson Tecnologia');
INSERT INTO public.empresa VALUES (519, 'Camargo S.A.', 'Camargo S.A. Creative');
INSERT INTO public.empresa VALUES (520, 'Santos S/A', 'Santos S/A Next');
INSERT INTO public.empresa VALUES (521, 'Viana S/A', 'Viana S/A Soluções');
INSERT INTO public.empresa VALUES (522, 'Lopes', 'Lopes Academia');
INSERT INTO public.empresa VALUES (523, 'Alves Marques - ME', 'Alves Marques - ME Construções');
INSERT INTO public.empresa VALUES (524, 'Duarte Mendonça - ME', 'Duarte Mendonça - ME Construções');
INSERT INTO public.empresa VALUES (525, 'Maynard, Mcintosh and Gonzalez', 'Maynard, Mcintosh and Gonzalez Hub');
INSERT INTO public.empresa VALUES (526, 'Schroeder and Sons', 'Schroeder and Sons Tecnologia');
INSERT INTO public.empresa VALUES (527, 'Barnett, Rodriguez and Arias', 'Barnett, Rodriguez and Arias Inteligência');
INSERT INTO public.empresa VALUES (528, 'Castro', 'Castro Delícias');
INSERT INTO public.empresa VALUES (529, 'Wolfe PLC', 'Wolfe PLC Distribuidora');
INSERT INTO public.empresa VALUES (530, 'Viana', 'Viana Inovação');
INSERT INTO public.empresa VALUES (531, 'Araújo S/A', 'Araújo S/A Global');
INSERT INTO public.empresa VALUES (532, 'Martin, Contreras and Hernandez', 'Martin, Contreras and Hernandez Advisors');
INSERT INTO public.empresa VALUES (533, 'Camacho, Hammond and Taylor', 'Camacho, Hammond and Taylor Advocacia');
INSERT INTO public.empresa VALUES (534, 'Caldeira - ME', 'Caldeira - ME Wellness');
INSERT INTO public.empresa VALUES (535, 'Farias Caldeira - EI', 'Farias Caldeira - EI Private');
INSERT INTO public.empresa VALUES (536, 'Lopez-Meza', 'Lopez-Meza Ambiental');
INSERT INTO public.empresa VALUES (537, 'Rodrigues - EI', 'Rodrigues - EI Inteligência');
INSERT INTO public.empresa VALUES (538, 'Campbell-Rose', 'Campbell-Rose Construções');
INSERT INTO public.empresa VALUES (539, 'Lawrence Inc', 'Lawrence Inc Transportes');
INSERT INTO public.empresa VALUES (540, 'Patterson, Washington and Evans', 'Patterson, Washington and Evans Clinic');
INSERT INTO public.empresa VALUES (541, 'Monteiro S.A.', 'Monteiro S.A. Wellness');
INSERT INTO public.empresa VALUES (542, 'Foster, Sullivan and Hess', 'Foster, Sullivan and Hess Frete');
INSERT INTO public.empresa VALUES (543, 'Montenegro', 'Montenegro Clinic');
INSERT INTO public.empresa VALUES (544, 'da Costa e Filhos', 'da Costa e Filhos Wellness');
INSERT INTO public.empresa VALUES (545, 'Morgan LLC', 'Morgan LLC Global');
INSERT INTO public.empresa VALUES (546, 'Williams-Tucker', 'Williams-Tucker Works');
INSERT INTO public.empresa VALUES (547, 'Koch Ltd', 'Koch Ltd Holdings');
INSERT INTO public.empresa VALUES (548, 'Martin-Hoffman', 'Martin-Hoffman Studio');
INSERT INTO public.empresa VALUES (549, 'Pires S/A', 'Pires S/A Varejo');
INSERT INTO public.empresa VALUES (550, 'Bradshaw, Perry and Stephens', 'Bradshaw, Perry and Stephens Empreendimentos');
INSERT INTO public.empresa VALUES (551, 'Anderson PLC', 'Anderson PLC Atelier');
INSERT INTO public.empresa VALUES (552, 'Kim-Pennington', 'Kim-Pennington Alimentos');
INSERT INTO public.empresa VALUES (553, 'Phillips-King', 'Phillips-King Grupo');
INSERT INTO public.empresa VALUES (554, 'Souza - ME', 'Souza - ME Creative');
INSERT INTO public.empresa VALUES (555, 'Davenport PLC', 'Davenport PLC Collective');
INSERT INTO public.empresa VALUES (556, 'Hodge Inc', 'Hodge Inc Systems');
INSERT INTO public.empresa VALUES (557, 'Lopez, Sullivan and Jones', 'Lopez, Sullivan and Jones Factory');
INSERT INTO public.empresa VALUES (558, 'Abreu', 'Abreu Works');
INSERT INTO public.empresa VALUES (559, 'Murphy and Sons', 'Murphy and Sons Legal');
INSERT INTO public.empresa VALUES (560, 'Carvalho Ltda.', 'Carvalho Ltda. Comércio');
INSERT INTO public.empresa VALUES (561, 'Costa Rios - EI', 'Costa Rios - EI International');
INSERT INTO public.empresa VALUES (562, 'Cavalcanti Fogaça S/A', 'Cavalcanti Fogaça S/A Creative');
INSERT INTO public.empresa VALUES (563, 'Sousa S/A', 'Sousa S/A Tech');
INSERT INTO public.empresa VALUES (564, 'Souza Guerra e Filhos', 'Souza Guerra e Filhos Academia');
INSERT INTO public.empresa VALUES (565, 'Ross, Thompson and Hunt', 'Ross, Thompson and Hunt Advocacia');
INSERT INTO public.empresa VALUES (566, 'Jesus', 'Jesus Factory');
INSERT INTO public.empresa VALUES (567, 'Fonseca Ltda.', 'Fonseca Ltda. Solutions');
INSERT INTO public.empresa VALUES (568, 'Whitney Inc', 'Whitney Inc Works');
INSERT INTO public.empresa VALUES (569, 'Nunes - ME', 'Nunes - ME Academia');
INSERT INTO public.empresa VALUES (570, 'Mclaughlin, Cordova and Murphy', 'Mclaughlin, Cordova and Murphy Hub');
INSERT INTO public.empresa VALUES (571, 'da Rosa da Cunha e Filhos', 'da Rosa da Cunha e Filhos Strategies');
INSERT INTO public.empresa VALUES (572, 'Ribeiro Barros e Filhos', 'Ribeiro Barros e Filhos Factory');
INSERT INTO public.empresa VALUES (573, 'Tyler-Kerr', 'Tyler-Kerr Jurídico');
INSERT INTO public.empresa VALUES (574, 'Cabrera, Miranda and Lopez', 'Cabrera, Miranda and Lopez Platform');
INSERT INTO public.empresa VALUES (575, 'Bond, Walker and West', 'Bond, Walker and West Operações');
INSERT INTO public.empresa VALUES (576, 'Rocha Rocha - EI', 'Rocha Rocha - EI Strategies');
INSERT INTO public.empresa VALUES (577, 'Aragão Moreira S/A', 'Aragão Moreira S/A Hub');
INSERT INTO public.empresa VALUES (578, 'Gilbert Group', 'Gilbert Group Studio');
INSERT INTO public.empresa VALUES (579, 'Rodrigues Santos - ME', 'Rodrigues Santos - ME Empreendimentos');
INSERT INTO public.empresa VALUES (580, 'Molina, Patterson and Dougherty', 'Molina, Patterson and Dougherty Wellness');
INSERT INTO public.empresa VALUES (581, 'Barros Moreira - ME', 'Barros Moreira - ME Creative');
INSERT INTO public.empresa VALUES (582, 'Macedo S/A', 'Macedo S/A Atelier');
INSERT INTO public.empresa VALUES (583, 'Rubio, Gilbert and Hansen', 'Rubio, Gilbert and Hansen Tecnologia');
INSERT INTO public.empresa VALUES (584, 'Watson, White and Rodriguez', 'Watson, White and Rodriguez Solutions');
INSERT INTO public.empresa VALUES (585, 'da Conceição - ME', 'da Conceição - ME Moda');
INSERT INTO public.empresa VALUES (586, 'Ortiz, Thornton and Martinez', 'Ortiz, Thornton and Martinez Tecnologia');
INSERT INTO public.empresa VALUES (587, 'Flores-Daniels', 'Flores-Daniels Logística');
INSERT INTO public.empresa VALUES (588, 'Jones-Kennedy', 'Jones-Kennedy Culinária');
INSERT INTO public.empresa VALUES (589, 'Padilla-Bush', 'Padilla-Bush Solutions');
INSERT INTO public.empresa VALUES (590, 'Sawyer Inc', 'Sawyer Inc Worldwide');
INSERT INTO public.empresa VALUES (591, 'Woods-Gordon', 'Woods-Gordon Gastronomia');
INSERT INTO public.empresa VALUES (592, 'Thompson, Taylor and Hendricks', 'Thompson, Taylor and Hendricks Enterprises');
INSERT INTO public.empresa VALUES (593, 'Avila, Whitaker and Schmitt', 'Avila, Whitaker and Schmitt Operações');
INSERT INTO public.empresa VALUES (594, 'Caldeira Martins S/A', 'Caldeira Martins S/A Agency');
INSERT INTO public.empresa VALUES (595, 'Monteiro Moura - EI', 'Monteiro Moura - EI Investimentos');
INSERT INTO public.empresa VALUES (596, 'Anderson-Johnson', 'Anderson-Johnson Universal');
INSERT INTO public.empresa VALUES (597, 'Hodges and Sons', 'Hodges and Sons Partners');
INSERT INTO public.empresa VALUES (598, 'Adams Inc', 'Adams Inc Agency');
INSERT INTO public.empresa VALUES (599, 'Ferreira', 'Ferreira Labs');
INSERT INTO public.empresa VALUES (600, 'Ribeiro Fonseca - ME', 'Ribeiro Fonseca - ME Verde');
INSERT INTO public.empresa VALUES (601, 'Ferreira Rezende e Filhos', 'Ferreira Rezende e Filhos Solutions');
INSERT INTO public.empresa VALUES (602, 'Brown Group', 'Brown Group Educação');
INSERT INTO public.empresa VALUES (603, 'da Mata', 'da Mata Networks');
INSERT INTO public.empresa VALUES (604, 'Cunha Ltda.', 'Cunha Ltda. Services');
INSERT INTO public.empresa VALUES (605, 'Wall, Shelton and Roberts', 'Wall, Shelton and Roberts Serviços');
INSERT INTO public.empresa VALUES (606, 'Lopez Inc', 'Lopez Inc Frete');
INSERT INTO public.empresa VALUES (607, 'Monteiro Ltda.', 'Monteiro Ltda. Labs');
INSERT INTO public.empresa VALUES (608, 'Cavalcante Montenegro - EI', 'Cavalcante Montenegro - EI Academia');
INSERT INTO public.empresa VALUES (609, 'Coleman Group', 'Coleman Group Grupo');
INSERT INTO public.empresa VALUES (610, 'Pereira S.A.', 'Pereira S.A. Consulting');
INSERT INTO public.empresa VALUES (611, 'Jesus Ltda.', 'Jesus Ltda. Inteligência');
INSERT INTO public.empresa VALUES (612, 'Velez Ltd', 'Velez Ltd Agency');
INSERT INTO public.empresa VALUES (613, 'Casa Grande - ME', 'Casa Grande - ME Studio');
INSERT INTO public.empresa VALUES (614, 'Pena-Schmitt', 'Pena-Schmitt Consultoria');
INSERT INTO public.empresa VALUES (615, 'da Rocha Machado - ME', 'da Rocha Machado - ME Next');
INSERT INTO public.empresa VALUES (616, 'Smith-Dixon', 'Smith-Dixon Legal');
INSERT INTO public.empresa VALUES (617, 'Humphrey, Miller and Garcia', 'Humphrey, Miller and Garcia Clinic');
INSERT INTO public.empresa VALUES (618, 'Ellis-James', 'Ellis-James Obras');
INSERT INTO public.empresa VALUES (619, 'Cox Inc', 'Cox Inc Obras');
INSERT INTO public.empresa VALUES (620, 'Wood, Davies and Evans', 'Wood, Davies and Evans Partners');
INSERT INTO public.empresa VALUES (621, 'Martinez and Sons', 'Martinez and Sons Atacado');
INSERT INTO public.empresa VALUES (622, 'Garcia Inc', 'Garcia Inc Smart');
INSERT INTO public.empresa VALUES (623, 'Morgan, Rodriguez and Freeman', 'Morgan, Rodriguez and Freeman Clinic');
INSERT INTO public.empresa VALUES (624, 'Simpson Ltd', 'Simpson Ltd Engine');
INSERT INTO public.empresa VALUES (625, 'Mendes Ltda.', 'Mendes Ltda. Agency');
INSERT INTO public.empresa VALUES (626, 'Bradley-Frye', 'Bradley-Frye Investimentos');
INSERT INTO public.empresa VALUES (627, 'Araújo Nunes - ME', 'Araújo Nunes - ME Moda');
INSERT INTO public.empresa VALUES (628, 'Costela', 'Costela Factory');
INSERT INTO public.empresa VALUES (629, 'Moore Group', 'Moore Group Imobiliária');
INSERT INTO public.empresa VALUES (630, 'Hood-Alexander', 'Hood-Alexander Atacado');
INSERT INTO public.empresa VALUES (631, 'Martins Brito - ME', 'Martins Brito - ME Hub');
INSERT INTO public.empresa VALUES (632, 'Teixeira Carvalho e Filhos', 'Teixeira Carvalho e Filhos Obras');
INSERT INTO public.empresa VALUES (633, 'Taylor, Bradley and Parrish', 'Taylor, Bradley and Parrish Alimentos');
INSERT INTO public.empresa VALUES (634, 'Wheeler, Aguirre and Torres', 'Wheeler, Aguirre and Torres Construções');
INSERT INTO public.empresa VALUES (635, 'Leão - EI', 'Leão - EI Edge');
INSERT INTO public.empresa VALUES (636, 'Rodriguez-Nielsen', 'Rodriguez-Nielsen Agency');
INSERT INTO public.empresa VALUES (637, 'Araújo S.A.', 'Araújo S.A. Grupo');
INSERT INTO public.empresa VALUES (638, 'Azevedo', 'Azevedo Strategies');
INSERT INTO public.empresa VALUES (639, 'Dias Ltda.', 'Dias Ltda. Platform');
INSERT INTO public.empresa VALUES (640, 'Câmara Araújo e Filhos', 'Câmara Araújo e Filhos Partners');
INSERT INTO public.empresa VALUES (641, 'Walsh, Howard and Smith', 'Walsh, Howard and Smith Edge');
INSERT INTO public.empresa VALUES (642, 'Castro Guerra e Filhos', 'Castro Guerra e Filhos Agency');
INSERT INTO public.empresa VALUES (643, 'Allen LLC', 'Allen LLC Ambiental');
INSERT INTO public.empresa VALUES (644, 'Abreu e Filhos', 'Abreu e Filhos Delícias');
INSERT INTO public.empresa VALUES (645, 'Nguyen-Castillo', 'Nguyen-Castillo Obras');
INSERT INTO public.empresa VALUES (646, 'Garza-Ford', 'Garza-Ford Solutions');
INSERT INTO public.empresa VALUES (647, 'Alves Sales - ME', 'Alves Sales - ME Services');
INSERT INTO public.empresa VALUES (648, 'das Neves Gomes Ltda.', 'das Neves Gomes Ltda. Consulting');
INSERT INTO public.empresa VALUES (649, 'Lee, Cordova and Jenkins', 'Lee, Cordova and Jenkins Consulting');
INSERT INTO public.empresa VALUES (650, 'Teixeira Aragão - ME', 'Teixeira Aragão - ME Worldwide');
INSERT INTO public.empresa VALUES (651, 'Albuquerque Azevedo - EI', 'Albuquerque Azevedo - EI Culinária');
INSERT INTO public.empresa VALUES (652, 'Perkins-Mathews', 'Perkins-Mathews Treinamento');
INSERT INTO public.empresa VALUES (653, 'Silva', 'Silva Next');
INSERT INTO public.empresa VALUES (654, 'Horn-Navarro', 'Horn-Navarro Eco');
INSERT INTO public.empresa VALUES (655, 'Lopez-Evans', 'Lopez-Evans Global');
INSERT INTO public.empresa VALUES (656, 'Rose Ltd', 'Rose Ltd Design');
INSERT INTO public.empresa VALUES (657, 'Almeida Freitas Ltda.', 'Almeida Freitas Ltda. Atelier');
INSERT INTO public.empresa VALUES (658, 'da Mata da Luz - EI', 'da Mata da Luz - EI Holdings');
INSERT INTO public.empresa VALUES (659, 'Moore Inc', 'Moore Inc Agency');
INSERT INTO public.empresa VALUES (660, 'Mitchell and Sons', 'Mitchell and Sons Agency');
INSERT INTO public.empresa VALUES (661, 'Montenegro Ltda.', 'Montenegro Ltda. Networks');
INSERT INTO public.empresa VALUES (662, 'Williams Ltd', 'Williams Ltd Atacado');
INSERT INTO public.empresa VALUES (663, 'Cavalcanti - ME', 'Cavalcanti - ME Atelier');
INSERT INTO public.empresa VALUES (664, 'Martinez-Miller', 'Martinez-Miller Inteligência');
INSERT INTO public.empresa VALUES (665, 'Novais S.A.', 'Novais S.A. Educação');
INSERT INTO public.empresa VALUES (666, 'Guerra S.A.', 'Guerra S.A. Empreendimentos');
INSERT INTO public.empresa VALUES (667, 'Howell PLC', 'Howell PLC Capital');
INSERT INTO public.empresa VALUES (668, 'Mendonça Sá S.A.', 'Mendonça Sá S.A. Wellness');
INSERT INTO public.empresa VALUES (669, 'Morris Ltd', 'Morris Ltd Boutique');
INSERT INTO public.empresa VALUES (670, 'Barros e Filhos', 'Barros e Filhos Atelier');
INSERT INTO public.empresa VALUES (671, 'Robinson-Parker', 'Robinson-Parker Factory');
INSERT INTO public.empresa VALUES (672, 'da Rocha S/A', 'da Rocha S/A Services');
INSERT INTO public.empresa VALUES (673, 'Morgan PLC', 'Morgan PLC Culinária');
INSERT INTO public.empresa VALUES (674, 'Hall Group', 'Hall Group Universal');
INSERT INTO public.empresa VALUES (675, 'Roberts, Williams and Hall', 'Roberts, Williams and Hall Factory');
INSERT INTO public.empresa VALUES (676, 'Moss, Wilson and Love', 'Moss, Wilson and Love Academia');
INSERT INTO public.empresa VALUES (677, 'Howard-Boone', 'Howard-Boone Capital');
INSERT INTO public.empresa VALUES (678, 'Perez PLC', 'Perez PLC Holdings');
INSERT INTO public.empresa VALUES (679, 'Wilkerson-Roberts', 'Wilkerson-Roberts Holdings');
INSERT INTO public.empresa VALUES (680, 'Cohen, Mclean and Ross', 'Cohen, Mclean and Ross Holdings');
INSERT INTO public.empresa VALUES (681, 'Howard, Robinson and Sanchez', 'Howard, Robinson and Sanchez Educação');
INSERT INTO public.empresa VALUES (682, 'Jones-Stevens', 'Jones-Stevens Factory');
INSERT INTO public.empresa VALUES (683, 'das Neves da Costa S.A.', 'das Neves da Costa S.A. Next');
INSERT INTO public.empresa VALUES (684, 'Rodrigues Abreu S/A', 'Rodrigues Abreu S/A Worldwide');
INSERT INTO public.empresa VALUES (685, 'Bender Inc', 'Bender Inc Enterprises');
INSERT INTO public.empresa VALUES (686, 'Carson-Clark', 'Carson-Clark Ambiental');
INSERT INTO public.empresa VALUES (687, 'Ramirez and Sons', 'Ramirez and Sons Prime');
INSERT INTO public.empresa VALUES (688, 'Ramos', 'Ramos Tecnologia');
INSERT INTO public.empresa VALUES (689, 'Perez, Mann and Williams', 'Perez, Mann and Williams Moda');
INSERT INTO public.empresa VALUES (690, 'Vargas S.A.', 'Vargas S.A. Frete');
INSERT INTO public.empresa VALUES (691, 'Morgan Inc', 'Morgan Inc Private');
INSERT INTO public.empresa VALUES (692, 'Moura - ME', 'Moura - ME Inovação');
INSERT INTO public.empresa VALUES (693, 'Torres, George and Moore', 'Torres, George and Moore Legal');
INSERT INTO public.empresa VALUES (694, 'Castaneda-Nelson', 'Castaneda-Nelson Culinária');
INSERT INTO public.empresa VALUES (695, 'Borges e Filhos', 'Borges e Filhos Academia');
INSERT INTO public.empresa VALUES (696, 'da Rocha Vasconcelos Ltda.', 'da Rocha Vasconcelos Ltda. Design');
INSERT INTO public.empresa VALUES (697, 'das Neves Duarte Ltda.', 'das Neves Duarte Ltda. Worldwide');
INSERT INTO public.empresa VALUES (698, 'Nascimento - ME', 'Nascimento - ME Next');
INSERT INTO public.empresa VALUES (699, 'Camargo Azevedo Ltda.', 'Camargo Azevedo Ltda. Creative');
INSERT INTO public.empresa VALUES (700, 'Macedo Ltda.', 'Macedo Ltda. Platform');
INSERT INTO public.empresa VALUES (701, 'Anderson-Howard', 'Anderson-Howard Systems');
INSERT INTO public.empresa VALUES (702, 'Jesus Jesus S.A.', 'Jesus Jesus S.A. Assessoria');
INSERT INTO public.empresa VALUES (703, 'da Luz', 'da Luz Imobiliária');
INSERT INTO public.empresa VALUES (704, 'Vargas - EI', 'Vargas - EI Obras');
INSERT INTO public.empresa VALUES (705, 'Caldeira Barros - EI', 'Caldeira Barros - EI Consulting');
INSERT INTO public.empresa VALUES (706, 'da Cunha - ME', 'da Cunha - ME Inteligência');
INSERT INTO public.empresa VALUES (707, 'Wright-Sanders', 'Wright-Sanders Transportes');
INSERT INTO public.empresa VALUES (708, 'Davis, Garza and Smith', 'Davis, Garza and Smith Agency');
INSERT INTO public.empresa VALUES (709, 'Hooper, Dickerson and Brown', 'Hooper, Dickerson and Brown Logística');
INSERT INTO public.empresa VALUES (710, 'Stafford-Higgins', 'Stafford-Higgins Consultoria');
INSERT INTO public.empresa VALUES (711, 'Oliveira Ltda.', 'Oliveira Ltda. Transportes');
INSERT INTO public.empresa VALUES (712, 'Green, Ross and Krueger', 'Green, Ross and Krueger Medical');
INSERT INTO public.empresa VALUES (713, 'Morris-Garcia', 'Morris-Garcia Ambiental');
INSERT INTO public.empresa VALUES (714, 'Almeida', 'Almeida Medical');
INSERT INTO public.empresa VALUES (715, 'Weaver-Davis', 'Weaver-Davis Wellness');
INSERT INTO public.empresa VALUES (716, 'Melo - ME', 'Melo - ME Operações');
INSERT INTO public.empresa VALUES (717, 'Rodriguez-Nunez', 'Rodriguez-Nunez Gastronomia');
INSERT INTO public.empresa VALUES (718, 'Stone Ltd', 'Stone Ltd Design');
INSERT INTO public.empresa VALUES (719, 'Correia S.A.', 'Correia S.A. Advisors');
INSERT INTO public.empresa VALUES (720, 'Williams, Miller and Smith', 'Williams, Miller and Smith Boutique');
INSERT INTO public.empresa VALUES (721, 'Cirino Leão - ME', 'Cirino Leão - ME Investimentos');
INSERT INTO public.empresa VALUES (722, 'Albuquerque Ramos Ltda.', 'Albuquerque Ramos Ltda. Investimentos');
INSERT INTO public.empresa VALUES (723, 'Bishop-Chandler', 'Bishop-Chandler Collective');
INSERT INTO public.empresa VALUES (724, 'da Mota Pinto S.A.', 'da Mota Pinto S.A. Design');
INSERT INTO public.empresa VALUES (725, 'Combs, Palmer and Fitzgerald', 'Combs, Palmer and Fitzgerald Factory');
INSERT INTO public.empresa VALUES (726, 'Wallace, King and Henderson', 'Wallace, King and Henderson Wellness');
INSERT INTO public.empresa VALUES (727, 'Howard, Mack and Waller', 'Howard, Mack and Waller Serviços');
INSERT INTO public.empresa VALUES (728, 'Rodrigues Vieira - ME', 'Rodrigues Vieira - ME Wellness');
INSERT INTO public.empresa VALUES (729, 'Rocha', 'Rocha Hub');
INSERT INTO public.empresa VALUES (730, 'Velasquez and Sons', 'Velasquez and Sons Collective');
INSERT INTO public.empresa VALUES (731, 'Montenegro - ME', 'Montenegro - ME Co');
INSERT INTO public.empresa VALUES (732, 'Marques Cavalcanti - ME', 'Marques Cavalcanti - ME Global');
INSERT INTO public.empresa VALUES (733, 'Miller-Black', 'Miller-Black Consultoria');
INSERT INTO public.empresa VALUES (734, 'Palmer, Shaw and Harding', 'Palmer, Shaw and Harding Operações');
INSERT INTO public.empresa VALUES (735, 'Allen, Walter and Morgan', 'Allen, Walter and Morgan Ambiental');
INSERT INTO public.empresa VALUES (736, 'Campos Pereira S.A.', 'Campos Pereira S.A. Construções');
INSERT INTO public.empresa VALUES (737, 'Campbell-Washington', 'Campbell-Washington Delícias');
INSERT INTO public.empresa VALUES (738, 'Lewis, Harvey and Hill', 'Lewis, Harvey and Hill Comércio');
INSERT INTO public.empresa VALUES (739, 'Marshall, Shaw and Guzman', 'Marshall, Shaw and Guzman Delícias');
INSERT INTO public.empresa VALUES (740, 'Novaes da Conceição Ltda.', 'Novaes da Conceição Ltda. Private');
INSERT INTO public.empresa VALUES (741, 'Long, Murray and Stone', 'Long, Murray and Stone Investimentos');
INSERT INTO public.empresa VALUES (742, 'Machado Moura - EI', 'Machado Moura - EI Sustentável');
INSERT INTO public.empresa VALUES (743, 'Tucker Ltd', 'Tucker Ltd Enterprises');
INSERT INTO public.empresa VALUES (744, 'Guerra Leão e Filhos', 'Guerra Leão e Filhos Networks');
INSERT INTO public.empresa VALUES (745, 'Weber-Tran', 'Weber-Tran Consulting');
INSERT INTO public.empresa VALUES (746, 'Martins Ltda.', 'Martins Ltda. Legal');
INSERT INTO public.empresa VALUES (747, 'Fonseca Barbosa - EI', 'Fonseca Barbosa - EI Academia');
INSERT INTO public.empresa VALUES (748, 'Mills, Maldonado and Fisher', 'Mills, Maldonado and Fisher Capital');
INSERT INTO public.empresa VALUES (749, 'Williams-Sanchez', 'Williams-Sanchez Universal');
INSERT INTO public.empresa VALUES (750, 'Pinto - EI', 'Pinto - EI Comércio');
INSERT INTO public.empresa VALUES (751, 'Hernandez Group', 'Hernandez Group Partners');
INSERT INTO public.empresa VALUES (752, 'Wells, Hines and Phillips', 'Wells, Hines and Phillips Inovação');
INSERT INTO public.empresa VALUES (753, 'Walker, Ramirez and Smith', 'Walker, Ramirez and Smith Varejo');
INSERT INTO public.empresa VALUES (754, 'Campos Guerra e Filhos', 'Campos Guerra e Filhos Empreendimentos');
INSERT INTO public.empresa VALUES (755, 'Newman PLC', 'Newman PLC Obras');
INSERT INTO public.empresa VALUES (756, 'Lamb, Edwards and Paul', 'Lamb, Edwards and Paul Engine');
INSERT INTO public.empresa VALUES (757, 'Marques Moreira - EI', 'Marques Moreira - EI Construções');
INSERT INTO public.empresa VALUES (758, 'da Paz - EI', 'da Paz - EI International');
INSERT INTO public.empresa VALUES (759, 'Jenkins Ltd', 'Jenkins Ltd Inteligência');
INSERT INTO public.empresa VALUES (760, 'Porto Caldeira S/A', 'Porto Caldeira S/A Solutions');
INSERT INTO public.empresa VALUES (761, 'Rivas, Anderson and Hall', 'Rivas, Anderson and Hall Advocacia');
INSERT INTO public.empresa VALUES (762, 'Alexander-Arellano', 'Alexander-Arellano Worldwide');
INSERT INTO public.empresa VALUES (763, 'Leblanc, Campbell and Poole', 'Leblanc, Campbell and Poole Alimentos');
INSERT INTO public.empresa VALUES (764, 'Albuquerque Barros S/A', 'Albuquerque Barros S/A Serviços');
INSERT INTO public.empresa VALUES (765, 'Casa Grande e Filhos', 'Casa Grande e Filhos Labs');
INSERT INTO public.empresa VALUES (766, 'Lewis, Porter and Wyatt', 'Lewis, Porter and Wyatt Alimentos');
INSERT INTO public.empresa VALUES (767, 'Dawson-Mcmillan', 'Dawson-Mcmillan Boutique');
INSERT INTO public.empresa VALUES (768, 'Goodman, Jackson and Dean', 'Goodman, Jackson and Dean Systems');
INSERT INTO public.empresa VALUES (769, 'Bailey, Marquez and Hayes', 'Bailey, Marquez and Hayes Inovação');
INSERT INTO public.empresa VALUES (770, 'Macedo Pinto S.A.', 'Macedo Pinto S.A. Frete');
INSERT INTO public.empresa VALUES (771, 'Dean, Smith and Baxter', 'Dean, Smith and Baxter Operações');
INSERT INTO public.empresa VALUES (772, 'Dias S/A', 'Dias S/A Frete');
INSERT INTO public.empresa VALUES (773, 'Viana e Filhos', 'Viana e Filhos Transportes');
INSERT INTO public.empresa VALUES (774, 'Munoz, Crawford and Jones', 'Munoz, Crawford and Jones Strategies');
INSERT INTO public.empresa VALUES (775, 'da Paz S/A', 'da Paz S/A Global');
INSERT INTO public.empresa VALUES (776, 'Palmer and Sons', 'Palmer and Sons Collective');
INSERT INTO public.empresa VALUES (777, 'Coleman, Hill and Collins', 'Coleman, Hill and Collins Comércio');
INSERT INTO public.empresa VALUES (778, 'Owens PLC', 'Owens PLC Agency');
INSERT INTO public.empresa VALUES (779, 'Fernandes Albuquerque - ME', 'Fernandes Albuquerque - ME Assessoria');
INSERT INTO public.empresa VALUES (780, 'Lopez LLC', 'Lopez LLC Operações');
INSERT INTO public.empresa VALUES (781, 'Jennings, Green and Henderson', 'Jennings, Green and Henderson Agency');
INSERT INTO public.empresa VALUES (782, 'Hunter Ltd', 'Hunter Ltd Eco');
INSERT INTO public.empresa VALUES (783, 'Delgado, Goodwin and Cain', 'Delgado, Goodwin and Cain Systems');
INSERT INTO public.empresa VALUES (784, 'Brown, Stewart and Jones', 'Brown, Stewart and Jones Solutions');
INSERT INTO public.empresa VALUES (785, 'Gardner Group', 'Gardner Group Factory');
INSERT INTO public.empresa VALUES (786, 'Fogaça S.A.', 'Fogaça S.A. Construções');
INSERT INTO public.empresa VALUES (787, 'Moreira Nascimento S.A.', 'Moreira Nascimento S.A. Agency');
INSERT INTO public.empresa VALUES (788, 'Leão S/A', 'Leão S/A Digital');
INSERT INTO public.empresa VALUES (789, 'Cavalcante - ME', 'Cavalcante - ME Verde');
INSERT INTO public.empresa VALUES (790, 'Câmara Gomes Ltda.', 'Câmara Gomes Ltda. Co');
INSERT INTO public.empresa VALUES (791, 'Green-Burns', 'Green-Burns Moda');
INSERT INTO public.empresa VALUES (792, 'Silveira Santos S.A.', 'Silveira Santos S.A. Grupo');
INSERT INTO public.empresa VALUES (793, 'Costela e Filhos', 'Costela e Filhos Logística');
INSERT INTO public.empresa VALUES (794, 'Jacobs-Alexander', 'Jacobs-Alexander Treinamento');
INSERT INTO public.empresa VALUES (795, 'Barros Pastor S/A', 'Barros Pastor S/A Boutique');
INSERT INTO public.empresa VALUES (796, 'Montenegro S.A.', 'Montenegro S.A. Tecnologia');
INSERT INTO public.empresa VALUES (797, 'Fritz Group', 'Fritz Group Global');
INSERT INTO public.empresa VALUES (798, 'Cole-Mcintyre', 'Cole-Mcintyre Networks');
INSERT INTO public.empresa VALUES (799, 'Gomes Rocha e Filhos', 'Gomes Rocha e Filhos Clinic');
INSERT INTO public.empresa VALUES (800, 'Lopes - ME', 'Lopes - ME Networks');
INSERT INTO public.empresa VALUES (801, 'Robinson PLC', 'Robinson PLC Universal');
INSERT INTO public.empresa VALUES (802, 'Sales e Filhos', 'Sales e Filhos Eco');
INSERT INTO public.empresa VALUES (803, 'da Luz Ferreira - ME', 'da Luz Ferreira - ME Services');
INSERT INTO public.empresa VALUES (804, 'Castro Rocha - EI', 'Castro Rocha - EI Educação');
INSERT INTO public.empresa VALUES (805, 'da Paz S.A.', 'da Paz S.A. Advisors');
INSERT INTO public.empresa VALUES (806, 'Guerra S/A', 'Guerra S/A Boutique');
INSERT INTO public.empresa VALUES (807, 'Nunes Machado - EI', 'Nunes Machado - EI Next');
INSERT INTO public.empresa VALUES (808, 'Smith, White and Bailey', 'Smith, White and Bailey Tecnologia');
INSERT INTO public.empresa VALUES (809, 'Wyatt-Berry', 'Wyatt-Berry Frete');
INSERT INTO public.empresa VALUES (810, 'Cook-Taylor', 'Cook-Taylor Partners');
INSERT INTO public.empresa VALUES (811, 'Murray-Zamora', 'Murray-Zamora Obras');
INSERT INTO public.empresa VALUES (812, 'Borges Vargas Ltda.', 'Borges Vargas Ltda. Wellness');
INSERT INTO public.empresa VALUES (813, 'Byrd, Smith and Thornton', 'Byrd, Smith and Thornton Capital');
INSERT INTO public.empresa VALUES (814, 'Fernandez Ltd', 'Fernandez Ltd Estilo');
INSERT INTO public.empresa VALUES (815, 'Costela Oliveira - ME', 'Costela Oliveira - ME Gastronomia');
INSERT INTO public.empresa VALUES (816, 'Mendonça Vargas - ME', 'Mendonça Vargas - ME Healthcare');
INSERT INTO public.empresa VALUES (817, 'Preston-Flores', 'Preston-Flores Systems');
INSERT INTO public.empresa VALUES (818, 'Lewis-Blake', 'Lewis-Blake Partners');
INSERT INTO public.empresa VALUES (819, 'Pham-Butler', 'Pham-Butler Educação');
INSERT INTO public.empresa VALUES (820, 'Alexander-Gallagher', 'Alexander-Gallagher Design');
INSERT INTO public.empresa VALUES (821, 'Nunes e Filhos', 'Nunes e Filhos Formação');
INSERT INTO public.empresa VALUES (822, 'Walters, Tyler and Jones', 'Walters, Tyler and Jones Digital');
INSERT INTO public.empresa VALUES (823, 'Simpson, Smith and Jacobs', 'Simpson, Smith and Jacobs Serviços');
INSERT INTO public.empresa VALUES (824, 'Nascimento Ltda.', 'Nascimento Ltda. Networks');
INSERT INTO public.empresa VALUES (825, 'Silveira Nunes e Filhos', 'Silveira Nunes e Filhos Works');
INSERT INTO public.empresa VALUES (826, 'Costa S/A', 'Costa S/A Construções');
INSERT INTO public.empresa VALUES (827, 'Ramos - EI', 'Ramos - EI Healthcare');
INSERT INTO public.empresa VALUES (828, 'Smith-Delacruz', 'Smith-Delacruz Serviços');
INSERT INTO public.empresa VALUES (829, 'Sosa, Garcia and Parker', 'Sosa, Garcia and Parker Worldwide');
INSERT INTO public.empresa VALUES (830, 'Andrade, Glover and Marshall', 'Andrade, Glover and Marshall Labs');
INSERT INTO public.empresa VALUES (831, 'Diaz LLC', 'Diaz LLC Boutique');
INSERT INTO public.empresa VALUES (832, 'da Cunha Borges Ltda.', 'da Cunha Borges Ltda. Healthcare');
INSERT INTO public.empresa VALUES (833, 'Luna and Sons', 'Luna and Sons Advocacia');
INSERT INTO public.empresa VALUES (834, 'Bauer-Roth', 'Bauer-Roth Operações');
INSERT INTO public.empresa VALUES (835, 'Casa Grande Viana S/A', 'Casa Grande Viana S/A Digital');
INSERT INTO public.empresa VALUES (836, 'Robinson, Nguyen and Lee', 'Robinson, Nguyen and Lee Universal');
INSERT INTO public.empresa VALUES (837, 'Hinton, Shaw and Allen', 'Hinton, Shaw and Allen Engine');
INSERT INTO public.empresa VALUES (838, 'Castaneda, Johnson and Ware', 'Castaneda, Johnson and Ware Frete');
INSERT INTO public.empresa VALUES (839, 'Mccoy-Mack', 'Mccoy-Mack Transportes');
INSERT INTO public.empresa VALUES (840, 'Mann-Turner', 'Mann-Turner Ambiental');
INSERT INTO public.empresa VALUES (841, 'Jensen-Berry', 'Jensen-Berry Atacado');
INSERT INTO public.empresa VALUES (842, 'Baker, Johnson and Moore', 'Baker, Johnson and Moore Agency');
INSERT INTO public.empresa VALUES (843, 'Arnold Ltd', 'Arnold Ltd Global');
INSERT INTO public.empresa VALUES (844, 'Sousa - EI', 'Sousa - EI Serviços');
INSERT INTO public.empresa VALUES (845, 'Farias Peixoto - ME', 'Farias Peixoto - ME Jurídico');
INSERT INTO public.empresa VALUES (846, 'Reyes-Richards', 'Reyes-Richards Frete');
INSERT INTO public.empresa VALUES (847, 'da Rosa da Rocha - EI', 'da Rosa da Rocha - EI Finanças');
INSERT INTO public.empresa VALUES (848, 'Scott-Nelson', 'Scott-Nelson Prime');
INSERT INTO public.empresa VALUES (849, 'Garcia Rezende - EI', 'Garcia Rezende - EI Distribuidora');
INSERT INTO public.empresa VALUES (850, 'Brown-Duncan', 'Brown-Duncan Clinic');
INSERT INTO public.empresa VALUES (851, 'Rezende', 'Rezende Hub');
INSERT INTO public.empresa VALUES (852, 'Silveira - EI', 'Silveira - EI Worldwide');
INSERT INTO public.empresa VALUES (853, 'Smith, Garcia and Vazquez', 'Smith, Garcia and Vazquez Design');
INSERT INTO public.empresa VALUES (854, 'Jones-Clark', 'Jones-Clark Obras');
INSERT INTO public.empresa VALUES (855, 'Macedo Guerra e Filhos', 'Macedo Guerra e Filhos Private');
INSERT INTO public.empresa VALUES (856, 'da Costa Abreu - EI', 'da Costa Abreu - EI Studio');
INSERT INTO public.empresa VALUES (857, 'Carney-Cannon', 'Carney-Cannon Alimentos');
INSERT INTO public.empresa VALUES (858, 'Romero Ltd', 'Romero Ltd Solutions');
INSERT INTO public.empresa VALUES (859, 'da Costa da Luz e Filhos', 'da Costa da Luz e Filhos Varejo');
INSERT INTO public.empresa VALUES (860, 'Harris, Rodriguez and Moss', 'Harris, Rodriguez and Moss Partners');
INSERT INTO public.empresa VALUES (861, 'Thomas PLC', 'Thomas PLC Gastronomia');
INSERT INTO public.empresa VALUES (862, 'Khan, Carpenter and Foster', 'Khan, Carpenter and Foster Collective');
INSERT INTO public.empresa VALUES (863, 'Hansen-Mcdaniel', 'Hansen-Mcdaniel Transportes');
INSERT INTO public.empresa VALUES (864, 'Nunes S/A', 'Nunes S/A Engine');
INSERT INTO public.empresa VALUES (865, 'Silveira Oliveira Ltda.', 'Silveira Oliveira Ltda. Logística');
INSERT INTO public.empresa VALUES (866, 'Bailey, Schroeder and Brown', 'Bailey, Schroeder and Brown Treinamento');
INSERT INTO public.empresa VALUES (867, 'Brooks and Sons', 'Brooks and Sons Partners');
INSERT INTO public.empresa VALUES (868, 'Kelly, Molina and Flores', 'Kelly, Molina and Flores Treinamento');
INSERT INTO public.empresa VALUES (869, 'Aparecida Ltda.', 'Aparecida Ltda. Advocacia');
INSERT INTO public.empresa VALUES (870, 'Silveira S.A.', 'Silveira S.A. Solutions');
INSERT INTO public.empresa VALUES (871, 'Smith PLC', 'Smith PLC Healthcare');
INSERT INTO public.empresa VALUES (872, 'Azevedo Costela S.A.', 'Azevedo Costela S.A. Partners');
INSERT INTO public.empresa VALUES (873, 'da Luz S.A.', 'da Luz S.A. Alimentos');
INSERT INTO public.empresa VALUES (874, 'Walker and Sons', 'Walker and Sons Jurídico');
INSERT INTO public.empresa VALUES (875, 'Burke, Murphy and Kelly', 'Burke, Murphy and Kelly Comércio');
INSERT INTO public.empresa VALUES (876, 'Johnson, Mcgee and Davis', 'Johnson, Mcgee and Davis Boutique');
INSERT INTO public.empresa VALUES (877, 'Peixoto Novaes e Filhos', 'Peixoto Novaes e Filhos Advocacia');
INSERT INTO public.empresa VALUES (878, 'Owen, Sullivan and Flores', 'Owen, Sullivan and Flores Serviços');
INSERT INTO public.empresa VALUES (879, 'Choi Group', 'Choi Group Treinamento');
INSERT INTO public.empresa VALUES (880, 'Perez, Morgan and Johnson', 'Perez, Morgan and Johnson Capital');
INSERT INTO public.empresa VALUES (881, 'Campos Santos Ltda.', 'Campos Santos Ltda. Agency');
INSERT INTO public.empresa VALUES (882, 'Scott Inc', 'Scott Inc Solutions');
INSERT INTO public.empresa VALUES (883, 'Nascimento - EI', 'Nascimento - EI Alimentos');
INSERT INTO public.empresa VALUES (884, 'Lima Silveira S.A.', 'Lima Silveira S.A. Clinic');
INSERT INTO public.empresa VALUES (885, 'Monteiro - ME', 'Monteiro - ME Worldwide');
INSERT INTO public.empresa VALUES (886, 'Luna-Vasquez', 'Luna-Vasquez Factory');
INSERT INTO public.empresa VALUES (887, 'Rezende S/A', 'Rezende S/A Wellness');
INSERT INTO public.empresa VALUES (888, 'Harris, Clark and Peterson', 'Harris, Clark and Peterson Prime');
INSERT INTO public.empresa VALUES (889, 'da Costa Rezende e Filhos', 'da Costa Rezende e Filhos Solutions');
INSERT INTO public.empresa VALUES (890, 'Jackson, Miller and Nelson', 'Jackson, Miller and Nelson Services');
INSERT INTO public.empresa VALUES (891, 'Cardoso Ferreira e Filhos', 'Cardoso Ferreira e Filhos Gastronomia');
INSERT INTO public.empresa VALUES (892, 'Holmes-Stuart', 'Holmes-Stuart Moda');
INSERT INTO public.empresa VALUES (893, 'Souza - EI', 'Souza - EI Prime');
INSERT INTO public.empresa VALUES (894, 'Jones-Bennett', 'Jones-Bennett Atacado');
INSERT INTO public.empresa VALUES (895, 'Correia Sampaio - EI', 'Correia Sampaio - EI Services');
INSERT INTO public.empresa VALUES (896, 'Ribeiro Novaes Ltda.', 'Ribeiro Novaes Ltda. Strategies');
INSERT INTO public.empresa VALUES (897, 'Miller, Bass and Roberts', 'Miller, Bass and Roberts Edge');
INSERT INTO public.empresa VALUES (898, 'Araújo Duarte - ME', 'Araújo Duarte - ME Moda');
INSERT INTO public.empresa VALUES (899, 'das Neves Ltda.', 'das Neves Ltda. Tecnologia');
INSERT INTO public.empresa VALUES (900, 'Caldeira da Costa Ltda.', 'Caldeira da Costa Ltda. Varejo');
INSERT INTO public.empresa VALUES (901, 'Thompson, Rogers and Hall', 'Thompson, Rogers and Hall Private');
INSERT INTO public.empresa VALUES (902, 'da Mata Mendes S/A', 'da Mata Mendes S/A Labs');
INSERT INTO public.empresa VALUES (903, 'Cunha Pimenta S.A.', 'Cunha Pimenta S.A. Networks');
INSERT INTO public.empresa VALUES (904, 'Stark-Brooks', 'Stark-Brooks Empreendimentos');
INSERT INTO public.empresa VALUES (905, 'Cassiano S.A.', 'Cassiano S.A. Factory');
INSERT INTO public.empresa VALUES (906, 'Mendez-Miller', 'Mendez-Miller Medical');
INSERT INTO public.empresa VALUES (907, 'Shah, Hurley and Diaz', 'Shah, Hurley and Diaz Frete');
INSERT INTO public.empresa VALUES (908, 'Cassiano Mendes - ME', 'Cassiano Mendes - ME International');
INSERT INTO public.empresa VALUES (909, 'Gomez, Johnson and Williams', 'Gomez, Johnson and Williams Serviços');
INSERT INTO public.empresa VALUES (910, 'King, Martinez and Deleon', 'King, Martinez and Deleon Verde');
INSERT INTO public.empresa VALUES (911, 'Costa Gomes e Filhos', 'Costa Gomes e Filhos Serviços');
INSERT INTO public.empresa VALUES (912, 'Jones, Hardy and Wells', 'Jones, Hardy and Wells Eco');
INSERT INTO public.empresa VALUES (913, 'Mitchell-Thompson', 'Mitchell-Thompson International');
INSERT INTO public.empresa VALUES (914, 'Simpson-Gonzalez', 'Simpson-Gonzalez Enterprises');
INSERT INTO public.empresa VALUES (915, 'Banks and Sons', 'Banks and Sons Varejo');
INSERT INTO public.empresa VALUES (916, 'Ferreira Nascimento S/A', 'Ferreira Nascimento S/A Worldwide');
INSERT INTO public.empresa VALUES (917, 'Castillo PLC', 'Castillo PLC Culinária');
INSERT INTO public.empresa VALUES (918, 'Martins S/A', 'Martins S/A Design');
INSERT INTO public.empresa VALUES (919, 'Eaton, Wall and Peters', 'Eaton, Wall and Peters Sustentável');
INSERT INTO public.empresa VALUES (920, 'Smith, Adams and Harper', 'Smith, Adams and Harper Hub');
INSERT INTO public.empresa VALUES (921, 'Oliveira da Mota e Filhos', 'Oliveira da Mota e Filhos Sustentável');
INSERT INTO public.empresa VALUES (922, 'Sampaio e Filhos', 'Sampaio e Filhos Solutions');
INSERT INTO public.empresa VALUES (923, 'Andrade Souza S.A.', 'Andrade Souza S.A. Imobiliária');
INSERT INTO public.empresa VALUES (924, 'Banks Inc', 'Banks Inc Atelier');
INSERT INTO public.empresa VALUES (925, 'Silveira da Mata Ltda.', 'Silveira da Mata Ltda. Atelier');
INSERT INTO public.empresa VALUES (926, 'Moura S/A', 'Moura S/A Labs');
INSERT INTO public.empresa VALUES (927, 'Camargo Viana S/A', 'Camargo Viana S/A Prime');
INSERT INTO public.empresa VALUES (928, 'Vasconcelos - ME', 'Vasconcelos - ME Comércio');
INSERT INTO public.empresa VALUES (929, 'Brown-Leon', 'Brown-Leon Labs');
INSERT INTO public.empresa VALUES (930, 'da Cruz e Filhos', 'da Cruz e Filhos Inteligência');
INSERT INTO public.empresa VALUES (931, 'Williams-Case', 'Williams-Case Verde');
INSERT INTO public.empresa VALUES (932, 'da Rocha Silveira S.A.', 'da Rocha Silveira S.A. Worldwide');
INSERT INTO public.empresa VALUES (933, 'Miller-Watson', 'Miller-Watson Medical');
INSERT INTO public.empresa VALUES (934, 'Hines, Harvey and Petersen', 'Hines, Harvey and Petersen Inteligência');
INSERT INTO public.empresa VALUES (935, 'Freitas', 'Freitas Holdings');
INSERT INTO public.empresa VALUES (936, 'Pacheco Cavalcante - EI', 'Pacheco Cavalcante - EI Edge');
INSERT INTO public.empresa VALUES (937, 'Costa Câmara S/A', 'Costa Câmara S/A Investimentos');
INSERT INTO public.empresa VALUES (938, 'Sanchez LLC', 'Sanchez LLC Frete');
INSERT INTO public.empresa VALUES (939, 'Novaes - EI', 'Novaes - EI Boutique');
INSERT INTO public.empresa VALUES (940, 'Carr-Howell', 'Carr-Howell Consultoria');
INSERT INTO public.empresa VALUES (941, 'Cardoso Pimenta S/A', 'Cardoso Pimenta S/A Labs');
INSERT INTO public.empresa VALUES (942, 'Raymond-Romero', 'Raymond-Romero Eco');
INSERT INTO public.empresa VALUES (943, 'Rezende Peixoto e Filhos', 'Rezende Peixoto e Filhos Varejo');
INSERT INTO public.empresa VALUES (944, 'Cavalcante S.A.', 'Cavalcante S.A. Logística');
INSERT INTO public.empresa VALUES (945, 'Miller Ltd', 'Miller Ltd Wellness');
INSERT INTO public.empresa VALUES (946, 'Caldeira - EI', 'Caldeira - EI Collective');
INSERT INTO public.empresa VALUES (947, 'Anderson-Wolfe', 'Anderson-Wolfe Grupo');
INSERT INTO public.empresa VALUES (948, 'Barros Carvalho S/A', 'Barros Carvalho S/A Comércio');
INSERT INTO public.empresa VALUES (949, 'Gill PLC', 'Gill PLC Grupo');
INSERT INTO public.empresa VALUES (950, 'Schmidt-Johnson', 'Schmidt-Johnson Estilo');
INSERT INTO public.empresa VALUES (951, 'Mcknight-Johnston', 'Mcknight-Johnston Formação');
INSERT INTO public.empresa VALUES (952, 'Cassiano Gonçalves Ltda.', 'Cassiano Gonçalves Ltda. Obras');
INSERT INTO public.empresa VALUES (953, 'Caldeira S/A', 'Caldeira S/A Design');
INSERT INTO public.empresa VALUES (954, 'Schultz, Miles and Page', 'Schultz, Miles and Page Empreendimentos');
INSERT INTO public.empresa VALUES (955, 'Rodrigues Andrade e Filhos', 'Rodrigues Andrade e Filhos Engine');
INSERT INTO public.empresa VALUES (956, 'Glover, Glass and Cabrera', 'Glover, Glass and Cabrera Hub');
INSERT INTO public.empresa VALUES (957, 'Duncan, Stone and Rocha', 'Duncan, Stone and Rocha Atelier');
INSERT INTO public.empresa VALUES (958, 'Moss, Rodriguez and Bond', 'Moss, Rodriguez and Bond Imobiliária');
INSERT INTO public.empresa VALUES (959, 'Ramos e Filhos', 'Ramos e Filhos Labs');
INSERT INTO public.empresa VALUES (960, 'Myers-Sloan', 'Myers-Sloan Engine');
INSERT INTO public.empresa VALUES (961, 'Ferreira e Filhos', 'Ferreira e Filhos Distribuidora');
INSERT INTO public.empresa VALUES (962, 'Johnson-Greene', 'Johnson-Greene Eco');
INSERT INTO public.empresa VALUES (963, 'Callahan, Jones and Obrien', 'Callahan, Jones and Obrien Verde');
INSERT INTO public.empresa VALUES (964, 'da Luz - ME', 'da Luz - ME Consultoria');
INSERT INTO public.empresa VALUES (965, 'Hoover-Brown', 'Hoover-Brown Logística');
INSERT INTO public.empresa VALUES (966, 'Little Inc', 'Little Inc Imobiliária');
INSERT INTO public.empresa VALUES (967, 'Morales and Sons', 'Morales and Sons Boutique');
INSERT INTO public.empresa VALUES (968, 'Gonzales-Moore', 'Gonzales-Moore Co');
INSERT INTO public.empresa VALUES (969, 'Gutierrez and Sons', 'Gutierrez and Sons Ambiental');
INSERT INTO public.empresa VALUES (970, 'Cunningham, Nelson and Gay', 'Cunningham, Nelson and Gay Atelier');
INSERT INTO public.empresa VALUES (971, 'Lang and Sons', 'Lang and Sons Grupo');
INSERT INTO public.empresa VALUES (972, 'Marques da Cunha - ME', 'Marques da Cunha - ME Platform');
INSERT INTO public.empresa VALUES (973, 'Peixoto S.A.', 'Peixoto S.A. Verde');
INSERT INTO public.empresa VALUES (974, 'Fritz Inc', 'Fritz Inc Clinic');
INSERT INTO public.empresa VALUES (975, 'Silveira S/A', 'Silveira S/A Collective');
INSERT INTO public.empresa VALUES (976, 'Aparecida - ME', 'Aparecida - ME Solutions');
INSERT INTO public.empresa VALUES (977, 'Ferreira Fonseca e Filhos', 'Ferreira Fonseca e Filhos Next');
INSERT INTO public.empresa VALUES (978, 'Viana da Costa - ME', 'Viana da Costa - ME Hub');
INSERT INTO public.empresa VALUES (979, 'Fowler, Stuart and Ford', 'Fowler, Stuart and Ford Medical');
INSERT INTO public.empresa VALUES (980, 'Conrad, Bowers and Mckee', 'Conrad, Bowers and Mckee Eco');
INSERT INTO public.empresa VALUES (981, 'Cunha Cardoso S/A', 'Cunha Cardoso S/A Boutique');
INSERT INTO public.empresa VALUES (982, 'Valdez Group', 'Valdez Group Healthcare');
INSERT INTO public.empresa VALUES (983, 'Lee-Reed', 'Lee-Reed Global');
INSERT INTO public.empresa VALUES (984, 'Willis, Armstrong and Williams', 'Willis, Armstrong and Williams Delícias');
INSERT INTO public.empresa VALUES (985, 'Leão Teixeira - ME', 'Leão Teixeira - ME Estilo');
INSERT INTO public.empresa VALUES (986, 'da Conceição Costela - EI', 'da Conceição Costela - EI Delícias');
INSERT INTO public.empresa VALUES (987, 'Griffin, Faulkner and Williams', 'Griffin, Faulkner and Williams Formação');
INSERT INTO public.empresa VALUES (988, 'Camargo - EI', 'Camargo - EI Academia');
INSERT INTO public.empresa VALUES (989, 'Farias S.A.', 'Farias S.A. Varejo');
INSERT INTO public.empresa VALUES (990, 'Johnston, Boyd and Miller', 'Johnston, Boyd and Miller Obras');
INSERT INTO public.empresa VALUES (991, 'Avila Group', 'Avila Group Construções');
INSERT INTO public.empresa VALUES (992, 'Pacheco Garcia - EI', 'Pacheco Garcia - EI Atelier');
INSERT INTO public.empresa VALUES (993, 'Pastor Cunha Ltda.', 'Pastor Cunha Ltda. Educação');
INSERT INTO public.empresa VALUES (994, 'Cavalcante - EI', 'Cavalcante - EI Atelier');
INSERT INTO public.empresa VALUES (995, 'Anderson-Sweeney', 'Anderson-Sweeney Distribuidora');
INSERT INTO public.empresa VALUES (996, 'Machado - EI', 'Machado - EI Soluções');
INSERT INTO public.empresa VALUES (997, 'Lee-Schaefer', 'Lee-Schaefer Studio');
INSERT INTO public.empresa VALUES (998, 'Gomez-Thompson', 'Gomez-Thompson Digital');
INSERT INTO public.empresa VALUES (999, 'Romero PLC', 'Romero PLC Medical');
INSERT INTO public.empresa VALUES (1000, 'da Luz - EI', 'da Luz - EI Soluções');


--
-- TOC entry 5253 (class 0 OID 16498)
-- Dependencies: 239
-- Data for Name: empresa_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5255 (class 0 OID 16506)
-- Dependencies: 241
-- Data for Name: inscricao; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5257 (class 0 OID 16516)
-- Dependencies: 243
-- Data for Name: mecanismo_plat; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5262 (class 0 OID 16533)
-- Dependencies: 248
-- Data for Name: nivel_canal; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5264 (class 0 OID 16546)
-- Dependencies: 250
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pais VALUES (254, 'Kenya', 'KES');
INSERT INTO public.pais VALUES (249, 'Sudan', 'SDG');
INSERT INTO public.pais VALUES (853, 'Macau', 'MOP');
INSERT INTO public.pais VALUES (92, 'Pakistan', 'PKR');
INSERT INTO public.pais VALUES (850, 'North Korea', 'KPW');
INSERT INTO public.pais VALUES (90, 'Turkey', 'TRY');
INSERT INTO public.pais VALUES (992, 'Tajikistan', 'TJS');
INSERT INTO public.pais VALUES (592, 'Guyana', 'GYD');
INSERT INTO public.pais VALUES (977, 'Nepal', 'NPR');
INSERT INTO public.pais VALUES (686, 'Kiribati', 'AUD');
INSERT INTO public.pais VALUES (420, 'Czechia', 'CZK');
INSERT INTO public.pais VALUES (389, 'North Macedonia', 'MKD');
INSERT INTO public.pais VALUES (673, 'Brunei', 'BND');
INSERT INTO public.pais VALUES (1246, 'Barbados', 'BBD');
INSERT INTO public.pais VALUES (269, 'Comoros', 'KMF');
INSERT INTO public.pais VALUES (972, 'Israel', 'ILS');
INSERT INTO public.pais VALUES (45, 'Denmark', 'DKK');
INSERT INTO public.pais VALUES (51, 'Peru', 'PEN');
INSERT INTO public.pais VALUES (350, 'Gibraltar', 'GIP');
INSERT INTO public.pais VALUES (1809, 'Dominican Republic', 'DOP');
INSERT INTO public.pais VALUES (504, 'Honduras', 'HNL');
INSERT INTO public.pais VALUES (253, 'Djibouti', 'DJF');
INSERT INTO public.pais VALUES (354, 'Iceland', 'ISK');
INSERT INTO public.pais VALUES (968, 'Oman', 'OMR');
INSERT INTO public.pais VALUES (993, 'Turkmenistan', 'TMT');
INSERT INTO public.pais VALUES (48, 'Poland', 'PLN');
INSERT INTO public.pais VALUES (54, 'Argentina', 'ARS');
INSERT INTO public.pais VALUES (381, 'Serbia', 'RSD');
INSERT INTO public.pais VALUES (52, 'Mexico', 'MXN');
INSERT INTO public.pais VALUES (1242, 'Bahamas', 'BSD');
INSERT INTO public.pais VALUES (225, 'Ivory Coast', 'XOF');
INSERT INTO public.pais VALUES (95, 'Myanmar', 'MMK');
INSERT INTO public.pais VALUES (966, 'Saudi Arabia', 'SAR');
INSERT INTO public.pais VALUES (359, 'Bulgaria', 'BGN');
INSERT INTO public.pais VALUES (373, 'Moldova', 'MDL');
INSERT INTO public.pais VALUES (675, 'Papua New Guinea', 'PGK');
INSERT INTO public.pais VALUES (502, 'Guatemala', 'GTQ');
INSERT INTO public.pais VALUES (47, 'Norway', 'NOK');
INSERT INTO public.pais VALUES (86, 'China', 'CNY');
INSERT INTO public.pais VALUES (974, 'Qatar', 'QAR');
INSERT INTO public.pais VALUES (995, 'Georgia', 'GEL');
INSERT INTO public.pais VALUES (1758, 'Saint Lucia', 'XCD');
INSERT INTO public.pais VALUES (1345, 'Cayman Islands', 'KYD');
INSERT INTO public.pais VALUES (231, 'Liberia', 'LRD');
INSERT INTO public.pais VALUES (266, 'Lesotho', 'LSL');
INSERT INTO public.pais VALUES (599, 'Curaçao', 'ANG');
INSERT INTO public.pais VALUES (268, 'Eswatini', 'SZL');
INSERT INTO public.pais VALUES (505, 'Nicaragua', 'NIO');
INSERT INTO public.pais VALUES (290, 'Saint Helena, Ascension and Tristan da Cunha', 'GBP');
INSERT INTO public.pais VALUES (598, 'Uruguay', 'UYU');
INSERT INTO public.pais VALUES (1, 'Canada', 'CAD');
INSERT INTO public.pais VALUES (98, 'Iran', 'IRR');
INSERT INTO public.pais VALUES (2125288, 'Western Sahara', 'DZD');
INSERT INTO public.pais VALUES (681, 'Wallis and Futuna', 'XPF');
INSERT INTO public.pais VALUES (970, 'Palestine', 'EGP');
INSERT INTO public.pais VALUES (685, 'Samoa', 'WST');
INSERT INTO public.pais VALUES (248, 'Seychelles', 'SCR');
INSERT INTO public.pais VALUES (677, 'Solomon Islands', 'SBD');
INSERT INTO public.pais VALUES (971, 'United Arab Emirates', 'AED');
INSERT INTO public.pais VALUES (57, 'Colombia', 'COP');
INSERT INTO public.pais VALUES (961, 'Lebanon', 'LBP');
INSERT INTO public.pais VALUES (509, 'Haiti', 'HTG');
INSERT INTO public.pais VALUES (267, 'Botswana', 'BWP');
INSERT INTO public.pais VALUES (591, 'Bolivia', 'BOB');
INSERT INTO public.pais VALUES (967, 'Yemen', 'YER');
INSERT INTO public.pais VALUES (960, 'Maldives', 'MVR');
INSERT INTO public.pais VALUES (256, 'Uganda', 'UGX');
INSERT INTO public.pais VALUES (374, 'Armenia', 'AMD');
INSERT INTO public.pais VALUES (973, 'Bahrain', 'BHD');
INSERT INTO public.pais VALUES (251, 'Ethiopia', 'ETB');
INSERT INTO public.pais VALUES (500, 'Falkland Islands', 'FKP');
INSERT INTO public.pais VALUES (76, 'Kazakhstan', 'KZT');
INSERT INTO public.pais VALUES (234, 'Nigeria', 'NGN');
INSERT INTO public.pais VALUES (965, 'Kuwait', 'KWD');
INSERT INTO public.pais VALUES (852, 'Hong Kong', 'HKD');
INSERT INTO public.pais VALUES (507, 'Panama', 'PAB');
INSERT INTO public.pais VALUES (218, 'Libya', 'LYD');
INSERT INTO public.pais VALUES (250, 'Rwanda', 'RWF');
INSERT INTO public.pais VALUES (856, 'Laos', 'LAK');
INSERT INTO public.pais VALUES (230, 'Mauritius', 'MUR');
INSERT INTO public.pais VALUES (297, 'Aruba', 'AWG');
INSERT INTO public.pais VALUES (257, 'Burundi', 'BIF');
INSERT INTO public.pais VALUES (244, 'Angola', 'AOA');
INSERT INTO public.pais VALUES (233, 'Ghana', 'GHS');
INSERT INTO public.pais VALUES (962, 'Jordan', 'JOD');
INSERT INTO public.pais VALUES (506, 'Costa Rica', 'CRC');
INSERT INTO public.pais VALUES (597, 'Suriname', 'SRD');
INSERT INTO public.pais VALUES (1876, 'Jamaica', 'JMD');
INSERT INTO public.pais VALUES (387, 'Bosnia and Herzegovina', 'BAM');
INSERT INTO public.pais VALUES (216, 'Tunisia', 'TND');
INSERT INTO public.pais VALUES (56, 'Chile', 'CLP');
INSERT INTO public.pais VALUES (40, 'Romania', 'RON');
INSERT INTO public.pais VALUES (423, 'Liechtenstein', 'CHF');
INSERT INTO public.pais VALUES (676, 'Tonga', 'TOP');
INSERT INTO public.pais VALUES (94, 'Sri Lanka', 'LKR');
INSERT INTO public.pais VALUES (60, 'Malaysia', 'MYR');
INSERT INTO public.pais VALUES (55, 'Brazil', 'BRL');
INSERT INTO public.pais VALUES (886, 'Taiwan', 'TWD');
INSERT INTO public.pais VALUES (265, 'Malawi', 'MWK');
INSERT INTO public.pais VALUES (82, 'South Korea', 'KRW');
INSERT INTO public.pais VALUES (255, 'Tanzania', 'TZS');
INSERT INTO public.pais VALUES (975, 'Bhutan', 'BTN');
INSERT INTO public.pais VALUES (62, 'Indonesia', 'IDR');
INSERT INTO public.pais VALUES (380, 'Ukraine', 'UAH');
INSERT INTO public.pais VALUES (264, 'Namibia', 'NAD');
INSERT INTO public.pais VALUES (291, 'Eritrea', 'ERN');
INSERT INTO public.pais VALUES (994, 'Azerbaijan', 'AZN');
INSERT INTO public.pais VALUES (964, 'Iraq', 'IQD');
INSERT INTO public.pais VALUES (93, 'Afghanistan', 'AFN');
INSERT INTO public.pais VALUES (27, 'South Africa', 'ZAR');
INSERT INTO public.pais VALUES (501, 'Belize', 'BZD');
INSERT INTO public.pais VALUES (1868, 'Trinidad and Tobago', 'TTD');
INSERT INTO public.pais VALUES (683, 'Niue', 'NZD');
INSERT INTO public.pais VALUES (65, 'Singapore', 'SGD');
INSERT INTO public.pais VALUES (998, 'Uzbekistan', 'UZS');
INSERT INTO public.pais VALUES (252, 'Somalia', 'SOS');
INSERT INTO public.pais VALUES (63, 'Philippines', 'PHP');
INSERT INTO public.pais VALUES (84, 'Vietnam', 'VND');
INSERT INTO public.pais VALUES (260, 'Zambia', 'ZMW');
INSERT INTO public.pais VALUES (678, 'Vanuatu', 'VUV');
INSERT INTO public.pais VALUES (595, 'Paraguay', 'PYG');
INSERT INTO public.pais VALUES (81, 'Japan', 'JPY');
INSERT INTO public.pais VALUES (963, 'Syria', 'SYP');
INSERT INTO public.pais VALUES (36, 'Hungary', 'HUF');
INSERT INTO public.pais VALUES (1441, 'Bermuda', 'BMD');
INSERT INTO public.pais VALUES (376, 'Andorra', 'EUR');
INSERT INTO public.pais VALUES (46, 'Sweden', 'SEK');
INSERT INTO public.pais VALUES (1787, 'Puerto Rico', 'USD');
INSERT INTO public.pais VALUES (224, 'Guinea', 'GNF');
INSERT INTO public.pais VALUES (238, 'Cape Verde', 'CVE');


--
-- TOC entry 5265 (class 0 OID 16554)
-- Dependencies: 251
-- Data for Name: participa; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5267 (class 0 OID 16565)
-- Dependencies: 253
-- Data for Name: patrocinio; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5270 (class 0 OID 16577)
-- Dependencies: 256
-- Data for Name: paypal; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5274 (class 0 OID 16593)
-- Dependencies: 260
-- Data for Name: plataforma; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.plataforma VALUES (1, 'Daniel, Sanchez and Martin Schedule', 0, 170, 526, '2001-05-21');
INSERT INTO public.plataforma VALUES (2, 'Azevedo Ramos - EI Beat', 0, 607, 998, '2006-08-29');
INSERT INTO public.plataforma VALUES (3, 'Maddox Group Radio', 0, 723, 712, '2006-10-27');
INSERT INTO public.plataforma VALUES (4, 'Steele-Fowler Aqui', 0, 371, 495, '1992-03-16');
INSERT INTO public.plataforma VALUES (5, 'Stewart Ltd Library', 0, 26, 974, '2022-12-06');
INSERT INTO public.plataforma VALUES (6, 'Barros Borges S/A Agora+', 0, 610, 569, '2007-03-20');
INSERT INTO public.plataforma VALUES (7, 'Gutierrez Ltd Reels', 0, 21, 678, '2017-02-08');
INSERT INTO public.plataforma VALUES (8, 'Hester-Gonzales PlayLab', 0, 892, 172, '2007-09-26');
INSERT INTO public.plataforma VALUES (9, 'Fernandes - ME Equipe', 0, 58, 811, '2015-08-01');
INSERT INTO public.plataforma VALUES (10, 'Fogaça Sales S/A Stream', 0, 598, 344, '2003-06-19');
INSERT INTO public.plataforma VALUES (11, 'Pacheco S.A. Atlas', 0, 230, 985, '2022-04-01');
INSERT INTO public.plataforma VALUES (12, 'Cassiano Fogaça - ME Broadcast', 0, 973, 599, '1990-02-07');
INSERT INTO public.plataforma VALUES (13, 'Aparecida S/A PlayLab', 0, 927, 931, '2015-12-12');
INSERT INTO public.plataforma VALUES (14, 'Vasconcelos Caldeira Ltda. Playground', 0, 115, 657, '2025-10-10');
INSERT INTO public.plataforma VALUES (15, 'Davis LLC Direct', 0, 89, 977, '2021-04-27');
INSERT INTO public.plataforma VALUES (16, 'Maldonado, Jones and Brown Collection', 0, 823, 699, '2001-09-24');
INSERT INTO public.plataforma VALUES (17, 'Porto - ME Hub', 0, 733, 803, '1994-09-21');
INSERT INTO public.plataforma VALUES (18, 'Valdez-Fitzgerald CastTV', 0, 228, 904, '1997-03-08');
INSERT INTO public.plataforma VALUES (19, 'Silveira Pires S.A. Fluxo', 0, 812, 143, '2023-10-28');
INSERT INTO public.plataforma VALUES (20, 'Horn-Mccarthy LoopTV', 0, 90, 192, '2000-05-01');
INSERT INTO public.plataforma VALUES (21, 'Cardoso e Filhos Channel', 0, 504, 443, '2002-01-11');
INSERT INTO public.plataforma VALUES (22, 'Araújo Rezende e Filhos Portal', 0, 190, 79, '2025-09-02');
INSERT INTO public.plataforma VALUES (23, 'Montenegro S/A Sync', 0, 636, 269, '2015-01-17');
INSERT INTO public.plataforma VALUES (24, 'da Mota Novais - ME Portal', 0, 49, 991, '1993-12-16');
INSERT INTO public.plataforma VALUES (25, 'Barros Sampaio e Filhos Universal', 0, 277, 538, '2002-11-25');
INSERT INTO public.plataforma VALUES (26, 'Lynch, Gonzales and Foster Palco', 0, 51, 143, '2000-12-13');
INSERT INTO public.plataforma VALUES (27, 'Vargas Cunha - ME Cast', 0, 731, 870, '2023-06-01');
INSERT INTO public.plataforma VALUES (28, 'Nogueira Araújo - EI LiveStream', 0, 848, 550, '2016-02-08');
INSERT INTO public.plataforma VALUES (29, 'Johnson PLC LoopTV', 0, 424, 221, '2024-08-05');
INSERT INTO public.plataforma VALUES (30, 'Steele, Espinoza and Adams Flix', 0, 764, 837, '2015-11-28');
INSERT INTO public.plataforma VALUES (31, 'Peixoto Gonçalves Ltda. Broadcast', 0, 59, 69, '1990-11-23');
INSERT INTO public.plataforma VALUES (32, 'Cross Ltd Network', 0, 317, 862, '1998-07-21');
INSERT INTO public.plataforma VALUES (33, 'Cardoso Leão - EI Plataforma', 0, 908, 579, '2022-10-24');
INSERT INTO public.plataforma VALUES (34, 'Silva e Filhos Ponto', 0, 858, 369, '2020-10-26');
INSERT INTO public.plataforma VALUES (35, 'Jones and Sons Verse', 0, 78, 887, '2011-08-05');
INSERT INTO public.plataforma VALUES (36, 'Novais Abreu - ME Pod', 0, 391, 526, '2013-11-07');
INSERT INTO public.plataforma VALUES (37, 'Palmer-Gates Connect+', 0, 753, 614, '2012-10-31');
INSERT INTO public.plataforma VALUES (38, 'Mora, Taylor and Brown Arquivo', 0, 184, 372, '1996-09-14');
INSERT INTO public.plataforma VALUES (39, 'Taylor, Cook and Martinez Transmit', 0, 964, 808, '2019-10-24');
INSERT INTO public.plataforma VALUES (40, 'Pires Machado e Filhos Pod', 0, 206, 842, '2003-02-14');
INSERT INTO public.plataforma VALUES (41, 'Nascimento Nogueira Ltda. Future', 0, 198, 273, '2016-10-08');
INSERT INTO public.plataforma VALUES (42, 'Carvalho - ME Collective', 0, 416, 265, '2020-02-28');
INSERT INTO public.plataforma VALUES (43, 'Martins Correia - EI Spot', 0, 321, 508, '2021-05-12');
INSERT INTO public.plataforma VALUES (44, 'Rocha Santos Ltda. Cine', 0, 647, 298, '2013-09-25');
INSERT INTO public.plataforma VALUES (45, 'Cannon Ltd Metaverse', 0, 231, 834, '2011-10-27');
INSERT INTO public.plataforma VALUES (46, 'Borges Dias - ME Lineup', 0, 824, 445, '2005-12-07');
INSERT INTO public.plataforma VALUES (47, 'Fisher Group Gate', 0, 202, 106, '2001-11-07');
INSERT INTO public.plataforma VALUES (48, 'Collins, Palmer and Ford Hub', 0, 255, 466, '1993-09-12');
INSERT INTO public.plataforma VALUES (49, 'Jones-Santana Reel', 0, 587, 271, '2023-01-29');
INSERT INTO public.plataforma VALUES (50, 'Hughes-Petersen Mais', 0, 577, 928, '2007-11-06');
INSERT INTO public.plataforma VALUES (51, 'Rocha - EI Now', 0, 968, 278, '2004-01-10');
INSERT INTO public.plataforma VALUES (52, 'Jackson, Lopez and Valdez Vibe', 0, 426, 100, '1990-07-19');
INSERT INTO public.plataforma VALUES (53, 'Câmara da Cunha Ltda. Go', 0, 828, 783, '2018-07-28');
INSERT INTO public.plataforma VALUES (54, 'Adams and Sons Air', 0, 590, 541, '2015-02-16');
INSERT INTO public.plataforma VALUES (55, 'Porto - EI Groove', 0, 79, 350, '2007-05-18');
INSERT INTO public.plataforma VALUES (56, 'Perry-Jones Live', 0, 733, 218, '2019-12-18');
INSERT INTO public.plataforma VALUES (57, 'Cardoso S.A. Originals', 0, 406, 598, '1998-08-18');
INSERT INTO public.plataforma VALUES (58, 'da Rocha S.A. Sync', 0, 318, 226, '2007-02-19');
INSERT INTO public.plataforma VALUES (59, 'Gray-Ryan Station', 0, 7, 289, '2004-06-02');
INSERT INTO public.plataforma VALUES (60, 'Lewis-Hall Mais', 0, 933, 10, '2010-12-04');
INSERT INTO public.plataforma VALUES (61, 'Robinson LLC HoraNobre', 0, 220, 121, '2010-12-22');
INSERT INTO public.plataforma VALUES (62, 'Rocha e Filhos Lineup', 0, 927, 513, '2000-01-01');
INSERT INTO public.plataforma VALUES (63, 'Almeida e Filhos Universal', 0, 566, 135, '1998-10-22');
INSERT INTO public.plataforma VALUES (64, 'Lynch Inc Pocket', 0, 456, 610, '2024-07-07');
INSERT INTO public.plataforma VALUES (65, 'Carvalho S.A. Stage', 0, 217, 530, '2023-09-04');
INSERT INTO public.plataforma VALUES (66, 'Fogaça - EI HoraNobre', 0, 287, 713, '2020-10-13');
INSERT INTO public.plataforma VALUES (67, 'Hebert and Sons Direct', 0, 129, 534, '1992-12-27');
INSERT INTO public.plataforma VALUES (68, 'Oliver-Johnson Play', 0, 883, 32, '2002-11-29');
INSERT INTO public.plataforma VALUES (69, 'Lewis Ltd Hub', 0, 522, 861, '2007-09-19');
INSERT INTO public.plataforma VALUES (70, 'Gomes Macedo S/A Playground', 0, 485, 304, '2020-02-03');
INSERT INTO public.plataforma VALUES (71, 'Barry-Sampson Access+', 0, 550, 918, '2022-07-02');
INSERT INTO public.plataforma VALUES (72, 'Moreira Ltda. Universe', 0, 313, 569, '2012-05-17');
INSERT INTO public.plataforma VALUES (73, 'Wheeler PLC Cine', 0, 755, 964, '2009-08-30');
INSERT INTO public.plataforma VALUES (74, 'Lopes S.A. Exclusive', 0, 198, 464, '2024-05-11');
INSERT INTO public.plataforma VALUES (75, 'Lopes S/A LiveStream', 0, 499, 979, '2009-12-26');
INSERT INTO public.plataforma VALUES (76, 'Machado Garcia - ME Lite', 0, 392, 470, '2003-07-26');
INSERT INTO public.plataforma VALUES (77, 'Garcia LLC Groove', 0, 562, 688, '2013-11-04');
INSERT INTO public.plataforma VALUES (78, 'Cavalcanti Nogueira S.A. Portal', 0, 726, 182, '2008-05-26');
INSERT INTO public.plataforma VALUES (79, 'Teixeira Nascimento S/A Transmit', 0, 691, 331, '1997-03-14');
INSERT INTO public.plataforma VALUES (80, 'Freitas Ltda. Stream', 0, 272, 191, '2016-07-31');
INSERT INTO public.plataforma VALUES (81, 'Thompson Inc Highlights', 0, 724, 877, '1995-07-14');
INSERT INTO public.plataforma VALUES (82, 'Wall-Harris Wave', 0, 721, 375, '1997-12-23');
INSERT INTO public.plataforma VALUES (83, 'Montenegro Camargo Ltda. Canal', 0, 344, 929, '2006-02-17');
INSERT INTO public.plataforma VALUES (84, 'Hoffman, Meyer and Johnson Premium', 0, 827, 795, '2005-03-10');
INSERT INTO public.plataforma VALUES (85, 'Pimenta Moura e Filhos Verse', 0, 25, 176, '2012-02-24');
INSERT INTO public.plataforma VALUES (86, 'Ho, Ross and Brown Replay', 0, 947, 143, '2020-12-13');
INSERT INTO public.plataforma VALUES (87, 'Fonseca Pimenta - EI Future', 0, 993, 652, '2021-03-27');
INSERT INTO public.plataforma VALUES (88, 'Elliott, Kirby and Reynolds Spot', 0, 623, 179, '1999-10-02');
INSERT INTO public.plataforma VALUES (89, 'Sousa Correia - ME Plataforma', 0, 194, 605, '2011-11-25');
INSERT INTO public.plataforma VALUES (90, 'Vargas S/A Portal', 0, 708, 900, '2017-04-16');
INSERT INTO public.plataforma VALUES (91, 'Hayden Inc Originais', 0, 84, 872, '2019-03-09');
INSERT INTO public.plataforma VALUES (92, 'Roberts-Gray Streamline', 0, 176, 112, '1994-05-22');
INSERT INTO public.plataforma VALUES (93, 'Rice-Banks Realm', 0, 489, 460, '2016-03-18');
INSERT INTO public.plataforma VALUES (94, 'Lewis-Allen Prime', 0, 778, 759, '2004-04-30');
INSERT INTO public.plataforma VALUES (95, 'Blair, Gomez and Richardson Palco', 0, 723, 13, '2025-05-31');
INSERT INTO public.plataforma VALUES (96, 'Owens, Rojas and Mckinney Flix', 0, 184, 751, '2025-05-24');
INSERT INTO public.plataforma VALUES (97, 'Allen Ltd Shows', 0, 783, 651, '2021-10-17');
INSERT INTO public.plataforma VALUES (98, 'Hodges, Underwood and Long Network', 0, 817, 445, '1997-09-09');
INSERT INTO public.plataforma VALUES (99, 'Câmara Pinto Ltda. Access+', 0, 851, 862, '2000-06-03');
INSERT INTO public.plataforma VALUES (100, 'da Mota Ltda. Future', 0, 41, 683, '2016-09-01');
INSERT INTO public.plataforma VALUES (101, 'Vieira - EI Wave', 0, 929, 662, '2007-03-02');
INSERT INTO public.plataforma VALUES (102, 'Porto e Filhos Pocket', 0, 462, 674, '2001-05-21');
INSERT INTO public.plataforma VALUES (103, 'Garcia Ribeiro S.A. Stage', 0, 645, 458, '2015-09-11');
INSERT INTO public.plataforma VALUES (104, 'Pimenta Correia S.A. Pod', 0, 634, 239, '2005-01-02');
INSERT INTO public.plataforma VALUES (105, 'Robertson, Jackson and Garcia Equipe', 0, 27, 746, '2025-08-07');
INSERT INTO public.plataforma VALUES (106, 'Taylor-Morris Collective', 0, 155, 703, '2001-09-24');
INSERT INTO public.plataforma VALUES (107, 'Reeves, Nguyen and Douglas Realm', 0, 615, 267, '2017-08-26');
INSERT INTO public.plataforma VALUES (108, 'Guerra, Adams and Giles Plus', 0, 418, 899, '2004-09-19');
INSERT INTO public.plataforma VALUES (109, 'Peixoto - EI Onda', 0, 779, 126, '2017-06-06');
INSERT INTO public.plataforma VALUES (110, 'Machado Fonseca S/A Cinema', 0, 14, 748, '1990-03-12');
INSERT INTO public.plataforma VALUES (111, 'Cardenas PLC Play', 0, 614, 744, '2022-04-17');
INSERT INTO public.plataforma VALUES (112, 'Mendes - ME PrimeTime', 0, 250, 584, '2021-04-18');
INSERT INTO public.plataforma VALUES (113, 'Chan, Brown and Sullivan Mapa', 0, 694, 1, '2014-02-19');
INSERT INTO public.plataforma VALUES (114, 'Wright, Ortiz and Sims Premium', 0, 461, 692, '2007-12-25');
INSERT INTO public.plataforma VALUES (115, 'Alves Ferreira S/A Go', 0, 882, 40, '2014-02-09');
INSERT INTO public.plataforma VALUES (116, 'Barbosa - EI Lite', 0, 859, 516, '2025-08-11');
INSERT INTO public.plataforma VALUES (117, 'Garcia Ltda. Library', 0, 829, 149, '2016-03-29');
INSERT INTO public.plataforma VALUES (118, 'Baker-Snyder Showcase', 0, 350, 313, '2015-12-18');
INSERT INTO public.plataforma VALUES (119, 'Rodriguez Inc Live', 0, 696, 22, '2016-05-07');
INSERT INTO public.plataforma VALUES (120, 'Hernandez and Sons Pod', 0, 901, 87, '2020-01-31');
INSERT INTO public.plataforma VALUES (121, 'Moraes Guerra e Filhos Crew', 0, 273, 61, '2005-09-22');
INSERT INTO public.plataforma VALUES (122, 'Ramos Cassiano S/A Mapa', 0, 945, 584, '1993-07-04');
INSERT INTO public.plataforma VALUES (123, 'Meyer-Dunn Lineup', 0, 343, 305, '2011-09-20');
INSERT INTO public.plataforma VALUES (124, 'Lima - ME Edge', 0, 219, 243, '2021-07-07');
INSERT INTO public.plataforma VALUES (125, 'Wells, Parker and Carroll Ir', 0, 645, 70, '2006-12-05');
INSERT INTO public.plataforma VALUES (126, 'Cassiano Siqueira S.A. Future', 0, 56, 651, '2017-08-09');
INSERT INTO public.plataforma VALUES (127, 'Le, Gordon and Gallegos Originals', 0, 716, 871, '1991-10-20');
INSERT INTO public.plataforma VALUES (128, 'Rodgers, Brown and Robles Pro', 0, 787, 158, '2006-06-23');
INSERT INTO public.plataforma VALUES (129, 'Monteiro - EI Originals', 0, 462, 944, '2025-06-10');
INSERT INTO public.plataforma VALUES (130, 'da Mota - EI Flix', 0, 795, 498, '2009-06-06');
INSERT INTO public.plataforma VALUES (131, 'Hawkins-Cox Originais', 0, 44, 188, '2007-06-25');
INSERT INTO public.plataforma VALUES (132, 'Freitas Pereira S.A. Radio', 0, 758, 781, '2013-01-29');
INSERT INTO public.plataforma VALUES (133, 'Estes LLC Next', 0, 885, 374, '1999-08-11');
INSERT INTO public.plataforma VALUES (134, 'Castillo, Carpenter and Lee Gate', 0, 142, 252, '2009-11-25');
INSERT INTO public.plataforma VALUES (135, 'Viana Borges - EI Now+', 0, 472, 836, '2008-06-27');
INSERT INTO public.plataforma VALUES (136, 'Mendonça Vieira S.A. Highlights', 0, 942, 179, '1998-08-05');
INSERT INTO public.plataforma VALUES (137, 'Obrien-Alvarado Shows', 0, 287, 437, '2021-05-08');
INSERT INTO public.plataforma VALUES (138, 'Ramirez, Delgado and Carter Vault', 0, 372, 933, '1995-12-28');
INSERT INTO public.plataforma VALUES (139, 'Lozano, Velazquez and Davis Flix', 0, 199, 894, '2015-10-08');
INSERT INTO public.plataforma VALUES (140, 'Higgins-Hill Mapa', 0, 222, 406, '2004-01-19');
INSERT INTO public.plataforma VALUES (141, 'da Costa Gomes - EI Shows', 0, 258, 237, '2011-07-24');
INSERT INTO public.plataforma VALUES (142, 'Johnston-Gilbert Metaverse', 0, 225, 73, '2020-03-31');
INSERT INTO public.plataforma VALUES (143, 'Woods-Green LoopTV', 0, 727, 396, '2009-02-21');
INSERT INTO public.plataforma VALUES (144, 'Lima Sales e Filhos Now+', 0, 915, 555, '2019-01-24');
INSERT INTO public.plataforma VALUES (145, 'Meyer Ltd LoopTV', 0, 893, 695, '2005-02-15');
INSERT INTO public.plataforma VALUES (146, 'Pastor Rocha - EI Network', 0, 281, 161, '1991-08-25');
INSERT INTO public.plataforma VALUES (147, 'Roberts, Stewart and Perez Hub', 0, 127, 215, '1998-11-17');
INSERT INTO public.plataforma VALUES (148, 'Almeida Caldeira - EI Mapa', 0, 271, 360, '2008-05-16');
INSERT INTO public.plataforma VALUES (149, 'Russell, Hicks and Lam AoVivo', 0, 182, 380, '1998-05-23');
INSERT INTO public.plataforma VALUES (150, 'Phillips-Shepherd Connect+', 0, 197, 800, '1997-05-14');
INSERT INTO public.plataforma VALUES (151, 'Almeida Melo Ltda. Arquivo', 0, 957, 868, '1999-02-04');
INSERT INTO public.plataforma VALUES (152, 'Foster-Chung Ritmo', 0, 330, 8, '2007-02-10');
INSERT INTO public.plataforma VALUES (153, 'Campos S/A Premium', 0, 147, 582, '2013-04-08');
INSERT INTO public.plataforma VALUES (154, 'Câmara Novaes e Filhos Box', 0, 699, 910, '2003-09-09');
INSERT INTO public.plataforma VALUES (155, 'Hayes-Raymond Edge', 0, 196, 538, '1991-07-25');
INSERT INTO public.plataforma VALUES (156, 'Chen-Allen Wave', 0, 516, 492, '2020-05-13');
INSERT INTO public.plataforma VALUES (157, 'Albuquerque Souza e Filhos AoVivo', 0, 440, 520, '2018-12-16');
INSERT INTO public.plataforma VALUES (158, 'Lambert, Kelly and Burke Exclusivo', 0, 594, 609, '2016-03-27');
INSERT INTO public.plataforma VALUES (159, 'Richardson-King OnRepeat', 0, 717, 827, '2021-11-01');
INSERT INTO public.plataforma VALUES (160, 'Lopes Ltda. LoopTV', 0, 484, 720, '2023-01-14');
INSERT INTO public.plataforma VALUES (161, 'Almeida - ME Transmit', 0, 997, 896, '1994-07-19');
INSERT INTO public.plataforma VALUES (162, 'Walls, Brown and Fowler Cine', 0, 278, 443, '2021-12-05');
INSERT INTO public.plataforma VALUES (163, 'Ribeiro Cavalcanti - ME Queue', 0, 469, 845, '1994-12-18');
INSERT INTO public.plataforma VALUES (164, 'Wyatt-Keller Ritmo', 0, 940, 475, '2022-04-17');
INSERT INTO public.plataforma VALUES (165, 'Garcia Farias e Filhos Studio', 0, 14, 871, '2017-10-09');
INSERT INTO public.plataforma VALUES (166, 'Lucas, Young and Davis Hub', 0, 586, 70, '1992-04-25');
INSERT INTO public.plataforma VALUES (167, 'Murray Inc Portal', 0, 913, 248, '2023-11-06');
INSERT INTO public.plataforma VALUES (168, 'Borges - ME Pocket', 0, 903, 34, '1990-08-25');
INSERT INTO public.plataforma VALUES (169, 'Macedo da Paz S.A. AoVivo', 0, 579, 248, '2013-05-22');
INSERT INTO public.plataforma VALUES (170, 'Alves - ME Metaverse', 0, 60, 290, '1999-05-06');
INSERT INTO public.plataforma VALUES (171, 'Pearson, Smith and Martin Sync', 0, 495, 572, '2000-11-01');
INSERT INTO public.plataforma VALUES (172, 'Goodman PLC Live+', 0, 274, 251, '1994-02-23');
INSERT INTO public.plataforma VALUES (173, 'Moura Guerra S.A. Station', 0, 223, 982, '2004-02-01');
INSERT INTO public.plataforma VALUES (174, 'Sales S/A Live+', 0, 82, 82, '2015-06-12');
INSERT INTO public.plataforma VALUES (175, 'Mcintyre, Benjamin and Hodge Loop', 0, 705, 640, '1997-04-13');
INSERT INTO public.plataforma VALUES (176, 'Cunha Marques S/A Live+', 0, 224, 248, '2014-02-21');
INSERT INTO public.plataforma VALUES (177, 'Silveira Silva - ME CastTV', 0, 937, 519, '1993-06-27');
INSERT INTO public.plataforma VALUES (178, 'Rios Vargas S.A. Air', 0, 149, 441, '2025-08-04');
INSERT INTO public.plataforma VALUES (179, 'Martinez, Walker and Hall Station', 0, 19, 492, '2009-07-06');
INSERT INTO public.plataforma VALUES (180, 'Walters, Thompson and Martinez Flix', 0, 90, 897, '2001-06-27');
INSERT INTO public.plataforma VALUES (181, 'Teixeira S.A. Connect+', 0, 643, 698, '2013-02-13');
INSERT INTO public.plataforma VALUES (182, 'Hendrix Group Ir', 0, 115, 327, '1993-09-02');
INSERT INTO public.plataforma VALUES (183, 'Price-Williams Collective', 0, 219, 191, '2015-08-06');
INSERT INTO public.plataforma VALUES (184, 'Fernandes S/A Select', 0, 691, 933, '2014-06-07');
INSERT INTO public.plataforma VALUES (185, 'Beck-Sullivan Plus', 0, 255, 8, '1992-04-19');
INSERT INTO public.plataforma VALUES (186, 'Vaughan and Sons Transmit', 0, 574, 723, '2000-12-25');
INSERT INTO public.plataforma VALUES (187, 'Cirino - ME Ritmo', 0, 291, 868, '2002-03-28');
INSERT INTO public.plataforma VALUES (188, 'Jesus - ME Direct', 0, 717, 782, '1999-12-28');
INSERT INTO public.plataforma VALUES (189, 'Aragão Pereira e Filhos Pro', 0, 73, 932, '1990-04-10');
INSERT INTO public.plataforma VALUES (190, 'Medina, Shelton and Martinez Highlights', 0, 168, 236, '1992-02-10');
INSERT INTO public.plataforma VALUES (191, 'Fowler, Sanchez and Hood Verse', 0, 249, 257, '2018-09-09');
INSERT INTO public.plataforma VALUES (192, 'Sá Correia - EI Go', 0, 345, 5, '1994-10-24');
INSERT INTO public.plataforma VALUES (193, 'Gallegos-Herman Worlds', 0, 191, 485, '1993-03-22');
INSERT INTO public.plataforma VALUES (194, 'Rocha Cunha - EI Go', 0, 33, 691, '2016-02-10');
INSERT INTO public.plataforma VALUES (195, 'Borges Siqueira Ltda. Transmit', 0, 483, 235, '2004-03-07');
INSERT INTO public.plataforma VALUES (196, 'Tucker LLC Universo', 0, 414, 5, '2020-05-28');
INSERT INTO public.plataforma VALUES (197, 'Vargas da Costa e Filhos Streamline', 0, 547, 932, '1996-02-02');
INSERT INTO public.plataforma VALUES (198, 'Robinson and Sons LoopTV', 0, 420, 412, '2016-07-12');
INSERT INTO public.plataforma VALUES (199, 'Carter, Smith and Watts Universal', 0, 224, 708, '2013-01-08');
INSERT INTO public.plataforma VALUES (200, 'Mendez-Valencia Vault', 0, 686, 916, '2008-05-26');
INSERT INTO public.plataforma VALUES (201, 'Hooper, Calderon and Moody Flow', 0, 123, 956, '2000-08-01');
INSERT INTO public.plataforma VALUES (202, 'Pinto Pinto S.A. Direct', 0, 427, 750, '1990-12-25');
INSERT INTO public.plataforma VALUES (203, 'Cavalcanti Oliveira S/A Fluxo', 0, 920, 459, '2005-08-17');
INSERT INTO public.plataforma VALUES (204, 'Hester Inc Mini', 0, 956, 535, '2024-10-24');
INSERT INTO public.plataforma VALUES (205, 'Melo Novais - EI Beat', 0, 622, 955, '1996-08-13');
INSERT INTO public.plataforma VALUES (206, 'Nguyen, Jensen and Blake Cast', 0, 709, 322, '2023-02-15');
INSERT INTO public.plataforma VALUES (207, 'Rose-Gillespie Ir', 0, 759, 774, '2004-11-03');
INSERT INTO public.plataforma VALUES (208, 'Vaughn, Thompson and Thomas Exclusivo', 0, 464, 129, '2006-10-24');
INSERT INTO public.plataforma VALUES (209, 'da Mata da Conceição - ME Live', 0, 393, 750, '1998-05-04');
INSERT INTO public.plataforma VALUES (210, 'Cavalcante Souza S/A Vibe', 0, 780, 569, '1999-05-16');
INSERT INTO public.plataforma VALUES (211, 'Abreu S.A. Schedule', 0, 900, 576, '2001-09-02');
INSERT INTO public.plataforma VALUES (212, 'Barbosa e Filhos Universe', 0, 27, 113, '2013-06-06');
INSERT INTO public.plataforma VALUES (213, 'Fonseca da Mata Ltda. Spot', 0, 801, 346, '2018-06-23');
INSERT INTO public.plataforma VALUES (214, 'Campos, Johnston and Price Studio', 0, 748, 750, '2022-03-01');
INSERT INTO public.plataforma VALUES (215, 'Moreno-Liu Metaverse', 0, 923, 167, '2014-12-26');
INSERT INTO public.plataforma VALUES (216, 'Castro Farias S.A. Vibe', 0, 85, 823, '2015-10-27');
INSERT INTO public.plataforma VALUES (217, 'da Mota da Conceição Ltda. Future', 0, 787, 687, '1996-05-24');
INSERT INTO public.plataforma VALUES (218, 'da Conceição - EI Fila', 0, 625, 324, '1994-07-10');
INSERT INTO public.plataforma VALUES (219, 'Ferreira - EI Fila', 0, 63, 480, '2024-11-18');
INSERT INTO public.plataforma VALUES (220, 'Gregory-Byrd Entrada', 0, 201, 844, '2025-09-08');
INSERT INTO public.plataforma VALUES (221, 'Sampaio da Mota e Filhos Future', 0, 768, 95, '2017-09-18');
INSERT INTO public.plataforma VALUES (222, 'Correia Monteiro e Filhos Streamline', 0, 205, 723, '2015-08-31');
INSERT INTO public.plataforma VALUES (223, 'Câmara - ME Pod', 0, 232, 822, '2006-06-17');
INSERT INTO public.plataforma VALUES (224, 'Rezende Gonçalves - EI Playground', 0, 854, 751, '2012-03-10');
INSERT INTO public.plataforma VALUES (225, 'Santos - EI Fila', 0, 378, 41, '1998-12-13');
INSERT INTO public.plataforma VALUES (226, 'Mendes S/A Station', 0, 340, 518, '2019-10-23');
INSERT INTO public.plataforma VALUES (227, 'da Mota Azevedo - ME OnRepeat', 0, 460, 179, '2009-11-23');
INSERT INTO public.plataforma VALUES (228, 'Marks-Butler Studios', 0, 398, 158, '2018-05-09');
INSERT INTO public.plataforma VALUES (229, 'da Costa Fernandes - ME Select', 0, 664, 432, '2006-12-10');
INSERT INTO public.plataforma VALUES (230, 'Teixeira - EI Transmit', 0, 735, 134, '2015-10-19');
INSERT INTO public.plataforma VALUES (231, 'Graves-Clark LoopTV', 0, 745, 228, '2007-05-18');
INSERT INTO public.plataforma VALUES (232, 'Ferreira Gomes S/A Filmes', 0, 519, 78, '1999-05-16');
INSERT INTO public.plataforma VALUES (233, 'da Mata Costela S.A. Onda', 0, 978, 294, '2019-04-04');
INSERT INTO public.plataforma VALUES (234, 'Joseph-Olson Playground', 0, 330, 678, '2000-11-23');
INSERT INTO public.plataforma VALUES (235, 'Aparecida das Neves S/A Worlds', 0, 163, 410, '1990-10-05');
INSERT INTO public.plataforma VALUES (236, 'Dias da Mata S.A. Schedule', 0, 669, 272, '2015-11-10');
INSERT INTO public.plataforma VALUES (237, 'Lima e Filhos Collection', 0, 163, 400, '2025-07-09');
INSERT INTO public.plataforma VALUES (238, 'Nascimento Silveira - ME Scene', 0, 787, 541, '2006-01-26');
INSERT INTO public.plataforma VALUES (239, 'Werner PLC Canal', 0, 290, 164, '2000-05-31');
INSERT INTO public.plataforma VALUES (240, 'Eaton-Woods Reel', 0, 466, 294, '2002-11-10');
INSERT INTO public.plataforma VALUES (241, 'Machado e Filhos Fluxo', 0, 269, 766, '1999-09-21');
INSERT INTO public.plataforma VALUES (242, 'Jackson-Perry Direct', 0, 496, 224, '1991-11-11');
INSERT INTO public.plataforma VALUES (243, 'Nascimento Pereira - EI Box', 0, 100, 670, '2007-07-13');
INSERT INTO public.plataforma VALUES (244, 'Andrade Fogaça S/A Air', 0, 624, 804, '2022-04-06');
INSERT INTO public.plataforma VALUES (245, 'Camargo da Rosa - EI LiveStream', 0, 542, 544, '1993-01-06');
INSERT INTO public.plataforma VALUES (246, 'Moore-Wise Originais', 0, 524, 641, '1999-09-04');
INSERT INTO public.plataforma VALUES (247, 'Rios, Powell and Williamson PocketTV', 0, 615, 27, '2020-12-21');
INSERT INTO public.plataforma VALUES (248, 'Silva-Hurley Reels', 0, 379, 36, '1991-01-12');
INSERT INTO public.plataforma VALUES (249, 'Jones Inc Arquivo', 0, 381, 398, '1992-10-08');
INSERT INTO public.plataforma VALUES (250, 'Câmara e Filhos Library', 0, 353, 458, '2025-06-13');
INSERT INTO public.plataforma VALUES (251, 'Camargo da Mata e Filhos Spot', 0, 447, 24, '2009-04-29');
INSERT INTO public.plataforma VALUES (252, 'Oliveira S.A. Streamers', 0, 773, 590, '2015-06-06');
INSERT INTO public.plataforma VALUES (253, 'Pimenta S/A Pass', 0, 223, 784, '2014-07-12');
INSERT INTO public.plataforma VALUES (254, 'Huerta-Allen Filmes', 0, 697, 494, '1990-03-18');
INSERT INTO public.plataforma VALUES (255, 'da Paz da Mata - ME Mini', 0, 515, 380, '2004-08-27');
INSERT INTO public.plataforma VALUES (256, 'Azevedo Gonçalves S/A Radio', 0, 412, 309, '1995-05-25');
INSERT INTO public.plataforma VALUES (257, 'Pereira Moura S/A Ir', 0, 143, 618, '2002-04-17');
INSERT INTO public.plataforma VALUES (258, 'Campos - ME Shows', 0, 959, 781, '1994-02-21');
INSERT INTO public.plataforma VALUES (259, 'Moura Ltda. Loop', 0, 816, 322, '2002-10-20');
INSERT INTO public.plataforma VALUES (260, 'Lindsey, Lowe and Gray Plus', 0, 390, 637, '2020-05-28');
INSERT INTO public.plataforma VALUES (261, 'Gonçalves Sousa - ME Palco', 0, 891, 283, '2007-07-14');
INSERT INTO public.plataforma VALUES (262, 'Sellers-Ramirez Equipe', 0, 912, 202, '2000-05-09');
INSERT INTO public.plataforma VALUES (263, 'Gonçalves Moura Ltda. Flow', 0, 648, 858, '2016-07-17');
INSERT INTO public.plataforma VALUES (264, 'Pacheco Pimenta - ME Pocket', 0, 106, 448, '2009-09-01');
INSERT INTO public.plataforma VALUES (265, 'Gomez-Mann Plataforma', 0, 804, 706, '1995-08-20');
INSERT INTO public.plataforma VALUES (266, 'da Mota S.A. Cinema', 0, 776, 701, '1997-11-15');
INSERT INTO public.plataforma VALUES (267, 'Gonçalves da Rosa - ME Metaverse', 0, 529, 748, '1991-09-30');
INSERT INTO public.plataforma VALUES (268, 'Cavalcante Cavalcante e Filhos Exclusive', 0, 411, 923, '2022-09-25');
INSERT INTO public.plataforma VALUES (269, 'Valentine Group Plataforma', 0, 820, 253, '1996-12-09');
INSERT INTO public.plataforma VALUES (270, 'Gonçalves Ltda. Verse', 0, 466, 624, '1990-03-11');
INSERT INTO public.plataforma VALUES (271, 'Silveira Ramos - ME Box', 0, 572, 887, '1991-01-22');
INSERT INTO public.plataforma VALUES (272, 'Pires Rezende S.A. Queue', 0, 771, 222, '2011-02-25');
INSERT INTO public.plataforma VALUES (273, 'Abreu - ME Cinema', 0, 796, 274, '2016-12-23');
INSERT INTO public.plataforma VALUES (274, 'Rezende Garcia - ME Spot', 0, 576, 553, '2010-02-17');
INSERT INTO public.plataforma VALUES (275, 'Jimenez-Johnson Portal', 0, 993, 735, '2015-12-17');
INSERT INTO public.plataforma VALUES (276, 'Almeida Costela - EI Collective+', 0, 719, 998, '2010-09-07');
INSERT INTO public.plataforma VALUES (277, 'Lewis, Roth and Gonzalez Mapa', 0, 171, 498, '2018-07-02');
INSERT INTO public.plataforma VALUES (278, 'Baldwin-Conley Navigator', 0, 609, 994, '1994-12-03');
INSERT INTO public.plataforma VALUES (279, 'da Paz da Costa e Filhos Arquivo', 0, 985, 425, '2024-11-22');
INSERT INTO public.plataforma VALUES (280, 'Campbell-Patterson Portal', 0, 230, 1000, '2009-02-17');
INSERT INTO public.plataforma VALUES (281, 'Rocha Gonçalves S/A Sync', 0, 161, 248, '2015-07-03');
INSERT INTO public.plataforma VALUES (282, 'Howell, Garcia and Nelson Box', 0, 60, 949, '1991-09-13');
INSERT INTO public.plataforma VALUES (283, 'Wiley-Miller Gate', 0, 638, 33, '1991-02-06');
INSERT INTO public.plataforma VALUES (284, 'Peixoto Jesus S.A. HoraNobre', 0, 247, 184, '2008-10-03');
INSERT INTO public.plataforma VALUES (285, 'Pinto Ltda. Portal', 0, 219, 865, '2013-06-10');
INSERT INTO public.plataforma VALUES (286, 'Carey, Young and Garcia Spot', 0, 670, 535, '2007-10-09');
INSERT INTO public.plataforma VALUES (287, 'Siqueira S/A Canal', 0, 841, 202, '2015-12-18');
INSERT INTO public.plataforma VALUES (288, 'Espinoza PLC Stream', 0, 284, 164, '1990-05-05');
INSERT INTO public.plataforma VALUES (289, 'Hall, Martin and Cunningham Entrada', 0, 503, 74, '2020-01-02');
INSERT INTO public.plataforma VALUES (290, 'Souza da Paz S.A. Broadcast', 0, 681, 181, '1997-08-21');
INSERT INTO public.plataforma VALUES (291, 'Siqueira Moura S/A Wave', 0, 528, 63, '2018-08-23');
INSERT INTO public.plataforma VALUES (292, 'Archer, Hunter and Le Verse', 0, 770, 201, '2002-09-11');
INSERT INTO public.plataforma VALUES (293, 'Ramirez PLC Live+', 0, 645, 159, '2008-07-15');
INSERT INTO public.plataforma VALUES (294, 'Lopez, Hamilton and Carter Portal', 0, 612, 775, '2001-10-22');
INSERT INTO public.plataforma VALUES (295, 'Townsend, Woods and Evans LiveStream', 0, 296, 754, '2002-11-23');
INSERT INTO public.plataforma VALUES (296, 'Adams, Weaver and May Vibe', 0, 810, 131, '2014-08-08');
INSERT INTO public.plataforma VALUES (297, 'da Costa da Mota e Filhos Broadcast', 0, 510, 935, '2006-07-22');
INSERT INTO public.plataforma VALUES (298, 'Robinson, Ellis and Golden Cinema', 0, 761, 401, '2018-03-22');
INSERT INTO public.plataforma VALUES (299, 'Miller, Elliott and Russell Fila', 0, 194, 452, '2010-12-24');
INSERT INTO public.plataforma VALUES (300, 'da Cruz - EI Realm', 0, 288, 599, '1999-08-28');
INSERT INTO public.plataforma VALUES (301, 'Morrison, Combs and Franklin Ponto', 0, 739, 525, '2020-04-19');
INSERT INTO public.plataforma VALUES (302, 'Walker, Martinez and Hoffman Metaverse', 0, 493, 989, '2012-02-27');
INSERT INTO public.plataforma VALUES (303, 'Clark, Wells and Hernandez Streamline', 0, 291, 233, '2020-02-18');
INSERT INTO public.plataforma VALUES (304, 'Borges Farias - ME Playground', 0, 940, 183, '2015-11-15');
INSERT INTO public.plataforma VALUES (305, 'Siqueira Ramos S.A. Radio', 0, 730, 468, '2005-05-04');
INSERT INTO public.plataforma VALUES (306, 'Moura Martins S.A. Verse', 0, 741, 614, '1999-03-14');
INSERT INTO public.plataforma VALUES (307, 'Mitchell, Woods and Hayes Now', 0, 906, 41, '2020-07-09');
INSERT INTO public.plataforma VALUES (308, 'Abreu Ltda. Reel', 0, 723, 369, '1995-10-01');
INSERT INTO public.plataforma VALUES (309, 'Aguilar-Choi Agora+', 0, 806, 672, '2019-02-05');
INSERT INTO public.plataforma VALUES (310, 'Lewis-Howard Lineup', 0, 31, 669, '1993-07-12');
INSERT INTO public.plataforma VALUES (311, 'Pacheco Sá Ltda. OnRepeat', 0, 477, 825, '2007-01-17');
INSERT INTO public.plataforma VALUES (312, 'Martinez LLC Canal', 0, 214, 976, '1991-01-10');
INSERT INTO public.plataforma VALUES (313, 'Câmara S/A Realm', 0, 774, 652, '2006-12-29');
INSERT INTO public.plataforma VALUES (314, 'Osborne-Jimenez HoraNobre', 0, 80, 356, '2022-04-11');
INSERT INTO public.plataforma VALUES (315, 'Teixeira Ferreira Ltda. Connect', 0, 459, 643, '2008-08-01');
INSERT INTO public.plataforma VALUES (316, 'Ross LLC Now+', 0, 369, 165, '1990-01-04');
INSERT INTO public.plataforma VALUES (317, 'Williams, Hill and Leach Broadcast', 0, 706, 199, '2014-09-08');
INSERT INTO public.plataforma VALUES (318, 'Maldonado Group Pass', 0, 347, 190, '2014-03-13');
INSERT INTO public.plataforma VALUES (319, 'Watson, Moran and Hampton Crew', 0, 125, 822, '2015-09-04');
INSERT INTO public.plataforma VALUES (320, 'Ferreira Farias - EI Library', 0, 199, 707, '2003-03-12');
INSERT INTO public.plataforma VALUES (321, 'Duarte S.A. Worlds', 0, 608, 356, '2013-09-28');
INSERT INTO public.plataforma VALUES (322, 'Arroyo-Tucker Reel', 0, 153, 931, '2022-01-17');
INSERT INTO public.plataforma VALUES (323, 'Castillo, Hunt and Harvey Fila', 0, 585, 130, '2011-01-16');
INSERT INTO public.plataforma VALUES (324, 'Abbott and Sons Connect+', 0, 66, 603, '2020-01-03');
INSERT INTO public.plataforma VALUES (325, 'da Cunha S/A Collection', 0, 297, 179, '1997-03-13');
INSERT INTO public.plataforma VALUES (326, 'Novaes Brito Ltda. Playground', 0, 434, 490, '2012-05-25');
INSERT INTO public.plataforma VALUES (327, 'Moreira e Filhos Gate', 0, 430, 538, '2021-06-26');
INSERT INTO public.plataforma VALUES (328, 'Moore, Larson and Bryan LoopTV', 0, 215, 203, '2002-11-23');
INSERT INTO public.plataforma VALUES (329, 'Moore and Sons Portal', 0, 205, 940, '1997-06-24');
INSERT INTO public.plataforma VALUES (330, 'Walker, Alvarez and Rodriguez On', 0, 979, 363, '2010-01-03');
INSERT INTO public.plataforma VALUES (331, 'Gomez, Carroll and Anthony Scene', 0, 170, 658, '1993-04-17');
INSERT INTO public.plataforma VALUES (332, 'Alexander, Grant and Gross Collective', 0, 322, 157, '2004-04-28');
INSERT INTO public.plataforma VALUES (333, 'Austin-Wright Universo', 0, 773, 570, '2011-10-21');
INSERT INTO public.plataforma VALUES (334, 'Sá e Filhos Cinema', 0, 914, 897, '2020-04-17');
INSERT INTO public.plataforma VALUES (335, 'Booker Ltd Go', 0, 436, 811, '1994-02-21');
INSERT INTO public.plataforma VALUES (336, 'da Mata - ME Streamline', 0, 64, 441, '2000-04-14');
INSERT INTO public.plataforma VALUES (337, 'Hunt Group Portal', 0, 288, 694, '2005-09-15');
INSERT INTO public.plataforma VALUES (338, 'Russell-White Cast', 0, 655, 494, '2015-01-01');
INSERT INTO public.plataforma VALUES (339, 'Ryan, Mcdonald and Williams Replay', 0, 114, 809, '2003-01-02');
INSERT INTO public.plataforma VALUES (340, 'Bush, Morris and Johnson Navigator', 0, 943, 314, '2023-08-16');
INSERT INTO public.plataforma VALUES (341, 'Pereira Mendonça - ME Connect', 0, 156, 587, '1995-09-19');
INSERT INTO public.plataforma VALUES (342, 'Melo S.A. AoVivo', 0, 553, 289, '1991-01-12');
INSERT INTO public.plataforma VALUES (343, 'Watson-Keller Explorer', 0, 417, 889, '2014-08-25');
INSERT INTO public.plataforma VALUES (344, 'Albuquerque Pimenta - EI Connect', 0, 970, 111, '2015-07-08');
INSERT INTO public.plataforma VALUES (345, 'Moon Group Lite', 0, 807, 72, '2001-03-27');
INSERT INTO public.plataforma VALUES (346, 'Freitas Mendonça e Filhos Groove', 0, 71, 103, '2013-03-11');
INSERT INTO public.plataforma VALUES (347, 'Reid, Mason and Alexander Exclusivo', 0, 493, 775, '2024-07-10');
INSERT INTO public.plataforma VALUES (348, 'Jacobs, Moore and Johnson Studios', 0, 133, 785, '1994-10-09');
INSERT INTO public.plataforma VALUES (349, 'Mendes Sales - EI Lineup', 0, 352, 198, '2020-07-14');
INSERT INTO public.plataforma VALUES (350, 'Sanchez-Delgado Fila', 0, 951, 12, '1996-04-12');
INSERT INTO public.plataforma VALUES (351, 'Curry Group Pocket', 0, 169, 266, '1998-11-28');
INSERT INTO public.plataforma VALUES (352, 'Dunn, Galvan and Shea Metaverse', 0, 419, 836, '2019-01-31');
INSERT INTO public.plataforma VALUES (353, 'Contreras, Stein and Lewis Select', 0, 322, 497, '1993-03-09');
INSERT INTO public.plataforma VALUES (354, 'Harvey-Everett Agora+', 0, 277, 567, '2022-03-14');
INSERT INTO public.plataforma VALUES (355, 'Duarte Mendes S/A Navigator', 0, 517, 335, '1994-04-12');
INSERT INTO public.plataforma VALUES (356, 'Fernandes Moraes - EI Crew', 0, 628, 420, '2012-07-10');
INSERT INTO public.plataforma VALUES (357, 'Miller LLC Streamers', 0, 852, 557, '1993-05-19');
INSERT INTO public.plataforma VALUES (358, 'Andrade S.A. Collective', 0, 264, 753, '1998-10-11');
INSERT INTO public.plataforma VALUES (359, 'da Paz - ME Filmes', 0, 680, 779, '2015-09-20');
INSERT INTO public.plataforma VALUES (360, 'Moraes Ltda. Live+', 0, 138, 606, '2009-11-22');
INSERT INTO public.plataforma VALUES (361, 'West PLC Pocket', 0, 332, 430, '2024-06-14');
INSERT INTO public.plataforma VALUES (362, 'Glenn, Hawkins and Johnson Highlights', 0, 841, 820, '1993-10-23');
INSERT INTO public.plataforma VALUES (363, 'Ferreira S/A Canal', 0, 809, 644, '2017-05-15');
INSERT INTO public.plataforma VALUES (364, 'Moraes e Filhos OnRepeat', 0, 738, 355, '2020-02-04');
INSERT INTO public.plataforma VALUES (365, 'Lewis, Bailey and Burgess Originals', 0, 736, 227, '2020-04-15');
INSERT INTO public.plataforma VALUES (366, 'Erickson-Rice Atlas', 0, 303, 270, '2021-01-27');
INSERT INTO public.plataforma VALUES (367, 'Sampaio - ME Lineup', 0, 676, 596, '2008-06-07');
INSERT INTO public.plataforma VALUES (368, 'Mcpherson-Newton Select', 0, 407, 398, '2023-12-03');
INSERT INTO public.plataforma VALUES (369, 'Williams and Sons Stream', 0, 375, 405, '2004-10-28');
INSERT INTO public.plataforma VALUES (370, 'Roberts-Guerrero Stage', 0, 906, 521, '2017-03-11');
INSERT INTO public.plataforma VALUES (371, 'Castro Sousa Ltda. Library', 0, 549, 333, '2024-10-18');
INSERT INTO public.plataforma VALUES (372, 'Pires Siqueira S/A CastTV', 0, 659, 759, '2004-05-10');
INSERT INTO public.plataforma VALUES (373, 'Green-Wiley Aqui', 0, 30, 842, '1993-07-02');
INSERT INTO public.plataforma VALUES (374, 'Araújo Gomes e Filhos Explorer', 0, 295, 872, '2016-02-17');
INSERT INTO public.plataforma VALUES (375, 'Wood, Hall and Rowland Reel', 0, 104, 687, '2010-06-20');
INSERT INTO public.plataforma VALUES (376, 'Wood-Cook CinePlus', 0, 159, 516, '1999-03-02');
INSERT INTO public.plataforma VALUES (377, 'Lopes Brito - ME Streamline', 0, 227, 190, '2007-04-27');
INSERT INTO public.plataforma VALUES (378, 'Correia Jesus - ME Explorer', 0, 70, 786, '1996-11-17');
INSERT INTO public.plataforma VALUES (379, 'Grimes-Deleon Connect', 0, 169, 435, '2011-07-12');
INSERT INTO public.plataforma VALUES (380, 'Phillips Group Studio', 0, 451, 2, '2022-08-19');
INSERT INTO public.plataforma VALUES (381, 'Odom and Sons Navigator', 0, 226, 598, '1994-01-27');
INSERT INTO public.plataforma VALUES (382, 'Lynch-Rowland Hub', 0, 818, 302, '1995-05-03');
INSERT INTO public.plataforma VALUES (383, 'Hunt, Horne and Patel Station', 0, 597, 203, '2010-08-06');
INSERT INTO public.plataforma VALUES (384, 'Swanson Ltd Showcase', 0, 664, 856, '2020-03-15');
INSERT INTO public.plataforma VALUES (385, 'Dunn, Harrell and Davis Air', 0, 792, 78, '1992-04-15');
INSERT INTO public.plataforma VALUES (386, 'Jackson-Fernandez Schedule', 0, 167, 865, '1999-09-24');
INSERT INTO public.plataforma VALUES (387, 'Harrison, Porter and Ball Highlights', 0, 807, 6, '2023-08-04');
INSERT INTO public.plataforma VALUES (388, 'Harmon PLC Connect', 0, 978, 594, '1991-01-29');
INSERT INTO public.plataforma VALUES (389, 'Porto Pires - EI Access', 0, 377, 175, '2009-12-10');
INSERT INTO public.plataforma VALUES (390, 'Thompson-Haney Portal', 0, 206, 789, '1994-08-02');
INSERT INTO public.plataforma VALUES (391, 'Nascimento Nunes e Filhos Select', 0, 94, 986, '1998-06-14');
INSERT INTO public.plataforma VALUES (392, 'Rivera PLC Direct', 0, 632, 907, '1992-09-04');
INSERT INTO public.plataforma VALUES (393, 'Wilson PLC Originais', 0, 614, 666, '1992-08-07');
INSERT INTO public.plataforma VALUES (394, 'Joseph-Lewis PrimeTime', 0, 246, 167, '2004-07-05');
INSERT INTO public.plataforma VALUES (395, 'Robinson, Dickerson and Anderson Agora+', 0, 518, 261, '1991-05-08');
INSERT INTO public.plataforma VALUES (396, 'Walker Group Live', 0, 840, 386, '2009-09-20');
INSERT INTO public.plataforma VALUES (397, 'Gibson, Hill and Schmidt Agora+', 0, 494, 153, '2009-03-14');
INSERT INTO public.plataforma VALUES (398, 'Bates-Wilson Groove', 0, 879, 54, '1991-08-20');
INSERT INTO public.plataforma VALUES (399, 'Albuquerque S.A. CinePlus', 0, 430, 823, '2011-08-28');
INSERT INTO public.plataforma VALUES (400, 'Ramos Garcia - EI Portal', 0, 618, 151, '2018-02-27');
INSERT INTO public.plataforma VALUES (401, 'Leão Almeida Ltda. Collective+', 0, 348, 240, '2015-03-29');
INSERT INTO public.plataforma VALUES (402, 'Johnston, Powell and Alvarez Now', 0, 861, 243, '1990-07-01');
INSERT INTO public.plataforma VALUES (403, 'Ramos Sales - EI Universal', 0, 82, 67, '2024-08-27');
INSERT INTO public.plataforma VALUES (404, 'da Costa S/A Radio', 0, 445, 108, '1999-01-29');
INSERT INTO public.plataforma VALUES (405, 'Rios-Butler Queue', 0, 821, 376, '2023-08-28');
INSERT INTO public.plataforma VALUES (406, 'Meadows Inc Connect+', 0, 577, 294, '1990-02-22');
INSERT INTO public.plataforma VALUES (407, 'Harris-Peterson Air', 0, 788, 866, '1998-10-27');
INSERT INTO public.plataforma VALUES (408, 'Vieira Caldeira - ME Flow', 0, 513, 911, '1991-04-11');
INSERT INTO public.plataforma VALUES (409, 'da Conceição Correia e Filhos Originals', 0, 932, 986, '2011-05-28');
INSERT INTO public.plataforma VALUES (410, 'Martin-Winters Loop', 0, 714, 775, '2020-09-01');
INSERT INTO public.plataforma VALUES (411, 'Chavez, Reynolds and Barrera Connect+', 0, 401, 668, '2021-03-14');
INSERT INTO public.plataforma VALUES (412, 'Atkins, Edwards and Moyer Equipe', 0, 538, 722, '2011-07-30');
INSERT INTO public.plataforma VALUES (413, 'Young Ltd Network', 0, 107, 518, '2011-06-27');
INSERT INTO public.plataforma VALUES (414, 'Richards and Sons Pocket', 0, 970, 140, '1997-08-01');
INSERT INTO public.plataforma VALUES (415, 'Nunez-Hudson NextGen', 0, 385, 654, '2001-04-01');
INSERT INTO public.plataforma VALUES (416, 'Smith, Turner and Ross Library', 0, 54, 47, '1994-02-27');
INSERT INTO public.plataforma VALUES (417, 'Hayes-Pham Fila', 0, 394, 512, '1990-04-17');
INSERT INTO public.plataforma VALUES (418, 'Siqueira - ME Go', 0, 431, 115, '2022-03-11');
INSERT INTO public.plataforma VALUES (419, 'White, Jackson and Roy Stream', 0, 154, 565, '2018-05-12');
INSERT INTO public.plataforma VALUES (420, 'Scott LLC Library', 0, 633, 524, '2003-06-29');
INSERT INTO public.plataforma VALUES (421, 'Manning Ltd Highlights', 0, 595, 728, '2011-09-15');
INSERT INTO public.plataforma VALUES (422, 'Azevedo S/A Streamline', 0, 183, 755, '2001-06-15');
INSERT INTO public.plataforma VALUES (423, 'Rogers Ltd PocketTV', 0, 17, 755, '2010-02-07');
INSERT INTO public.plataforma VALUES (424, 'Gonzalez-Lee Queue', 0, 256, 989, '1990-03-29');
INSERT INTO public.plataforma VALUES (425, 'Gamble-Smith Access', 0, 474, 290, '2003-03-08');
INSERT INTO public.plataforma VALUES (426, 'Jesus Lopes Ltda. Network', 0, 376, 331, '2003-10-04');
INSERT INTO public.plataforma VALUES (427, 'Abreu - EI Playground', 0, 370, 668, '2016-07-08');
INSERT INTO public.plataforma VALUES (428, 'Perry, Woods and Doyle Fila', 0, 486, 273, '2011-02-08');
INSERT INTO public.plataforma VALUES (429, 'Costela S/A Universe', 0, 976, 938, '2016-04-25');
INSERT INTO public.plataforma VALUES (430, 'Souza Jesus - ME Schedule', 0, 38, 354, '1998-04-21');
INSERT INTO public.plataforma VALUES (431, 'Morgan, Washington and Russell Play', 0, 530, 969, '2010-01-20');
INSERT INTO public.plataforma VALUES (432, 'Ferreira Ltda. Schedule', 0, 853, 439, '2004-12-21');
INSERT INTO public.plataforma VALUES (433, 'Viana Souza - ME Loop', 0, 75, 617, '1995-06-07');
INSERT INTO public.plataforma VALUES (434, 'Davis Group Connect', 0, 433, 137, '2024-09-09');
INSERT INTO public.plataforma VALUES (435, 'Cavalcanti Costela - EI Portal', 0, 449, 412, '2007-08-21');
INSERT INTO public.plataforma VALUES (436, 'Aragão - ME Reel', 0, 921, 777, '2007-03-23');
INSERT INTO public.plataforma VALUES (437, 'Burch, Howard and Smith Universal', 0, 80, 699, '1996-08-30');
INSERT INTO public.plataforma VALUES (438, 'Machado Jesus - ME Schedule', 0, 566, 821, '2018-03-22');
INSERT INTO public.plataforma VALUES (439, 'Araújo Ltda. Station', 0, 161, 752, '2017-10-29');
INSERT INTO public.plataforma VALUES (440, 'Guerra e Filhos Explorer', 0, 604, 310, '2005-05-17');
INSERT INTO public.plataforma VALUES (441, 'Nascimento Mendonça S/A Portal', 0, 810, 501, '2022-11-12');
INSERT INTO public.plataforma VALUES (442, 'Pacheco S/A Streamline', 0, 841, 900, '1992-08-05');
INSERT INTO public.plataforma VALUES (443, 'Caldeira S.A. Explorer', 0, 986, 406, '2015-07-21');
INSERT INTO public.plataforma VALUES (444, 'Garcia-Navarro Access', 0, 386, 683, '1998-04-18');
INSERT INTO public.plataforma VALUES (445, 'Mcclain Inc Universo', 0, 682, 867, '1994-02-09');
INSERT INTO public.plataforma VALUES (446, 'Barros Camargo S.A. Exclusivo', 0, 386, 865, '2018-06-11');
INSERT INTO public.plataforma VALUES (447, 'da Mata Dias S.A. Arquivo', 0, 621, 530, '1997-12-28');
INSERT INTO public.plataforma VALUES (448, 'Nascimento Brito Ltda. Universe', 0, 21, 756, '2021-10-08');
INSERT INTO public.plataforma VALUES (449, 'Pastor Ltda. Shows', 0, 428, 883, '1991-10-03');
INSERT INTO public.plataforma VALUES (450, 'Hart, Nichols and Parker Transmit', 0, 621, 341, '2019-11-20');
INSERT INTO public.plataforma VALUES (451, 'Rivera Inc Worlds', 0, 811, 392, '2018-11-14');
INSERT INTO public.plataforma VALUES (452, 'Santos LLC HoraNobre', 0, 108, 244, '2014-05-18');
INSERT INTO public.plataforma VALUES (453, 'Costa Nogueira S.A. Atlas', 0, 969, 366, '2019-03-10');
INSERT INTO public.plataforma VALUES (454, 'Peck-Lowe Pro', 0, 948, 947, '2006-06-05');
INSERT INTO public.plataforma VALUES (455, 'Parrish, Brown and Haynes Aqui', 0, 27, 480, '1995-10-16');
INSERT INTO public.plataforma VALUES (456, 'Mills LLC Edge', 0, 955, 515, '2013-06-02');
INSERT INTO public.plataforma VALUES (457, 'Flowers-Mcdonald Lite', 0, 196, 317, '2008-10-14');
INSERT INTO public.plataforma VALUES (458, 'Huff and Sons HoraNobre', 0, 579, 874, '2003-08-13');
INSERT INTO public.plataforma VALUES (459, 'Becker Group Radio', 0, 609, 103, '2009-03-16');
INSERT INTO public.plataforma VALUES (460, 'Chapman LLC Future', 0, 74, 505, '1998-07-06');
INSERT INTO public.plataforma VALUES (461, 'Gray, Duncan and Anderson Streamers', 0, 155, 245, '2022-04-04');
INSERT INTO public.plataforma VALUES (462, 'Perry, Gardner and Thomas Mais', 0, 89, 358, '2023-01-24');
INSERT INTO public.plataforma VALUES (463, 'Wright, Norris and Best Universe', 0, 391, 308, '2001-06-30');
INSERT INTO public.plataforma VALUES (464, 'da Rosa Farias e Filhos Transmit', 0, 646, 850, '2016-04-19');
INSERT INTO public.plataforma VALUES (465, 'Skinner, Ramirez and Maddox Library', 0, 228, 610, '2003-06-06');
INSERT INTO public.plataforma VALUES (466, 'Kent-Johnson Air', 0, 796, 68, '2021-02-22');
INSERT INTO public.plataforma VALUES (467, 'Camargo e Filhos Direct', 0, 880, 836, '2000-10-13');
INSERT INTO public.plataforma VALUES (468, 'Lane, Frye and Henson Air', 0, 31, 103, '2015-03-14');
INSERT INTO public.plataforma VALUES (469, 'Andrade Novaes e Filhos Palco', 0, 178, 485, '2007-05-27');
INSERT INTO public.plataforma VALUES (470, 'Woods, Jackson and Martin Prime', 0, 125, 268, '2009-04-27');
INSERT INTO public.plataforma VALUES (471, 'Frey Group Onda', 0, 434, 643, '1998-07-04');
INSERT INTO public.plataforma VALUES (472, 'Gomes da Cunha e Filhos Library', 0, 743, 777, '1994-05-13');
INSERT INTO public.plataforma VALUES (473, 'Cunha Jesus S/A Mini', 0, 721, 880, '2002-07-30');
INSERT INTO public.plataforma VALUES (474, 'Baker, Wright and Barber Stream', 0, 158, 521, '2015-12-04');
INSERT INTO public.plataforma VALUES (475, 'Moura Aragão - ME Connect', 0, 259, 750, '2020-01-24');
INSERT INTO public.plataforma VALUES (476, 'Mills, Jones and Bell Live+', 0, 111, 195, '1994-04-04');
INSERT INTO public.plataforma VALUES (477, 'Brito Ltda. Studio', 0, 291, 177, '2018-07-21');
INSERT INTO public.plataforma VALUES (478, 'Anderson, Scott and Potts Highlights', 0, 86, 853, '1992-11-30');
INSERT INTO public.plataforma VALUES (479, 'Campbell, Brown and Black Portal', 0, 977, 449, '2025-04-05');
INSERT INTO public.plataforma VALUES (480, 'Gonzalez Inc Arquivo', 0, 410, 528, '2010-11-05');
INSERT INTO public.plataforma VALUES (481, 'da Rosa Camargo Ltda. Lineup', 0, 950, 978, '2002-08-09');
INSERT INTO public.plataforma VALUES (482, 'Rios Ltda. Streamline', 0, 519, 807, '2020-12-10');
INSERT INTO public.plataforma VALUES (483, 'Martins e Filhos Vault', 0, 227, 661, '2023-02-24');
INSERT INTO public.plataforma VALUES (484, 'da Mata Fogaça - EI Library', 0, 356, 759, '1997-11-27');
INSERT INTO public.plataforma VALUES (485, 'Barrett-Hernandez Cinema', 0, 270, 967, '1993-04-07');
INSERT INTO public.plataforma VALUES (486, 'Beltran and Sons Mundo', 0, 895, 928, '1992-10-22');
INSERT INTO public.plataforma VALUES (487, 'Meyer-Stokes Play', 0, 570, 227, '2005-10-21');
INSERT INTO public.plataforma VALUES (488, 'Vieira Nunes S/A Shows', 0, 305, 866, '2011-02-04');
INSERT INTO public.plataforma VALUES (489, 'Monteiro Gonçalves Ltda. OnRepeat', 0, 283, 353, '2002-01-08');
INSERT INTO public.plataforma VALUES (490, 'Alves Borges e Filhos Originals', 0, 207, 390, '2012-09-10');
INSERT INTO public.plataforma VALUES (491, 'Fogaça Ltda. Portal', 0, 931, 732, '2023-05-26');
INSERT INTO public.plataforma VALUES (492, 'Ribeiro - ME Metaverse', 0, 159, 910, '1999-01-12');
INSERT INTO public.plataforma VALUES (493, 'da Mata Duarte S.A. Go', 0, 834, 969, '2006-02-01');
INSERT INTO public.plataforma VALUES (494, 'Bennett, Mcdaniel and Middleton NextGen', 0, 510, 176, '2014-09-21');
INSERT INTO public.plataforma VALUES (495, 'Nascimento Rios S/A Atlas', 0, 471, 623, '1993-05-09');
INSERT INTO public.plataforma VALUES (496, 'Morgan-Little Originals', 0, 516, 829, '2013-06-26');
INSERT INTO public.plataforma VALUES (497, 'Ali, Johnson and Harris Reel', 0, 914, 601, '2001-02-08');
INSERT INTO public.plataforma VALUES (498, 'Ribeiro Vasconcelos e Filhos On', 0, 14, 366, '1992-01-06');
INSERT INTO public.plataforma VALUES (499, 'Freitas da Costa S.A. Prime', 0, 722, 592, '2014-05-29');
INSERT INTO public.plataforma VALUES (500, 'Dias Peixoto - EI Verse', 0, 856, 902, '2007-12-12');
INSERT INTO public.plataforma VALUES (501, 'Dalton LLC Select', 0, 891, 991, '1995-10-27');
INSERT INTO public.plataforma VALUES (502, 'Albuquerque S/A Spot', 0, 839, 39, '1993-02-18');
INSERT INTO public.plataforma VALUES (503, 'da Mata Ltda. Transmit', 0, 2, 311, '2019-06-05');
INSERT INTO public.plataforma VALUES (504, 'Jackson-Turner Fluxo', 0, 452, 968, '2004-07-07');
INSERT INTO public.plataforma VALUES (505, 'Baker Inc Future', 0, 870, 370, '2011-05-03');
INSERT INTO public.plataforma VALUES (506, 'Vargas Ramos - EI Collective+', 0, 37, 191, '2025-01-22');
INSERT INTO public.plataforma VALUES (507, 'da Mata e Filhos Arquivo', 0, 722, 962, '2023-08-11');
INSERT INTO public.plataforma VALUES (508, 'Howard Group CastTV', 0, 645, 939, '2004-09-11');
INSERT INTO public.plataforma VALUES (509, 'Horn and Sons OnRepeat', 0, 280, 647, '2023-09-09');
INSERT INTO public.plataforma VALUES (510, 'Oliveira Albuquerque - EI Box', 0, 503, 950, '2004-01-03');
INSERT INTO public.plataforma VALUES (511, 'Kim and Sons Schedule', 0, 257, 608, '2009-12-29');
INSERT INTO public.plataforma VALUES (512, 'Ortega Group Verse', 0, 950, 974, '2000-09-09');
INSERT INTO public.plataforma VALUES (513, 'Nogueira Costela S.A. Atlas', 0, 854, 223, '2023-11-17');
INSERT INTO public.plataforma VALUES (514, 'Boyd, King and Fischer Select', 0, 255, 161, '2012-08-15');
INSERT INTO public.plataforma VALUES (515, 'da Rocha - ME Portal', 0, 235, 749, '2009-12-19');
INSERT INTO public.plataforma VALUES (516, 'Casa Grande Ltda. Equipe', 0, 240, 374, '2020-02-11');
INSERT INTO public.plataforma VALUES (517, 'Novaes das Neves S/A NextGen', 0, 591, 724, '2001-06-24');
INSERT INTO public.plataforma VALUES (518, 'Holmes Ltd Pro', 0, 349, 539, '2023-08-02');
INSERT INTO public.plataforma VALUES (519, 'Davis-Hernandez Box', 0, 46, 786, '2007-02-02');
INSERT INTO public.plataforma VALUES (520, 'Shelton-Garcia PlayLab', 0, 554, 497, '1993-03-26');
INSERT INTO public.plataforma VALUES (521, 'Brooks-Jones Transmit', 0, 572, 15, '2011-10-23');
INSERT INTO public.plataforma VALUES (522, 'Garcia Pimenta S.A. Ir', 0, 863, 228, '2003-09-14');
INSERT INTO public.plataforma VALUES (523, 'Melo Camargo e Filhos Stage', 0, 571, 845, '2005-11-14');
INSERT INTO public.plataforma VALUES (524, 'Harrison-Ray Channel', 0, 63, 929, '2009-10-10');
INSERT INTO public.plataforma VALUES (525, 'Taylor, Castro and Jones Equipe', 0, 547, 41, '2000-04-10');
INSERT INTO public.plataforma VALUES (526, 'Aparecida Correia e Filhos Flow', 0, 546, 878, '2016-07-08');
INSERT INTO public.plataforma VALUES (527, 'Barbosa - ME Universal', 0, 858, 842, '2005-08-02');
INSERT INTO public.plataforma VALUES (528, 'Wilson, Daugherty and Cruz Universo', 0, 814, 205, '2018-02-11');
INSERT INTO public.plataforma VALUES (529, 'Novais - ME Atlas', 0, 481, 994, '2008-10-23');
INSERT INTO public.plataforma VALUES (530, 'Alves Almeida S/A Reels', 0, 130, 350, '1999-09-12');
INSERT INTO public.plataforma VALUES (531, 'Fonseca - ME Explorer', 0, 796, 174, '1990-12-08');
INSERT INTO public.plataforma VALUES (532, 'Owen-Robinson Prime', 0, 925, 282, '2022-04-21');
INSERT INTO public.plataforma VALUES (533, 'da Cruz Lopes Ltda. LiveStream', 0, 815, 266, '2025-10-27');
INSERT INTO public.plataforma VALUES (534, 'Collins Inc Originais', 0, 371, 885, '2022-03-16');
INSERT INTO public.plataforma VALUES (535, 'Ross and Sons Collective+', 0, 353, 425, '2017-07-07');
INSERT INTO public.plataforma VALUES (536, 'Jenkins, Bryant and Sparks LiveStream', 0, 64, 833, '2014-03-09');
INSERT INTO public.plataforma VALUES (537, 'Costela - ME HoraNobre', 0, 117, 159, '2021-08-03');
INSERT INTO public.plataforma VALUES (538, 'Moraes da Cruz - ME Ir', 0, 62, 631, '1999-01-04');
INSERT INTO public.plataforma VALUES (539, 'Castro Caldeira - ME Flix', 0, 534, 556, '2001-04-21');
INSERT INTO public.plataforma VALUES (540, 'Wilson, Gould and Andrews Explorer', 0, 763, 703, '1994-02-23');
INSERT INTO public.plataforma VALUES (541, 'Chung Ltd Direct', 0, 80, 236, '2016-12-01');
INSERT INTO public.plataforma VALUES (542, 'da Luz Brito - ME PrimeTime', 0, 289, 703, '2024-06-18');
INSERT INTO public.plataforma VALUES (543, 'Williams LLC Radio', 0, 427, 786, '2002-01-13');
INSERT INTO public.plataforma VALUES (544, 'Andrade Santos - ME Air', 0, 187, 156, '2019-02-02');
INSERT INTO public.plataforma VALUES (545, 'Davis-Williams Worlds', 0, 473, 674, '2003-04-23');
INSERT INTO public.plataforma VALUES (546, 'Fonseca Garcia - ME Streamline', 0, 298, 262, '2007-05-01');
INSERT INTO public.plataforma VALUES (547, 'Swanson-Evans PocketTV', 0, 174, 6, '2022-10-03');
INSERT INTO public.plataforma VALUES (548, 'da Costa - ME Now+', 0, 493, 836, '2010-04-14');
INSERT INTO public.plataforma VALUES (549, 'Guerra Silva - EI Arquivo', 0, 670, 937, '2021-02-14');
INSERT INTO public.plataforma VALUES (550, 'Brown Ltd CinePlus', 0, 304, 3, '2025-08-12');
INSERT INTO public.plataforma VALUES (551, 'das Neves e Filhos Live+', 0, 201, 176, '2000-11-25');
INSERT INTO public.plataforma VALUES (552, 'Taylor Group Collective', 0, 474, 549, '2014-12-17');
INSERT INTO public.plataforma VALUES (553, 'Garcia, Morton and Moreno Play', 0, 591, 394, '2005-06-11');
INSERT INTO public.plataforma VALUES (554, 'Cook, Sanders and Gibson Stream', 0, 448, 33, '1990-07-20');
INSERT INTO public.plataforma VALUES (555, 'Andrade Machado S/A Exclusivo', 0, 367, 84, '2023-11-13');
INSERT INTO public.plataforma VALUES (556, 'Adams-Hendricks Cine', 0, 796, 729, '2014-07-11');
INSERT INTO public.plataforma VALUES (557, 'Roberson-Chavez Spot', 0, 659, 855, '2016-03-25');
INSERT INTO public.plataforma VALUES (558, 'da Rosa Sampaio S/A Now', 0, 516, 518, '2020-08-22');
INSERT INTO public.plataforma VALUES (559, 'Carvalho Borges Ltda. Canal', 0, 65, 347, '2022-07-25');
INSERT INTO public.plataforma VALUES (560, 'Brito Fernandes S.A. Cinema', 0, 771, 704, '2002-10-08');
INSERT INTO public.plataforma VALUES (561, 'Curtis-Hall Portal', 0, 951, 319, '1995-06-03');
INSERT INTO public.plataforma VALUES (562, 'Costela S.A. Atlas', 0, 767, 446, '2008-08-03');
INSERT INTO public.plataforma VALUES (563, 'Marques S.A. Exclusive', 0, 60, 419, '2011-07-06');
INSERT INTO public.plataforma VALUES (564, 'Duffy-Anderson Streamers', 0, 108, 307, '1998-06-04');
INSERT INTO public.plataforma VALUES (565, 'Cavalcante S/A PlayLab', 0, 368, 619, '1990-11-17');
INSERT INTO public.plataforma VALUES (566, 'White Inc Worlds', 0, 873, 76, '2019-07-11');
INSERT INTO public.plataforma VALUES (567, 'Guerra da Cruz - ME Ir', 0, 692, 885, '2020-04-27');
INSERT INTO public.plataforma VALUES (568, 'Jones-Smith Beat', 0, 129, 581, '2004-08-02');
INSERT INTO public.plataforma VALUES (569, 'Pimenta S.A. Exclusivo', 0, 655, 919, '2018-02-05');
INSERT INTO public.plataforma VALUES (570, 'Smith, Frazier and Cline Verse', 0, 914, 871, '2019-06-14');
INSERT INTO public.plataforma VALUES (571, 'Silva Freitas - EI Schedule', 0, 622, 358, '1994-04-05');
INSERT INTO public.plataforma VALUES (572, 'Fonseca Aragão e Filhos Access+', 0, 970, 400, '2003-02-21');
INSERT INTO public.plataforma VALUES (573, 'Pastor Gonçalves - ME Edge', 0, 842, 660, '2018-05-16');
INSERT INTO public.plataforma VALUES (574, 'Macedo - ME Replay', 0, 53, 781, '1999-03-07');
INSERT INTO public.plataforma VALUES (575, 'Lee LLC Studio', 0, 176, 729, '2015-02-13');
INSERT INTO public.plataforma VALUES (576, 'Rezende - ME Now', 0, 710, 331, '1992-03-09');
INSERT INTO public.plataforma VALUES (577, 'Richardson PLC PlayLab', 0, 678, 759, '2008-03-29');
INSERT INTO public.plataforma VALUES (578, 'Ho-Rojas CastTV', 0, 559, 586, '2000-11-15');
INSERT INTO public.plataforma VALUES (579, 'Azevedo Ltda. Flow', 0, 625, 56, '2014-01-27');
INSERT INTO public.plataforma VALUES (580, 'Sales Nascimento S.A. Atlas', 0, 941, 530, '1999-02-11');
INSERT INTO public.plataforma VALUES (581, 'Gross, Herman and Luna LiveStream', 0, 83, 875, '1992-06-30');
INSERT INTO public.plataforma VALUES (582, 'Thompson, Jones and Jensen Explorer', 0, 484, 368, '2017-04-28');
INSERT INTO public.plataforma VALUES (583, 'da Costa Oliveira - ME Navigator', 0, 569, 392, '1996-02-18');
INSERT INTO public.plataforma VALUES (584, 'Hart, Thomas and Murphy LoopTV', 0, 841, 883, '1995-08-27');
INSERT INTO public.plataforma VALUES (585, 'Gonzalez-Browning Mais', 0, 534, 428, '2015-08-27');
INSERT INTO public.plataforma VALUES (586, 'Burton PLC Mundo', 0, 91, 997, '2007-09-18');
INSERT INTO public.plataforma VALUES (587, 'Murphy-Finley Live+', 0, 766, 90, '2018-01-23');
INSERT INTO public.plataforma VALUES (588, 'Pimenta Pereira Ltda. Live+', 0, 584, 779, '2011-03-12');
INSERT INTO public.plataforma VALUES (589, 'Carroll, Brown and Vasquez Scene', 0, 325, 106, '1996-10-25');
INSERT INTO public.plataforma VALUES (590, 'Guzman and Sons Plus', 0, 712, 985, '2013-04-09');
INSERT INTO public.plataforma VALUES (591, 'Almeida Dias - EI Gate', 0, 16, 714, '1992-02-28');
INSERT INTO public.plataforma VALUES (592, 'Farias Pires e Filhos Cinema', 0, 47, 395, '2020-07-25');
INSERT INTO public.plataforma VALUES (593, 'Lamb Group Filmes', 0, 479, 864, '1998-05-05');
INSERT INTO public.plataforma VALUES (594, 'Ruiz Ltd Vibe', 0, 340, 304, '2007-02-19');
INSERT INTO public.plataforma VALUES (595, 'Mitchell, Moore and Martinez Pod', 0, 611, 865, '2017-05-09');
INSERT INTO public.plataforma VALUES (596, 'Wilson-Watts LoopTV', 0, 339, 532, '2002-10-19');
INSERT INTO public.plataforma VALUES (597, 'Borges Sá e Filhos Worlds', 0, 69, 262, '2020-12-03');
INSERT INTO public.plataforma VALUES (598, 'Rhodes-Clark Streamers', 0, 618, 601, '2009-04-12');
INSERT INTO public.plataforma VALUES (599, 'Pimenta Pinto - EI Cinema', 0, 429, 154, '2002-11-05');
INSERT INTO public.plataforma VALUES (600, 'Pereira e Filhos Streamline', 0, 677, 768, '2025-09-29');
INSERT INTO public.plataforma VALUES (601, 'Alexander LLC Navigator', 0, 742, 873, '1997-07-18');
INSERT INTO public.plataforma VALUES (602, 'Ware LLC Next', 0, 932, 464, '2024-07-15');
INSERT INTO public.plataforma VALUES (603, 'Campos LLC Mini', 0, 940, 836, '2012-01-30');
INSERT INTO public.plataforma VALUES (604, 'Rodrigues da Cunha e Filhos PocketTV', 0, 903, 532, '2004-10-02');
INSERT INTO public.plataforma VALUES (605, 'Nascimento S.A. Ir', 0, 491, 743, '2014-01-03');
INSERT INTO public.plataforma VALUES (606, 'Collins, Schmidt and Johnson OnRepeat', 0, 906, 459, '2021-11-14');
INSERT INTO public.plataforma VALUES (607, 'da Luz Cavalcanti Ltda. Transmit', 0, 118, 41, '2003-12-08');
INSERT INTO public.plataforma VALUES (608, 'Duarte Ltda. Library', 0, 836, 483, '1997-09-19');
INSERT INTO public.plataforma VALUES (609, 'Cavalcanti Ltda. Channel', 0, 527, 243, '1998-02-28');
INSERT INTO public.plataforma VALUES (610, 'Aragão - EI Highlights', 0, 314, 499, '2000-06-12');
INSERT INTO public.plataforma VALUES (611, 'Patel-Hull Portal', 0, 203, 52, '2018-07-16');
INSERT INTO public.plataforma VALUES (612, 'Pires Pacheco - EI Highlights', 0, 535, 850, '2015-10-03');
INSERT INTO public.plataforma VALUES (613, 'Abbott-Foley Wave', 0, 523, 392, '2017-08-01');
INSERT INTO public.plataforma VALUES (614, 'Moraes S/A Future', 0, 246, 556, '1991-02-26');
INSERT INTO public.plataforma VALUES (615, 'Cavalcante da Rocha - EI Connect', 0, 529, 246, '1996-11-16');
INSERT INTO public.plataforma VALUES (616, 'Mitchell Ltd Mapa', 0, 263, 825, '2012-08-08');
INSERT INTO public.plataforma VALUES (617, 'Cavalcanti S.A. Portal', 0, 756, 1, '1993-08-18');
INSERT INTO public.plataforma VALUES (618, 'Barros Pinto - ME Collective+', 0, 524, 616, '2024-11-26');
INSERT INTO public.plataforma VALUES (619, 'Palmer, Roth and Burch Collection', 0, 510, 312, '2011-08-08');
INSERT INTO public.plataforma VALUES (620, 'Lima Ltda. Portal', 0, 586, 557, '1999-03-01');
INSERT INTO public.plataforma VALUES (621, 'Wall-Hood Mundo', 0, 355, 895, '2010-02-21');
INSERT INTO public.plataforma VALUES (622, 'Hernandez-Rivers Stage', 0, 44, 554, '2025-07-09');
INSERT INTO public.plataforma VALUES (623, 'Austin-Vazquez Sincroniza', 0, 114, 941, '2020-08-29');
INSERT INTO public.plataforma VALUES (624, 'Cardoso - ME Play', 0, 932, 430, '2019-09-02');
INSERT INTO public.plataforma VALUES (625, 'Vazquez-Martinez Queue', 0, 121, 141, '2025-07-31');
INSERT INTO public.plataforma VALUES (626, 'da Conceição Barros Ltda. Originals', 0, 859, 381, '1998-06-17');
INSERT INTO public.plataforma VALUES (627, 'Glover LLC CinePlus', 0, 608, 243, '2022-11-22');
INSERT INTO public.plataforma VALUES (628, 'Alves da Mota S.A. Universo', 0, 404, 271, '2007-01-15');
INSERT INTO public.plataforma VALUES (629, 'Silva Brito S/A Go', 0, 84, 324, '2019-07-06');
INSERT INTO public.plataforma VALUES (630, 'Vincent-Brown Showcase', 0, 320, 315, '1990-11-22');
INSERT INTO public.plataforma VALUES (631, 'Pastor S/A Sync', 0, 671, 528, '2013-12-29');
INSERT INTO public.plataforma VALUES (632, 'Austin, Sosa and Beltran Access', 0, 497, 760, '2010-04-19');
INSERT INTO public.plataforma VALUES (633, 'Shaffer-Jones Streamers', 0, 289, 414, '2015-02-22');
INSERT INTO public.plataforma VALUES (634, 'Morgan-Norman Streamline', 0, 488, 152, '2012-10-15');
INSERT INTO public.plataforma VALUES (635, 'da Cunha Ltda. Spotlight', 0, 353, 17, '2001-05-08');
INSERT INTO public.plataforma VALUES (636, 'Costela Dias e Filhos Pro', 0, 530, 990, '2024-11-28');
INSERT INTO public.plataforma VALUES (637, 'Campos e Filhos Pass', 0, 847, 614, '2000-06-16');
INSERT INTO public.plataforma VALUES (638, 'Lang Inc NextGen', 0, 676, 692, '2018-07-19');
INSERT INTO public.plataforma VALUES (639, 'Myers-Cox Collective', 0, 731, 680, '1994-07-14');
INSERT INTO public.plataforma VALUES (640, 'Hardy, Harris and Harrell Shows', 0, 569, 980, '2009-12-06');
INSERT INTO public.plataforma VALUES (641, 'Torres Group Realm', 0, 171, 70, '1999-07-04');
INSERT INTO public.plataforma VALUES (642, 'Rodrigues - ME Crew', 0, 408, 103, '2023-06-24');
INSERT INTO public.plataforma VALUES (643, 'Hardin, Aguirre and Dean Hub', 0, 340, 481, '1998-10-16');
INSERT INTO public.plataforma VALUES (644, 'Moraes Castro e Filhos Connect', 0, 204, 253, '2025-08-14');
INSERT INTO public.plataforma VALUES (645, 'Robinson Group Wave', 0, 749, 9, '2002-10-26');
INSERT INTO public.plataforma VALUES (646, 'Gomes Monteiro - EI Worlds', 0, 774, 449, '2004-01-07');
INSERT INTO public.plataforma VALUES (647, 'Khan, Smith and Brown Fluxo', 0, 269, 182, '2012-09-24');
INSERT INTO public.plataforma VALUES (648, 'Vasconcelos - EI Connect', 0, 633, 130, '1999-05-24');
INSERT INTO public.plataforma VALUES (649, 'Stevenson, Gilbert and Anthony Plataforma', 0, 915, 250, '1998-05-30');
INSERT INTO public.plataforma VALUES (650, 'Andrade Pimenta - ME Playground', 0, 474, 605, '2003-07-29');
INSERT INTO public.plataforma VALUES (651, 'Rezende Casa Grande - EI Crew', 0, 883, 35, '1997-09-18');
INSERT INTO public.plataforma VALUES (652, 'Castaneda, Hood and Brown Premium', 0, 523, 284, '2012-02-04');
INSERT INTO public.plataforma VALUES (653, 'Walker, Cook and Simpson Mais', 0, 803, 642, '1992-03-29');
INSERT INTO public.plataforma VALUES (654, 'Brito da Paz e Filhos Atlas', 0, 514, 36, '2008-11-22');
INSERT INTO public.plataforma VALUES (655, 'Graham-Miller Plataforma', 0, 11, 86, '2012-11-16');
INSERT INTO public.plataforma VALUES (656, 'Nogueira Ltda. Library', 0, 471, 435, '2017-11-21');
INSERT INTO public.plataforma VALUES (657, 'Adams-Cohen Library', 0, 544, 12, '2020-02-29');
INSERT INTO public.plataforma VALUES (658, 'Cunha Nascimento - EI Go', 0, 539, 699, '1995-09-09');
INSERT INTO public.plataforma VALUES (659, 'Gonçalves da Cunha Ltda. Schedule', 0, 282, 392, '2008-03-29');
INSERT INTO public.plataforma VALUES (660, 'Moore-Harris PlayLab', 0, 201, 451, '1997-08-03');
INSERT INTO public.plataforma VALUES (661, 'Jones, Martinez and Mccarty Verse', 0, 463, 461, '2003-06-12');
INSERT INTO public.plataforma VALUES (662, 'West LLC Now+', 0, 266, 86, '2016-03-25');
INSERT INTO public.plataforma VALUES (663, 'Gomes Sousa - ME Spot', 0, 744, 131, '2024-08-06');
INSERT INTO public.plataforma VALUES (664, 'Ramos Nunes - ME Flow', 0, 762, 423, '2012-12-11');
INSERT INTO public.plataforma VALUES (665, 'Carvalho Mendes Ltda. CastTV', 0, 732, 544, '2002-03-28');
INSERT INTO public.plataforma VALUES (666, 'Fields, White and Watson Arquivo', 0, 557, 118, '1990-11-06');
INSERT INTO public.plataforma VALUES (667, 'Dennis-Burke Library', 0, 267, 496, '2023-02-18');
INSERT INTO public.plataforma VALUES (668, 'Hebert, Thompson and Cole Filmes', 0, 786, 761, '2015-02-07');
INSERT INTO public.plataforma VALUES (669, 'Câmara Gonçalves S.A. Entrada', 0, 807, 310, '2005-07-06');
INSERT INTO public.plataforma VALUES (670, 'Moore, Nelson and Adams Cine', 0, 12, 401, '2013-10-31');
INSERT INTO public.plataforma VALUES (671, 'Guerra Souza - ME Premium', 0, 262, 312, '2000-05-14');
INSERT INTO public.plataforma VALUES (672, 'Silva Ltda. Ir', 0, 594, 850, '2016-07-08');
INSERT INTO public.plataforma VALUES (673, 'Araújo Machado Ltda. Realm', 0, 982, 603, '2005-02-19');
INSERT INTO public.plataforma VALUES (674, 'Harrison-Spears Select', 0, 103, 132, '2000-05-05');
INSERT INTO public.plataforma VALUES (675, 'Miller-West Lite', 0, 527, 864, '2023-08-17');
INSERT INTO public.plataforma VALUES (676, 'Marques Monteiro S/A Exclusive', 0, 237, 287, '2003-01-20');
INSERT INTO public.plataforma VALUES (677, 'Santos - ME Entrada', 0, 522, 382, '2012-12-27');
INSERT INTO public.plataforma VALUES (678, 'Burns PLC Collective', 0, 580, 863, '2008-11-20');
INSERT INTO public.plataforma VALUES (679, 'Machado Gomes - ME Play', 0, 710, 197, '2015-02-23');
INSERT INTO public.plataforma VALUES (680, 'Marshall Ltd Premium', 0, 730, 348, '2025-10-16');
INSERT INTO public.plataforma VALUES (681, 'Brito S/A Mais', 0, 757, 356, '1991-06-10');
INSERT INTO public.plataforma VALUES (682, 'Gilbert, Castaneda and Wilson Playground', 0, 433, 702, '1993-05-02');
INSERT INTO public.plataforma VALUES (683, 'Henderson PLC Cine', 0, 688, 90, '2003-03-31');
INSERT INTO public.plataforma VALUES (684, 'Brooks, Guzman and Potts Beat', 0, 841, 761, '2000-03-30');
INSERT INTO public.plataforma VALUES (685, 'Steele LLC Select', 0, 320, 524, '2012-03-20');
INSERT INTO public.plataforma VALUES (686, 'da Rocha Ltda. Exclusive', 0, 513, 469, '1994-09-15');
INSERT INTO public.plataforma VALUES (687, 'Warner LLC Prime', 0, 567, 327, '1992-08-10');
INSERT INTO public.plataforma VALUES (688, 'Harris-Thomas Beat', 0, 391, 374, '2022-01-05');
INSERT INTO public.plataforma VALUES (689, 'Miranda-Johnston Universe', 0, 785, 171, '2010-10-02');
INSERT INTO public.plataforma VALUES (690, 'Jackson Inc Live', 0, 869, 212, '2009-11-19');
INSERT INTO public.plataforma VALUES (691, 'Ramsey, Watts and Mayer Ir', 0, 700, 753, '2004-06-27');
INSERT INTO public.plataforma VALUES (692, 'Lopes Farias - ME Box', 0, 575, 937, '1997-04-26');
INSERT INTO public.plataforma VALUES (693, 'Pacheco Caldeira - EI PocketTV', 0, 199, 343, '1994-05-07');
INSERT INTO public.plataforma VALUES (694, 'Pereira Silva S.A. Vibe', 0, 148, 16, '2001-05-25');
INSERT INTO public.plataforma VALUES (695, 'Rios Pastor e Filhos PlayLab', 0, 629, 254, '1997-12-14');
INSERT INTO public.plataforma VALUES (696, 'Torres, Hughes and King Exclusive', 0, 94, 754, '1997-02-13');
INSERT INTO public.plataforma VALUES (697, 'Carvalho - EI Live+', 0, 619, 760, '2002-12-16');
INSERT INTO public.plataforma VALUES (698, 'Alves S/A Pod', 0, 915, 757, '2004-11-07');
INSERT INTO public.plataforma VALUES (699, 'Noble, Moran and Cisneros Ir', 0, 955, 299, '1994-10-02');
INSERT INTO public.plataforma VALUES (700, 'Robinson-Ferguson Pod', 0, 64, 663, '2014-09-18');
INSERT INTO public.plataforma VALUES (701, 'Phillips-Hill Transmit', 0, 792, 873, '1993-12-29');
INSERT INTO public.plataforma VALUES (702, 'Adkins-Nguyen Network', 0, 668, 443, '1995-02-08');
INSERT INTO public.plataforma VALUES (703, 'Mendonça Carvalho - EI Streamline', 0, 468, 383, '2021-04-01');
INSERT INTO public.plataforma VALUES (704, 'Novais Moraes - ME AoVivo', 0, 532, 233, '2013-08-19');
INSERT INTO public.plataforma VALUES (705, 'Fonseca S.A. Vault', 0, 626, 41, '2024-03-01');
INSERT INTO public.plataforma VALUES (706, 'Bailey Group Flix', 0, 867, 508, '2016-07-01');
INSERT INTO public.plataforma VALUES (707, 'Rivera, Smith and Hernandez Queue', 0, 474, 451, '2024-01-14');
INSERT INTO public.plataforma VALUES (708, 'Warner-Thomas Beat', 0, 260, 646, '2019-07-24');
INSERT INTO public.plataforma VALUES (709, 'Ellis LLC Ponto', 0, 722, 895, '2016-08-31');
INSERT INTO public.plataforma VALUES (710, 'Le, Armstrong and Nelson Pro', 0, 613, 902, '2002-11-03');
INSERT INTO public.plataforma VALUES (711, 'Farias Barros - ME Station', 0, 121, 967, '2019-11-18');
INSERT INTO public.plataforma VALUES (712, 'Souza da Paz e Filhos Vibe', 0, 393, 250, '1995-03-29');
INSERT INTO public.plataforma VALUES (713, 'Pereira Mendes e Filhos Mini', 0, 148, 521, '2013-10-28');
INSERT INTO public.plataforma VALUES (714, 'Wallace, Evans and White Mundo', 0, 299, 2, '2000-08-27');
INSERT INTO public.plataforma VALUES (715, 'Jackson, Romero and Mcclain Live+', 0, 911, 436, '2004-06-17');
INSERT INTO public.plataforma VALUES (716, 'Albuquerque Pacheco S/A Now', 0, 255, 740, '1998-09-19');
INSERT INTO public.plataforma VALUES (717, 'da Paz e Filhos Entrada', 0, 827, 810, '1996-02-19');
INSERT INTO public.plataforma VALUES (718, 'Pires S.A. Live', 0, 669, 437, '2025-04-25');
INSERT INTO public.plataforma VALUES (719, 'da Rocha Moura S/A Reel', 0, 820, 523, '2005-07-08');
INSERT INTO public.plataforma VALUES (720, 'Freitas Lima Ltda. Mundo', 0, 839, 150, '2011-04-19');
INSERT INTO public.plataforma VALUES (721, 'Gomes Ltda. Ponto', 0, 712, 562, '1990-08-26');
INSERT INTO public.plataforma VALUES (722, 'Zimmerman-Gibson Access', 0, 88, 413, '2022-08-15');
INSERT INTO public.plataforma VALUES (723, 'Johnston, Wilcox and Dyer On', 0, 605, 429, '2022-05-17');
INSERT INTO public.plataforma VALUES (724, 'Oliveira Câmara - EI LiveStream', 0, 338, 421, '2010-07-03');
INSERT INTO public.plataforma VALUES (725, 'Garrett Ltd Agora+', 0, 558, 248, '1998-05-13');
INSERT INTO public.plataforma VALUES (726, 'Melo Nogueira e Filhos Reels', 0, 81, 165, '2017-10-24');
INSERT INTO public.plataforma VALUES (727, 'Scott-Perez Schedule', 0, 226, 834, '2008-05-22');
INSERT INTO public.plataforma VALUES (728, 'Cardenas, Ali and Brown Exclusivo', 0, 76, 950, '1994-04-21');
INSERT INTO public.plataforma VALUES (729, 'Ribeiro Sá Ltda. Collective', 0, 256, 367, '2007-09-30');
INSERT INTO public.plataforma VALUES (730, 'Oliveira Castro S.A. Scene', 0, 691, 664, '1993-02-18');
INSERT INTO public.plataforma VALUES (731, 'Vasconcelos Almeida e Filhos Playground', 0, 600, 642, '2013-12-10');
INSERT INTO public.plataforma VALUES (732, 'Monteiro da Luz - ME Portal', 0, 193, 906, '2006-01-26');
INSERT INTO public.plataforma VALUES (733, 'Jones, Gutierrez and Odom Entrada', 0, 664, 545, '2023-08-16');
INSERT INTO public.plataforma VALUES (734, 'Odom Group Live+', 0, 658, 861, '2013-06-04');
INSERT INTO public.plataforma VALUES (735, 'Cunha Leão Ltda. PrimeTime', 0, 660, 909, '1991-07-10');
INSERT INTO public.plataforma VALUES (736, 'Blackwell LLC Access', 0, 496, 340, '2000-03-28');
INSERT INTO public.plataforma VALUES (737, 'Fogaça S/A Realm', 0, 913, 841, '2008-02-24');
INSERT INTO public.plataforma VALUES (738, 'Novaes Novaes Ltda. Portal', 0, 195, 561, '2012-02-09');
INSERT INTO public.plataforma VALUES (739, 'Mendonça Dias - ME Universal', 0, 5, 199, '1996-04-18');
INSERT INTO public.plataforma VALUES (740, 'Novaes - ME LoopTV', 0, 508, 144, '2000-01-21');
INSERT INTO public.plataforma VALUES (741, 'Chavez, Castillo and Thompson Spot', 0, 974, 157, '2022-08-20');
INSERT INTO public.plataforma VALUES (742, 'Camargo Ltda. Highlights', 0, 136, 811, '2011-05-15');
INSERT INTO public.plataforma VALUES (743, 'West Group Vault', 0, 365, 471, '2025-04-04');
INSERT INTO public.plataforma VALUES (744, 'Wright Group Premium', 0, 407, 373, '2023-06-27');
INSERT INTO public.plataforma VALUES (745, 'Peixoto e Filhos Air', 0, 269, 922, '2005-12-19');
INSERT INTO public.plataforma VALUES (746, 'Freeman, Smith and Hicks Access', 0, 568, 719, '1990-05-13');
INSERT INTO public.plataforma VALUES (747, 'Fernandes - EI Prime', 0, 785, 476, '2012-07-20');
INSERT INTO public.plataforma VALUES (748, 'Santos Caldeira - EI Reels', 0, 149, 240, '2020-10-21');
INSERT INTO public.plataforma VALUES (749, 'Gallagher-Harper Fila', 0, 786, 630, '2012-11-28');
INSERT INTO public.plataforma VALUES (750, 'Fonseca Silva - ME Reels', 0, 567, 619, '1998-02-26');
INSERT INTO public.plataforma VALUES (751, 'Villegas-Jackson Filmes', 0, 152, 95, '2003-04-14');
INSERT INTO public.plataforma VALUES (752, 'Machado Moura S/A Portal', 0, 765, 383, '2021-07-11');
INSERT INTO public.plataforma VALUES (753, 'Aragão Viana e Filhos Spot', 0, 623, 771, '2012-09-04');
INSERT INTO public.plataforma VALUES (754, 'da Cunha e Filhos Premium', 0, 105, 264, '1990-08-21');
INSERT INTO public.plataforma VALUES (755, 'Machado Sales S.A. Atlas', 0, 102, 186, '1997-10-08');
INSERT INTO public.plataforma VALUES (756, 'Nogueira Macedo S.A. LoopTV', 0, 402, 280, '2025-08-07');
INSERT INTO public.plataforma VALUES (757, 'Cassiano Ltda. Access', 0, 642, 438, '1990-10-05');
INSERT INTO public.plataforma VALUES (758, 'Romero, Hart and Williams Stage', 0, 701, 533, '2023-01-27');
INSERT INTO public.plataforma VALUES (759, 'Bartlett-Melton Ritmo', 0, 665, 630, '1999-01-11');
INSERT INTO public.plataforma VALUES (760, 'Barnes-Hutchinson LoopTV', 0, 134, 430, '1997-09-20');
INSERT INTO public.plataforma VALUES (761, 'Novais Silva S.A. Highlights', 0, 793, 190, '2025-09-30');
INSERT INTO public.plataforma VALUES (762, 'Machado Teixeira e Filhos Fila', 0, 398, 97, '1993-05-29');
INSERT INTO public.plataforma VALUES (763, 'Souza da Rosa S.A. Box', 0, 787, 266, '2000-05-26');
INSERT INTO public.plataforma VALUES (764, 'Novaes Cirino S.A. Canal', 0, 83, 199, '1997-04-05');
INSERT INTO public.plataforma VALUES (765, 'Bowers and Sons Vault', 0, 617, 70, '1997-10-17');
INSERT INTO public.plataforma VALUES (766, 'da Conceição Porto S.A. Queue', 0, 29, 124, '2012-07-28');
INSERT INTO public.plataforma VALUES (767, 'Jones, Foster and Nelson Direct', 0, 959, 830, '1991-01-16');
INSERT INTO public.plataforma VALUES (768, 'Bailey, Wilson and Jones Library', 0, 746, 366, '2012-08-19');
INSERT INTO public.plataforma VALUES (769, 'Burton, Green and Briggs Sincroniza', 0, 855, 214, '2005-03-04');
INSERT INTO public.plataforma VALUES (770, 'Peixoto Moura e Filhos Fluxo', 0, 10, 317, '2013-06-29');
INSERT INTO public.plataforma VALUES (771, 'Moraes Moura S/A Wave', 0, 369, 338, '2000-07-14');
INSERT INTO public.plataforma VALUES (772, 'da Rosa S.A. Plus', 0, 416, 919, '2012-03-26');
INSERT INTO public.plataforma VALUES (773, 'Farias S/A Box', 0, 557, 222, '1993-08-22');
INSERT INTO public.plataforma VALUES (774, 'Gomes - ME Direct', 0, 569, 691, '2021-03-22');
INSERT INTO public.plataforma VALUES (775, 'Cunha Souza - EI Edge', 0, 6, 780, '2023-08-16');
INSERT INTO public.plataforma VALUES (776, 'Borges da Luz S.A. Ritmo', 0, 117, 641, '2025-07-07');
INSERT INTO public.plataforma VALUES (777, 'Moraes S.A. Equipe', 0, 243, 125, '1990-09-08');
INSERT INTO public.plataforma VALUES (778, 'Cassiano Pereira S.A. Ritmo', 0, 896, 149, '2005-02-19');
INSERT INTO public.plataforma VALUES (779, 'Dias Aparecida S.A. Palco', 0, 918, 650, '2016-03-09');
INSERT INTO public.plataforma VALUES (780, 'da Cruz Campos S/A Fluxo', 0, 553, 734, '2019-10-30');
INSERT INTO public.plataforma VALUES (781, 'Pires Camargo S.A. PocketTV', 0, 544, 988, '2020-11-03');
INSERT INTO public.plataforma VALUES (782, 'Almeida Cassiano S.A. Box', 0, 11, 351, '1990-01-24');
INSERT INTO public.plataforma VALUES (783, 'Pires Almeida S/A Navigator', 0, 186, 606, '1992-03-07');
INSERT INTO public.plataforma VALUES (784, 'Almeida - EI Replay', 0, 486, 333, '1993-05-24');
INSERT INTO public.plataforma VALUES (785, 'Perkins-Daniel Worlds', 0, 352, 604, '1999-05-11');
INSERT INTO public.plataforma VALUES (786, 'Morrison Group Hub', 0, 554, 610, '1990-04-04');
INSERT INTO public.plataforma VALUES (787, 'Barros da Costa Ltda. Collective', 0, 37, 398, '1998-10-05');
INSERT INTO public.plataforma VALUES (788, 'Pimenta Farias S/A Direct', 0, 91, 448, '2008-02-11');
INSERT INTO public.plataforma VALUES (789, 'Pineda, Jackson and Robinson Streamers', 0, 417, 30, '2017-05-11');
INSERT INTO public.plataforma VALUES (790, 'Rivas-Phillips Broadcast', 0, 340, 854, '1996-10-25');
INSERT INTO public.plataforma VALUES (791, 'Goodman LLC NextGen', 0, 46, 659, '2002-10-27');
INSERT INTO public.plataforma VALUES (792, 'Mendonça da Luz Ltda. Scene', 0, 244, 334, '2014-02-06');
INSERT INTO public.plataforma VALUES (793, 'Smith-Navarro Universal', 0, 55, 987, '1993-08-17');
INSERT INTO public.plataforma VALUES (794, 'da Mota Caldeira S/A Explorer', 0, 119, 419, '2007-08-06');
INSERT INTO public.plataforma VALUES (795, 'Cassiano - ME Box', 0, 617, 467, '1991-05-09');
INSERT INTO public.plataforma VALUES (796, 'Barros Almeida S/A Collective+', 0, 485, 223, '1992-10-12');
INSERT INTO public.plataforma VALUES (797, 'Marques - EI Crew', 0, 818, 501, '2007-06-29');
INSERT INTO public.plataforma VALUES (798, 'Hansen-Lewis Lineup', 0, 275, 605, '2019-01-11');
INSERT INTO public.plataforma VALUES (799, 'Cooper-Williams Connect+', 0, 483, 338, '2000-11-04');
INSERT INTO public.plataforma VALUES (800, 'Sales Teixeira - EI Queue', 0, 568, 83, '1997-11-19');
INSERT INTO public.plataforma VALUES (801, 'Garcia-Logan Cinema', 0, 151, 524, '2007-05-12');
INSERT INTO public.plataforma VALUES (802, 'Novais Andrade - ME Beat', 0, 844, 111, '2013-01-19');
INSERT INTO public.plataforma VALUES (803, 'Reed, Williams and Burke Exclusivo', 0, 311, 997, '2010-11-24');
INSERT INTO public.plataforma VALUES (804, 'Spencer, Church and Morse Pod', 0, 274, 498, '2023-02-11');
INSERT INTO public.plataforma VALUES (805, 'Conrad-Lynch Streamline', 0, 524, 626, '2012-12-15');
INSERT INTO public.plataforma VALUES (806, 'Johnson, Woods and Riley Aqui', 0, 265, 466, '2014-12-25');
INSERT INTO public.plataforma VALUES (807, 'Barbosa Barros - ME Portal', 0, 98, 701, '1998-03-31');
INSERT INTO public.plataforma VALUES (808, 'Potter-Gallegos AoVivo', 0, 23, 320, '2005-12-29');
INSERT INTO public.plataforma VALUES (809, 'Pope-Ford Next', 0, 682, 678, '2011-10-10');
INSERT INTO public.plataforma VALUES (810, 'Cassiano Fogaça S/A Stage', 0, 770, 470, '1991-10-01');
INSERT INTO public.plataforma VALUES (811, 'Andrade Barbosa S/A Filmes', 0, 151, 703, '1999-05-22');
INSERT INTO public.plataforma VALUES (812, 'Lopez, Washington and Newman Collective+', 0, 599, 63, '2003-11-25');
INSERT INTO public.plataforma VALUES (813, 'Mendonça Farias - EI Box', 0, 185, 301, '2009-03-15');
INSERT INTO public.plataforma VALUES (814, 'Robinson, Moreno and Jackson Ritmo', 0, 385, 1, '1994-12-17');
INSERT INTO public.plataforma VALUES (815, 'Moura Sampaio - ME Air', 0, 104, 603, '2009-03-21');
INSERT INTO public.plataforma VALUES (816, 'Gonzalez LLC Exclusive', 0, 66, 564, '2015-12-01');
INSERT INTO public.plataforma VALUES (817, 'Johnson-Ibarra Pass', 0, 882, 628, '2019-02-14');
INSERT INTO public.plataforma VALUES (818, 'Garcia-Moore Studios', 0, 165, 289, '2009-05-22');
INSERT INTO public.plataforma VALUES (819, 'Campos Oliveira S.A. Flow', 0, 165, 334, '2004-12-17');
INSERT INTO public.plataforma VALUES (820, 'Arnold-Yang Cinema', 0, 250, 550, '2014-01-11');
INSERT INTO public.plataforma VALUES (821, 'Neal, Cooper and Lopez Mini', 0, 176, 956, '2001-07-18');
INSERT INTO public.plataforma VALUES (822, 'Moore Ltd Universo', 0, 991, 772, '2002-10-08');
INSERT INTO public.plataforma VALUES (823, 'Gomes Melo - ME PlayLab', 0, 597, 764, '1996-05-30');
INSERT INTO public.plataforma VALUES (824, 'Sales Novais S/A Replay', 0, 744, 275, '1994-12-25');
INSERT INTO public.plataforma VALUES (825, 'Lindsey-Mcneil Pass', 0, 707, 315, '1999-01-20');
INSERT INTO public.plataforma VALUES (826, 'Duarte - EI Groove', 0, 411, 749, '2004-08-22');
INSERT INTO public.plataforma VALUES (827, 'Ferreira Melo Ltda. Wave', 0, 884, 816, '2006-02-14');
INSERT INTO public.plataforma VALUES (828, 'Novais e Filhos Explorer', 0, 622, 430, '2016-05-08');
INSERT INTO public.plataforma VALUES (829, 'Combs, Martinez and Robinson Stage', 0, 588, 865, '2021-08-15');
INSERT INTO public.plataforma VALUES (830, 'Siqueira Oliveira - EI Premium', 0, 145, 867, '2008-10-05');
INSERT INTO public.plataforma VALUES (831, 'Barnes-Norris Studio', 0, 408, 915, '1996-05-11');
INSERT INTO public.plataforma VALUES (832, 'Monteiro Pastor - ME Mini', 0, 668, 146, '1993-05-26');
INSERT INTO public.plataforma VALUES (833, 'Holland, Tanner and Wright Crew', 0, 272, 770, '1994-01-17');
INSERT INTO public.plataforma VALUES (834, 'Thornton-Garcia Collective', 0, 340, 554, '2005-02-08');
INSERT INTO public.plataforma VALUES (835, 'Donovan, Haney and Gentry Worlds', 0, 634, 195, '2024-09-19');
INSERT INTO public.plataforma VALUES (836, 'Costela Pereira - EI Palco', 0, 67, 727, '2015-07-08');
INSERT INTO public.plataforma VALUES (837, 'Whitney-Jones Streamers', 0, 660, 62, '1995-09-30');
INSERT INTO public.plataforma VALUES (838, 'Curry-Griffin Live+', 0, 377, 291, '2018-06-21');
INSERT INTO public.plataforma VALUES (839, 'Clark, Cameron and Guerrero Play', 0, 260, 722, '2000-04-03');
INSERT INTO public.plataforma VALUES (840, 'Payne-Hebert Exclusive', 0, 380, 559, '2017-06-21');
INSERT INTO public.plataforma VALUES (841, 'Fox, Riley and Butler NextGen', 0, 116, 857, '2008-03-20');
INSERT INTO public.plataforma VALUES (842, 'Burns-Ruiz Atlas', 0, 963, 109, '2020-10-08');
INSERT INTO public.plataforma VALUES (843, 'Mendes Pires S.A. Schedule', 0, 215, 914, '2020-01-30');
INSERT INTO public.plataforma VALUES (844, 'Pires Abreu Ltda. Entrada', 0, 123, 905, '1994-01-10');
INSERT INTO public.plataforma VALUES (845, 'Carvalho Souza e Filhos Exclusivo', 0, 195, 464, '2003-03-21');
INSERT INTO public.plataforma VALUES (846, 'Carter-Atkins Ir', 0, 332, 967, '2025-07-20');
INSERT INTO public.plataforma VALUES (847, 'Evans, Lopez and Hill CinePlus', 0, 580, 793, '1999-07-28');
INSERT INTO public.plataforma VALUES (848, 'da Mota Gonçalves - ME Universo', 0, 250, 122, '1993-12-09');
INSERT INTO public.plataforma VALUES (849, 'Marques Carvalho - ME Explorer', 0, 642, 841, '2022-05-14');
INSERT INTO public.plataforma VALUES (850, 'Casa Grande Leão e Filhos Plataforma', 0, 659, 377, '2014-12-14');
INSERT INTO public.plataforma VALUES (851, 'Andrade Nunes e Filhos CinePlus', 0, 205, 827, '2022-04-02');
INSERT INTO public.plataforma VALUES (852, 'Alvarez, Davis and Stone Gate', 0, 771, 564, '2018-07-15');
INSERT INTO public.plataforma VALUES (853, 'Sampaio Vasconcelos S/A Now+', 0, 346, 675, '1998-08-22');
INSERT INTO public.plataforma VALUES (854, 'Rodrigues da Costa - EI Aqui', 0, 77, 414, '2020-02-17');
INSERT INTO public.plataforma VALUES (855, 'da Costa Borges - EI Universal', 0, 226, 887, '1994-10-20');
INSERT INTO public.plataforma VALUES (856, 'Brown, Delacruz and Taylor LoopTV', 0, 844, 982, '2021-06-04');
INSERT INTO public.plataforma VALUES (857, 'Christensen, Figueroa and Stewart Select', 0, 303, 959, '2012-05-29');
INSERT INTO public.plataforma VALUES (858, 'Morgan, Maxwell and Wood Cast', 0, 450, 570, '2003-05-16');
INSERT INTO public.plataforma VALUES (859, 'Powell, Harper and Lin Cinema', 0, 771, 128, '2025-04-24');
INSERT INTO public.plataforma VALUES (860, 'Silveira Novais S/A PlayLab', 0, 178, 441, '2002-12-01');
INSERT INTO public.plataforma VALUES (861, 'Ruiz-Ortega Cinema', 0, 222, 422, '2010-05-03');
INSERT INTO public.plataforma VALUES (862, 'Hall, Sutton and Wells Streamers', 0, 664, 802, '1993-02-18');
INSERT INTO public.plataforma VALUES (863, 'Moreira Pimenta S/A Universal', 0, 542, 92, '2011-02-09');
INSERT INTO public.plataforma VALUES (864, 'Grant, King and Rasmussen Streamline', 0, 377, 117, '2019-09-28');
INSERT INTO public.plataforma VALUES (865, 'Taylor-Espinoza OnRepeat', 0, 879, 214, '2021-11-30');
INSERT INTO public.plataforma VALUES (866, 'Cirino Aparecida Ltda. Now+', 0, 447, 240, '2011-09-01');
INSERT INTO public.plataforma VALUES (867, 'Cirino Novais - ME CinePlus', 0, 904, 84, '2016-08-23');
INSERT INTO public.plataforma VALUES (868, 'Câmara Cassiano S/A Loop', 0, 47, 49, '1996-05-08');
INSERT INTO public.plataforma VALUES (869, 'Santos Macedo - EI Ponto', 0, 536, 655, '2017-09-20');
INSERT INTO public.plataforma VALUES (870, 'Marques e Filhos Onda', 0, 624, 868, '1994-08-27');
INSERT INTO public.plataforma VALUES (871, 'Silveira Rodrigues e Filhos On', 0, 741, 440, '2015-12-28');
INSERT INTO public.plataforma VALUES (872, 'Rios Freitas S/A Verse', 0, 2, 168, '2001-01-16');
INSERT INTO public.plataforma VALUES (873, 'Mccann-King Universe', 0, 388, 565, '2023-12-17');
INSERT INTO public.plataforma VALUES (874, 'Lima Pinto S/A Prime', 0, 941, 191, '1998-03-02');
INSERT INTO public.plataforma VALUES (875, 'Machado Montenegro - EI Sync', 0, 187, 333, '2011-02-25');
INSERT INTO public.plataforma VALUES (876, 'Souza e Filhos Queue', 0, 358, 203, '1996-07-09');
INSERT INTO public.plataforma VALUES (877, 'Ramos da Luz S/A Queue', 0, 130, 279, '1998-07-14');
INSERT INTO public.plataforma VALUES (878, 'Davis Inc Metaverse', 0, 639, 202, '1993-10-08');
INSERT INTO public.plataforma VALUES (879, 'Brock, Summers and Hill Replay', 0, 326, 12, '2013-03-17');
INSERT INTO public.plataforma VALUES (880, 'Rocha Cavalcanti S.A. Next', 0, 485, 646, '2013-12-21');
INSERT INTO public.plataforma VALUES (881, 'Lima Aparecida e Filhos Realm', 0, 311, 233, '2004-07-25');
INSERT INTO public.plataforma VALUES (882, 'Campos Freitas S/A Beat', 0, 729, 849, '2001-09-30');
INSERT INTO public.plataforma VALUES (883, 'Leon-Adams Spotlight', 0, 557, 190, '2010-08-12');
INSERT INTO public.plataforma VALUES (884, 'Moreno Ltd Collection', 0, 270, 952, '2003-09-24');
INSERT INTO public.plataforma VALUES (885, 'Allen PLC Network', 0, 113, 648, '2024-07-01');
INSERT INTO public.plataforma VALUES (886, 'Oliveira Campos - EI Verse', 0, 135, 25, '1990-12-08');
INSERT INTO public.plataforma VALUES (887, 'Roberts and Sons Palco', 0, 360, 284, '2022-10-30');
INSERT INTO public.plataforma VALUES (888, 'Cole-Collins Collective', 0, 318, 651, '2014-09-01');
INSERT INTO public.plataforma VALUES (889, 'Sales da Rosa Ltda. Air', 0, 127, 613, '2007-02-16');
INSERT INTO public.plataforma VALUES (890, 'Cirino Marques S/A Ponto', 0, 582, 678, '2020-04-01');
INSERT INTO public.plataforma VALUES (891, 'Carter PLC Gate', 0, 157, 388, '2010-02-20');
INSERT INTO public.plataforma VALUES (892, 'Aragão Sales S/A AoVivo', 0, 12, 589, '2008-09-23');
INSERT INTO public.plataforma VALUES (893, 'Sheppard-Sharp Hub', 0, 786, 653, '1991-10-09');
INSERT INTO public.plataforma VALUES (894, 'Obrien, Garcia and Wallace Prime', 0, 334, 479, '1993-02-09');
INSERT INTO public.plataforma VALUES (895, 'Macedo da Paz - EI Reels', 0, 477, 536, '2010-06-11');
INSERT INTO public.plataforma VALUES (896, 'Carey-Benjamin Playground', 0, 238, 290, '2006-12-02');
INSERT INTO public.plataforma VALUES (897, 'Anderson and Sons Transmit', 0, 180, 826, '2024-01-10');
INSERT INTO public.plataforma VALUES (898, 'Holland-Ponce Mais', 0, 139, 472, '1995-09-21');
INSERT INTO public.plataforma VALUES (899, 'Dias - EI Schedule', 0, 704, 407, '2016-09-06');
INSERT INTO public.plataforma VALUES (900, 'das Neves da Cunha S/A Universo', 0, 97, 205, '2017-06-19');
INSERT INTO public.plataforma VALUES (901, 'Becker-Duncan Direct', 0, 806, 731, '2016-05-19');
INSERT INTO public.plataforma VALUES (902, 'Key, Cunningham and Daniels Now+', 0, 208, 802, '2017-09-16');
INSERT INTO public.plataforma VALUES (903, 'Brown-Diaz Plus', 0, 994, 823, '1994-07-13');
INSERT INTO public.plataforma VALUES (904, 'Davis, Morgan and Smith Reel', 0, 597, 574, '1998-01-14');
INSERT INTO public.plataforma VALUES (905, 'Reynolds, Levy and Soto LiveStream', 0, 735, 242, '1993-06-15');
INSERT INTO public.plataforma VALUES (906, 'Leblanc-Barnes Plus', 0, 895, 620, '2000-05-13');
INSERT INTO public.plataforma VALUES (907, 'Collins, Marshall and Lara Palco', 0, 879, 186, '1995-09-26');
INSERT INTO public.plataforma VALUES (908, 'Parsons-Martin Pro', 0, 196, 776, '2022-09-03');
INSERT INTO public.plataforma VALUES (909, 'Gonzalez-Barr Connect+', 0, 930, 487, '2010-10-18');
INSERT INTO public.plataforma VALUES (910, 'Rezende Araújo e Filhos Shows', 0, 335, 573, '1990-05-24');
INSERT INTO public.plataforma VALUES (911, 'Franklin Ltd Prime', 0, 182, 142, '1998-02-18');
INSERT INTO public.plataforma VALUES (912, 'Sanders Ltd Future', 0, 49, 190, '1992-04-24');
INSERT INTO public.plataforma VALUES (913, 'Parker-Kim HoraNobre', 0, 937, 185, '1993-03-02');
INSERT INTO public.plataforma VALUES (914, 'Cavalcante Machado Ltda. Loop', 0, 692, 228, '1991-10-25');
INSERT INTO public.plataforma VALUES (915, 'Jesus e Filhos Loop', 0, 876, 686, '1999-02-04');
INSERT INTO public.plataforma VALUES (916, 'Cruz and Sons Portal', 0, 331, 399, '2012-01-12');
INSERT INTO public.plataforma VALUES (917, 'Novais S/A PrimeTime', 0, 428, 372, '2009-01-15');
INSERT INTO public.plataforma VALUES (918, 'Pacheco Ltda. Entrada', 0, 909, 134, '1994-11-25');
INSERT INTO public.plataforma VALUES (919, 'Borges Vieira - EI Studio', 0, 266, 919, '2020-12-10');
INSERT INTO public.plataforma VALUES (920, 'Green-Hill Broadcast', 0, 662, 503, '1991-04-12');
INSERT INTO public.plataforma VALUES (921, 'Miller-Simmons AoVivo', 0, 744, 368, '2019-11-19');
INSERT INTO public.plataforma VALUES (922, 'Vang-Ellison Ir', 0, 562, 82, '2022-10-23');
INSERT INTO public.plataforma VALUES (923, 'da Mota Vargas - EI Studios', 0, 591, 636, '2011-02-28');
INSERT INTO public.plataforma VALUES (924, 'da Cunha Rezende S.A. Direct', 0, 364, 318, '2019-02-20');
INSERT INTO public.plataforma VALUES (925, 'Albuquerque Monteiro e Filhos Arquivo', 0, 655, 694, '2000-02-14');
INSERT INTO public.plataforma VALUES (926, 'White-Nguyen Scene', 0, 954, 204, '2010-01-14');
INSERT INTO public.plataforma VALUES (927, 'Casa Grande da Cunha e Filhos Studio', 0, 108, 925, '1991-10-27');
INSERT INTO public.plataforma VALUES (928, 'Costa - EI Loop', 0, 743, 294, '2007-01-08');
INSERT INTO public.plataforma VALUES (929, 'Teixeira Rocha e Filhos Pocket', 0, 867, 755, '2004-09-07');
INSERT INTO public.plataforma VALUES (930, 'Cirino - EI Channel', 0, 539, 15, '2009-03-02');
INSERT INTO public.plataforma VALUES (931, 'Barnes Group Vibe', 0, 216, 519, '2010-02-19');
INSERT INTO public.plataforma VALUES (932, 'Benton-Washington Navigator', 0, 231, 526, '2021-05-27');
INSERT INTO public.plataforma VALUES (933, 'Caldeira Cassiano S.A. Network', 0, 474, 971, '1995-03-27');
INSERT INTO public.plataforma VALUES (934, 'Grant Group LoopTV', 0, 179, 751, '2023-10-24');
INSERT INTO public.plataforma VALUES (935, 'Khan, Luna and Crosby Reel', 0, 214, 875, '2012-08-19');
INSERT INTO public.plataforma VALUES (936, 'da Mata S/A PlayLab', 0, 673, 858, '2006-09-13');
INSERT INTO public.plataforma VALUES (937, 'Caldwell, Brooks and Arellano Live', 0, 486, 556, '2018-09-22');
INSERT INTO public.plataforma VALUES (938, 'Almeida Machado S/A Ritmo', 0, 812, 55, '2024-11-21');
INSERT INTO public.plataforma VALUES (939, 'Castaneda-King Prime', 0, 770, 649, '2025-07-05');
INSERT INTO public.plataforma VALUES (940, 'Silva - ME Loop', 0, 28, 532, '1999-12-07');
INSERT INTO public.plataforma VALUES (941, 'Brown-Jones Live+', 0, 285, 506, '2020-02-01');
INSERT INTO public.plataforma VALUES (942, 'Pastor S.A. Wave', 0, 991, 345, '2022-09-04');
INSERT INTO public.plataforma VALUES (943, 'Barros - ME Hub', 0, 757, 637, '2000-10-04');
INSERT INTO public.plataforma VALUES (944, 'Rezende Moreira Ltda. Ritmo', 0, 208, 490, '1990-06-06');
INSERT INTO public.plataforma VALUES (945, 'Walsh, Campbell and Martin Network', 0, 100, 750, '2021-09-21');
INSERT INTO public.plataforma VALUES (946, 'Jennings-Davis Mini', 0, 948, 962, '1991-12-10');
INSERT INTO public.plataforma VALUES (947, 'Guerra Silveira - ME Live+', 0, 315, 789, '1996-08-08');
INSERT INTO public.plataforma VALUES (948, 'Parker Ltd Live+', 0, 764, 291, '2008-08-22');
INSERT INTO public.plataforma VALUES (949, 'Silva das Neves e Filhos Plus', 0, 151, 609, '1995-07-21');
INSERT INTO public.plataforma VALUES (950, 'Cardoso Marques - EI Replay', 0, 20, 697, '1990-05-10');
INSERT INTO public.plataforma VALUES (951, 'Romero LLC Showcase', 0, 784, 383, '2025-08-08');
INSERT INTO public.plataforma VALUES (952, 'Franco, Stevens and Shepherd Loop', 0, 597, 173, '1995-08-14');
INSERT INTO public.plataforma VALUES (953, 'Monteiro S/A CinePlus', 0, 150, 882, '2025-01-16');
INSERT INTO public.plataforma VALUES (954, 'Rios Fernandes - EI Agora+', 0, 93, 357, '2002-07-16');
INSERT INTO public.plataforma VALUES (955, 'Rocha, Lam and Morales Transmit', 0, 661, 449, '2000-10-11');
INSERT INTO public.plataforma VALUES (956, 'Lima S.A. Pro', 0, 229, 48, '2025-03-12');
INSERT INTO public.plataforma VALUES (957, 'Costa Cardoso - ME Atlas', 0, 492, 754, '2025-08-28');
INSERT INTO public.plataforma VALUES (958, 'Rios Leão S.A. PlayLab', 0, 159, 695, '2023-11-15');
INSERT INTO public.plataforma VALUES (959, 'Oliveira S/A Shows', 0, 878, 739, '2011-09-02');
INSERT INTO public.plataforma VALUES (960, 'Martinez-White Playground', 0, 845, 624, '2019-02-18');
INSERT INTO public.plataforma VALUES (961, 'Ortega-Grant Reels', 0, 69, 781, '2023-02-08');
INSERT INTO public.plataforma VALUES (962, 'Powell, Rogers and Ponce Live', 0, 721, 129, '2012-08-26');
INSERT INTO public.plataforma VALUES (963, 'Franco-Trevino Highlights', 0, 737, 703, '2022-06-22');
INSERT INTO public.plataforma VALUES (964, 'Sales Azevedo Ltda. Universe', 0, 202, 914, '2013-02-21');
INSERT INTO public.plataforma VALUES (965, 'Newton-Bradford Connect', 0, 410, 301, '2025-03-12');
INSERT INTO public.plataforma VALUES (966, 'Santos Sampaio - ME Loop', 0, 807, 552, '2023-01-17');
INSERT INTO public.plataforma VALUES (967, 'Ribeiro Rodrigues - ME Exclusive', 0, 878, 716, '1993-11-21');
INSERT INTO public.plataforma VALUES (968, 'Bell-Black On', 0, 356, 675, '1998-09-06');
INSERT INTO public.plataforma VALUES (969, 'Nogueira S.A. Shows', 0, 30, 568, '1998-10-03');
INSERT INTO public.plataforma VALUES (970, 'Martins da Luz S/A Spot', 0, 931, 543, '2020-01-01');
INSERT INTO public.plataforma VALUES (971, 'Mendonça e Filhos Ir', 0, 537, 847, '2008-06-28');
INSERT INTO public.plataforma VALUES (972, 'Duarte Lopes Ltda. NextGen', 0, 248, 10, '2019-09-30');
INSERT INTO public.plataforma VALUES (973, 'Freeman-Ortiz Flix', 0, 804, 363, '2004-08-19');
INSERT INTO public.plataforma VALUES (974, 'Sanders-Vazquez Reel', 0, 129, 22, '2011-10-23');
INSERT INTO public.plataforma VALUES (975, 'Machado S.A. NextGen', 0, 188, 982, '1994-05-30');
INSERT INTO public.plataforma VALUES (976, 'Costa Gonçalves - ME Stage', 0, 441, 199, '2001-04-05');
INSERT INTO public.plataforma VALUES (977, 'Ryan Inc Cinema', 0, 228, 183, '1990-01-10');
INSERT INTO public.plataforma VALUES (978, 'Chapman, Fitzpatrick and Castro Edge', 0, 280, 107, '1999-03-15');
INSERT INTO public.plataforma VALUES (979, 'Guerra Sá e Filhos Access+', 0, 516, 879, '1992-03-15');
INSERT INTO public.plataforma VALUES (980, 'Lopes da Rosa - EI Lite', 0, 828, 514, '1997-02-08');
INSERT INTO public.plataforma VALUES (981, 'Kelly-Simon LoopTV', 0, 49, 722, '1996-08-07');
INSERT INTO public.plataforma VALUES (982, 'Whitaker-Nunez Loop', 0, 954, 804, '2011-05-09');
INSERT INTO public.plataforma VALUES (983, 'Barros Mendonça e Filhos Connect+', 0, 814, 932, '1992-09-03');
INSERT INTO public.plataforma VALUES (984, 'Vasconcelos Pastor S/A Vibe', 0, 5, 155, '1997-08-04');
INSERT INTO public.plataforma VALUES (985, 'Gallegos Group Groove', 0, 612, 635, '2019-10-20');
INSERT INTO public.plataforma VALUES (986, 'Walsh, Escobar and Murphy PlayLab', 0, 381, 527, '2019-11-23');
INSERT INTO public.plataforma VALUES (987, 'Park, Stewart and Johnson Wave', 0, 37, 88, '2019-06-28');
INSERT INTO public.plataforma VALUES (988, 'Allen-Phillips Direct', 0, 958, 535, '2022-12-03');
INSERT INTO public.plataforma VALUES (989, 'Lewis and Sons Radio', 0, 88, 467, '2000-11-18');
INSERT INTO public.plataforma VALUES (990, 'Dawson, Barnes and Crosby Stream', 0, 401, 652, '2015-12-18');
INSERT INTO public.plataforma VALUES (991, 'Dean, Webb and Hobbs Queue', 0, 768, 596, '2007-08-07');
INSERT INTO public.plataforma VALUES (992, 'Elliott LLC Ritmo', 0, 697, 334, '2007-08-25');
INSERT INTO public.plataforma VALUES (993, 'Dias das Neves Ltda. PocketTV', 0, 750, 157, '1998-11-01');
INSERT INTO public.plataforma VALUES (994, 'Melo Nunes S/A LiveStream', 0, 216, 670, '2003-11-19');
INSERT INTO public.plataforma VALUES (995, 'Rezende da Mota - EI Universal', 0, 296, 977, '1997-09-29');
INSERT INTO public.plataforma VALUES (996, 'Wise, Gallagher and Taylor Highlights', 0, 163, 808, '2012-12-26');
INSERT INTO public.plataforma VALUES (997, 'Navarro, Bennett and Manning Universal', 0, 477, 858, '1995-07-17');
INSERT INTO public.plataforma VALUES (998, 'Cardoso Nunes Ltda. Network', 0, 309, 473, '2024-06-29');
INSERT INTO public.plataforma VALUES (999, 'George Ltd Sincroniza', 0, 17, 944, '1998-06-01');
INSERT INTO public.plataforma VALUES (1000, 'Kim-Simpson Future', 0, 328, 460, '1991-07-03');


--
-- TOC entry 5278 (class 0 OID 16607)
-- Dependencies: 264
-- Data for Name: plataforma_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5281 (class 0 OID 16617)
-- Dependencies: 267
-- Data for Name: streamer_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5282 (class 0 OID 16625)
-- Dependencies: 268
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5283 (class 0 OID 16636)
-- Dependencies: 269
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5328 (class 0 OID 0)
-- Dependencies: 220
-- Name: bitcoin_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_nro_plataforma_seq', 1, false);


--
-- TOC entry 5329 (class 0 OID 0)
-- Dependencies: 221
-- Name: bitcoin_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_seq_comentario_seq', 1, false);


--
-- TOC entry 5330 (class 0 OID 0)
-- Dependencies: 222
-- Name: bitcoin_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_seq_doacao_seq', 1, false);


--
-- TOC entry 5331 (class 0 OID 0)
-- Dependencies: 224
-- Name: canal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.canal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5332 (class 0 OID 0)
-- Dependencies: 226
-- Name: cartao_credito_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_nro_plataforma_seq', 1, false);


--
-- TOC entry 5333 (class 0 OID 0)
-- Dependencies: 227
-- Name: cartao_credito_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_seq_comentario_seq', 1, false);


--
-- TOC entry 5334 (class 0 OID 0)
-- Dependencies: 228
-- Name: cartao_credito_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_seq_doacao_seq', 1, false);


--
-- TOC entry 5335 (class 0 OID 0)
-- Dependencies: 230
-- Name: comentario_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_nro_plataforma_seq', 1, false);


--
-- TOC entry 5336 (class 0 OID 0)
-- Dependencies: 231
-- Name: comentario_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_seq_seq', 1, false);


--
-- TOC entry 5337 (class 0 OID 0)
-- Dependencies: 234
-- Name: doacao_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_nro_plataforma_seq', 1, false);


--
-- TOC entry 5338 (class 0 OID 0)
-- Dependencies: 235
-- Name: doacao_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_seq_comentario_seq', 1, false);


--
-- TOC entry 5339 (class 0 OID 0)
-- Dependencies: 236
-- Name: doacao_seq_pg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_seq_pg_seq', 1, false);


--
-- TOC entry 5340 (class 0 OID 0)
-- Dependencies: 238
-- Name: empresa_nro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_nro_seq', 1, false);


--
-- TOC entry 5341 (class 0 OID 0)
-- Dependencies: 240
-- Name: empresa_pais_nro_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_pais_nro_empresa_seq', 1, false);


--
-- TOC entry 5342 (class 0 OID 0)
-- Dependencies: 242
-- Name: inscricao_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscricao_nro_plataforma_seq', 1, false);


--
-- TOC entry 5343 (class 0 OID 0)
-- Dependencies: 244
-- Name: mecanismo_plat_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_nro_plataforma_seq', 1, false);


--
-- TOC entry 5344 (class 0 OID 0)
-- Dependencies: 245
-- Name: mecanismo_plat_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_comentario_seq', 1, false);


--
-- TOC entry 5345 (class 0 OID 0)
-- Dependencies: 246
-- Name: mecanismo_plat_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_doacao_seq', 1, false);


--
-- TOC entry 5346 (class 0 OID 0)
-- Dependencies: 247
-- Name: mecanismo_plat_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_seq', 1, false);


--
-- TOC entry 5347 (class 0 OID 0)
-- Dependencies: 249
-- Name: nivel_canal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nivel_canal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5348 (class 0 OID 0)
-- Dependencies: 252
-- Name: participa_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participa_nro_plataforma_seq', 1, false);


--
-- TOC entry 5349 (class 0 OID 0)
-- Dependencies: 254
-- Name: patrocinio_nro_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patrocinio_nro_empresa_seq', 1, false);


--
-- TOC entry 5350 (class 0 OID 0)
-- Dependencies: 255
-- Name: patrocinio_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patrocinio_nro_plataforma_seq', 1, false);


--
-- TOC entry 5351 (class 0 OID 0)
-- Dependencies: 257
-- Name: paypal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5352 (class 0 OID 0)
-- Dependencies: 258
-- Name: paypal_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_seq_comentario_seq', 1, false);


--
-- TOC entry 5353 (class 0 OID 0)
-- Dependencies: 259
-- Name: paypal_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_seq_doacao_seq', 1, false);


--
-- TOC entry 5354 (class 0 OID 0)
-- Dependencies: 261
-- Name: plataforma_empresa_fund_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_empresa_fund_seq', 1, false);


--
-- TOC entry 5355 (class 0 OID 0)
-- Dependencies: 262
-- Name: plataforma_empresa_respo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_empresa_respo_seq', 1, false);


--
-- TOC entry 5356 (class 0 OID 0)
-- Dependencies: 263
-- Name: plataforma_nro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_nro_seq', 1, false);


--
-- TOC entry 5357 (class 0 OID 0)
-- Dependencies: 265
-- Name: plataforma_usuario_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_usuario_nro_plataforma_seq', 1, false);


--
-- TOC entry 5358 (class 0 OID 0)
-- Dependencies: 266
-- Name: plataforma_usuario_nro_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_usuario_nro_usuario_seq', 1, false);


--
-- TOC entry 5359 (class 0 OID 0)
-- Dependencies: 270
-- Name: video_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.video_nro_plataforma_seq', 1, false);


--
-- TOC entry 5011 (class 2606 OID 16686)
-- Name: bitcoin bitcoin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin
    ADD CONSTRAINT bitcoin_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao);


--
-- TOC entry 5013 (class 2606 OID 16688)
-- Name: bitcoin bitcoin_txid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin
    ADD CONSTRAINT bitcoin_txid_key UNIQUE (txid);


--
-- TOC entry 5015 (class 2606 OID 16690)
-- Name: canal canal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT canal_pkey PRIMARY KEY (nro_plataforma, nome);


--
-- TOC entry 5017 (class 2606 OID 16692)
-- Name: cartao_credito cartao_credito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito
    ADD CONSTRAINT cartao_credito_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao);


--
-- TOC entry 5019 (class 2606 OID 16694)
-- Name: comentario comentario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT comentario_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq);


--
-- TOC entry 5021 (class 2606 OID 16696)
-- Name: conversao conversao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversao
    ADD CONSTRAINT conversao_pkey PRIMARY KEY (moeda);


--
-- TOC entry 5023 (class 2606 OID 16698)
-- Name: doacao doacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao
    ADD CONSTRAINT doacao_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg);


--
-- TOC entry 5027 (class 2606 OID 17681)
-- Name: empresa_pais empresa_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT empresa_pais_pkey PRIMARY KEY (nro_empresa, nome_pais);


--
-- TOC entry 5025 (class 2606 OID 16702)
-- Name: empresa empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (nro);


--
-- TOC entry 5029 (class 2606 OID 16704)
-- Name: inscricao inscricao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT inscricao_pkey PRIMARY KEY (nro_plataforma, nome_canal, nick_membro, nivel);


--
-- TOC entry 5031 (class 2606 OID 16706)
-- Name: mecanismo_plat mecanismo_plat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat
    ADD CONSTRAINT mecanismo_plat_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, seq);


--
-- TOC entry 5033 (class 2606 OID 16708)
-- Name: nivel_canal nivel_canal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_canal
    ADD CONSTRAINT nivel_canal_pkey PRIMARY KEY (nro_plataforma, nome_canal, nivel);


--
-- TOC entry 5035 (class 2606 OID 17661)
-- Name: pais pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (nome);


--
-- TOC entry 5037 (class 2606 OID 16712)
-- Name: participa participa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT participa_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_streamer);


--
-- TOC entry 5039 (class 2606 OID 16714)
-- Name: patrocinio patrocinio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio
    ADD CONSTRAINT patrocinio_pkey PRIMARY KEY (nro_empresa, nro_plataforma, nome_canal);


--
-- TOC entry 5041 (class 2606 OID 16716)
-- Name: paypal paypal_idpaypal_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal
    ADD CONSTRAINT paypal_idpaypal_key UNIQUE (idpaypal);


--
-- TOC entry 5043 (class 2606 OID 16718)
-- Name: paypal paypal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal
    ADD CONSTRAINT paypal_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao);


--
-- TOC entry 5045 (class 2606 OID 16720)
-- Name: plataforma plataforma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT plataforma_pkey PRIMARY KEY (nro);


--
-- TOC entry 5047 (class 2606 OID 16722)
-- Name: plataforma_usuario plataforma_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario
    ADD CONSTRAINT plataforma_usuario_pkey PRIMARY KEY (nro_plataforma, nick_usuario);


--
-- TOC entry 5049 (class 2606 OID 16724)
-- Name: streamer_pais streamer_pais_nro_passaporte_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT streamer_pais_nro_passaporte_key UNIQUE (nro_passaporte);


--
-- TOC entry 5051 (class 2606 OID 17683)
-- Name: streamer_pais streamer_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT streamer_pais_pkey PRIMARY KEY (nick_streamer, nome_pais);


--
-- TOC entry 5053 (class 2606 OID 16728)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 5055 (class 2606 OID 16730)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (nick);


--
-- TOC entry 5057 (class 2606 OID 16732)
-- Name: video video_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo, datah);


--
-- TOC entry 5058 (class 2606 OID 16733)
-- Name: bitcoin fk_bitcoin_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin
    ADD CONSTRAINT fk_bitcoin_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg);


--
-- TOC entry 5059 (class 2606 OID 16738)
-- Name: canal fk_canal_plataforma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT fk_canal_plataforma FOREIGN KEY (nro_plataforma) REFERENCES public.plataforma(nro);


--
-- TOC entry 5060 (class 2606 OID 16743)
-- Name: canal fk_canal_streamer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT fk_canal_streamer FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick);


--
-- TOC entry 5061 (class 2606 OID 16748)
-- Name: cartao_credito fk_cartao_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito
    ADD CONSTRAINT fk_cartao_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg);


--
-- TOC entry 5062 (class 2606 OID 16753)
-- Name: comentario fk_comentario_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_usuario FOREIGN KEY (nick_usuario) REFERENCES public.usuario(nick);


--
-- TOC entry 5063 (class 2606 OID 16758)
-- Name: comentario fk_comentario_video; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_video FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video) REFERENCES public.video(nro_plataforma, nome_canal, titulo, datah);


--
-- TOC entry 5064 (class 2606 OID 16763)
-- Name: doacao fk_doacao_comentario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao
    ADD CONSTRAINT fk_doacao_comentario FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario) REFERENCES public.comentario(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq);


--
-- TOC entry 5065 (class 2606 OID 16768)
-- Name: doacao fk_doacao_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao
    ADD CONSTRAINT fk_doacao_usuario FOREIGN KEY (nick_usuario) REFERENCES public.usuario(nick);


--
-- TOC entry 5066 (class 2606 OID 16773)
-- Name: empresa_pais fk_empresapais_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT fk_empresapais_empresa FOREIGN KEY (nro_empresa) REFERENCES public.empresa(nro);


--
-- TOC entry 5067 (class 2606 OID 17663)
-- Name: empresa_pais fk_empresapais_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT fk_empresapais_pais FOREIGN KEY (nome_pais) REFERENCES public.pais(nome);


--
-- TOC entry 5068 (class 2606 OID 16783)
-- Name: inscricao fk_inscricao_membro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT fk_inscricao_membro FOREIGN KEY (nick_membro) REFERENCES public.usuario(nick);


--
-- TOC entry 5069 (class 2606 OID 16788)
-- Name: inscricao fk_inscricao_nivel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT fk_inscricao_nivel FOREIGN KEY (nro_plataforma, nome_canal, nivel) REFERENCES public.nivel_canal(nro_plataforma, nome_canal, nivel);


--
-- TOC entry 5070 (class 2606 OID 16793)
-- Name: mecanismo_plat fk_mecanismo_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat
    ADD CONSTRAINT fk_mecanismo_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg);


--
-- TOC entry 5071 (class 2606 OID 16798)
-- Name: nivel_canal fk_nivel_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_canal
    ADD CONSTRAINT fk_nivel_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome);


--
-- TOC entry 5072 (class 2606 OID 16803)
-- Name: pais fk_pais_moeda; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT fk_pais_moeda FOREIGN KEY (moeda) REFERENCES public.conversao(moeda);


--
-- TOC entry 5073 (class 2606 OID 16808)
-- Name: participa fk_participa_streamer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_streamer FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick);


--
-- TOC entry 5074 (class 2606 OID 16813)
-- Name: participa fk_participa_video; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_video FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video) REFERENCES public.video(nro_plataforma, nome_canal, titulo, datah);


--
-- TOC entry 5075 (class 2606 OID 16818)
-- Name: patrocinio fk_patrocinio_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio
    ADD CONSTRAINT fk_patrocinio_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome);


--
-- TOC entry 5076 (class 2606 OID 16823)
-- Name: patrocinio fk_patrocinio_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio
    ADD CONSTRAINT fk_patrocinio_empresa FOREIGN KEY (nro_empresa) REFERENCES public.empresa(nro);


--
-- TOC entry 5077 (class 2606 OID 16828)
-- Name: paypal fk_paypal_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal
    ADD CONSTRAINT fk_paypal_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg);


--
-- TOC entry 5078 (class 2606 OID 16833)
-- Name: plataforma fk_plataforma_empresa_fund; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT fk_plataforma_empresa_fund FOREIGN KEY (empresa_fund) REFERENCES public.empresa(nro);


--
-- TOC entry 5079 (class 2606 OID 16838)
-- Name: plataforma fk_plataforma_empresa_respo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT fk_plataforma_empresa_respo FOREIGN KEY (empresa_respo) REFERENCES public.empresa(nro);


--
-- TOC entry 5080 (class 2606 OID 16843)
-- Name: plataforma_usuario fk_plataforma_usuario_plataforma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario
    ADD CONSTRAINT fk_plataforma_usuario_plataforma FOREIGN KEY (nro_plataforma) REFERENCES public.plataforma(nro);


--
-- TOC entry 5081 (class 2606 OID 16848)
-- Name: plataforma_usuario fk_plataforma_usuario_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario
    ADD CONSTRAINT fk_plataforma_usuario_usuario FOREIGN KEY (nick_usuario) REFERENCES public.usuario(nick);


--
-- TOC entry 5082 (class 2606 OID 17675)
-- Name: streamer_pais fk_streamerpais_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT fk_streamerpais_pais FOREIGN KEY (nome_pais) REFERENCES public.pais(nome);


--
-- TOC entry 5083 (class 2606 OID 16858)
-- Name: streamer_pais fk_streamerpais_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT fk_streamerpais_usuario FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick);


--
-- TOC entry 5084 (class 2606 OID 17669)
-- Name: usuario fk_usuario_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_pais FOREIGN KEY (nome_pais_residencia) REFERENCES public.pais(nome);


--
-- TOC entry 5085 (class 2606 OID 16868)
-- Name: video fk_video_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT fk_video_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome);


-- Completed on 2025-10-28 02:23:54

--
-- PostgreSQL database dump complete
--

\unrestrict zK6DGwibaHR7MPu4JMxvwyiXnkXQixbGbuvI8mcXM2rbO6TGThhBGK1Gn8oY3xC
