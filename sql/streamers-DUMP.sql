--
-- PostgreSQL database dump
--

\restrict f2DNUBB3BT6kVy5FBZn4M4RoYzdKQV6V8D9asYjuIR3UVF03kIMUSh3aDQiY26o

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-27 05:31:03

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
-- TOC entry 951 (class 1247 OID 16723)
-- Name: statusdoacao; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.statusdoacao AS ENUM (
    'recusado',
    'recebido',
    'lido'
);


ALTER TYPE public.statusdoacao OWNER TO postgres;

--
-- TOC entry 927 (class 1247 OID 16543)
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
-- TOC entry 257 (class 1259 OID 16765)
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
-- TOC entry 5290 (class 0 OID 0)
-- Dependencies: 257
-- Name: COLUMN bitcoin.txid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.bitcoin.txid IS 'TXID do Bitcoin é uma sequência única de letras e números que identifica cada transação na blockchain do Bitcoin. Ele funciona como um recibo digital e permite rastrear detalhes da transação';


--
-- TOC entry 254 (class 1259 OID 16762)
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
-- TOC entry 5291 (class 0 OID 0)
-- Dependencies: 254
-- Name: bitcoin_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitcoin_nro_plataforma_seq OWNED BY public.bitcoin.nro_plataforma;


--
-- TOC entry 255 (class 1259 OID 16763)
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
-- TOC entry 5292 (class 0 OID 0)
-- Dependencies: 255
-- Name: bitcoin_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitcoin_seq_comentario_seq OWNED BY public.bitcoin.seq_comentario;


--
-- TOC entry 256 (class 1259 OID 16764)
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
-- TOC entry 5293 (class 0 OID 0)
-- Dependencies: 256
-- Name: bitcoin_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitcoin_seq_doacao_seq OWNED BY public.bitcoin.seq_doacao;


--
-- TOC entry 235 (class 1259 OID 16550)
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
-- TOC entry 5294 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN canal.qtd_visualizacoes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.canal.qtd_visualizacoes IS 'Derivado: manter via batch/trigger/ETL';


--
-- TOC entry 234 (class 1259 OID 16549)
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
-- TOC entry 5295 (class 0 OID 0)
-- Dependencies: 234
-- Name: canal_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.canal_nro_plataforma_seq OWNED BY public.canal.nro_plataforma;


--
-- TOC entry 265 (class 1259 OID 16821)
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
-- TOC entry 262 (class 1259 OID 16818)
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
-- TOC entry 5296 (class 0 OID 0)
-- Dependencies: 262
-- Name: cartao_credito_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartao_credito_nro_plataforma_seq OWNED BY public.cartao_credito.nro_plataforma;


--
-- TOC entry 263 (class 1259 OID 16819)
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
-- TOC entry 5297 (class 0 OID 0)
-- Dependencies: 263
-- Name: cartao_credito_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartao_credito_seq_comentario_seq OWNED BY public.cartao_credito.seq_comentario;


--
-- TOC entry 264 (class 1259 OID 16820)
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
-- TOC entry 5298 (class 0 OID 0)
-- Dependencies: 264
-- Name: cartao_credito_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartao_credito_seq_doacao_seq OWNED BY public.cartao_credito.seq_doacao;


--
-- TOC entry 249 (class 1259 OID 16694)
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
-- TOC entry 247 (class 1259 OID 16692)
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
-- TOC entry 5299 (class 0 OID 0)
-- Dependencies: 247
-- Name: comentario_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentario_nro_plataforma_seq OWNED BY public.comentario.nro_plataforma;


--
-- TOC entry 248 (class 1259 OID 16693)
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
-- TOC entry 5300 (class 0 OID 0)
-- Dependencies: 248
-- Name: comentario_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentario_seq_seq OWNED BY public.comentario.seq;


--
-- TOC entry 225 (class 1259 OID 16429)
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
-- TOC entry 253 (class 1259 OID 16732)
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
-- TOC entry 250 (class 1259 OID 16729)
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
-- TOC entry 5301 (class 0 OID 0)
-- Dependencies: 250
-- Name: doacao_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doacao_nro_plataforma_seq OWNED BY public.doacao.nro_plataforma;


--
-- TOC entry 251 (class 1259 OID 16730)
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
-- TOC entry 5302 (class 0 OID 0)
-- Dependencies: 251
-- Name: doacao_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doacao_seq_comentario_seq OWNED BY public.doacao.seq_comentario;


--
-- TOC entry 252 (class 1259 OID 16731)
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
-- TOC entry 5303 (class 0 OID 0)
-- Dependencies: 252
-- Name: doacao_seq_pg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doacao_seq_pg_seq OWNED BY public.doacao.seq_pg;


