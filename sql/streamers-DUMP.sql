--
-- PostgreSQL database dump
--

\restrict ZtdFzc7eWFeoR5ugs4S0C7DGSbpPS89YiA1Ty2RkYwz5YgEZGYBQXWl1mRIHZP2

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-30 03:36:40

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
-- TOC entry 5291 (class 0 OID 0)
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
-- TOC entry 5292 (class 0 OID 0)
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
-- TOC entry 5293 (class 0 OID 0)
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
-- TOC entry 5294 (class 0 OID 0)
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
-- TOC entry 5295 (class 0 OID 0)
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
-- TOC entry 5296 (class 0 OID 0)
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
-- TOC entry 5297 (class 0 OID 0)
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
-- TOC entry 5298 (class 0 OID 0)
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
-- TOC entry 5299 (class 0 OID 0)
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
-- TOC entry 5300 (class 0 OID 0)
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
-- TOC entry 5301 (class 0 OID 0)
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
-- TOC entry 5302 (class 0 OID 0)
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
-- TOC entry 5303 (class 0 OID 0)
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
-- TOC entry 5304 (class 0 OID 0)
-- Dependencies: 236
-- Name: doacao_seq_pg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doacao_seq_pg_seq OWNED BY public.doacao.seq_pg;


--
-- TOC entry 269 (class 1259 OID 17716)
-- Name: empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa (
    nro integer NOT NULL,
    nome text NOT NULL,
    nome_fantasia text
);


ALTER TABLE public.empresa OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 17723)
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
-- TOC entry 5305 (class 0 OID 0)
-- Dependencies: 270
-- Name: empresa_nro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_nro_seq OWNED BY public.empresa.nro;


--
-- TOC entry 237 (class 1259 OID 16498)
-- Name: empresa_pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa_pais (
    nro_empresa integer NOT NULL,
    id_nacional text,
    nome_pais text NOT NULL
);


ALTER TABLE public.empresa_pais OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16505)
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
-- TOC entry 5306 (class 0 OID 0)
-- Dependencies: 238
-- Name: empresa_pais_nro_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_pais_nro_empresa_seq OWNED BY public.empresa_pais.nro_empresa;


--
-- TOC entry 239 (class 1259 OID 16506)
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
-- TOC entry 240 (class 1259 OID 16515)
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
-- TOC entry 5307 (class 0 OID 0)
-- Dependencies: 240
-- Name: inscricao_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inscricao_nro_plataforma_seq OWNED BY public.inscricao.nro_plataforma;


--
-- TOC entry 241 (class 1259 OID 16516)
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
-- TOC entry 242 (class 1259 OID 16529)
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
-- TOC entry 5308 (class 0 OID 0)
-- Dependencies: 242
-- Name: mecanismo_plat_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_nro_plataforma_seq OWNED BY public.mecanismo_plat.nro_plataforma;


--
-- TOC entry 243 (class 1259 OID 16530)
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
-- TOC entry 5309 (class 0 OID 0)
-- Dependencies: 243
-- Name: mecanismo_plat_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_comentario_seq OWNED BY public.mecanismo_plat.seq_comentario;


--
-- TOC entry 244 (class 1259 OID 16531)
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
-- TOC entry 5310 (class 0 OID 0)
-- Dependencies: 244
-- Name: mecanismo_plat_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_doacao_seq OWNED BY public.mecanismo_plat.seq_doacao;


--
-- TOC entry 245 (class 1259 OID 16532)
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
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 245
-- Name: mecanismo_plat_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mecanismo_plat_seq_seq OWNED BY public.mecanismo_plat.seq;


--
-- TOC entry 246 (class 1259 OID 16533)
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
-- TOC entry 247 (class 1259 OID 16545)
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
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 247
-- Name: nivel_canal_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nivel_canal_nro_plataforma_seq OWNED BY public.nivel_canal.nro_plataforma;


--
-- TOC entry 248 (class 1259 OID 16546)
-- Name: pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pais (
    ddi integer NOT NULL,
    nome text NOT NULL,
    moeda text NOT NULL
);


ALTER TABLE public.pais OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16554)
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
-- TOC entry 250 (class 1259 OID 16564)
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
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 250
-- Name: participa_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participa_nro_plataforma_seq OWNED BY public.participa.nro_plataforma;


--
-- TOC entry 251 (class 1259 OID 16565)
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
-- TOC entry 252 (class 1259 OID 16575)
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
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 252
-- Name: patrocinio_nro_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patrocinio_nro_empresa_seq OWNED BY public.patrocinio.nro_empresa;


--
-- TOC entry 253 (class 1259 OID 16576)
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
-- TOC entry 5315 (class 0 OID 0)
-- Dependencies: 253
-- Name: patrocinio_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patrocinio_nro_plataforma_seq OWNED BY public.patrocinio.nro_plataforma;


--
-- TOC entry 254 (class 1259 OID 16577)
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
-- TOC entry 255 (class 1259 OID 16590)
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
-- TOC entry 5316 (class 0 OID 0)
-- Dependencies: 255
-- Name: paypal_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_nro_plataforma_seq OWNED BY public.paypal.nro_plataforma;


--
-- TOC entry 256 (class 1259 OID 16591)
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
-- TOC entry 5317 (class 0 OID 0)
-- Dependencies: 256
-- Name: paypal_seq_comentario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_seq_comentario_seq OWNED BY public.paypal.seq_comentario;


--
-- TOC entry 257 (class 1259 OID 16592)
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
-- TOC entry 5318 (class 0 OID 0)
-- Dependencies: 257
-- Name: paypal_seq_doacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paypal_seq_doacao_seq OWNED BY public.paypal.seq_doacao;


--
-- TOC entry 258 (class 1259 OID 16593)
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
-- TOC entry 5319 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN plataforma.qtd_users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.plataforma.qtd_users IS 'Derivado: manter via batch/trigger/ETL';


--
-- TOC entry 259 (class 1259 OID 16604)
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
-- TOC entry 5320 (class 0 OID 0)
-- Dependencies: 259
-- Name: plataforma_empresa_fund_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_empresa_fund_seq OWNED BY public.plataforma.empresa_fund;


--
-- TOC entry 260 (class 1259 OID 16605)
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
-- TOC entry 5321 (class 0 OID 0)
-- Dependencies: 260
-- Name: plataforma_empresa_respo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_empresa_respo_seq OWNED BY public.plataforma.empresa_respo;


--
-- TOC entry 261 (class 1259 OID 16606)
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
-- TOC entry 5322 (class 0 OID 0)
-- Dependencies: 261
-- Name: plataforma_nro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_nro_seq OWNED BY public.plataforma.nro;


--
-- TOC entry 262 (class 1259 OID 16607)
-- Name: plataforma_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plataforma_usuario (
    nro_plataforma integer NOT NULL,
    nick_usuario text NOT NULL,
    nro_usuario integer NOT NULL
);


ALTER TABLE public.plataforma_usuario OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 16615)
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
-- TOC entry 5323 (class 0 OID 0)
-- Dependencies: 263
-- Name: plataforma_usuario_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_usuario_nro_plataforma_seq OWNED BY public.plataforma_usuario.nro_plataforma;


--
-- TOC entry 264 (class 1259 OID 16616)
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
-- TOC entry 5324 (class 0 OID 0)
-- Dependencies: 264
-- Name: plataforma_usuario_nro_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plataforma_usuario_nro_usuario_seq OWNED BY public.plataforma_usuario.nro_usuario;


--
-- TOC entry 265 (class 1259 OID 16617)
-- Name: streamer_pais; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.streamer_pais (
    nick_streamer text NOT NULL,
    nro_passaporte character varying(9) NOT NULL,
    nome_pais text NOT NULL
);


ALTER TABLE public.streamer_pais OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 16625)
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
-- TOC entry 5325 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN usuario.pais_resid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.usuario.pais_resid IS 'País de residência';


--
-- TOC entry 267 (class 1259 OID 16636)
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
-- TOC entry 268 (class 1259 OID 16652)
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
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 268
-- Name: video_nro_plataforma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.video_nro_plataforma_seq OWNED BY public.video.nro_plataforma;


--
-- TOC entry 4969 (class 2604 OID 17724)
-- Name: bitcoin nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.bitcoin_nro_plataforma_seq'::regclass);


--
-- TOC entry 4970 (class 2604 OID 17725)
-- Name: bitcoin seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN seq_comentario SET DEFAULT nextval('public.bitcoin_seq_comentario_seq'::regclass);


--
-- TOC entry 4971 (class 2604 OID 17726)
-- Name: bitcoin seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin ALTER COLUMN seq_doacao SET DEFAULT nextval('public.bitcoin_seq_doacao_seq'::regclass);


--
-- TOC entry 4972 (class 2604 OID 17727)
-- Name: canal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.canal_nro_plataforma_seq'::regclass);


--
-- TOC entry 4973 (class 2604 OID 17728)
-- Name: cartao_credito nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.cartao_credito_nro_plataforma_seq'::regclass);


--
-- TOC entry 4974 (class 2604 OID 17729)
-- Name: cartao_credito seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN seq_comentario SET DEFAULT nextval('public.cartao_credito_seq_comentario_seq'::regclass);


--
-- TOC entry 4975 (class 2604 OID 17730)
-- Name: cartao_credito seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito ALTER COLUMN seq_doacao SET DEFAULT nextval('public.cartao_credito_seq_doacao_seq'::regclass);


--
-- TOC entry 4976 (class 2604 OID 17731)
-- Name: comentario nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.comentario_nro_plataforma_seq'::regclass);


--
-- TOC entry 4977 (class 2604 OID 17732)
-- Name: comentario seq; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario ALTER COLUMN seq SET DEFAULT nextval('public.comentario_seq_seq'::regclass);


--
-- TOC entry 4979 (class 2604 OID 17733)
-- Name: doacao nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.doacao_nro_plataforma_seq'::regclass);


--
-- TOC entry 4980 (class 2604 OID 17734)
-- Name: doacao seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN seq_comentario SET DEFAULT nextval('public.doacao_seq_comentario_seq'::regclass);


--
-- TOC entry 4981 (class 2604 OID 17735)
-- Name: doacao seq_pg; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao ALTER COLUMN seq_pg SET DEFAULT nextval('public.doacao_seq_pg_seq'::regclass);


--
-- TOC entry 5001 (class 2604 OID 17736)
-- Name: empresa nro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa ALTER COLUMN nro SET DEFAULT nextval('public.empresa_nro_seq'::regclass);


--
-- TOC entry 4982 (class 2604 OID 17737)
-- Name: empresa_pais nro_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais ALTER COLUMN nro_empresa SET DEFAULT nextval('public.empresa_pais_nro_empresa_seq'::regclass);


--
-- TOC entry 4983 (class 2604 OID 17738)
-- Name: inscricao nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.inscricao_nro_plataforma_seq'::regclass);


--
-- TOC entry 4984 (class 2604 OID 17739)
-- Name: mecanismo_plat nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.mecanismo_plat_nro_plataforma_seq'::regclass);


--
-- TOC entry 4985 (class 2604 OID 17740)
-- Name: mecanismo_plat seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq_comentario SET DEFAULT nextval('public.mecanismo_plat_seq_comentario_seq'::regclass);


--
-- TOC entry 4986 (class 2604 OID 17741)
-- Name: mecanismo_plat seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq_doacao SET DEFAULT nextval('public.mecanismo_plat_seq_doacao_seq'::regclass);


--
-- TOC entry 4987 (class 2604 OID 17742)
-- Name: mecanismo_plat seq; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat ALTER COLUMN seq SET DEFAULT nextval('public.mecanismo_plat_seq_seq'::regclass);


--
-- TOC entry 4988 (class 2604 OID 17743)
-- Name: nivel_canal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_canal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.nivel_canal_nro_plataforma_seq'::regclass);


--
-- TOC entry 4989 (class 2604 OID 17744)
-- Name: participa nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.participa_nro_plataforma_seq'::regclass);


--
-- TOC entry 4990 (class 2604 OID 17745)
-- Name: patrocinio nro_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio ALTER COLUMN nro_empresa SET DEFAULT nextval('public.patrocinio_nro_empresa_seq'::regclass);


--
-- TOC entry 4991 (class 2604 OID 17746)
-- Name: patrocinio nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.patrocinio_nro_plataforma_seq'::regclass);


--
-- TOC entry 4992 (class 2604 OID 17747)
-- Name: paypal nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.paypal_nro_plataforma_seq'::regclass);


--
-- TOC entry 4993 (class 2604 OID 17748)
-- Name: paypal seq_comentario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN seq_comentario SET DEFAULT nextval('public.paypal_seq_comentario_seq'::regclass);


--
-- TOC entry 4994 (class 2604 OID 17749)
-- Name: paypal seq_doacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal ALTER COLUMN seq_doacao SET DEFAULT nextval('public.paypal_seq_doacao_seq'::regclass);


--
-- TOC entry 4995 (class 2604 OID 17750)
-- Name: plataforma nro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN nro SET DEFAULT nextval('public.plataforma_nro_seq'::regclass);


--
-- TOC entry 4996 (class 2604 OID 17751)
-- Name: plataforma empresa_fund; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN empresa_fund SET DEFAULT nextval('public.plataforma_empresa_fund_seq'::regclass);


--
-- TOC entry 4997 (class 2604 OID 17752)
-- Name: plataforma empresa_respo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma ALTER COLUMN empresa_respo SET DEFAULT nextval('public.plataforma_empresa_respo_seq'::regclass);


--
-- TOC entry 4998 (class 2604 OID 17753)
-- Name: plataforma_usuario nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.plataforma_usuario_nro_plataforma_seq'::regclass);


--
-- TOC entry 4999 (class 2604 OID 17754)
-- Name: plataforma_usuario nro_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario ALTER COLUMN nro_usuario SET DEFAULT nextval('public.plataforma_usuario_nro_usuario_seq'::regclass);


--
-- TOC entry 5000 (class 2604 OID 17755)
-- Name: video nro_plataforma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video ALTER COLUMN nro_plataforma SET DEFAULT nextval('public.video_nro_plataforma_seq'::regclass);


--
-- TOC entry 5234 (class 0 OID 16403)
-- Dependencies: 219
-- Data for Name: bitcoin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bitcoin (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, txid) FROM stdin;
\.


--
-- TOC entry 5238 (class 0 OID 16419)
-- Dependencies: 223
-- Data for Name: canal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.canal (nro_plataforma, nome, tipo, data, descricao, qtd_visualizacoes, nick_streamer) FROM stdin;
\.


--
-- TOC entry 5240 (class 0 OID 16430)
-- Dependencies: 225
-- Data for Name: cartao_credito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cartao_credito (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, nro_cartao, bandeira) FROM stdin;
\.


--
-- TOC entry 5244 (class 0 OID 16447)
-- Dependencies: 229
-- Data for Name: comentario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comentario (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq, texto, datah, online) FROM stdin;
\.


--
-- TOC entry 5247 (class 0 OID 16463)
-- Dependencies: 232
-- Data for Name: conversao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversao (moeda, nome, fator_conver) FROM stdin;
MZN	Mozambican metical	3.58207198
TVD	Tuvaluan dollar	0.81270399
HNL	Honduran lempira	4.62024124
BAM	Bosnia and Herzegovina convertible mark	2.04578192
XCD	Eastern Caribbean dollar	4.31639339
GTQ	Guatemalan quetzal	6.03396674
SBD	Solomon Islands dollar	4.27788297
YER	Yemeni rial	5.06703656
UZS	Uzbekistani soʻm	3.20103795
ETB	Ethiopian birr	0.87448575
LTL	Lithuanian litas	6.48977817
SRD	Surinamese dollar	5.53380203
KPW	North Korean won	2.77546438
CNY	Renminbi	4.56442241
ZMW	Zambian kwacha	3.11156051
SDG	Sudanese pound	2.86602250
BOB	Bolivian boliviano	2.18841460
JOD	Jordanian dinar	5.23416230
GBP	Pound sterling	3.31266312
KYD	Cayman Islands dollar	5.43213139
VEF	Venezuelan bolívar	1.28225356
NPR	Nepalese rupee	5.25622934
SVC	Salvadoran colón	0.20505376
AFN	Afghan afghani	6.18871557
TWD	New Taiwan dollar	3.57144597
SEK	Swedish krona	4.54612748
FJD	Fijian dollar	2.27336421
CRC	Costa Rican colón	1.41972265
ZWD	Zimbabwean dollar	6.39117896
XOF	West African CFA franc	4.58843046
ALL	Albanian lek	1.74552173
MAD	Moroccan dirham	3.27212456
BDT	Bangladeshi taka	5.31789009
EUR	Euro	5.53065969
MXN	Mexican peso	5.33046371
ARS	Argentine peso	5.26085622
CLP	Chilean peso	2.31366612
HRK	Croatian kuna	3.96185077
JEP	Jersey pound	4.31055631
SHP	Saint Helena pound	1.17166304
CVE	Cape Verdean escudo	0.21154954
TJS	Tajikistani somoni	1.51433998
RSD	Serbian dinar	4.37968924
TOP	Tongan paʻanga	2.10598638
ERN	Eritrean nakfa	4.32647935
ISK	Icelandic króna	4.04158452
MYR	Malaysian ringgit	4.91223064
CHF	Swiss franc	0.14343175
SLL	Sierra Leonean leone	3.51350444
CUC	Cuban convertible peso	2.85065956
ILS	Israeli new shekel	5.15448570
MDL	Moldovan leu	6.46521334
IRR	Iranian rial	4.31851773
BIF	Burundian franc	3.93143816
LKR	Sri Lankan rupee	3.38976064
PLN	Polish zloty	5.09743038
TTD	Trinidad and Tobago dollar	4.32175174
MKD	Macedonian denar	2.57929148
CDF	Congolese franc	3.76678713
COP	Colombian peso	2.97508794
PGK	Papua New Guinean kina	2.28526890
NIS	Israeli new shekel	0.64879442
CZK	Czech koruna	2.38949588
UGX	Ugandan shilling	6.05146247
GHS	Ghanaian cedi	2.22143105
PEN	Peruvian sol	2.79519333
PHP	Philippine peso	4.40603373
LYD	Libyan dinar	1.31003789
WST	Samoan tālā	2.43025118
KRW	South Korean won	0.68793495
BMD	Bermudian dollar	1.64844714
CAD	Canadian dollar	0.99814157
BHD	Bahraini dinar	0.61078094
XPF	CFP franc	3.60968748
KES	Kenyan shilling	2.16884673
AUD	Australian dollar	0.40675529
NGN	Nigerian naira	4.49139066
HUF	Hungarian forint	3.02066662
BRL	Brazilian real	5.67825180
KGS	Kyrgyzstani som	1.03802200
TND	Tunisian dinar	4.79709781
JMD	Jamaican dollar	6.29073749
NIO	Nicaraguan córdoba	0.21484816
USD	United States dollar	1.00000000
JPY	Japanese yen	1.12462131
GGP	Guernsey pound	1.51079984
XAF	Central African CFA franc	5.69273031
BYR	Belarusian ruble	5.45037564
LSL	Lesotho loti	1.07724388
MVR	Maldivian rufiyaa	2.51678572
UAH	Ukrainian hryvnia	5.96896573
GEL	Georgian lari	5.60730247
MWK	Malawian kwacha	1.94035108
INR	Indian rupee	4.35448131
MGA	Malagasy ariar	1.25355591
KHR	Cambodian riel	5.23242264
IMP	Manx pound	2.90562342
GYD	Guyanese dollar	1.01520494
BTN	Bhutanese ngultrum	1.95266561
PYG	Paraguayan guarani	0.39150617
SCR	Seychellois rupee	2.98367133
BZD	Belize dollar	2.58378544
CUP	Cuban peso	1.24698144
DJF	Djiboutian franc	5.97362753
AOA	Angolan kwanza	3.73622143
PKR	Pakistani rupee	0.07864296
BWP	Botswana pula	1.57121505
AMD	Armenian dram	3.29376192
BBD	Barbadian dollar	1.68817254
SGD	Singapore dollar	1.86289875
OMR	Omani rial	4.19425055
TMT	Turkmenistan manat	5.82622654
MUR	Mauritian rupee	2.73623803
DZD	Algerian dinar	6.20905085
LBP	Lebanese pound	0.88511310
KZT	Kazakhstani tenge	4.00742214
SOS	Somali shilling	1.41293285
LAK	Lao kip	6.46535512
STD	São Tomé and Príncipe dobra	2.25328079
XDR	Special drawing rights	3.71199012
IDR	Indonesian rupiah	1.37179768
MOP	Macanese pataca	0.70670257
BND	Brunei dollar	0.10280827
HTG	Haitian gourde	6.07193754
ANG	Netherlands Antillean guilder	4.16205315
HKD	Hong Kong dollar	2.65110583
SZL	Swazi lilangeni	5.91772804
KWD	Kuwaiti dinar	2.66011041
UYU	Uruguayan peso	3.83289387
SYP	Syrian pound	1.92113623
LRD	Liberian dollar	6.34571775
RUB	Russian ruble	3.98747728
NZD	New Zealand dollar	1.53897388
AWG	Aruban florin	3.91552603
RWF	Rwandan franc	2.31331182
MRO	Mauritanian ouguiya	3.60165930
BGN	Bulgarian lev	5.43767727
SAR	Saudi riyal	6.14786892
THB	Thai baht	0.51180107
VND	Vietnamese đồng	4.26390061
QAR	Qatari riyal	4.36956969
ZAR	South African rand	1.09904061
NAD	Namibian dollar	2.21344430
TRY	Turkish lira	4.52913583
GIP	Gibraltar pound	0.47867976
GMD	Gambian dalasi	3.91081956
MNT	Mongolian tugrik	5.67131185
IQD	Iraqi dinar	4.83402455
VUV	Vanuatu vatu	5.19265102
AZN	Azerbaijani manat	6.31691516
AED	United Arab Emirates dirham	2.63562588
PAB	Panamanian balboa	4.84354870
BSD	Bahamian dollar	1.00940632
KMF	Comorian franc	0.17355859
DOP	Dominican peso	2.85772684
TZS	Tanzanian shilling	2.57103341
SPL	Seborga luigino	3.58136477
DKK	Danish krone	6.05991931
MMK	Burmese kyat	5.60930486
GNF	Guinean franc	6.28291438
\.


--
-- TOC entry 5248 (class 0 OID 16472)
-- Dependencies: 233
-- Data for Name: doacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doacao (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg, valor, status) FROM stdin;
\.


--
-- TOC entry 5284 (class 0 OID 17716)
-- Dependencies: 269
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa (nro, nome, nome_fantasia) FROM stdin;
1	Perez Inc	Perez Inc Hub
2	Rodrigues	Rodrigues Construções
3	Abreu	Abreu Legal
4	da Luz Novaes e Filhos	da Luz Novaes e Filhos Smart
5	Barbosa Ltda.	Barbosa Ltda. Logística
6	Schmidt-Pham	Schmidt-Pham Next
7	Hill-Smith	Hill-Smith Alimentos
8	Pereira Leão S/A	Pereira Leão S/A Networks
9	Porter-Davis	Porter-Davis Empreendimentos
10	Casa Grande	Casa Grande Universal
11	Almeida	Almeida Academia
12	Montenegro S.A.	Montenegro S.A. Tecnologia
13	Swanson-Moody	Swanson-Moody Obras
14	da Rosa	da Rosa Platform
15	Snyder, Green and Deleon	Snyder, Green and Deleon Serviços
16	Sá	Sá Atelier
17	Jensen, Jones and Roy	Jensen, Jones and Roy Sustentável
18	Gallegos, James and Diaz	Gallegos, James and Diaz Enterprises
19	Fonseca Araújo Ltda.	Fonseca Araújo Ltda. Prime
20	Teixeira	Teixeira Distribuidora
21	Farias	Farias Holdings
22	Grant-Campbell	Grant-Campbell Next
23	Mccann-Delgado	Mccann-Delgado Inovação
24	Farias Vasconcelos e Filhos	Farias Vasconcelos e Filhos Private
25	Campos-Goodman	Campos-Goodman Estilo
26	Sanchez, Manning and Taylor	Sanchez, Manning and Taylor Edge
27	Myers-Williams	Myers-Williams Design
28	Martins S.A.	Martins S.A. Networks
29	Smith-Johnson	Smith-Johnson Tech
30	Sharp, Barton and Clark	Sharp, Barton and Clark Formação
31	Huber LLC	Huber LLC Delícias
32	Reyes-Smith	Reyes-Smith Consultoria
33	Cirino S.A.	Cirino S.A. Global
34	Cardoso	Cardoso Creative
35	Cardoso Peixoto - EI	Cardoso Peixoto - EI Atelier
36	Duran, Thompson and Howard	Duran, Thompson and Howard Sustentável
37	Barros	Barros Delícias
38	Ramos	Ramos Logística
39	Marques	Marques Platform
40	Pacheco S.A.	Pacheco S.A. Hub
41	Machado	Machado Systems
42	Silveira	Silveira Atelier
43	Garcia LLC	Garcia LLC Partners
44	Casa Grande Cavalcanti e Filhos	Casa Grande Cavalcanti e Filhos Comércio
45	Costela da Rocha Ltda.	Costela da Rocha Ltda. Studio
46	Ramos Fogaça - ME	Ramos Fogaça - ME Advisors
47	Melo	Melo Design
48	Sawyer-Lee	Sawyer-Lee Hub
49	Harris-Duncan	Harris-Duncan Investimentos
50	Bernard, Rodriguez and Martinez	Bernard, Rodriguez and Martinez Inovação
51	Lowe-Ramirez	Lowe-Ramirez Agency
52	Johnston-Huff	Johnston-Huff Solutions
53	Pereira Gomes Ltda.	Pereira Gomes Ltda. Verde
54	Foster, Rangel and Jackson	Foster, Rangel and Jackson Smart
55	Krause Inc	Krause Inc Creative
56	das Neves	das Neves Services
57	Mendes Fogaça Ltda.	Mendes Fogaça Ltda. International
58	Montenegro	Montenegro Tecnologia
59	Jesus - EI	Jesus - EI Collective
60	Mccarthy-Meyer	Mccarthy-Meyer Serviços
61	Camargo	Camargo Services
62	Matthews, Edwards and Rogers	Matthews, Edwards and Rogers Design
63	Duarte e Filhos	Duarte e Filhos Assessoria
64	Smith, Perry and Daugherty	Smith, Perry and Daugherty Eco
65	Orr LLC	Orr LLC Healthcare
66	Edwards, Lopez and Barrett	Edwards, Lopez and Barrett Prime
67	Robertson PLC	Robertson PLC Assessoria
68	Weeks, Watson and Crawford	Weeks, Watson and Crawford Advisors
69	Walker, Hernandez and Hart	Walker, Hernandez and Hart Eco
70	Ferreira e Filhos	Ferreira e Filhos Investimentos
71	Kent, Buchanan and Smith	Kent, Buchanan and Smith Wellness
72	Cavalcanti S.A.	Cavalcanti S.A. Consulting
73	Welch Ltd	Welch Ltd Moda
74	Albuquerque	Albuquerque Serviços
75	Fitzgerald-Smith	Fitzgerald-Smith Agency
76	Aparecida Ltda.	Aparecida Ltda. Engine
77	Edwards-Moore	Edwards-Moore Smart
78	Montenegro Garcia - EI	Montenegro Garcia - EI Systems
79	Mcguire-Sanchez	Mcguire-Sanchez Factory
80	Duarte Group	Duarte Group Boutique
81	Horne, Taylor and Wang	Horne, Taylor and Wang Frete
82	Martin Inc	Martin Inc Solutions
83	Ferguson, Rodriguez and Williams	Ferguson, Rodriguez and Williams Design
84	Lewis, Hutchinson and Pierce	Lewis, Hutchinson and Pierce Culinária
85	Rivera and Sons	Rivera and Sons Academia
86	Gill, Bartlett and Hickman	Gill, Bartlett and Hickman Frete
87	Gomes - ME	Gomes - ME Prime
88	Harrington-Flores	Harrington-Flores Comércio
89	Smith, Murray and Miller	Smith, Murray and Miller Eco
90	Cavalcanti	Cavalcanti Tech
91	Hammond LLC	Hammond LLC Obras
92	Sá Nogueira e Filhos	Sá Nogueira e Filhos Treinamento
93	Costa - ME	Costa - ME Collective
94	Barrett PLC	Barrett PLC Gastronomia
95	Holmes, Moreno and Patel	Holmes, Moreno and Patel International
96	Albuquerque - ME	Albuquerque - ME Engine
97	Barber, Stone and Fisher	Barber, Stone and Fisher Smart
98	Nogueira - EI	Nogueira - EI Serviços
99	Bass, Miller and Pollard	Bass, Miller and Pollard Engine
100	Berg-Weber	Berg-Weber Varejo
101	Stewart, Archer and Walsh	Stewart, Archer and Walsh International
102	Martins	Martins Comércio
103	Mendes Cardoso S.A.	Mendes Cardoso S.A. Tech
104	Chen Ltd	Chen Ltd Distribuidora
105	Kelly PLC	Kelly PLC Frete
106	Campos and Sons	Campos and Sons Consultoria
107	Novaes Almeida S/A	Novaes Almeida S/A Tech
108	Snyder, Flores and Donovan	Snyder, Flores and Donovan Design
109	Goodman LLC	Goodman LLC Consulting
110	Novaes - EI	Novaes - EI Tech
111	Oliveira - EI	Oliveira - EI Agency
112	Floyd-Lindsey	Floyd-Lindsey Eco
113	Leão	Leão Comércio
114	Novais	Novais Tecnologia
115	Smith-Bradley	Smith-Bradley Capital
116	das Neves e Filhos	das Neves e Filhos Worldwide
117	Ryan PLC	Ryan PLC Logística
118	Rose-Cook	Rose-Cook Holdings
119	da Rocha - ME	da Rocha - ME Solutions
120	Wood, Gordon and Patrick	Wood, Gordon and Patrick Works
121	Molina, Boyle and Price	Molina, Boyle and Price Labs
122	Perez-Frazier	Perez-Frazier Design
123	Anderson, Baker and Richards	Anderson, Baker and Richards Wellness
124	Cirino Lima e Filhos	Cirino Lima e Filhos Verde
125	Kelly LLC	Kelly LLC Creative
126	Campos Nunes Ltda.	Campos Nunes Ltda. Agency
127	Reeves Inc	Reeves Inc Digital
128	Hayden PLC	Hayden PLC Systems
129	Lopez and Sons	Lopez and Sons Solutions
130	Leão Ltda.	Leão Ltda. Capital
131	Osborne, Woods and Daniels	Osborne, Woods and Daniels Solutions
132	Morton, Joseph and Peters	Morton, Joseph and Peters Academia
133	Taylor and Sons	Taylor and Sons Academia
134	Silva	Silva Consulting
135	Souza	Souza Edge
136	Fox, Michael and Baker	Fox, Michael and Baker Treinamento
137	Montenegro Lopes S.A.	Montenegro Lopes S.A. Platform
138	Moura	Moura Investimentos
139	Novaes S.A.	Novaes S.A. Moda
140	Sales	Sales Holdings
141	Carvalho	Carvalho Operações
142	Gonçalves	Gonçalves Finanças
143	Nogueira Fonseca S/A	Nogueira Fonseca S/A Healthcare
144	Hunter, Williams and Hale	Hunter, Williams and Hale Advisors
145	Campbell, Barber and Morris	Campbell, Barber and Morris Design
146	Mitchell-Thomas	Mitchell-Thomas Moda
147	Fernandes e Filhos	Fernandes e Filhos Legal
148	Borges	Borges Inovação
149	Silva e Filhos	Silva e Filhos Assessoria
150	Long, Scott and Newman	Long, Scott and Newman Strategies
151	Franklin-Anderson	Franklin-Anderson Frete
152	Jesus	Jesus Assessoria
153	Long Group	Long Group Obras
154	da Conceição	da Conceição Systems
155	Lopez Inc	Lopez Inc Prime
156	Miller LLC	Miller LLC Next
157	Nogueira	Nogueira Estilo
158	Almeida S/A	Almeida S/A Clinic
159	Johnson and Sons	Johnson and Sons Serviços
160	Molina-Phelps	Molina-Phelps Digital
161	Whitney Ltd	Whitney Ltd Networks
162	da Paz da Cruz - ME	da Paz da Cruz - ME Verde
163	Freeman, Bean and Page	Freeman, Bean and Page Empreendimentos
164	Martinez, Barry and Ibarra	Martinez, Barry and Ibarra Ambiental
165	da Rocha Ltda.	da Rocha Ltda. Networks
166	Sampaio Guerra Ltda.	Sampaio Guerra Ltda. Jurídico
167	Hood-Pope	Hood-Pope Inovação
168	Barbosa - EI	Barbosa - EI Prime
169	da Costa	da Costa Obras
170	Cardoso Nogueira - ME	Cardoso Nogueira - ME Delícias
171	Barbosa S/A	Barbosa S/A Design
172	Grimes-Wilson	Grimes-Wilson Consultoria
173	Ayers PLC	Ayers PLC Services
174	Nichols, Garcia and Stevens	Nichols, Garcia and Stevens Edge
175	Sampaio	Sampaio Design
176	Nascimento	Nascimento Treinamento
177	Lopes Vargas - EI	Lopes Vargas - EI Strategies
178	da Rosa Costa S.A.	da Rosa Costa S.A. Transportes
179	Collins, Marshall and Carroll	Collins, Marshall and Carroll Wellness
180	Garza Ltd	Garza Ltd Prime
181	Smith and Sons	Smith and Sons Wellness
182	Waters Ltd	Waters Ltd Advocacia
183	Mendonça S/A	Mendonça S/A Enterprises
184	Costa da Costa S/A	Costa da Costa S/A Distribuidora
185	Madden Ltd	Madden Ltd Educação
186	Fogaça	Fogaça Serviços
187	Butler PLC	Butler PLC Services
188	Grimes-Nunez	Grimes-Nunez Works
189	Albuquerque Sousa S/A	Albuquerque Sousa S/A Creative
190	Bennett-Stewart	Bennett-Stewart Worldwide
191	Viana	Viana Grupo
192	Miller, Navarro and Baxter	Miller, Navarro and Baxter Legal
193	Hansen-Smith	Hansen-Smith Investimentos
194	Cohen, Moore and Johnson	Cohen, Moore and Johnson Universal
195	Garcia	Garcia Treinamento
196	Hodge-Carlson	Hodge-Carlson Delícias
197	Vazquez-Murray	Vazquez-Murray Consultoria
198	Câmara Andrade e Filhos	Câmara Andrade e Filhos Consultoria
199	Hughes Inc	Hughes Inc Platform
200	Brown-Gonzalez	Brown-Gonzalez Investimentos
201	Price LLC	Price LLC Construções
202	Roy Ltd	Roy Ltd Sustentável
203	Macedo	Macedo Digital
204	Atkinson LLC	Atkinson LLC Estilo
205	Sharp PLC	Sharp PLC Consulting
206	Gomez Ltd	Gomez Ltd Clinic
207	Mendes Pinto S/A	Mendes Pinto S/A Formação
208	Câmara S/A	Câmara S/A Agency
209	Mitchell-Collins	Mitchell-Collins Eco
210	Harrington PLC	Harrington PLC Healthcare
211	Pastor e Filhos	Pastor e Filhos Wellness
212	Taylor, Colon and Stephenson	Taylor, Colon and Stephenson Solutions
213	da Paz	da Paz Networks
214	Alves Campos - EI	Alves Campos - EI Solutions
215	Harris and Sons	Harris and Sons Hub
216	Novaes	Novaes Labs
217	Casa Grande Novaes S/A	Casa Grande Novaes S/A Culinária
218	Stuart Ltd	Stuart Ltd Collective
219	Campbell, Reynolds and Miller	Campbell, Reynolds and Miller Alimentos
220	Roberts, Thomas and Phelps	Roberts, Thomas and Phelps Labs
221	da Costa e Filhos	da Costa e Filhos Atelier
222	Jones-Charles	Jones-Charles Networks
223	da Cunha Azevedo S.A.	da Cunha Azevedo S.A. Investimentos
224	Stone Group	Stone Group Sustentável
225	Rios	Rios Edge
226	Cunha - EI	Cunha - EI Networks
227	Vasconcelos Martins S.A.	Vasconcelos Martins S.A. Agency
228	Rodriguez Ltd	Rodriguez Ltd Advisors
229	Alexander PLC	Alexander PLC Investimentos
230	da Cunha Mendonça S.A.	da Cunha Mendonça S.A. Soluções
231	Holmes-Smith	Holmes-Smith Estilo
232	Patel, Reyes and Chang	Patel, Reyes and Chang Finanças
233	Dias	Dias Logística
234	Ruiz, Norman and Garcia	Ruiz, Norman and Garcia Soluções
235	Berry-Watts	Berry-Watts Varejo
236	da Rocha	da Rocha Next
237	Ruiz Ltd	Ruiz Ltd Tech
238	Campos Barbosa S/A	Campos Barbosa S/A Academia
239	Washington, Bates and Taylor	Washington, Bates and Taylor Solutions
240	Sampaio S/A	Sampaio S/A Wellness
241	York-Frye	York-Frye Engine
242	Duran Inc	Duran Inc Atelier
243	Yang, Rowe and Thompson	Yang, Rowe and Thompson Advisors
244	Cirino	Cirino Works
245	Campbell, Green and Smith	Campbell, Green and Smith Transportes
246	Fox-Mann	Fox-Mann Universal
247	Henderson, Johnson and Wood	Henderson, Johnson and Wood Educação
248	Sellers, Higgins and Holland	Sellers, Higgins and Holland Private
249	Russo-Parker	Russo-Parker International
250	da Mota	da Mota Alimentos
251	Adams and Sons	Adams and Sons Soluções
252	Henderson LLC	Henderson LLC Inovação
253	Câmara	Câmara Academia
254	Gutierrez, Castillo and Moreno	Gutierrez, Castillo and Moreno Factory
255	Freitas Araújo S/A	Freitas Araújo S/A Finanças
256	Foster LLC	Foster LLC Digital
257	Hutchinson Group	Hutchinson Group Legal
258	Odonnell Ltd	Odonnell Ltd Advocacia
259	Flores-Skinner	Flores-Skinner Delícias
260	Vasconcelos	Vasconcelos Partners
261	Moraes Pimenta S/A	Moraes Pimenta S/A Worldwide
262	Noble-Chavez	Noble-Chavez Solutions
263	Pastor	Pastor Boutique
264	Bray, Hall and Patterson	Bray, Hall and Patterson Studio
265	Higgins, Salazar and Miller	Higgins, Salazar and Miller Consulting
266	da Mota Andrade e Filhos	da Mota Andrade e Filhos Treinamento
267	Melendez and Sons	Melendez and Sons Boutique
268	Montgomery PLC	Montgomery PLC Labs
269	Sá Castro e Filhos	Sá Castro e Filhos Legal
270	Scott-Wright	Scott-Wright Capital
271	Azevedo Barros S/A	Azevedo Barros S/A Ambiental
272	Jackson Inc	Jackson Inc Labs
273	Rocha	Rocha Consultoria
274	Casa Grande Castro S/A	Casa Grande Castro S/A Ambiental
275	Lopes	Lopes Clinic
276	Nunes Cardoso - ME	Nunes Cardoso - ME Factory
277	da Cunha	da Cunha Jurídico
278	Powell-Benton	Powell-Benton Operações
279	Johnson, Young and Garcia	Johnson, Young and Garcia Advocacia
280	Norton and Sons	Norton and Sons Next
281	Bryan PLC	Bryan PLC Alimentos
282	Caldeira	Caldeira Systems
283	Baker, Lamb and Peterson	Baker, Lamb and Peterson Boutique
284	Morrow LLC	Morrow LLC Private
285	Fleming LLC	Fleming LLC Holdings
286	Rodriguez-Miranda	Rodriguez-Miranda Estilo
287	Allen Inc	Allen Inc Labs
288	Martinez, Kim and Copeland	Martinez, Kim and Copeland Eco
289	Souza Oliveira S.A.	Souza Oliveira S.A. Creative
290	Nogueira Ltda.	Nogueira Ltda. Edge
291	Jones, Chambers and Williams	Jones, Chambers and Williams Co
292	Siqueira e Filhos	Siqueira e Filhos Gastronomia
293	Dawson, Bennett and Munoz	Dawson, Bennett and Munoz Creative
294	Williams, Figueroa and Brown	Williams, Figueroa and Brown Investimentos
295	Weiss and Sons	Weiss and Sons Wellness
296	das Neves - ME	das Neves - ME Clinic
297	King-Gross	King-Gross Next
298	Hernandez-Schmidt	Hernandez-Schmidt Eco
299	Rhodes-Wilkerson	Rhodes-Wilkerson Clinic
300	Clark Group	Clark Group Design
301	Câmara Ltda.	Câmara Ltda. Prime
302	Oliveira Mendes - ME	Oliveira Mendes - ME Moda
303	Barron Ltd	Barron Ltd Advocacia
304	Rios - EI	Rios - EI International
305	da Mata	da Mata Strategies
306	Morris, Wall and Brown	Morris, Wall and Brown Culinária
307	Moore-Hernandez	Moore-Hernandez Factory
308	Webster-Johnson	Webster-Johnson Culinária
309	Gomes Novais Ltda.	Gomes Novais Ltda. Networks
310	Costela Pinto - ME	Costela Pinto - ME Tecnologia
311	Thornton-Allen	Thornton-Allen Partners
312	Costa, Frank and Scott	Costa, Frank and Scott Construções
313	Mendes S/A	Mendes S/A Operações
314	Borges Rezende S.A.	Borges Rezende S.A. Smart
315	Russell Group	Russell Group Tecnologia
316	Fonseca e Filhos	Fonseca e Filhos Eco
317	Huffman-Haynes	Huffman-Haynes Eco
318	Blackburn LLC	Blackburn LLC Advocacia
319	Aparecida S/A	Aparecida S/A Delícias
737	da Luz S.A.	da Luz S.A. Academia
320	Cassiano - EI	Cassiano - EI Services
321	Miller PLC	Miller PLC Edge
322	Pimenta Garcia S.A.	Pimenta Garcia S.A. Advocacia
323	Vega Inc	Vega Inc Construções
324	Leach Group	Leach Group Eco
325	Moreira Duarte S.A.	Moreira Duarte S.A. Consultoria
326	Peixoto Brito S/A	Peixoto Brito S/A Worldwide
327	Terrell-Jones	Terrell-Jones Studio
328	das Neves Moura e Filhos	das Neves Moura e Filhos Tecnologia
329	Byrd and Sons	Byrd and Sons Consulting
330	Lee Group	Lee Group Agency
331	Medina, Clark and Williams	Medina, Clark and Williams Investimentos
332	Andrade	Andrade Comércio
333	Martinez, Patel and Ross	Martinez, Patel and Ross Grupo
334	Day-Garcia	Day-Garcia Distribuidora
335	Sousa Guerra S/A	Sousa Guerra S/A Construções
336	Thompson LLC	Thompson LLC Inteligência
337	Schmidt PLC	Schmidt PLC Imobiliária
338	Pires - ME	Pires - ME Serviços
339	Lee, Hayes and Diaz	Lee, Hayes and Diaz Imobiliária
340	Gates Group	Gates Group Culinária
341	Jones Ltd	Jones Ltd Atacado
342	Johnson, Blevins and Molina	Johnson, Blevins and Molina Capital
343	Matthews-Conway	Matthews-Conway Verde
344	Henry-Day	Henry-Day Global
345	Fernandes	Fernandes Grupo
346	Gutierrez-Mckee	Gutierrez-Mckee Grupo
347	Peixoto	Peixoto Distribuidora
348	Thompson, Benson and Stewart	Thompson, Benson and Stewart Consultoria
349	Smith-Mora	Smith-Mora Platform
350	Castro Cardoso - EI	Castro Cardoso - EI Agency
351	Taylor Inc	Taylor Inc Inteligência
352	Dias e Filhos	Dias e Filhos Educação
353	Freitas	Freitas Tecnologia
354	Wolfe LLC	Wolfe LLC Holdings
355	Franco Group	Franco Group Delícias
356	Bradley-Holland	Bradley-Holland Moda
357	Baker-Maxwell	Baker-Maxwell Edge
358	Barros - ME	Barros - ME Legal
359	Siqueira - EI	Siqueira - EI Sustentável
360	Johnson, Lewis and Anthony	Johnson, Lewis and Anthony Varejo
361	Davis-Clark	Davis-Clark Frete
362	George-Jacobs	George-Jacobs Soluções
363	Jesus e Filhos	Jesus e Filhos Co
364	Gomes	Gomes Strategies
365	Duarte da Rocha Ltda.	Duarte da Rocha Ltda. Engine
366	Cassiano	Cassiano Engine
367	Jordan-Castillo	Jordan-Castillo Transportes
368	Castro	Castro Tecnologia
369	Harris, Duke and Morrow	Harris, Duke and Morrow Works
370	Robertson and Sons	Robertson and Sons Educação
371	Harvey and Sons	Harvey and Sons Inteligência
372	Williams-Underwood	Williams-Underwood Hub
373	Lambert Inc	Lambert Inc Logística
374	Martin and Sons	Martin and Sons Empreendimentos
375	da Cunha Vasconcelos - ME	da Cunha Vasconcelos - ME Comércio
376	Monroe Inc	Monroe Inc Operações
377	Fischer, Wood and Carroll	Fischer, Wood and Carroll Labs
378	Smith-Bentley	Smith-Bentley Universal
379	Moraes da Cunha S.A.	Moraes da Cunha S.A. Clinic
380	Siqueira Rios S.A.	Siqueira Rios S.A. Atacado
381	Burgess PLC	Burgess PLC Works
382	Alves Cunha - EI	Alves Cunha - EI Systems
383	Williams, Woodard and York	Williams, Woodard and York Academia
384	da Costa Alves S/A	da Costa Alves S/A Treinamento
385	Castro Porto e Filhos	Castro Porto e Filhos Imobiliária
386	da Rosa Mendes - EI	da Rosa Mendes - EI Studio
387	Wilson PLC	Wilson PLC Serviços
388	Moraes Pacheco Ltda.	Moraes Pacheco Ltda. Clinic
389	Sharp and Sons	Sharp and Sons Partners
390	Sousa Mendes S.A.	Sousa Mendes S.A. Gastronomia
391	Drake Group	Drake Group Smart
392	Sousa e Filhos	Sousa e Filhos Co
393	Williams-Grant	Williams-Grant Alimentos
394	Hensley PLC	Hensley PLC Agency
395	Bartlett PLC	Bartlett PLC Treinamento
396	Lee Ltd	Lee Ltd Wellness
397	Grant PLC	Grant PLC Transportes
398	Alves Rocha Ltda.	Alves Rocha Ltda. Delícias
399	Pimenta	Pimenta Operações
400	Farias e Filhos	Farias e Filhos Strategies
401	Paul, Burke and Gomez	Paul, Burke and Gomez Factory
402	Camargo Cavalcante e Filhos	Camargo Cavalcante e Filhos Estilo
403	Viana Siqueira - ME	Viana Siqueira - ME Prime
404	Vieira Machado - ME	Vieira Machado - ME Platform
405	Ryan, Caldwell and Bond	Ryan, Caldwell and Bond Tecnologia
406	Hanson-Lopez	Hanson-Lopez Factory
407	Martin-Carter	Martin-Carter Investimentos
408	Moraes	Moraes Tecnologia
409	Martins Borges - EI	Martins Borges - EI Prime
410	Mason-Ramos	Mason-Ramos Healthcare
411	Martin, Butler and Anderson	Martin, Butler and Anderson Studio
412	Curtis-Kent	Curtis-Kent Digital
413	Moss, Wallace and Mcmillan	Moss, Wallace and Mcmillan Grupo
414	Goodman, Chen and Cortez	Goodman, Chen and Cortez Tecnologia
415	Adams-Lewis	Adams-Lewis Moda
416	Araújo	Araújo Moda
417	Adams-Walker	Adams-Walker Creative
418	Oliveira	Oliveira Services
419	Peixoto - ME	Peixoto - ME Culinária
420	Cavalcanti e Filhos	Cavalcanti e Filhos Tech
421	Costela	Costela Studio
422	Washington LLC	Washington LLC Solutions
423	Silva S/A	Silva S/A Platform
424	Machado Casa Grande e Filhos	Machado Casa Grande e Filhos Hub
425	Allen-Barnes	Allen-Barnes Eco
426	Nguyen, Bradley and Torres	Nguyen, Bradley and Torres Legal
427	Duarte	Duarte Soluções
428	Hill, Chavez and Palmer	Hill, Chavez and Palmer Verde
429	Albuquerque Freitas S.A.	Albuquerque Freitas S.A. Imobiliária
430	Sales Rezende e Filhos	Sales Rezende e Filhos Alimentos
431	Myers PLC	Myers PLC Jurídico
432	Moreira Ltda.	Moreira Ltda. Clinic
433	Mendes Souza Ltda.	Mendes Souza Ltda. Advocacia
434	Price, Moreno and Dean	Price, Moreno and Dean Inovação
435	Azevedo	Azevedo Labs
436	Johnson, Morrison and Robles	Johnson, Morrison and Robles International
437	Moreira Carvalho S.A.	Moreira Carvalho S.A. Factory
438	Ward Ltd	Ward Ltd Solutions
439	Boyd, Daniel and Jones	Boyd, Daniel and Jones Consulting
440	Siqueira	Siqueira Enterprises
441	Stevens-Allen	Stevens-Allen Services
442	Marques - ME	Marques - ME Design
443	Long-Wilson	Long-Wilson Ambiental
444	Peixoto S/A	Peixoto S/A Eco
445	Chen and Sons	Chen and Sons Prime
446	Chapman-Nelson	Chapman-Nelson Networks
447	Davis-Mccoy	Davis-Mccoy Obras
448	Scott, Carroll and Jensen	Scott, Carroll and Jensen Advocacia
449	Rezende Ltda.	Rezende Ltda. Moda
450	Vasconcelos S/A	Vasconcelos S/A Eco
451	Kelley, Ford and Ayala	Kelley, Ford and Ayala Worldwide
452	Harding, Jones and Warren	Harding, Jones and Warren Frete
453	Cassiano Siqueira e Filhos	Cassiano Siqueira e Filhos Healthcare
454	Montenegro Rocha S/A	Montenegro Rocha S/A Healthcare
455	Martins - EI	Martins - EI Enterprises
456	Cavalcante	Cavalcante Hub
457	Thomas-Ramirez	Thomas-Ramirez Enterprises
458	Graham, Porter and Sherman	Graham, Porter and Sherman Inovação
459	Klein LLC	Klein LLC Estilo
460	Nogueira S.A.	Nogueira S.A. Gastronomia
461	Harmon, Patel and Roberts	Harmon, Patel and Roberts Smart
462	Campos, Hayes and Camacho	Campos, Hayes and Camacho Wellness
463	Câmara Santos S.A.	Câmara Santos S.A. Distribuidora
464	Mullins-Whitney	Mullins-Whitney Solutions
465	Jones-Bentley	Jones-Bentley Labs
466	Nunes	Nunes Eco
467	Correia Farias e Filhos	Correia Farias e Filhos Varejo
468	Correia - EI	Correia - EI Holdings
469	Vieira - EI	Vieira - EI Worldwide
470	Joseph Ltd	Joseph Ltd Estilo
471	Gomez-Hernandez	Gomez-Hernandez Solutions
472	King-Munoz	King-Munoz Investimentos
473	Baker, Nicholson and Conway	Baker, Nicholson and Conway Verde
474	Abreu S.A.	Abreu S.A. Serviços
475	Johnson-Mathews	Johnson-Mathews Alimentos
476	Morrow Inc	Morrow Inc Studio
477	Davila and Sons	Davila and Sons Atelier
478	da Conceição Ferreira - ME	da Conceição Ferreira - ME Next
479	Ramos and Sons	Ramos and Sons Labs
480	Saunders and Sons	Saunders and Sons Global
481	Paul LLC	Paul LLC Labs
482	Castro Silveira e Filhos	Castro Silveira e Filhos Design
483	Simon, Elliott and Hays	Simon, Elliott and Hays Varejo
484	Monteiro	Monteiro Systems
485	Santos	Santos Educação
486	Dias Abreu - ME	Dias Abreu - ME Holdings
487	Cavalcanti da Costa S.A.	Cavalcanti da Costa S.A. Strategies
488	Long-Marshall	Long-Marshall Next
489	Barros da Rosa Ltda.	Barros da Rosa Ltda. Atelier
490	Peixoto Ltda.	Peixoto Ltda. Private
491	Santos da Luz Ltda.	Santos da Luz Ltda. Transportes
492	Robinson-Harris	Robinson-Harris Legal
493	Foster Inc	Foster Inc Capital
494	Sá - EI	Sá - EI Verde
495	Novais e Filhos	Novais e Filhos Strategies
496	Gonçalves S.A.	Gonçalves S.A. Smart
497	Moreira	Moreira Sustentável
498	da Mata Cardoso S/A	da Mata Cardoso S/A Operações
499	Lindsey, Parker and Delgado	Lindsey, Parker and Delgado Grupo
500	Rodgers, Willis and Fisher	Rodgers, Willis and Fisher Legal
501	Sellers-Webb	Sellers-Webb Grupo
502	Dias S/A	Dias S/A Transportes
503	Araújo Barros S/A	Araújo Barros S/A Culinária
504	Knight LLC	Knight LLC Healthcare
505	Willis-Nichols	Willis-Nichols Holdings
506	Mendes Ltda.	Mendes Ltda. Varejo
507	Banks, Evans and Boyer	Banks, Evans and Boyer Estilo
508	Terry, Hatfield and Lawrence	Terry, Hatfield and Lawrence Smart
509	Rios Ltda.	Rios Ltda. Consultoria
510	da Mota Ltda.	da Mota Ltda. Ambiental
511	Dunn LLC	Dunn LLC Verde
512	Jacobson-Taylor	Jacobson-Taylor Atelier
513	Odonnell, Wright and Alvarado	Odonnell, Wright and Alvarado Inovação
514	Mccarthy-Contreras	Mccarthy-Contreras Imobiliária
515	Barbosa	Barbosa Imobiliária
516	Hanson-Allen	Hanson-Allen Soluções
517	Araújo Moraes - EI	Araújo Moraes - EI Consulting
518	Macedo Almeida e Filhos	Macedo Almeida e Filhos Healthcare
519	Novaes Carvalho - EI	Novaes Carvalho - EI Academia
520	Hernandez-Mitchell	Hernandez-Mitchell Atelier
521	Bush Inc	Bush Inc Smart
522	Gay-Ryan	Gay-Ryan Tecnologia
523	Ribeiro	Ribeiro Design
524	Viana S/A	Viana S/A Co
525	Lewis Inc	Lewis Inc Gastronomia
526	da Mota Aparecida S/A	da Mota Aparecida S/A Design
527	Gomes Rios - ME	Gomes Rios - ME Treinamento
528	Lopez, Perez and Dodson	Lopez, Perez and Dodson Formação
529	Nelson-Johnson	Nelson-Johnson Estilo
530	Sousa Nunes - EI	Sousa Nunes - EI Formação
531	Newman-Moore	Newman-Moore Culinária
532	Hernandez-Powell	Hernandez-Powell Consultoria
533	Pinto	Pinto Solutions
534	Cook, Wood and Jackson	Cook, Wood and Jackson Formação
535	Cavalcante da Mota e Filhos	Cavalcante da Mota e Filhos Transportes
536	Macedo S/A	Macedo S/A Varejo
537	da Cruz S/A	da Cruz S/A Tecnologia
538	Kelly-Velasquez	Kelly-Velasquez Clinic
539	da Luz	da Luz Wellness
540	Wagner LLC	Wagner LLC Comércio
541	Tucker, Cordova and Freeman	Tucker, Cordova and Freeman Delícias
542	Mitchell, Rose and Thomas	Mitchell, Rose and Thomas Engine
543	Cavalcanti da Conceição Ltda.	Cavalcanti da Conceição Ltda. Tecnologia
544	Pereira	Pereira Academia
545	Lawrence-Holmes	Lawrence-Holmes Smart
546	Bradley Inc	Bradley Inc Design
547	Fields, Murphy and Owens	Fields, Murphy and Owens Serviços
548	Dias S.A.	Dias S.A. Transportes
549	Melo Nogueira - ME	Melo Nogueira - ME Eco
550	Harris, Harris and Chan	Harris, Harris and Chan Clinic
551	Peixoto Moura S/A	Peixoto Moura S/A Varejo
552	Jefferson-Taylor	Jefferson-Taylor Construções
553	Brooks, Smith and Combs	Brooks, Smith and Combs Obras
554	Ruiz-Rodriguez	Ruiz-Rodriguez Transportes
555	Sousa - EI	Sousa - EI Delícias
556	Monteiro Costela - ME	Monteiro Costela - ME Educação
557	Campos	Campos Platform
558	Taylor, Davis and Robinson	Taylor, Davis and Robinson Ambiental
559	Crawford, Weiss and Travis	Crawford, Weiss and Travis Logística
560	Lima Souza - EI	Lima Souza - EI Healthcare
561	Brewer, Webb and Bentley	Brewer, Webb and Bentley Distribuidora
562	Dyer, Schultz and Stark	Dyer, Schultz and Stark Distribuidora
563	Arias, Rodriguez and Klein	Arias, Rodriguez and Klein Obras
564	Watts, Stanley and Green	Watts, Stanley and Green Factory
565	Correia	Correia Consultoria
566	Carvalho Santos Ltda.	Carvalho Santos Ltda. Ambiental
567	Bennett-Molina	Bennett-Molina Enterprises
568	Moreira Cardoso e Filhos	Moreira Cardoso e Filhos Grupo
569	Taylor-Navarro	Taylor-Navarro Construções
570	Duran, Gallagher and Patton	Duran, Gallagher and Patton Capital
571	Davis Inc	Davis Inc Atelier
572	Carlson Group	Carlson Group Estilo
573	Gonzalez, Spence and Clark	Gonzalez, Spence and Clark Atacado
574	Ferreira Nunes S.A.	Ferreira Nunes S.A. Formação
575	Kelly-Acosta	Kelly-Acosta Clinic
576	Ramirez, Cox and Carpenter	Ramirez, Cox and Carpenter Consultoria
577	Sousa	Sousa Delícias
578	Mendonça Nunes e Filhos	Mendonça Nunes e Filhos International
579	Gonzalez LLC	Gonzalez LLC Capital
580	Alves	Alves Formação
581	Daugherty-Montoya	Daugherty-Montoya Digital
582	Carroll Group	Carroll Group International
583	Teixeira Alves - ME	Teixeira Alves - ME Atacado
584	da Mata - EI	da Mata - EI Eco
585	Guzman, Hicks and Carter	Guzman, Hicks and Carter Boutique
586	Williams, Lopez and Gomez	Williams, Lopez and Gomez Labs
587	das Neves Cirino S/A	das Neves Cirino S/A Academia
588	Valencia PLC	Valencia PLC Sustentável
589	Woodward Inc	Woodward Inc Estilo
590	Murphy Inc	Murphy Inc Enterprises
591	Martinez-Daugherty	Martinez-Daugherty Inovação
592	Cunha - ME	Cunha - ME Advocacia
593	Morales-Hernandez	Morales-Hernandez Clinic
594	Nash PLC	Nash PLC Grupo
595	Cunha	Cunha Services
596	Barros Rocha - ME	Barros Rocha - ME Next
597	Rocha Abreu S/A	Rocha Abreu S/A Frete
598	da Mota S.A.	da Mota S.A. Prime
599	Hernandez PLC	Hernandez PLC Legal
600	Scott-Carter	Scott-Carter Treinamento
601	Ferreira	Ferreira Services
602	das Neves Lopes e Filhos	das Neves Lopes e Filhos Digital
603	Hogan, Wilson and Hayes	Hogan, Wilson and Hayes Comércio
604	May Inc	May Inc Digital
605	das Neves Almeida Ltda.	das Neves Almeida Ltda. Empreendimentos
606	Azevedo Brito - ME	Azevedo Brito - ME Co
607	da Cruz	da Cruz Strategies
608	Vance Ltd	Vance Ltd Culinária
609	Ribeiro e Filhos	Ribeiro e Filhos Edge
610	Thomas-Vargas	Thomas-Vargas Finanças
611	Copeland and Sons	Copeland and Sons Capital
612	Cobb-Stone	Cobb-Stone Labs
613	Williams, Bartlett and Mann	Williams, Bartlett and Mann Networks
614	Stafford and Sons	Stafford and Sons Enterprises
615	Brito	Brito Prime
616	Machado Vieira e Filhos	Machado Vieira e Filhos Global
617	Silveira Novaes S.A.	Silveira Novaes S.A. Next
618	Wilson-Vasquez	Wilson-Vasquez Private
619	Caldeira Ltda.	Caldeira Ltda. Academia
620	Silva, Stone and Young	Silva, Stone and Young Agency
621	Hodge, Williams and Brown	Hodge, Williams and Brown Wellness
622	Santos Ltda.	Santos Ltda. Solutions
623	Moraes e Filhos	Moraes e Filhos Co
624	Mitchell Group	Mitchell Group Tecnologia
625	Armstrong and Sons	Armstrong and Sons Delícias
626	Chandler, Rodriguez and Cunningham	Chandler, Rodriguez and Cunningham Factory
627	Lima	Lima Boutique
628	Miller, Velez and Harris	Miller, Velez and Harris Hub
629	Caldwell and Sons	Caldwell and Sons Strategies
630	Porto	Porto Private
631	Jones Group	Jones Group Engine
632	Freitas Carvalho S/A	Freitas Carvalho S/A Design
633	Porto Farias e Filhos	Porto Farias e Filhos Factory
634	Arnold, Blake and Tucker	Arnold, Blake and Tucker Inovação
635	Huff and Sons	Huff and Sons Consulting
636	Sampaio e Filhos	Sampaio e Filhos Serviços
637	Young, Simmons and Wright	Young, Simmons and Wright Atelier
638	Costela Pinto e Filhos	Costela Pinto e Filhos Obras
639	Camargo Almeida - ME	Camargo Almeida - ME Strategies
640	Moreira Pires S/A	Moreira Pires S/A Prime
641	Bailey LLC	Bailey LLC Distribuidora
642	Jackson-Boyd	Jackson-Boyd Factory
643	Dias - ME	Dias - ME Global
644	Aparecida	Aparecida Factory
645	Moreno, Pena and Boyd	Moreno, Pena and Boyd Empreendimentos
646	Cassiano - ME	Cassiano - ME Transportes
647	Smith Group	Smith Group Atelier
648	Sullivan Ltd	Sullivan Ltd Inovação
649	Cavalcante - EI	Cavalcante - EI Factory
650	da Rosa S/A	da Rosa S/A Hub
651	Brito - EI	Brito - EI Legal
652	Vargas	Vargas Frete
653	Martinez, Dominguez and Burke	Martinez, Dominguez and Burke Services
654	Costa	Costa Advisors
655	Mccann, Collins and Bates	Mccann, Collins and Bates Medical
656	da Costa Ltda.	da Costa Ltda. Partners
657	Abreu S/A	Abreu S/A Verde
658	Cavalcanti Ramos Ltda.	Cavalcanti Ramos Ltda. Agency
659	Perry, Matthews and Gordon	Perry, Matthews and Gordon International
660	Richardson, Harris and Baker	Richardson, Harris and Baker Labs
661	Faulkner-Oliver	Faulkner-Oliver Tecnologia
662	Pacheco	Pacheco Clinic
663	Vieira Ltda.	Vieira Ltda. Estilo
664	Hunt-Smith	Hunt-Smith Estilo
665	Villegas-Williams	Villegas-Williams Partners
666	Aparecida Câmara S.A.	Aparecida Câmara S.A. Strategies
667	Barros Vargas - ME	Barros Vargas - ME Distribuidora
668	Gray Inc	Gray Inc Networks
669	Green-Garcia	Green-Garcia Imobiliária
670	Rose PLC	Rose PLC Treinamento
671	Alves Ribeiro S.A.	Alves Ribeiro S.A. Prime
672	Pereira Nogueira S.A.	Pereira Nogueira S.A. Treinamento
673	Cavalcante - ME	Cavalcante - ME Logística
674	Pereira da Luz e Filhos	Pereira da Luz e Filhos Frete
675	Wright, Stevenson and Wong	Wright, Stevenson and Wong Alimentos
676	Mcintosh Ltd	Mcintosh Ltd Works
677	Souza e Filhos	Souza e Filhos Capital
678	da Costa - ME	da Costa - ME Solutions
679	Flores-Savage	Flores-Savage Tecnologia
680	Johnston-Valdez	Johnston-Valdez Healthcare
681	Costela Borges e Filhos	Costela Borges e Filhos Smart
682	Sá da Cunha - ME	Sá da Cunha - ME Labs
683	Rogers-Holt	Rogers-Holt International
684	Choi, Miller and Jones	Choi, Miller and Jones Edge
685	da Costa Andrade Ltda.	da Costa Andrade Ltda. Soluções
686	Rezende	Rezende Design
687	Waters and Sons	Waters and Sons Culinária
688	Barbosa S.A.	Barbosa S.A. Boutique
689	Cassiano Camargo - ME	Cassiano Camargo - ME Consulting
690	Guerra	Guerra Formação
691	Cassiano Rezende e Filhos	Cassiano Rezende e Filhos Moda
692	Mullen-Bishop	Mullen-Bishop Edge
693	Brito Cardoso Ltda.	Brito Cardoso Ltda. Worldwide
694	Montgomery-Scott	Montgomery-Scott Atacado
695	Smith-Pope	Smith-Pope Healthcare
696	Mckinney and Sons	Mckinney and Sons Design
697	Fox LLC	Fox LLC Next
698	Rocha da Costa Ltda.	Rocha da Costa Ltda. Formação
699	Pires S.A.	Pires S.A. Consultoria
700	Dixon PLC	Dixon PLC Soluções
701	Lopez, Cameron and Farrell	Lopez, Cameron and Farrell Finanças
702	Carvalho Ltda.	Carvalho Ltda. Educação
703	Harris Ltd	Harris Ltd Clinic
704	Araújo Rocha S/A	Araújo Rocha S/A Solutions
705	Caldeira - EI	Caldeira - EI Agency
706	Lima - EI	Lima - EI Strategies
707	Lima Sá Ltda.	Lima Sá Ltda. Clinic
708	Rezende Jesus S.A.	Rezende Jesus S.A. Wellness
709	Andrade Sales Ltda.	Andrade Sales Ltda. Services
710	Melo Azevedo - ME	Melo Azevedo - ME Holdings
711	Holland and Sons	Holland and Sons Digital
712	Vieira	Vieira Ambiental
713	Todd-Torres	Todd-Torres Networks
714	Hines-Mckinney	Hines-Mckinney Obras
715	Valdez-Terry	Valdez-Terry Tech
716	Aparecida Correia Ltda.	Aparecida Correia Ltda. Edge
717	Novaes S/A	Novaes S/A Studio
718	Campos Pimenta Ltda.	Campos Pimenta Ltda. Networks
719	da Conceição Fogaça S.A.	da Conceição Fogaça S.A. Atelier
720	Marques Nogueira - ME	Marques Nogueira - ME Worldwide
721	Moura S/A	Moura S/A Treinamento
722	Brooks-Miller	Brooks-Miller Comércio
723	Brown-Olson	Brown-Olson Legal
724	Lewis, Hunt and Smith	Lewis, Hunt and Smith Solutions
725	Andrade Fonseca S.A.	Andrade Fonseca S.A. Legal
726	Leão - EI	Leão - EI Educação
727	das Neves Viana S/A	das Neves Viana S/A Edge
728	Cavalcante Andrade S/A	Cavalcante Andrade S/A Academia
729	Fonseca S/A	Fonseca S/A Finanças
730	Vasconcelos - EI	Vasconcelos - EI Transportes
731	Pinto e Filhos	Pinto e Filhos Worldwide
732	Pires S/A	Pires S/A Advisors
733	Williams and Sons	Williams and Sons Systems
734	Gomes Teixeira S/A	Gomes Teixeira S/A Consultoria
735	Wilson, Vega and Hernandez	Wilson, Vega and Hernandez Moda
736	Gomez, Stewart and Chapman	Gomez, Stewart and Chapman Empreendimentos
738	Carter, Parker and Smith	Carter, Parker and Smith Medical
739	Turner, Smith and Porter	Turner, Smith and Porter Hub
740	Fonseca	Fonseca Wellness
741	Schaefer-Johnson	Schaefer-Johnson Creative
742	Garcia-Snyder	Garcia-Snyder Medical
743	Jones-White	Jones-White Solutions
744	Mccarthy and Sons	Mccarthy and Sons Finanças
745	Novaes Casa Grande S.A.	Novaes Casa Grande S.A. Empreendimentos
746	Castro Santos e Filhos	Castro Santos e Filhos Empreendimentos
747	Williamson PLC	Williamson PLC Jurídico
748	Calhoun-Rhodes	Calhoun-Rhodes Jurídico
749	Vieira S/A	Vieira S/A Advocacia
750	Smith, Lane and Turner	Smith, Lane and Turner Engine
751	Boyer, Mcguire and Atkinson	Boyer, Mcguire and Atkinson Studio
752	Cook PLC	Cook PLC Finanças
753	Jimenez-Cook	Jimenez-Cook Verde
754	Jenkins-Lopez	Jenkins-Lopez Comércio
755	Walton LLC	Walton LLC International
756	Pires e Filhos	Pires e Filhos Inteligência
757	Fogaça Novaes S/A	Fogaça Novaes S/A Solutions
758	Gonzales LLC	Gonzales LLC Treinamento
759	Sales Pinto e Filhos	Sales Pinto e Filhos Comércio
760	Hughes and Sons	Hughes and Sons Jurídico
761	Lewis-Howard	Lewis-Howard Wellness
762	Pires Silveira S.A.	Pires Silveira S.A. Tech
763	Winters-Phillips	Winters-Phillips Global
764	Chan-Lopez	Chan-Lopez Labs
765	da Paz S/A	da Paz S/A Smart
766	Carpenter, Erickson and Nixon	Carpenter, Erickson and Nixon Networks
767	Cruz, Collins and Moreno	Cruz, Collins and Moreno Gastronomia
768	Beltran-Carroll	Beltran-Carroll Collective
769	Berry, Williams and Nelson	Berry, Williams and Nelson Comércio
770	Lee, Nelson and Valdez	Lee, Nelson and Valdez Enterprises
771	Weaver-Davis	Weaver-Davis Enterprises
772	Mcgrath LLC	Mcgrath LLC Holdings
773	Cirino Pacheco S.A.	Cirino Pacheco S.A. Services
774	Lin-Williams	Lin-Williams Engine
775	Turner-Howard	Turner-Howard Next
776	Andrade - EI	Andrade - EI Services
777	da Mota Montenegro S/A	da Mota Montenegro S/A Engine
778	Hicks Group	Hicks Group Construções
779	Melo S.A.	Melo S.A. Medical
780	Paul-Simpson	Paul-Simpson Advisors
781	Ferreira - ME	Ferreira - ME Agency
782	Garcia PLC	Garcia PLC Educação
783	Martinez-Ayers	Martinez-Ayers Inteligência
784	Aparecida - ME	Aparecida - ME Treinamento
785	Pinto da Mata S.A.	Pinto da Mata S.A. Solutions
786	Hatfield Ltd	Hatfield Ltd Factory
787	Rocha Pereira - EI	Rocha Pereira - EI Obras
788	Carr-Hernandez	Carr-Hernandez Smart
789	Pires	Pires Inteligência
790	Barber-Ramsey	Barber-Ramsey Edge
791	Snyder-Tapia	Snyder-Tapia Edge
792	Bennett, Bowen and Miller	Bennett, Bowen and Miller Universal
793	Vargas - EI	Vargas - EI Culinária
794	da Mata S/A	da Mata S/A Frete
795	Hernandez Ltd	Hernandez Ltd Holdings
796	Porter Group	Porter Group Comércio
797	Johnson-Foley	Johnson-Foley Edge
798	Wilson-Maldonado	Wilson-Maldonado Works
799	Williamson and Sons	Williamson and Sons Advisors
800	Jesus Rocha Ltda.	Jesus Rocha Ltda. Finanças
801	Santos S.A.	Santos S.A. Alimentos
802	Brito e Filhos	Brito e Filhos Legal
803	Miller Ltd	Miller Ltd Medical
804	Cavalcante Peixoto Ltda.	Cavalcante Peixoto Ltda. Consulting
805	da Rosa S.A.	da Rosa S.A. Hub
806	Vance-Haynes	Vance-Haynes Sustentável
807	Mendonça	Mendonça Hub
808	Alexander and Sons	Alexander and Sons Capital
809	Neal Group	Neal Group Clinic
810	Burke-Harris	Burke-Harris Construções
811	Gonçalves da Rocha e Filhos	Gonçalves da Rocha e Filhos Serviços
812	Cunha Correia S.A.	Cunha Correia S.A. Solutions
813	Freitas Nascimento S/A	Freitas Nascimento S/A Private
814	Oliveira Silveira S/A	Oliveira Silveira S/A Enterprises
815	Rezende S.A.	Rezende S.A. Ambiental
816	Machado Cardoso - ME	Machado Cardoso - ME Jurídico
817	Casa Grande Abreu e Filhos	Casa Grande Abreu e Filhos Solutions
818	Holland-Simmons	Holland-Simmons Tech
819	Ray Inc	Ray Inc Finanças
820	Vieira e Filhos	Vieira e Filhos Operações
821	da Cunha Ltda.	da Cunha Ltda. Factory
822	Fonseca Lopes e Filhos	Fonseca Lopes e Filhos Boutique
823	Rodrigues e Filhos	Rodrigues e Filhos Engine
824	Azevedo Ltda.	Azevedo Ltda. Consulting
825	Williams Group	Williams Group Works
826	da Paz Aragão S/A	da Paz Aragão S/A Solutions
827	Ellis LLC	Ellis LLC Tecnologia
828	Barnes, Copeland and Moore	Barnes, Copeland and Moore Wellness
829	Santos S/A	Santos S/A Academia
830	Pimenta S.A.	Pimenta S.A. Agency
831	Nogueira e Filhos	Nogueira e Filhos Atacado
832	Cunha Rios Ltda.	Cunha Rios Ltda. Enterprises
833	Duke, Peterson and Parker	Duke, Peterson and Parker Comércio
834	Barros - EI	Barros - EI Services
835	Cavalcanti Barbosa S.A.	Cavalcanti Barbosa S.A. Inteligência
836	Cassiano Ferreira - EI	Cassiano Ferreira - EI Alimentos
837	Rhodes-Hebert	Rhodes-Hebert Next
838	Crawford-Pham	Crawford-Pham Transportes
839	Oliveira Novais Ltda.	Oliveira Novais Ltda. Eco
840	Edwards PLC	Edwards PLC Operações
841	Garcia Vieira S.A.	Garcia Vieira S.A. Digital
842	Cardoso S/A	Cardoso S/A Strategies
843	Knapp-Little	Knapp-Little Transportes
844	Fernandes da Costa S.A.	Fernandes da Costa S.A. Jurídico
845	Rezende Camargo S/A	Rezende Camargo S/A Finanças
846	Arroyo-Smith	Arroyo-Smith Comércio
847	Price Ltd	Price Ltd Logística
848	Farias da Mata Ltda.	Farias da Mata Ltda. Assessoria
849	Martins S/A	Martins S/A Boutique
850	Carvalho - EI	Carvalho - EI Culinária
851	Woods Ltd	Woods Ltd Hub
852	Pacheco Gonçalves - EI	Pacheco Gonçalves - EI Co
853	Costela Costela - EI	Costela Costela - EI Varejo
854	Vargas S/A	Vargas S/A Advisors
855	Nogueira S/A	Nogueira S/A Logística
856	Smith-Thomas	Smith-Thomas Engine
857	Novaes da Costa - ME	Novaes da Costa - ME Private
858	Figueroa-Gordon	Figueroa-Gordon Assessoria
859	Larsen-Edwards	Larsen-Edwards Alimentos
860	Aragão Duarte - ME	Aragão Duarte - ME Distribuidora
861	Williams Inc	Williams Inc Finanças
862	Nascimento Aparecida S/A	Nascimento Aparecida S/A Prime
863	Costela - ME	Costela - ME Clinic
864	Nogueira Machado Ltda.	Nogueira Machado Ltda. Imobiliária
865	Cavalcante Ferreira - ME	Cavalcante Ferreira - ME Systems
866	da Costa Freitas S/A	da Costa Freitas S/A Construções
867	Alves - EI	Alves - EI Labs
868	Johnson Inc	Johnson Inc Factory
869	Alves e Filhos	Alves e Filhos Co
870	Torres, Williams and Silva	Torres, Williams and Silva Solutions
871	Pereira - ME	Pereira - ME Assessoria
872	Wilson-Wells	Wilson-Wells Clinic
873	Araújo da Mata - ME	Araújo da Mata - ME Advisors
874	Hart Group	Hart Group Moda
875	da Mota - EI	da Mota - EI Worldwide
876	Freitas - EI	Freitas - EI Sustentável
877	da Cruz Sampaio Ltda.	da Cruz Sampaio Ltda. Factory
878	Anderson and Sons	Anderson and Sons Global
879	Oliveira Cavalcanti S.A.	Oliveira Cavalcanti S.A. Worldwide
880	Velez Group	Velez Group Consultoria
881	Williams, Pearson and Thompson	Williams, Pearson and Thompson Educação
882	Pacheco-Kramer	Pacheco-Kramer Solutions
883	Richards-Taylor	Richards-Taylor Factory
884	Garcia, Rivas and Lucas	Garcia, Rivas and Lucas Systems
885	Sousa Monteiro - ME	Sousa Monteiro - ME Medical
886	Casa Grande - ME	Casa Grande - ME Smart
887	Vargas Gomes Ltda.	Vargas Gomes Ltda. Capital
888	Andrade e Filhos	Andrade e Filhos Capital
889	Bell, Morales and Parker	Bell, Morales and Parker Advocacia
890	Quinn PLC	Quinn PLC Finanças
891	Berg-Garcia	Berg-Garcia Jurídico
892	Santos Alves S/A	Santos Alves S/A Comércio
893	Thompson PLC	Thompson PLC Collective
894	Siqueira S/A	Siqueira S/A Jurídico
895	Teixeira e Filhos	Teixeira e Filhos Delícias
896	Yang Ltd	Yang Ltd Advocacia
897	Abreu - ME	Abreu - ME Advocacia
898	Banks Group	Banks Group Assessoria
899	Abreu da Cruz Ltda.	Abreu da Cruz Ltda. Consulting
900	Guerrero, Jordan and Horn	Guerrero, Jordan and Horn Solutions
901	Castro S.A.	Castro S.A. Ambiental
902	Nascimento Campos - ME	Nascimento Campos - ME Operações
903	Monroe, Washington and Sanders	Monroe, Washington and Sanders Universal
904	Pereira Ltda.	Pereira Ltda. Solutions
905	Almeida e Filhos	Almeida e Filhos Networks
906	Sá e Filhos	Sá e Filhos Transportes
907	Morton LLC	Morton LLC Services
908	Avila-Stone	Avila-Stone Grupo
909	Moore, Decker and Davidson	Moore, Decker and Davidson Platform
910	Webb, Rodriguez and Love	Webb, Rodriguez and Love Advocacia
911	Pereira S/A	Pereira S/A Alimentos
912	Marshall and Sons	Marshall and Sons Finanças
913	Gonçalves Albuquerque S.A.	Gonçalves Albuquerque S.A. Labs
914	Lane and Sons	Lane and Sons Educação
915	Camargo - ME	Camargo - ME Educação
916	Casa Grande - EI	Casa Grande - EI Consulting
917	Nunes S.A.	Nunes S.A. Edge
918	Almeida da Luz Ltda.	Almeida da Luz Ltda. Finanças
919	Nogueira Cavalcante - ME	Nogueira Cavalcante - ME Solutions
920	Moreira e Filhos	Moreira e Filhos Universal
921	da Conceição Costela - ME	da Conceição Costela - ME Moda
922	Morris and Sons	Morris and Sons Culinária
923	Brown-Green	Brown-Green Worldwide
924	Pena Inc	Pena Inc Services
925	da Cunha Silva Ltda.	da Cunha Silva Ltda. Moda
926	Bailey PLC	Bailey PLC Tecnologia
927	Ross, Jensen and Wright	Ross, Jensen and Wright Educação
928	Moore, Cook and Grimes	Moore, Cook and Grimes Varejo
929	Warner, Paul and White	Warner, Paul and White Investimentos
930	Wilkins, Richard and Rogers	Wilkins, Richard and Rogers Alimentos
931	Marques Silveira - EI	Marques Silveira - EI Advocacia
932	Stanley, Drake and Holloway	Stanley, Drake and Holloway Empreendimentos
933	Hunt-Campbell	Hunt-Campbell Co
934	Powell, Zimmerman and Rodriguez	Powell, Zimmerman and Rodriguez Hub
935	da Rosa - ME	da Rosa - ME Solutions
936	Davis, Pacheco and Cook	Davis, Pacheco and Cook Verde
937	Singh-Peterson	Singh-Peterson Comércio
938	Lima S/A	Lima S/A Consultoria
939	Duarte Ltda.	Duarte Ltda. Serviços
940	Robinson, Caldwell and Gonzalez	Robinson, Caldwell and Gonzalez Factory
941	Gomes Oliveira Ltda.	Gomes Oliveira Ltda. Agency
942	Austin Group	Austin Group Frete
943	Baker, Garza and Miller	Baker, Garza and Miller Services
944	Johnson-Johnson	Johnson-Johnson Design
945	Pacheco das Neves - ME	Pacheco das Neves - ME Private
946	Vargas Pacheco e Filhos	Vargas Pacheco e Filhos Delícias
947	Marques Borges S.A.	Marques Borges S.A. Inteligência
948	Gonçalves - ME	Gonçalves - ME Prime
949	Vargas S.A.	Vargas S.A. Estilo
950	Ray, Wright and Poole	Ray, Wright and Poole Clinic
951	Vasconcelos - ME	Vasconcelos - ME Atelier
952	Nascimento Garcia e Filhos	Nascimento Garcia e Filhos Assessoria
953	Perkins LLC	Perkins LLC Consulting
954	Brown, Johnson and Hanson	Brown, Johnson and Hanson Educação
955	Ward-Medina	Ward-Medina Alimentos
956	Wagner, Richards and Cunningham	Wagner, Richards and Cunningham Legal
957	Calderon, Morales and Rodriguez	Calderon, Morales and Rodriguez Solutions
958	Costela - EI	Costela - EI Advisors
959	Lynch PLC	Lynch PLC Moda
960	Taylor Group	Taylor Group Soluções
961	Roberts LLC	Roberts LLC Factory
962	Novaes Aragão e Filhos	Novaes Aragão e Filhos Networks
963	Ferreira Almeida Ltda.	Ferreira Almeida Ltda. Eco
964	Mendes da Mata S.A.	Mendes da Mata S.A. Consulting
965	Greer Inc	Greer Inc Worldwide
966	Mendes	Mendes Boutique
967	Garcia-Fowler	Garcia-Fowler Construções
968	George Group	George Group Universal
969	Howard-Williams	Howard-Williams Edge
970	Crosby, Moore and Gonzalez	Crosby, Moore and Gonzalez Agency
971	Fernandes Leão Ltda.	Fernandes Leão Ltda. Imobiliária
972	Alves Casa Grande Ltda.	Alves Casa Grande Ltda. Academia
973	Barros Ltda.	Barros Ltda. Advisors
974	Young Group	Young Group Boutique
975	Flores Group	Flores Group Digital
976	Watson LLC	Watson LLC Sustentável
977	Borges Teixeira e Filhos	Borges Teixeira e Filhos Digital
978	Brown Ltd	Brown Ltd Tecnologia
979	Machado Melo Ltda.	Machado Melo Ltda. Gastronomia
980	Moraes Cavalcante e Filhos	Moraes Cavalcante e Filhos Partners
981	Mills, Marks and Flores	Mills, Marks and Flores Assessoria
982	Porto Rodrigues - EI	Porto Rodrigues - EI Wellness
983	Shepard-Hall	Shepard-Hall Tecnologia
984	Patrick-Morrow	Patrick-Morrow Educação
985	Foster, Reilly and Young	Foster, Reilly and Young Grupo
986	Vasconcelos Pimenta - EI	Vasconcelos Pimenta - EI Inteligência
987	Cain Ltd	Cain Ltd Medical
988	Gonçalves da Paz S.A.	Gonçalves da Paz S.A. Assessoria
989	Navarro-Jarvis	Navarro-Jarvis Operações
990	Landry, Dominguez and Santana	Landry, Dominguez and Santana Edge
991	Lima Vasconcelos S.A.	Lima Vasconcelos S.A. Clinic
992	Vieira Pinto - ME	Vieira Pinto - ME Hub
993	Melo Ltda.	Melo Ltda. Construções
994	Strong, Smith and Holland	Strong, Smith and Holland Serviços
995	Vasconcelos Ltda.	Vasconcelos Ltda. Transportes
996	Ferreira Ltda.	Ferreira Ltda. Construções
997	Smith, Hernandez and Wilson	Smith, Hernandez and Wilson Finanças
998	Sampaio Garcia S.A.	Sampaio Garcia S.A. Agency
999	Cavalcanti Azevedo S/A	Cavalcanti Azevedo S/A Ambiental
1000	Alves Pereira - EI	Alves Pereira - EI Eco
\.


--
-- TOC entry 5252 (class 0 OID 16498)
-- Dependencies: 237
-- Data for Name: empresa_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa_pais (nro_empresa, id_nacional, nome_pais) FROM stdin;
659	LES-163224861	Lesotho
1000	SOL-899204075	Solomon Islands
403	SUR-899391266	Suriname
339	ARM-955632745	Armenia
227	ANG-705673576	Angola
794	SEY-434812386	Seychelles
476	SOU-114544639	South Korea
209	GIB-577818312	Gibraltar
905	ARU-248277694	Aruba
73	THA-886136822	Thailand
178	KEN-520684052	Kenya
692	JOR-787632157	Jordan
54	BAH-263819840	Bosnia and Herzegovina
778	JAP-977376436	Japan
870	ARM-093508556	Armenia
586	PUE-865684939	Puerto Rico
348	POL-899339875	Poland
766	MAL-491588354	Malawi
792	SER-342859354	Serbia
676	HUN-487489894	Hungary
761	BAN-717794994	Bangladesh
236	UAE-376144579	United Arab Emirates
386	AFG-206732102	Afghanistan
687	UZB-153476491	Uzbekistan
477	ARG-399143505	Argentina
679	UGA-631427771	Uganda
912	NAM-195489165	Namibia
404	JAP-620828042	Japan
11	ESW-143837624	Eswatini
618	CAM-472453018	Cambodia
209	SEY-420507384	Seychelles
539	ISR-724529316	Israel
763	MAL-905384778	Maldives
644	WAF-502521280	Wallis and Futuna
126	ARG-780809618	Argentina
514	SWE-057266317	Sweden
966	NEP-452088305	Nepal
381	MAU-802994003	Mauritius
341	SOU-403066337	South Korea
269	WES-368397001	Western Sahara
773	CHI-165502541	Chile
407	TUN-500531507	Tunisia
219	POL-549714789	Poland
716	CAR-718362600	Central African Republic
854	GUI-246548293	Guinea
162	PUE-247704877	Puerto Rico
877	MAU-727078240	Mauritius
782	SAI-257181551	Saint Helena, Ascension and Tristan da Cunha
62	SUD-556266605	Sudan
672	KUW-396581980	Kuwait
830	LEB-557138848	Lebanon
871	RWA-283642479	Rwanda
737	SIN-481072885	Singapore
774	MAL-364570169	Maldives
722	BOT-600926410	Botswana
763	COS-698607638	Costa Rica
668	PER-004401201	Peru
979	UGA-687982446	Uganda
578	BEL-323676018	Belize
339	TUR-263350878	Turkmenistan
578	SIN-169047074	Singapore
785	CAP-820535875	Cape Verde
479	IRA-288887398	Iraq
507	SER-404487621	Serbia
99	PUE-267796433	Puerto Rico
437	DOM-126360778	Dominican Republic
73	COM-860946803	Comoros
742	SER-455707480	Serbia
128	GUA-347982927	Guatemala
651	QAT-566119693	Qatar
713	SRI-629221471	Sri Lanka
875	PER-057502100	Peru
428	IVO-834113347	Ivory Coast
598	ERI-698793311	Eritrea
470	ICE-688523370	Iceland
854	SOM-980772120	Somalia
822	RUS-117009150	Russia
225	COM-958184246	Comoros
237	PAR-687408212	Paraguay
898	CAY-443782700	Cayman Islands
188	DR -610613282	DR Congo
843	SOU-165945413	South Korea
153	LAO-709654069	Laos
498	AZE-969736079	Azerbaijan
780	PAN-255459263	Panama
628	BHU-356570391	Bhutan
705	GIB-651061755	Gibraltar
840	SAU-124603014	Saudi Arabia
30	UKR-843242330	Ukraine
367	NEP-971476274	Nepal
448	UZB-202759640	Uzbekistan
593	SRI-694562647	Sri Lanka
999	TON-099126034	Tonga
115	PUE-686731649	Puerto Rico
619	IVO-908262097	Ivory Coast
784	LAO-334569649	Laos
191	ICE-094336134	Iceland
230	IND-048345032	Indonesia
354	UZB-946924562	Uzbekistan
774	HON-418562041	Hong Kong
985	LES-149497140	Lesotho
110	IRA-067704875	Iraq
610	TAJ-897339205	Tajikistan
877	BAH-045928315	Bahamas
974	PHI-282651790	Philippines
15	LIE-797979414	Liechtenstein
368	SUD-037986672	Sudan
59	LIB-390105632	Libya
613	LEB-672794809	Lebanon
748	GAM-849352843	Gambia
668	KEN-473048260	Kenya
188	ARM-503988598	Armenia
385	IRA-082709789	Iraq
786	SAU-862880930	Saudi Arabia
46	BOT-464265595	Botswana
288	SAM-755284044	Samoa
310	SOM-877937073	Somalia
393	GEO-461434217	Georgia
987	DJI-265004422	Djibouti
785	ARM-766004595	Armenia
827	LAO-363055812	Laos
809	BAH-208019543	Bosnia and Herzegovina
635	FIJ-869117869	Fiji
601	BEL-030199922	Belize
912	LES-022660373	Lesotho
339	COL-575514797	Colombia
182	TON-978509547	Tonga
684	BAR-659689277	Barbados
154	DOM-901380150	Dominican Republic
836	CAY-228551177	Cayman Islands
216	JAM-005207223	Jamaica
978	KUW-531669574	Kuwait
433	AFG-314362277	Afghanistan
588	PUE-422335288	Puerto Rico
52	BAR-656289330	Barbados
884	ESW-393962336	Eswatini
363	DEN-378845630	Denmark
47	SAU-477226044	Saudi Arabia
923	NEP-941741393	Nepal
805	CAY-434018914	Cayman Islands
546	UGA-524716372	Uganda
148	SOM-392939864	Somalia
184	TON-222964681	Tonga
204	BRU-140433847	Brunei
200	UZB-643694470	Uzbekistan
41	BAH-164057058	Bahrain
260	BUR-747061677	Burundi
612	CAP-248318057	Cape Verde
447	WAF-444715809	Wallis and Futuna
786	KAZ-863293873	Kazakhstan
960	LIE-707392251	Liechtenstein
263	KAZ-095289050	Kazakhstan
296	MAL-829620476	Maldives
202	PAN-634356528	Panama
907	COL-105369821	Colombia
899	TUR-755701291	Turkey
622	MOZ-472531343	Mozambique
212	BAH-868562441	Bosnia and Herzegovina
591	BRA-599744594	Brazil
180	SUR-996680287	Suriname
643	HON-382386193	Hong Kong
663	KUW-602421508	Kuwait
215	LIB-018078316	Liberia
612	UAE-987374088	United Arab Emirates
444	PHI-552169979	Philippines
248	HUN-762594466	Hungary
224	SUD-713130052	Sudan
144	KUW-225690880	Kuwait
189	IRA-965939538	Iraq
681	BOT-382681720	Botswana
388	JOR-929262916	Jordan
96	ZAM-465817681	Zambia
539	BAN-116155956	Bangladesh
452	SAU-427609404	Saudi Arabia
142	GUA-846117140	Guatemala
360	PAN-235944201	Panama
107	ETH-041788774	Ethiopia
441	MAC-776771862	Macau
36	CUB-891888693	Cuba
461	MOZ-883609607	Mozambique
92	HAI-992415832	Haiti
354	GUA-319940097	Guatemala
272	POL-011603020	Poland
627	BAN-536821146	Bangladesh
239	GHA-941912440	Ghana
634	GUY-201935944	Guyana
912	SAM-309336864	Samoa
242	VIE-220725071	Vietnam
238	SRI-293675617	Sri Lanka
796	WAF-956696559	Wallis and Futuna
206	PAR-493569320	Paraguay
928	GHA-218194472	Ghana
408	CAM-739013376	Cambodia
436	IRA-982578117	Iraq
256	JOR-291550075	Jordan
94	TUR-232612128	Turkey
168	GUY-062649788	Guyana
187	SUD-415666100	Sudan
973	MAU-769543954	Mauritius
875	KEN-503146963	Kenya
74	ANG-590591106	Angola
855	RWA-478595564	Rwanda
35	ESW-013691802	Eswatini
556	PAN-922464832	Panama
484	BER-313778876	Bermuda
380	JAM-028480155	Jamaica
798	MAD-309754530	Madagascar
618	HUN-701197255	Hungary
764	PAR-160748478	Paraguay
508	ARG-367214018	Argentina
403	ISR-824946266	Israel
442	SOL-557121632	Solomon Islands
348	ARM-114388794	Armenia
415	HON-533568478	Hong Kong
842	BER-757789264	Bermuda
298	CAP-269872871	Cape Verde
753	QAT-780348265	Qatar
171	CAY-954751810	Cayman Islands
119	MAL-356368227	Malaysia
260	IRA-998501795	Iran
222	UKR-132313683	Ukraine
223	BAH-613604644	Bahamas
863	CUB-691223252	Cuba
225	BHU-568442677	Bhutan
850	COL-536034358	Colombia
251	ARU-309754522	Aruba
2	IVO-365577256	Ivory Coast
665	SEY-586378722	Seychelles
554	BEL-979333634	Belize
680	WAF-077028814	Wallis and Futuna
583	GUA-015547590	Guatemala
354	BAH-352179316	Bahamas
793	UGA-110750082	Uganda
276	ZAM-864224788	Zambia
259	BUL-663768128	Bulgaria
990	MAC-743869271	Macau
772	DR -839635982	DR Congo
483	UZB-543176562	Uzbekistan
117	UAE-417613227	United Arab Emirates
38	HON-766477821	Hong Kong
23	YEM-114427152	Yemen
989	DEN-047506437	Denmark
217	LIB-673599444	Libya
919	ERI-517056720	Eritrea
591	UZB-413693623	Uzbekistan
375	NOR-262769336	North Macedonia
641	SUD-551396120	Sudan
531	ETH-866103119	Ethiopia
833	CAM-619979996	Cambodia
173	MOR-969683216	Morocco
374	COL-522358920	Colombia
319	UGA-112550515	Uganda
320	CAN-865242157	Canada
661	OMA-279476627	Oman
279	COL-320678171	Colombia
197	MAD-229844984	Madagascar
806	LIB-605375546	Libya
806	MAL-657638874	Malawi
643	MAU-177343731	Mauritius
761	BOT-905734544	Botswana
917	BAH-517609899	Bosnia and Herzegovina
858	MAU-971225350	Mauritius
96	PAR-039783320	Paraguay
390	ETH-503142077	Ethiopia
273	BAN-999356182	Bangladesh
974	IND-521852417	Indonesia
739	MAL-505344632	Malawi
479	MYA-276284898	Myanmar
852	QAT-127142323	Qatar
610	SWE-136493713	Sweden
144	NAM-792708228	Namibia
151	AZE-830924294	Azerbaijan
243	CAN-177170494	Canada
281	SRI-968021923	Sri Lanka
254	NAM-185217652	Namibia
751	IND-572791315	India
817	UAE-677574215	United Arab Emirates
615	RWA-783999034	Rwanda
235	ALB-167143452	Albania
17	GUY-460743014	Guyana
355	TUR-066308020	Turkey
860	DR -870715701	DR Congo
554	GEO-770423374	Georgia
466	TUN-039706868	Tunisia
564	KYR-308814715	Kyrgyzstan
647	DR -504522633	DR Congo
478	ICE-932029448	Iceland
66	SAI-939296955	Saint Lucia
346	SAM-074985302	Samoa
819	BRU-554544605	Brunei
560	TON-966540890	Tonga
78	KAZ-580581306	Kazakhstan
978	MAU-819005000	Mauritius
490	QAT-968087288	Qatar
720	MAD-090392540	Madagascar
44	SAI-108060715	Saint Helena, Ascension and Tristan da Cunha
319	IRA-897845078	Iraq
879	HON-096650837	Hong Kong
984	DJI-107431183	Djibouti
291	BAH-591163728	Bosnia and Herzegovina
394	GEO-676447386	Georgia
939	MAC-989305300	Macau
654	KYR-391047184	Kyrgyzstan
873	SRI-844905441	Sri Lanka
327	SEY-183823564	Seychelles
259	TUN-789627198	Tunisia
560	MAD-317501338	Madagascar
144	IVO-710504050	Ivory Coast
339	MAL-343772772	Malaysia
525	HON-699003140	Hong Kong
399	SOL-264752066	Solomon Islands
835	SAU-619239096	Saudi Arabia
651	GHA-336748341	Ghana
706	CHI-271853882	China
538	MAL-059033137	Malawi
316	PHI-426461276	Philippines
719	AZE-770768898	Azerbaijan
103	JOR-505993882	Jordan
202	ARM-090386927	Armenia
122	WAF-597124121	Wallis and Futuna
946	MAL-821691439	Malaysia
201	TUR-714605396	Turkmenistan
974	CAP-249399537	Cape Verde
561	SEY-115450838	Seychelles
166	MYA-979892673	Myanmar
53	CAM-722610311	Cambodia
853	MOZ-528425998	Mozambique
621	BAH-948903779	Bosnia and Herzegovina
363	PHI-501917168	Philippines
712	TUN-640287668	Tunisia
681	GHA-899709386	Ghana
604	YEM-696176248	Yemen
756	NOR-481368102	North Korea
773	QAT-672160891	Qatar
805	SIN-438785707	Singapore
120	BAN-460201788	Bangladesh
601	UKR-008805733	Ukraine
469	SWE-819410069	Sweden
317	YEM-029658047	Yemen
247	BRU-621423713	Brunei
814	SRI-103223244	Sri Lanka
295	ESW-621232496	Eswatini
564	JAP-416088043	Japan
144	GHA-763238011	Ghana
539	DOM-259494800	Dominican Republic
288	SIN-830038647	Singapore
470	DOM-748995061	Dominican Republic
287	TAI-735209553	Taiwan
188	BAH-962814927	Bosnia and Herzegovina
162	CHI-178420767	China
990	COM-338559078	Comoros
565	LIB-066703407	Liberia
263	MAD-538189151	Madagascar
88	QAT-926976334	Qatar
859	SEY-776279649	Seychelles
308	JAM-797999910	Jamaica
902	LES-484358656	Lesotho
176	NEP-088755833	Nepal
176	JOR-566905816	Jordan
136	AFG-512505502	Afghanistan
41	KYR-823312492	Kyrgyzstan
87	VIE-746933790	Vietnam
465	TAI-746145823	Taiwan
112	NIU-996839227	Niue
437	MOZ-412344266	Mozambique
466	CAP-712172505	Cape Verde
699	TON-558553753	Tonga
624	SWE-636890476	Sweden
692	TAJ-887499990	Tajikistan
512	BHU-395997475	Bhutan
673	ARU-690905721	Aruba
441	KYR-174211228	Kyrgyzstan
843	BAH-668744791	Bosnia and Herzegovina
994	PER-494300140	Peru
43	ARM-094506940	Armenia
138	NOR-924915563	North Macedonia
751	PHI-945772477	Philippines
168	SUR-328277025	Suriname
496	BAR-915438545	Barbados
702	LIB-110163225	Liberia
356	JAM-784718706	Jamaica
393	ESW-003367184	Eswatini
208	MAL-509510372	Malaysia
304	SAI-537716949	Saint Helena, Ascension and Tristan da Cunha
933	TAJ-967932784	Tajikistan
941	SIN-685321825	Singapore
283	COM-411291206	Comoros
258	CAM-115861182	Cambodia
748	BRU-551032792	Brunei
916	IRA-915915518	Iraq
244	PUE-018049528	Puerto Rico
494	COL-506159456	Colombia
538	NIU-328715089	Niue
469	BRA-331200200	Brazil
405	KIR-917268410	Kiribati
589	AFG-936767055	Afghanistan
940	DOM-063684530	Dominican Republic
253	MAL-416761026	Malaysia
900	MEX-226763779	Mexico
117	ERI-996235881	Eritrea
822	MAL-241324377	Malawi
965	ARG-659086598	Argentina
531	OMA-783898384	Oman
395	HAI-412061994	Haiti
570	BRU-384142543	Brunei
365	SAI-217837723	Saint Helena, Ascension and Tristan da Cunha
313	COL-607783664	Colombia
538	SAU-594440203	Saudi Arabia
322	SWE-148484314	Sweden
936	SUR-033218236	Suriname
658	UZB-679256405	Uzbekistan
701	HON-849091637	Honduras
1000	HAI-075649407	Haiti
139	KEN-878991227	Kenya
282	MAC-533656988	Macau
881	PHI-448713565	Philippines
385	IND-181853298	Indonesia
387	GUI-370979533	Guinea
793	NIC-263727968	Nicaragua
616	VIE-834974493	Vietnam
54	CAR-870732983	Central African Republic
110	ISR-074815065	Israel
690	MAL-041979301	Malaysia
497	TUN-528251813	Tunisia
387	BHU-645829654	Bhutan
505	MON-344629988	Mongolia
488	GUY-629132895	Guyana
113	CAR-395387069	Central African Republic
706	SOM-872180119	Somalia
102	UAE-065989177	United Arab Emirates
429	CHI-631200580	China
989	IND-443798901	India
623	BRA-839023814	Brazil
919	JOR-351277715	Jordan
489	CHI-677649231	Chile
829	BOT-579357083	Botswana
550	SOM-687583566	Somalia
130	TAJ-419891792	Tajikistan
872	LIB-366987401	Libya
216	GIB-516895800	Gibraltar
782	NOR-378094443	North Macedonia
977	MAU-869810537	Mauritius
796	KAZ-267093248	Kazakhstan
728	NIC-569058948	Nicaragua
519	KAZ-736062489	Kazakhstan
587	DR -073468616	DR Congo
407	RUS-990673397	Russia
851	THA-906188677	Thailand
603	CUB-817103678	Cuba
584	MON-678978770	Mongolia
444	LIB-372890011	Liberia
274	GEO-795118268	Georgia
496	SAM-309263973	Samoa
637	ESW-588817989	Eswatini
776	ARU-689742153	Aruba
533	LAO-686599501	Laos
237	SOL-079037342	Solomon Islands
45	CAM-901342322	Cambodia
751	SRI-706708939	Sri Lanka
578	BAH-078680003	Bahrain
655	CAM-478205297	Cambodia
922	BER-314796832	Bermuda
447	AFG-013473234	Afghanistan
173	BRA-048761653	Brazil
388	PHI-423536037	Philippines
87	TUN-536425832	Tunisia
769	FIJ-625298734	Fiji
535	NOR-952636295	North Korea
160	ANG-691317349	Angola
965	NIU-792417683	Niue
623	PAN-527892611	Panama
378	LAO-844633959	Laos
244	IRA-792392613	Iran
918	LIB-624963634	Libya
654	ETH-896868322	Ethiopia
684	JAM-792010857	Jamaica
996	UAE-749018610	United Arab Emirates
860	TUN-183410494	Tunisia
319	MAD-374540571	Madagascar
111	ARU-662905998	Aruba
518	GUA-028946818	Guatemala
11	PER-470493448	Peru
245	JOR-708160462	Jordan
521	BAH-655793106	Bahamas
777	DEN-165635782	Denmark
967	MOL-834071494	Moldova
344	BEL-412465038	Belize
364	HON-149362956	Honduras
880	TAT-208479804	Trinidad and Tobago
280	SOU-368848603	South Korea
372	SUR-361714970	Suriname
389	TUR-920367831	Turkmenistan
830	WAF-553497695	Wallis and Futuna
609	RWA-850459391	Rwanda
755	KYR-554404409	Kyrgyzstan
626	KEN-483416987	Kenya
645	PAR-900669892	Paraguay
435	BOT-438362081	Botswana
756	SEY-115208179	Seychelles
217	IND-986395417	Indonesia
897	COM-790022759	Comoros
652	POL-840049630	Poland
794	ARG-273637144	Argentina
287	MAL-898220189	Malawi
815	SER-205430013	Serbia
478	CAP-755162793	Cape Verde
663	TAT-944638126	Trinidad and Tobago
120	MOL-893348326	Moldova
370	TAT-757717681	Trinidad and Tobago
319	MOZ-810804864	Mozambique
23	CUB-767986807	Cuba
254	KUW-727222316	Kuwait
562	ICE-679972219	Iceland
927	CHI-586390513	Chile
736	TON-888127314	Tonga
22	PHI-940855950	Philippines
600	CHI-661524559	Chile
96	KYR-816729413	Kyrgyzstan
111	DOM-649861072	Dominican Republic
603	HUN-964630253	Hungary
671	BER-072754868	Bermuda
869	RUS-991116537	Russia
886	PAR-982157366	Paraguay
442	WES-713272325	Western Sahara
766	CHI-200250652	Chile
124	NOR-742374518	North Macedonia
123	MOZ-406613279	Mozambique
785	NOR-288112268	North Macedonia
905	SOL-326446205	Solomon Islands
290	KYR-063148073	Kyrgyzstan
676	SOU-689637035	South Korea
110	IVO-687664519	Ivory Coast
485	BUR-705221507	Burundi
823	HON-390899656	Honduras
424	CAR-131364238	Central African Republic
473	SUR-895647235	Suriname
250	PUE-313484901	Puerto Rico
626	HON-314498965	Hong Kong
304	NEP-946679709	Nepal
863	THA-118275904	Thailand
737	WAF-348315717	Wallis and Futuna
367	IND-151634836	Indonesia
801	DJI-706245649	Djibouti
110	UAE-886029581	United Arab Emirates
720	BAH-772097490	Bahrain
132	ESW-495736476	Eswatini
848	GIB-994082317	Gibraltar
950	FIJ-586630838	Fiji
52	AZE-899533949	Azerbaijan
768	LIE-380637577	Liechtenstein
263	WES-965051718	Western Sahara
200	LEB-607969552	Lebanon
637	MAL-184560524	Malawi
64	ESW-096298721	Eswatini
909	GUI-430587781	Guinea
682	COL-417885806	Colombia
697	UAE-041790940	United Arab Emirates
241	SUD-153366168	Sudan
493	PHI-550929512	Philippines
950	TUN-739610418	Tunisia
485	ICE-650302924	Iceland
394	ARM-715641241	Armenia
749	NOR-661489648	North Korea
476	KYR-923886518	Kyrgyzstan
585	LIB-575465047	Liberia
863	UZB-159526110	Uzbekistan
13	IND-184545278	Indonesia
216	CAM-200472535	Cambodia
618	DOM-467891554	Dominican Republic
671	HAI-876980353	Haiti
964	HON-677683452	Hong Kong
452	LIE-708269936	Liechtenstein
744	SOM-178771200	Somalia
934	SUD-717931629	Sudan
342	LIB-488199392	Libya
347	DR -867872919	DR Congo
100	THA-369752933	Thailand
605	BRU-809091799	Brunei
340	CHI-531706678	China
358	KAZ-969029687	Kazakhstan
974	TAT-664605054	Trinidad and Tobago
719	UAE-411185352	United Arab Emirates
933	ANG-839596932	Angola
756	YEM-765007845	Yemen
601	BOT-738035400	Botswana
29	GAM-776865232	Gambia
191	LIB-061778775	Libya
831	MOZ-697875826	Mozambique
890	POL-645225631	Poland
755	TON-543703045	Tonga
220	CHI-104946695	China
520	CHI-015285055	China
910	SUR-207682473	Suriname
790	ERI-278591339	Eritrea
131	ARG-145829090	Argentina
124	GHA-601895486	Ghana
995	DJI-679432468	Djibouti
802	TUN-669396029	Tunisia
723	HAI-433249326	Haiti
814	BOT-355110358	Botswana
880	BEL-782540391	Belize
571	BER-913625501	Bermuda
217	SAI-874526148	Saint Lucia
480	TUR-468674989	Turkey
908	SIN-278643253	Singapore
542	YEM-247512122	Yemen
186	NIU-864366510	Niue
656	DEN-055741582	Denmark
477	LIB-669973637	Liberia
586	GUY-143476620	Guyana
204	CAR-526130438	Central African Republic
194	TUR-140133762	Turkmenistan
894	MON-498700458	Mongolia
850	PUE-558213114	Puerto Rico
865	LIE-004375704	Liechtenstein
782	BEL-705450217	Belize
190	TAJ-522847618	Tajikistan
866	GUY-904179513	Guyana
334	ETH-359649187	Ethiopia
33	SWE-403849570	Sweden
408	ETH-614091255	Ethiopia
823	RWA-623051662	Rwanda
848	TAJ-052311386	Tajikistan
320	NIU-308439833	Niue
428	BAH-092335907	Bahamas
868	HUN-757351282	Hungary
551	PAN-287483839	Panama
489	JAM-868389725	Jamaica
525	BRU-270660756	Brunei
576	NOR-759934246	North Korea
982	UAE-968437772	United Arab Emirates
487	LIB-084341468	Liberia
903	BUL-601363687	Bulgaria
27	BUR-914593300	Burundi
810	ERI-363461852	Eritrea
614	UZB-568358394	Uzbekistan
569	CAR-028720676	Central African Republic
500	MAL-706047250	Maldives
3	KYR-279970612	Kyrgyzstan
91	ALB-332838153	Albania
616	MAL-751807667	Malaysia
301	CAY-092328925	Cayman Islands
377	ZAM-722040706	Zambia
587	PAR-560344724	Paraguay
217	BUL-657766448	Bulgaria
238	SOM-907832575	Somalia
831	SAU-212262476	Saudi Arabia
145	JAP-072919745	Japan
156	GUA-159991914	Guatemala
968	JAP-705948659	Japan
709	ARG-258048431	Argentina
342	BAH-460743960	Bahamas
973	NAM-512107544	Namibia
756	IRA-531386066	Iran
557	WAF-379284605	Wallis and Futuna
214	CAY-575509554	Cayman Islands
804	SWE-010909638	Sweden
168	GEO-870313160	Georgia
569	SAU-901826011	Saudi Arabia
994	SWE-102196840	Sweden
520	IVO-621401942	Ivory Coast
111	IND-973818614	India
368	THA-584137207	Thailand
823	ZAM-339240809	Zambia
905	ARG-093760430	Argentina
437	CAN-199217715	Canada
172	CAM-493342337	Cambodia
610	TAI-200086093	Taiwan
68	TON-023437183	Tonga
418	WAF-400793894	Wallis and Futuna
653	JOR-343568742	Jordan
810	SAI-230938706	Saint Helena, Ascension and Tristan da Cunha
6	TON-947762098	Tonga
566	ETH-852660216	Ethiopia
338	DOM-643429958	Dominican Republic
996	BER-959632979	Bermuda
647	CAM-857351244	Cambodia
177	PUE-824937410	Puerto Rico
695	CAR-144557485	Central African Republic
307	BAR-817419341	Barbados
133	WES-809876445	Western Sahara
165	ETH-752085247	Ethiopia
276	OMA-019694656	Oman
385	ARG-330095307	Argentina
774	MOZ-719979496	Mozambique
46	IRA-109769766	Iraq
180	MOZ-539344890	Mozambique
120	BRU-082883297	Brunei
415	SOL-772849004	Solomon Islands
866	BAR-908597364	Barbados
95	FIJ-714069045	Fiji
215	ALB-314413748	Albania
922	SOU-665155795	South Korea
34	ALB-938069918	Albania
167	ETH-238309846	Ethiopia
204	BAR-005794462	Barbados
124	CAN-029331560	Canada
157	MOR-713440254	Morocco
837	UAE-422915073	United Arab Emirates
5	IRA-626869899	Iraq
135	ANG-250012952	Angola
972	CHI-233123830	China
907	SIN-748579469	Singapore
646	POL-649572584	Poland
382	ESW-991994188	Eswatini
92	HUN-561061382	Hungary
74	VIE-047794235	Vietnam
230	ZAM-970243963	Zambia
863	WES-803406613	Western Sahara
645	MEX-741402600	Mexico
376	COS-365834189	Costa Rica
113	CAY-274383368	Cayman Islands
38	CAP-638949535	Cape Verde
124	DEN-648431319	Denmark
504	UKR-157137364	Ukraine
422	MOL-260465136	Moldova
459	BAH-692371190	Bahrain
376	COM-479704895	Comoros
633	MAU-515867501	Mauritius
242	PAR-240801618	Paraguay
310	HAI-850987564	Haiti
94	BOT-630281986	Botswana
125	KUW-780483419	Kuwait
842	CUB-592375666	Cuba
73	TAT-676880644	Trinidad and Tobago
354	VIE-002185556	Vietnam
343	LIE-075576743	Liechtenstein
325	TAJ-634440545	Tajikistan
237	POL-394868361	Poland
699	SEY-047455155	Seychelles
197	PER-656834812	Peru
870	SIN-891994959	Singapore
851	NOR-030125521	North Korea
535	BRA-773464298	Brazil
519	JAP-958494760	Japan
272	JAM-535208106	Jamaica
83	BOT-145172186	Botswana
696	SUD-353178333	Sudan
104	SAI-489888592	Saint Helena, Ascension and Tristan da Cunha
170	YEM-472159896	Yemen
240	KUW-874169219	Kuwait
5	POL-625131013	Poland
605	YEM-241851141	Yemen
308	BRA-658120068	Brazil
457	SAI-453099789	Saint Helena, Ascension and Tristan da Cunha
153	BEL-508587359	Belize
789	BAR-528152265	Barbados
920	CAR-227075944	Central African Republic
71	CHI-522304231	China
818	SAI-977283736	Saint Lucia
456	TON-326966199	Tonga
977	DEN-678241674	Denmark
322	GAM-798339559	Gambia
579	HON-107904361	Hong Kong
479	SOL-525686875	Solomon Islands
994	SOL-066844274	Solomon Islands
309	ESW-630517259	Eswatini
273	CAR-720650585	Central African Republic
215	CUB-994604770	Cuba
899	ALB-120570104	Albania
107	HAI-528955225	Haiti
733	ESW-984988320	Eswatini
555	BOT-984665771	Botswana
992	NIC-514050134	Nicaragua
393	FIJ-414746656	Fiji
810	QAT-024365987	Qatar
448	LAO-732364926	Laos
802	TUR-985876082	Turkey
820	BAH-234661126	Bosnia and Herzegovina
268	BAH-215166036	Bahrain
181	KUW-855850822	Kuwait
85	GUA-612060965	Guatemala
579	OMA-638977637	Oman
902	MOZ-226359099	Mozambique
3	CUB-441843537	Cuba
248	BRA-122470519	Brazil
770	SUD-179889167	Sudan
141	TUR-506140432	Turkey
490	DJI-377841002	Djibouti
248	KEN-420132994	Kenya
5	MAL-568951265	Malaysia
80	BRU-325829014	Brunei
308	TAI-095550827	Taiwan
778	KEN-922405853	Kenya
303	SRI-507194817	Sri Lanka
449	AZE-519839273	Azerbaijan
990	RWA-327300582	Rwanda
272	THA-952207702	Thailand
339	MEX-733658005	Mexico
725	JOR-000435808	Jordan
832	IVO-738203859	Ivory Coast
812	FIJ-293007565	Fiji
30	BAN-678556466	Bangladesh
168	AFG-928192917	Afghanistan
244	NEP-281472689	Nepal
648	YEM-932118901	Yemen
559	LES-825027601	Lesotho
690	TAT-185916892	Trinidad and Tobago
137	PHI-782796662	Philippines
915	POL-972294875	Poland
558	IND-754029463	Indonesia
370	BER-295887239	Bermuda
547	UAE-115809477	United Arab Emirates
177	SWE-130482867	Sweden
467	CAR-721086867	Central African Republic
777	GIB-891711668	Gibraltar
502	PAR-827847657	Paraguay
949	CAM-415819527	Cambodia
443	NIC-539514140	Nicaragua
804	BRU-092232053	Brunei
796	SOU-813236836	South Korea
780	PER-770080174	Peru
383	GIB-429383763	Gibraltar
933	MAL-711612253	Malawi
838	ERI-907841851	Eritrea
137	BRU-317729035	Brunei
854	KUW-462230102	Kuwait
547	CAY-971321601	Cayman Islands
332	ARM-493266168	Armenia
853	HUN-315226818	Hungary
449	PHI-475891876	Philippines
938	SAU-839445513	Saudi Arabia
619	BUL-581944081	Bulgaria
773	JAP-919927416	Japan
181	TUR-713210084	Turkmenistan
191	IND-436085926	Indonesia
473	COS-486016522	Costa Rica
656	CAP-482788993	Cape Verde
788	PUE-435691412	Puerto Rico
857	MAD-474005116	Madagascar
88	BER-770882143	Bermuda
1	KYR-983114995	Kyrgyzstan
571	KUW-050674496	Kuwait
80	UAE-343534969	United Arab Emirates
488	DR -316714685	DR Congo
936	CHI-681491482	China
653	GUY-442824109	Guyana
340	TON-939433314	Tonga
197	BAH-468631073	Bahrain
42	POL-991753154	Poland
210	MAC-722451211	Macau
844	CAN-668417662	Canada
743	ARG-898256251	Argentina
397	TON-906657157	Tonga
766	ARM-564577118	Armenia
155	ANG-924695916	Angola
123	IRA-017301175	Iraq
187	SOU-733690689	South Korea
673	MOR-844052641	Morocco
709	SIN-734844725	Singapore
908	BAH-412436177	Bosnia and Herzegovina
791	FIJ-353212896	Fiji
783	KIR-375652872	Kiribati
103	GUI-420555124	Guinea
506	GAM-858639122	Gambia
382	ARG-573332915	Argentina
290	UAE-424300716	United Arab Emirates
313	UGA-093247078	Uganda
814	UGA-057644851	Uganda
823	IND-429745550	Indonesia
193	ANG-601585624	Angola
223	PHI-474819170	Philippines
541	ARU-771984986	Aruba
364	NIU-048605760	Niue
907	CAP-472884388	Cape Verde
892	SIN-243618742	Singapore
291	HUN-831914247	Hungary
863	JAM-086392908	Jamaica
33	JAP-629034306	Japan
790	LAO-274185100	Laos
872	HON-441187273	Honduras
539	THA-091529670	Thailand
426	BUL-738984368	Bulgaria
943	NIC-551410726	Nicaragua
469	KUW-071614001	Kuwait
963	MAU-803765310	Mauritius
465	SEY-199243541	Seychelles
143	SIN-831484485	Singapore
196	LES-894974733	Lesotho
965	UKR-583212006	Ukraine
658	CAY-307774621	Cayman Islands
827	IRA-399531120	Iran
34	SAU-406849044	Saudi Arabia
711	FIJ-480100214	Fiji
392	KIR-957004701	Kiribati
507	QAT-912349213	Qatar
609	MON-774747788	Mongolia
564	OMA-218631952	Oman
824	MOR-796277947	Morocco
824	HAI-157809685	Haiti
141	LES-405539766	Lesotho
262	GEO-202418192	Georgia
302	MEX-999133012	Mexico
54	LIE-520611490	Liechtenstein
762	GAM-216099950	Gambia
606	ARG-913011570	Argentina
813	GAM-953719771	Gambia
939	CAP-880341776	Cape Verde
842	HUN-329926198	Hungary
539	NIC-765645894	Nicaragua
199	GUA-199990705	Guatemala
897	UAE-534022910	United Arab Emirates
690	BRA-365375325	Brazil
16	GUI-732917123	Guinea
771	CHI-054279064	Chile
998	IND-722934112	India
348	IVO-340644446	Ivory Coast
450	ANG-130839550	Angola
303	COL-159068000	Colombia
564	ICE-971093035	Iceland
249	NAM-039935149	Namibia
309	LIB-489682385	Liberia
89	DOM-790116770	Dominican Republic
996	DOM-151999237	Dominican Republic
278	KYR-644265183	Kyrgyzstan
560	ALB-626566489	Albania
415	CAP-484451172	Cape Verde
340	GUI-201341786	Guinea
818	IVO-083773669	Ivory Coast
26	IND-809436775	India
59	SER-951863919	Serbia
618	MOR-647692513	Morocco
383	TAJ-160281253	Tajikistan
800	IRA-260840448	Iraq
845	BAH-174168085	Bahamas
810	BAH-147201204	Bahamas
368	LAO-188384241	Laos
903	MAC-786443174	Macau
644	NIU-949758207	Niue
370	BAH-208996662	Bahrain
322	IRA-327683618	Iran
868	MAL-501532075	Maldives
44	RWA-503772757	Rwanda
480	LES-699789610	Lesotho
472	LIE-074572198	Liechtenstein
865	ICE-919569312	Iceland
121	ARU-154842609	Aruba
580	GHA-360656190	Ghana
414	BAN-482534815	Bangladesh
404	SUR-992201898	Suriname
644	BEL-124324996	Belize
519	BAH-927906983	Bosnia and Herzegovina
842	DOM-188423965	Dominican Republic
229	NIU-723716326	Niue
901	SWE-768719279	Sweden
588	MAL-649763478	Malaysia
809	QAT-913412830	Qatar
830	MYA-452088680	Myanmar
319	NAM-005334415	Namibia
163	TAI-942212988	Taiwan
562	MAD-038608897	Madagascar
751	DEN-729210327	Denmark
825	SUR-191241724	Suriname
869	CAP-422179157	Cape Verde
796	SEY-439151062	Seychelles
354	TAT-442235201	Trinidad and Tobago
280	SAI-431833966	Saint Helena, Ascension and Tristan da Cunha
540	BAH-015860765	Bahamas
179	BRU-022052587	Brunei
241	BER-196757121	Bermuda
479	BER-182525641	Bermuda
508	GIB-781621473	Gibraltar
632	SOM-872079904	Somalia
736	ARU-235117589	Aruba
988	SER-162256778	Serbia
305	DOM-754996672	Dominican Republic
998	SUR-049846871	Suriname
481	JOR-665938486	Jordan
310	BOT-509156245	Botswana
765	HUN-238302575	Hungary
167	HON-736815925	Hong Kong
724	BAH-733186845	Bahamas
898	DEN-021068937	Denmark
978	DEN-801939355	Denmark
171	SUD-652764147	Sudan
639	LIB-596043920	Liberia
375	GUI-476261080	Guinea
506	TAI-203979979	Taiwan
330	BRA-790063081	Brazil
610	BAN-686555601	Bangladesh
160	OMA-074619411	Oman
210	JAP-103777059	Japan
150	ARG-395917391	Argentina
591	SEY-369361344	Seychelles
135	DOM-163188629	Dominican Republic
847	MAL-910855037	Malaysia
717	ARU-286449251	Aruba
44	VIE-283926905	Vietnam
71	JAP-676622919	Japan
770	BRU-235437975	Brunei
151	TUR-599463862	Turkey
58	LES-815443140	Lesotho
426	IND-152358672	Indonesia
289	ARU-909302301	Aruba
154	CAR-346638086	Central African Republic
288	SRI-937509381	Sri Lanka
243	GUY-255943796	Guyana
432	SAU-210888812	Saudi Arabia
685	LIE-890016285	Liechtenstein
760	JOR-705318834	Jordan
\.


--
-- TOC entry 5254 (class 0 OID 16506)
-- Dependencies: 239
-- Data for Name: inscricao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inscricao (nro_plataforma, nome_canal, nick_membro, nivel) FROM stdin;
\.


--
-- TOC entry 5256 (class 0 OID 16516)
-- Dependencies: 241
-- Data for Name: mecanismo_plat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mecanismo_plat (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, seq) FROM stdin;
\.


--
-- TOC entry 5261 (class 0 OID 16533)
-- Dependencies: 246
-- Data for Name: nivel_canal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nivel_canal (nro_plataforma, nome_canal, nivel, nome_nivel, valor, gif) FROM stdin;
\.


--
-- TOC entry 5263 (class 0 OID 16546)
-- Dependencies: 248
-- Data for Name: pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pais (ddi, nome, moeda) FROM stdin;
224	Guinea	GNF
359	Bulgaria	BGN
243	DR Congo	CDF
249	Sudan	SDG
60	Malaysia	MYR
2125288	Western Sahara	DZD
231	Liberia	LRD
852	Hong Kong	HKD
46	Sweden	SEK
244	Angola	AOA
65	Singapore	SGD
502	Guatemala	GTQ
220	Gambia	GMD
992	Tajikistan	TJS
84	Vietnam	VND
256	Uganda	UGX
36	Hungary	HUF
994	Azerbaijan	AZN
90	Turkey	TRY
51	Peru	PEN
592	Guyana	GYD
509	Haiti	HTG
973	Bahrain	BHD
507	Panama	PAB
975	Bhutan	BTN
82	South Korea	KRW
964	Iraq	IQD
1	Canada	CAD
252	Somalia	SOS
998	Uzbekistan	UZS
268	Eswatini	SZL
86	China	CNY
94	Sri Lanka	LKR
1809	Dominican Republic	DOP
257	Burundi	BIF
45	Denmark	DKK
57	Colombia	COP
66	Thailand	THB
264	Namibia	NAD
56	Chile	CLP
261	Madagascar	MGA
961	Lebanon	LBP
962	Jordan	JOD
1242	Bahamas	BSD
269	Comoros	KMF
54	Argentina	ARS
965	Kuwait	KWD
505	Nicaragua	NIO
260	Zambia	ZMW
374	Armenia	AMD
267	Botswana	BWP
355	Albania	ALL
62	Indonesia	IDR
501	Belize	BZD
967	Yemen	YER
677	Solomon Islands	SBD
996	Kyrgyzstan	KGS
679	Fiji	FJD
373	Moldova	MDL
1758	Saint Lucia	XCD
225	Ivory Coast	XOF
212	Morocco	MAD
686	Kiribati	AUD
855	Cambodia	KHR
880	Bangladesh	BDT
48	Poland	PLN
52	Mexico	MXN
251	Ethiopia	ETB
233	Ghana	GHS
230	Mauritius	MUR
976	Mongolia	MNT
995	Georgia	GEL
253	Djibouti	DJF
236	Central African Republic	XAF
966	Saudi Arabia	SAR
250	Rwanda	RWF
258	Mozambique	MZN
55	Brazil	BRL
595	Paraguay	PYG
681	Wallis and Futuna	XPF
1868	Trinidad and Tobago	TTD
53	Cuba	CUC
676	Tonga	TOP
993	Turkmenistan	TMT
81	Japan	JPY
76	Kazakhstan	KZT
1441	Bermuda	BMD
856	Laos	LAK
968	Oman	OMR
597	Suriname	SRD
354	Iceland	ISK
1246	Barbados	BBD
673	Brunei	BND
886	Taiwan	TWD
91	India	INR
683	Niue	NZD
350	Gibraltar	GIP
387	Bosnia and Herzegovina	BAM
218	Libya	LYD
93	Afghanistan	AFN
971	United Arab Emirates	AED
381	Serbia	RSD
1345	Cayman Islands	KYD
389	North Macedonia	MKD
266	Lesotho	LSL
63	Philippines	PHP
265	Malawi	MWK
380	Ukraine	UAH
98	Iran	IRR
685	Samoa	WST
423	Liechtenstein	CHF
977	Nepal	NPR
850	North Korea	KPW
95	Myanmar	MMK
504	Honduras	HNL
972	Israel	ILS
506	Costa Rica	CRC
254	Kenya	KES
974	Qatar	QAR
291	Eritrea	ERN
248	Seychelles	SCR
238	Cape Verde	CVE
1787	Puerto Rico	USD
297	Aruba	AWG
216	Tunisia	TND
290	Saint Helena, Ascension and Tristan da Cunha	GBP
1876	Jamaica	JMD
73	Russia	RUB
960	Maldives	MVR
853	Macau	MOP
\.


--
-- TOC entry 5264 (class 0 OID 16554)
-- Dependencies: 249
-- Data for Name: participa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participa (nome_canal, nro_plataforma, titulo_video, datah_video, nick_streamer) FROM stdin;
\.


--
-- TOC entry 5266 (class 0 OID 16565)
-- Dependencies: 251
-- Data for Name: patrocinio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patrocinio (nro_empresa, nro_plataforma, nome_canal, valor) FROM stdin;
\.


--
-- TOC entry 5269 (class 0 OID 16577)
-- Dependencies: 254
-- Data for Name: paypal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paypal (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, idpaypal) FROM stdin;
\.


--
-- TOC entry 5273 (class 0 OID 16593)
-- Dependencies: 258
-- Data for Name: plataforma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plataforma (nro, nome, qtd_users, empresa_fund, empresa_respo, data_fund) FROM stdin;
1	Farias - ME Box	0	230	996	2000-08-29
2	Collins, Brooks and Rogers Highlights	0	233	43	2011-09-09
3	da Cruz - EI Sync	0	852	467	2025-07-31
4	Barrett Ltd Realm	0	240	755	2007-11-30
5	da Cunha Castro - EI Select	0	914	346	2016-03-21
6	Garcia e Filhos Pod	0	331	133	1999-07-16
7	Arias, Marsh and Baker Flow	0	379	187	1998-08-03
8	da Luz Sousa S.A. Plataforma	0	768	751	2014-05-29
9	Hernandez-Lopez Portal	0	406	370	2000-11-26
10	Wilkinson, Davis and Parsons On	0	567	523	2000-01-09
11	Reynolds, Hernandez and Jennings Now+	0	987	412	1991-11-19
12	Lee, Mccarthy and Madden Channel	0	185	298	1995-03-02
13	Moreira S/A Stream	0	3	854	2003-09-14
14	Cavalcanti - EI Replay	0	724	788	2016-09-03
15	King Inc PocketTV	0	557	671	1990-06-11
16	Abbott, Hall and Young Queue	0	499	661	1996-06-03
17	Santos Gonçalves e Filhos Access	0	481	456	2024-11-15
18	Macedo Casa Grande Ltda. Ritmo	0	695	872	2019-04-05
19	Rodrigues S/A Mini	0	236	626	2022-03-11
20	da Paz Pimenta - EI Live+	0	136	270	1997-06-06
21	Rocha e Filhos Plus	0	435	845	2011-12-29
22	Barros e Filhos Streamers	0	695	630	2007-09-05
23	Caldwell Inc Collective	0	54	339	2024-11-16
24	Cassiano S.A. Scene	0	677	107	1994-07-01
25	Harris-Owen Flix	0	907	883	2012-09-18
26	Young, Ruiz and Whitaker Palco	0	245	731	2022-09-25
27	Garcia Inc Play	0	925	6	2021-11-20
28	Moura Câmara Ltda. Ponto	0	807	861	2020-09-07
29	Fernandes Viana e Filhos Now	0	86	747	1999-02-01
30	Dias Souza Ltda. Navigator	0	374	206	1993-12-24
31	Hardin-Mason Verse	0	693	730	2000-08-28
32	Walker PLC Stream	0	234	449	2010-10-26
33	Nascimento e Filhos Stream	0	625	832	2002-06-10
34	Johnson PLC Crew	0	141	190	2009-11-21
35	Baldwin Inc PocketTV	0	817	216	2006-01-07
36	Silva Cunha Ltda. Aqui	0	460	449	2023-08-31
37	Martins Sousa e Filhos On	0	98	52	1999-03-21
38	Berger PLC Flix	0	712	17	1990-06-23
39	Garcia, Martinez and Moore Edge	0	172	867	2011-04-23
40	Robinson Inc Collection	0	951	73	1994-12-01
41	da Rocha S/A Future	0	772	752	2011-11-24
42	Andrade S.A. Showcase	0	834	198	2001-01-11
43	King-Garza Air	0	483	847	2024-10-19
44	Thompson-Clark Now+	0	834	812	2019-04-03
45	das Neves Ltda. Universo	0	76	166	2004-08-21
46	Vasconcelos Albuquerque - EI Broadcast	0	25	407	1992-02-23
47	Fuller and Sons Cine	0	153	18	2006-09-28
48	White, Moran and Watts Portal	0	633	967	2015-08-22
49	Pereira Marques e Filhos Direct	0	596	567	2006-06-02
50	Morrison-Harper Fluxo	0	931	42	2017-03-28
51	Odonnell-Davenport Collection	0	872	150	1998-09-17
52	May, Smith and Murray Palco	0	19	728	2025-03-21
53	Thomas-Wood Atlas	0	564	413	2014-02-14
54	Abreu Monteiro S/A Cast	0	49	981	2018-01-12
55	Anderson-Yoder Flix	0	148	383	2024-03-28
56	Sales Montenegro Ltda. Premium	0	234	106	2000-03-25
57	Martin-Bennett Transmit	0	723	654	2018-02-17
58	Rezende Caldeira S.A. Portal	0	673	778	1990-11-29
59	Freitas S.A. Collective	0	882	655	2006-08-03
60	Mclean, Pena and Buck Access+	0	63	345	1994-01-12
61	Bowman-Delgado Collective	0	193	707	2005-10-07
62	Andrade Ltd Worlds	0	742	29	2019-03-28
63	Jesus Ltda. Onda	0	632	550	1998-11-04
64	Rodgers-Grant Spot	0	141	264	2022-08-20
65	Miles, Castillo and Torres Transmit	0	138	435	2001-11-02
66	da Mata - ME Streamers	0	593	175	2008-11-18
67	Oliveira Montenegro e Filhos Direct	0	415	581	2011-12-07
68	Myers, Dean and Schultz Pro	0	548	71	1996-01-29
69	Baker and Sons Hub	0	534	899	2020-08-23
70	Wagner Ltd Collection	0	826	465	2007-08-19
71	Baxter, Jackson and Mcneil Palco	0	356	472	2002-12-21
72	Wall Inc Plus	0	264	853	2010-12-06
73	Oliveira S.A. Entrada	0	777	511	2011-12-28
74	Novaes Brito S/A Future	0	356	674	2021-06-02
75	James, Scott and Young Originals	0	804	459	2011-04-28
76	Cirino S/A Originals	0	437	88	2017-12-21
77	Mendonça - EI PlayLab	0	965	240	2022-04-22
78	Jones and Sons Station	0	478	726	2002-10-19
79	Mendes S.A. Streamers	0	665	781	2002-09-17
80	Collins-Cole Prime	0	526	492	2008-11-26
81	Macias-Miller Portal	0	834	572	2021-07-03
82	Mendonça S.A. Worlds	0	821	212	2024-09-12
83	Fogaça Camargo Ltda. Universo	0	65	502	2009-06-25
84	Silva Mendonça Ltda. Portal	0	527	151	2005-01-29
85	Riley LLC Fluxo	0	168	812	2008-11-03
86	Oliveira Moura Ltda. Streamline	0	902	737	2018-10-18
87	Moore-Fields Reel	0	828	162	2002-02-17
88	Green PLC Wave	0	799	114	1995-09-27
89	Shaffer-Moore Studio	0	878	992	2009-08-08
90	Stanley Inc Connect+	0	691	607	2024-10-26
91	Dias Ltda. AoVivo	0	227	325	2025-05-12
92	Lee-Delgado Agora+	0	432	912	2018-04-02
93	Borges S.A. Sync	0	976	535	2021-04-14
94	Fonseca Ltda. Select	0	435	363	1992-02-02
95	Garcia Souza S/A Streamers	0	561	685	1990-05-05
96	Teixeira Albuquerque e Filhos Entrada	0	246	658	1991-02-01
97	Ramos - ME Filmes	0	211	14	2000-11-21
98	Moss-Cohen Box	0	345	165	1993-04-28
99	Rocha Viana - EI Flix	0	660	349	2016-12-03
100	Aragão - ME Studios	0	316	792	2010-12-17
101	Novaes Ribeiro S/A Future	0	941	644	2003-09-12
102	Albuquerque S/A Station	0	105	769	2011-08-29
103	Patterson PLC Showcase	0	431	580	2015-10-20
104	Clarke, Carr and Salazar Studios	0	791	67	2001-04-14
105	Macedo S.A. Lite	0	197	812	2009-03-29
106	Carter, Warner and Lynn Exclusive	0	56	383	1993-09-03
107	Barros da Luz e Filhos Access	0	699	654	2014-07-05
108	Tucker-Villarreal Beat	0	460	679	2016-07-24
109	Aragão Studio	0	360	900	2023-12-23
110	Melo da Rocha - EI Live+	0	464	581	2010-11-05
111	Rivera, Barnett and Burnett Crew	0	924	871	1990-10-04
112	White PLC Future	0	63	914	2004-06-07
113	Aragão Lima - ME Plataforma	0	762	125	2014-05-22
114	Barnes LLC Metaverse	0	52	146	2004-02-11
115	Rocha - EI Collective	0	795	373	2024-07-25
116	Rodrigues da Paz e Filhos Access+	0	73	716	2017-06-30
117	Freitas Ltda. Box	0	192	384	2013-11-26
118	Cirino e Filhos Verse	0	833	819	2010-06-03
119	Marques e Filhos Mundo	0	8	693	2009-12-25
120	Costa S/A Library	0	86	27	1994-11-08
121	Watkins-Maxwell LiveStream	0	573	883	2015-06-24
122	Chapman-Villa NextGen	0	81	205	2021-11-11
123	Nunez Group LoopTV	0	799	836	1991-02-07
124	Clark LLC PrimeTime	0	600	8	2000-04-07
125	da Paz Ltda. Spot	0	127	339	1998-08-22
126	Oconnor LLC Hub	0	450	245	2012-03-26
127	da Paz da Rocha - EI Lite	0	997	330	2014-06-03
128	Robinson, Pena and Williams OnRepeat	0	531	849	2006-02-06
129	Brown, Coleman and Deleon Station	0	306	753	1993-08-30
130	Perez, Peterson and Gregory Navigator	0	145	778	2023-02-06
131	Santos e Filhos Edge	0	722	750	2006-03-28
132	Lima Monteiro Ltda. Worlds	0	624	872	2010-03-06
133	Davidson-Jones Radio	0	166	213	1992-03-08
134	Brown LLC Pod	0	874	165	2009-03-06
135	Pimenta Freitas Ltda. Plus	0	435	104	2024-12-27
136	Souza Machado - EI Streamers	0	498	703	1997-08-11
137	Greene Ltd Lite	0	666	131	1992-02-15
138	Borges Cunha Ltda. Realm	0	505	51	1993-11-20
139	Sampaio Pacheco S/A Mais	0	387	191	2009-07-16
140	Brown and Sons Portal	0	538	88	2022-03-04
141	da Conceição da Cunha Ltda. Box	0	39	466	2004-09-15
142	Farias S.A. Metaverse	0	745	713	2012-02-14
143	Adams, Henry and Washington Reel	0	895	368	1996-11-24
144	Peixoto Gonçalves - EI Go	0	866	558	2002-04-10
145	Wells, Brown and Harris Edge	0	616	873	1991-01-29
146	Herrera-Burns Aqui	0	525	174	2014-02-25
147	Miller-Martinez Radio	0	958	525	2021-06-03
148	Dominguez and Sons AoVivo	0	914	686	2009-07-30
149	Camargo e Filhos Lite	0	81	915	2010-06-24
150	Cirino Vargas S.A. Worlds	0	969	9	1990-05-08
151	Aragão Ltda. Realm	0	838	625	2022-08-10
152	Chen PLC Future	0	484	214	2014-03-13
153	Harris PLC Navigator	0	270	789	1990-07-12
154	da Cruz Sales e Filhos Schedule	0	691	501	2002-08-05
155	Cisneros-Bryan HoraNobre	0	341	75	1996-05-28
156	Rezende Aragão - ME Equipe	0	838	872	2015-03-05
157	Marques Ltda. Spot	0	102	445	1994-11-12
158	Williams-Black Premium	0	903	729	1996-01-16
159	Monteiro Brito Ltda. Select	0	863	60	2016-10-02
160	Rodriguez, West and King Mapa	0	597	106	2013-12-24
161	Pereira da Paz Ltda. OnRepeat	0	218	876	2000-01-25
162	Castro S/A Portal	0	557	270	1992-06-04
163	Vieira - ME Sincroniza	0	258	857	2010-07-08
164	Gomes Silva e Filhos Premium	0	459	748	2019-06-21
165	Martins Rodrigues - EI Originais	0	906	442	2021-06-20
166	Smith LLC Access	0	432	291	2020-11-27
167	Frost-Dean Go	0	144	234	2005-01-19
168	Pacheco Souza S.A. Collective	0	846	755	1993-12-17
169	Andrade Jesus Ltda. CinePlus	0	649	956	2004-11-06
170	Sales Rodrigues S/A Spotlight	0	201	591	1992-10-02
171	Petersen, Andrews and White Channel	0	460	592	2024-02-20
172	das Neves Casa Grande Ltda. Studios	0	512	609	2006-12-17
173	Simpson PLC Portal	0	710	270	2004-09-02
174	Salinas, Henderson and Dunlap Universo	0	484	755	2023-04-25
175	Fernandes Sousa S/A Portal	0	111	522	1999-07-18
176	Smith-Shah Shows	0	457	94	2001-09-02
177	da Conceição Vargas S/A Queue	0	67	428	2004-05-01
178	Harper Group Plataforma	0	389	639	1994-02-24
179	Fogaça Borges e Filhos Filmes	0	685	259	2017-05-28
180	Wilkins, Ritter and Booth Exclusivo	0	681	224	2005-07-21
181	Holmes, Fletcher and Meyer Arquivo	0	608	630	2011-10-21
182	Costela Duarte e Filhos OnRepeat	0	123	504	2018-07-23
183	Marques Correia e Filhos Ponto	0	388	952	2020-11-30
184	da Luz Ribeiro e Filhos Exclusivo	0	311	604	2000-11-17
185	Gutierrez, Williams and Decker Equipe	0	736	952	2004-12-20
186	Freitas Cavalcanti Ltda. Universo	0	250	534	2001-09-05
187	Barbosa Santos Ltda. Ponto	0	823	437	2019-01-19
188	Sawyer-Li Cine	0	477	10	2009-09-29
189	Viana S.A. Reel	0	893	996	1993-10-30
190	Nunes Borges - ME Agora+	0	429	226	2019-06-13
191	Campos - EI Originals	0	245	565	1995-12-20
192	Jennings, Ferrell and Rios Ir	0	229	147	1997-12-30
193	Davis-Nguyen CinePlus	0	171	345	1994-11-28
194	Castro - ME Ponto	0	637	472	2021-04-29
195	Martin, Long and Fisher Next	0	428	413	2009-07-04
196	Collier Group Agora+	0	302	598	2002-09-15
197	Johnson-Turner Exclusivo	0	255	728	2023-10-12
198	Silveira da Conceição Ltda. Beat	0	825	583	1999-11-15
199	Berger-Allen Playground	0	973	269	1994-03-02
200	Jones-Evans Air	0	409	897	2005-11-18
201	Aragão S.A. Cine	0	790	521	2009-08-05
202	Browning-Hardin Aqui	0	542	670	2000-08-27
203	da Luz Almeida - ME Mais	0	577	284	2014-05-09
204	Clark-Rodriguez Cast	0	627	520	1998-08-10
205	Stein Ltd Aqui	0	69	991	2021-09-02
206	Hill Ltd Collection	0	562	820	2024-01-22
207	Cassiano S/A LiveStream	0	457	357	2009-11-17
208	Decker, Sandoval and Ortega Hub	0	855	788	2002-10-19
209	Watson-Bell Highlights	0	190	255	2016-01-10
210	Morrison PLC Future	0	676	44	2018-12-12
211	da Costa S/A Replay	0	224	294	2005-11-19
212	Andrade S/A Sync	0	554	884	2004-03-31
213	Silveira Guerra e Filhos Agora+	0	71	815	2024-02-26
214	Burns, Vega and Cooper NextGen	0	32	151	2016-05-23
215	Thomas, Hunt and Mitchell PocketTV	0	976	257	1991-07-02
216	Pastor da Mata S.A. Connect+	0	147	437	1990-06-01
217	Moreira Vargas S.A. Connect+	0	904	656	1993-05-30
218	Mcclure-Reed Exclusivo	0	728	614	2003-04-24
219	Jordan-Valdez Now+	0	121	532	1998-06-18
220	Melo - ME Navigator	0	29	985	1991-07-18
221	Giles PLC Live+	0	788	114	2007-04-08
222	Torres, Mcdonald and Brooks Stage	0	491	122	2001-04-15
223	Davis, Hernandez and Rivera Select	0	858	565	2016-11-13
224	da Conceição Silveira S/A Palco	0	488	989	2017-04-14
225	Jesus - ME Canal	0	765	213	2000-11-21
226	Santos - EI Access	0	694	606	2014-04-25
227	Mason, Olson and Hubbard Gate	0	124	783	2000-11-02
228	Maxwell-Richardson Radio	0	276	636	2016-01-04
229	Bright-Anderson Now+	0	922	457	2023-01-07
230	Pham-Clark Spot	0	811	357	2013-08-08
231	Moura S.A. Stream	0	577	977	2025-10-18
232	Thomas, Cunningham and Weber HoraNobre	0	278	334	1991-06-09
233	Fischer-Mcpherson Air	0	767	953	2015-02-26
234	Alves Peixoto - ME Stage	0	901	203	1992-11-25
235	Sales - ME Spotlight	0	295	406	2018-02-11
236	Cain, Howard and Ramirez Air	0	583	914	2025-05-04
237	Wright, Taylor and Bryant Cinema	0	954	338	2010-10-09
238	Pinto Caldeira e Filhos Showcase	0	678	393	2014-10-29
239	Haas-Green Now+	0	53	733	2025-06-13
240	Borges Ltda. Crew	0	296	175	1997-11-04
241	Ramos da Cunha - EI Library	0	987	457	2020-07-21
242	Silva - ME Portal	0	146	578	2005-08-09
243	Lawrence LLC Pocket	0	960	566	1994-11-01
244	Lopes - ME Pod	0	300	770	2015-10-23
245	da Mota Sousa S/A Filmes	0	417	476	2000-09-27
246	Viana Pacheco S.A. Originals	0	900	556	2006-06-11
247	Taylor, Morris and Shields Beat	0	705	102	2013-12-03
248	Jordan Ltd Arquivo	0	819	152	2015-11-07
249	Barbosa e Filhos Flix	0	723	376	2006-05-04
250	Espinoza, Palmer and Yates Crew	0	880	440	1995-01-01
251	Rezende Ferreira e Filhos Now+	0	101	502	2016-07-06
252	Fletcher, Jones and Torres Studios	0	702	700	1995-09-30
253	Adams-Green Gate	0	651	292	1999-07-09
254	Cassiano Carvalho Ltda. Studios	0	389	595	2020-02-10
255	Rhodes, Watson and Richardson Ritmo	0	146	557	2010-09-27
256	Espinoza LLC Streamline	0	294	514	2017-08-09
257	Hunter-Cordova Broadcast	0	967	656	2022-10-10
258	da Rocha Moura e Filhos Collective	0	213	45	2006-04-22
259	Moraes Ltda. Exclusive	0	4	944	2012-07-15
260	Vargas Fonseca Ltda. Wave	0	397	621	1999-08-19
261	Wilkinson-Terry Vibe	0	126	2	1994-04-17
262	Garcia-Townsend Vibe	0	818	806	2014-05-15
263	Kelly-Ortega Atlas	0	718	728	2019-12-23
264	Barbosa - ME Select	0	884	636	2022-10-13
265	Davis and Sons Mundo	0	849	183	2020-10-03
266	Sá Nogueira - EI Exclusivo	0	485	957	1999-03-28
267	Powell-Smith Onda	0	382	394	2022-02-08
268	Sousa S.A. Sync	0	94	314	1993-09-11
269	Blankenship, Cowan and White Ponto	0	86	369	1994-06-16
270	Mendes Siqueira - ME Select	0	362	850	2006-12-22
271	da Cruz Sampaio - ME Collective	0	477	412	2022-03-17
272	Chavez, Cooper and Perez Replay	0	158	295	2010-05-17
273	Borges - ME Collective	0	534	59	2011-02-19
274	Porto Ltda. Spot	0	73	183	2022-06-11
275	da Conceição Ferreira S/A Plus	0	812	424	1990-09-21
276	Câmara Azevedo S.A. Originais	0	519	223	2017-03-09
277	Cruz-Harrington Originals	0	610	200	2021-02-05
278	da Paz - ME Portal	0	581	983	2025-08-26
279	Hayes LLC Go	0	189	166	1990-11-23
280	Williams-Lowe Universo	0	540	388	2004-07-19
281	Costa Cassiano Ltda. Portal	0	495	174	1995-07-31
282	Hale, Cunningham and Taylor Channel	0	830	882	2004-12-03
283	Sharp Ltd Box	0	218	297	2010-05-05
284	Mitchell Ltd Fila	0	877	308	2007-11-26
285	Andrade da Paz - EI Pocket	0	78	154	2013-03-22
286	Alvarez, Ellison and Russell Replay	0	215	451	2007-11-27
287	Barbosa Cardoso e Filhos Hub	0	297	885	2015-12-28
288	Maldonado Ltd Highlights	0	307	191	2023-10-05
289	Costa Pires e Filhos Collective	0	444	389	2017-04-07
290	Camargo Porto e Filhos Lineup	0	656	823	2016-11-21
291	Mendes Cunha Ltda. PocketTV	0	596	915	2005-04-06
292	Duarte S.A. Originals	0	12	414	1998-09-28
293	Johnson, Henry and Carson Realm	0	268	85	2019-11-15
294	Novaes Fernandes - ME Entrada	0	450	595	2002-12-25
295	Murphy-Wilson Spot	0	213	916	2009-10-08
296	Roach, Price and Scott Verse	0	172	60	2021-05-12
297	Rodriguez, Carr and Jones Portal	0	155	237	1996-08-05
298	Fuller, Green and Santos Premium	0	773	347	1997-02-24
299	Carter, Howard and Lane Streamline	0	324	606	2002-01-05
300	Lopes Dias - EI Flow	0	971	865	2010-10-21
301	Ramos da Rosa Ltda. Replay	0	918	374	2025-10-04
302	da Rocha Farias - EI Connect+	0	232	905	1994-10-22
303	Novais S.A. CastTV	0	612	93	2022-06-17
304	Perry-Lee Lite	0	39	981	2008-12-28
305	Monteiro Alves S/A Ritmo	0	149	682	1997-02-13
306	Silva LLC Air	0	969	580	2012-12-19
307	Garcia Moraes Ltda. Select	0	7	860	2020-11-27
308	Carvalho Barros S/A Filmes	0	721	576	1994-06-10
309	Campos Novaes S.A. Radio	0	73	897	2015-11-04
310	Santos Barros S.A. Fila	0	504	328	1990-01-21
311	Crawford Inc Filmes	0	784	955	2020-01-18
312	Campos Mendes - ME Crew	0	968	322	2000-11-19
313	Carpenter-Johnson Channel	0	777	27	2020-05-24
314	da Mata Nogueira S/A Plus	0	696	182	2019-11-05
315	Machado Ltda. Broadcast	0	851	34	1994-02-25
316	Smith PLC Pro	0	764	480	2002-09-09
317	Lima S.A. Originais	0	61	403	2016-02-04
318	Pastor Alves S/A Crew	0	917	660	1992-09-29
319	Pollard Inc Portal	0	132	116	1997-04-18
320	Lewis-Petty Filmes	0	155	828	1990-05-17
321	Leão Sales S.A. Go	0	503	691	2006-12-24
322	Leão Aragão - ME Hub	0	418	611	2009-03-20
323	Schmidt, Vasquez and Cox Next	0	507	791	2007-08-21
324	Rowe and Sons Sync	0	168	434	2016-11-01
325	Porto Montenegro S.A. Hub	0	224	428	2005-02-01
326	Jones LLC CinePlus	0	667	749	1994-09-14
327	Mendonça Garcia e Filhos Groove	0	927	33	2011-06-07
328	Costela e Filhos PocketTV	0	996	83	1991-02-01
329	da Rosa Teixeira Ltda. Ritmo	0	486	515	2005-10-19
330	Lopes S.A. Vault	0	799	315	1990-12-12
331	Drake LLC Portal	0	461	533	2010-11-04
332	Araújo e Filhos Atlas	0	212	298	2005-09-15
333	Cunha Sousa - EI LoopTV	0	336	556	2022-02-23
334	Lima Costela S.A. Mundo	0	428	308	2010-10-13
335	Watson, Richardson and Barron Onda	0	789	697	2023-12-15
336	Farias Cavalcante S/A Cinema	0	501	354	2018-04-25
337	Jesus S/A Onda	0	518	693	2021-09-29
338	Mendonça Moraes e Filhos Ritmo	0	570	964	1992-12-14
339	Novais Ltda. Connect+	0	129	666	2010-05-28
340	White-Summers HoraNobre	0	403	645	2006-01-07
341	Jones, Freeman and Carter Studios	0	257	328	1999-08-04
342	Sá Costa Ltda. Atlas	0	619	576	2008-12-30
343	Potts LLC Cinema	0	676	879	1994-09-17
344	Garcia and Sons Equipe	0	444	247	2016-06-12
345	Hood, Gamble and Diaz Future	0	61	346	1996-01-07
346	Griffin-Byrd Flow	0	148	793	1992-06-13
347	Cruz, Hall and Ramirez Loop	0	249	416	1990-04-02
348	Guerra S.A. Sync	0	493	442	2009-12-23
349	Cassiano Ltda. Sync	0	803	787	2017-03-29
350	Porto Melo S.A. Arquivo	0	495	302	2002-08-07
351	Lopes Ltda. Scene	0	735	686	1993-05-14
352	Harrison Ltd OnRepeat	0	261	381	1995-01-09
353	Souza Correia - ME Universal	0	371	868	2018-01-11
354	Benton-Perry Universal	0	778	911	1994-07-31
355	Foster, Scott and Johnston Streamline	0	380	607	2025-04-30
356	Guerra da Cruz S/A Cine	0	337	18	2016-12-04
357	Boyd, Fernandez and Torres Explorer	0	402	576	1999-03-06
358	Lutz-James Aqui	0	549	696	2011-05-29
359	Rodrigues Ribeiro e Filhos LoopTV	0	408	830	2012-05-06
360	Nguyen, Rhodes and Davis Filmes	0	961	221	2001-03-17
361	Griffin, Rubio and Miller Mundo	0	402	94	2024-11-17
362	Pereira S.A. Connect+	0	324	194	1996-01-22
363	Cruz, Cook and Henderson Vibe	0	496	301	2006-07-02
364	Smith-Martinez Sincroniza	0	855	910	2006-10-28
365	da Conceição Sampaio S.A. Queue	0	256	600	1999-08-14
366	Carney-Sherman Mundo	0	169	370	2016-07-02
367	Washington, Lam and Castro Collection	0	758	795	2012-02-20
368	Payne-Clark Exclusive	0	935	492	2021-02-10
369	Allen, Richardson and George Hub	0	517	884	2000-02-18
370	Vasconcelos Farias - ME Scene	0	901	727	2016-07-14
371	Montenegro S/A Collection	0	582	410	2007-08-21
372	Morales, Obrien and Montgomery Lite	0	911	829	1995-08-18
373	Morrow, Gonzalez and Wheeler CastTV	0	33	981	2017-08-13
374	Guzman Ltd Entrada	0	667	167	2003-11-23
375	Banks-Owens Studios	0	899	303	2006-03-22
376	Mills Group Onda	0	9	47	2011-09-14
377	Dias Moraes - ME Streamline	0	778	999	2009-07-24
378	Thomas, Jones and Jimenez Ponto	0	472	902	1994-11-26
379	Wang Inc Connect+	0	845	789	2022-11-03
380	Macdonald-Oneal Transmit	0	659	898	1995-02-16
381	da Rocha Melo S/A Agora+	0	446	35	1998-08-15
382	Mclean, Steele and Ware Stream	0	308	243	2024-12-03
383	Romero PLC CastTV	0	122	617	2001-11-12
384	Guerra Jesus - ME Connect+	0	295	243	2019-09-08
385	Dodson-Ward Mapa	0	723	282	2005-02-19
386	Ribeiro S/A Gate	0	535	720	2018-06-13
387	Freeman Inc Universo	0	501	57	2025-06-01
388	Pastor - ME Explorer	0	947	884	2007-04-20
389	da Rocha Martins e Filhos Gate	0	890	904	1999-02-14
390	Machado e Filhos Air	0	854	944	1993-06-09
391	Alves Barbosa - EI Plus	0	728	389	2022-02-23
392	Gomes e Filhos Onda	0	718	170	2019-12-11
393	da Mata Cavalcante S.A. Portal	0	541	196	2010-03-19
394	Hardin LLC Ritmo	0	972	107	2004-07-07
395	Nunes Correia - EI Palco	0	5	596	2008-04-09
396	Underwood, Wood and Gilbert Edge	0	949	702	2015-08-15
397	Silveira Pereira Ltda. Mini	0	181	629	1992-11-29
398	Mendes Rezende - EI Exclusive	0	210	666	2002-01-07
399	da Rocha Siqueira Ltda. Queue	0	351	632	2009-03-31
400	Cassiano Azevedo S.A. Hub	0	281	125	1993-05-31
401	da Rocha - EI Select	0	417	161	2008-03-11
402	Nelson PLC Connect+	0	591	755	2001-09-06
403	Cross, Tucker and Koch Vault	0	753	4	2014-05-25
404	Edwards, Moore and Griffin Pod	0	103	986	1993-05-09
405	Cassiano Brito e Filhos Premium	0	411	155	2019-04-10
406	Pastor Caldeira - EI Pass	0	529	497	2000-07-24
407	da Rosa Leão S/A On	0	950	101	2000-11-27
408	Hull, Campbell and Smith Portal	0	843	224	1991-08-25
409	das Neves Sousa - EI Streamline	0	690	461	2018-04-05
410	Saunders-Hampton Connect	0	737	618	2016-03-13
411	Câmara Fernandes S/A Equipe	0	699	612	1993-06-17
412	Young Ltd Connect+	0	880	806	2021-11-01
413	Casa Grande Martins S.A. LiveStream	0	11	130	2020-07-31
414	Adams-Floyd Arquivo	0	60	782	2013-12-18
415	Roberts, Hanna and Love Exclusivo	0	471	166	2019-09-03
416	Novais Nogueira S.A. Stage	0	423	495	2019-01-25
417	Sims-Smith Hub	0	886	788	2016-03-20
418	Nogueira Mendes S.A. CastTV	0	658	128	1998-09-08
419	Pimenta Cirino - ME Hub	0	984	839	2000-02-05
420	Meyers and Sons Replay	0	75	725	2012-06-09
421	Davis, Taylor and Hill CastTV	0	50	706	2017-05-09
422	Gutierrez-Stone Connect+	0	717	401	2001-04-12
423	Harris, Hudson and Taylor Aqui	0	629	272	2012-11-19
424	Hansen, Maldonado and Graham Pass	0	687	665	2015-06-22
425	Garrett-Hill Prime	0	955	735	2010-03-14
426	Souza Ltda. Plus	0	26	200	2018-02-04
427	Carr-Harris Lineup	0	233	188	2018-01-06
428	Jarvis, Craig and Simpson Sync	0	727	7	2022-07-01
429	Borges Barros S.A. Cine	0	64	633	1993-10-28
430	Rodrigues S.A. Now	0	488	894	1993-08-18
431	Moreira Nascimento Ltda. Exclusive	0	816	430	2023-11-21
432	Schaefer Group Verse	0	404	504	2004-11-01
433	Wilson LLC Library	0	905	561	2006-03-19
434	Porter, Mcguire and Moreno Originais	0	298	212	1990-03-01
435	Almeida Fogaça Ltda. Studios	0	716	465	2018-02-25
436	Bolton, Martinez and Oneal Vault	0	814	188	2020-04-30
437	Rodrigues Ltda. Flow	0	928	808	2022-08-06
438	Matthews-Fry Beat	0	785	309	2005-08-31
439	Rios, Pitts and Horn Studios	0	559	204	2002-08-17
440	Cirino - ME Loop	0	583	898	1992-10-17
441	Berry-Smith On	0	516	473	1990-02-16
442	Osborne, Flores and Davis Navigator	0	306	816	2024-05-05
443	Graves, Campos and Clark PlayLab	0	422	511	2001-07-20
444	Juarez LLC Broadcast	0	211	365	2010-06-19
445	Sales S.A. Agora+	0	35	449	2022-04-25
446	Johnson, Aguilar and Walls Streamline	0	812	339	2005-12-31
447	Machado - EI Transmit	0	273	883	2019-02-11
448	Pimenta e Filhos Navigator	0	605	723	1990-09-11
449	Moraes Almeida - ME Explorer	0	744	598	2000-03-08
450	Sampaio Silveira e Filhos Replay	0	689	31	2004-11-21
451	Weaver, Vasquez and Barnes Access+	0	159	948	1996-01-23
452	Dias Teixeira - ME Onda	0	307	184	2020-02-13
453	Perry-Lindsey Exclusive	0	392	742	2005-01-11
454	Newman, Woodward and Wells Highlights	0	407	608	1996-03-15
455	Garcia S/A Ritmo	0	420	980	2007-05-07
456	Henderson and Sons Spot	0	888	272	1995-02-04
457	Horton, Bishop and Torres Fluxo	0	968	18	2013-02-16
458	Thomas Ltd Live	0	770	77	2000-04-24
459	Rocha S/A Next	0	980	355	1994-08-15
460	Estes Inc Direct	0	916	892	2017-02-18
461	Adams, Smith and Wong Channel	0	603	373	2017-08-17
462	Guerra da Rocha - EI Transmit	0	483	774	2010-06-11
463	Jesus Pinto - EI Next	0	825	805	2008-11-20
464	Arnold-Kennedy Connect+	0	378	899	2001-11-29
465	Taylor, Walker and Rodriguez Future	0	27	490	2025-09-26
466	Mendes Sousa - EI Ritmo	0	484	491	2003-09-11
467	Costa S.A. Prime	0	383	448	1995-02-18
468	Costa - EI Now+	0	834	248	1999-10-24
469	Silva Nunes S.A. Exclusive	0	418	746	2013-02-27
470	Santos Rocha S.A. Next	0	966	203	2019-04-22
471	Roth, King and Cuevas Ponto	0	785	873	2007-06-14
472	Cardenas-Scott Pod	0	823	884	2000-02-12
473	Macedo Rezende S.A. Exclusivo	0	235	711	1998-07-24
474	Barrett Inc Queue	0	494	83	1992-04-30
475	Almeida Novais S.A. Next	0	695	820	2006-04-21
476	Travis, Hill and Pitts Future	0	247	718	1991-04-01
477	Clay-Garrett Entrada	0	494	498	2021-09-19
478	Caldeira S/A Mais	0	997	621	2008-11-25
479	Sousa Abreu Ltda. Reels	0	632	488	2006-07-30
480	Teixeira Carvalho S.A. Sync	0	956	966	1996-08-14
481	Gonçalves Ltda. Originais	0	420	205	2018-01-26
482	Mclaughlin, Salazar and Burch Onda	0	419	368	2024-03-14
483	da Rosa Ltda. Channel	0	496	615	2013-11-04
484	Alves S/A Beat	0	398	654	2004-12-26
485	Mendoza-Johnson AoVivo	0	671	247	2014-01-10
486	Schmidt and Sons Live	0	878	650	2024-11-13
487	Proctor-Lam Exclusivo	0	540	601	2006-02-19
488	Santos Freitas S.A. Wave	0	911	696	2009-05-11
489	Owens LLC Metaverse	0	672	1	2017-11-25
490	Ross Inc Reel	0	421	253	2023-07-19
491	Morales, Allen and Smith Cine	0	463	956	1994-02-10
492	Keller, Ruiz and Scott Universe	0	849	3	2011-06-09
493	Frederick, Davenport and Lee Atlas	0	497	63	1995-10-05
494	Watson, Pittman and Benson Network	0	978	892	1997-11-25
495	Correia Machado - EI Edge	0	979	70	1991-10-31
496	Fogaça Fogaça Ltda. Prime	0	188	519	2004-05-05
497	Silveira Correia S/A Palco	0	138	957	2001-12-24
498	Peixoto S.A. Sync	0	227	68	2003-08-08
499	Guerra Ltda. Broadcast	0	324	360	2023-08-04
500	Baldwin, Sawyer and Smith Mais	0	587	238	1993-09-06
501	Gonçalves Aragão S/A Playground	0	235	301	1997-01-06
502	Ramirez-Watson Direct	0	2	434	1996-04-15
503	Pimenta Freitas - EI Loop	0	251	960	2019-01-29
504	Hunt-Torres Streamers	0	276	784	2013-08-16
505	Aragão Mendes Ltda. Fluxo	0	609	230	2017-04-02
506	da Costa Santos S/A Verse	0	5	608	1991-08-01
507	Cochran-Wright Next	0	402	588	2022-01-15
508	Alvarado-Walsh Entrada	0	126	486	1995-09-21
509	French-Barnes Highlights	0	915	218	2014-07-05
510	Jackson, Mckenzie and Perez Onda	0	934	808	2015-12-20
511	Young, Holmes and Jimenez Transmit	0	773	708	2024-03-20
512	Gross PLC Highlights	0	714	442	2024-07-06
513	Silva Jesus e Filhos Portal	0	132	297	1990-06-08
514	Alves da Conceição Ltda. Originais	0	985	28	2000-12-08
515	Moore, Caldwell and Murphy Metaverse	0	542	425	2012-06-02
516	Aragão e Filhos Studios	0	800	774	2010-05-07
517	Edwards-Rodriguez Network	0	11	828	2019-01-20
518	Almeida Silveira Ltda. Stream	0	614	572	2017-06-14
519	Franklin-Evans Spot	0	516	131	2009-04-30
520	Farias Rezende - ME Play	0	651	105	1996-02-11
521	Johnson, Gardner and Young Ponto	0	67	231	2021-06-07
522	Fonseca - EI Ponto	0	406	263	2002-11-30
523	Dias Fernandes S.A. Flow	0	142	622	2017-10-05
524	Pires Novaes e Filhos LiveStream	0	69	342	2006-06-06
525	Mitchell, Rodriguez and Foster Flix	0	376	456	1997-10-26
526	Forbes, Mitchell and Cruz Air	0	422	774	2006-01-09
527	Doyle-Mcdaniel Onda	0	321	87	2007-04-03
528	Butler, Greer and Brown Radio	0	504	31	2019-09-29
529	Montenegro Ltda. Streamline	0	379	288	2003-01-23
530	Garcia S.A. Connect	0	90	645	2022-09-29
531	Walsh-Young Cinema	0	29	646	2017-02-13
532	Burnett LLC Universe	0	617	723	2012-04-23
533	Cavalcanti - ME Now+	0	239	608	2010-11-24
534	Flores, Lloyd and Johnson Next	0	625	957	2018-05-21
535	Gonçalves da Conceição e Filhos Streamers	0	79	242	2002-06-30
536	Barbosa Melo - EI Universal	0	832	802	2008-12-23
537	Lima Garcia Ltda. Live	0	786	773	2011-12-01
538	David, Brown and Tran Vibe	0	660	581	2019-03-10
539	Almeida Ltda. OnRepeat	0	302	913	2011-05-27
540	Borges Brito - ME Ir	0	855	69	2014-05-21
541	Morales, Case and Rivera Cine	0	1000	197	2005-12-01
542	Thompson Group Wave	0	470	742	2007-05-14
543	Nelson Group Worlds	0	921	536	2022-03-16
544	White-Gibson Showcase	0	806	955	1996-01-24
545	Teixeira Fogaça - ME Access+	0	970	623	1993-10-02
546	Hicks-Lara Verse	0	668	788	2021-05-12
547	das Neves Teixeira e Filhos Shows	0	627	653	2024-05-26
548	Branch, Hicks and Lopez Stream	0	805	172	2022-03-02
549	Barros S.A. Pod	0	22	517	2004-08-06
550	Machado S/A Worlds	0	336	200	1997-11-08
551	Cavalcanti Pimenta Ltda. Studio	0	722	22	2010-07-20
552	Allison-Fox On	0	461	443	1999-10-25
553	Graves, Pratt and Wilson Radio	0	707	810	2018-07-22
554	Lara and Sons Universo	0	782	784	1998-12-01
555	Baker, Mcknight and Villanueva Collection	0	872	770	2003-08-16
556	Summers, Rose and Lewis Spotlight	0	44	572	2017-01-05
557	Sales Lopes S/A Sincroniza	0	681	11	2004-10-10
558	da Conceição Castro Ltda. Transmit	0	805	198	2018-07-06
559	Kirk LLC On	0	285	976	2002-03-15
560	Daugherty Inc Realm	0	758	279	2023-08-31
561	Johnson, Yoder and Riley Streamline	0	413	390	2002-07-04
562	Alvarado and Sons AoVivo	0	375	278	2001-08-18
563	Joyce-Johnson Pro	0	984	729	1991-12-26
564	Gibbs-Williams Connect	0	486	553	1999-12-30
565	Wagner PLC Next	0	321	365	2015-11-03
566	Clayton-Davis Transmit	0	497	952	2003-08-08
567	Mullen, Moore and Sparks Loop	0	458	76	2000-08-12
568	Viana - EI AoVivo	0	365	407	1991-07-17
569	Kennedy, Sanchez and Sullivan Scene	0	70	367	2023-12-07
570	Fernandes Ribeiro S/A LiveStream	0	48	626	2019-03-08
571	Johnson LLC Realm	0	512	29	1996-05-31
572	Andrade Costa S/A Access	0	832	124	1992-01-05
573	Mendes da Rocha - ME Mapa	0	463	436	2010-06-06
574	Mcdonald and Sons Future	0	243	106	2016-06-30
575	Carvalho Nascimento - EI LiveStream	0	595	557	1995-06-01
576	Vega-Hill Channel	0	499	65	2023-01-08
577	Thomas, Clark and Miller Reels	0	975	919	2005-10-14
578	Leão Câmara S.A. Access	0	25	963	1999-06-10
579	Li, Orr and Jenkins Fluxo	0	425	96	2019-11-10
580	Mcfarland, Long and Hernandez Prime	0	740	694	2015-10-02
581	Mann, Johnson and Solomon Queue	0	404	47	1993-02-22
582	Becker-Rowe Streamline	0	260	761	2021-05-09
583	Dias - EI Streamers	0	284	625	2018-01-25
584	Teixeira - EI Spotlight	0	906	715	2010-11-16
585	da Cunha S.A. Pass	0	392	592	1992-04-04
586	Jesus Rocha - EI CastTV	0	994	357	1998-06-26
587	Martinez-Wise Fila	0	230	537	1994-07-03
588	Porto S.A. Spotlight	0	850	691	2019-01-11
589	Hood Group Arquivo	0	903	77	2020-02-07
590	Brown, Scott and Smith Pro	0	578	202	2023-07-03
591	Burke-Kennedy Originals	0	31	292	2024-04-21
592	Vargas Porto S.A. Channel	0	433	991	2018-01-08
593	Kelley, George and Carter Wave	0	292	682	2019-04-09
594	Mendonça Ltda. Flow	0	166	856	2016-05-07
595	Farrell-Martin Agora+	0	618	796	1995-11-17
596	Alexander LLC Beat	0	862	293	2017-03-26
597	Smith-Bradford Reels	0	85	479	2020-03-24
598	Nascimento da Mata - ME Cinema	0	64	235	2023-11-23
599	Murray, Wolfe and Cabrera Now	0	211	789	1996-12-30
600	Tucker Group PrimeTime	0	849	102	2006-03-14
601	Sá Ltda. Fila	0	893	733	2012-01-24
602	Deleon-Gould Edge	0	16	612	1994-02-05
603	Tapia Ltd Collection	0	415	701	2022-12-12
604	Andrade Santos Ltda. Verse	0	482	460	2011-10-07
605	Cameron, Ramos and Phillips Collection	0	316	684	1997-07-29
606	Alves Ltda. Schedule	0	857	855	2014-06-19
607	King-Singh Prime	0	520	145	2008-05-22
608	Baker-Ford Equipe	0	509	212	1994-11-08
609	da Cruz Borges - EI Atlas	0	503	215	2017-05-12
610	da Paz da Mata S/A CastTV	0	887	918	2007-07-21
611	Casa Grande e Filhos Mundo	0	555	494	2006-05-29
612	Pacheco Ltda. Lineup	0	718	313	1999-10-01
613	Aragão - EI Collective+	0	609	463	1991-12-17
614	Gonçalves Abreu e Filhos Streamline	0	950	695	2008-12-20
615	Barros da Paz S.A. Air	0	74	774	1990-02-21
616	Moreira - ME Beat	0	723	635	2001-07-27
617	Silveira - ME Groove	0	166	425	2015-07-23
618	Hughes-Gonzalez Originais	0	875	376	2006-04-02
619	Baker, Garcia and Smith HoraNobre	0	869	173	1998-09-02
620	Aparecida Macedo - EI Premium	0	61	852	2001-06-10
621	Pinto S/A Transmit	0	297	736	2022-10-02
622	Aparecida Ramos - ME Arquivo	0	352	282	2011-08-18
623	Dias Novais Ltda. Access+	0	608	766	2019-08-31
624	Good PLC Atlas	0	165	986	2022-09-17
625	Rodrigues Fogaça Ltda. Mapa	0	426	856	1994-08-29
626	Taylor-Day Canal	0	144	492	2010-11-08
627	Gomez, Kerr and Johnson Reel	0	486	877	2006-11-11
628	Huang-Turner Filmes	0	162	978	2004-12-21
629	Ramos Aragão S.A. Now+	0	856	947	2005-12-22
630	Jesus S.A. LiveStream	0	453	36	1998-07-07
631	Campos Correia Ltda. Fila	0	300	223	2007-04-02
632	Vieira Costa e Filhos LoopTV	0	807	200	2005-05-24
633	Davenport, Frye and Simon LoopTV	0	432	696	1995-05-10
634	Scott Inc Navigator	0	4	456	2020-09-17
635	Franklin, Zuniga and Cruz Studio	0	217	810	2012-02-04
636	Campos Andrade e Filhos Vibe	0	665	159	2015-07-29
637	Câmara S.A. Library	0	245	173	1997-10-08
638	Morales LLC Collective	0	712	701	1991-06-19
639	Sanders Inc Network	0	479	635	2018-12-01
640	Rios Moreira - ME Next	0	15	905	2003-07-02
641	Vargas Campos Ltda. Connect+	0	495	74	1994-06-15
642	Brito Nunes - ME Loop	0	778	575	2024-10-22
643	Barros Albuquerque e Filhos PocketTV	0	398	57	2011-12-18
644	Porter PLC Loop	0	289	226	2019-05-07
645	Gregory-Kemp Radio	0	907	46	1991-04-11
646	Kim, Wallace and Kennedy Go	0	922	600	2008-08-22
647	Andrade Carvalho Ltda. Portal	0	342	269	2009-02-04
648	Fowler, Wise and Edwards Streamers	0	984	612	2013-09-21
649	Duarte, Adams and Dawson PlayLab	0	615	438	2004-05-02
650	Fernandes S.A. Studios	0	921	785	2019-08-19
651	Moreira Cassiano S.A. Mini	0	540	18	2009-11-04
652	Harrison and Sons Streamline	0	679	456	2025-08-20
653	Dias Duarte - EI Box	0	798	456	2002-02-13
654	Melo Cassiano - EI Playground	0	574	379	1996-01-19
655	Green LLC Prime	0	527	383	2021-10-08
656	Sampaio Nogueira e Filhos Lite	0	712	57	1993-06-22
657	Johnson, Jones and Walker Loop	0	670	226	1992-03-01
658	Carvalho S/A Metaverse	0	207	314	1995-12-04
659	Brito Farias S.A. Pro	0	920	946	2012-10-15
660	Cirino Costa S.A. Play	0	50	878	2019-05-26
661	Souza - EI Collective+	0	268	39	2006-01-31
662	Stout, Roman and Morales Broadcast	0	592	317	2016-07-19
663	Cassiano Fonseca - EI Pass	0	278	158	2011-12-04
664	Sampaio Freitas - EI Queue	0	652	287	1993-08-06
665	Duarte Albuquerque S.A. HoraNobre	0	956	212	2011-12-07
666	Brooks-Conway Lineup	0	49	958	2022-12-04
667	Perez, Duran and Mcdowell Ir	0	705	408	2019-02-16
668	Costa Lopes Ltda. Stage	0	122	136	2024-01-21
669	Thornton, Thomas and Rose Now	0	750	163	2001-08-28
670	Brown-Harris On	0	768	791	2023-10-18
671	Bell-Wolfe Exclusivo	0	40	490	1994-11-28
672	Arnold Ltd Universe	0	417	685	1998-07-09
673	Lopes Sampaio - ME Streamers	0	46	210	2008-06-06
674	Weber-Johnson Flix	0	187	387	1990-06-10
675	Novais - ME Live	0	151	42	2000-11-20
676	Moreno, Gordon and Evans Mundo	0	879	967	2022-07-31
677	Williams-Nelson Streamline	0	520	755	2006-09-25
678	Johnson Ltd Palco	0	267	821	2013-02-03
679	Wolfe PLC Portal	0	800	953	1992-06-09
680	Sloan Group Arquivo	0	818	827	2001-04-03
681	Daniels, Harris and White Portal	0	640	172	2020-05-27
682	Deleon, Wright and Dalton Mini	0	273	988	1995-09-17
683	Hunt and Sons PocketTV	0	325	39	2009-09-19
684	Sales Guerra Ltda. Crew	0	806	588	2006-06-28
685	Novais Câmara - EI Pod	0	64	795	2010-06-20
686	Pires Duarte e Filhos Equipe	0	901	150	1996-10-02
687	Richmond-Harper Broadcast	0	266	862	1991-04-30
688	Fogaça Pinto - EI Streamline	0	302	798	1999-11-11
689	Pires Mendes Ltda. Collection	0	122	153	2010-02-10
690	Barros da Paz Ltda. Palco	0	437	650	2020-09-16
691	Novais Barros e Filhos Wave	0	168	211	2010-09-27
692	das Neves S.A. LoopTV	0	795	476	2016-05-18
693	Bailey, Rice and Johnson Broadcast	0	397	393	1992-09-27
694	Murphy Ltd Highlights	0	33	559	2014-05-26
695	Novais da Costa S/A AoVivo	0	125	955	1990-12-11
696	Reed-Espinoza Mais	0	682	802	1994-02-02
697	Pastor Ltda. HoraNobre	0	459	353	2012-01-03
698	Alves Castro - ME Now	0	418	756	1999-02-18
699	Chan, Mckinney and Perez Canal	0	699	75	1990-06-01
700	Monteiro e Filhos Broadcast	0	434	795	2020-07-18
701	Castro Almeida - EI LiveStream	0	11	176	2022-05-30
702	Machado S.A. Originais	0	107	225	2020-02-22
703	Vargas Mendes S/A Vibe	0	311	389	2017-12-14
704	Roberts, Esparza and Bishop Arquivo	0	990	448	2016-03-20
705	Taylor-Nolan Transmit	0	109	851	1996-02-13
706	Stanley-Johnson Lineup	0	160	9	2014-03-29
707	Lee, Hayden and Livingston Collection	0	14	704	2015-04-23
708	Rios PLC Originals	0	356	172	2024-08-10
709	Day, Anderson and Fisher Wave	0	949	282	2007-01-28
710	da Rocha S.A. Portal	0	991	324	2007-08-19
711	Campos e Filhos Agora+	0	352	898	2012-12-05
712	Lopes Silva - ME Library	0	40	287	2012-09-27
713	Souza Rocha Ltda. Flix	0	804	475	2001-07-08
714	Owens-Herrera Navigator	0	40	295	2009-12-29
715	Fogaça - ME Arquivo	0	540	698	1995-06-30
716	da Rocha e Filhos Crew	0	671	330	1999-07-17
717	Teixeira S/A Portal	0	260	651	2008-07-11
718	Silva Leão - EI Broadcast	0	137	971	2005-01-27
719	Rice PLC Spot	0	676	521	1994-06-03
720	Cruz Inc Next	0	87	566	2017-06-19
721	Ferguson, Coleman and Key Vault	0	475	126	2014-07-07
722	Garcia-Welch Queue	0	412	329	2016-07-15
723	Nogueira Leão - EI Originais	0	603	835	2016-04-26
724	Pinto - ME Prime	0	539	962	2006-07-16
725	Brown-Martinez Universo	0	692	631	1993-01-09
726	Silveira Ferreira e Filhos Box	0	969	195	2023-09-10
727	Garrison-Cardenas Station	0	514	873	1999-04-10
728	Thompson Ltd Cast	0	516	143	2004-07-19
729	Vasconcelos S.A. Hub	0	7	891	2018-05-16
730	Campos Ltda. Mapa	0	849	401	1996-10-12
731	Jones, Thomas and Simmons Aqui	0	903	948	2007-08-28
732	Pacheco Barros - EI LoopTV	0	985	858	2001-12-15
733	Sutton Inc Streamline	0	672	132	2016-09-23
734	Albuquerque Gonçalves - EI Beat	0	1	598	1992-12-12
735	Williams, Moore and Walters Future	0	470	792	2000-07-16
736	da Conceição S.A. Pocket	0	231	592	2024-01-22
737	Barbosa Fogaça - EI Cast	0	89	632	2018-09-18
738	Harris, Vaughan and Bryan Network	0	474	149	2003-11-12
739	Thompson-Rodriguez Sync	0	888	475	1991-07-03
740	Sampaio Pimenta S.A. Playground	0	541	278	2017-12-28
741	Brown PLC Gate	0	344	133	2010-05-04
742	Fields Inc Metaverse	0	978	459	2002-07-22
743	Cavalcanti Borges - EI Mundo	0	392	975	1995-04-27
744	Albuquerque Camargo S/A Equipe	0	654	562	2025-04-20
745	Hunt-Simmons Lite	0	403	394	2009-06-13
746	Bradshaw LLC Crew	0	229	379	1994-01-21
747	Moreira Aparecida - ME Groove	0	447	799	1997-02-11
748	Fonseca S.A. Mundo	0	201	721	1997-07-25
749	Castro Teixeira Ltda. Access+	0	653	526	1996-01-12
750	Higgins, Chapman and Odonnell Mini	0	936	74	2020-07-21
751	Gomes Brito Ltda. Now	0	190	712	2024-04-19
752	Santos - ME Fluxo	0	787	910	2011-11-17
753	Fogaça Porto e Filhos Broadcast	0	440	553	2003-06-21
754	Aragão Rodrigues - ME Replay	0	711	859	1997-09-22
755	Hines LLC Spot	0	775	520	2010-04-07
756	Jones-Chapman Vault	0	87	341	2006-05-08
757	Mendes - ME Access	0	814	846	2012-11-29
758	Phillips-Rose Navigator	0	788	849	2021-05-06
759	Hendricks, Anderson and Howell Originais	0	787	929	1993-08-22
760	Martinez LLC Atlas	0	632	651	2021-03-05
761	Parker PLC Premium	0	385	830	2015-04-06
762	Gonzalez-Watson Future	0	625	396	2016-03-22
763	Cavalcante da Costa S.A. Broadcast	0	922	755	1990-12-07
764	Sampaio S.A. Ir	0	457	969	2014-04-07
765	Shepherd-Wright Exclusivo	0	203	203	2015-04-14
766	Le-Jefferson Streamline	0	301	421	2007-11-21
767	Correia Teixeira S.A. HoraNobre	0	215	771	2004-08-25
768	Castro Viana Ltda. Flix	0	839	63	2013-11-28
769	Farias da Rocha - EI Station	0	957	976	1998-11-01
770	Perez, Adkins and Mason Air	0	673	91	2006-02-14
771	Sá Moura - ME Beat	0	656	711	2014-07-11
772	Cavalcanti Garcia - ME PlayLab	0	581	207	2006-09-30
773	Payne-King Plataforma	0	434	234	1990-04-08
774	Adams Group Universe	0	109	861	2013-04-16
775	Long-Black Studio	0	568	396	2025-06-30
776	Anderson, Duarte and Freeman Mapa	0	7	916	2019-11-26
777	Jimenez, Brown and Clark Cine	0	992	265	2005-04-14
778	Thomas Group Mini	0	766	3	2024-03-31
779	Graham-Robertson Edge	0	157	313	1998-02-20
780	Jackson-Zimmerman Streamline	0	783	858	2008-12-17
781	Araújo S/A Collective+	0	998	277	2018-02-23
782	Correia Marques - EI PocketTV	0	202	816	2006-05-10
783	Pacheco Sampaio - ME Onda	0	97	101	2016-05-22
784	das Neves Ramos S/A NextGen	0	224	210	2003-01-31
785	Acosta, Blanchard and Perez Library	0	290	159	2019-11-08
786	Jacobson-Rivera Portal	0	536	105	1999-01-25
787	Cavalcante Cavalcante - EI Studios	0	641	239	2015-04-18
788	Fogaça Carvalho - EI Studio	0	64	506	2014-11-04
789	Woods-Smith Exclusivo	0	165	60	1991-09-23
790	Moreira Sampaio - EI Streamline	0	776	66	2011-05-05
791	Hardy-Smith Universal	0	744	413	2005-08-08
792	Montgomery-Mcguire Replay	0	106	917	1996-01-19
793	Salazar-Mathis Vibe	0	145	589	2010-04-14
794	Lara LLC Ponto	0	959	666	1991-05-20
795	Myers LLC Navigator	0	849	431	2003-07-23
796	Aragão Marques e Filhos Vault	0	426	324	2025-08-05
797	Ribeiro - EI Premium	0	461	725	2011-04-30
798	Moreira da Costa S/A Premium	0	110	757	2015-09-02
799	Stewart-Moore Box	0	556	169	2014-05-31
800	Guerra Alves - EI Hub	0	501	138	2024-12-28
801	Benton PLC Future	0	15	670	2006-03-08
802	Costela Macedo Ltda. Universal	0	617	523	2004-04-22
803	Fernandes Ltda. Streamline	0	422	242	2007-11-17
804	Miller, Cooper and Lee Flix	0	855	363	2006-11-21
805	Duarte Campos Ltda. Lineup	0	514	182	1990-02-03
806	Walker, Carpenter and Brown Originals	0	965	214	2011-04-23
807	Fox-Moreno Network	0	7	28	2016-05-13
808	Macdonald, Parker and Perez Access	0	976	303	1999-08-23
809	da Conceição Almeida e Filhos Fluxo	0	662	273	2013-06-29
810	Cardoso Ltda. Shows	0	658	942	2012-06-20
811	Hardin Ltd Flix	0	971	320	2010-12-23
812	Siqueira Farias - EI PocketTV	0	37	354	2007-02-09
813	Macedo Sousa - EI LiveStream	0	119	557	1993-11-27
814	Carter Ltd Prime	0	468	414	1993-10-01
815	Cardoso S.A. Air	0	647	390	2025-03-26
816	Finley Group Sincroniza	0	12	672	2023-04-01
817	Almeida - ME Broadcast	0	818	758	1994-07-13
818	Williams-Ray Originais	0	359	47	2000-01-04
819	Aparecida Campos Ltda. Sincroniza	0	345	397	1999-09-05
820	Novaes e Filhos Access	0	965	992	1995-01-02
821	Vieira Moraes e Filhos Now+	0	450	141	1996-12-04
822	Rezende Ramos e Filhos Streamers	0	291	302	2013-06-27
823	Marques Moreira Ltda. Portal	0	578	245	2016-09-23
824	Alves - ME Reel	0	79	154	1990-06-10
825	das Neves - EI Pod	0	616	110	2019-10-07
826	Mendonça Ribeiro e Filhos Schedule	0	392	419	2016-05-31
827	Nixon, Peterson and Rios Live+	0	842	543	1991-12-11
828	Nascimento S.A. Entrada	0	368	647	2021-01-09
829	Deleon-Crawford LiveStream	0	410	832	2013-01-18
830	Silva Moura - EI Aqui	0	771	280	2007-06-25
831	Peixoto da Luz S.A. Connect	0	778	598	2015-03-20
832	da Rocha Barbosa S/A Lineup	0	892	93	2007-10-20
833	Olsen and Sons Spotlight	0	880	377	2007-12-05
834	Sheppard PLC Premium	0	995	232	2021-03-04
835	Palmer-Rodriguez Beat	0	674	97	1991-03-29
836	Archer-Martinez HoraNobre	0	240	932	2013-03-30
837	Moura Gomes Ltda. Mais	0	412	859	1996-06-16
838	Abreu Ltda. OnRepeat	0	228	25	2024-06-22
839	Kim Inc Navigator	0	911	3	2002-08-22
840	Peterson Group Onda	0	563	61	2012-12-02
841	Vasconcelos Dias S/A Agora+	0	404	601	2024-10-09
842	Andrade Mendonça - ME PrimeTime	0	428	497	2022-07-20
843	Benson, Sanchez and May Playground	0	494	56	2017-07-31
844	Miranda Inc Sincroniza	0	305	400	1992-11-18
845	Johnson-Davidson Flow	0	757	431	2008-07-24
846	Hunt PLC Reels	0	749	287	2020-02-01
847	Cooper, Mason and Caldwell Live+	0	165	333	2007-08-22
848	Leão Peixoto e Filhos Filmes	0	286	737	1990-04-30
849	Brito Cardoso - ME Direct	0	983	136	2003-07-07
850	da Cunha Campos S.A. Pro	0	712	503	1994-05-30
851	Grant and Sons Transmit	0	7	789	2023-03-04
852	Sousa Rocha - ME Mapa	0	522	212	1996-01-04
853	White-Simmons Beat	0	64	717	2016-01-21
854	Swanson-Green Plataforma	0	363	42	2005-10-31
855	Pastor Cavalcante - ME Air	0	421	778	2022-11-28
856	Fernandes Costa S/A Pod	0	823	934	2017-04-21
857	Sales Câmara S.A. Connect	0	378	263	1996-08-16
858	Howard Group Library	0	594	814	1999-04-14
859	Camargo Ltda. Mini	0	134	983	1997-10-14
860	Rocha S.A. Highlights	0	687	938	2015-05-09
861	Miller, King and Riley Realm	0	143	408	1990-09-19
862	da Cunha - EI NextGen	0	111	207	2007-10-21
863	Stewart-Johnson Now+	0	317	416	2013-09-20
864	Fernandes Fogaça S/A Connect	0	565	188	2021-08-26
865	Rodriguez, Boyer and Graham Spotlight	0	929	420	2007-02-26
866	Vasconcelos Mendes Ltda. Verse	0	899	444	2000-09-10
867	Tran, Ross and Sanchez Prime	0	886	595	1991-06-08
868	Davis Ltd Cast	0	866	721	2004-12-15
869	Albuquerque Ltda. Plus	0	922	430	1991-10-25
870	Williams-Sullivan Gate	0	363	322	2008-08-17
871	Novaes Albuquerque Ltda. Aqui	0	189	680	1998-02-09
872	Caldeira Costa - EI Flix	0	614	367	2009-11-30
873	Rowe-Huber Now	0	654	222	2012-10-17
874	Sanders and Sons Schedule	0	317	695	2021-03-28
875	Fernandes - ME Access	0	449	812	1998-07-21
876	Morgan Group Showcase	0	865	874	1999-05-29
877	Porto e Filhos Mundo	0	151	430	2006-08-08
878	Correia Mendonça - ME Canal	0	692	469	2000-03-10
879	Costela Caldeira S.A. Stream	0	691	855	2010-05-15
880	Moura Farias - EI Cine	0	824	202	2017-08-17
881	Franklin-Robinson Equipe	0	505	35	2009-05-03
882	Rodrigues Moraes - ME Collection	0	919	197	2015-03-06
883	Teixeira Montenegro e Filhos Channel	0	978	146	2006-03-30
884	Boyd-Campbell Sync	0	113	484	2011-03-20
885	Ruiz Inc Flow	0	754	721	2007-01-05
886	Monteiro S.A. Connect+	0	62	713	2021-06-23
887	Schwartz-Love Arquivo	0	165	856	2018-12-28
888	Gomez, Moore and Henderson Filmes	0	298	709	2007-05-17
889	Lima - ME Vibe	0	985	988	2002-03-20
890	Wilkins, Stevenson and Melendez Live+	0	65	335	2025-09-23
891	Barbosa Ribeiro - ME NextGen	0	882	737	2008-12-05
892	Cox LLC Lite	0	380	199	2020-07-19
893	Vega-Sparks Filmes	0	64	64	1999-08-10
894	Conway, Griffin and Bailey Canal	0	660	476	2019-01-02
895	Andrade - ME Wave	0	630	84	2021-01-02
896	Garcia, Martinez and Horton AoVivo	0	936	438	2003-02-25
897	Melo da Cunha S/A Verse	0	300	636	2002-11-19
898	da Mota Castro e Filhos Premium	0	342	693	2021-05-13
899	Ferreira Gomes - EI Box	0	629	299	2020-08-02
900	Bradley, Williams and Smith Pass	0	770	67	1995-08-17
901	Ferreira da Mota Ltda. Entrada	0	539	344	2009-07-31
902	Jackson-Monroe Studio	0	308	990	1991-11-24
903	Burke, Sparks and King Plus	0	19	29	2005-01-08
904	Ward, Brown and Sanchez Highlights	0	328	546	2015-01-23
905	Rodrigues - EI Pocket	0	121	170	1995-11-10
906	Vargas - ME Box	0	263	174	2009-05-13
907	da Cruz Vargas - ME Pass	0	751	737	2006-07-07
908	Hoffman-Rodriguez Universal	0	431	689	2011-01-18
909	Adams Inc Onda	0	264	441	2022-03-22
910	Knapp, Parker and Miles Equipe	0	649	582	2011-09-09
911	Mendes Sampaio Ltda. CastTV	0	406	988	2008-07-05
912	Gates-Larson Showcase	0	952	570	2024-11-23
913	Cavalcante Rocha - EI Fluxo	0	528	514	2019-02-20
914	Davis, Long and Clark PrimeTime	0	230	862	1994-02-18
915	Higgins LLC HoraNobre	0	204	759	2013-08-22
916	Roberts PLC Box	0	57	514	2007-07-14
917	Cassiano Borges S/A Entrada	0	664	936	2023-02-09
918	Roman and Sons Beat	0	26	287	1999-07-31
919	Sanders, Harris and Richards Agora+	0	656	583	2019-01-20
920	Carney Group Reel	0	409	64	2017-11-25
921	da Rocha da Cruz - ME Streamers	0	912	8	2008-03-31
922	Garcia - ME Prime	0	208	579	1999-10-28
923	Rios S.A. Aqui	0	76	685	2018-02-17
924	Fisher, Stevens and Nelson Vibe	0	475	693	1991-09-20
925	Smith, Yates and Franklin Access	0	27	255	2022-01-04
926	Austin-White Play	0	991	685	1996-04-15
927	Borges Campos - EI On	0	799	209	1998-06-22
928	Alvarez-Pitts LiveStream	0	483	104	2012-07-07
929	Novaes Aragão - EI Sincroniza	0	803	514	2010-05-23
930	Cunha Monteiro - ME Hub	0	403	237	1997-09-19
931	Siqueira Peixoto S.A. Box	0	268	894	1993-12-23
932	Pires - EI Access+	0	332	667	1994-01-24
933	Ferreira Albuquerque S/A Verse	0	706	19	1997-10-30
934	Nielsen Inc Connect	0	143	838	1993-09-10
935	Nunes Machado e Filhos PocketTV	0	873	894	1999-12-19
936	Pastor Borges - ME Mais	0	186	711	2004-10-13
937	Patel, Romero and Skinner Go	0	569	546	2015-04-04
938	Cavalcante Viana - EI Universo	0	725	4	1990-12-12
939	Torres, Cruz and David Universo	0	203	806	1992-05-30
940	Mason and Sons On	0	473	969	1999-04-04
941	Mendes Machado - ME Universo	0	885	503	2003-05-27
942	Young, Vazquez and Torres Equipe	0	543	658	2009-02-05
943	Novais Lima S.A. Pro	0	622	144	2001-10-19
944	Macedo Moraes - ME Studios	0	204	412	2019-10-26
945	Nascimento da Luz S/A HoraNobre	0	38	367	2012-04-02
946	Fitzgerald, Alvarez and Butler Palco	0	326	15	2025-04-06
947	Kelly, Molina and Meyer PocketTV	0	436	588	2015-01-19
948	Meyer, Carr and Jackson Portal	0	483	505	1993-12-28
949	Moura Monteiro S/A Entrada	0	543	37	2018-12-21
950	Cirino Macedo S.A. Portal	0	242	224	2010-04-30
951	King, Graves and James Pod	0	321	115	1990-08-29
952	Freitas e Filhos Exclusive	0	627	403	1991-10-07
953	Carvalho da Cruz - ME Collection	0	654	701	1994-04-23
954	Peixoto Oliveira - ME Universo	0	893	390	2016-01-11
955	da Mota - ME OnRepeat	0	861	654	1995-11-08
956	Brown, Reeves and Ortiz Go	0	579	270	2007-02-27
957	Monteiro Abreu e Filhos Cinema	0	487	585	2018-07-02
958	Combs-Stewart On	0	649	369	1992-08-10
959	Marques Lima Ltda. Next	0	224	891	1992-01-23
960	Brown Inc Sync	0	440	503	2025-07-29
961	Silva - EI Replay	0	608	380	2017-04-29
962	Macedo da Rosa Ltda. AoVivo	0	25	81	2004-09-09
963	Aguirre, White and Kerr Metaverse	0	217	856	2019-08-18
964	Pires Cunha Ltda. Go	0	560	799	2024-03-02
965	Miller, Carter and Washington Collective	0	963	465	1995-10-31
966	Ribeiro da Rocha - EI Palco	0	487	794	2013-08-27
967	Allen PLC Hub	0	632	129	2008-01-16
968	Silveira Martins e Filhos Studio	0	170	545	2023-01-06
969	Potter-Carlson Canal	0	42	509	2006-12-31
970	Robinson LLC Canal	0	448	481	2020-02-16
971	Pastor Jesus - ME Entrada	0	967	934	2004-05-16
972	Nascimento S/A Streamers	0	444	803	1996-04-08
973	Almeida - EI Box	0	644	517	2010-11-18
974	Andrews-Harris Aqui	0	241	113	1991-12-12
975	Moreira Duarte S/A Sincroniza	0	865	818	2002-05-26
976	Kemp, Martinez and Cox Flix	0	77	119	1993-12-27
977	Evans, Gomez and Martin Navigator	0	802	855	2007-12-22
978	Davis-Paul Reel	0	564	967	2021-01-20
979	Almeida Viana S.A. Beat	0	573	747	1996-02-10
980	Farias Siqueira e Filhos Mini	0	798	278	2005-05-20
981	Novais Novais - ME Portal	0	425	326	1990-01-06
982	Larson LLC Streamline	0	990	526	1999-10-04
983	Souza S/A Entrada	0	829	532	2007-09-28
984	Cooper-Underwood Streamline	0	902	531	1993-07-04
985	Cunha da Costa Ltda. Portal	0	320	345	1990-01-06
986	Silva Ltda. Canal	0	57	767	1996-08-07
987	da Rosa Sá - EI NextGen	0	644	312	2010-08-16
988	Curtis, Lopez and Taylor On	0	986	396	2003-02-28
989	Ferreira - EI Live+	0	58	754	2003-04-20
990	Duarte da Paz S.A. CinePlus	0	977	29	2024-02-15
991	Sherman-Hudson Loop	0	245	2	2017-12-12
992	Castro LLC Beat	0	274	547	2024-02-19
993	Barbosa Lopes - ME Hub	0	942	35	1994-02-25
994	Travis, Thompson and Murphy Streamline	0	503	523	1996-12-06
995	King-Hughes PocketTV	0	529	718	2004-09-12
996	Sampaio Gonçalves - ME Atlas	0	142	473	2019-08-22
997	Larson-Sutton HoraNobre	0	916	975	1998-07-24
998	Pena-Mays Spot	0	843	532	1998-03-13
999	Jones, Hoffman and Costa Live	0	393	931	2015-06-27
1000	Leão Barbosa S.A. Onda	0	415	403	2017-12-10
\.


--
-- TOC entry 5277 (class 0 OID 16607)
-- Dependencies: 262
-- Data for Name: plataforma_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plataforma_usuario (nro_plataforma, nick_usuario, nro_usuario) FROM stdin;
\.


--
-- TOC entry 5280 (class 0 OID 16617)
-- Dependencies: 265
-- Data for Name: streamer_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.streamer_pais (nick_streamer, nro_passaporte, nome_pais) FROM stdin;
\.


--
-- TOC entry 5281 (class 0 OID 16625)
-- Dependencies: 266
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (nick, email, data_nasc, telefone, end_postal, pais_resid) FROM stdin;
jameswall	manuela46@example.net	1917-10-25	0800 188 6911	32381 Katrina Fall Apt. 511, New Cathy, MO 36625	Iran
emanuellypimenta	anavarro@example.net	1977-05-23	0300-240-8620	280 Bennett Parks, South Carlaview, WI 54488	Azerbaijan
matthew06	tda-cunha@example.net	1912-02-21	+55 (081) 4424-2363	61587 Jennifer Pike, Lake Danielhaven, AL 30322	Kyrgyzstan
lunnaalbuquerque	barry30@example.org	1936-03-20	(564)707-0013	Ladeira Pereira, 63, Cidade Jardim Taquaril, 90792184 Sampaio do Sul / DF	Sri Lanka
juanfonseca	mary80@example.com	2001-11-09	+55 (031) 9633-8829	638 Sarah Brook, South Thomasview, GA 64649	Guinea
dominguezashley	vitor70@example.org	1979-12-11	(550)957-2008x544	08991 Wayne Port Apt. 856, North Melissaside, WA 00787	Solomon Islands
brenoda-costa	isabela95@example.net	1972-06-12	743.984.6006x1833	71125 Leslie Glen, South Amy, MI 66964	Jordan
carterneil	marshkristine@example.com	1916-03-08	(378)399-2498x133	Rodovia de Pires, 9, Santa Cecilia, 41386015 Araújo do Oeste / GO	Bangladesh
ana-beatriz76	martinezmelissa@example.com	1917-03-03	81 2526-6192	99763 Angela Path, Hortontown, PR 23167	Cambodia
maysa45	joana28@example.com	1985-10-14	359-645-0639	Alameda Rios, 137, Monte Azul, 51398472 da Paz dos Dourados / MS	Wallis and Futuna
bianca85	vkennedy@example.org	2004-08-25	217.249.6163x771	0858 Cox Curve Suite 524, South Benjaminborough, OK 96566	Aruba
yborges	michael52@example.com	1935-05-15	11 5988-2625	3200 Ronald Valley Apt. 388, Millerview, IN 45802	Iraq
mcmillanerik	vmachado@example.org	1945-05-01	323-564-1295	Passarela de Rodrigues, 7, Mirtes, 34696108 da Paz de Souza / PA	Peru
caiomelo	hvasquez@example.com	1952-06-15	961-941-7218	Estrada de Silva, 52, Céu Azul, 51109-022 Mendes / DF	Madagascar
thiago22	da-costastella@example.net	1922-11-06	+55 (021) 3112 2085	Vereda Melo, 56, Monte São José, 72718493 Teixeira / AL	Maldives
eduarda25	carvalhodavi@example.com	1935-01-27	+55 (011) 9638 8002	812 Wesley Run Suite 075, Tylerburgh, AS 82997	Namibia
teixeiradaniel	lavinia62@example.org	1945-04-17	61 6926 7873	916 Amanda Centers Suite 963, Nicholasshire, MP 50077	Taiwan
melinanovaes	ryan40@example.com	1936-01-12	+1-256-498-8077x30889	1382 Jennifer Forest, Meyerport, DC 17447	Morocco
hoffmanrodney	keithortiz@example.net	1987-12-05	(860)289-1338x992	6562 Johnson Pine, Philliphaven, GU 24606	Japan
pmoraes	cauerocha@example.org	1920-07-26	403.336.7474x39522	Trevo Rael Martins, 5, Jatobá, 38272-090 Câmara das Flores / DF	Tajikistan
sousaisaque	zpacheco@example.net	1947-08-29	+55 31 2984 9370	300 Kristen Ridge Apt. 250, Bryceview, MO 11577	Lebanon
caua73	wlopez@example.com	1985-07-10	81 0846-3614	3283 Jose Tunnel, Lauraberg, DE 71666	Morocco
dante31	icardoso@example.com	2013-01-20	+55 51 1683 0779	Residencial de Casa Grande, 78, Vila Coqueiral, 60904-902 Cassiano / MS	Cambodia
da-matakevin	phanson@example.org	1923-08-19	+55 61 4142 0838	PSC 5882, Box 9549, APO AA 79940	Kazakhstan
julia15	sandraparker@example.com	1994-08-17	5354311352	5912 Kelly Estates, Harrisonland, VT 36544	Peru
teixeirapedro	elizabeth33@example.com	1977-09-24	+55 84 4063 2931	USNS Brock, FPO AA 47290	Dominican Republic
nrodrigues	steven65@example.net	2007-03-28	9846888899	Unit 4406 Box 8931, DPO AP 41670	Saudi Arabia
stella33	sousaantony@example.net	1940-04-29	+1-636-792-2158x0574	Viaduto de Correia, 6, Vila Aeroporto, 26247-333 Sousa Verde / AC	Barbados
simsmichael	fitzgeraldmike@example.net	1967-06-16	81 4290-9641	Núcleo Pietro da Mota, 82, Nossa Senhora De Fátima, 73559410 Aragão de da Mota / GO	Costa Rica
emoreira	vanessa07@example.net	1974-05-31	(011) 3178-1109	Sítio de Duarte, 89, São Jorge 2ª Seção, 26966-535 Santos Paulista / PR	Kuwait
molly62	jamesday@example.net	2009-02-14	(051) 4568 8188	803 Franco Port Apt. 086, Port Haileystad, FL 34418	Botswana
tpimenta	michaelperez@example.com	1951-02-22	+55 71 8040-9247	Praia da Rocha, 2, Conjunto Celso Machado, 02892405 Lima / AM	Brunei
jennifer75	camposana-clara@example.com	1996-11-27	+55 (084) 1327-4716	Área Pietra Silveira, 759, Teixeira Dias, 98160686 Vasconcelos / ES	Cape Verde
mendescarlos-eduardo	henry39@example.org	1970-10-22	0300-061-8954	Alameda Breno Gonçalves, 64, Maravilha, 86564917 Borges dos Dourados / AP	Saint Helena, Ascension and Tristan da Cunha
emanuelly34	michael38@example.com	1982-03-17	0300 482 5430	Ladeira Bento Rodrigues, 3, Alto Dos Pinheiros, 04619-697 Azevedo / MA	Denmark
hhoover	arogers@example.com	2010-11-12	+55 21 4065-1887	335 Jennifer Passage, Mcdonaldchester, AS 39558	Morocco
martinsteven	joshua21@example.org	1969-04-02	+55 51 2388 8610	Vereda de Duarte, 57, Barão Homem De Melo 1ª Seção, 97130-935 Aparecida / PA	Turkey
eloahdas-neves	ssexton@example.net	1995-12-12	6935041263	Núcleo Cauê Martins, 6, Vila Havaí, 97892234 Viana / DF	Jamaica
tnunez	xatkins@example.org	1915-12-30	001-401-331-0610x6667	Estrada da Mota, Lagoa, 02387377 Montenegro / RO	Bahrain
taylordanielle	eharris@example.org	1955-10-13	+55 61 3679 6569	017 Patrick Station Suite 773, Hendricksville, LA 86439	Kenya
brandtteresa	isaquesousa@example.com	1944-06-22	0900 317 1478	USCGC Hahn, FPO AP 40162	Liberia
wrightlauren	kathy24@example.com	2003-09-10	001-661-934-5582x9758	Estação da Conceição, 7, Olhos D'água, 06835986 Alves / DF	Niue
scottmay	eandrade@example.org	1960-08-14	731.496.6882	Sítio Olívia Albuquerque, Vila Petropolis, 56674451 das Neves da Prata / MG	Mexico
psales	maria-julia04@example.net	1978-10-20	+55 21 0597 9618	Estrada Silva, 9, Concórdia, 06772-789 Cassiano das Pedras / AM	China
woliveira	kevin09@example.com	1923-04-08	001-602-603-7869	Trecho de Cardoso, 9, Bacurau, 61846611 Porto do Campo / RR	Kiribati
dante71	fdas-neves@example.com	1930-08-02	630.930.4380x55932	787 Sullivan Center, Trevorberg, IA 84092	Puerto Rico
dgomes	hector43@example.com	1978-06-10	81 0005-6569	Viaduto Amanda Fogaça, 57, Ernesto Nascimento, 43879380 Aparecida / TO	Cuba
robert19	melissamarques@example.net	1910-07-02	415.674.8162x30702	9972 Wilson Crossroad, Judithhaven, IA 20483	Uzbekistan
lda-luz	vasconcelosheloisa@example.net	2001-07-18	+55 71 8771 2285	Lago Vieira, 95, Caiçara - Adelaide, 52164291 Moraes Grande / AP	Angola
williamscassie	vitor-hugo39@example.com	1950-05-03	31 9257 3769	25119 Rachael Station Apt. 795, Lake Christy, SD 52652	Albania
alvesluigi	caroline67@example.net	1967-11-30	+55 41 6290-8788	039 Hart Mountain, Burtonbury, NC 22320	Moldova
stacy86	fmay@example.net	1995-03-20	(084) 4328 9055	2130 Robinson Row Suite 597, Smithfort, FM 89118	Tonga
schaeferrobert	ayalacheryl@example.org	1980-01-23	21 1043-0372	Feira de Monteiro, 38, Eymard, 12647981 Lopes de Goiás / TO	Costa Rica
jorgemurphy	mteixeira@example.net	1992-10-04	(955)759-6084	95978 Ashley Meadows, Tylerland, TN 14547	Gambia
hansongeorge	stevenhiggins@example.net	1940-12-27	975-283-9597	14094 Anna Lights, North Tommymouth, VT 52831	Indonesia
cturner	bcirino@example.org	1957-12-28	+55 (071) 0787-8900	Alameda de Casa Grande, 2, Cardoso, 19521325 Vasconcelos de Teixeira / AM	United Arab Emirates
sarahcamara	mendoncamaria-luiza@example.com	1957-04-10	+55 41 1986 7708	Morro Moura, 64, Solimoes, 20064290 Montenegro da Serra / TO	Bahrain
djones	sfarias@example.net	1978-06-29	(432)426-9962	USNS Evans, FPO AP 56191	Moldova
zleao	fariaslarissa@example.net	1956-09-13	824.564.0992x35446	Avenida Sampaio, 470, Eymard, 45729190 Moura de Porto / RR	Samoa
mariah72	ovieira@example.org	1998-06-22	(051) 5102-6075	2294 Nathaniel Radial Apt. 676, North Lisa, MH 96275	United Arab Emirates
thomaspatrick	valves@example.net	1996-10-18	369.364.0615x930	Lagoa Rael Sá, Vila Paquetá, 00895-969 Barros / RR	Thailand
vargasgabriela	karensmith@example.net	1992-05-04	(247)587-2537x225	PSC 6355, Box 1173, APO AA 11198	Nepal
garciaallana	esales@example.org	1969-06-01	001-363-664-1079x85739	4897 Peter Pike, West Ashley, MO 64806	Peru
das-nevesbernardo	amanda93@example.net	1995-02-17	0300-699-6728	Lagoa Rocha, 264, Santana Do Cafezal, 25799-712 Campos do Amparo / AL	Uganda
ana-laurafogaca	uburgess@example.net	2002-11-10	231-774-1169x068	Chácara Yuri Carvalho, 43, Novo São Lucas, 37352-072 Alves da Praia / MG	China
nicholaswilson	luiz-fernando28@example.org	1949-03-09	+55 (021) 3696 6221	Área Vasconcelos, 45, Santo Antônio, 24259048 Novaes / RO	Mongolia
camaraeduardo	viniciuspimenta@example.org	1987-08-21	(071) 7631-4788	9938 Sullivan Park Suite 594, Hollandview, PW 74785	Japan
ramoskevin	julia47@example.net	2007-04-24	908-219-0430	Vila Vitor Hugo Pires, 3, Conjunto Califórnia I, 48643289 Oliveira / RJ	Peru
oliviarios	ana-sophiada-mata@example.net	1925-04-20	+55 (051) 7946-1945	0475 Vanessa Fall, West Julia, FM 18434	Albania
pbarbosa	benjaminbrito@example.com	1988-11-21	41 3251 9015	9094 Lucas Crossing, Jamestown, ID 08777	Nepal
plima	ana-vitoriamoura@example.org	1968-01-23	(041) 4651 1764	Travessa de Nunes, 19, Canaa, 37493-928 Borges de Minas / SE	Saint Helena, Ascension and Tristan da Cunha
samueljohnson	baileypalmer@example.net	1988-07-25	+55 41 5228 3549	Área Raul da Mota, Ouro Minas, 65347-369 Barros da Praia / AP	DR Congo
davi-lucasmarques	vcamargo@example.org	1960-03-15	688-703-2308x95294	460 Joseph Locks Suite 470, Andersonville, AZ 44261	Eritrea
jacobsonbrian	jesusjulia@example.net	1934-05-16	436.437.0387x56059	Chácara de da Rocha, 7, Nazare, 05155142 Freitas do Norte / CE	Brunei
danajones	teixeiraapollo@example.net	2002-09-13	51 9166 3553	88583 Meza Island Apt. 492, Penaview, SD 70906	Morocco
jeffrey33	kristinegibson@example.net	1914-01-19	+1-881-503-5573x871	Rua de Nunes, 62, Vila Engenho Nogueira, 57839472 Sousa / PA	Madagascar
pietro85	silveiranicolas@example.net	1937-04-15	(401)231-8636x9411	5394 Williams Plaza, Donovanborough, NH 99059	Angola
michael36	uda-cruz@example.net	1948-04-27	(084) 3122-0859	Recanto de Pereira, 39, Bernadete, 78853856 Carvalho / BA	Burundi
graynancy	nichole43@example.com	1942-03-04	+55 (071) 6713 0013	Ladeira de Azevedo, 6, Vila Paris, 85127-995 Nogueira de Minas / PI	Djibouti
rrezende	garcialeticia@example.net	1995-11-05	711.392.6586	Viela de Rezende, 51, Mariano De Abreu, 44946-729 Oliveira das Pedras / DF	Honduras
vfreitas	flee@example.net	1989-10-11	+55 (021) 1685-2821	97127 Moore Views, West Margaret, VA 03753	Saudi Arabia
kristen37	whitney24@example.com	1953-02-08	+55 71 1759-5204	889 Scott Fort Apt. 629, Pattersonbury, AL 14918	Suriname
justin23	shepparddavid@example.org	1919-10-20	+1-885-227-5539x747	33235 Carter Vista, Christineberg, AK 76809	Bahamas
carla58	cecilia43@example.net	2005-07-18	0900 041 8140	5936 Elliott Inlet, Smithfurt, UT 06571	Panama
mathias61	smithshane@example.net	1939-01-11	833.643.4349x6676	Avenida de Gomes, 48, Maria Tereza, 71807-587 Cassiano das Pedras / ES	Namibia
rubenstone	milenanovaes@example.org	1941-11-22	247-651-7689x8572	Estação Miguel Pires, 6, Conjunto Capitão Eduardo, 22869-232 Carvalho Grande / SP	Peru
ryanmoreno	itran@example.org	1923-08-31	451-433-4541x3562	Passarela da Costa, Bonsucesso, 33731-834 Vasconcelos do Oeste / AM	Libya
ortizmary	nelsonpatricia@example.net	1911-06-25	608-689-2912x525	0023 Melissa Plains Apt. 160, North Bethanyberg, MH 96354	Kiribati
dwaynebarron	enzosilveira@example.org	1969-07-12	420-324-9502x7625	196 Chad Expressway Suite 745, Josephville, UT 42161	Poland
joseph17	anthony88@example.net	1927-06-04	+1-563-898-3782	Chácara Mirella Silva, 616, Colégio Batista, 02672068 da Rosa Paulista / RN	Botswana
susanchan	tpowers@example.com	1999-01-27	+55 (041) 0022-9530	Vila de Barros, Jardim Leblon, 94900-025 Farias de Goiás / ES	Sudan
jessicabradford	gabrielwilson@example.net	1972-03-03	(645)457-8833x289	117 Hall Plain, Kevinburgh, IN 48212	Western Sahara
xsimpson	melodycruz@example.net	1931-11-08	7427164406	0908 Richard Shoals, East Benjaminberg, UT 45976	Comoros
jakewilliams	rhondapadilla@example.com	1925-08-18	(594)594-3470x0204	758 Ramirez Walk Apt. 909, South Ryan, OH 48831	Malaysia
montescharles	xwells@example.org	1984-02-18	(624)795-4127x84967	Residencial José Pedro Castro, 90, Vitoria Da Conquista, 69412-918 Mendes / PI	Mauritius
moraestheo	davenportwendy@example.com	1978-07-25	0300 403 2415	Núcleo Davi Miguel Campos, 89, Vila Barragem Santa Lúcia, 50033460 Oliveira / GO	Iran
melissa43	mariah74@example.net	1987-04-05	+55 (051) 8417 4667	59052 Manuel Green Suite 247, Williamshaven, RI 55303	Bosnia and Herzegovina
lisa06	cavalcantebruna@example.com	1948-09-05	+55 61 1442-9673	Ladeira Henry Melo, Lajedo, 56229696 Cavalcante Paulista / AP	Canada
vromero	esiqueira@example.net	1945-04-27	(041) 7027 6490	8976 Seth Islands, South Richardville, CO 98818	Afghanistan
christy33	grahambryan@example.net	1999-05-18	001-518-884-7523x667	Recanto de Peixoto, 9, Conjunto Jardim Filadélfia, 46570829 Azevedo Alegre / ES	United Arab Emirates
nelsonsteven	thales87@example.net	1922-03-25	84 5531-8794	Distrito Alves, Vila Rica, 29115339 Martins de Pacheco / RN	Kenya
kwilliams	wujeffrey@example.net	1943-10-18	41 9941-7848	Aeroporto Rodrigues, 745, Madre Gertrudes, 11801-018 Gomes do Amparo / ES	Japan
jrios	stephenromero@example.net	1927-01-29	(855)634-5719x4817	346 Michelle Extension, East Markbury, MO 24941	Bosnia and Herzegovina
camargoyuri	kanemargaret@example.org	1994-11-14	+1-765-931-7314x931	7054 Dixon Freeway Suite 358, Matthewmouth, WI 73569	China
wesleygonzalez	janetcarr@example.net	1929-04-21	001-271-491-0162x2472	Quadra Rocha, 1, Araguaia, 03154-847 Silveira da Serra / AC	Puerto Rico
krodrigues	mateus59@example.org	1966-04-01	(051) 3263 6550	Rodovia Benicio Gomes, 692, Vista Alegre, 17792-247 Nunes / RR	Central African Republic
gomesleo	phammond@example.com	1947-11-07	(021) 2970 1519	9174 Paul Mission, Michaelmouth, GA 86211	Afghanistan
tking	sara28@example.net	1988-08-11	+55 (071) 8423-4589	24111 Woods Meadows Apt. 292, Tapiaburgh, AZ 85512	Saudi Arabia
petersonelizabeth	paul16@example.net	1987-09-17	+55 (011) 0314-2190	7827 Harrell Mission, South Sheilastad, OK 07377	Eswatini
jamesbryan	dominguezjerry@example.com	1999-08-31	001-674-625-5249x100	90706 Beth Greens, East Stacie, MN 51816	Chile
lindsey61	pamela24@example.com	1961-08-15	(235)663-0098x06120	5499 Tina Prairie, North Joseph, FM 82936	North Macedonia
victorialee	deanna90@example.org	1970-08-28	6366855928	Ladeira de Gonçalves, 35, Vila Madre Gertrudes 2ª Seção, 40500435 Campos / SC	Somalia
kimberly58	zpastor@example.org	1912-01-20	0500-106-4901	8646 Martin Centers Suite 898, Carrilloview, KS 67793	Guinea
andre64	ribeirovitor@example.org	1920-02-28	595-790-8485x14474	587 Melissa Rapids, Lake Scott, TN 54127	Comoros
correiamatteo	esousa@example.net	1970-04-25	+55 11 9021 7754	PSC 6346, Box 4043, APO AA 48869	Taiwan
heather13	raymarie@example.org	2007-10-11	+55 21 3230-7803	Feira Barros, 23, Jardim América, 24926591 Pires / TO	Brazil
asantos	vkelly@example.net	1964-07-06	(287)625-1914x6659	81406 Bryan Shore Suite 768, Stevenchester, AR 20436	Iceland
fritzkevin	marksimpson@example.com	1970-05-06	001-500-436-0017x64086	Unit 0435 Box 9033, DPO AE 68583	Saint Helena, Ascension and Tristan da Cunha
robert07	popemarcus@example.net	1925-11-12	+55 11 8877-3420	Praia Vitor Hugo Melo, 763, Jardim São José, 15802-734 Martins / AC	Ghana
amber81	allana39@example.org	1949-02-28	545.716.8394x647	8125 Jacob Ways, South Scottfurt, SC 36474	Uganda
james61	darrell67@example.net	2013-06-13	(797)858-3241x4508	19094 Smith Walks, Lauraborough, NE 34559	Ivory Coast
sophie80	maria-laura60@example.com	1991-01-23	+55 81 6363 5851	03851 Gutierrez Well, North Daisyton, IN 96004	Guatemala
craiglopez	jgardner@example.com	1951-02-04	+55 (031) 0727 6845	1846 Andrews Drive, North Victoria, KY 12872	Bulgaria
stephensanna	leebecky@example.com	1944-02-28	+1-604-379-3412x9489	22798 Jennifer Stream Apt. 600, Shawnbury, MA 24153	Georgia
rodneycohen	alejandracasey@example.com	1918-11-29	(061) 3948 2006	Trecho da Luz, Conjunto São Francisco De Assis, 55618483 Fonseca / BA	Mauritius
dcavalcante	rachel95@example.com	1945-03-20	84 1077 3735	Pátio de Farias, 31, Vila Suzana Segunda Seção, 92945-325 Abreu / MA	Gibraltar
jerrychapman	stephanie06@example.net	1945-11-01	+55 (011) 5419 6657	5853 Jones Bypass, New Adam, NE 67414	Saudi Arabia
mathiasaparecida	darius31@example.org	2005-04-05	001-246-500-9183	890 Eaton Brook Suite 964, South Grantmouth, ND 16538	Macau
aragaobenjamim	hsolomon@example.com	1910-03-19	001-811-585-1982x8091	21390 Kurt Alley, Seanville, RI 24007	Mexico
loliveira	jonessabrina@example.net	1945-04-17	(887)892-4427x8110	Favela de Costela, 52, Vila Bandeirantes, 08459-018 Campos / PR	Mozambique
leandro19	caitlin98@example.net	1944-02-26	+55 (084) 2211 7588	54856 Robert Hollow Apt. 072, Joseshire, LA 21742	Madagascar
zda-luz	kylehansen@example.org	2009-08-11	4074500340	Alameda Pacheco, 82, Conjunto São Francisco De Assis, 84508-611 Siqueira das Pedras / AL	North Macedonia
ferreiragabriel	jameswarner@example.com	1962-08-04	799.894.3559	708 Davis Wall Suite 571, Marymouth, OR 57414	Gibraltar
inovais	ccaldeira@example.net	2003-03-18	+1-398-721-2659x75532	Estrada Borges, 16, Campo Alegre, 01352128 Brito Verde / ES	Malawi
katrinalopez	theodorolima@example.com	1972-04-12	9482833411	Distrito Eloá Pinto, 13, Santa Inês, 07311298 Macedo / PR	Cuba
rjennings	novaiserick@example.com	1966-02-28	419.864.1208	Praça Moreira, 45, Delta, 38845131 Viana do Sul / AC	Argentina
anthony91	ravi-lucca81@example.org	1931-09-01	+1-658-886-2522x1468	222 May Haven, Port Randy, MI 79294	Taiwan
carolmcclure	laviniabrito@example.org	1991-02-28	676.209.6418x261	7909 Henderson Plaza Apt. 104, Mendezberg, DE 83359	Burundi
timothyschmidt	barbosamaria-vitoria@example.com	1921-07-31	941-952-1475x6668	Fazenda Rodrigo Camargo, 27, Bairro Das Indústrias Ii, 56376032 Fernandes de Goiás / PE	Argentina
isabela50	gpinto@example.com	1985-08-20	(071) 3369-7178	130 Anthony Terrace, Johnsonview, NJ 33075	Uganda
markcortez	hellena75@example.com	1968-08-09	+1-519-689-2309x2620	Estrada Dias, 752, Cruzeiro, 84531-731 Leão de Goiás / MA	Guatemala
ochoamichael	ryancarter@example.net	2013-05-15	51 1421 6090	051 Keith Stream Suite 355, East Anthonyburgh, MH 42281	Malawi
kristenmartin	lorenzo70@example.net	2011-02-02	+55 31 5453-9874	PSC 1004, Box 5536, APO AP 73744	Bosnia and Herzegovina
ingramjill	ebrown@example.org	1923-12-24	+1-356-851-0825x984	55742 David Mission, Travisview, NH 64501	Saudi Arabia
justin45	ocunha@example.com	1988-06-12	0300-914-7389	9959 Benjamin Road, Port Jimville, MD 07606	Turkey
pmartin	nealcody@example.net	1919-11-02	(569)704-6695x07273	Distrito Ana Julia Monteiro, Conjunto Taquaril, 81547-478 Nunes / PB	Bahrain
mathias31	jacksonapril@example.org	1965-08-16	883.399.1450x22936	4695 Hunter Rue, Port Erin, RI 27231	Bulgaria
cunharebeca	ribeirokamilly@example.org	1937-01-13	84 1164-6868	Praça Caio Azevedo, 53, Novo Das Industrias, 27569334 Albuquerque / PA	Central African Republic
alexia20	wramos@example.org	1981-07-04	+55 (081) 5728 5857	Conjunto de Camargo, 2, Vila Paraíso, 79757172 Fernandes da Praia / PR	Solomon Islands
sara42	maria90@example.net	1913-04-21	(031) 9396 5268	Conjunto da Rosa, Bom Jesus, 36699948 Castro Verde / RN	Serbia
aliciapimenta	qperez@example.net	1933-04-06	0800 233 0034	2063 Bray Walk Suite 866, Bradleyborough, CA 52195	Singapore
lcoffey	brendamoreira@example.net	1925-09-27	(316)971-0895	768 Jackson Bypass Suite 179, Trujillostad, CO 93441	Guyana
tbrown	lara95@example.org	1991-09-11	61 8329-1991	8696 Keith Stream Suite 743, Tiffanychester, NE 01662	Kenya
terribond	carldavis@example.net	2001-05-28	001-484-766-1956	81898 Mullen Common Apt. 146, New Ronaldberg, MI 84151	Serbia
edward15	epatterson@example.org	1927-08-21	+55 51 3018 8213	01049 Moran Bypass, Morenoborough, IN 89532	Solomon Islands
joao-gabriel79	luigi77@example.org	1986-04-21	+1-737-369-6824x5855	89392 Richmond Mountains, East Hannah, GA 61132	Nepal
zimmermanstephanie	silveirayuri@example.org	1911-11-17	(061) 5852-6286	Quadra de Siqueira, 4, Santa Cruz, 61715297 Viana / AM	Qatar
henriquebrito	johnbrown@example.com	1976-03-28	(952)907-3773x293	Colônia Marques, 79, Novo São Lucas, 82328788 Rezende / PE	Guinea
fteixeira	ukelley@example.com	1959-08-19	001-589-468-9824x333	1030 Brandon Locks Apt. 508, Port Glenn, VA 38568	Morocco
ysousa	pmoreno@example.net	1963-08-12	816-690-2367	Área de Ramos, Santa Sofia, 26769308 da Cruz / BA	Bahamas
lisamorrow	srobinson@example.com	1978-05-17	423-751-4697x592	63653 Bobby Plaza Apt. 919, Karenshire, MA 58225	Cayman Islands
rebeccaward	travis00@example.com	1998-12-17	71 0185-6083	46604 Renee Burgs, South Nicholas, VA 55096	Lesotho
peixotovitor-gabriel	kevin21@example.com	1917-08-28	332.475.7519	Viaduto Cirino, 1, Casa Branca, 05948608 Vasconcelos / PI	Canada
da-motalivia	crystal88@example.com	1946-07-20	221-918-0493	Vale Farias, 933, Vila Nova Cachoeirinha 2ª Seção, 25771-203 Albuquerque / TO	Mauritius
mendesian	luiz-henrique61@example.org	1968-03-08	2972820969	Largo Oliveira, 3, Vila Nova Paraíso, 10451439 Almeida / BA	Tonga
uviana	pgray@example.com	1910-07-25	(021) 3843 8954	Rua Dom Câmara, Vila Trinta E Um De Março, 37164449 Guerra do Galho / TO	Aruba
ocopeland	diogo74@example.com	2013-04-03	(071) 0321-0926	Estrada da Conceição, Eymard, 04542-232 Moreira do Oeste / PI	Comoros
ucarter	anthony-gabriel97@example.com	1953-08-13	8282078027	Estrada da Rocha, 92, Vila Minaslandia, 24194170 Lima / DF	Malawi
maria-laura43	marinasousa@example.org	1966-11-11	41 4247-8016	Unit 2590 Box 9512, DPO AE 28082	Saudi Arabia
bennettlisa	boltonstephanie@example.org	1940-04-22	11 9067 0240	041 Hernandez Isle Suite 665, New Gina, ME 75638	Tajikistan
davi-luccamacedo	msilva@example.com	2005-07-30	+55 (084) 7419-1248	Campo Pacheco, Grota, 16499-851 Brito da Mata / GO	Lebanon
nicole63	rcavalcanti@example.net	2006-07-31	425-837-4942x098	26797 Karen Summit, Tatebury, NV 43776	Saint Helena, Ascension and Tristan da Cunha
rebeca47	luiz-miguel20@example.net	1911-08-21	+55 51 7406 7254	Unit 8714 Box 2588, DPO AE 91784	Uzbekistan
mchambers	hodgeseric@example.com	1916-02-02	+55 (084) 1852-3659	6234 John Hill Suite 362, West Emilyburgh, ID 08917	Saudi Arabia
brandi03	maria87@example.org	1974-04-25	84 2595 9412	56943 Aaron Way, Julieton, OK 26428	Mongolia
nathannascimento	qcavalcante@example.com	1992-09-13	11 4449-5321	Estação de Viana, 15, Marajó, 52373954 Santos / RN	Zambia
costelavalentina	justinturner@example.org	1977-02-06	(255)791-1365x03491	Sítio de Martins, 148, Novo Ouro Preto, 94707-188 Cirino Grande / PA	Sweden
ccamargo	isabelamoreira@example.com	1920-07-06	4312509262	2700 Hill Fork, Ricemouth, WA 46150	Zambia
jasonware	michelle55@example.net	1997-05-08	+55 71 1367 7937	Largo Théo Teixeira, 95, Vila De Sá, 93109554 Moreira de Minas / DF	Colombia
eduardoalves	azevedoaugusto@example.org	1910-10-12	(806)211-6181	76504 Williamson Forge, Port Steven, MO 23032	Kazakhstan
perezdouglas	ethanrhodes@example.net	1930-05-17	0500 084 7533	Estrada Eduardo Moura, 2, Vila Nova Paraíso, 86659-590 Jesus / RJ	Denmark
da-cruzana-julia	robin84@example.net	1981-05-18	71 1128 9375	41777 William Lodge, South Tracyview, MI 25494	North Korea
dana49	joseph34@example.com	1963-10-31	(084) 6514 9100	PSC 3432, Box 3872, APO AA 22003	DR Congo
cavalcantegabriela	cirinorafaela@example.net	1933-01-14	001-303-357-6454x52089	1258 Jeremy Junctions Suite 162, New Meganfort, VA 76490	Comoros
limasarah	bryantallison@example.com	1944-12-02	71 8970 6555	Residencial Théo Pinto, 30, Santa Monica, 30910-241 Andrade de Andrade / SP	India
johnsonrichard	jessica58@example.net	1964-05-08	(231)899-4404	Favela Erick Fonseca, Savassi, 72747-595 Macedo / DF	Malawi
alexia72	davidtravis@example.net	2008-11-04	+55 41 1017 8302	50958 Carmen Pass Apt. 310, Michellechester, SC 60391	Fiji
larsonanthony	claranunes@example.com	1978-11-04	+55 51 7695 6291	9912 Phillips Port Apt. 679, Angelicaview, PW 98439	Seychelles
shawn03	kylie89@example.net	2003-09-01	+55 (081) 1211 4957	Aeroporto Novais, 30, Conjunto Minas Caixa, 24051-745 Nogueira das Flores / GO	Western Sahara
hartmanemily	dmarshall@example.org	1979-03-14	0900 014 9581	8489 Traci Route, Normanberg, MO 92177	Turkey
dmartinez	gabriel62@example.org	1955-05-12	001-361-767-7989x1551	02390 Wright Haven Apt. 016, East Kelly, DE 05530	Trinidad and Tobago
mariananogueira	dhernandez@example.com	1988-03-14	(623)431-3521	Passarela de das Neves, Bernadete, 41822-113 Ribeiro / TO	Sudan
william12	aragaomanuella@example.com	1974-11-30	9436452957	Conjunto Henrique Castro, 5, Vila São Geraldo, 09402-821 Ribeiro / MA	Ghana
hvasconcelos	mariane74@example.com	1972-12-02	(858)419-9452x57892	Lago Garcia, 29, Santa Branca, 92039-536 Gomes / SE	Namibia
piresluiz-henrique	luanpinto@example.net	1910-02-19	920.574.2101x044	Esplanada Rebeca Brito, 98, Concórdia, 80198-641 Aragão da Serra / AL	Saudi Arabia
ana38	wfogaca@example.com	1956-09-12	236.249.3790	6889 Ashley Garden Apt. 413, Feliciamouth, MO 30495	Maldives
rrios	lunacardoso@example.net	1984-12-24	(031) 9226 7115	Viaduto Lima, Grota, 94115-639 Porto Grande / PE	Guatemala
jonathanbradley	christopher01@example.net	1998-07-25	253.634.1860x098	Quadra Amanda Lopes, 25, Vila Nova Paraíso, 58799-610 Sá / RS	Ghana
maria-sophiacastro	vteixeira@example.net	1956-03-09	(666)399-9468x6682	Unit 0667 Box 5430, DPO AP 79317	Yemen
zcorreia	balbuquerque@example.org	1970-01-30	(011) 4380-0730	Trevo de Novais, Nossa Senhora De Fátima, 56215860 da Cruz / BA	Honduras
halljessica	johnvaughan@example.com	1998-04-07	(021) 7935-6949	Praça de Rezende, 87, Vila Paraíso, 55601-356 Sales do Sul / ES	Hong Kong
qfreitas	jessemccall@example.net	1917-05-13	+55 31 9141 2993	47851 Stephen Village, Kevinland, NE 30783	Canada
hardincharlene	wfreitas@example.com	1968-01-01	(661)623-4469	Loteamento Campos, 12, Serrano, 61239014 Moura / RJ	Argentina
millerbrandon	ana-claraferreira@example.com	1915-07-11	001-238-848-3572x951	977 Downs River Suite 186, Jerryton, GA 16905	Israel
clarkbobby	tferreira@example.com	1922-04-03	(011) 7763-1526	Via Lopes, 12, Lagoinha, 64467-372 Câmara do Oeste / AL	Haiti
caitlincollins	camargoleonardo@example.org	1998-05-01	(011) 3617 9585	Campo de Andrade, 291, Jaraguá, 78800001 Ramos / SP	United Arab Emirates
cassianojoao-gabriel	ianbarbosa@example.org	1925-03-03	(061) 0034-5208	69311 Lee Rest, Stonestad, PR 82043	Brazil
aragaothomas	waragao@example.org	1933-11-09	348.297.8218	Largo de da Cunha, 54, Taquaril, 02629638 Albuquerque do Galho / PB	Israel
da-cruzenrico	arthur-gabrielribeiro@example.net	1986-03-29	+55 81 3880-8249	0849 Hughes Cliff, East Pamelamouth, CO 69171	Costa Rica
araujomirella	stephany76@example.com	1953-06-21	+55 (061) 4307-9146	Lago Henry Gabriel Nogueira, 47, Vila Novo São Lucas, 31237-885 Nogueira / MS	Saudi Arabia
aaron52	vincentdenise@example.org	1957-09-23	635-638-3174x617	Unit 2486 Box 5537, DPO AP 39048	Chile
thiago77	dean00@example.com	1980-02-27	+55 (051) 9664-6742	4787 Chambers Fort, Port Nicholashaven, MH 10258	Eswatini
rmachado	gburke@example.com	1948-03-17	649-505-0010	9168 Lori Canyon Apt. 451, New Garyside, AK 80546	Philippines
joaquimcorreia	egarcia@example.com	1915-06-24	+55 (021) 3468-6203	Viela Gonçalves, 1, Cinquentenário, 49839-322 Pereira de Vargas / MT	Ghana
jorgekennedy	robin43@example.org	1995-05-29	+55 (011) 2738-3592	941 Lynn Stream, Fernandezburgh, AZ 06838	Vietnam
eloarodrigues	ehines@example.net	1931-10-27	271.277.2613x330	04860 Morales Parkway Apt. 409, Rachelstad, GA 66814	Kuwait
leslie68	juliana81@example.com	1952-04-17	649.205.8577	Rodovia Bento Ramos, 25, Conjunto Paulo Vi, 79945976 Guerra / RN	Mozambique
loweshawn	douglasfisher@example.com	1909-11-07	51 4712 8377	Vila Gael Henrique Rios, 44, Ápia, 12448550 Câmara / MG	Paraguay
bruna84	kribeiro@example.net	1973-06-30	+1-854-836-0539x848	563 Shawn Bridge, Katherineborough, SC 64911	Brazil
levinascimento	garciamaria-fernanda@example.org	1930-03-30	0900 772 0133	Conjunto Melissa Moraes, 25, São Lucas, 43162979 Dias de Sales / GO	Ivory Coast
pintorael	burnettpamela@example.org	1931-02-19	001-627-903-1973x175	39615 Martha Extensions Suite 397, Fullerview, OH 64983	Armenia
davi-lucaslopes	dneal@example.net	1939-01-07	001-476-601-1453x5891	PSC 4813, Box 1615, APO AP 47945	Indonesia
kevinthomas	whitney43@example.net	1964-02-27	+1-330-621-4308	Núcleo Erick Gonçalves, 65, Xodo-Marize, 53977952 Castro do Oeste / DF	Honduras
richardreyes	fernandescaua@example.com	1921-09-23	81 7685-2520	0763 Tammy Heights, Watsontown, FL 09789	Azerbaijan
davidparsons	nsilva@example.org	1920-10-11	(084) 7315-8602	PSC 2494, Box 6173, APO AP 05784	Cambodia
maya48	umendes@example.com	1925-01-26	+55 (051) 1057-4876	03739 Tammy Isle, Port Michael, LA 59611	Vietnam
vitoriaaragao	lopestheo@example.org	1967-06-04	+1-833-559-8036x90690	0889 Michael Run Apt. 793, Lake Kevin, NE 13132	Cuba
da-pazmaria-helena	gmacedo@example.net	2005-02-07	7745679577	Lagoa de Costela, 942, Nova Gameleira, 28666024 Cunha / PE	Angola
hallsean	catherinelewis@example.org	1993-08-26	41 2905-9856	Lagoa Thomas Melo, 6, Barroca, 31043-460 Macedo / PI	Samoa
robert13	kinglauren@example.org	1927-05-12	(071) 5198-5329	Praia Brito, 62, Vila Vista Alegre, 03391057 Dias de Aragão / SP	Jordan
johnsonkathleen	dnovak@example.com	1918-07-25	001-403-901-3660x139	15564 Thomas Walk Apt. 535, Robertside, LA 56273	Armenia
jacquelinegates	stephanie56@example.net	1940-02-05	(690)645-7858	308 Gordon Parks, North Kelseyburgh, ND 54407	Solomon Islands
zjackson	caldeiramaria-eduarda@example.com	1999-10-30	8844768534	Conjunto de Ramos, 816, Novo Aarão Reis, 48410-812 Porto de Sousa / SP	Kiribati
das-nevesravy	cruzvanessa@example.net	1911-05-12	609.828.8262x941	233 Vance Forest, Danielhaven, NE 86364	Tunisia
pimentamathias	xaraujo@example.com	1979-09-24	001-641-879-9099	Jardim Garcia, 1, Aarão Reis, 91622-339 da Rosa do Sul / PA	Saudi Arabia
daniel98	thomascamargo@example.net	1919-11-19	001-905-929-5972	832 Gary Inlet, West Shelleybury, AL 30624	Thailand
joegarcia	sabrinacavalcante@example.org	1916-06-05	385-245-1850x5650	Esplanada de Ramos, 66, Vila Suzana Primeira Seção, 50232-973 Vargas / GO	Sweden
benjamin59	icirino@example.com	1916-12-18	71 9194 1379	0891 Cody Crossroad Apt. 161, Theodorehaven, PA 11356	Barbados
dallen	gomesbenjamin@example.net	1970-03-31	(051) 2381 7161	4015 Trujillo Corner Suite 009, East Laurashire, ID 62813	Puerto Rico
cardosomariane	ana-sophiacosta@example.com	1915-02-01	317-850-8607x816	Praça de Teixeira, 79, João Paulo Ii, 86335150 da Rosa de Silveira / BA	Barbados
da-conceicaosarah	gmoore@example.com	1988-10-14	465-494-7303x9288	28787 Dillon Turnpike, Washingtonburgh, OK 84991	Poland
raquel39	dmoore@example.com	1989-06-21	+1-731-220-8683	133 Mosley Extensions Suite 698, East Bradley, ND 85981	Rwanda
tamarasummers	oliviamelo@example.com	2006-02-14	001-432-761-6660	0924 Miles Avenue, Cameronborough, CT 74331	Saudi Arabia
eferreira	zcunha@example.com	1920-11-14	2593028940	Sítio Kevin da Mata, 27, Betânia, 40192803 Novaes das Flores / AM	Tajikistan
alicrystal	kristinagentry@example.net	1913-08-01	(927)971-9223x58358	889 Brett Points, Leahmouth, VT 23493	DR Congo
srios	richardsonadam@example.net	1928-12-09	+55 21 4655-3903	Estrada Fernandes, 7, Vitoria, 93716-987 Ribeiro / PB	Trinidad and Tobago
moraeshelena	maite57@example.net	1944-01-01	+1-748-367-9814	Vila Nascimento, 443, Castelo, 09900074 Cirino Verde / RS	Western Sahara
luiz-miguel60	pedronogueira@example.net	1971-03-01	5252162007	Campo Freitas, 269, Paraíso, 33465436 Câmara Verde / AL	Afghanistan
mnogueira	jburton@example.net	1927-04-18	81 8316 3680	Lagoa Gustavo da Cunha, 86, Conjunto Bonsucesso, 28900887 Dias de Martins / BA	Botswana
aurora91	cirinojuliana@example.com	2002-12-03	(031) 1393-1734	86109 Colon Rue Suite 052, Port Joeltown, PA 35886	Somalia
youngmary	marisawest@example.org	1937-06-16	+1-809-479-8279x98312	8431 Howard Lodge, Lake Elizabeth, SD 14961	Zambia
erica98	lopeslivia@example.org	1983-05-12	(061) 7263 5327	972 Montgomery Inlet, New Melissa, SD 41823	Samoa
catarina61	smcdaniel@example.org	1978-03-09	(689)731-9980x47727	645 Johnson Views, North Teresa, ND 78043	Angola
snyderallison	stephanieoconnor@example.net	1920-08-09	869-522-0975x197	Ladeira de Rodrigues, 5, Grajaú, 04739727 Nascimento de Guerra / ES	Liechtenstein
freitaslevi	karenlopez@example.net	1949-02-26	(021) 7252-4923	Estrada de Camargo, 72, Ápia, 36733-677 Barros / SC	Israel
hughesamy	stephanylima@example.net	1946-01-17	356-975-8150x462	Núcleo de Costa, 1, Bacurau, 69169-592 Brito do Campo / PA	Myanmar
droberts	maria-fernandapires@example.org	1923-10-15	+55 61 2459 7662	888 Heather Crest Apt. 464, South Anthonyfort, MA 50769	Uzbekistan
rollinsjohn	vasquezkristy@example.com	1975-11-09	+1-619-554-1792x0874	Praça Azevedo, 451, Marçola, 44581-988 Duarte / RJ	Qatar
isabella55	fcostela@example.org	2006-10-21	001-710-496-7035x907	80908 Olson Court, Lake Davidville, OR 36630	Bangladesh
almeidagustavo	saragao@example.org	1936-03-11	001-938-873-3564	PSC 1101, Box 0293, APO AE 75292	Bahrain
john08	lauren26@example.org	1935-10-31	001-531-901-9176x91934	Lago Isaque Mendonça, 718, Alto Das Antenas, 78732-249 Abreu de Nascimento / PA	Iceland
samuel44	steven12@example.org	1968-10-19	0300 153 0150	62524 Michael Street, Millerborough, MD 17228	Costa Rica
ytran	smithkatherine@example.net	2013-01-12	+55 (051) 6263-8736	3455 Timothy Lake Apt. 875, Montgomerytown, AL 83626	Samoa
ribeironoah	jose-miguelazevedo@example.org	1930-01-27	452-449-0836x7643	26435 James Field, Port Judyborough, OH 91882	Chile
vicente66	oborges@example.com	1912-06-27	(761)450-3137	0797 Sims Lodge Apt. 903, Danielland, NV 03349	Macau
qmoore	lopesmaria-julia@example.com	1992-01-17	267-339-0058x26613	Avenida de Montenegro, 181, Europa, 08719525 Nunes / RN	Somalia
monteirosara	steven31@example.org	1962-11-25	+55 (021) 9640-8664	Largo de Costela, 39, Lorena, 91491010 Ferreira de Minas / TO	Somalia
ana-sophia81	isabelavieira@example.net	1966-03-28	396-344-8224x3446	06035 Kramer Glens Suite 690, Silvachester, NH 94831	Guyana
florestimothy	riosgael-henrique@example.org	1927-11-04	(051) 0466 9891	Travessa Cavalcanti, 323, Nossa Senhora Do Rosário, 76086-979 da Costa / SE	Chile
aylacirino	rdas-neves@example.com	1981-07-08	739.688.7022x67314	8547 Wood Ville, Andreafort, MA 17777	Ghana
jimmycain	hnovaes@example.org	1988-02-04	(061) 5339-5577	4560 Ruiz Coves, Wilsonstad, NC 03084	North Macedonia
albert39	brittneylong@example.net	1921-09-02	+55 21 1979-1936	731 Jennifer Lake, South Andrewchester, SD 80500	Kyrgyzstan
tda-mota	claytonkevin@example.com	1926-03-15	41 7161-2960	Unit 6027 Box 4988, DPO AA 24253	Nepal
elizabeth12	plopes@example.com	1934-12-01	462-955-7450x01550	USNV Boyd, FPO AP 73015	Gambia
danielle51	andrew30@example.org	1951-05-29	+55 (084) 7381 5405	182 Cooper Avenue, Olsonberg, IL 41425	Lebanon
huffdestiny	britoluiz-miguel@example.com	2011-09-15	2166616365	Feira de Freitas, 55, Candelaria, 86681-820 Albuquerque / AP	Lebanon
larissa36	april26@example.org	1936-07-09	+1-618-706-9626x4229	1764 Stacy Squares Suite 810, West Alexandra, MS 57014	China
emma51	bguerra@example.net	1914-03-14	+55 71 7338-5025	6397 Sanchez Island Suite 355, Jasonland, NY 30933	Russia
carriebolton	nicole41@example.org	1996-08-30	001-644-671-1980x81149	PSC 0580, Box 2487, APO AP 68410	Laos
ana-sophianovaes	pamela73@example.com	1982-03-23	3527938059	43381 Ruth Lake Suite 288, Rosschester, OH 38858	Turkey
manuelanunes	carvalhojoao-guilherme@example.com	1949-08-29	001-410-480-4176x051	Lagoa Anthony Pereira, 203, Jardim Guanabara, 73145246 Cassiano / AL	Tunisia
fitzgeraldandrew	da-pazlais@example.com	1989-04-12	001-784-324-5630x337	53398 Santos Station, Petersonmouth, CO 29922	Zambia
marianasousa	robinsonteresa@example.net	1997-03-25	676.209.1557x700	Morro de Rios, 7, Biquinhas, 97231-512 Melo / CE	Denmark
da-motaisabela	jessicakramer@example.org	1924-02-11	81 3329 7942	Vila Arthur Carvalho, 1, Nova Cintra, 59354588 Ramos Grande / PI	Niue
norriseric	jonespatrick@example.net	1914-06-30	001-279-277-8533x27883	62141 Peters Track, Karenton, LA 12721	Trinidad and Tobago
mendesjulia	pedro17@example.net	1922-01-11	84 3110-5634	Estrada Pimenta, 40, Vila De Sá, 60269564 Cunha da Prata / AP	Macau
laispereira	allenjulie@example.net	1948-10-21	422.280.8242x61942	Avenida Ferreira, 328, Solimoes, 86080566 Siqueira da Praia / RJ	Taiwan
phillipcortez	luisafernandes@example.net	1973-03-16	881-269-0709x18483	848 Michael Mission, West Tina, WA 06047	Denmark
kathrynmiller	kingcolton@example.net	1987-02-24	+55 41 4947 0021	9211 Boyer Lakes Suite 588, North Martin, AR 71932	Costa Rica
osampaio	mcastro@example.net	1969-11-03	370-350-3502	04017 Thompson Streets Suite 975, Cameronfurt, ME 78480	Panama
pachecomanuella	valentinapeixoto@example.org	1994-09-13	(820)471-1089x40518	36486 Alvarez Pines, Kentmouth, CA 66189	Cambodia
wcampbell	maria-liz01@example.net	1930-08-29	+1-339-421-3921x55373	3218 Moreno Point, North Jillberg, IL 80006	Maldives
ryan60	martinlorraine@example.org	1965-01-29	794.254.5536x42095	85207 Andrew Harbors Apt. 771, Harriston, MN 83041	Albania
pmoura	isuarez@example.net	1944-01-22	+1-581-751-8033x1122	Pátio Ana Clara da Rosa, 79, Santa Branca, 65795878 Freitas / PI	DR Congo
hsmith	edwardlewis@example.net	1912-06-29	8724703983	Passarela de da Rocha, 5, Barão Homem De Melo 1ª Seção, 88037-926 Nunes / RR	Armenia
michael07	cody77@example.com	1915-04-13	+55 (061) 0842-6740	Conjunto Samuel da Luz, 70, Salgado Filho, 82532-797 das Neves de Gomes / AM	Brunei
eduardapimenta	bteixeira@example.org	2002-05-04	001-399-490-8807x29501	Feira de Rocha, 2, Jardim São José, 25305-832 Moura / SE	Canada
karen03	james15@example.org	1912-08-28	+1-729-372-3529x6864	3475 Katherine Park, West Oscar, NH 27609	North Korea
montgomerygina	portopaulo@example.org	2004-11-11	880-615-2511x344	560 Martha View, Georgeville, NM 86685	Chile
paulo40	dana32@example.com	1948-10-13	+55 (071) 5070-0249	Travessa Pacheco, 87, Vila Das Oliveiras, 05295-161 Abreu do Norte / RR	Mozambique
camargomaria-luisa	kristin14@example.com	2002-10-04	(290)886-2967	Condomínio Vargas, 71, Vila Fumec, 71474283 Silva do Campo / SC	Thailand
peixotohenry-gabriel	ana-beatriz03@example.com	2008-10-15	9019857233	994 Bond Burg Apt. 945, Hoffmanburgh, OH 86783	Maldives
heloisa33	melissasanders@example.com	1919-11-21	001-399-331-5546x5025	1362 Watson Ferry Apt. 911, Moyerville, TX 16857	Bahamas
vargasisaac	casa-grandevitoria@example.com	1914-03-18	877.778.8118	81601 Cox Court Apt. 329, Sanchezberg, MN 95692	Morocco
bhill	garciarafaela@example.org	1922-05-28	(954)820-7013	Alameda Marques, 44, São Bento, 82205414 da Rocha / RR	Sudan
sandra64	augustosales@example.org	1941-03-27	739.275.2501x198	080 Bailey Alley, Gibsonmouth, GU 97156	Morocco
ana-carolinanunes	stonekathleen@example.net	2003-04-23	735-639-7641	Travessa Vicente Moreira, 87, Silveira, 57457-926 Peixoto do Sul / PE	Bosnia and Herzegovina
zcox	gcummings@example.net	1993-10-02	(380)424-8264x0850	153 Richard Place, South Catherine, TN 34399	Eritrea
brookecruz	timothyshaw@example.com	1997-11-19	+55 (041) 5018 7851	PSC 2772, Box 2988, APO AE 46642	Tonga
williamdixon	rachelavila@example.org	1947-01-24	+55 (071) 5216 8323	64603 Brianna Loaf, West Anita, MS 42483	China
jameshayes	malonetammy@example.net	1958-08-03	730-618-6078x527	74267 Robert Ferry Suite 955, Gilbertshire, AK 12667	Taiwan
enogueira	noahpires@example.net	1947-05-06	(832)693-9659	4329 Young Oval Suite 359, West Kimmouth, IA 12690	Hong Kong
josephmorse	mayarodrigues@example.com	1953-07-02	71 4551-4227	Travessa de Silveira, Andiroba, 54738150 Carvalho da Praia / PB	Jordan
breno08	alicia11@example.net	1917-07-05	71 6339 9910	85755 Troy Viaduct Suite 832, Powersbury, MI 55012	Bulgaria
ucirino	yago89@example.com	1978-01-01	+1-849-436-3702x0605	Alameda José Miguel da Luz, 7, Anchieta, 91735111 Almeida / DF	Kenya
monteirojuan	rgardner@example.org	1992-07-05	928-521-4012x4277	8682 Floyd Park, Christopherhaven, AZ 77581	Uganda
alexandrevargas	icooper@example.com	2001-10-24	581.974.2469x98722	054 Kellie Hill Suite 598, West Jennifer, WI 39359	Bangladesh
mary20	ybarbosa@example.com	1917-02-06	329-952-2761x14466	046 Erika Shores, Lawsonfurt, OR 88248	Malawi
maria-fernandacassiano	ana-cecilia65@example.org	1934-10-21	001-806-288-6259x91432	Viaduto de Lopes, São Pedro, 55220057 Pastor / MT	Indonesia
martinslavinia	jda-cruz@example.net	1922-02-21	(041) 9804 5011	Jardim Rezende, 88, Milionario, 23176537 Pereira da Mata / AM	Nepal
cavalcantiana	zsnyder@example.org	1949-06-13	+55 (071) 3759-2758	430 Margaret Circle, Morrishaven, HI 59304	Bosnia and Herzegovina
maria-ceciliasilveira	ramoselizabeth@example.com	1997-06-19	81 3598 0878	Distrito de Mendonça, 11, Vila Betânia, 20632678 Santos de Goiás / SP	Mozambique
griffithzachary	joao-miguelsilva@example.org	1933-07-09	927-679-2910x82571	Colônia Maitê Fonseca, 10, Oeste, 80359707 Sampaio Grande / RO	Puerto Rico
cecilia55	silveiravitoria@example.net	1963-04-23	001-813-813-8243	Fazenda Silveira, 33, Santa Cecilia, 97705847 Rocha / TO	Comoros
iclark	theobarros@example.net	1988-09-06	+55 (041) 3172 8355	01756 Ortiz Highway Apt. 339, Clarkton, SD 49270	Jordan
fonsecabeatriz	nogueiraotavio@example.com	2003-04-16	+55 84 8466-4802	Largo Maria Flor Silva, 49, Vila Petropolis, 80645-117 Vasconcelos do Norte / PB	Bangladesh
robert33	imartin@example.com	1973-07-01	258-736-3352	213 Dawn Gardens Suite 529, Markbury, NE 70200	Panama
oduarte	da-pazpedro-lucas@example.net	1976-07-29	(998)257-5355x88657	Loteamento Borges, 15, Conjunto Floramar, 90522861 Moraes Grande / RS	Georgia
britomathias	cartertimothy@example.net	1942-06-16	+55 11 3299 9446	Favela de da Mota, 4, Dom Joaquim, 55457769 Brito Paulista / TO	Ivory Coast
taparecida	mateuspinto@example.org	1948-09-26	+55 (031) 1406 5581	Distrito Abreu, 53, Cruzeiro, 67400236 Silva Verde / BA	Solomon Islands
vcavalcante	cherylclarke@example.com	1997-07-27	+55 51 7136 8908	Vereda Bárbara da Rosa, 45, Serrano, 16438288 Pacheco / PE	Saudi Arabia
daniel04	newmanvictor@example.net	1917-07-07	0300 724 9799	8281 Taylor Hills Suite 976, Brockville, IA 75447	Barbados
christophergraham	vbrito@example.org	1965-03-25	(638)429-6545	Rodovia de da Rocha, 348, Miramar, 58724-175 Ramos / DF	Cambodia
raulgarcia	pda-cunha@example.org	2001-02-03	31 8252-4020	Sítio Mateus Lopes, 48, Vila Real 1ª Seção, 49567-114 da Luz / PR	Chile
leaomariane	zbarros@example.org	1983-11-26	81 2641 8151	22741 Amber Highway Apt. 434, Phillipschester, NM 63828	Japan
nicholas95	crystalphelps@example.net	1999-03-26	(021) 7132-6264	720 Vickie Fall, Leeland, AR 93300	Namibia
wesley40	cortezjonathan@example.com	2000-09-27	+1-989-315-8653x64166	Área Bella Peixoto, 16, Conjunto Providencia, 71991321 da Mata de Minas / SP	Russia
linda39	jyu@example.com	2011-03-07	+55 (071) 9722 2446	036 Lee Fall, Brianfort, ND 24181	Comoros
mlima	juliasilveira@example.com	1925-05-06	863.287.3700	Largo Thiago Oliveira, 88, São Marcos, 54579358 Pires / RJ	Philippines
brewertimothy	thomasjohn@example.org	2010-09-23	731-880-3831x2781	Ladeira de Castro, 7, Serrano, 44987-185 Costa de Alves / MT	Taiwan
imelo	isabel04@example.com	1958-04-19	(011) 9645-9477	Via Vasconcelos, 80, Andiroba, 76133-533 Sales / PA	Yemen
amy64	paulo82@example.net	1971-02-07	41 4552-2556	783 Laura Extension Apt. 395, Barbaraside, IL 47958	Angola
carlos-eduardoda-rosa	ester22@example.net	1933-06-18	(081) 1457-7969	593 Richard Square, Osbornbury, UT 76936	Israel
aprilbarnes	ravypeixoto@example.org	1965-06-20	+55 41 0905 9332	Via de da Paz, 8, Vila São João Batista, 14556131 Vargas de Souza / PR	Brazil
thomasmendez	makaylabradley@example.org	1933-08-29	6706896274	67575 Jason Overpass Suite 730, Hillshire, NC 86212	Cape Verde
kristen12	vieiraanthony@example.net	2005-12-18	3385410005	Feira José da Luz, 80, São Geraldo, 23134-542 Ribeiro de Minas / AL	Mexico
sarah45	castroana-livia@example.org	1961-05-02	852-471-0972	8199 John Flats, Leehaven, GA 55115	Malaysia
lara79	murrayscott@example.net	1963-04-27	+1-673-826-1987x846	Ladeira de Albuquerque, 446, São Francisco Das Chagas, 42807-664 Castro / PE	Morocco
michaelmonroe	michaelhiggins@example.net	1965-06-20	+55 (011) 3028 9061	Quadra das Neves, 5, Xodo-Marize, 17427-027 Peixoto de Carvalho / AL	Turkmenistan
ocasa-grande	salesisaac@example.org	1963-08-16	+55 84 9667 0316	94128 Ryan Stravenue Suite 823, North Shawn, GU 31823	Oman
kristina81	gustavolima@example.org	1972-02-17	001-536-462-7164	Vale Gabriela Aragão, 878, Novo Aarão Reis, 97184992 Siqueira do Campo / SE	Hong Kong
fnovais	portomaria-julia@example.com	2001-04-26	+1-566-801-2398x2740	Pátio Daniel Aragão, 93, Jardim Montanhês, 58343750 Leão de Rios / MT	Puerto Rico
ribeiroeloah	icastro@example.net	1960-08-27	001-598-450-3649x3184	09631 Gordon Port Apt. 354, Andrewhaven, SD 70454	Hungary
cunhajoao-gabriel	morrisonconnie@example.org	1923-04-02	(084) 1758 5235	7096 Smith Forks Suite 231, Juliestad, WI 82736	Angola
larissasales	victoriaperez@example.net	1951-12-18	(779)522-8793x452	Praça Lima, 3, Vila São João Batista, 40138622 Jesus das Pedras / RJ	Eswatini
sara20	qhutchinson@example.org	1918-12-02	+55 51 2598 9778	Praia de Sá, 16, Savassi, 42738255 Gonçalves Paulista / AM	Tunisia
cabreradonald	pricericardo@example.com	1941-07-07	(683)374-1764x59006	Largo de Farias, 202, Vila Nova Cachoeirinha 1ª Seção, 66136-675 Nogueira de Costa / CE	Samoa
umeadows	jennaoliver@example.com	1986-04-27	(454)440-0967	Conjunto Rocha, 4, Serrano, 02792-666 da Luz Alegre / SC	Iraq
lisamoses	xoliveira@example.org	2007-10-23	0800-924-9081	Vereda de Viana, 74, Vila Sesc, 14490816 Gonçalves do Amparo / DF	Lebanon
glenndominguez	qwalter@example.org	1947-10-02	21 9381 7315	Campo de Cavalcanti, 890, São Benedito, 36280447 Pacheco / RJ	Rwanda
xwhite	broberts@example.com	1933-09-26	(322)463-8737x24921	8330 Earl Summit Apt. 757, Lake Diana, KS 43854	Brazil
stephensonshannon	cdiaz@example.org	1958-03-28	(527)350-7374	Área Ana Júlia Jesus, 631, Horto Florestal, 31390571 da Rosa Paulista / CE	Cayman Islands
da-rosadiogo	fariasdavi-luiz@example.net	1972-11-20	878-216-1823	Núcleo Hadassa Cavalcanti, Castelo, 71337898 da Paz Grande / AP	North Macedonia
borgeslarissa	ygraham@example.net	1936-10-08	(081) 1706-5219	Fazenda Fernandes, 4, São José, 76725174 Barros de Minas / BA	Kyrgyzstan
vasconcelosbruna	tkirby@example.net	1956-08-12	+55 (071) 4488 6192	Vila Maria Flor Moreira, 54, Marilandia, 20181958 Cardoso de Goiás / PB	Sri Lanka
portodante	britosofia@example.com	2003-04-18	422-257-5233	035 Gary Shore Apt. 242, East Christopherburgh, MO 67517	Moldova
cavalcantebento	david43@example.net	1946-10-12	+1-399-749-6222	898 Daniel Tunnel Apt. 099, Lopezshire, KS 81801	Fiji
liz08	luiz-gustavo58@example.net	1910-05-15	0800 769 5986	2709 Stein Village Suite 656, North Timothy, UT 35404	Kiribati
bjohnson	tylercollins@example.net	1922-06-22	+55 (011) 2917 4036	0925 David Trafficway Suite 072, Andrewtown, WY 79755	Mozambique
hendersondestiny	rodriguezjose@example.net	1987-12-22	+55 41 8746-9636	Condomínio Nogueira, 60, Acaba Mundo, 95520109 Martins do Galho / PA	Iraq
arnoldjason	tsilveira@example.net	1958-02-07	+55 41 5079 6392	6710 Robert Port Suite 416, Gonzalezmouth, PA 59316	Brunei
joneslaura	ana-carolinaferreira@example.net	1959-08-08	21 0746-3076	Loteamento Ferreira, Prado, 60815-605 Cardoso do Campo / PA	Lebanon
wlong	wrightdiane@example.com	1942-04-16	466-969-9537	PSC 3511, Box 0898, APO AA 90451	Bahamas
samarina	yhughes@example.com	1919-01-08	(051) 2212-8305	543 Holly Shore, East Rose, KS 96089	Qatar
mariahandrade	xferreira@example.org	1974-12-08	001-683-330-0670x86975	Sítio Brenda Barbosa, Boa União 2ª Seção, 67985-254 Monteiro de Minas / BA	Solomon Islands
lcamara	melissa74@example.net	2005-06-16	+55 51 7468 4470	25708 Lewis Trace Apt. 244, Lake Joshuafort, SD 72697	Cambodia
sara35	cavalcanteanthony@example.com	1963-09-27	+1-341-332-6614x70055	Travessa de Barbosa, Alto Barroca, 29967-201 Lima de Peixoto / RJ	Belize
denisegordon	fpope@example.com	1993-09-27	(313)550-5179x541	Trecho de Vasconcelos, 76, Vila Do Pombal, 46275-591 Sales de Rocha / AL	Serbia
pedro-miguel28	molly49@example.com	2012-05-08	001-242-527-3956x72331	55199 Richard View, Lake Lorifurt, RI 60799	Angola
gibsonerin	emanuelsouza@example.com	1992-03-15	470-294-1053x973	Avenida Nogueira, 12, Ouro Preto, 29499509 Teixeira / PI	Bulgaria
bethany28	daniel65@example.com	1922-04-03	+1-855-465-8311	Quadra João Vitor Costela, 34, Vale Do Jatoba, 03971345 Barbosa de Guerra / ES	Japan
brandonlawson	arthur-miguelsampaio@example.org	2010-05-09	521.909.6833	Condomínio Pedro Miguel Sales, 7, Padre Eustáquio, 74748199 Araújo Alegre / ES	Belize
luiz-henrique37	raraujo@example.net	1989-08-18	887.754.8485x4423	Loteamento Farias, 62, União, 83509-362 Fernandes Alegre / MT	Turkmenistan
schultzdaniel	guzmandeborah@example.net	2000-10-03	0500-008-0004	9663 Samantha Walk Apt. 949, New Melissa, CA 88112	Iceland
amy07	lucas-gabrielvieira@example.org	2006-10-27	61 0749-4004	Viela Gabrielly Fonseca, 63, Granja Werneck, 30025039 Freitas / PA	Morocco
joana83	caldeirapaulo@example.org	1953-12-19	+55 81 6676 7925	0919 Stephanie Forks, North Kelly, CO 41595	North Korea
molinatrevor	aragaomarcos-vinicius@example.net	2013-01-05	+55 (081) 2189-8136	Vereda Isabelly da Rocha, 9, Cônego Pinheiro 1ª Seção, 94141-604 da Conceição / AC	North Macedonia
danathomas	michael80@example.net	1996-03-01	641.483.2368	Estrada de Macedo, 5, Coqueiros, 30534632 Alves do Norte / AM	Barbados
paul61	oda-mota@example.com	1986-09-14	+55 81 7119 9042	818 Ortiz Flat, New Denise, OH 58969	Gambia
mcconnellryan	ocamara@example.net	1983-06-30	+55 (051) 3079 9641	2175 Lopez Village, South Christine, WY 56919	Costa Rica
ana-julia27	chaneybonnie@example.net	1988-03-24	+1-513-806-1533x024	Viaduto Pacheco, 68, Vista Do Sol, 89864078 Porto da Praia / AM	Cuba
fergusonleah	isabella40@example.com	2001-06-24	001-618-703-1154x005	9641 Luna Square Apt. 185, North William, RI 30594	Comoros
ramosjanice	matthewclarke@example.net	1911-03-13	754-616-8044x7140	6748 Villa Orchard Apt. 670, Williamston, AK 87011	Nepal
melissa86	jeanne35@example.org	1943-08-22	(051) 5705-1022	Estrada de da Cunha, 974, Inconfidência, 96952213 Silveira de Dias / GO	Afghanistan
brenda39	rachel62@example.com	1994-09-24	+55 21 3847-5558	Esplanada de Pires, 8, Vila Fumec, 47418027 Leão de Cirino / AP	Kiribati
dwalker	lmorgan@example.net	1994-01-18	+55 (071) 9843-9030	Via Isabela Teixeira, 3, Vitoria, 69921226 Moura de Minas / DF	Ghana
costelastella	da-motabenjamin@example.org	1982-01-10	(031) 5423 2422	855 Brooks Centers, Markmouth, MI 24244	Hong Kong
garciathiago	cpeixoto@example.com	1917-12-25	(041) 6623-5548	7809 Bobby Club Suite 737, Nelsonchester, WI 52192	Saudi Arabia
vieiracaua	edgarhart@example.org	1946-12-14	336.216.0011x3623	Praia Diego da Conceição, 2, Vila Madre Gertrudes 1ª Seção, 18121336 Moreira / PR	Hungary
holtpamela	aylada-luz@example.com	2001-05-18	61 9732 9451	51699 Mario Lock, Ericshire, WI 78464	Gibraltar
ana-luiza34	isabelsampaio@example.org	1973-10-19	001-317-932-7587x1217	Morro Vasconcelos, 657, Nova Esperança, 59929656 Alves / SE	Zambia
ana-carolinamoreira	camposcarolina@example.net	1954-10-30	(818)249-0036x60444	Residencial Gomes, 81, Teixeira Dias, 64620484 Vargas de Minas / RR	Suriname
fernandesmirella	morrisrobert@example.org	1990-10-24	+55 51 9010 4214	97352 Kristina Lights Suite 866, Monicachester, VA 03106	Namibia
ana-lizaragao	costelarael@example.org	2008-07-03	+55 (051) 1105-4843	45885 Troy Track Apt. 204, New Anthony, PR 08606	Rwanda
felipe24	david47@example.org	1913-07-13	979-413-2066x262	Área de da Conceição, 65, Bernadete, 54350032 Azevedo do Galho / CE	Puerto Rico
sharpelizabeth	conniewalker@example.org	1995-07-11	+55 (041) 6358-7295	7237 Baldwin Islands, Banksport, MP 86830	United Arab Emirates
wallstephanie	rogersfrancis@example.com	1953-07-19	(081) 9514 8887	Área de Vargas, São João, 72710-144 Sampaio / CE	Guyana
joaquim24	da-rochakamilly@example.com	1915-05-07	0900 835 4734	Rua de Lima, 47, Palmares, 49868-115 Duarte / AM	South Korea
xmorris	steventhompson@example.com	1999-07-28	526-393-9577x56105	Pátio Carvalho, 135, Santa Cruz, 22807-521 Azevedo do Campo / MS	Guinea
jdickerson	uribeiro@example.net	1975-02-19	875-448-7891x06869	4780 Rachel Springs, Ronaldtown, ID 68209	Suriname
joao-miguelsouza	arthur-gabrielmachado@example.net	1993-09-25	+55 41 2624 9459	Aeroporto Clarice Barbosa, 51, Marieta 2ª Seção, 04700-615 da Cruz / AM	Saint Lucia
piercemary	levibailey@example.com	1942-02-19	763.260.0654x920	Vale Mendonça, Primeiro De Maio, 84530-141 Cardoso Verde / AP	Poland
isabelly27	kamilly15@example.net	1967-05-03	(081) 9250 0841	Sítio Maria Cecília Pacheco, 67, Piratininga, 67689593 Correia da Mata / RO	Brunei
perezbenjamin	qfoster@example.com	1928-10-21	339.951.8406	1595 Cheryl Hills, Lake Debraborough, CT 04933	Albania
sheila63	sarathomas@example.org	1917-01-02	475-436-7466x864	Fazenda Camargo, 786, Vila Rica, 49870737 Barbosa Paulista / SP	Poland
stonestephanie	amandawagner@example.com	1947-04-28	+55 (051) 9953-4993	Rua Luiz Gustavo Pires, 16, Ambrosina, 80677-771 Nunes do Norte / AP	Haiti
mcosta	melinda00@example.net	1928-12-18	0500-794-2038	Via Diego Campos, Vila Santa Monica 2ª Seção, 42945-625 Rezende da Prata / RR	Albania
emcbride	bmason@example.net	1944-05-05	001-926-949-8079x7566	USS King, FPO AE 19156	Uzbekistan
onguyen	andreagibbs@example.com	1982-10-17	(031) 4152-7150	Fazenda Casa Grande, 75, Conjunto Califórnia Ii, 06881502 Novais / SE	Japan
isadoramoraes	pereiraclarice@example.com	1919-04-26	+55 (051) 0870-5676	2561 Kenneth Pike Suite 531, Emilyborough, MN 53311	Honduras
barbosaliz	haasshawn@example.org	1980-08-16	+55 (051) 5556 1628	Avenida Laís Gonçalves, 963, Novo Ouro Preto, 90517791 Pinto / RJ	Canada
maria-liz92	raul51@example.net	1929-11-01	(051) 8611 2436	9013 Alyssa Manor, Diazberg, UT 26802	India
lbrooks	kara16@example.com	1934-05-10	41 5070-2864	3262 Banks Terrace, Sullivanbury, ND 11476	India
ian44	william23@example.com	1961-04-22	(081) 1407 1403	Trecho Luiz Henrique Abreu, Santa Maria, 02302692 Nogueira Alegre / RS	Eritrea
vasconceloselisa	juan98@example.org	1944-05-05	+55 41 4338 5315	70543 Goodwin Ville Suite 678, New Leslietown, KY 35530	Azerbaijan
christina81	leandrobrito@example.org	1936-10-21	001-663-388-2945x67622	Via Isaac Rezende, 159, Primeiro De Maio, 41694330 Guerra / AP	Barbados
guerraleo	bobby39@example.org	1999-05-02	61 4920 0249	Colônia Vargas, 1, Marieta 1ª Seção, 30886-121 Sousa Grande / MG	Fiji
ceciliamelo	qcasa-grande@example.com	1942-07-02	+55 81 3190 7573	6340 Makayla Springs, Ericafort, TX 60230	Honduras
lauren64	rbrito@example.net	1917-08-08	(412)593-6857x58723	Unit 8690 Box 0458, DPO AE 95154	Liberia
imendonca	oliveirayasmin@example.org	1952-05-07	(456)619-4432	Rodovia Costa, 8, Nova Suíça, 33310-622 Silveira do Amparo / PB	Costa Rica
klopes	vieirarhavi@example.net	1974-04-10	+55 41 2907-0483	388 Mcdonald Springs Apt. 429, New Emilyberg, IN 59159	Madagascar
calebcamargo	justin66@example.net	1950-05-01	6252834672	978 Michael Pines Apt. 159, Stephensonville, AR 69955	Kiribati
yavila	henry71@example.com	1962-05-29	+55 (071) 5299 9419	350 Loretta Bypass Apt. 021, South Elizabethberg, GA 13466	Laos
portobella	garciascott@example.org	1972-03-13	001-236-523-2521x752	0069 Pratt Route, Port Gina, OH 85813	Brunei
hudsonjose	david98@example.com	1988-03-05	+1-544-992-5326x48282	USCGC Lawrence, FPO AP 07688	Burundi
julie32	nicolasmendonca@example.org	1990-03-09	+55 11 7922 6319	1643 Amy Mountain Suite 589, Baileyberg, MT 44314	Zambia
novaesthales	riddleroger@example.org	1931-05-28	001-494-640-0421x622	139 Campbell Underpass, Lake Danielburgh, ID 51203	Liechtenstein
tiffanyharris	dom11@example.com	1945-12-17	(031) 7935-4204	96981 Armstrong Vista Suite 485, South Edward, OH 45059	Qatar
nicolethomas	ujohnson@example.com	1935-09-05	+55 61 7585 6730	Estrada Pires, 919, Vila Piratininga Venda Nova, 96854287 Castro de Goiás / PA	Russia
souzajoana	stephanie26@example.net	1982-04-14	375.775.6839x88987	Esplanada Camargo, 2, João Paulo Ii, 10211860 Brito / CE	Kazakhstan
phillipscharlotte	millerbob@example.com	2009-07-02	+55 61 3077-2495	399 Matthew Brook, North Whitneychester, IA 15426	Central African Republic
millererica	ubennett@example.net	2005-07-22	21 1225 6683	Unit 7018 Box 0688, DPO AE 36438	Saint Lucia
moniquesanders	jpimenta@example.com	1918-07-03	+1-402-211-1026	Feira de Dias, 66, Vila Independencia 2ª Seção, 44319170 da Costa / SP	Honduras
castanedamichael	ravi10@example.org	1987-09-28	+55 (011) 4098 1529	Distrito Ana Clara Pereira, 9, Taquaril, 18675148 Correia de Viana / RJ	Iraq
esouza	emanuelly76@example.net	1972-11-06	+1-242-862-0393x6526	Vila Nogueira, 93, Vista Alegre, 88835-283 Cavalcanti / MA	Nepal
bgates	goodwinjason@example.com	1941-06-30	+55 41 2556 3149	171 Richard Forge, Reynoldsberg, KS 30740	Morocco
barreraerica	danielbarry@example.net	1970-02-25	+1-644-583-1304x766	USS Robinson, FPO AE 29850	Denmark
alanafreitas	hartmanrobert@example.net	1926-06-22	(081) 8995-7213	Travessa de Guerra, 2, Estrela Do Oriente, 23607992 da Mata dos Dourados / SP	North Korea
pietramoura	juan46@example.org	1978-02-03	215.535.8073x962	34213 Cooper Via, Greenchester, ID 83635	Sweden
udas-neves	nguyenrobin@example.org	1957-01-15	425-924-3789x06469	850 Sherri Plains Apt. 381, Elizabethmouth, NM 14656	Iceland
smithemily	carlos-eduardo62@example.org	1932-05-28	811-503-1912x920	Alameda Machado, 13, Santana Do Cafezal, 52603-706 Albuquerque de Campos / PB	Bermuda
ubennett	enzorios@example.com	1958-02-05	61 8097 3221	Praia da Conceição, 85, Vista Alegre, 45992-971 Caldeira / GO	Belize
megan14	arthur82@example.com	1994-02-02	+55 (011) 5853 1203	Rodovia Cassiano, Conjunto Minas Caixa, 09522-999 Mendonça / PR	Israel
michael18	wharrison@example.com	2008-05-13	(388)556-3170x65443	Ladeira de Cavalcante, 745, Gameleira, 83574655 Gomes / RN	Uzbekistan
onogueira	jadefernandes@example.com	1933-12-26	71 6781 0763	798 Randall Row, Port Jonathan, MN 42953	Chile
crawfordryan	fernanda40@example.net	2009-05-28	+55 41 1727-7931	Chácara de da Luz, 86, Ribeiro De Abreu, 12777636 Lima de Goiás / BA	Ethiopia
tylerchristina	craigmitchell@example.org	1917-08-11	(210)732-6452	980 Mayer Field, Benjaminhaven, NY 38182	Laos
lorenzodas-neves	zachary98@example.net	1965-03-09	0900 136 5419	3570 Donald Village, Katherineburgh, NH 84044	Canada
hmoore	brogers@example.com	1920-06-12	+1-318-564-3069x1781	0546 Nicole Fork, Port Heathershire, OK 81019	Gambia
courtney78	adamstewart@example.net	1995-03-07	+1-759-744-8267	Favela de da Conceição, 78, Universo, 85801-114 Costa Grande / AL	Dominican Republic
liviaazevedo	enzomartins@example.org	1943-01-06	+1-856-980-8467x408	72768 Sarah Crest Suite 134, New Ryan, VA 41276	Indonesia
isis37	anna-liz58@example.com	1967-07-24	(731)960-0156x617	229 Laura Locks, South Thomas, AL 91861	Japan
sarahmedina	barbosamelissa@example.org	1922-03-18	803-309-1923x87531	Morro Cavalcanti, 81, Coqueiros, 19824-564 Porto / TO	Afghanistan
marcos-viniciusrodrigues	vitoriada-costa@example.com	2007-08-05	001-490-578-2412x3925	Praia Nogueira, 810, Independência, 10381-536 Cavalcante de Teixeira / AC	United Arab Emirates
julie14	rachelwiggins@example.org	1995-08-14	428.910.5487x537	Área de Aragão, 8, Aparecida 7ª Seção, 63146223 Lopes / CE	Myanmar
rodrigolopes	thomasjohnson@example.net	1948-11-14	+55 81 0296 3858	8346 Dustin Wells, Newtonhaven, MH 54859	Namibia
moorejennifer	nicole69@example.com	1914-05-25	(664)352-7174x51437	Residencial Rael Peixoto, 22, Nova Granada, 37971-072 Cunha / AC	Sudan
sean39	hellenaaragao@example.net	1996-11-16	+55 31 0667-0908	77306 Shelton Prairie, New Jose, ND 23722	Oman
luiz-otavioviana	luanada-mata@example.org	2001-10-13	(011) 0682-0508	717 Ryan Mill Apt. 450, Sarahfurt, ID 24253	Somalia
palmerbrandon	claricebarbosa@example.net	1966-11-21	536-461-2480x033	Setor Maysa Vasconcelos, Guaratã, 02325821 Almeida / SE	Guatemala
thompsonryan	portoarthur-miguel@example.net	1993-02-26	513.746.6636x78920	11854 Brian Springs, Lake Aprilbury, DE 75517	Sri Lanka
mary02	isaac18@example.org	1957-10-06	+55 11 7492 6988	Loteamento Maya Melo, 32, Vila São Gabriel Jacui, 46823-790 Caldeira / RR	Lesotho
nelsonbrandon	michelleneal@example.org	1958-09-15	(061) 6978-1665	494 Lewis Falls Apt. 540, Lake Lesliehaven, SD 22050	Wallis and Futuna
padillawhitney	cbrito@example.com	1969-11-14	41 7184-0366	547 Brian Brooks Suite 094, New Sean, MD 82746	Mongolia
josuemontenegro	maite82@example.org	1933-08-15	613.305.1908	9438 Taylor Circle Apt. 126, South Alex, TN 09489	Zambia
agathafogaca	ecastro@example.com	1976-08-14	+55 11 8516 3362	66080 Ward Lake, South James, MP 91791	Western Sahara
milleralexandra	fernando95@example.org	1956-09-07	443.319.2060x5698	Vereda de Martins, 37, Marçola, 88736674 Cassiano de Goiás / RJ	Sudan
kathy42	diasdavi-luiz@example.org	1920-01-23	441-394-5424x0494	Passarela Siqueira, Gutierrez, 12563888 Cunha de Minas / AM	Solomon Islands
eduardo65	fariasvitor@example.com	1937-07-09	(084) 8591 7674	706 Sanders Courts Apt. 970, Latoyamouth, VT 57217	Madagascar
simmonscheryl	freitasian@example.com	1925-04-20	0900-684-3432	Loteamento Rezende, 14, Vila Paris, 26711019 Albuquerque / BA	Eswatini
melissapennington	kerrmark@example.com	1972-10-01	(061) 3980-1509	Jardim de Abreu, 96, Esplanada, 17414320 Martins Grande / PB	Sudan
allennatalie	brayancavalcanti@example.net	1950-07-18	+55 (021) 8958-6461	99844 Roberts Isle, Landryville, VT 80006	Sudan
ana-liviasousa	robertriley@example.org	1930-05-18	001-941-557-3727	294 Murray Rapid, Port Deborahfort, ID 67467	Liberia
nunesisis	prestoncaitlin@example.org	1930-11-14	+1-774-588-7995	Vila Duarte, 34, Vila Santa Monica 1ª Seção, 89070-454 Melo de Goiás / RR	Bahamas
pintoeduardo	danilosantos@example.net	2000-05-16	+1-939-710-7273	Campo Maysa Lima, 5, Ribeiro De Abreu, 28769292 Cavalcanti das Pedras / AM	Sweden
tpeixoto	mmiller@example.org	1988-07-04	+55 (031) 2479 8563	Vale Sales, Marçola, 72928753 Vasconcelos / RN	Namibia
cauabarbosa	calebbarros@example.net	2007-07-25	(071) 8785 2880	60064 Brady Coves Suite 078, Ortizshire, UT 13497	Kiribati
cavalcantemaria-clara	vitor-gabriel53@example.org	1940-09-20	+55 (011) 7466 6113	47480 Torres Walks, Sandrafort, NM 49714	DR Congo
yhood	christopherblake@example.com	1921-03-18	81 3895-2734	Campo de Cirino, Santa Efigênia, 89698-982 Peixoto das Pedras / PR	Fiji
maria-flormacedo	colleen23@example.net	1956-01-17	41 1015-9460	116 Catherine Fort Suite 616, West Bridgetberg, NE 29341	Jamaica
henry90	foxrobyn@example.net	2004-09-11	(041) 3070 9082	Alameda Pereira, 5, Vila Rica, 92051-112 Camargo / MT	Lebanon
montenegroana	dda-luz@example.net	1922-03-26	+55 11 2075 4655	Chácara Cassiano, 62, Prado, 38313-056 Jesus das Pedras / PB	Eritrea
mathew20	azevedoana-cecilia@example.net	1969-01-04	81 3694-7265	Colônia de Correia, 58, São Gabriel, 90376-131 Moura / RR	Chile
maria-ceciliacamargo	zbowman@example.com	2003-06-16	41 0610 0104	Vale da Costa, 1, Vila Antena Montanhês, 49096204 Teixeira / CE	Kenya
brandidawson	currytimothy@example.net	1950-11-22	(575)840-3415	984 Cox Crossroad Suite 752, Blairfort, NC 22487	Afghanistan
caua39	ashleemiller@example.net	2011-02-20	4512552635	Lago Carvalho, Pantanal, 62152250 Peixoto / RR	Morocco
francisco28	garymoore@example.net	1995-01-03	+55 71 8919 0140	Passarela Valentina Ramos, 501, Aparecida 7ª Seção, 22014-055 da Cunha / CE	Seychelles
tmendonca	larry01@example.net	1981-01-07	(619)228-0368	Morro de Peixoto, 31, Coração Eucarístico, 67706-843 Siqueira / SE	Djibouti
lopezrebecca	bethwhite@example.com	1960-07-01	(011) 3464 9420	1265 Woods Coves Apt. 688, Diazbury, WA 45285	DR Congo
rfreitas	saheloisa@example.com	2001-06-22	+55 (061) 8531-7654	Travessa Paulo Cirino, Santa Rita De Cássia, 96335928 da Cruz / RN	Kyrgyzstan
kevingardner	rgriffin@example.com	2007-04-16	(307)386-6464	Estação de Brito, Vista Do Sol, 01616-400 Farias / MG	Maldives
da-costaheloisa	jandrade@example.com	1964-12-08	950.434.3978	Conjunto de Costa, 44, Engenho Nogueira, 42512990 Cunha da Praia / PA	Maldives
benicio73	kcamara@example.net	1959-01-28	730.313.8252x946	4863 Todd Junction, North Maryfort, UT 07152	Djibouti
da-cruzmaria	nanthony@example.org	1965-10-15	(896)480-9754x583	Trecho de Rezende, 441, Calafate, 34163443 Porto de Minas / PB	Niue
zbrown	ogarcia@example.net	1999-03-27	(496)885-0671	Conjunto Brito, Santa Cecilia, 57537-881 da Rocha / SE	Saint Lucia
novaislorenzo	vcampbell@example.org	1959-11-02	(482)797-1952x38124	Via da Rocha, 7, Aparecida 7ª Seção, 99821-014 Rodrigues do Sul / AM	Lesotho
egarcia	bgreen@example.com	1987-04-20	51 5573 7448	162 Melissa Tunnel Suite 067, West Taraborough, MA 80809	Rwanda
ashleebray	reginaldphelps@example.com	1955-10-03	792-421-0545x314	Parque Marina da Costa, 37, Vila Paquetá, 59588-112 Cardoso de Caldeira / MS	Zambia
jpatrick	serranostephen@example.com	1926-10-10	61 1139 0702	Unit 9356 Box 6455, DPO AP 70695	Kenya
dpastor	aholt@example.net	1983-09-13	0800 627 4307	4654 Joe Dale Apt. 074, Markburgh, MH 40553	Eswatini
asafeandrade	riley24@example.org	2003-01-28	(961)325-1215x31320	4619 Wilkinson Center Suite 699, Elizabethburgh, WA 17921	Russia
oliveiradanilo	ryan37@example.org	1934-05-28	0300-119-9876	9090 Sanders Heights Suite 048, South Elizabethfurt, WI 99110	Sweden
mayada-cunha	caroline02@example.net	1949-12-28	+55 81 9734 0832	Praça Moura, 85, Cachoeirinha, 54087287 da Cunha de Peixoto / RS	Seychelles
sofia70	marienixon@example.com	1937-03-29	(041) 3162-1486	Recanto de Borges, 215, Floresta, 89111-897 Aparecida / SP	Honduras
mhendricks	djohns@example.com	1927-04-05	+55 (061) 5657-1613	422 Foster Ranch, East Jameschester, MI 21720	Morocco
yda-luz	johnpatton@example.net	2009-05-03	+55 84 7454 4997	7712 Marcus Viaduct, Hugheston, PW 54603	Liechtenstein
xsutton	alana19@example.org	1916-09-14	21 0982-2383	391 Martin Summit Apt. 428, West Richardview, MN 91165	Namibia
ajones	stella29@example.org	1962-07-24	001-567-978-6449	Via de Alves, Andiroba, 10974037 Pires / GO	Libya
sbrown	kimvictoria@example.net	1953-07-15	819-760-7148	Via Silva, 8, Santa Monica, 08200-668 Costa do Amparo / ES	Bulgaria
garciaaylla	jamiemclaughlin@example.net	1912-10-27	416-219-6225x114	Lagoa de Lopes, 717, Minaslandia, 29328734 Camargo / AL	Bhutan
johnstontyler	castroana-beatriz@example.net	2001-05-11	+55 11 5689 0028	Viela Marques, 24, Vila Independencia 2ª Seção, 60093-695 Freitas do Oeste / AL	Sri Lanka
davi-luiz83	daniel04@example.net	1963-07-28	+1-523-846-1440x3660	Parque Arthur Miguel Martins, Ernesto Nascimento, 32205698 Rios / MT	North Macedonia
brayanpastor	ianmartins@example.net	2008-02-21	001-986-709-3906x32597	Feira de Aparecida, 4, Vila Olhos D'água, 92778352 Mendonça / PE	Uzbekistan
benjamin81	ldavid@example.org	2013-09-07	(502)996-4258x81394	Alameda Cunha, 6, Vila Fumec, 44264-867 da Rosa do Sul / RJ	Solomon Islands
maria-vitoria49	da-costaravi-lucca@example.net	1994-04-05	+55 41 6108 0921	7993 Davis Plain Apt. 791, Port Cynthiaview, LA 45555	Malaysia
colemanyvonne	juliasampaio@example.com	1973-07-22	9188061304	Rua Yan das Neves, 627, João Pinheiro, 37370-112 Martins / CE	Belize
bowerselizabeth	josueda-costa@example.org	1996-01-22	001-818-248-1317x2917	Lago Porto, 30, Braúnas, 42207-584 Nogueira / AM	Serbia
aurorasales	zmacedo@example.org	1937-11-12	0500-474-2704	Aeroporto das Neves, 542, Tupi B, 21415-973 Marques / SE	Thailand
cynthiafranklin	qnascimento@example.com	1982-09-27	11 6088 6077	Quadra Sophia Almeida, 641, Europa, 21705183 Rocha / SP	Niue
tallen	kristin86@example.com	1913-10-19	4654516207	30829 James Valleys Suite 924, Lake Brittany, MP 80764	Albania
thales27	howardrenee@example.net	1933-11-01	11 0765-2254	Rodovia Isabela Pastor, 39, Conjunto Paulo Vi, 04476654 Lopes / AC	Wallis and Futuna
rodgersjohn	petersendennis@example.com	1938-09-09	+55 (011) 7036 6710	Passarela André da Costa, 83, Bernadete, 91480-504 da Cunha / PR	Jamaica
raymondrichard	gmurray@example.net	1939-04-15	0500 086 2595	PSC 2535, Box 4768, APO AP 30324	Yemen
samuelgarcia	albuquerquejoaquim@example.org	1938-08-03	+1-231-232-4756x83601	00494 George Avenue Suite 489, Kristiville, UT 93588	Cambodia
bryan24	willie65@example.net	2006-05-24	+55 71 5276 5290	8642 Martinez Branch Apt. 196, Perkinshaven, PR 77274	Liechtenstein
cthompson	pastorkevin@example.net	1989-03-09	(434)571-5675x283	33473 White Track Suite 525, New Nicoletown, TN 80814	Saudi Arabia
goncalvesasafe	ana-carolina55@example.com	2008-06-20	(536)681-3379x9008	Área de Vasconcelos, 47, Santa Rosa, 13810-329 Castro do Amparo / CE	Cayman Islands
jhart	paynenicholas@example.com	1944-05-27	61 4570-7244	Vereda Novais, 655, Vila De Sá, 94458099 Nascimento da Praia / ES	Saint Helena, Ascension and Tristan da Cunha
laurabush	joao-guilhermemarques@example.org	1926-07-03	318-826-5119x51454	7268 Mclean Rapids, East Carlos, CO 94550	Ethiopia
katiekoch	john16@example.net	1957-10-13	61 0406-6959	802 Jackson Plaza, New Jennifer, AS 99569	Kazakhstan
brendaalexander	mourapaulo@example.com	1927-02-08	(081) 3064 1268	Loteamento de Sousa, 20, Ápia, 34564-707 Lopes de Sousa / ES	South Korea
osantos	das-nevesjoaquim@example.org	2011-01-03	951.329.6460x0557	Praça de Cunha, Trevo, 46908672 Fonseca Paulista / AP	Comoros
ajacobson	breno72@example.com	1990-03-28	291.653.7263	Fazenda de Freitas, 72, Califórnia, 65365341 Costa do Campo / RO	Lesotho
shannon05	thiagocirino@example.net	1919-06-05	11 0992 1436	Passarela Danilo Castro, 719, Graça, 04701304 Caldeira / MA	Malawi
jacobgriffith	zbrown@example.org	1993-10-26	+55 51 2398 5573	Morro de Leão, 80, Providencia, 72459303 da Rocha / PB	Peru
qvieira	sabrina00@example.org	1950-02-05	001-794-512-1539x6959	Estação de Machado, 353, Novo Santa Cecilia, 21686-350 Cirino / DF	Gambia
marcos-viniciusnogueira	luiz-miguelramos@example.com	1974-12-24	3446326553	Fazenda Cirino, 69, Vila Fumec, 45513918 da Mata / SP	Ivory Coast
rochabenicio	jrodrigues@example.org	1952-10-17	644.480.7434x81158	Via de Sampaio, 855, Centro, 84540-225 Castro da Serra / DF	Bhutan
iazevedo	lisawatts@example.net	1942-04-30	431.729.0826	Lago Emilly Siqueira, 42, Primeiro De Maio, 83617018 Sampaio Alegre / PE	Yemen
apollo90	mataangela@example.net	1928-01-17	+55 11 0946-0660	Esplanada de Mendonça, 5, Aparecida, 67147440 Silveira / PB	Western Sahara
tanyalane	pimentabryan@example.net	1963-10-06	+55 (021) 7371-2575	Travessa de Melo, 3, São Bento, 43110898 Jesus / AC	Wallis and Futuna
guerrerokevin	nogueiramathias@example.net	1949-06-30	(084) 3364 2115	Setor de Pires, 9, Inconfidência, 89451634 Jesus da Serra / AL	Iraq
mark19	isabelda-luz@example.com	1953-05-02	001-546-823-9110	Unit 2707 Box 7699, DPO AP 80259	Turkey
hoodbrandi	arthurduarte@example.net	1929-03-07	562-391-0420	Loteamento Dante Sá, 5, Vila Havaí, 56458-969 Cardoso / MT	Malawi
sanderson	luiz-otavio97@example.org	1912-02-04	(031) 7290-4183	Conjunto Pinto, Nova Granada, 09993-513 Araújo / MS	Djibouti
vgarcia	sofia89@example.com	1944-03-30	213-276-9260	Área Isabel Correia, 17, Dom Bosco, 91871902 Freitas / MS	Zambia
vitoria92	hvieira@example.net	1962-08-07	(081) 5146-5064	Fazenda Renan Almeida, 93, Horto, 70586-945 Abreu da Serra / MA	Macau
olee	jperez@example.org	1992-03-29	0800-670-0581	02573 Jaime Stream, West Alexander, VI 08835	Morocco
lpeixoto	meloana-vitoria@example.net	1917-05-31	(084) 5845-8589	USCGC Taylor, FPO AE 98386	Tajikistan
sarah78	jessica65@example.net	1927-08-26	(011) 2011 1352	Alameda Letícia Pires, 5, Oeste, 64708473 Duarte de Goiás / ES	North Korea
heloisaaraujo	hannahmorris@example.com	2005-07-20	001-288-623-0865	93917 Jackson Locks, Port Manuel, IA 49354	Haiti
calebealbuquerque	julianabarbosa@example.org	1949-12-30	001-724-490-2692	030 Bender Mews Apt. 815, Brookstown, MT 92035	Denmark
fsantos	mfernandez@example.com	1974-04-29	+55 61 6463-0798	Chácara Lívia da Costa, 82, Vila Piratininga, 71659-300 Jesus / AP	Morocco
qalvarez	jrios@example.com	1997-11-06	532-740-2258x2702	Passarela de Silva, 2, Tiradentes, 84287031 Peixoto / PA	Cambodia
luisacostela	sharon10@example.org	1935-03-27	(230)618-7606x692	Travessa de Fernandes, 1, Vila Do Pombal, 83579-724 Fogaça / RR	Fiji
zbrandt	rrichards@example.net	2010-08-09	+1-980-616-0476x613	53850 Johnson Burgs, West Scott, MD 62800	Aruba
ana-beatriz48	igor85@example.org	1958-02-23	+55 (071) 5663 2009	29375 Williams Stravenue, Erikland, FM 06924	Japan
evanbenitez	matthew45@example.com	1954-08-30	41 0902 0907	Praia Barbosa, 1, Tirol, 25731513 Gonçalves / AP	Fiji
thomas43	mayacostela@example.com	1960-02-29	+1-828-641-4180	Vila Siqueira, 9, Corumbiara, 69298759 Campos / SP	Panama
fogacacecilia	morrisbenjamin@example.com	1957-09-18	11 5882-5622	079 Mark Trail, East Robert, PW 96678	Oman
mia89	courtneygrant@example.net	1982-08-07	(041) 4129 2582	3670 Mclean Centers, Port Michele, PA 50141	Bahrain
pattonchristina	hpeixoto@example.net	1923-03-21	381-821-6064x8922	1651 Russell Stravenue Apt. 756, Wilsonfurt, SC 45839	Haiti
jamesrobinson	shannoncervantes@example.net	2004-09-01	001-410-536-5828x9745	Sítio Nicolas Moreira, 911, Ambrosina, 78153406 Martins do Sul / SC	Argentina
alvesleonardo	paultorres@example.com	1932-01-30	(084) 4407-6179	Feira de Montenegro, 66, Alto Caiçaras, 61478-971 Dias Verde / RS	Poland
jacob37	wgomes@example.org	1910-09-08	343.342.3464x572	733 Smith Corner Apt. 673, West Franciscoborough, GU 64654	Suriname
leaosophie	laurenbauer@example.net	2010-06-05	+55 (071) 9073-1882	0525 Valencia Mountain Apt. 690, Perryland, WA 25428	Gambia
leviduarte	dmiller@example.com	1935-03-31	360-856-0577x6529	Praia Novais, Grota, 66061928 Fonseca da Mata / MA	Mexico
jennifer17	john09@example.org	1949-07-26	+55 (021) 1192 0248	Quadra Peixoto, Monsenhor Messias, 89303266 Novaes / PA	Malawi
alexisball	joaoandrade@example.com	1948-06-25	+1-809-759-5835x030	Esplanada de Costa, Jardim Leblon, 83728-447 Ribeiro / PR	Eritrea
levicardoso	stephanie98@example.net	1940-11-07	+1-961-795-6545x06936	Conjunto Andrade, 46, Nova Cachoeirinha, 48530650 da Cunha / PE	Jordan
jchen	fariasmariana@example.net	1945-06-12	896.473.0114x3916	2626 Stewart Islands, Wallsstad, LA 50874	Guatemala
agathacasa-grande	taylorkathy@example.net	1939-07-28	31 1575 1216	Trecho Ana Lívia Barbosa, 46, Santa Rosa, 77516204 Gomes da Praia / MA	Bhutan
stewartdustin	olivia17@example.com	1982-02-26	(814)527-8806	202 Kevin Shore, Jamesfurt, AZ 22263	Cambodia
jamiereid	garciavernon@example.org	2012-09-08	+55 84 9548 4934	Colônia Garcia, 53, Santa Terezinha, 35344-633 Ferreira / AP	Laos
rfernandes	hadassaramos@example.org	1982-11-03	+55 51 1029 5598	Trecho Isabela Peixoto, 12, Monte Azul, 53415-817 da Rocha / RJ	Singapore
viananoah	luiz-gustavo56@example.org	1917-10-28	+55 (041) 2096-1232	Ladeira Dante Costa, 33, Vila Atila De Paiva, 42269-792 da Rocha / MG	Cambodia
anthonylee	justin40@example.com	1966-01-25	+55 61 7945 8091	330 Mitchell Circle Apt. 170, West Anthony, VA 73344	Brunei
juanmoraes	benicio60@example.com	1974-02-14	+55 (084) 3622-4274	016 Cobb Crossing Apt. 321, North Tonya, DE 29487	Uganda
noah90	luan40@example.org	1958-05-10	001-436-253-1040x99152	Alameda de Andrade, Vila Dos Anjos, 03734509 Ribeiro Verde / TO	Liechtenstein
kamillymoraes	gomesmanuella@example.com	1987-10-22	312-211-4252x4795	2831 Martin Forks Suite 205, West Robert, VT 51906	Taiwan
vegacindy	caue60@example.net	1953-04-22	001-787-754-6262x537	Avenida de Ferreira, 470, Santa Lúcia, 62018854 Costela / PA	Sri Lanka
kevinaparecida	bbaker@example.net	1925-04-07	+55 (021) 8613-2470	36695 Simpson Springs, Scottmouth, NJ 10113	Costa Rica
tammy05	vitor-gabrielmarques@example.net	1985-04-20	84 7723 0904	Largo Pastor, 8, São Jorge 2ª Seção, 52223000 Araújo / PE	Poland
dawnwilson	alexandriahouse@example.net	1945-04-14	001-950-621-5086x58957	8994 Julian Circles, East Ralphshire, MI 61419	Zambia
amy40	nicolasleao@example.com	1984-11-28	(051) 0576-3192	3765 Oliver Loaf Apt. 222, Codyshire, VT 52310	Samoa
andersonashley	poliveira@example.net	2011-10-14	+55 (071) 9052 5224	6231 Christopher Turnpike Suite 565, Josephview, ME 69115	Israel
montenegromaria-clara	omartins@example.com	1930-11-20	984-996-2281x8652	Avenida de Novais, 884, Nossa Senhora Aparecida, 95857060 Peixoto Paulista / MS	Honduras
xpires	claricepires@example.net	1933-04-20	(061) 3129 3996	7129 Daniel Field Suite 928, Brendaside, OH 90492	Trinidad and Tobago
antonellalima	nicolasramos@example.net	2006-04-22	240.323.5080	44183 Reynolds Turnpike, Ellisborough, DC 89328	Yemen
fogacaotavio	maria-isisjesus@example.net	1950-09-14	+55 (041) 1809 2520	746 Luis Islands, East Monica, MN 73858	Brunei
shannon53	dwilson@example.org	1999-07-17	(061) 4263 4687	6550 Schneider Manor Apt. 342, East Sandraberg, DE 21672	Vietnam
angelacrawford	barrosenrico@example.org	1930-10-06	487.639.4313	Núcleo Andrade, 91, Ipe, 86578-126 Cassiano / MA	Morocco
kelly62	dixonashley@example.net	1940-09-23	+55 61 8661 9388	Aeroporto Bernardo Cassiano, Bandeirantes, 58819542 da Costa / MG	Saint Lucia
esmith	pdas-neves@example.net	1941-05-17	11 2715-8698	5148 Williams Crest, East Daniel, FL 95129	Liberia
john01	aragaocatarina@example.org	1967-06-13	+1-709-702-0245x5357	Estrada de Ribeiro, 4, Alto Caiçaras, 05265-010 Borges de Goiás / MS	Hong Kong
annjohnson	zbarbosa@example.com	1918-02-10	001-451-856-5577x45176	23265 Jones Mountain Apt. 752, Lake Carlos, CO 18972	Mongolia
andrejesus	omoraes@example.net	1928-02-18	(061) 4664 1037	412 Smith Courts, New Jefferyton, IL 04788	Botswana
aragaojose-pedro	richard26@example.net	2004-07-05	+55 (041) 6303-3349	209 Richard Mission, Lake Joseph, NJ 39021	United Arab Emirates
daniela52	brooke34@example.net	1928-08-04	(011) 1109-5062	Viela de Cirino, 57, Cachoeirinha, 80969881 da Mata de Brito / MT	Tunisia
juliacampos	karenallen@example.org	1952-04-28	+55 71 8234 3059	Vale Davi Luiz da Mata, 992, Ernesto Nascimento, 23341816 Cirino / ES	Philippines
rachelrobbins	bernardo89@example.org	1969-02-22	+55 61 9159-0917	2632 Kelley Falls Apt. 675, South Lauren, PW 66745	Iceland
aylaoliveira	ramosluiz-miguel@example.com	1949-03-25	0800 035 6098	Estação Mariah Melo, 974, Paquetá, 70213-435 Ferreira / PA	North Macedonia
glandry	nicholasjohnson@example.com	1945-01-05	+55 11 1387 9426	Viela Ribeiro, Conjunto Jardim Filadélfia, 12797447 Garcia / ES	DR Congo
vduarte	wmoore@example.com	1965-08-18	(041) 5437-9550	Alameda de da Costa, 33, Madre Gertrudes, 53764-943 Sampaio do Amparo / BA	Puerto Rico
jbryan	ttyler@example.org	1998-02-04	+1-371-445-4483x9961	8626 Williams Points Apt. 952, Hardinmouth, TX 05528	Iraq
caioda-cunha	ralves@example.net	1917-11-15	+55 11 6515 2427	7698 Kathleen Vista, Michaelberg, CA 75119	Cuba
diogobarbosa	lindaburton@example.com	1977-03-12	839-210-5265x4361	Área de Cavalcanti, 73, Monsenhor Messias, 25888455 Nunes / PI	China
larissapastor	rafaelsantos@example.org	1970-04-27	41 8047-3090	644 Mckinney Square, Michaelhaven, NE 10651	Colombia
stephenspencer	ericksales@example.net	1967-10-17	001-884-899-7576x57337	26393 Underwood Ports Suite 602, North Maria, MA 50505	Cape Verde
andradejoao-pedro	caua08@example.net	1919-04-10	71 9358-8886	Praça Leandro Cavalcanti, 29, Vitoria, 24836-915 Azevedo do Sul / MG	Fiji
laisfogaca	allisonbell@example.net	1958-07-13	(061) 8810-8638	811 Cherry Tunnel Suite 282, Loganport, TN 69345	Vietnam
sarada-cruz	schaeferpenny@example.net	1984-04-19	673.825.9850x4785	Jardim Benjamin Abreu, 99, Aarão Reis, 69335-464 Novais do Galho / CE	Gibraltar
maria-liz37	susan26@example.net	1943-03-20	001-224-886-9577	Quadra de Silveira, 91, Vila Ecológica, 67511-633 Pacheco / SC	Eswatini
melanie96	joshua88@example.org	1996-01-12	842.998.0689	15181 Harding Rapid Apt. 671, Ricemouth, IL 90212	Tonga
naraujo	uramirez@example.com	1966-11-15	9733903855	Lagoa Guerra, Vila Jardim Montanhes, 37814782 Ramos da Mata / DF	Guyana
ustewart	antony40@example.com	1921-02-03	+55 11 5363 8993	Loteamento Pietro da Paz, Distrito Industrial Do Jatoba, 59758426 Camargo Alegre / SC	Guyana
vrodrigues	alicia21@example.net	1987-07-09	+55 81 9114-5606	729 Jodi Roads, Reginafort, IA 70784	Albania
xthompson	larsontodd@example.net	1980-11-02	220.762.6398	Residencial da Mata, 29, Vila Ecológica, 58833-308 Correia / PE	Kyrgyzstan
silvajuliana	ana-carolinada-cruz@example.net	1968-08-15	5925691251	049 Timothy Lakes, South Amy, NV 92393	Russia
teixeiraerick	fallen@example.org	1944-03-21	001-491-792-8631x21264	40796 Harrison Lodge, South Christopherview, WI 91746	Turkmenistan
olivia60	leaoana-beatriz@example.com	2013-02-25	647-272-0217	USNS Fox, FPO AE 92103	Taiwan
cauamoraes	apollo88@example.org	1931-07-09	+55 61 6258-3301	694 Lopez Stream Suite 014, Desireehaven, SC 80672	Puerto Rico
ceciliamendonca	marquesjoao-gabriel@example.com	1927-05-25	5119090181	Pátio de Barbosa, 313, Frei Leopoldo, 76449803 Martins da Mata / AC	Ivory Coast
ucavalcanti	xgonzalez@example.org	1955-04-19	+55 (081) 9656-0304	7374 Snyder Plains, North Eugene, VI 46121	Peru
duartetheo	joelcarpenter@example.net	1940-01-30	318-763-6162x6513	Recanto da Rocha, 92, São Pedro, 40097068 Costa / AL	Suriname
luiz-henriquecampos	cavalcanteleo@example.net	1979-02-06	+55 (081) 3191 1827	364 Henry Freeway, Scottport, SC 04142	Myanmar
ellismaria	clarice46@example.net	1989-01-13	272.843.2649	8483 Justin Pines, South Stephanieside, MI 00929	Armenia
ana-juliaalbuquerque	mperez@example.com	1988-11-13	693.650.2071x57212	366 Richard Village Suite 690, Port Samanthamouth, IN 36876	South Korea
borgesvitor-gabriel	douglasholmes@example.org	1994-05-10	0900-541-9167	Praia Fogaça, 40, Conjunto Celso Machado, 66759-022 Vieira / GO	Cambodia
dda-mata	xgalvan@example.com	1953-08-05	6293669959	22180 Frederick Crossroad, North Jerry, VA 70542	Solomon Islands
vasconceloslaura	hellenaribeiro@example.net	1960-01-12	505.356.0033x406	13970 Powers Port Suite 254, South Mason, NM 16216	Aruba
mouraluiz-fernando	christopher60@example.com	1961-11-10	+55 (011) 7725-2990	Lagoa Liz Fernandes, 50, Parque São José, 86535-207 Marques / PA	Georgia
henry-gabrielaraujo	adamcalhoun@example.net	1936-02-23	371-784-0116	Loteamento Silveira, 28, Frei Leopoldo, 47951287 Fernandes / AP	Cuba
cardosoisabelly	foxtimothy@example.org	1956-04-19	360-261-8468	390 Kathryn Valleys, West William, CT 85882	Angola
selenahudson	azevedodavi@example.net	1938-02-16	+1-280-981-8936x4280	Viaduto Câmara, 463, Providencia, 89732-639 da Cruz / MT	Brazil
wendy93	nicholaschung@example.com	1984-09-16	+1-584-811-8567x01056	821 David Park, North Michael, WA 35290	Gambia
ana-laura92	jessica93@example.org	1924-11-17	0500 033 2921	1570 Drake View, Andrewborough, MN 94501	Iceland
portojoao-guilherme	harry43@example.com	1981-07-24	486-812-8484	USNV Wright, FPO AA 88528	Vietnam
nicolasmonteiro	cingram@example.net	1941-04-26	206-243-8082x174	Campo Ana Lima, Beira Linha, 28047-185 Nunes / RO	Bosnia and Herzegovina
pirestheodoro	nicoleferguson@example.org	1940-08-18	+1-528-407-9845x11720	PSC 2793, Box 9699, APO AP 87021	Tajikistan
vargascalvin	imendonca@example.org	1983-09-03	(021) 1294 1893	Praia Câmara, 336, Caiçara - Adelaide, 23320-593 Barbosa da Mata / ES	Kazakhstan
selenapowell	diazcarolyn@example.net	1944-11-08	+1-804-300-4040x50025	68005 Bartlett Street Apt. 902, North Tracyfort, DE 18607	Indonesia
silveirabreno	rafaela30@example.com	1995-03-08	996-219-3695	Conjunto de Rocha, 37, Vila Primeiro De Maio, 82721941 das Neves / GO	Denmark
michael61	gabriela92@example.org	1955-04-06	001-595-261-7522x855	76115 Barbara Pines, Danielbury, HI 02110	Samoa
leticia48	lmacedo@example.net	1988-10-01	(061) 0217-2979	Quadra das Neves, Canaa, 48874-150 Melo de Costa / PE	Bhutan
joana28	acampos@example.net	1935-01-04	212-472-5772x49057	Aeroporto Caio Nunes, 5, Prado, 04477782 Câmara do Oeste / ES	Qatar
danielaaparecida	amber26@example.com	1945-07-31	0800 420 3897	Aeroporto Correia, 483, Dom Bosco, 26679-702 Almeida / DF	Aruba
nascimentorafaela	leroyhall@example.com	2013-10-24	(643)892-6612x76321	Alameda Eloah Barros, 13, Vila Nossa Senhora Do Rosário, 80905-944 Marques Verde / GO	Mauritius
spinto	da-rosaleo@example.org	1962-12-28	51 3603 9257	Recanto de Camargo, 1, Atila De Paiva, 38562-977 Cunha / TO	Morocco
halexander	ebarros@example.net	1962-05-10	21 0633-1977	Rua de Casa Grande, 22, São Jorge 3ª Seção, 04913-915 da Cruz / MG	Libya
nribeiro	sanchezjoseph@example.net	1920-01-23	396.336.1903x876	695 Palmer Curve, Simonmouth, MS 63308	Mauritius
lcarvalho	dnunez@example.org	1993-05-29	001-857-338-4778	75829 Bowers Radial Apt. 670, West Jennifer, PR 85588	Niue
nolanderek	zkerr@example.net	2004-10-06	975-385-6373x4241	Distrito Vitor Hugo da Costa, 5, Mirtes, 38871337 Cirino do Oeste / RS	Central African Republic
lara09	sarah89@example.com	1964-10-21	001-702-365-8909	61425 Perez Station, Donnachester, NM 90127	Turkmenistan
perrypatricia	qrobinson@example.net	1958-12-16	001-450-500-0418x81677	36233 Brown Lodge, East Angela, AS 83165	Vietnam
ashleymonica	jeffrey30@example.com	1984-08-03	(669)667-4811x402	6264 Beard Port, West Andrew, CA 50167	Albania
jmoraes	pdas-neves@example.org	1973-04-06	+55 (021) 1257 6613	Largo Alves, 86, Buritis, 51238541 Alves do Campo / SE	Armenia
maria-clara70	heathergomez@example.com	1992-06-09	001-842-919-3910x727	Jardim Zoe da Mata, Santa Rita De Cássia, 82866693 Novaes do Sul / ES	Saudi Arabia
vinicius63	kennethsmith@example.net	1917-07-03	51 4740 9047	455 Reginald Highway, Port Sarahbury, FL 86034	China
tony70	ischneider@example.net	1948-09-24	+55 (051) 9783-7855	63154 Jill Brook, West Andrew, IL 03604	Turkmenistan
souzadavi-lucca	teixeiramariane@example.net	1990-02-21	84 9090 4449	Passarela Matheus Souza, 135, Santa Rosa, 53498-513 Mendonça / ES	Madagascar
ashley09	leaoemanuelly@example.com	2005-07-16	001-456-294-1871x606	7977 Alexander Springs, South Ivan, NC 25811	Western Sahara
alex55	esouza@example.com	1913-11-21	+55 (084) 9237 9929	227 Spears Via Suite 905, Port Jasmine, KS 07551	Mauritius
brenocardoso	sampaiosofia@example.org	1977-07-29	(453)981-9542x0856	PSC 0941, Box 6691, APO AA 11293	Zambia
da-pazisaac	lisafisher@example.com	1944-09-24	+55 61 3657 8998	840 Jessica Shoal Suite 621, Port Kellyfurt, LA 17035	Uganda
luisadias	hannah30@example.com	1970-04-17	(338)666-9757	Estrada Ribeiro, 75, Serra, 85429613 da Cunha / AM	Poland
laraborges	uyoung@example.net	1950-04-19	+55 31 1460 6383	Vila Josué Nogueira, 10, Barro Preto, 06766798 Cardoso Alegre / RN	Guinea
harrisondaryl	oconnoralex@example.org	2002-05-16	51 3443 2056	Unit 9111 Box 1482, DPO AA 10757	Barbados
marianenovais	nrivera@example.com	1919-07-04	+55 (011) 1031 2330	938 Robinson Ford, North Daniel, MD 92252	Taiwan
charles51	suzannehunt@example.com	1924-02-18	(612)837-1631x43472	Vereda João Lucas Azevedo, 3, São Cristóvão, 43297352 Pinto / RR	Seychelles
jwebb	aprilhuffman@example.com	2002-12-30	(917)613-9509x886	125 Donald Park Suite 033, South Anna, CT 12382	Colombia
guzmankendra	allana48@example.com	1972-04-04	+1-471-545-5252x25057	Trevo Luana Jesus, 7, Santa Cecilia, 86096-401 Gonçalves / PI	Suriname
chasewest	brenda01@example.org	1914-06-20	001-242-352-9556x56018	PSC 0255, Box 7854, APO AE 35739	Botswana
limapietra	oconnorkatherine@example.org	1992-05-13	21 5596-2275	Via Theodoro Martins, 197, Conjunto Lagoa, 36713-457 Sales dos Dourados / RR	China
aurora71	ycostela@example.org	1955-12-23	+55 (041) 9620 4925	Via Cavalcanti, 71, Saudade, 07181014 Monteiro do Sul / TO	Haiti
vbaker	lgarcia@example.com	1928-06-18	+1-557-882-2611x7412	Distrito Sales, 47, Baleia, 29737-129 Silveira / RJ	Maldives
rochaallana	cfogaca@example.org	2009-02-11	+1-568-491-6627x61248	Chácara de Teixeira, 252, Lagoinha, 08168-296 Castro dos Dourados / MA	Namibia
osmith	mendesasafe@example.net	1929-07-14	(844)786-8704x462	Aeroporto de Gomes, 22, Madri, 75102453 Duarte da Mata / CE	Saint Helena, Ascension and Tristan da Cunha
nhill	daniel88@example.org	1965-01-31	254.773.7611x2258	1490 Ortega Lock, South Dianatown, AK 10447	Albania
silveiramaria-luisa	allana58@example.org	1955-07-01	476.225.5152	Morro Vasconcelos, 51, Vila Copacabana, 33517755 Costa / SE	Hong Kong
amberward	christinewoodward@example.org	1971-08-12	+55 21 8734 7755	Morro Diego Albuquerque, 15, Jardim Montanhês, 78118-412 Teixeira / RJ	Azerbaijan
parkerhughes	fda-cunha@example.com	1935-03-18	+1-421-706-1482x03428	Viaduto de Macedo, 19, Engenho Nogueira, 79094-721 Vieira Alegre / GO	Afghanistan
allisongates	wilsoneric@example.com	1983-11-22	375-479-7031x7359	4122 Sarah Union, East Leahton, UT 70121	Zambia
rodrigoda-mata	peixotohenry-gabriel@example.net	1985-04-11	+55 (081) 8941 3348	00939 Smith Field Suite 545, Hodgeville, PW 12776	Azerbaijan
wvieira	souzayasmin@example.net	1984-08-24	583.461.0670x9250	USNS Murillo, FPO AA 67723	North Macedonia
vcasa-grande	ncosta@example.org	1999-08-04	899-443-3684	Setor Lucca Marques, Vila Paraíso, 33296-880 Vasconcelos do Campo / MS	Costa Rica
luiz-gustavomendonca	alexandremarques@example.net	1917-09-13	(936)733-7179x34692	492 Contreras Course Suite 402, Jeffreybury, MI 86034	Kyrgyzstan
vitoria02	rhodeskristy@example.com	1949-08-12	+55 (051) 8976-2607	24149 John Canyon, East Kyle, FL 91761	Belize
bbrown	araujoana-clara@example.net	1939-01-20	8863887099	Núcleo de Cassiano, 477, Califórnia, 37817392 Lopes das Flores / GO	Sweden
xjackson	jasongarner@example.net	2009-02-08	+55 (031) 4935-0724	0119 Jensen Run Suite 992, West Laurastad, RI 91250	Myanmar
genemills	regina48@example.com	1989-06-02	+1-821-254-7788x826	53570 Gary Locks Suite 179, New Virginia, OH 85571	Ethiopia
vfogaca	imelo@example.org	1934-01-18	(084) 3648-4999	117 Rose Village Apt. 770, Lake Lisa, CA 52898	Rwanda
barbara70	olivia95@example.org	1953-03-31	(427)774-0943x93511	188 Rebecca Manors, Tamaratown, MH 14053	Peru
huberricky	alexmartinez@example.net	1953-06-14	598-762-1150	Conjunto Fernanda Pereira, 19, Bonsucesso, 01963-837 Gomes de Goiás / TO	Cambodia
natalia47	peter95@example.com	1980-07-25	+1-637-822-3653x3238	072 Jonathan Glens, New Donaldview, PW 80772	Eritrea
rezendeemanuel	vinicius01@example.net	2004-10-13	001-531-972-5511x427	Via de Sá, 932, Belmonte, 38981-313 Freitas / AM	Western Sahara
brianford	aparecidaagatha@example.org	1991-06-29	(011) 9262 4798	Esplanada Caldeira, 39, Pilar, 26409-032 Andrade Alegre / RS	Samoa
ecampos	jacob55@example.net	1989-07-06	81 5381-9126	359 Bartlett Divide Suite 783, North Lori, MO 23467	Lebanon
barbarada-paz	matthewmendoza@example.org	1992-12-14	837-877-0255	Recanto Cavalcanti, 49, Vista Do Sol, 04546-461 Souza / AC	Albania
cassianomariane	ana78@example.net	1930-10-09	+55 (011) 0061 5188	80888 Snyder Trafficway, Stevenfurt, FM 13219	DR Congo
ikoch	ana-julia60@example.org	1929-10-26	41 1784-3697	07362 Chloe Ridge, Lake Nancy, NH 58726	Uganda
emanuellafogaca	allisonjones@example.org	1983-02-12	+55 11 8025 9062	9378 Ronald Coves, Michellehaven, MD 57316	Philippines
augustocirino	barbara97@example.org	2005-07-19	+55 51 8265 0588	Pátio da Cruz, 54, Vila Da Luz, 66442880 Garcia Alegre / PI	Bosnia and Herzegovina
richardsondonald	cookcristian@example.org	2009-05-22	(081) 1390 7357	745 Rachel Walks Suite 081, Hernandezburgh, PA 16997	Libya
knappnathan	jesusmarcelo@example.org	1926-07-08	51 4203 9486	Alameda Maria Flor Viana, Conjunto São Francisco De Assis, 90218332 da Cunha / DF	Cuba
agonzales	monteirolavinia@example.org	1930-01-21	001-734-662-1453x830	54782 Harrington Land, Port Ricardoburgh, DE 35503	Laos
augustofreitas	joao-gabriel94@example.org	1931-08-19	51 5016 9546	4936 Jennifer Manor Suite 709, Megantown, VI 40279	Trinidad and Tobago
yago30	catarina01@example.net	1927-09-20	427.912.4017x131	PSC 1464, Box 2019, APO AP 76662	Yemen
cavalcanteevelyn	cassianoisaque@example.org	1985-12-10	(071) 7256-0869	07400 Shaun Mission, South Debbie, KY 09834	Serbia
goncalvesluiz-felipe	isabelacampos@example.net	1986-09-20	84 6510 3003	Trevo de Sampaio, 6, Dom Cabral, 04990367 Vieira / RR	DR Congo
richard70	maria-helena28@example.net	1958-06-08	001-632-999-0091x021	9749 Smith Key, Brittanymouth, ID 23166	Botswana
igorcamara	enzo97@example.com	1922-08-26	7467038406	Núcleo Theo Fonseca, 82, Teixeira Dias, 25219-025 Cirino / BA	Poland
cgarcia	joneswilliam@example.net	1942-05-08	21 6078 4214	487 Ryan Parkways Apt. 553, Gonzalezhaven, MN 21870	North Macedonia
james07	yjames@example.net	1978-01-22	+55 11 9200-9278	USS Griffith, FPO AE 09888	Burundi
da-motajoao-miguel	rezendecarlos-eduardo@example.net	1919-05-12	358-962-9424	Ladeira Souza, Vila Satélite, 86129307 da Cruz de Montenegro / SE	Solomon Islands
davidguzman	ester14@example.net	1970-12-09	(071) 5599-2963	660 Alvarado Unions, South Danielle, ID 01936	Trinidad and Tobago
ovalencia	robinsondennis@example.net	1926-08-26	+55 11 3814-0655	1672 Melissa Well, Lake Williamville, TN 80369	Tajikistan
kfreitas	francisco91@example.com	2009-11-20	+1-468-258-7872x93381	Trevo Ribeiro, 51, Juliana, 16030298 Duarte / TO	Lebanon
laismartins	mendesdavi@example.org	1950-06-06	84 3624-9326	50971 Jacob Hill, Johnsonshire, NC 71436	Gibraltar
fsutton	vasconceloseloa@example.org	1941-11-16	7678874713	441 Sawyer Garden, Port Sierra, MP 35843	Sweden
pireseduardo	bboyd@example.com	1941-04-23	(021) 0332-3635	62148 Hanson Viaduct Suite 482, Hillbury, MH 17151	South Korea
pnunes	michelleatkins@example.net	1994-02-21	(495)949-3529x06988	359 Williams Hollow Suite 231, North Benjamin, FM 14513	Liberia
andreamayer	williamholland@example.net	1946-12-17	(084) 7176 5376	8339 Ricardo Port, Millsmouth, MT 56870	Somalia
gaelcosta	jillsweeney@example.com	1954-05-21	71 6786-3868	Loteamento Ísis Siqueira, Copacabana, 27204-642 Pereira de Câmara / AM	Seychelles
maria-flor68	lopesmatteo@example.org	1994-02-10	81 1228-7278	Morro de Cavalcanti, 241, Candelaria, 17337621 Borges / AC	Lesotho
lawsontony	sydneybarr@example.com	1919-09-29	981.705.0673x98495	Condomínio Gael Henrique da Rosa, 792, Campo Alegre, 77645698 Brito de Almeida / MS	Hong Kong
joaquim75	ceciliafogaca@example.net	1979-04-05	+55 (084) 3888 9124	Largo de Nunes, 79, Novo Aarão Reis, 60647-790 Cassiano da Prata / AP	Bangladesh
silveiramatheus	philip37@example.net	1945-06-28	61 0178 7060	Viela Viana, Vila Piratininga, 24732119 da Cunha de Cavalcante / BA	Western Sahara
jamesronald	souzajoao-miguel@example.com	1919-02-08	(061) 8155-0061	17302 Oneill Club, Amandaborough, IL 46435	Serbia
cavalcantealexia	elizabethfernandez@example.net	2012-08-11	(011) 2282 4878	Avenida Sales, 787, Renascença, 21752-248 Costela do Sul / TO	Bahamas
ana-julia70	gpollard@example.com	1944-05-28	+1-516-691-8994x388	Largo Nina da Mota, 26, Tirol, 34801-624 das Neves / AC	Laos
rochaluiza	ravy19@example.net	1928-03-08	001-684-829-0082x65568	Unit 8777 Box 5245, DPO AA 34954	Saint Helena, Ascension and Tristan da Cunha
bcavalcanti	pgraham@example.org	1912-04-04	+1-239-216-2705x61869	Largo Evelyn Abreu, 61, Jardinópolis, 13380-576 Sousa / BA	Tonga
isaac37	cardosoenrico@example.net	1964-07-29	837-694-2551x958	4562 Mcdowell Manor Suite 066, Alvarezton, AS 49397	Zambia
allisonparker	augustosa@example.org	1955-09-03	+55 (031) 8742-0735	Parque de Borges, 90, Vila Cemig, 92286-832 Alves das Flores / RN	Wallis and Futuna
asafe18	washingtonmichael@example.org	1945-12-01	51 2985 5038	Passarela Santos, 3, Apolonia, 40319-139 Novaes / PR	Ghana
ana-beatrizjesus	claraaraujo@example.com	1912-01-10	(321)254-1244x82416	Via de Garcia, 48, Ermelinda, 84440866 Montenegro / CE	Haiti
montgomerytiffany	bruno82@example.com	1938-03-02	(384)465-4847	8561 Nicole Falls Suite 058, North Vanessa, RI 70374	Russia
gpeixoto	amanda91@example.org	1994-11-29	+1-525-671-1829x4120	Unit 1115 Box 0280, DPO AA 68108	Vietnam
bellis	barrosdavi@example.com	1952-09-08	330-741-2869x83580	Distrito de da Costa, Vila Suzana Segunda Seção, 92313152 Martins de Minas / DF	Iran
barrosluigi	davivieira@example.net	2006-07-05	0900-177-5130	Vila Sousa, 191, Mangabeiras, 15898-914 da Mata das Flores / MG	Myanmar
rebecca87	alana62@example.org	1991-02-13	41 7515-7139	Estação Maria Clara Fogaça, 90, Vila Da Paz, 23513069 Costela / SC	Uganda
isabela78	ryanchristopher@example.net	1920-11-06	31 5393 1330	Loteamento de Leão, Marilandia, 45887710 Viana do Sul / PR	Tunisia
williamsraymond	martinhaley@example.org	1993-10-18	+1-791-862-5386x256	Trecho de Cavalcante, 444, Comiteco, 92630673 da Cunha do Amparo / MG	Nicaragua
giovanna84	levineruth@example.com	2011-09-15	+55 (051) 0132-9026	23037 Kelly Road, Davidfort, AS 89444	Gambia
wmoraes	rebeccaellis@example.net	1992-04-25	41 4889 9083	Favela Sofia Moura, 95, Flamengo, 37255-939 Ferreira do Oeste / RJ	Bosnia and Herzegovina
ferreirasarah	garciaelisa@example.com	1921-03-17	579-514-9127x1464	Trecho Caroline Fogaça, 3, Aparecida 7ª Seção, 20254734 Costela da Serra / PA	Denmark
daviswilliam	ana-beatrizleao@example.net	1942-04-27	632.368.1574x45503	8174 Kenneth Via, Carolinehaven, OH 09989	Mexico
matheus66	erios@example.org	1963-05-02	+55 41 5431-3466	928 Bush Creek Suite 994, West Tracey, FM 61316	Madagascar
garciajamie	shirley32@example.net	1913-04-01	(031) 5184-2976	5800 Amy Bridge Apt. 184, Whiteside, AZ 52915	Guatemala
blawson	pmelo@example.org	2001-10-04	+55 31 8409-1625	Favela Ana Julia Camargo, Santa Rosa, 33752-540 Sales dos Dourados / AM	Belize
brent19	scasa-grande@example.com	2010-11-22	(494)978-1425x846	USS Foster, FPO AA 57544	Ghana
michaelreyes	austin36@example.net	1957-08-25	001-513-953-9001x63016	Pátio Henry Viana, 80, Sport Club, 87844-883 da Cunha / SP	China
pollardcarla	melissa54@example.net	1995-03-12	(081) 6146-5396	653 Mathis Roads Apt. 824, Elaineshire, MP 96874	Saint Lucia
patricia01	omendonca@example.org	1954-12-10	205-263-0676x2880	Praça Nogueira, 35, Novo Glória, 24493597 Abreu / AC	Guinea
alananovaes	ortizpaul@example.net	1946-09-20	(440)918-0279	Praia de Jesus, 631, Nova Suíça, 40276-430 Almeida / MT	North Korea
qguerra	isadoradias@example.com	1918-09-27	(021) 8960-0737	Rua Teixeira, 81, Vila Nova Cachoeirinha 1ª Seção, 47507479 Nascimento da Praia / CE	Cayman Islands
liz59	mcclainamanda@example.net	1976-03-24	494.487.5003x540	Vale Souza, 443, Confisco, 13596111 Duarte de Cavalcanti / RR	Tonga
valentinamarques	bwilson@example.org	1982-02-01	(541)619-9415	56476 Bolton Locks, Hayesshire, NE 04140	Russia
gonzalezmark	nconner@example.org	1984-11-18	533-936-6898x635	Avenida de Peixoto, 37, Nova Suíça, 82259-882 Ferreira / MT	Moldova
grahamtravis	davispeter@example.com	1922-01-28	0800-144-9206	Unit 7248 Box 1990, DPO AA 30255	Namibia
jessica41	luiz-fernando95@example.com	1992-02-16	+55 (021) 3160 2482	600 Daniel Key Suite 944, North Karla, VT 90241	Guinea
marcelapimenta	kimberly83@example.com	1912-09-22	+55 (021) 3612 2302	878 Allison Ports, East Carrieland, NM 54796	Myanmar
joao73	donna18@example.org	1934-12-04	(041) 7976 3566	305 Sanchez Drive, Port Colin, MS 36019	Thailand
vsteele	steven72@example.org	1956-10-24	+1-353-758-9721	Fazenda de Sampaio, Centro, 56001-263 Viana do Galho / SC	Philippines
ucamargo	qcirino@example.com	1913-12-03	+55 (061) 4235 4543	Pátio da Paz, 73, Santa Amelia, 95209531 Moura / SC	Gambia
saraujo	paulalee@example.net	1983-06-17	+55 (084) 7104 3081	Favela de Fonseca, 31, Jardim Vitoria, 29193879 da Costa / MS	Fiji
cunninghamerin	vitor-hugo39@example.org	1928-06-04	7182393203	886 Stephanie Via Apt. 403, North David, VA 86744	Liechtenstein
cgentry	duncandaniel@example.com	1946-02-11	+1-366-210-5614x277	Rodovia Ana Luiza Montenegro, 95, Caetano Furquim, 82040868 Viana / PA	Madagascar
felipe56	yduran@example.net	1939-07-22	(496)936-4144	Residencial Albuquerque, 819, Santa Rita, 40139068 Cavalcanti do Campo / RS	Kenya
salesjoao-felipe	jessica41@example.com	1982-04-06	001-905-850-6684x8961	Via Almeida, 439, Novo Santa Cecilia, 85526123 Alves de Pacheco / RN	Trinidad and Tobago
mariaferguson	alana32@example.net	2012-07-09	+55 (011) 9589-0108	USCGC Patel, FPO AA 54720	Eswatini
ahernandez	fernanda71@example.com	1920-01-20	+55 (071) 4814 5522	Via José Pedro Caldeira, 59, Santa Terezinha, 84408776 Borges Alegre / SC	Laos
ada-mata	millerjohn@example.org	2011-02-24	+55 71 2849-5279	Passarela de Guerra, 4, Camponesa 1ª Seção, 25402-268 Lima do Oeste / RO	Colombia
dturner	pmacedo@example.org	2004-05-31	51 8330 1064	621 Morrow Vista, South Rebecca, NJ 41533	Uzbekistan
agatha30	isampaio@example.net	1949-08-23	+55 (084) 5934-1743	Aeroporto Pedro Cunha, Ribeiro De Abreu, 15045407 Araújo / MG	Guinea
ycavalcante	xvargas@example.net	1987-02-28	220-290-8404	USNS Duke, FPO AP 33576	Angola
saluna	manuellaaparecida@example.net	1946-08-02	+55 31 5841-7022	Estação de Almeida, São João, 61591-783 Ramos / ES	Bahrain
raquelmoraes	ariel52@example.net	1987-05-31	(051) 5347 3772	Vila Daniela Rezende, 79, Mariano De Abreu, 36410239 Vieira / PB	Singapore
christopher74	watsonphillip@example.org	1976-12-09	960-762-0241x4165	Vereda Gael Henrique da Mata, 16, Nova Floresta, 39602-389 Barbosa / ES	Chile
uhill	sally22@example.com	1942-10-03	228.814.7387	72233 Debra Mews Suite 981, South Martha, CT 73529	Tunisia
ecastro	fogacarodrigo@example.net	1974-04-03	+1-573-735-0061	6993 Brittany Pike, Kimshire, ID 17184	Panama
beniciocostela	taragonzalez@example.com	1950-11-08	(479)436-8295x8578	8442 Whitney Spur, New Steven, NC 14301	Sudan
ravy80	schwartzrebecca@example.net	1933-11-05	41 9380-1572	64727 Rodriguez Lights Apt. 513, West Patrick, UT 62525	Trinidad and Tobago
theodoro77	audrey19@example.net	1931-09-08	(071) 6784-6491	Recanto de Aparecida, 1, João Paulo Ii, 84732-974 Freitas da Serra / RJ	Japan
rael18	da-luznoah@example.org	1968-11-18	+55 (041) 7585 8431	203 Wilson Inlet, East Lisa, FL 90827	Puerto Rico
brayan94	dariuscalderon@example.net	1941-02-08	+55 11 7697 6757	1604 Johnson Wall Apt. 034, New Courtney, NC 36292	Belize
udawson	pam76@example.com	1919-11-29	(084) 5566-7550	Quadra de Macedo, 26, Santa Inês, 51969-786 Farias / RN	Hungary
joliveira	iboone@example.org	1993-03-23	001-257-685-8630x8868	Vale de da Cunha, Vila Satélite, 45430-135 Costa Alegre / RR	Solomon Islands
johnsonbrittany	cauejesus@example.org	1997-09-21	+55 (011) 4030 4608	834 Walker Springs Suite 528, Trujillomouth, UT 79315	Mozambique
mariahcostela	marcela63@example.net	1938-08-12	(084) 5813-8409	391 Robin Trafficway Suite 270, Steventown, NM 13645	Bangladesh
jeffchavez	harmonderek@example.org	1953-03-21	408.794.0658x61105	Travessa Caroline da Rocha, 31, Serra Do Curral, 78331-478 Cavalcanti de da Cruz / SC	United Arab Emirates
hpatterson	melissajackson@example.net	1976-05-07	+55 41 7672 0102	PSC 2309, Box 4192, APO AA 03814	Aruba
anna-liz23	robbinscatherine@example.com	1922-01-03	378-304-0847x16628	Recanto Kamilly Araújo, 21, Vila Maria, 37315-561 da Conceição / SP	Laos
coxjeremiah	da-luzana-clara@example.net	1999-06-01	344.385.4220x66869	Favela Calebe da Mota, 77, Vila Santa Monica 2ª Seção, 99230125 Silva Grande / CE	Afghanistan
kellyblackwell	ischroeder@example.net	1986-10-20	642.567.1110x012	Viaduto Maria Helena da Mata, São Damião, 26160787 Lopes / PB	North Macedonia
ann11	luiz-otaviomontenegro@example.org	1942-05-20	41 3104-6738	Ladeira de Rezende, 1, Madre Gertrudes, 63899896 Marques / PE	Mexico
silvadavi-luiz	da-conceicaomaria-flor@example.org	1949-01-25	(205)573-0530	Avenida Cardoso, 3, Vale Do Jatoba, 40093378 Oliveira / SP	Uzbekistan
nogueiracatarina	richard98@example.org	1982-04-24	339-601-8814x073	3966 Jackson Forks Apt. 594, West Josefort, MP 27591	Moldova
pedro58	nicole12@example.org	1955-06-25	7254962471	Lagoa de Câmara, 677, Vila Barragem Santa Lúcia, 74684730 Nogueira da Prata / PB	Trinidad and Tobago
ucunningham	sousapedro@example.com	1967-02-27	21 5566 1697	4659 Gregory Lake Apt. 498, Robertland, PR 22686	Bosnia and Herzegovina
davimendes	stevenmclaughlin@example.com	2011-09-26	41 7785 6701	PSC 9071, Box 8269, APO AA 38039	Paraguay
laura43	sophiada-mata@example.com	1922-11-22	41 3377-6031	Morro de Costa, 67, Olaria, 64678091 Brito / PE	Saint Lucia
goncalvesravi-lucca	amelendez@example.net	1936-11-28	+55 (011) 2088-6145	Unit 1831 Box 3975, DPO AE 77214	Saudi Arabia
john55	graykathleen@example.org	1959-04-10	(084) 9849 9560	9863 Adrian Garden Apt. 638, Jamesland, MN 69271	Costa Rica
vholloway	claricecastro@example.org	1957-09-30	959.270.8410	9764 Ellis Crossing, Lake William, HI 11381	Trinidad and Tobago
vitor-hugomoura	fnunes@example.net	1984-08-25	+1-651-874-2956x5009	014 Joshua Streets Apt. 842, Wallacestad, IL 31012	Singapore
caroline07	perezwilliam@example.com	1971-10-18	882-213-0360x5887	725 Mary Ranch, Moralesville, HI 46514	Seychelles
bento49	luisa60@example.net	1933-09-08	(084) 0978-1609	Campo Pastor, 86, Grotinha, 68044-333 Ribeiro Grande / CE	Bangladesh
habreu	susan76@example.com	2003-11-30	001-480-973-6122	PSC 5427, Box 1426, APO AP 49814	Singapore
xcastro	sabrinacampos@example.net	1961-02-19	821-467-9707x415	Largo Ana Dias, Santa Rita De Cássia, 61068679 Viana / MA	Argentina
vitoria42	estherjesus@example.org	1956-07-21	+1-925-696-0510	Colônia da Mota, 360, Vila Copasa, 29522991 Guerra de da Costa / ES	Armenia
ymachado	brian66@example.net	1996-07-03	690.405.4883	Praça de Cassiano, 743, Estoril, 27644-717 Marques / TO	Saint Lucia
vitoria11	mariah23@example.com	2007-12-24	9186386360	Estação de Camargo, 53, Marajó, 20132-234 Gonçalves / RO	Bahrain
danielafernandes	leonogueira@example.com	1913-09-30	877-741-8484x10459	Parque da Paz, 677, Dom Joaquim, 68380111 Gonçalves da Praia / AP	Iraq
cmoura	morsekari@example.com	1921-01-22	001-327-277-4339	Morro de Cirino, 8, Cruzeiro, 92974178 da Cunha da Mata / SE	Libya
heitorpacheco	deborah64@example.com	1972-08-23	(011) 1926 2676	Viaduto Ryan Correia, 9, Padre Eustáquio, 88352-829 Sá dos Dourados / TO	South Korea
fmoore	matthew48@example.com	2008-03-31	0800 519 3951	954 Fowler Common Apt. 051, South Jessicamouth, AZ 96828	Japan
jacob02	amber59@example.net	1948-06-04	581.869.2857x6838	Largo de Ribeiro, Cenaculo, 70312555 Azevedo de Vieira / TO	Samoa
asafe09	pattersonkeith@example.com	1977-03-15	+55 (061) 7047-2123	4944 Robert Divide Apt. 359, Samanthastad, NH 89575	Honduras
jfonseca	estermartins@example.com	1933-12-12	+55 61 8110 9748	952 Hopkins Mews, Cherylfurt, KS 26508	Oman
kpastor	hhernandez@example.net	2001-11-08	+55 41 6595-1529	Travessa Theodoro Fonseca, 604, Xodo-Marize, 95287-958 Lima / PR	Nicaragua
kathryn29	da-cunhamariana@example.org	1932-03-16	21 0426 0776	Lago de Sá, 200, Vila Paraíso, 63853-314 Pacheco da Praia / PE	Saudi Arabia
isisguerra	stephanie28@example.org	1942-05-06	+55 61 6941-8526	Vila Anthony Gabriel Moreira, Das Industrias I, 51441-671 Araújo / ES	Mauritius
aparecidadanilo	james32@example.org	1944-04-16	+55 (041) 9794 4613	Via Emanuel Moura, Aeroporto, 35470-739 Fonseca das Flores / MT	Libya
utucker	floresjoel@example.com	1987-07-28	279-969-9096	6873 Allison Square, Thomasfort, FL 83867	Bulgaria
morganmichael	taragao@example.com	1970-06-22	0500 624 7030	7890 Emily Walks, Hicksfort, MO 41243	Cape Verde
eric43	juliabarros@example.org	1982-01-17	+55 (071) 7211-5493	0115 Hughes Rapid, North Brentmouth, AL 17113	Namibia
stacy63	sara66@example.net	1946-09-02	+55 (011) 3457 4738	Vila de Pires, 96, Jaraguá, 21524-736 Moraes da Prata / AC	Western Sahara
jonathan10	ayalachristina@example.net	1915-04-05	+1-694-936-1846	87474 Justin Run, North Alvin, OK 90816	Tajikistan
apollo05	barbara37@example.net	1921-06-18	+1-255-758-4041x28517	9559 Susan Field Suite 380, New Michael, NH 88809	Sudan
kcarvalho	brandy30@example.com	1966-02-17	0300 326 9511	Vale de da Rosa, São Vicente, 19641-975 da Rosa / RN	South Korea
lvasconcelos	katherineritter@example.com	1989-09-23	+1-320-463-0448	Estação Rhavi Cirino, 7, Nova Granada, 86654907 Fernandes do Sul / MA	Jordan
margaretrodriguez	da-costaisis@example.org	1988-12-08	84 6560 7202	Loteamento de Costela, 29, São Gonçalo, 44130-386 Rios de Nunes / CE	Israel
ruth68	qrichmond@example.com	1967-06-26	61 6994 1768	Colônia Alice Casa Grande, 36, Heliopolis, 22673515 Cardoso / AM	Mauritius
dfigueroa	christopherreilly@example.org	1939-03-12	621.830.3551x45605	635 Darius Garden, Heatherfurt, MD 82604	Panama
christian27	brianna16@example.org	1927-02-06	825.597.6683	PSC 2257, Box 4582, APO AP 16813	Uzbekistan
ian16	murilosampaio@example.net	1947-10-22	61 9792-1683	Vila Moraes, 74, Novo São Lucas, 86720615 Jesus da Mata / BA	Nicaragua
marianedas-neves	fparsons@example.org	1931-08-22	(605)896-8744	33245 Juan Locks, East Andrea, AS 84863	Lebanon
fprince	iviana@example.com	1932-10-04	(463)683-3562	93034 Ramirez Pine, Tamaramouth, VA 49719	Guyana
gilberttimothy	cindymyers@example.com	1986-05-01	(583)715-0131x7605	85748 Murillo Avenue Suite 810, Jacksonfort, MH 70909	Lesotho
elliskeith	xwagner@example.org	1928-05-27	+55 41 0388 1266	Vale de Abreu, Cabana Do Pai Tomás, 38153-688 Pastor de Silveira / SC	Sweden
icamargo	thomascourtney@example.org	1990-10-07	+55 (011) 7489-2146	Fazenda Cavalcante, Confisco, 59751155 Gomes do Galho / PA	Bangladesh
melissasilva	harrisjorge@example.org	1972-01-14	001-540-332-6302x7451	Distrito Fogaça, 88, Cachoeirinha, 14958392 Melo / RJ	Mauritius
patricia41	jonathandavis@example.org	1943-03-10	398.532.5380	5505 Kenneth Spur Apt. 631, Lake Michaela, OH 95041	Kuwait
costamaria-laura	maria-ceciliafogaca@example.org	1928-01-28	(081) 8482-2985	05687 Paul Villages Suite 391, Lake William, DC 37089	Paraguay
lisaallison	msa@example.net	2013-07-24	0300 838 6657	783 Love Junctions, Hernandeztown, GA 23768	Solomon Islands
arthur-gabriel49	susan62@example.net	1998-12-06	+1-771-407-3510	PSC 8249, Box 2018, APO AA 41633	Philippines
pereztracy	qda-rocha@example.org	1990-03-02	4147683334	Feira Siqueira, 3, Serra Do Curral, 76553-118 Rodrigues de Minas / BA	Guinea
moraesheloisa	ida-costa@example.net	2012-11-17	470-987-7681	PSC 7857, Box 1854, APO AA 86308	Bosnia and Herzegovina
arthurlopes	figueroajonathan@example.org	1956-11-28	+55 (031) 2608 2270	786 James Curve, South Timothymouth, WI 91067	Saint Lucia
hmullins	ngarner@example.net	1911-10-07	362-587-5698	Estação de Ferreira, 79, Mantiqueira, 99448-309 Sousa Alegre / RO	Uzbekistan
pietra10	fernandesbernardo@example.org	1960-05-17	+55 (051) 6964 1394	415 Rice Mountains Suite 369, New Christina, WY 16372	Eswatini
rachael20	heloisa39@example.com	1992-12-14	+1-319-305-4342x583	Núcleo da Conceição, Conjunto Jardim Filadélfia, 48320-101 Machado das Pedras / MG	Philippines
allanavasconcelos	xgreen@example.com	1966-11-12	780-860-2186	Vereda de Campos, Santa Tereza, 62038200 Sá / PI	Zambia
amonteiro	vclay@example.org	2002-01-26	+55 21 5885 0025	Alameda Casa Grande, 14, Mangabeiras, 65289667 Carvalho da Prata / PB	Guinea
barbara11	kim29@example.org	2006-08-15	680-231-9188x208	005 Suzanne Lakes Suite 746, New Alexanderport, PA 55248	Burundi
caldeiravicente	agathagomes@example.com	1967-12-31	620-411-0858x7087	5742 Mullins Park Apt. 651, Briannaville, MN 60692	Nepal
marquesbenjamin	xperez@example.net	1965-05-06	(071) 1907 3656	15952 Thomas Path, North Paigeport, CA 73421	Japan
hsilva	emily57@example.com	1978-10-25	0300 901 4407	Sítio Cavalcanti, 50, Araguaia, 27963716 da Paz / PB	Qatar
clara18	maria-flor19@example.net	1943-05-15	+1-725-757-0551x5032	20112 Dillon Station Suite 640, Port Reginaburgh, FL 50735	Philippines
bwalker	nina86@example.com	1920-01-05	215-466-2562	Praça de Ferreira, 99, Cidade Jardim, 21382843 Vieira / SE	Angola
sally03	mouramaria-cecilia@example.org	1999-12-13	51 8779 7126	901 Robinson Dale Apt. 275, West Anne, VI 82770	Armenia
jessemills	nicole25@example.net	1976-02-24	41 6128 8200	Vila de Campos, 268, João Pinheiro, 33967-636 Mendes / AP	Rwanda
hhale	scottjones@example.com	1990-02-21	(031) 9584-3282	PSC 0598, Box 2899, APO AE 88611	Armenia
powelllynn	vramos@example.com	1956-05-27	001-815-538-4484x1427	81637 Haynes Bridge, Corybury, FL 47112	Malaysia
pastoresther	nicolaspeixoto@example.com	2010-08-01	(837)980-0414	081 Lopez Curve, Allenfurt, AS 29758	Jordan
laura51	maria-alicenogueira@example.net	1961-10-01	740-474-0938x165	5756 Barbara Pine, Karlachester, MH 10608	Bhutan
pshort	melissasmith@example.net	1982-10-14	617-742-3134x08522	Passarela da Conceição, Vila Real 1ª Seção, 99950-013 Martins da Praia / PI	Belize
arnoldbrandon	kristymoore@example.net	2002-08-11	620-424-3708x918	63197 Berry Place, South Trevorchester, OK 51562	Solomon Islands
micheledawson	stephanymendonca@example.com	1971-02-22	288-840-3195x1710	Área Maria Cecília da Luz, 92, Carlos Prates, 87449614 Jesus de Minas / MT	Bosnia and Herzegovina
josepeixoto	vnguyen@example.net	1956-05-29	21 9324 6137	Morro Montenegro, 7, Marmiteiros, 83456888 Azevedo / RN	Bahamas
augusto00	ramosbeatriz@example.net	1980-05-14	+1-367-812-6811x38115	Recanto de Rios, 33, Vila Nova Dos Milionarios, 36378905 Costa de Sá / BA	Israel
ana-sophiadias	rgomes@example.org	1979-06-01	(071) 0543-7036	724 Grace Extension, West Anthonyville, NE 41696	Colombia
nealdarrell	jacksontravis@example.com	1954-12-09	+1-416-584-5329x2248	Ladeira de Peixoto, 52, Novo São Lucas, 32600-711 Duarte do Oeste / PI	Wallis and Futuna
amy74	mholmes@example.net	1961-09-15	001-703-825-7949	Morro de Ramos, 32, Vila Piratininga, 58200865 Gomes de Goiás / ES	Eswatini
delacruzthomas	freemanmichael@example.org	1986-11-06	31 8444 3372	Feira de Silva, 95, Lajedo, 87984147 da Mata / GO	Saint Helena, Ascension and Tristan da Cunha
jonesyvette	nicholas92@example.net	2005-12-15	558.799.1589	Conjunto de Pacheco, 761, Santa Cecilia, 22540-209 da Conceição de Goiás / AL	Sudan
nathansilveira	pachecootto@example.net	1948-09-12	(217)340-4021x16978	Recanto Aparecida, 89, São Bento, 89132-553 da Rosa / SP	Albania
maria-luisabrito	cavalcantelorenzo@example.org	1964-09-04	001-635-747-2492x85608	Estação de Fogaça, 42, Marilandia, 81040-896 Costela de Minas / AC	Somalia
jacquelinemeyer	robert43@example.net	1979-09-24	001-632-454-8053x0984	102 Joseph Corner, North Brenda, NH 52854	Wallis and Futuna
andre27	sampaiorafaela@example.net	1956-10-19	0900 458 5352	Unit 1618 Box 5646, DPO AP 77770	Haiti
da-motajuliana	antonyda-conceicao@example.com	1941-08-31	(481)265-9112x5692	24002 Tracy Drive, Lake Christinafurt, CT 60939	Iceland
sampaiolevi	pietro99@example.com	1944-01-07	+55 61 2320-7019	Loteamento Andrade, 40, Jonas Veiga, 24421548 Nogueira / RR	Liechtenstein
juanfrazier	kingcourtney@example.net	1945-12-03	0300-033-7800	658 Juarez Cape, West Albert, NY 86318	Oman
leslie26	derrick00@example.org	1913-07-07	(051) 3417 5284	Feira Azevedo, 56, Pilar, 53258484 Fernandes Alegre / SP	Macau
miguelgomes	tfrancis@example.net	2005-11-03	0800 929 2155	Distrito da Rocha, Vila Piratininga Venda Nova, 23552-743 da Mata / AM	Gibraltar
carrnancy	hthompson@example.com	2011-01-05	612-561-2692	23405 Malik Knolls Suite 556, Colleenstad, WY 33852	Morocco
jacksonjohn	shannon95@example.com	1918-06-23	(021) 1138-7540	7769 Samuel Parkway Suite 185, Port John, RI 29167	Tajikistan
megan92	mcunha@example.net	1930-01-26	(011) 9908 6935	PSC 2743, Box 6563, APO AP 91550	Barbados
maria28	lmoura@example.com	1956-01-04	+55 (071) 5465 8630	33471 Aaron Island, Anthonymouth, MH 32375	Lesotho
mvasquez	yclark@example.org	1923-02-06	229.705.4058x70586	25803 Boone Stravenue, Andreashire, GA 86235	Bosnia and Herzegovina
gdavis	jsouza@example.com	1930-12-20	(342)332-9801	Avenida de Cassiano, 23, Dom Bosco, 30187754 Cirino dos Dourados / AC	Samoa
lewiskyle	yan13@example.org	1924-12-25	+55 51 4334 9500	Chácara de Fernandes, 18, Pirineus, 58828-119 Garcia / AM	Bangladesh
barberbarry	nfogaca@example.net	1989-09-14	31 9379 2516	Estrada Carvalho, 92, Vila Independencia 1ª Seção, 33730-029 Rodrigues / MT	Morocco
juliana75	benicioda-conceicao@example.com	1956-01-17	(041) 1568-0985	Jardim de Costela, 9, Vila Nova Dos Milionarios, 23116-564 Moreira / MT	Yemen
danielle98	sanchezgeorge@example.org	1995-08-03	410.599.4718x44577	695 Mathew Lakes Suite 476, Brownland, PR 39905	Nicaragua
isabella90	anna42@example.com	1913-11-05	(530)778-1409x9315	Travessa de Moraes, 3, Conjunto Minas Caixa, 87246599 Brito da Serra / PE	Kyrgyzstan
jacquelinepotts	cisnerosdeanna@example.com	1982-06-23	(031) 3970-3624	Lagoa Cardoso, Nossa Senhora Da Conceição, 12852-337 Guerra / PE	Canada
guilhermemendonca	benicio57@example.com	1941-10-15	(988)608-1787	Passarela Mendes, 86, Colégio Batista, 65273271 Caldeira / CE	Central African Republic
tda-cruz	pachecomurilo@example.org	1918-07-08	290.385.3252x26258	Aeroporto de Albuquerque, 5, Lagoinha, 09712744 Moreira de Pimenta / SP	Jordan
fanthony	gellis@example.net	1934-04-29	887.738.4776x2895	025 Bell Stream, Wardside, VA 49553	Burundi
bryan10	hberry@example.net	1973-08-18	+55 11 4009 5272	905 Castro Lodge, Santostown, IN 86320	Turkey
jrodriguez	eduardo35@example.net	1970-02-02	687-355-5283x97806	920 Soto Gateway, Lake Brianmouth, CT 20287	India
julia76	xalmeida@example.net	2012-12-26	619.233.9121x9206	Estrada Eloah Câmara, 3, São João Batista, 99971-538 Aparecida Grande / AM	Central African Republic
cirinonicolas	fleblanc@example.org	2010-03-09	+55 71 2696 8713	Trecho de Dias, 31, Marmiteiros, 75305369 Azevedo / MA	Japan
calebe55	vitor-hugopeixoto@example.com	1983-05-15	+1-368-232-7529x1350	Sítio Rios, 83, Serra, 72309322 Abreu dos Dourados / RN	Iran
shaneweaver	bfogaca@example.org	1919-05-22	+55 41 2966-5352	Campo Fonseca, 31, Dom Joaquim, 64605914 Mendonça / MG	Zambia
lsales	domnunes@example.com	1967-01-07	41 7203 3425	Chácara de Ramos, 28, Santo André, 24760-056 da Luz de Peixoto / BA	Iran
chadbryant	whitneymiller@example.net	1974-06-19	81 6837 5629	Ladeira Andrade, 68, Penha, 27171-242 Nascimento / SE	Madagascar
dana87	abigailsmith@example.org	1961-04-17	(989)805-8318x47564	38583 Brittany Views Apt. 848, Spenceview, OR 27654	United Arab Emirates
spires	diane60@example.org	1963-08-27	21 6155-8943	Feira da Cruz, 311, Tupi A, 87653214 Freitas / MT	Tunisia
samuelbautista	paragao@example.net	1962-07-07	4079174713	4123 Craig Forest Suite 194, Branchshire, PA 31614	Iceland
augusto04	philip50@example.com	2011-01-20	71 4356 7846	Sítio de Nogueira, 8, Barão Homem De Melo 3ª Seção, 19016433 Vieira / AP	North Macedonia
zgomes	wattsmichael@example.net	1974-06-03	001-686-915-9052x8621	Aeroporto de Mendes, 68, Alto Vera Cruz, 72453947 Duarte de Melo / CE	Iceland
renanandrade	josebrito@example.org	1925-04-20	597.569.4352x9807	3732 Nicholson Spurs, West Brian, WY 00982	Vietnam
da-pazmarina	gjackson@example.org	1993-09-21	+1-355-293-2694x79836	638 Townsend Ramp Suite 644, Port Kyle, TX 66977	Niue
ana-liz73	krussell@example.net	1998-06-11	749-279-6113x26211	Viaduto Viana, 53, Santa Rita, 69568-081 Pires / AC	Tajikistan
novaisvicente	rbaker@example.com	2006-07-01	+55 (071) 1229 7224	Vila Barbosa, 42, Santa Cruz, 54196-021 Martins Alegre / MS	Qatar
robert44	vinicius87@example.net	1915-10-06	+55 84 0031 5349	Campo de Correia, 7, Varzea Da Palma, 74649924 Ramos / MT	Bahamas
almeidamaria-liz	andrea69@example.com	1917-03-30	864.237.2245x76806	9808 Moore Unions Apt. 973, Kenthaven, TN 81151	Cambodia
kevinrobles	davi-lucca90@example.com	1956-11-04	+55 (071) 4979-8915	Estação Eduardo Costela, 93, Jardim Guanabara, 34374742 Cavalcante da Mata / RR	Canada
yjesus	murphyandrew@example.net	1922-04-20	81 0662-5160	376 Janice Street, East Reginaburgh, PR 65856	Libya
ymendonca	kaitlinmeadows@example.com	1920-03-11	+55 (011) 7677 7096	1110 Anderson Lake Apt. 881, Devontown, AK 16594	Trinidad and Tobago
pricejohn	kenneth37@example.net	1948-11-05	544.357.9520	05830 Roger Mountain Apt. 851, New Michael, SD 88682	Trinidad and Tobago
greerrobert	tylerwhitney@example.com	1974-06-28	(409)246-4996	Viela de da Costa, 574, Olaria, 82078016 Campos da Mata / AM	Israel
isaac50	lisawade@example.org	2005-04-07	+55 (061) 8566-2890	832 Griffin Crest Suite 673, East Katherine, HI 72936	Liberia
bowersjudy	labreu@example.net	1987-03-09	369-461-1952x62059	Estação de Oliveira, 17, Nossa Senhora Aparecida, 33633313 Azevedo da Mata / RN	Zambia
maria-fernandamoreira	marshalljustin@example.org	1975-04-14	329-356-1418x9543	Chácara Viana, Aguas Claras, 78989304 Fernandes / PI	Honduras
almeidaluiz-fernando	xmichael@example.org	2012-11-19	(081) 8017-4542	8510 Cervantes Flat Suite 759, New Annetteborough, PA 57407	Malawi
alicecastro	howardmorgan@example.org	1964-05-21	338-798-8596x746	Praia Matteo Sales, Jardim Vitoria, 81079-115 Casa Grande / CE	Myanmar
pbrewer	alexanderriggs@example.org	1937-10-23	71 2076-0556	Alameda de Novais, Vila Rica, 55017382 Costela / MA	Singapore
caldeirabernardo	davi03@example.org	1980-12-18	+55 (031) 4567-4101	Quadra de Araújo, 207, Bernadete, 26430047 da Conceição / TO	Ghana
johnsonerika	jasonreyes@example.org	2001-02-14	21 1986-9113	7204 Ryan Locks Apt. 169, Goodwintown, GA 87434	Liechtenstein
yualison	yan71@example.com	1925-07-11	+55 71 7290-2154	Núcleo Farias, 23, Primeiro De Maio, 95465-172 Monteiro do Norte / RO	Laos
mjohnson	liviacorreia@example.org	2007-09-03	+1-561-277-3088x10275	Via Maria Helena Teixeira, Castanheira, 21729-241 Montenegro do Campo / SP	Mozambique
nlindsey	johnsondavid@example.net	1977-11-16	+1-857-783-7849x7713	Setor Cassiano, 70, Conjunto Minas Caixa, 64655-214 da Mata da Praia / BA	Trinidad and Tobago
jguzman	murphycody@example.com	2009-02-16	001-906-853-4751x6461	90382 Jackson Ferry Apt. 540, Hopkinshaven, AZ 38172	Philippines
eda-costa	ufischer@example.net	1919-06-04	333.466.6636x70601	Largo Araújo, 50, Bonsucesso, 27298-852 Costela de Nogueira / GO	Malawi
isabel34	cirinodante@example.org	1991-07-05	+55 81 7221-2598	Via Pedro Aparecida, 88, Bonsucesso, 50249584 Pimenta Paulista / SP	Honduras
roy83	hvieira@example.org	1991-10-02	(061) 3385-7427	3433 Mclaughlin Gardens Suite 660, Smithville, CA 37433	Bahamas
jennifermcdonald	maria-cecilia70@example.org	1920-12-08	3779074645	Travessa Juan da Paz, 46, Barão Homem De Melo 2ª Seção, 34070-177 Lopes / AC	Panama
jason09	hellis@example.org	1925-07-09	3423011852	Via Lima, 25, Vila Esplanada, 08009641 da Costa de Casa Grande / AM	Kazakhstan
manuelladas-neves	christopherstewart@example.com	2008-10-02	628-485-8531x2570	Trevo de Pires, 797, Lorena, 48285624 Casa Grande / AM	China
bmartin	hernandezkeith@example.net	1942-05-06	439-416-8108x6093	98496 Victoria Trafficway Suite 113, Whiteport, DE 71870	Namibia
cochrankari	gael-henrique97@example.net	1915-09-25	(982)812-9001x7433	Favela Lopes, 692, Lourdes, 72119-399 Lima / ES	Brunei
timlopez	rodriguesana-sophia@example.net	1976-02-26	(874)461-5437	421 Bryant Gateway, South Patriciamouth, FL 49893	Comoros
yasminpires	reyeschristine@example.net	1927-06-15	299.302.5416x75111	Praça de Vieira, 8, Acaiaca, 37578-083 Nascimento das Pedras / SP	United Arab Emirates
lipaul	pfernandes@example.org	1924-09-09	001-202-706-9251x7040	Via Farias, 89, Marieta 3ª Seção, 40353381 Sousa do Campo / MS	Puerto Rico
cdas-neves	charles24@example.net	1982-01-14	911-959-1501	Setor de Aragão, 6, Santa Sofia, 82324728 Casa Grande de Ramos / MG	Seychelles
oliviawilson	freitasian@example.net	1996-11-10	926.729.5181x35918	Esplanada Theo Azevedo, 9, Alto Vera Cruz, 31742-791 Moreira / AP	Moldova
rhavi03	elisa45@example.net	1960-05-11	+55 11 2838 9757	Distrito Correia, 22, Alto Barroca, 82334220 da Mota do Galho / AM	Saint Helena, Ascension and Tristan da Cunha
kaique28	tsanford@example.org	1920-09-18	+55 (081) 7354 3676	8760 Baker Creek Suite 384, Spencerton, MI 97598	Nicaragua
gregory82	enricoaparecida@example.com	1993-02-26	929.210.0414	020 Jeffrey Shoals, East Benjamin, FL 84870	Ethiopia
sburgess	shannon39@example.net	1946-12-28	808-895-8638	7032 Carr Inlet, Lawrencehaven, ND 50652	Botswana
yasmin67	deborah18@example.net	1981-09-17	781.950.9215x6626	Pátio Martins, Trevo, 57429-544 Sampaio do Oeste / CE	Comoros
melissa20	carmen96@example.com	1964-01-15	+1-321-929-4622x870	Parque Luiz Felipe Cavalcanti, 55, Jardim Atlântico, 98416-017 Guerra de Minas / PR	Cambodia
miguelfuller	aliciarandall@example.com	1986-03-03	+1-644-249-0631x22011	6707 Edward Via Suite 918, North Richardmouth, KS 06066	Iran
floresbrady	carvalhojuliana@example.net	1981-03-10	(011) 0285 8398	33278 Jacob Manors Suite 636, Sandrahaven, MN 37566	Djibouti
earagao	umontenegro@example.net	1981-10-10	392.866.6751x0859	4171 Brenda Forge Apt. 329, South Michellebury, NV 39839	Bhutan
cmarquez	maria-helena60@example.com	1993-09-29	394.474.5258x3323	3118 Carter Passage, South Williammouth, MD 95381	Botswana
gustavo-henrique00	jrodrigues@example.com	1936-12-19	(021) 2457 2044	15662 Paul Square, Jeffport, FM 22956	Albania
das-nevesrenan	alveslarissa@example.com	2013-05-29	+55 (081) 7711 0805	151 Flores Trace, East Michealhaven, PW 26383	Botswana
qbell	sarah00@example.net	1919-02-04	51 5490 5106	Trecho de Ferreira, Barão Homem De Melo 3ª Seção, 28360-194 Machado / CE	Tonga
kda-costa	yanderson@example.net	2002-07-18	3553108130	Vereda de Pacheco, 27, Confisco, 18720-714 Sampaio / SC	Philippines
pastorsara	icamargo@example.com	1914-10-19	+1-740-485-9475x481	Via de Ferreira, 50, Cônego Pinheiro 1ª Seção, 73639452 Jesus de Minas / BA	Ivory Coast
xpimenta	mallory14@example.org	1948-04-27	515-499-8653x94815	9876 Michael Hills Apt. 767, East Garyville, PR 37307	Cape Verde
zharris	matthewho@example.net	1937-03-15	8483109769	8465 Hailey Shoals Suite 749, Andreafort, AS 38812	Kazakhstan
yasmin29	thompsonshannon@example.org	2011-05-28	743.420.5340x3453	Área de Duarte, 38, Guaratã, 16370-501 Andrade / RO	Eritrea
fonsecalucas	lavinia82@example.org	1968-11-20	(051) 9814-9253	119 Santos Drive Suite 423, North Miranda, PR 80008	Liechtenstein
silvaelisa	mouramaite@example.org	1992-06-26	84 5383-8662	Pátio Novaes, 602, Virgínia, 17928-981 Fernandes de Minas / CE	Niue
mateusda-mata	joseabreu@example.com	2003-11-21	+1-883-634-5514x2445	Avenida de Cunha, 249, Tupi B, 50766-053 da Luz dos Dourados / PR	Moldova
kyle84	fogacaheloisa@example.com	2005-10-19	(717)714-6214	USS Collins, FPO AE 16274	Afghanistan
enzocasa-grande	mayamacedo@example.org	1992-07-12	0300 977 3702	388 Jessica Passage, Amandabury, GA 81504	Angola
mathisjacqueline	cookdaniel@example.org	1936-02-29	+55 84 0153-0783	3966 Campbell Plain, Jamesfort, WI 75723	Ethiopia
sowens	yvaughan@example.com	1965-03-15	+55 (051) 9715 7190	117 Johnson Lights, Jenkinsville, WI 32790	Russia
umendes	henry-gabrielpinto@example.net	2009-11-18	779.562.0245x3140	12587 Mann Stream Apt. 798, Lake Amandamouth, ID 13361	Macau
llopes	cynthiawilson@example.net	1947-06-15	+1-605-445-5426x9001	692 Ramos Stravenue Suite 331, New Taramouth, NC 60116	Albania
lgoncalves	lda-paz@example.com	1911-05-17	+55 11 6039 0296	435 Brenda Dam, West James, MO 75878	Iceland
luiz-felipecavalcante	cgordon@example.org	1997-09-04	+1-751-261-5403x13100	Campo Bernardo Rodrigues, 261, Vila Paris, 05162-160 Teixeira / AL	Taiwan
shanebailey	lindsey04@example.com	2007-06-07	+1-716-224-2451x9514	Estrada Rezende, 33, Silveira, 64852539 da Mota / ES	Thailand
vitor-gabriel20	clariceda-mata@example.net	2012-01-25	+55 31 5047-7655	96451 Kathryn Fall, Nicholasville, SD 42103	Ethiopia
michellewhite	bernardjessica@example.org	1984-08-20	41 5094 8165	618 Pham Fork Apt. 056, Ethanchester, GU 82422	North Macedonia
zpugh	aparecidamarcelo@example.net	1995-09-08	+1-754-532-1753x84169	622 Wendy Terrace, Nancyburgh, MD 98052	Lebanon
dante99	william68@example.com	1955-01-05	81 3276 6863	4936 Brady Vista Apt. 694, Port Jeff, MH 10734	Lebanon
lcosta	browneric@example.com	1938-12-10	0500 465 8199	57953 Young Hills, Davidmouth, HI 05790	Aruba
lindsayclark	pereiraravi@example.net	1954-03-11	+1-316-499-4783x044	6695 Wagner Overpass, Joanhaven, MN 19145	Rwanda
nancy73	britoelisa@example.org	1915-10-06	41 7558 3851	Trecho Anthony da Cruz, 72, Nova Cintra, 57015583 Barros do Galho / MA	Japan
carteranne	jesusmirella@example.com	2002-12-15	+55 11 6951-0768	023 Webster Crossroad, Lopezshire, NY 17707	Ethiopia
mccarthypatricia	qcollins@example.com	1967-07-24	727.668.8375x9939	Lago de Siqueira, 960, Vila Jardim São José, 51806-014 da Rocha Grande / RN	Argentina
\.


--
-- TOC entry 5282 (class 0 OID 16636)
-- Dependencies: 267
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.video (nro_plataforma, nome_canal, titulo, datah, tema, duracao_segs, visu_simul, visu_total) FROM stdin;
\.


--
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 220
-- Name: bitcoin_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_nro_plataforma_seq', 1, false);


--
-- TOC entry 5328 (class 0 OID 0)
-- Dependencies: 221
-- Name: bitcoin_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_seq_comentario_seq', 1, false);


--
-- TOC entry 5329 (class 0 OID 0)
-- Dependencies: 222
-- Name: bitcoin_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_seq_doacao_seq', 1, false);


--
-- TOC entry 5330 (class 0 OID 0)
-- Dependencies: 224
-- Name: canal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.canal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5331 (class 0 OID 0)
-- Dependencies: 226
-- Name: cartao_credito_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_nro_plataforma_seq', 1, false);


--
-- TOC entry 5332 (class 0 OID 0)
-- Dependencies: 227
-- Name: cartao_credito_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_seq_comentario_seq', 1, false);


--
-- TOC entry 5333 (class 0 OID 0)
-- Dependencies: 228
-- Name: cartao_credito_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_seq_doacao_seq', 1, false);


--
-- TOC entry 5334 (class 0 OID 0)
-- Dependencies: 230
-- Name: comentario_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_nro_plataforma_seq', 1, false);


--
-- TOC entry 5335 (class 0 OID 0)
-- Dependencies: 231
-- Name: comentario_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_seq_seq', 1, false);


--
-- TOC entry 5336 (class 0 OID 0)
-- Dependencies: 234
-- Name: doacao_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_nro_plataforma_seq', 1, false);


--
-- TOC entry 5337 (class 0 OID 0)
-- Dependencies: 235
-- Name: doacao_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_seq_comentario_seq', 1, false);


--
-- TOC entry 5338 (class 0 OID 0)
-- Dependencies: 236
-- Name: doacao_seq_pg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_seq_pg_seq', 1, false);


--
-- TOC entry 5339 (class 0 OID 0)
-- Dependencies: 270
-- Name: empresa_nro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_nro_seq', 1, false);


--
-- TOC entry 5340 (class 0 OID 0)
-- Dependencies: 238
-- Name: empresa_pais_nro_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_pais_nro_empresa_seq', 1, false);


--
-- TOC entry 5341 (class 0 OID 0)
-- Dependencies: 240
-- Name: inscricao_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscricao_nro_plataforma_seq', 1, false);


--
-- TOC entry 5342 (class 0 OID 0)
-- Dependencies: 242
-- Name: mecanismo_plat_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_nro_plataforma_seq', 1, false);


--
-- TOC entry 5343 (class 0 OID 0)
-- Dependencies: 243
-- Name: mecanismo_plat_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_comentario_seq', 1, false);


--
-- TOC entry 5344 (class 0 OID 0)
-- Dependencies: 244
-- Name: mecanismo_plat_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_doacao_seq', 1, false);


--
-- TOC entry 5345 (class 0 OID 0)
-- Dependencies: 245
-- Name: mecanismo_plat_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_seq', 1, false);


--
-- TOC entry 5346 (class 0 OID 0)
-- Dependencies: 247
-- Name: nivel_canal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nivel_canal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5347 (class 0 OID 0)
-- Dependencies: 250
-- Name: participa_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participa_nro_plataforma_seq', 1, false);


--
-- TOC entry 5348 (class 0 OID 0)
-- Dependencies: 252
-- Name: patrocinio_nro_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patrocinio_nro_empresa_seq', 1, false);


--
-- TOC entry 5349 (class 0 OID 0)
-- Dependencies: 253
-- Name: patrocinio_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patrocinio_nro_plataforma_seq', 1, false);


--
-- TOC entry 5350 (class 0 OID 0)
-- Dependencies: 255
-- Name: paypal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5351 (class 0 OID 0)
-- Dependencies: 256
-- Name: paypal_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_seq_comentario_seq', 1, false);


--
-- TOC entry 5352 (class 0 OID 0)
-- Dependencies: 257
-- Name: paypal_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_seq_doacao_seq', 1, false);


--
-- TOC entry 5353 (class 0 OID 0)
-- Dependencies: 259
-- Name: plataforma_empresa_fund_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_empresa_fund_seq', 1, false);


--
-- TOC entry 5354 (class 0 OID 0)
-- Dependencies: 260
-- Name: plataforma_empresa_respo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_empresa_respo_seq', 1, false);


--
-- TOC entry 5355 (class 0 OID 0)
-- Dependencies: 261
-- Name: plataforma_nro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_nro_seq', 1, false);


--
-- TOC entry 5356 (class 0 OID 0)
-- Dependencies: 263
-- Name: plataforma_usuario_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_usuario_nro_plataforma_seq', 1, false);


--
-- TOC entry 5357 (class 0 OID 0)
-- Dependencies: 264
-- Name: plataforma_usuario_nro_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_usuario_nro_usuario_seq', 1, false);


--
-- TOC entry 5358 (class 0 OID 0)
-- Dependencies: 268
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
-- TOC entry 5025 (class 2606 OID 17681)
-- Name: empresa_pais empresa_pais_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT empresa_pais_pkey PRIMARY KEY (nro_empresa, nome_pais);


--
-- TOC entry 5027 (class 2606 OID 22120)
-- Name: empresa_pais empresa_pais_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT empresa_pais_unique UNIQUE (id_nacional, nome_pais);


--
-- TOC entry 5059 (class 2606 OID 17757)
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
-- TOC entry 5060 (class 2606 OID 22127)
-- Name: bitcoin fk_bitcoin_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitcoin
    ADD CONSTRAINT fk_bitcoin_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5061 (class 2606 OID 22132)
-- Name: canal fk_canal_plataforma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT fk_canal_plataforma FOREIGN KEY (nro_plataforma) REFERENCES public.plataforma(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5062 (class 2606 OID 22137)
-- Name: canal fk_canal_streamer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.canal
    ADD CONSTRAINT fk_canal_streamer FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5063 (class 2606 OID 22122)
-- Name: cartao_credito fk_cartao_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartao_credito
    ADD CONSTRAINT fk_cartao_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5064 (class 2606 OID 22142)
-- Name: comentario fk_comentario_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_usuario FOREIGN KEY (nick_usuario) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5065 (class 2606 OID 22147)
-- Name: comentario fk_comentario_video; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentario
    ADD CONSTRAINT fk_comentario_video FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video) REFERENCES public.video(nro_plataforma, nome_canal, titulo, datah) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5066 (class 2606 OID 22152)
-- Name: doacao fk_doacao_comentario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doacao
    ADD CONSTRAINT fk_doacao_comentario FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario) REFERENCES public.comentario(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5067 (class 2606 OID 22157)
-- Name: empresa_pais fk_empresapais_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT fk_empresapais_empresa FOREIGN KEY (nro_empresa) REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5068 (class 2606 OID 22162)
-- Name: empresa_pais fk_empresapais_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa_pais
    ADD CONSTRAINT fk_empresapais_pais FOREIGN KEY (nome_pais) REFERENCES public.pais(nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5069 (class 2606 OID 22167)
-- Name: inscricao fk_inscricao_membro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT fk_inscricao_membro FOREIGN KEY (nick_membro) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5070 (class 2606 OID 22172)
-- Name: inscricao fk_inscricao_nivel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inscricao
    ADD CONSTRAINT fk_inscricao_nivel FOREIGN KEY (nro_plataforma, nome_canal, nivel) REFERENCES public.nivel_canal(nro_plataforma, nome_canal, nivel) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5071 (class 2606 OID 22177)
-- Name: mecanismo_plat fk_mecanismo_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanismo_plat
    ADD CONSTRAINT fk_mecanismo_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5072 (class 2606 OID 22182)
-- Name: nivel_canal fk_nivel_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nivel_canal
    ADD CONSTRAINT fk_nivel_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5073 (class 2606 OID 22187)
-- Name: pais fk_pais_moeda; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pais
    ADD CONSTRAINT fk_pais_moeda FOREIGN KEY (moeda) REFERENCES public.conversao(moeda) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5074 (class 2606 OID 22192)
-- Name: participa fk_participa_streamer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_streamer FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5075 (class 2606 OID 22197)
-- Name: participa fk_participa_video; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participa
    ADD CONSTRAINT fk_participa_video FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video) REFERENCES public.video(nro_plataforma, nome_canal, titulo, datah) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5076 (class 2606 OID 22202)
-- Name: patrocinio fk_patrocinio_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio
    ADD CONSTRAINT fk_patrocinio_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5077 (class 2606 OID 22207)
-- Name: patrocinio fk_patrocinio_empresa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patrocinio
    ADD CONSTRAINT fk_patrocinio_empresa FOREIGN KEY (nro_empresa) REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5078 (class 2606 OID 22222)
-- Name: paypal fk_paypal_doacao; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paypal
    ADD CONSTRAINT fk_paypal_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao) REFERENCES public.doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5079 (class 2606 OID 22212)
-- Name: plataforma fk_plataforma_empresa_fund; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT fk_plataforma_empresa_fund FOREIGN KEY (empresa_fund) REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5080 (class 2606 OID 22217)
-- Name: plataforma fk_plataforma_empresa_respo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma
    ADD CONSTRAINT fk_plataforma_empresa_respo FOREIGN KEY (empresa_respo) REFERENCES public.empresa(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5081 (class 2606 OID 22227)
-- Name: plataforma_usuario fk_plataforma_usuario_plataforma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario
    ADD CONSTRAINT fk_plataforma_usuario_plataforma FOREIGN KEY (nro_plataforma) REFERENCES public.plataforma(nro) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5082 (class 2606 OID 22232)
-- Name: plataforma_usuario fk_plataforma_usuario_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plataforma_usuario
    ADD CONSTRAINT fk_plataforma_usuario_usuario FOREIGN KEY (nick_usuario) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5083 (class 2606 OID 22237)
-- Name: streamer_pais fk_streamerpais_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT fk_streamerpais_pais FOREIGN KEY (nome_pais) REFERENCES public.pais(nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5084 (class 2606 OID 22242)
-- Name: streamer_pais fk_streamerpais_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.streamer_pais
    ADD CONSTRAINT fk_streamerpais_usuario FOREIGN KEY (nick_streamer) REFERENCES public.usuario(nick) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5085 (class 2606 OID 22247)
-- Name: usuario fk_usuario_pais; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_usuario_pais FOREIGN KEY (pais_resid) REFERENCES public.pais(nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5086 (class 2606 OID 22252)
-- Name: video fk_video_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT fk_video_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2025-10-30 03:36:40

--
-- PostgreSQL database dump complete
--

\unrestrict ZtdFzc7eWFeoR5ugs4S0C7DGSbpPS89YiA1Ty2RkYwz5YgEZGYBQXWl1mRIHZP2