--
-- TOC entry 220 (class 1259 OID 16390)
-- Name: empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa (
    nro integer NOT NULL,
    nome text NOT NULL,
    nome_fantasia text
);


ALTER TABLE public.empresa OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16389)
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
-- TOC entry 5304 (class 0 OID 0)
-- Dependencies: 219
-- Name: empresa_nro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_nro_seq OWNED BY public.empresa.nro;


--
-- TOC entry 233 (class 1259 OID 16522)
-- Name: empresa_pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa_pais (
    nro_empresa integer NOT NULL,
    ddi_pais smallint NOT NULL,
    id_nacional text
);


ALTER TABLE public.empresa_pais OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16521)
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
-- TOC entry 5305 (class 0 OID 0)
-- Dependencies: 232
-- Name: empresa_pais_nro_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_pais_nro_empresa_seq OWNED BY public.empresa_pais.nro_empresa;


--
-- TOC entry 242 (class 1259 OID 16621)
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
-- TOC entry 241 (class 1259 OID 16620)
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
-- TOC entry 5306 (class 0 OID 0)
-- Dependencies: 241
-- Name: inscricao_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inscricao_nro_plataforma_seq OWNED BY public.inscricao.nro_plataforma;


--
-- TOC entry 270 (class 1259 OID 16849)
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
-- TOC entry 266 (class 1259 OID 16845)
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
-- TOC entry 5307 (class 0 OID 0)
-- Dependencies: 266
-- Name: mecanismo_plat_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_nro_plataforma_seq OWNED BY public.mecanismo_plat.nro_plataforma;


--
-- TOC entry 267 (class 1259 OID 16846)
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
-- TOC entry 5308 (class 0 OID 0)
-- Dependencies: 267
-- Name: mecanismo_plat_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_comentario_seq OWNED BY public.mecanismo_plat.seq_comentario;


--
-- TOC entry 268 (class 1259 OID 16847)
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
-- TOC entry 5309 (class 0 OID 0)
-- Dependencies: 268
-- Name: mecanismo_plat_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_doacao_seq OWNED BY public.mecanismo_plat.seq_doacao;


--
-- TOC entry 269 (class 1259 OID 16848)
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
-- TOC entry 5310 (class 0 OID 0)
-- Dependencies: 269
-- Name: mecanismo_plat_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_seq OWNED BY public.mecanismo_plat.seq;


--
-- TOC entry 240 (class 1259 OID 16600)
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
-- TOC entry 239 (class 1259 OID 16599)
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
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 239
-- Name: nivel_canal_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nivel_canal_nro_plataforma_seq OWNED BY public.nivel_canal.nro_plataforma;


--
-- TOC entry 226 (class 1259 OID 16440)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    ddi smallint NOT NULL,
    nome text NOT NULL,
    moeda text NOT NULL
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16669)
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
-- TOC entry 245 (class 1259 OID 16668)
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
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 245
-- Name: participa_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participa_nro_plataforma_seq OWNED BY public.participa.nro_plataforma;


--
-- TOC entry 238 (class 1259 OID 16575)
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
-- TOC entry 236 (class 1259 OID 16573)
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
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 236
-- Name: patrocinio_nro_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patrocinio_nro_empresa_seq OWNED BY public.patrocinio.nro_empresa;


--
-- TOC entry 237 (class 1259 OID 16574)
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
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 237
-- Name: patrocinio_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patrocinio_nro_plataforma_seq OWNED BY public.patrocinio.nro_plataforma;


--
-- TOC entry 261 (class 1259 OID 16793)
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
-- TOC entry 258 (class 1259 OID 16790)
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
-- TOC entry 5315 (class 0 OID 0)
-- Dependencies: 258
-- Name: paypal_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_nro_plataforma_seq OWNED BY public.paypal.nro_plataforma;


--
-- TOC entry 259 (class 1259 OID 16791)
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
-- TOC entry 5316 (class 0 OID 0)
-- Dependencies: 259
-- Name: paypal_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_seq_comentario_seq OWNED BY public.paypal.seq_comentario;


--
-- TOC entry 260 (class 1259 OID 16792)
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
-- TOC entry 5317 (class 0 OID 0)
-- Dependencies: 260
-- Name: paypal_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_seq_doacao_seq OWNED BY public.paypal.seq_doacao;


--
-- TOC entry 224 (class 1259 OID 16403)
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
-- TOC entry 5318 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN plataforma.qtd_users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plataforma.qtd_users IS 'Derivado: manter via batch/trigger/ETL';


--
-- TOC entry 222 (class 1259 OID 16401)
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
-- TOC entry 5319 (class 0 OID 0)
-- Dependencies: 222
-- Name: plataforma_empresa_fund_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_empresa_fund_seq OWNED BY public.plataforma.empresa_fund;


--
-- TOC entry 223 (class 1259 OID 16402)
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
-- TOC entry 5320 (class 0 OID 0)
-- Dependencies: 223
-- Name: plataforma_empresa_respo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_empresa_respo_seq OWNED BY public.plataforma.empresa_respo;


--
-- TOC entry 221 (class 1259 OID 16400)
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
-- TOC entry 5321 (class 0 OID 0)
-- Dependencies: 221
-- Name: plataforma_nro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_nro_seq OWNED BY public.plataforma.nro;


--
-- TOC entry 230 (class 1259 OID 16477)
-- Name: plataforma_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plataforma_usuario (
    nro_plataforma integer NOT NULL,
    nick_usuario text NOT NULL,
    nro_usuario integer NOT NULL
);


ALTER TABLE public.plataforma_usuario OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16475)
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
-- TOC entry 5322 (class 0 OID 0)
-- Dependencies: 228
-- Name: plataforma_usuario_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_usuario_nro_plataforma_seq OWNED BY public.plataforma_usuario.nro_plataforma;


--
-- TOC entry 229 (class 1259 OID 16476)
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
-- TOC entry 5323 (class 0 OID 0)
-- Dependencies: 229
-- Name: plataforma_usuario_nro_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_usuario_nro_usuario_seq OWNED BY public.plataforma_usuario.nro_usuario;


--
-- TOC entry 231 (class 1259 OID 16499)
-- Name: streamer_pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.streamer_pais (
    nick_streamer text NOT NULL,
    ddi_pais smallint NOT NULL,
    nro_passaporte character varying(9) NOT NULL
);


ALTER TABLE public.streamer_pais OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16455)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    nick text NOT NULL,
    email text NOT NULL,
    data_nasc date NOT NULL,
    telefone text NOT NULL,
    end_postal text NOT NULL,
    pais_residencia smallint NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16644)
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
-- TOC entry 243 (class 1259 OID 16643)
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
-- TOC entry 5324 (class 0 OID 0)
-- Dependencies: 243
-- Name: video_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.video_nro_plataforma_seq OWNED BY public.video.nro_plataforma;


--
-- TOC entry 4989 (class 2604 OID 16768)
-- Name: bitcoin nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.bitcoin_nro_plataforma_seq'::regclass);


--
-- TOC entry 4990 (class 2604 OID 16769)
-- Name: bitcoin seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN seq_comentario SET DEFAULT nextval('public.bitcoin_seq_comentario_seq'::regclass);


--
-- TOC entry 4991 (class 2604 OID 16770)
-- Name: bitcoin seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN seq_doacao SET DEFAULT nextval('public.bitcoin_seq_doacao_seq'::regclass);


--
-- TOC entry 4976 (class 2604 OID 16553)
-- Name: canal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.canal_nro_plataforma_seq'::regclass);


--
-- TOC entry 4995 (class 2604 OID 16824)
-- Name: cartao_credito nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.cartao_credito_nro_plataforma_seq'::regclass);


--
-- TOC entry 4996 (class 2604 OID 16825)
-- Name: cartao_credito seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN seq_comentario SET DEFAULT nextval('public.cartao_credito_seq_comentario_seq'::regclass);


--
-- TOC entry 4997 (class 2604 OID 16826)
-- Name: cartao_credito seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN seq_doacao SET DEFAULT nextval('public.cartao_credito_seq_doacao_seq'::regclass);


--
-- TOC entry 4983 (class 2604 OID 16697)
-- Name: comentario nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.comentario_nro_plataforma_seq'::regclass);


--
-- TOC entry 4984 (class 2604 OID 16698)
-- Name: comentario seq; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario ALTER COLUMN seq SET DEFAULT nextval('public.comentario_seq_seq'::regclass);


--
-- TOC entry 4986 (class 2604 OID 16735)
-- Name: doacao nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.doacao_nro_plataforma_seq'::regclass);


--
-- TOC entry 4987 (class 2604 OID 16736)
-- Name: doacao seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN seq_comentario SET DEFAULT nextval('public.doacao_seq_comentario_seq'::regclass);


--
-- TOC entry 4988 (class 2604 OID 16737)
-- Name: doacao seq_pg; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN seq_pg SET DEFAULT nextval('public.doacao_seq_pg_seq'::regclass);


--
-- TOC entry 4969 (class 2604 OID 16393)
-- Name: empresa nro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa ALTER COLUMN nro SET DEFAULT nextval('public.empresa_nro_seq'::regclass);


--
-- TOC entry 4975 (class 2604 OID 16525)
-- Name: empresa_pais nro_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais ALTER COLUMN nro_empresa SET DEFAULT nextval('public.empresa_pais_nro_empresa_seq'::regclass);


--
-- TOC entry 4980 (class 2604 OID 16624)
-- Name: inscricao nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.inscricao_nro_plataforma_seq'::regclass);


--
-- TOC entry 4998 (class 2604 OID 16852)
-- Name: mecanismo_plat nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.mecanismo_plat_nro_plataforma_seq'::regclass);


--
-- TOC entry 4999 (class 2604 OID 16853)
-- Name: mecanismo_plat seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq_comentario SET DEFAULT nextval('public.mecanismo_plat_seq_comentario_seq'::regclass);


--
-- TOC entry 5000 (class 2604 OID 16854)
-- Name: mecanismo_plat seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq_doacao SET DEFAULT nextval('public.mecanismo_plat_seq_doacao_seq'::regclass);


--
-- TOC entry 5001 (class 2604 OID 16855)
-- Name: mecanismo_plat seq; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq SET DEFAULT nextval('public.mecanismo_plat_seq_seq'::regclass);


--
-- TOC entry 4979 (class 2604 OID 16603)
-- Name: nivel_canal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_canal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.nivel_canal_nro_plataforma_seq'::regclass);


--
-- TOC entry 4982 (class 2604 OID 16672)
-- Name: participa nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.participa_nro_plataforma_seq'::regclass);


--
-- TOC entry 4977 (class 2604 OID 16578)
-- Name: patrocinio nro_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio ALTER COLUMN nro_empresa SET DEFAULT nextval('public.patrocinio_nro_empresa_seq'::regclass);


--
-- TOC entry 4978 (class 2604 OID 16579)
-- Name: patrocinio nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.patrocinio_nro_plataforma_seq'::regclass);


--
-- TOC entry 4992 (class 2604 OID 16796)
-- Name: paypal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.paypal_nro_plataforma_seq'::regclass);


--
-- TOC entry 4993 (class 2604 OID 16797)
-- Name: paypal seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN seq_comentario SET DEFAULT nextval('public.paypal_seq_comentario_seq'::regclass);


--
-- TOC entry 4994 (class 2604 OID 16798)
-- Name: paypal seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN seq_doacao SET DEFAULT nextval('public.paypal_seq_doacao_seq'::regclass);


--
-- TOC entry 4970 (class 2604 OID 16406)
-- Name: plataforma nro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN nro SET DEFAULT nextval('public.plataforma_nro_seq'::regclass);


--
-- TOC entry 4971 (class 2604 OID 16407)
-- Name: plataforma empresa_fund; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN empresa_fund SET DEFAULT nextval('public.plataforma_empresa_fund_seq'::regclass);


--
-- TOC entry 4972 (class 2604 OID 16408)
-- Name: plataforma empresa_respo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN empresa_respo SET DEFAULT nextval('public.plataforma_empresa_respo_seq'::regclass);


--
-- TOC entry 4973 (class 2604 OID 16480)
-- Name: plataforma_usuario nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.plataforma_usuario_nro_plataforma_seq'::regclass);


--
-- TOC entry 4974 (class 2604 OID 16481)
-- Name: plataforma_usuario nro_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario ALTER COLUMN nro_usuario SET DEFAULT nextval('public.plataforma_usuario_nro_usuario_seq'::regclass);


--
-- TOC entry 4981 (class 2604 OID 16647)
-- Name: video nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.video_nro_plataforma_seq'::regclass);


--
-- TOC entry 5271 (class 0 OID 16765)
-- Dependencies: 257
-- Data for Name: bitcoin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bitcoin (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, txid) FROM stdin;
\.


--
-- TOC entry 5249 (class 0 OID 16550)
-- Dependencies: 235
-- Data for Name: canal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.canal (nro_plataforma, nome, tipo, data, descricao, qtd_visualizacoes, nick_streamer) FROM stdin;
\.


--
-- TOC entry 5279 (class 0 OID 16821)
-- Dependencies: 265
-- Data for Name: cartao_credito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cartao_credito (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, nro_cartao, bandeira) FROM stdin;
\.


--
-- TOC entry 5263 (class 0 OID 16694)
-- Dependencies: 249
-- Data for Name: comentario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comentario (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq, texto, datah, online) FROM stdin;
\.


--
-- TOC entry 5239 (class 0 OID 16429)
-- Dependencies: 225
-- Data for Name: conversao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversao (moeda, nome, fator_conver) FROM stdin;
\.


--
-- TOC entry 5267 (class 0 OID 16732)
-- Dependencies: 253
-- Data for Name: doacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doacao (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg, valor, status) FROM stdin;
\.


--
-- TOC entry 5234 (class 0 OID 16390)
-- Dependencies: 220
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa (nro, nome, nome_fantasia) FROM stdin;
1	da Cunha da Conceição e Filhos	da Cunha da Conceição e Filhos Express
2	Davies-Huff	Davies-Huff Max
3	Vieira	Vieira Express
4	da Mota	da Mota Plus
5	Hunt, Pittman and Andrews	Hunt, Pittman and Andrews Store
6	Azevedo	Azevedo Original
7	Albuquerque - EI	Albuquerque - EI Singular
8	West, Torres and Rice	West, Torres and Rice Express
9	da Mota	da Mota Digital
10	Albuquerque Machado S.A.	Albuquerque Machado S.A. One
11	Garza Group	Garza Group Original
12	Pastor	Pastor Singular
13	Allen-Keith	Allen-Keith Singular
14	Duarte Ltda.	Duarte Ltda. Store
15	Andrade Alves S/A	Andrade Alves S/A Digital
16	da Rocha S.A.	da Rocha S.A. Max
17	Rocha	Rocha Max
18	Albuquerque Nascimento - EI	Albuquerque Nascimento - EI Digital
19	Silva-Flowers	Silva-Flowers Store
20	Mcbride-Burke	Mcbride-Burke Digital
\.


--
-- TOC entry 5247 (class 0 OID 16522)
-- Dependencies: 233
-- Data for Name: empresa_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa_pais (nro_empresa, ddi_pais, id_nacional) FROM stdin;
\.


--
-- TOC entry 5256 (class 0 OID 16621)
-- Dependencies: 242
-- Data for Name: inscricao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inscricao (nro_plataforma, nome_canal, nick_membro, nivel) FROM stdin;
\.


--
-- TOC entry 5284 (class 0 OID 16849)
-- Dependencies: 270
-- Data for Name: mecanismo_plat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mecanismo_plat (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, seq) FROM stdin;
\.


--
-- TOC entry 5254 (class 0 OID 16600)
-- Dependencies: 240
-- Data for Name: nivel_canal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nivel_canal (nro_plataforma, nome_canal, nivel, nome_nivel, valor, gif) FROM stdin;
\.


--
-- TOC entry 5240 (class 0 OID 16440)
-- Dependencies: 226
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pais (ddi, nome, moeda) FROM stdin;
\.


--
-- TOC entry 5260 (class 0 OID 16669)
-- Dependencies: 246
-- Data for Name: participa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participa (nome_canal, nro_plataforma, titulo_video, datah_video, nick_streamer) FROM stdin;
\.


--
-- TOC entry 5252 (class 0 OID 16575)
-- Dependencies: 238
-- Data for Name: patrocinio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patrocinio (nro_empresa, nro_plataforma, nome_canal, valor) FROM stdin;
\.


--
-- TOC entry 5275 (class 0 OID 16793)
-- Dependencies: 261
-- Data for Name: paypal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paypal (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, idpaypal) FROM stdin;
\.


--
-- TOC entry 5238 (class 0 OID 16403)
-- Dependencies: 224
-- Data for Name: plataforma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plataforma (nro, nome, qtd_users, empresa_fund, empresa_respo, data_fund) FROM stdin;
\.


--
-- TOC entry 5244 (class 0 OID 16477)
-- Dependencies: 230
-- Data for Name: plataforma_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plataforma_usuario (nro_plataforma, nick_usuario, nro_usuario) FROM stdin;
\.


--
-- TOC entry 5245 (class 0 OID 16499)
-- Dependencies: 231
-- Data for Name: streamer_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.streamer_pais (nick_streamer, ddi_pais, nro_passaporte) FROM stdin;
\.


--
-- TOC entry 5241 (class 0 OID 16455)
-- Dependencies: 227
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (nick, email, data_nasc, telefone, end_postal, pais_residencia) FROM stdin;
\.


--
-- TOC entry 5258 (class 0 OID 16644)
-- Dependencies: 244
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.video (nro_plataforma, nome_canal, titulo, datah, tema, duracao_segs, visu_simul, visu_total) FROM stdin;
\.


--
-- TOC entry 5325 (class 0 OID 0)
-- Dependencies: 254
-- Name: bitcoin_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_nro_plataforma_seq', 1, false);


--
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 255
-- Name: bitcoin_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_seq_comentario_seq', 1, false);


--
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 256
-- Name: bitcoin_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_seq_doacao_seq', 1, false);


--
-- TOC entry 5328 (class 0 OID 0)
-- Dependencies: 234
-- Name: canal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.canal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5329 (class 0 OID 0)
-- Dependencies: 262
-- Name: cartao_credito_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_nro_plataforma_seq', 1, false);


--
-- TOC entry 5330 (class 0 OID 0)
-- Dependencies: 263
-- Name: cartao_credito_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_seq_comentario_seq', 1, false);


--
-- TOC entry 5331 (class 0 OID 0)
-- Dependencies: 264
-- Name: cartao_credito_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_seq_doacao_seq', 1, false);


--
-- TOC entry 5332 (class 0 OID 0)
-- Dependencies: 247
-- Name: comentario_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_nro_plataforma_seq', 1, false);


--
-- TOC entry 5333 (class 0 OID 0)
-- Dependencies: 248
-- Name: comentario_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_seq_seq', 1, false);


--
-- TOC entry 5334 (class 0 OID 0)
-- Dependencies: 250
-- Name: doacao_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_nro_plataforma_seq', 1, false);


--
-- TOC entry 5335 (class 0 OID 0)
-- Dependencies: 251
-- Name: doacao_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_seq_comentario_seq', 1, false);


--
-- TOC entry 5336 (class 0 OID 0)
-- Dependencies: 252
-- Name: doacao_seq_pg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_seq_pg_seq', 1, false);


--
-- TOC entry 5337 (class 0 OID 0)
-- Dependencies: 219
-- Name: empresa_nro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_nro_seq', 1, false);


--
-- TOC entry 5338 (class 0 OID 0)
-- Dependencies: 232
-- Name: empresa_pais_nro_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_pais_nro_empresa_seq', 1, false);


--
-- TOC entry 5339 (class 0 OID 0)
-- Dependencies: 241
-- Name: inscricao_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscricao_nro_plataforma_seq', 1, false);


--
-- TOC entry 5340 (class 0 OID 0)
-- Dependencies: 266
-- Name: mecanismo_plat_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_nro_plataforma_seq', 1, false);


--
-- TOC entry 5341 (class 0 OID 0)
-- Dependencies: 267
-- Name: mecanismo_plat_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_comentario_seq', 1, false);


--
-- TOC entry 5342 (class 0 OID 0)
-- Dependencies: 268
-- Name: mecanismo_plat_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_doacao_seq', 1, false);


--
-- TOC entry 5343 (class 0 OID 0)
-- Dependencies: 269
-- Name: mecanismo_plat_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_seq', 1, false);


--
-- TOC entry 5344 (class 0 OID 0)
-- Dependencies: 239
-- Name: nivel_canal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nivel_canal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5345 (class 0 OID 0)
-- Dependencies: 245
-- Name: participa_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participa_nro_plataforma_seq', 1, false);


--
-- TOC entry 5346 (class 0 OID 0)
-- Dependencies: 236
-- Name: patrocinio_nro_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patrocinio_nro_empresa_seq', 1, false);


--
-- TOC entry 5347 (class 0 OID 0)
-- Dependencies: 237
-- Name: patrocinio_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patrocinio_nro_plataforma_seq', 1, false);


--
-- TOC entry 5348 (class 0 OID 0)
-- Dependencies: 258
-- Name: paypal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5349 (class 0 OID 0)
-- Dependencies: 259
-- Name: paypal_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_seq_comentario_seq', 1, false);


--
-- TOC entry 5350 (class 0 OID 0)
-- Dependencies: 260
-- Name: paypal_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_seq_doacao_seq', 1, false);


--
-- TOC entry 5351 (class 0 OID 0)
-- Dependencies: 222
-- Name: plataforma_empresa_fund_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_empresa_fund_seq', 1, false);


--
-- TOC entry 5352 (class 0 OID 0)
-- Dependencies: 223
-- Name: plataforma_empresa_respo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_empresa_respo_seq', 1, false);


--
-- TOC entry 5353 (class 0 OID 0)
-- Dependencies: 221
-- Name: plataforma_nro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_nro_seq', 1, false);


--
-- TOC entry 5354 (class 0 OID 0)
-- Dependencies: 228
-- Name: plataforma_usuario_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_usuario_nro_plataforma_seq', 1, false);


--
-- TOC entry 5355 (class 0 OID 0)
-- Dependencies: 229
-- Name: plataforma_usuario_nro_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_usuario_nro_usuario_seq', 1, false);


--
-- TOC entry 5356 (class 0 OID 0)
-- Dependencies: 243
-- Name: video_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.video_nro_plataforma_seq', 1, false);


--
-- TOC entry 5047 (class 2606 OID 16782)
-- Name: bitcoin bitcoin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin
    ADD CONSTRAINT bitcoin_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao);


--
-- TOC entry 5049 (class 2606 OID 16784)
-- Name: bitcoin bitcoin_txid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin
    ADD CONSTRAINT bitcoin_txid_key UNIQUE (txid);


--
-- TOC entry 5031 (class 2606 OID 16562)
-- Name: canal canal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT canal_pkey PRIMARY KEY (nro_plataforma, nome);


--
-- TOC entry 5055 (class 2606 OID 16839)
-- Name: cartao_credito cartao_credito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito
    ADD CONSTRAINT cartao_credito_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao);


--
-- TOC entry 5043 (class 2606 OID 16711)
-- Name: comentario comentario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT comentario_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq);


--
-- TOC entry 5015 (class 2606 OID 16439)
-- Name: conversao conversao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversao
    ADD CONSTRAINT conversao_pkey PRIMARY KEY (moeda);


--
-- TOC entry 5045 (class 2606 OID 16751)
-- Name: doacao doacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao
    ADD CONSTRAINT doacao_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg);


--
-- TOC entry 5029 (class 2606 OID 16531)
-- Name: empresa_pais empresa_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT empresa_pais_pkey PRIMARY KEY (nro_empresa, ddi_pais);


--
-- TOC entry 5011 (class 2606 OID 16399)
-- Name: empresa empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (nro);


--
-- TOC entry 5037 (class 2606 OID 16632)
-- Name: inscricao inscricao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT inscricao_pkey PRIMARY KEY (nro_plataforma, nome_canal, nick_membro, nivel);


--
-- TOC entry 5057 (class 2606 OID 16867)
-- Name: mecanismo_plat mecanismo_plat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat
    ADD CONSTRAINT mecanismo_plat_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, seq);


--
-- TOC entry 5035 (class 2606 OID 16614)
-- Name: nivel_canal nivel_canal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_canal
    ADD CONSTRAINT nivel_canal_pkey PRIMARY KEY (nro_plataforma, nome_canal, nivel);


--
-- TOC entry 5017 (class 2606 OID 16449)
-- Name: pais pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (ddi);


--
-- TOC entry 5041 (class 2606 OID 16681)
-- Name: participa participa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT participa_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_streamer);


--
-- TOC entry 5033 (class 2606 OID 16588)
-- Name: patrocinio patrocinio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio
    ADD CONSTRAINT patrocinio_pkey PRIMARY KEY (nro_empresa, nro_plataforma, nome_canal);


--
-- TOC entry 5051 (class 2606 OID 16812)
-- Name: paypal paypal_idpaypal_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal
    ADD CONSTRAINT paypal_idpaypal_key UNIQUE (idpaypal);


--
-- TOC entry 5053 (class 2606 OID 16810)
-- Name: paypal paypal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal
    ADD CONSTRAINT paypal_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao);


--
-- TOC entry 5013 (class 2606 OID 16418)
-- Name: plataforma plataforma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT plataforma_pkey PRIMARY KEY (nro);


--
-- TOC entry 5023 (class 2606 OID 16488)
-- Name: plataforma_usuario plataforma_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario
    ADD CONSTRAINT plataforma_usuario_pkey PRIMARY KEY (nro_plataforma, nick_usuario);


--
-- TOC entry 5025 (class 2606 OID 16510)
-- Name: streamer_pais streamer_pais_nro_passaporte_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT streamer_pais_nro_passaporte_key UNIQUE (nro_passaporte);


--
-- TOC entry 5027 (class 2606 OID 16508)
-- Name: streamer_pais streamer_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT streamer_pais_pkey PRIMARY KEY (nick_streamer, ddi_pais);


--
-- TOC entry 5019 (class 2606 OID 16469)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 5021 (class 2606 OID 16467)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (nick);


--
-- TOC entry 5039 (class 2606 OID 16662)
-- Name: video video_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pkey PRIMARY KEY (nro_plataforma, nome_canal, titulo, datah);


--
-- TOC entry 5082 (class 2606 OID 16785)
-- Name: bitcoin fk_bitcoin_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin
    ADD CONSTRAINT fk_bitcoin_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg);


--
-- TOC entry 5068 (class 2606 OID 16563)
-- Name: canal fk_canal_plataforma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT fk_canal_plataforma FOREIGN KEY (nro_plataforma) REFERENCES public.plataforma(nro);


--
-- TOC entry 5069 (class 2606 OID 16568)
-- Name: canal fk_canal_streamer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT fk_canal_streamer FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick);


--
-- TOC entry 5084 (class 2606 OID 16840)
-- Name: cartao_credito fk_cartao_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito
    ADD CONSTRAINT fk_cartao_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg);


--
-- TOC entry 5078 (class 2606 OID 16717)
-- Name: comentario fk_comentario_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_usuario FOREIGN KEY (nick_usuario) REFERENCES public.usuario(nick);


--
-- TOC entry 5079 (class 2606 OID 16712)
-- Name: comentario fk_comentario_video; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_video FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video) REFERENCES public.video(nro_plataforma, nome_canal, titulo, datah);


--
-- TOC entry 5080 (class 2606 OID 16752)
-- Name: doacao fk_doacao_comentario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao
    ADD CONSTRAINT fk_doacao_comentario FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario) REFERENCES public.comentario(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq);


--
-- TOC entry 5081 (class 2606 OID 16757)
-- Name: doacao fk_doacao_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao
    ADD CONSTRAINT fk_doacao_usuario FOREIGN KEY (nick_usuario) REFERENCES public.usuario(nick);


--
-- TOC entry 5066 (class 2606 OID 16532)
-- Name: empresa_pais fk_empresapais_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT fk_empresapais_empresa FOREIGN KEY (nro_empresa) REFERENCES public.empresa(nro);


--
-- TOC entry 5067 (class 2606 OID 16537)
-- Name: empresa_pais fk_empresapais_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT fk_empresapais_pais FOREIGN KEY (ddi_pais) REFERENCES public.pais(ddi);


--
-- TOC entry 5073 (class 2606 OID 16633)
-- Name: inscricao fk_inscricao_membro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT fk_inscricao_membro FOREIGN KEY (nick_membro) REFERENCES public.usuario(nick);


--
-- TOC entry 5074 (class 2606 OID 16638)
-- Name: inscricao fk_inscricao_nivel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT fk_inscricao_nivel FOREIGN KEY (nro_plataforma, nome_canal, nivel) REFERENCES public.nivel_canal(nro_plataforma, nome_canal, nivel);


--
-- TOC entry 5085 (class 2606 OID 16868)
-- Name: mecanismo_plat fk_mecanismo_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat
    ADD CONSTRAINT fk_mecanismo_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg);


--
-- TOC entry 5072 (class 2606 OID 16615)
-- Name: nivel_canal fk_nivel_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_canal
    ADD CONSTRAINT fk_nivel_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome);


--
-- TOC entry 5060 (class 2606 OID 16450)
-- Name: pais fk_pais_moeda; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT fk_pais_moeda FOREIGN KEY (moeda) REFERENCES public.conversao(moeda);


--
-- TOC entry 5076 (class 2606 OID 16687)
-- Name: participa fk_participa_streamer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_streamer FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick);


--
-- TOC entry 5077 (class 2606 OID 16682)
-- Name: participa fk_participa_video; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_video FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video) REFERENCES public.video(nro_plataforma, nome_canal, titulo, datah);


--
-- TOC entry 5070 (class 2606 OID 16594)
-- Name: patrocinio fk_patrocinio_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio
    ADD CONSTRAINT fk_patrocinio_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome);


--
-- TOC entry 5071 (class 2606 OID 16589)
-- Name: patrocinio fk_patrocinio_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio
    ADD CONSTRAINT fk_patrocinio_empresa FOREIGN KEY (nro_empresa) REFERENCES public.empresa(nro);


--
-- TOC entry 5083 (class 2606 OID 16813)
-- Name: paypal fk_paypal_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal
    ADD CONSTRAINT fk_paypal_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg);


--
-- TOC entry 5058 (class 2606 OID 16419)
-- Name: plataforma fk_plataforma_empresa_fund; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT fk_plataforma_empresa_fund FOREIGN KEY (empresa_fund) REFERENCES public.empresa(nro);


--
-- TOC entry 5059 (class 2606 OID 16424)
-- Name: plataforma fk_plataforma_empresa_respo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT fk_plataforma_empresa_respo FOREIGN KEY (empresa_respo) REFERENCES public.empresa(nro);


--
-- TOC entry 5062 (class 2606 OID 16489)
-- Name: plataforma_usuario fk_plataforma_usuario_plataforma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario
    ADD CONSTRAINT fk_plataforma_usuario_plataforma FOREIGN KEY (nro_plataforma) REFERENCES public.plataforma(nro);


--
-- TOC entry 5063 (class 2606 OID 16494)
-- Name: plataforma_usuario fk_plataforma_usuario_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario
    ADD CONSTRAINT fk_plataforma_usuario_usuario FOREIGN KEY (nick_usuario) REFERENCES public.usuario(nick);


--
-- TOC entry 5064 (class 2606 OID 16516)
-- Name: streamer_pais fk_streamerpais_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT fk_streamerpais_pais FOREIGN KEY (ddi_pais) REFERENCES public.pais(ddi);


--
-- TOC entry 5065 (class 2606 OID 16511)
-- Name: streamer_pais fk_streamerpais_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT fk_streamerpais_usuario FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick);


--
-- TOC entry 5061 (class 2606 OID 16470)
-- Name: usuario fk_usuario_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_pais FOREIGN KEY (pais_residencia) REFERENCES public.pais(ddi);


--
-- TOC entry 5075 (class 2606 OID 16663)
-- Name: video fk_video_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT fk_video_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome);


-- Completed on 2025-10-27 05:31:03

--
-- PostgreSQL database dump complete
--

\unrestrict f2DNUBB3BT6kVy5FBZn4M4RoYzdKQV6V8D9asYjuIR3UVF03kIMUSh3aDQiY26o

