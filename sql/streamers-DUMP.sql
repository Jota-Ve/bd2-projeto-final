--
-- PostgreSQL database dump
--

\restrict tPU60J3Re5P3uydPE3utjhhlIMQtas49GSwM4fZU8rfLdy7ckYgdKWA1xdYI1nN

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-30 02:34:59

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
    nome_pais_residencia text NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

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
-- TOC entry 5325 (class 0 OID 0)
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
MMK	Burmese kyat	2.42192284
MKD	Macedonian denar	0.75117371
JPY	Japanese yen	1.10456421
WST	Samoan tālā	6.30732265
BRL	Brazilian real	4.97375398
XDR	Special drawing rights	4.80134377
BMD	Bermudian dollar	2.47367028
TRY	Turkish lira	4.46749620
XCD	Eastern Caribbean dollar	2.77393881
HKD	Hong Kong dollar	5.57268015
FJD	Fijian dollar	6.04839320
MDL	Moldovan leu	1.73528867
ARS	Argentine peso	5.21764531
GMD	Gambian dalasi	2.39525966
ALL	Albanian lek	1.69070605
NIS	Israeli new shekel	0.37762627
XOF	West African CFA franc	0.07899646
GYD	Guyanese dollar	1.59899987
RUB	Russian ruble	4.81315633
RWF	Rwandan franc	1.91497970
JOD	Jordanian dinar	0.30179817
PAB	Panamanian balboa	3.95832092
BGN	Bulgarian lev	1.42129467
ZMW	Zambian kwacha	1.11148235
SGD	Singapore dollar	1.63973487
VUV	Vanuatu vatu	1.19684323
SAR	Saudi riyal	3.01236593
UAH	Ukrainian hryvnia	4.87202935
MXN	Mexican peso	1.58269111
TVD	Tuvaluan dollar	0.77666793
ETB	Ethiopian birr	5.58796270
CUP	Cuban peso	0.79433344
BAM	Bosnia and Herzegovina convertible mark	2.91058796
STD	São Tomé and Príncipe dobra	2.03202591
THB	Thai baht	2.98596507
BTN	Bhutanese ngultrum	0.28081997
CZK	Czech koruna	4.91796750
NOK	Norwegian krone	1.27264035
NIO	Nicaraguan córdoba	0.81330916
BYR	Belarusian ruble	3.92584094
MNT	Mongolian tugrik	0.88704886
GGP	Guernsey pound	6.22825458
GBP	Pound sterling	2.70374514
CDF	Congolese franc	1.99944186
TWD	New Taiwan dollar	6.05273941
MVR	Maldivian rufiyaa	1.43099877
USD	United States dollar	1.00000000
CRC	Costa Rican colón	3.35323675
PEN	Peruvian sol	2.68367154
TMT	Turkmenistan manat	2.78691219
SOS	Somali shilling	3.02628808
INR	Indian rupee	3.48161959
GHS	Ghanaian cedi	2.64934076
CAD	Canadian dollar	5.38495866
BOB	Bolivian boliviano	2.36408420
MRO	Mauritanian ouguiya	4.21331595
NPR	Nepalese rupee	2.99903218
SVC	Salvadoran colón	4.09440110
HNL	Honduran lempira	2.23206138
CNY	Renminbi	1.27255937
AUD	Australian dollar	5.74709776
SRD	Surinamese dollar	3.34024173
GNF	Guinean franc	0.54767261
BDT	Bangladeshi taka	3.28106055
PLN	Polish zloty	6.03923219
AOA	Angolan kwanza	1.37936533
RON	Romanian leu	2.35098899
ERN	Eritrean nakfa	4.35055507
MZN	Mozambican metical	0.78832022
UZS	Uzbekistani soʻm	4.30965110
MOP	Macanese pataca	0.41680252
SPL	Seborga luigino	3.11926712
PGK	Papua New Guinean kina	2.41797003
PYG	Paraguayan guarani	1.70840895
QAR	Qatari riyal	0.24659820
KGS	Kyrgyzstani som	2.56592856
LBP	Lebanese pound	5.85193513
ANG	Netherlands Antillean guilder	6.16061099
TND	Tunisian dinar	3.31070510
IRR	Iranian rial	4.31988717
MAD	Moroccan dirham	0.68828521
CUC	Cuban convertible peso	6.06462267
DKK	Danish krone	3.43337926
CHF	Swiss franc	0.52276736
DOP	Dominican peso	4.64021940
AED	United Arab Emirates dirham	4.04367025
JEP	Jersey pound	1.06608397
TTD	Trinidad and Tobago dollar	1.86775375
BWP	Botswana pula	2.57730863
KMF	Comorian franc	4.29835095
GTQ	Guatemalan quetzal	3.78174330
BSD	Bahamian dollar	5.61938858
KZT	Kazakhstani tenge	3.91342736
SHP	Saint Helena pound	0.18063791
SCR	Seychellois rupee	0.47145728
CVE	Cape Verdean escudo	4.51978199
OMR	Omani rial	4.70058577
IMP	Manx pound	4.78250952
LTL	Lithuanian litas	2.19035665
BBD	Barbadian dollar	1.00866374
VEF	Venezuelan bolívar	4.19765806
MWK	Malawian kwacha	4.38759946
RSD	Serbian dinar	2.54494768
UYU	Uruguayan peso	1.28547818
LKR	Sri Lankan rupee	2.70564690
AFN	Afghan afghani	2.04860824
KRW	South Korean won	2.69460542
SYP	Syrian pound	1.18193111
EUR	Euro	3.50134018
SEK	Swedish krona	2.08600071
AWG	Aruban florin	0.04625804
BHD	Bahraini dinar	1.20780258
XPF	CFP franc	2.76431142
NAD	Namibian dollar	2.85785255
VND	Vietnamese đồng	2.97713384
LYD	Libyan dinar	0.75079209
BND	Brunei dollar	1.48942049
BIF	Burundian franc	5.60522045
GIP	Gibraltar pound	2.66680617
MYR	Malaysian ringgit	4.70303808
UGX	Ugandan shilling	1.63038594
SBD	Solomon Islands dollar	1.83549193
COP	Colombian peso	2.11649986
EGP	Egyptian pound	3.52272171
HUF	Hungarian forint	1.89803901
KYD	Cayman Islands dollar	1.73269851
PHP	Philippine peso	6.01088621
PKR	Pakistani rupee	5.13334838
LRD	Liberian dollar	2.51958511
LAK	Lao kip	4.01701325
AZN	Azerbaijani manat	2.25258671
LSL	Lesotho loti	4.24856158
XAF	Central African CFA franc	0.97305143
TOP	Tongan paʻanga	1.56457540
BZD	Belize dollar	0.71740181
YER	Yemeni rial	4.75008478
DJF	Djiboutian franc	4.13369389
CLP	Chilean peso	5.64980933
DZD	Algerian dinar	0.97922625
KWD	Kuwaiti dinar	5.31198627
ILS	Israeli new shekel	3.77201875
GEL	Georgian lari	1.17504708
TJS	Tajikistani somoni	5.74385676
SDG	Sudanese pound	5.26504908
IQD	Iraqi dinar	6.35742029
MUR	Mauritian rupee	4.58732949
HTG	Haitian gourde	0.08372244
MGA	Malagasy ariar	5.56939315
KHR	Cambodian riel	1.10727785
AMD	Armenian dram	3.14497781
TZS	Tanzanian shilling	0.58961358
HRK	Croatian kuna	2.30553317
KPW	North Korean won	0.75423165
ZAR	South African rand	2.32195958
NGN	Nigerian naira	6.38865662
ZWD	Zimbabwean dollar	1.27295250
JMD	Jamaican dollar	3.04021516
NZD	New Zealand dollar	5.96016063
FKP	Falkland Islands pound	3.16304902
ISK	Icelandic króna	3.44373963
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
1	Martin LLC	Martin LLC Tech
2	Pimenta - ME	Pimenta - ME Prime
3	Nascimento e Filhos	Nascimento e Filhos Delícias
4	Lewis Inc	Lewis Inc Consultoria
5	Dias Garcia e Filhos	Dias Garcia e Filhos Creative
6	Jackson-Patterson	Jackson-Patterson Soluções
7	Osborne Group	Osborne Group Inteligência
8	Hernandez, Walls and Powell	Hernandez, Walls and Powell Prime
9	Green-Kelly	Green-Kelly Transportes
10	Vieira - EI	Vieira - EI Advocacia
11	Schwartz-Charles	Schwartz-Charles Worldwide
12	Johnson Ltd	Johnson Ltd Jurídico
13	Smith and Sons	Smith and Sons Transportes
14	da Mata Ltda.	da Mata Ltda. Design
15	Peters PLC	Peters PLC Works
16	Smith Group	Smith Group Networks
17	Moura	Moura Creative
18	Hall, Berry and Hawkins	Hall, Berry and Hawkins Advisors
19	Singh-Schaefer	Singh-Schaefer Verde
20	Moraes	Moraes Private
21	Peixoto	Peixoto Atelier
22	Gomes - ME	Gomes - ME Imobiliária
23	da Conceição	da Conceição Next
24	Frederick, Duncan and Spears	Frederick, Duncan and Spears Verde
25	Rodrigues	Rodrigues Moda
26	Wright-Leonard	Wright-Leonard Clinic
27	Ferreira Ltda.	Ferreira Ltda. Formação
28	Fernandez, Perez and Hawkins	Fernandez, Perez and Hawkins Smart
29	Morris-Smith	Morris-Smith Holdings
30	Holmes-Bradford	Holmes-Bradford Tech
31	Azevedo e Filhos	Azevedo e Filhos International
32	Bond Ltd	Bond Ltd Grupo
33	Andrews Ltd	Andrews Ltd Legal
34	Davis-Moss	Davis-Moss Soluções
35	Pires	Pires Jurídico
36	Mckenzie, Butler and Smith	Mckenzie, Butler and Smith Atacado
37	Barbosa	Barbosa Private
38	Ward-Jones	Ward-Jones Obras
39	Brito Machado Ltda.	Brito Machado Ltda. Networks
40	Lane, Jones and Sullivan	Lane, Jones and Sullivan Investimentos
41	Santos	Santos Sustentável
42	Cavalcante Nunes - ME	Cavalcante Nunes - ME Studio
43	Leonard-Fuentes	Leonard-Fuentes Inteligência
44	Guerra	Guerra Delícias
45	Mason Ltd	Mason Ltd Edge
46	Hoffman-Guerra	Hoffman-Guerra Grupo
47	Pinto Farias S.A.	Pinto Farias S.A. Delícias
48	Cassiano Nunes Ltda.	Cassiano Nunes Ltda. Jurídico
49	Barros Moraes - EI	Barros Moraes - EI Sustentável
50	Nascimento Almeida Ltda.	Nascimento Almeida Ltda. Empreendimentos
51	das Neves Camargo e Filhos	das Neves Camargo e Filhos Jurídico
52	Mendonça	Mendonça Empreendimentos
53	Ribeiro Silva e Filhos	Ribeiro Silva e Filhos Estilo
54	Mejia-Prince	Mejia-Prince Investimentos
55	Blair LLC	Blair LLC Worldwide
56	Rodriguez, Mccoy and Moore	Rodriguez, Mccoy and Moore Atacado
57	Brown-Brown	Brown-Brown Platform
58	Correia	Correia Educação
59	Melo	Melo Assessoria
60	Brown, Gray and Gibson	Brown, Gray and Gibson Grupo
61	Nogueira - ME	Nogueira - ME Investimentos
62	Aragão Nascimento e Filhos	Aragão Nascimento e Filhos Clinic
63	Almeida	Almeida Transportes
64	da Rocha	da Rocha Empreendimentos
65	Myers, Murphy and Cox	Myers, Murphy and Cox Prime
66	Gonçalves	Gonçalves Hub
67	Silva - ME	Silva - ME Digital
68	Siqueira Novaes Ltda.	Siqueira Novaes Ltda. Hub
69	Lima	Lima Services
70	Marques S/A	Marques S/A Alimentos
71	Rice Group	Rice Group Comércio
72	Sousa Camargo - EI	Sousa Camargo - EI Academia
73	Wells LLC	Wells LLC Formação
74	Coleman-Dalton	Coleman-Dalton Boutique
75	Vasquez, Thompson and White	Vasquez, Thompson and White Services
76	Costa	Costa Networks
77	Davis, Sheppard and Woodard	Davis, Sheppard and Woodard Treinamento
78	Albuquerque Ltda.	Albuquerque Ltda. Prime
79	Wallace-Austin	Wallace-Austin Estilo
80	Ramsey Inc	Ramsey Inc Platform
81	Cassiano	Cassiano Distribuidora
82	Almeida S/A	Almeida S/A Next
83	Castro Caldeira - EI	Castro Caldeira - EI Jurídico
84	Hampton, Middleton and Jacobson	Hampton, Middleton and Jacobson Digital
85	Gonçalves da Paz S.A.	Gonçalves da Paz S.A. Assessoria
86	Frost-Sampson	Frost-Sampson Comércio
87	Miller PLC	Miller PLC Tech
88	Perkins-Elliott	Perkins-Elliott Inovação
89	da Luz Ferreira Ltda.	da Luz Ferreira Ltda. Delícias
90	da Luz Aragão e Filhos	da Luz Aragão e Filhos Gastronomia
91	Wilcox-Webb	Wilcox-Webb Educação
92	Chandler, Hammond and Gibson	Chandler, Hammond and Gibson Design
93	Owens PLC	Owens PLC Digital
94	Machado	Machado Collective
95	Pimenta - EI	Pimenta - EI Jurídico
96	Cummings Ltd	Cummings Ltd Agency
97	Lewis, Sparks and Hardy	Lewis, Sparks and Hardy Delícias
98	Sá S.A.	Sá S.A. Systems
99	Miller LLC	Miller LLC Verde
100	Parker and Sons	Parker and Sons Educação
101	Jesus	Jesus Culinária
102	Guerra da Rosa Ltda.	Guerra da Rosa Ltda. Engine
103	Aparecida - ME	Aparecida - ME Varejo
104	Sanchez-Salas	Sanchez-Salas Partners
105	Davis-Fowler	Davis-Fowler Soluções
106	Sá	Sá Labs
107	Farias	Farias Legal
108	da Conceição Albuquerque - EI	da Conceição Albuquerque - EI Medical
109	Mitchell PLC	Mitchell PLC Systems
110	da Mata	da Mata Culinária
111	Correia Vieira e Filhos	Correia Vieira e Filhos Digital
112	Brown LLC	Brown LLC Next
113	Boyd Group	Boyd Group Works
114	Bell LLC	Bell LLC Moda
115	Ryan-Kelley	Ryan-Kelley Enterprises
116	Cooper-White	Cooper-White Formação
117	Park Ltd	Park Ltd Finanças
118	Herrera-Barron	Herrera-Barron Edge
119	Ribeiro Aparecida - EI	Ribeiro Aparecida - EI Estilo
120	Johnson-Hill	Johnson-Hill Healthcare
121	Russell-Taylor	Russell-Taylor Wellness
122	Leão Rios S.A.	Leão Rios S.A. Verde
123	da Mata S.A.	da Mata S.A. Advisors
124	Perez-Lopez	Perez-Lopez Distribuidora
125	Sharp-Jordan	Sharp-Jordan Labs
126	Teixeira Moura Ltda.	Teixeira Moura Ltda. Finanças
127	Souza	Souza Formação
128	Pereira	Pereira Systems
129	Castro Nogueira Ltda.	Castro Nogueira Ltda. Studio
130	Harrison, Kemp and Nichols	Harrison, Kemp and Nichols Tech
131	Santos da Mata - EI	Santos da Mata - EI Transportes
132	Sales Ltda.	Sales Ltda. Prime
133	Câmara S/A	Câmara S/A Tech
134	Hernandez PLC	Hernandez PLC Logística
135	Marques Ltda.	Marques Ltda. Legal
136	da Cunha	da Cunha Atelier
137	Silva Novais S.A.	Silva Novais S.A. Empreendimentos
138	Moreira Souza - ME	Moreira Souza - ME Jurídico
139	Reese Group	Reese Group Empreendimentos
140	Montenegro da Rosa S.A.	Montenegro da Rosa S.A. Alimentos
141	Casa Grande	Casa Grande Gastronomia
142	Blackburn, Martinez and Smith	Blackburn, Martinez and Smith Digital
143	Brown-Gutierrez	Brown-Gutierrez Atacado
144	da Luz S.A.	da Luz S.A. Boutique
145	Viana	Viana Design
146	Schneider, Smith and Erickson	Schneider, Smith and Erickson Alimentos
147	Siqueira	Siqueira Prime
148	Quinn, Clark and White	Quinn, Clark and White Works
149	Fogaça	Fogaça Hub
150	Martin and Sons	Martin and Sons Engine
151	Nunes - EI	Nunes - EI Services
152	Albuquerque S/A	Albuquerque S/A Design
153	Aparecida S/A	Aparecida S/A Smart
154	Cavalcanti	Cavalcanti Grupo
155	Fernandes da Rocha Ltda.	Fernandes da Rocha Ltda. Consultoria
156	Andrade	Andrade Systems
157	Caldeira e Filhos	Caldeira e Filhos Advisors
158	Monteiro S.A.	Monteiro S.A. Distribuidora
159	Young Inc	Young Inc Partners
160	Novaes	Novaes Prime
161	Carvalho Castro - EI	Carvalho Castro - EI Boutique
162	Lopes	Lopes Healthcare
163	Adams-Smith	Adams-Smith Factory
164	Pereira - ME	Pereira - ME Universal
165	Alves - ME	Alves - ME Estilo
166	Morrow and Sons	Morrow and Sons Advocacia
167	Parrish-Jackson	Parrish-Jackson Holdings
168	Evans-Thompson	Evans-Thompson Ambiental
169	Anderson-Bauer	Anderson-Bauer Advocacia
170	Alves S/A	Alves S/A Engine
171	Carvalho	Carvalho Grupo
172	Gordon-Brock	Gordon-Brock Inteligência
173	Jones, Rios and Morse	Jones, Rios and Morse Comércio
174	Sanchez, Patton and Black	Sanchez, Patton and Black Capital
175	Montenegro	Montenegro Varejo
176	Green-Morris	Green-Morris Capital
177	Marques	Marques Factory
178	Alves Rezende - ME	Alves Rezende - ME Varejo
179	Brown-Harrison	Brown-Harrison Moda
180	da Cunha S.A.	da Cunha S.A. Advocacia
181	Gomes Marques S.A.	Gomes Marques S.A. Capital
182	Lima Cassiano - EI	Lima Cassiano - EI Services
183	Pinto S/A	Pinto S/A Studio
184	Rocha	Rocha Legal
185	Leão - ME	Leão - ME Atacado
186	Castro	Castro Inovação
187	Cruz-Chavez	Cruz-Chavez Delícias
188	Rose Group	Rose Group Boutique
189	Mosley-Singleton	Mosley-Singleton Finanças
190	Novais	Novais Universal
191	Salas LLC	Salas LLC Global
192	Araújo S/A	Araújo S/A Networks
193	Barry, Johnson and Booth	Barry, Johnson and Booth Verde
194	David-Valenzuela	David-Valenzuela Transportes
195	Torres, Hendricks and Lam	Torres, Hendricks and Lam Capital
196	Garcia	Garcia Tecnologia
197	Rios S.A.	Rios S.A. Design
198	Davis Group	Davis Group Advocacia
199	Shaffer and Sons	Shaffer and Sons Universal
200	Fogaça - ME	Fogaça - ME Construções
201	Silveira	Silveira Inteligência
202	Burns-Santos	Burns-Santos Consultoria
203	Williams, Lee and Hudson	Williams, Lee and Hudson Empreendimentos
204	Casa Grande Vargas e Filhos	Casa Grande Vargas e Filhos Edge
205	Pacheco - EI	Pacheco - EI Comércio
206	Richardson LLC	Richardson LLC Jurídico
207	Watkins-Ewing	Watkins-Ewing Edge
208	Smith, Bishop and Parker	Smith, Bishop and Parker Global
209	Abbott, Strong and Price	Abbott, Strong and Price Solutions
210	Gutierrez, Donovan and Barber	Gutierrez, Donovan and Barber Consulting
211	Sampaio	Sampaio Legal
212	Gould and Sons	Gould and Sons Estilo
213	Novais Abreu e Filhos	Novais Abreu e Filhos Global
214	Morales-Espinoza	Morales-Espinoza Hub
215	Dougherty, Jackson and Valenzuela	Dougherty, Jackson and Valenzuela Systems
216	Ross-Richards	Ross-Richards Delícias
217	da Rosa	da Rosa Clinic
218	Diaz-Flynn	Diaz-Flynn Advisors
219	Brown, Anderson and Adams	Brown, Anderson and Adams Logística
220	Oneill-Robinson	Oneill-Robinson Verde
221	Guerra S.A.	Guerra S.A. Networks
222	Harris-Cobb	Harris-Cobb Strategies
223	da Mota Novais Ltda.	da Mota Novais Ltda. Smart
224	Ferguson Inc	Ferguson Inc Academia
225	Vieira S.A.	Vieira S.A. Systems
226	Nelson and Sons	Nelson and Sons Labs
227	Jones, Turner and Lee	Jones, Turner and Lee Soluções
228	Gomez Group	Gomez Group Clinic
229	Moura Jesus - ME	Moura Jesus - ME Academia
230	Hernandez-Soto	Hernandez-Soto Serviços
231	Johnson-Cohen	Johnson-Cohen Finanças
232	Moreira - ME	Moreira - ME Labs
233	Monteiro Nunes e Filhos	Monteiro Nunes e Filhos Inovação
234	Mack-Cooley	Mack-Cooley Partners
235	Aparecida Rocha - EI	Aparecida Rocha - EI Finanças
236	Glass-Frazier	Glass-Frazier Academia
237	Glass, Barajas and Baird	Glass, Barajas and Baird Delícias
238	Almeida S.A.	Almeida S.A. Estilo
239	Sá Viana S.A.	Sá Viana S.A. Next
240	Walsh Group	Walsh Group Global
241	Macedo S/A	Macedo S/A Wellness
242	Moreira Guerra - EI	Moreira Guerra - EI Agency
243	Costa - EI	Costa - EI Smart
244	Silva	Silva Estilo
245	Eaton-Morgan	Eaton-Morgan Clinic
246	Robinson Ltd	Robinson Ltd Holdings
247	Schmidt Group	Schmidt Group Ambiental
248	Duarte Sá S.A.	Duarte Sá S.A. Engine
249	Smith-Clark	Smith-Clark Capital
250	Novais Santos - ME	Novais Santos - ME Assessoria
251	Câmara	Câmara Solutions
252	Gomes Santos - ME	Gomes Santos - ME Agency
253	Leão e Filhos	Leão e Filhos Formação
254	Gonzalez-Lam	Gonzalez-Lam Studio
255	Young, Collins and Sanchez	Young, Collins and Sanchez Systems
256	Hall-Parks	Hall-Parks International
257	Ball-Sanders	Ball-Sanders Solutions
258	Cardoso	Cardoso Enterprises
259	Nelson, Thompson and Gonzalez	Nelson, Thompson and Gonzalez Healthcare
260	Montenegro Nogueira - ME	Montenegro Nogueira - ME Operações
261	Novaes da Costa - ME	Novaes da Costa - ME Gastronomia
262	Jesus Castro S.A.	Jesus Castro S.A. Collective
263	Gomes S/A	Gomes S/A Clinic
264	Jackson Inc	Jackson Inc Construções
265	Brito e Filhos	Brito e Filhos Grupo
266	Teixeira S/A	Teixeira S/A Delícias
267	Gutierrez-Gutierrez	Gutierrez-Gutierrez Ambiental
268	Zamora-Schwartz	Zamora-Schwartz Factory
269	Landry, Schmidt and Walls	Landry, Schmidt and Walls Varejo
270	Fletcher, Mckenzie and Gilbert	Fletcher, Mckenzie and Gilbert Transportes
271	Farias - ME	Farias - ME Engine
272	da Rocha - EI	da Rocha - EI Frete
273	Miles, Tucker and Burke	Miles, Tucker and Burke Serviços
274	Brown-Benson	Brown-Benson Moda
275	Walker, Best and Clark	Walker, Best and Clark Educação
276	Caldwell-Moran	Caldwell-Moran Advisors
277	Campbell Ltd	Campbell Ltd Culinária
278	Salazar-Carpenter	Salazar-Carpenter Enterprises
279	Shepard-Moore	Shepard-Moore Consulting
280	Novais S/A	Novais S/A Legal
281	Powers PLC	Powers PLC Construções
282	Campbell-Larsen	Campbell-Larsen Design
283	Martinez, King and Fletcher	Martinez, King and Fletcher Empreendimentos
284	White, Sawyer and Campbell	White, Sawyer and Campbell Distribuidora
285	Goodman-Cook	Goodman-Cook Systems
286	Cuevas-Morgan	Cuevas-Morgan Private
287	Monteiro	Monteiro Collective
288	da Mota	da Mota Boutique
289	Dias	Dias Ambiental
290	Graham Group	Graham Group Frete
291	Duncan-Brown	Duncan-Brown Treinamento
292	Peixoto Sampaio Ltda.	Peixoto Sampaio Ltda. Treinamento
293	Wall-Taylor	Wall-Taylor Global
294	Moreira	Moreira Clinic
295	Castro da Mata - EI	Castro da Mata - EI Consulting
296	Campos Fernandes S.A.	Campos Fernandes S.A. Services
297	Huffman Group	Huffman Group Construções
298	White and Sons	White and Sons Empreendimentos
299	Borges Campos e Filhos	Borges Campos e Filhos Universal
300	Campbell, Hughes and Sweeney	Campbell, Hughes and Sweeney Studio
301	Azevedo	Azevedo Transportes
302	Pacheco	Pacheco Labs
303	Porto	Porto Private
304	Logan Ltd	Logan Ltd Hub
305	Brito	Brito Legal
306	Bautista, Smith and Hunt	Bautista, Smith and Hunt Co
307	Sampaio e Filhos	Sampaio e Filhos Finanças
308	Pimenta	Pimenta Comércio
309	Abreu - ME	Abreu - ME Treinamento
310	Davis-Patel	Davis-Patel Engine
311	Murphy and Sons	Murphy and Sons Boutique
312	Dawson LLC	Dawson LLC Jurídico
313	Vargas Inc	Vargas Inc Legal
314	Brown-Larson	Brown-Larson Eco
315	Torres-Washington	Torres-Washington Serviços
316	da Conceição Aparecida S.A.	da Conceição Aparecida S.A. Eco
317	Gross, Thompson and Smith	Gross, Thompson and Smith Services
318	Pinto	Pinto Collective
319	Mendes	Mendes Estilo
320	Freitas	Freitas Consultoria
321	Ferreira - ME	Ferreira - ME Ambiental
322	da Costa Ltda.	da Costa Ltda. Estilo
323	Mitchell, Mack and Spencer	Mitchell, Mack and Spencer Healthcare
324	Casa Grande S.A.	Casa Grande S.A. Universal
325	Dixon-Massey	Dixon-Massey Engine
326	Adams and Sons	Adams and Sons Prime
327	Nixon-Mullen	Nixon-Mullen Partners
328	Miller and Sons	Miller and Sons Jurídico
329	Douglas-Cortez	Douglas-Cortez Alimentos
330	Moore-Blevins	Moore-Blevins Comércio
331	Meyers PLC	Meyers PLC Solutions
332	Cox and Sons	Cox and Sons Systems
333	Moura Nogueira - ME	Moura Nogueira - ME Wellness
334	Leão Mendonça e Filhos	Leão Mendonça e Filhos Finanças
335	Phillips, Green and Henry	Phillips, Green and Henry Advisors
336	Burke-Hart	Burke-Hart Studio
337	Schwartz, Parker and Allen	Schwartz, Parker and Allen Engine
338	Cirino	Cirino Jurídico
339	Smith LLC	Smith LLC Solutions
340	Larson, Carroll and Johnson	Larson, Carroll and Johnson Worldwide
341	Fonseca	Fonseca Operações
342	Machado Ltda.	Machado Ltda. Next
343	Barnes, Shannon and Curry	Barnes, Shannon and Curry Gastronomia
344	Villarreal Ltd	Villarreal Ltd Agency
345	Garcia, Young and Marquez	Garcia, Young and Marquez Logística
346	da Costa Cardoso Ltda.	da Costa Cardoso Ltda. Networks
347	Jones Group	Jones Group Tech
348	Baxter, Walls and Lee	Baxter, Walls and Lee Agency
349	Morrow, Powers and Ingram	Morrow, Powers and Ingram Culinária
350	Ribeiro	Ribeiro Comércio
351	Camargo Gomes - EI	Camargo Gomes - EI Serviços
352	Alves Sales e Filhos	Alves Sales e Filhos Digital
353	Mendes Ltda.	Mendes Ltda. Ambiental
354	da Rocha S.A.	da Rocha S.A. Sustentável
355	Gomes S.A.	Gomes S.A. Empreendimentos
356	Stewart PLC	Stewart PLC Clinic
357	da Mota Ltda.	da Mota Ltda. Educação
358	Moraes Fonseca S/A	Moraes Fonseca S/A Global
359	Pope LLC	Pope LLC Edge
360	Hunt-Simmons	Hunt-Simmons Delícias
361	da Rosa Rocha S/A	da Rosa Rocha S/A Digital
362	Pearson, Jones and Baker	Pearson, Jones and Baker Universal
363	Gomes Cirino S.A.	Gomes Cirino S.A. Works
364	Fogaça e Filhos	Fogaça e Filhos Culinária
365	Siqueira S.A.	Siqueira S.A. Co
366	Marks, Jordan and Morrow	Marks, Jordan and Morrow Systems
367	Camargo das Neves S.A.	Camargo das Neves S.A. Atelier
368	Martins	Martins Treinamento
369	Reed Inc	Reed Inc Assessoria
370	Pacheco Borges - EI	Pacheco Borges - EI Operações
371	James, Christian and Mercer	James, Christian and Mercer Construções
372	Peixoto Martins - EI	Peixoto Martins - EI Worldwide
373	Obrien LLC	Obrien LLC Global
374	Nascimento	Nascimento Varejo
375	Webster, White and Stewart	Webster, White and Stewart Formação
376	Fuller Inc	Fuller Inc Tech
377	Walker-Peters	Walker-Peters Boutique
378	da Cunha - EI	da Cunha - EI Medical
379	Aragão	Aragão Ambiental
380	Teixeira Cassiano - EI	Teixeira Cassiano - EI Construções
381	Brooks Ltd	Brooks Ltd Labs
382	Escobar PLC	Escobar PLC Systems
383	Robbins, Harvey and Mccarthy	Robbins, Harvey and Mccarthy Verde
384	Gomes	Gomes Distribuidora
385	Smith Inc	Smith Inc Grupo
386	Almeida Ltda.	Almeida Ltda. Estilo
387	Nogueira	Nogueira Services
388	Sousa	Sousa Finanças
389	Johnson-Hunt	Johnson-Hunt Atacado
390	Daniels, Stone and Walsh	Daniels, Stone and Walsh Global
391	Reid PLC	Reid PLC Agency
392	Johnson, Sanders and Griffin	Johnson, Sanders and Griffin Empreendimentos
393	Alves S.A.	Alves S.A. Formação
394	Dias - EI	Dias - EI Enterprises
395	Souza Ribeiro Ltda.	Souza Ribeiro Ltda. Culinária
396	Lowe, Ramos and Ramirez	Lowe, Ramos and Ramirez Global
397	Valencia Inc	Valencia Inc Jurídico
398	Jones PLC	Jones PLC Obras
399	Allen-Spence	Allen-Spence Moda
400	Barros	Barros Digital
401	das Neves	das Neves Design
402	Morgan-Miller	Morgan-Miller Worldwide
403	Carvalho S.A.	Carvalho S.A. Operações
404	Turner-Knight	Turner-Knight Atelier
405	Pacheco Cardoso - EI	Pacheco Cardoso - EI Assessoria
406	Hodge LLC	Hodge LLC Verde
407	da Rosa e Filhos	da Rosa e Filhos Networks
408	Silveira da Paz - EI	Silveira da Paz - EI Logística
409	Castillo LLC	Castillo LLC Factory
410	Mcmillan Ltd	Mcmillan Ltd Partners
411	Azevedo Souza Ltda.	Azevedo Souza Ltda. Worldwide
412	Reyes, Kelly and Taylor	Reyes, Kelly and Taylor Verde
413	Ford LLC	Ford LLC Design
414	Jones, Allen and Glover	Jones, Allen and Glover Smart
415	da Cruz	da Cruz Digital
416	Berry-Howard	Berry-Howard Empreendimentos
417	Matthews Ltd	Matthews Ltd Operações
418	Gonçalves Borges S/A	Gonçalves Borges S/A Systems
419	Harper-Ellis	Harper-Ellis Operações
420	Mitchell-Thompson	Mitchell-Thompson Alimentos
421	Hubbard-Olsen	Hubbard-Olsen Serviços
422	Conley-Gonzalez	Conley-Gonzalez Worldwide
423	Oliveira	Oliveira Delícias
424	Myers, Oconnor and Meadows	Myers, Oconnor and Meadows Ambiental
425	Castro - ME	Castro - ME Advisors
426	Albuquerque	Albuquerque Distribuidora
427	Machado S.A.	Machado S.A. Obras
428	Vincent-Lewis	Vincent-Lewis Ambiental
429	Duarte	Duarte Gastronomia
430	Miles, Mueller and Faulkner	Miles, Mueller and Faulkner Advisors
431	Ferreira S/A	Ferreira S/A Advisors
432	Castro Jesus S/A	Castro Jesus S/A Investimentos
433	Pinto S.A.	Pinto S.A. Solutions
434	Schneider PLC	Schneider PLC Eco
435	Harris, Thornton and Sanchez	Harris, Thornton and Sanchez Logística
436	Edwards, Russell and Martinez	Edwards, Russell and Martinez Treinamento
437	Fernandes	Fernandes Networks
438	Azevedo - EI	Azevedo - EI Advisors
439	Cox, Jones and Caldwell	Cox, Jones and Caldwell Labs
440	Paul, Montoya and Smith	Paul, Montoya and Smith Co
441	Ramirez-Peters	Ramirez-Peters Inteligência
442	Baird LLC	Baird LLC Wellness
443	Smith, White and Brown	Smith, White and Brown Operações
444	Albuquerque Pereira S/A	Albuquerque Pereira S/A Next
445	Davis, Johnson and Lee	Davis, Johnson and Lee Serviços
446	Johnston and Sons	Johnston and Sons Serviços
447	da Rocha Camargo - ME	da Rocha Camargo - ME Culinária
448	Abreu Nascimento S.A.	Abreu Nascimento S.A. Agency
449	da Cunha Vieira - EI	da Cunha Vieira - EI Platform
450	Rodriguez-Floyd	Rodriguez-Floyd Boutique
451	Correia Alves S.A.	Correia Alves S.A. Holdings
452	Holt-Cooper	Holt-Cooper Next
453	Jackson-Flores	Jackson-Flores Tech
454	Rodrigues e Filhos	Rodrigues e Filhos Operações
455	Oliveira Ltda.	Oliveira Ltda. Sustentável
456	Garrett, Henry and Lewis	Garrett, Henry and Lewis Atelier
457	Austin-Lopez	Austin-Lopez Culinária
458	Vieira e Filhos	Vieira e Filhos Tecnologia
459	Aparecida	Aparecida Atacado
460	Ribeiro Novais - EI	Ribeiro Novais - EI Empreendimentos
461	Coleman-Lee	Coleman-Lee Clinic
462	West Group	West Group Strategies
463	Guerra Costa S/A	Guerra Costa S/A Ambiental
464	Pacheco Guerra e Filhos	Pacheco Guerra e Filhos Finanças
465	Dixon-Watson	Dixon-Watson Solutions
466	Brown-Holmes	Brown-Holmes Frete
467	Pimenta S/A	Pimenta S/A Works
468	Grant and Sons	Grant and Sons Next
469	Anderson-Mosley	Anderson-Mosley Studio
470	Garcia - ME	Garcia - ME Services
471	Rubio-Summers	Rubio-Summers Logística
472	Arellano-Jones	Arellano-Jones Transportes
473	Washington-Cole	Washington-Cole Moda
474	Aragão S.A.	Aragão S.A. Atacado
475	da Costa	da Costa Design
476	Ramos Ltd	Ramos Ltd Estilo
477	Arnold, Mills and Reid	Arnold, Mills and Reid Sustentável
478	Davis-Barton	Davis-Barton Inteligência
479	Stevens Inc	Stevens Inc Co
480	Gomez-Haynes	Gomez-Haynes Assessoria
481	Singh Group	Singh Group Operações
482	Monteiro Silveira e Filhos	Monteiro Silveira e Filhos Imobiliária
483	Davis, Tucker and Campos	Davis, Tucker and Campos Soluções
484	Cavalcante S/A	Cavalcante S/A Healthcare
485	Caldeira S.A.	Caldeira S.A. Strategies
486	Vasconcelos	Vasconcelos Solutions
487	Schultz-Wood	Schultz-Wood Distribuidora
488	da Cunha - ME	da Cunha - ME Strategies
489	Silva Campos - EI	Silva Campos - EI Frete
490	Waters, James and Nguyen	Waters, James and Nguyen Partners
491	Morse-Humphrey	Morse-Humphrey Tech
492	Ochoa PLC	Ochoa PLC Culinária
493	Brown, Zamora and Yates	Brown, Zamora and Yates Ambiental
494	da Costa Viana S.A.	da Costa Viana S.A. Academia
495	Macedo	Macedo Medical
496	Cavalcanti Abreu e Filhos	Cavalcanti Abreu e Filhos Investimentos
497	Perez-Cruz	Perez-Cruz Educação
498	da Paz	da Paz Culinária
499	Guerra, Howard and Rowe	Guerra, Howard and Rowe Legal
500	Pinto Ramos S/A	Pinto Ramos S/A Empreendimentos
501	Teixeira	Teixeira Factory
502	Armstrong Inc	Armstrong Inc Legal
503	Barnett, Rangel and Ferguson	Barnett, Rangel and Ferguson Platform
504	Pastor	Pastor Academia
505	Carvalho S/A	Carvalho S/A Enterprises
506	Wilson and Sons	Wilson and Sons Sustentável
507	Martins Teixeira - EI	Martins Teixeira - EI Comércio
508	Cohen Ltd	Cohen Ltd Tecnologia
509	Fonseca Ramos e Filhos	Fonseca Ramos e Filhos Universal
510	Caldeira Cassiano Ltda.	Caldeira Cassiano Ltda. Estilo
511	Roberts Inc	Roberts Inc Obras
512	Gregory-Martinez	Gregory-Martinez Frete
513	Reed, Washington and Moore	Reed, Washington and Moore Wellness
514	da Luz Peixoto Ltda.	da Luz Peixoto Ltda. Empreendimentos
515	Anderson, Hayes and English	Anderson, Hayes and English Moda
516	Araújo Fonseca e Filhos	Araújo Fonseca e Filhos Factory
517	Mcdonald-Smith	Mcdonald-Smith Private
518	Grant Ltd	Grant Ltd Worldwide
519	Caldeira Gonçalves S.A.	Caldeira Gonçalves S.A. Atelier
520	Vasconcelos Borges Ltda.	Vasconcelos Borges Ltda. Creative
521	Collins, Durham and Pittman	Collins, Durham and Pittman Educação
522	Sales e Filhos	Sales e Filhos Partners
523	Perez-Mitchell	Perez-Mitchell Investimentos
524	Williams Group	Williams Group Boutique
525	Brown Inc	Brown Inc Edge
526	Jesus Dias S.A.	Jesus Dias S.A. Edge
527	Freitas S.A.	Freitas S.A. Operações
528	Mckee, Barnes and Klein	Mckee, Barnes and Klein Wellness
529	Conrad Inc	Conrad Inc Varejo
530	Ribeiro S.A.	Ribeiro S.A. Medical
531	Martin Group	Martin Group Solutions
532	Nascimento Siqueira - ME	Nascimento Siqueira - ME Delícias
533	da Conceição - EI	da Conceição - EI Global
534	Potts Inc	Potts Inc Consultoria
535	Ward Inc	Ward Inc Consultoria
536	da Paz Dias - ME	da Paz Dias - ME Ambiental
537	Richard, Hale and Hampton	Richard, Hale and Hampton Consultoria
538	Miranda, Harris and Boyd	Miranda, Harris and Boyd Universal
539	Barros - ME	Barros - ME Inovação
540	Kelly, Greer and Thompson	Kelly, Greer and Thompson Ambiental
541	Araújo Ltda.	Araújo Ltda. Finanças
542	Williams-Flores	Williams-Flores Treinamento
543	Scott-Dyer	Scott-Dyer Varejo
544	Young Ltd	Young Ltd Enterprises
545	Leão	Leão Construções
546	Hall-Johnson	Hall-Johnson Boutique
547	Dyer, Johnson and Wilson	Dyer, Johnson and Wilson Hub
548	Perry LLC	Perry LLC Inovação
549	Potter LLC	Potter LLC Grupo
550	Santos Ltda.	Santos Ltda. Delícias
551	Romero Ltd	Romero Ltd Digital
552	Cooper Ltd	Cooper Ltd Hub
553	Moreira Oliveira Ltda.	Moreira Oliveira Ltda. Assessoria
554	Ferreira	Ferreira Inteligência
555	Vargas Barros Ltda.	Vargas Barros Ltda. Solutions
556	Carvalho Cavalcante Ltda.	Carvalho Cavalcante Ltda. Healthcare
557	Cavalcanti Ltda.	Cavalcanti Ltda. Factory
558	Lucas, Nolan and Clark	Lucas, Nolan and Clark Creative
559	da Rocha da Conceição Ltda.	da Rocha da Conceição Ltda. Assessoria
560	Cooper, Cameron and Vargas	Cooper, Cameron and Vargas Design
561	Bruce PLC	Bruce PLC Medical
562	Sá S/A	Sá S/A Varejo
563	Vieira	Vieira Smart
564	Hamilton, White and Juarez	Hamilton, White and Juarez Enterprises
565	Caldeira	Caldeira Ambiental
566	Wright, White and Rasmussen	Wright, White and Rasmussen Moda
567	Thompson, Anderson and Carlson	Thompson, Anderson and Carlson Works
568	Andrade - EI	Andrade - EI Digital
569	Sampaio Ltda.	Sampaio Ltda. International
570	Novais Marques Ltda.	Novais Marques Ltda. International
571	Alves	Alves Design
572	Adams-Anderson	Adams-Anderson Networks
573	Rezende S/A	Rezende S/A Tech
574	Aragão Ltda.	Aragão Ltda. Studio
575	Moreira Ferreira Ltda.	Moreira Ferreira Ltda. Smart
576	Garcia, Frost and Wagner	Garcia, Frost and Wagner Atacado
577	da Paz Cassiano S.A.	da Paz Cassiano S.A. Advisors
578	Weaver, Jackson and Smith	Weaver, Jackson and Smith Prime
579	Abreu - EI	Abreu - EI Global
580	Gomes Ltda.	Gomes Ltda. Medical
581	da Cunha S/A	da Cunha S/A Comércio
582	Novais - EI	Novais - EI Boutique
583	Farias S.A.	Farias S.A. Prime
584	Mercado-Rivas	Mercado-Rivas Obras
585	Borges Ltda.	Borges Ltda. Labs
586	Vasconcelos Santos - ME	Vasconcelos Santos - ME Verde
587	Gray, Blackwell and Clark	Gray, Blackwell and Clark Engine
588	Ferguson-Dunn	Ferguson-Dunn Soluções
589	Powell and Sons	Powell and Sons Treinamento
590	Daniels, Hammond and Mayer	Daniels, Hammond and Mayer Treinamento
591	Mendonça Araújo S.A.	Mendonça Araújo S.A. Educação
592	Patterson, Anderson and Fields	Patterson, Anderson and Fields International
593	da Cruz Ferreira - EI	da Cruz Ferreira - EI Comércio
594	Fisher LLC	Fisher LLC Consulting
595	Brito Cirino - ME	Brito Cirino - ME Serviços
596	Mendonça - EI	Mendonça - EI Global
597	Pugh-Jenkins	Pugh-Jenkins Solutions
598	Walker and Sons	Walker and Sons Construções
599	Scott LLC	Scott LLC Alimentos
600	Nguyen-Valenzuela	Nguyen-Valenzuela Partners
601	Jones, Smith and Hunt	Jones, Smith and Hunt Consulting
602	Foster Inc	Foster Inc Inteligência
603	Carlson Group	Carlson Group Engine
604	Araújo	Araújo Smart
605	Quinn-Walker	Quinn-Walker Factory
606	Almeida - ME	Almeida - ME Investimentos
607	Velez PLC	Velez PLC Advisors
608	Kelley, Singh and Smith	Kelley, Singh and Smith Engine
609	Siqueira das Neves e Filhos	Siqueira das Neves e Filhos Digital
610	Macedo Oliveira Ltda.	Macedo Oliveira Ltda. Enterprises
611	Silveira e Filhos	Silveira e Filhos Formação
612	Moura S.A.	Moura S.A. Works
613	Davila Ltd	Davila Ltd Design
614	Pereira - EI	Pereira - EI Soluções
615	Fonseca - ME	Fonseca - ME Soluções
616	Teixeira Siqueira - EI	Teixeira Siqueira - EI Comércio
617	Camargo	Camargo Services
618	Griffith, Wells and Brown	Griffith, Wells and Brown Next
619	Carlson, Spencer and Taylor	Carlson, Spencer and Taylor Estilo
620	Sullivan Group	Sullivan Group Advisors
621	Ramos da Cruz e Filhos	Ramos da Cruz e Filhos Imobiliária
622	Rezende Cavalcante - ME	Rezende Cavalcante - ME Boutique
623	Castillo PLC	Castillo PLC Legal
624	Johnson, Davis and Mendoza	Johnson, Davis and Mendoza Next
625	Salinas, Schmidt and Johnson	Salinas, Schmidt and Johnson Enterprises
626	Cavalcante da Cruz Ltda.	Cavalcante da Cruz Ltda. Empreendimentos
627	Richard-Anderson	Richard-Anderson Networks
628	Leão S/A	Leão S/A Capital
629	Smith-Bell	Smith-Bell Educação
630	Camacho-Atkins	Camacho-Atkins International
631	Oliveira - ME	Oliveira - ME Edge
632	Fox-Glenn	Fox-Glenn Treinamento
633	Câmara Gonçalves - ME	Câmara Gonçalves - ME Next
634	Guerra Rocha S/A	Guerra Rocha S/A Jurídico
635	Humphrey-Lloyd	Humphrey-Lloyd Prime
636	Mendes e Filhos	Mendes e Filhos Eco
637	Sales	Sales Moda
638	Lopez, White and Alvarado	Lopez, White and Alvarado Operações
639	Arnold-Wolf	Arnold-Wolf Finanças
640	Rios Brito Ltda.	Rios Brito Ltda. Comércio
641	Harris, Haynes and Tate	Harris, Haynes and Tate Private
642	Dias Pacheco e Filhos	Dias Pacheco e Filhos Design
643	Swanson Inc	Swanson Inc Hub
644	Borges - EI	Borges - EI Solutions
645	Rezende	Rezende Holdings
646	Albuquerque - ME	Albuquerque - ME Edge
647	da Cruz Câmara e Filhos	da Cruz Câmara e Filhos Tecnologia
648	Vargas Gomes - ME	Vargas Gomes - ME Advocacia
649	Parker LLC	Parker LLC Hub
650	Henderson Group	Henderson Group Delícias
651	Adams-Edwards	Adams-Edwards Academia
652	Nunes - ME	Nunes - ME Alimentos
653	Palmer, Robinson and Berry	Palmer, Robinson and Berry Atacado
654	Fernandes Ltda.	Fernandes Ltda. Frete
655	Ramos	Ramos Tecnologia
656	Sá Nunes Ltda.	Sá Nunes Ltda. Wellness
657	da Luz Siqueira Ltda.	da Luz Siqueira Ltda. Investimentos
658	Jimenez LLC	Jimenez LLC Advisors
659	Ramirez Inc	Ramirez Inc Delícias
660	Costela Souza S.A.	Costela Souza S.A. Soluções
661	Duncan-Hodges	Duncan-Hodges Medical
662	Duarte - EI	Duarte - EI Networks
663	Christian, Clark and Douglas	Christian, Clark and Douglas Digital
664	Velazquez-Phillips	Velazquez-Phillips Strategies
665	Caldwell Inc	Caldwell Inc Next
666	Smith-Perez	Smith-Perez Ambiental
667	Cunha S.A.	Cunha S.A. Atelier
668	Siqueira Ferreira S/A	Siqueira Ferreira S/A Networks
669	Rios Cavalcante S.A.	Rios Cavalcante S.A. Obras
670	Stewart, Wood and Salazar	Stewart, Wood and Salazar Estilo
671	Tran-Martin	Tran-Martin Logística
672	Cirino S.A.	Cirino S.A. Medical
673	Velazquez, Estrada and Stout	Velazquez, Estrada and Stout Delícias
674	Day-Flores	Day-Flores Delícias
675	Pittman, Herrera and Wells	Pittman, Herrera and Wells Studio
676	Jackson Ltd	Jackson Ltd Agency
677	Gamble-Morgan	Gamble-Morgan Treinamento
678	Pennington-Thompson	Pennington-Thompson Finanças
679	Barbosa Ltda.	Barbosa Ltda. Labs
680	Andrade-Estes	Andrade-Estes Tecnologia
681	Koch Group	Koch Group Studio
682	Mullins Ltd	Mullins Ltd Partners
683	Cavalcanti Silva - EI	Cavalcanti Silva - EI Healthcare
684	Carr Group	Carr Group Engine
685	Shaw-Reese	Shaw-Reese Gastronomia
686	Porto Brito Ltda.	Porto Brito Ltda. Networks
687	Moreira Ribeiro S/A	Moreira Ribeiro S/A Estilo
688	Holmes Inc	Holmes Inc Enterprises
689	Caldeira Lopes - ME	Caldeira Lopes - ME Assessoria
690	Johnson, Johnson and Sanchez	Johnson, Johnson and Sanchez Moda
691	Franco-Ramos	Franco-Ramos Frete
692	Shelton and Sons	Shelton and Sons Consultoria
693	Bell Group	Bell Group Solutions
694	Duarte - ME	Duarte - ME Varejo
695	James-Moran	James-Moran Investimentos
696	Martinez, Lynn and Peterson	Martinez, Lynn and Peterson Edge
697	Randolph Ltd	Randolph Ltd Clinic
698	Warner-Cook	Warner-Cook Delícias
699	Fogaça S.A.	Fogaça S.A. Platform
700	Cavalcanti - ME	Cavalcanti - ME Universal
701	Nascimento Farias S/A	Nascimento Farias S/A Academia
702	da Costa - ME	da Costa - ME Investimentos
703	Rezende - ME	Rezende - ME Systems
704	Roberts-Love	Roberts-Love Worldwide
705	Wade, Vargas and Brooks	Wade, Vargas and Brooks Edge
706	Montenegro S.A.	Montenegro S.A. Works
707	Simmons, Jackson and Davis	Simmons, Jackson and Davis Atacado
708	Kelly and Sons	Kelly and Sons Moda
709	Tran-Sanford	Tran-Sanford Creative
710	Little LLC	Little LLC Consultoria
711	Cavalcante Novaes - EI	Cavalcante Novaes - EI Jurídico
712	Vargas	Vargas Collective
713	Nunes	Nunes Academia
714	Johnston Inc	Johnston Inc Treinamento
715	Nascimento S.A.	Nascimento S.A. Soluções
716	Monteiro Mendes Ltda.	Monteiro Mendes Ltda. Collective
717	Borges S.A.	Borges S.A. Engine
718	Castro da Rocha e Filhos	Castro da Rocha e Filhos Tecnologia
719	Casey, Roach and Carney	Casey, Roach and Carney Holdings
720	Nguyen-Rangel	Nguyen-Rangel Agency
721	Pacheco S/A	Pacheco S/A Creative
722	Rezende Correia Ltda.	Rezende Correia Ltda. Atelier
723	da Costa Montenegro S/A	da Costa Montenegro S/A Distribuidora
724	da Cunha Moura e Filhos	da Cunha Moura e Filhos Eco
725	Abreu	Abreu Serviços
726	Perez-Howard	Perez-Howard Engine
727	Sampaio - ME	Sampaio - ME Verde
728	Brown, Stewart and Rosario	Brown, Stewart and Rosario Operações
729	Mendes Peixoto S.A.	Mendes Peixoto S.A. Boutique
730	Oliver Ltd	Oliver Ltd Labs
731	Mcclain Ltd	Mcclain Ltd Systems
732	Raymond, Sims and Kelley	Raymond, Sims and Kelley Construções
733	Campos	Campos Consultoria
734	Souza Ltda.	Souza Ltda. Networks
735	Clark Ltd	Clark Ltd Investimentos
736	Cassiano da Mota Ltda.	Cassiano da Mota Ltda. Varejo
737	Martins Cardoso S.A.	Martins Cardoso S.A. Distribuidora
738	Cavalcante e Filhos	Cavalcante e Filhos Educação
739	Hopkins Group	Hopkins Group Logística
740	Rios - EI	Rios - EI Agency
741	Hudson-Pugh	Hudson-Pugh Smart
742	Freitas Moura S/A	Freitas Moura S/A Distribuidora
743	Novais Ltda.	Novais Ltda. Delícias
744	Schroeder, Kennedy and Brandt	Schroeder, Kennedy and Brandt Frete
745	Nunes Costela e Filhos	Nunes Costela e Filhos Inovação
746	Marques S.A.	Marques S.A. Logística
747	Melo e Filhos	Melo e Filhos Varejo
748	Rodriguez, Hanson and Anderson	Rodriguez, Hanson and Anderson Next
749	Mendonça S.A.	Mendonça S.A. Edge
750	Dias Ltda.	Dias Ltda. Varejo
751	Davis, Walls and Cox	Davis, Walls and Cox Construções
752	Garcia Moraes S/A	Garcia Moraes S/A Advisors
753	Ferreira Sá S/A	Ferreira Sá S/A Construções
754	Tucker, Long and Cox	Tucker, Long and Cox Healthcare
755	Bradley-Ray	Bradley-Ray Delícias
756	Brock-Griffin	Brock-Griffin Engine
757	Martinez-Freeman	Martinez-Freeman Studio
758	Gonçalves - ME	Gonçalves - ME Advisors
759	Stephenson-Reilly	Stephenson-Reilly Engine
760	Cavalcante	Cavalcante Verde
761	Cunha S/A	Cunha S/A Obras
762	Câmara Rodrigues - ME	Câmara Rodrigues - ME Verde
763	Boyd and Sons	Boyd and Sons Universal
764	Gomes e Filhos	Gomes e Filhos Prime
765	Rogers and Sons	Rogers and Sons Solutions
766	Ruiz PLC	Ruiz PLC Atelier
767	Golden, Gomez and Clark	Golden, Gomez and Clark Tecnologia
768	Vieira Ltda.	Vieira Ltda. Eco
769	Sandoval, Schultz and Pittman	Sandoval, Schultz and Pittman Comércio
770	da Mata e Filhos	da Mata e Filhos Universal
771	Ramos S.A.	Ramos S.A. Advisors
772	Ramos Andrade - EI	Ramos Andrade - EI Boutique
773	Carvalho - ME	Carvalho - ME Healthcare
774	Holder-Valenzuela	Holder-Valenzuela Co
775	Ramsey Ltd	Ramsey Ltd Inovação
776	Jackson Group	Jackson Group Atacado
777	Lopes Fogaça Ltda.	Lopes Fogaça Ltda. Consultoria
778	Bailey Inc	Bailey Inc Distribuidora
779	Clayton, Sanders and Wheeler	Clayton, Sanders and Wheeler Digital
780	Davis, Murphy and Hebert	Davis, Murphy and Hebert Labs
781	Williams-Nelson	Williams-Nelson Labs
782	Marks-Walker	Marks-Walker Co
783	Warner, Wells and Mitchell	Warner, Wells and Mitchell Empreendimentos
784	Rocha Ribeiro S.A.	Rocha Ribeiro S.A. Obras
785	Carrillo-Brown	Carrillo-Brown Digital
786	Pimenta S.A.	Pimenta S.A. Transportes
787	da Cruz Teixeira S/A	da Cruz Teixeira S/A Agency
788	Scott-Sanchez	Scott-Sanchez Healthcare
789	Martins Carvalho S/A	Martins Carvalho S/A Operações
790	Valdez, Moore and Novak	Valdez, Moore and Novak Imobiliária
791	Barr-Eaton	Barr-Eaton Consultoria
792	Perkins Group	Perkins Group Worldwide
793	Gamble, Young and Miller	Gamble, Young and Miller Consultoria
794	Cain-Walters	Cain-Walters Verde
795	Jacobs, Saunders and Molina	Jacobs, Saunders and Molina Verde
796	Rocha Rios Ltda.	Rocha Rios Ltda. Boutique
797	Câmara Cavalcanti e Filhos	Câmara Cavalcanti e Filhos Jurídico
798	Viana - ME	Viana - ME Investimentos
799	Borges Fernandes S.A.	Borges Fernandes S.A. Atacado
800	Webb-Pruitt	Webb-Pruitt Atacado
801	Perkins-Holt	Perkins-Holt Clinic
802	Lopes - EI	Lopes - EI Enterprises
803	Moraes Ltda.	Moraes Ltda. Edge
804	Cardoso Carvalho S.A.	Cardoso Carvalho S.A. Eco
805	Oliver-Grimes	Oliver-Grimes Solutions
806	Pacheco e Filhos	Pacheco e Filhos Next
807	Rios	Rios Transportes
808	Anderson and Sons	Anderson and Sons Solutions
809	Novaes Aragão e Filhos	Novaes Aragão e Filhos Private
810	Ewing, Carroll and Maxwell	Ewing, Carroll and Maxwell Frete
811	Wallace, Smith and Pruitt	Wallace, Smith and Pruitt Transportes
812	da Cruz S.A.	da Cruz S.A. Estilo
813	Barber, Fuller and Thomas	Barber, Fuller and Thomas Clinic
814	da Costa Cirino e Filhos	da Costa Cirino e Filhos Serviços
815	Novais Fernandes Ltda.	Novais Fernandes Ltda. Enterprises
816	Costela	Costela Networks
817	Hodges, Oconnor and Gardner	Hodges, Oconnor and Gardner Educação
818	Garcia, Price and Yoder	Garcia, Price and Yoder Eco
819	Montenegro S/A	Montenegro S/A Tech
820	Christensen Inc	Christensen Inc Legal
821	Rocha e Filhos	Rocha e Filhos International
822	Santos Leão e Filhos	Santos Leão e Filhos Solutions
823	Wright PLC	Wright PLC Solutions
824	Hernandez, Hernandez and Diaz	Hernandez, Hernandez and Diaz Co
825	Lucas Group	Lucas Group Tecnologia
826	Moody LLC	Moody LLC Engine
827	Mata PLC	Mata PLC Co
828	Cavalcanti - EI	Cavalcanti - EI Works
829	Pinto Brito e Filhos	Pinto Brito e Filhos Finanças
830	Flores Ltd	Flores Ltd Platform
831	Garza, Gomez and Miller	Garza, Gomez and Miller Networks
832	Tucker and Sons	Tucker and Sons Imobiliária
833	Pacheco Abreu S/A	Pacheco Abreu S/A Atacado
834	Rivers, Molina and Moreno	Rivers, Molina and Moreno Logística
835	Chavez-Tran	Chavez-Tran Worldwide
836	Johnson, Wilkerson and Curtis	Johnson, Wilkerson and Curtis Estilo
837	Viana - EI	Viana - EI Alimentos
838	Martins S/A	Martins S/A Smart
839	Ramos Alves S.A.	Ramos Alves S.A. Culinária
840	Teixeira Sousa e Filhos	Teixeira Sousa e Filhos Healthcare
841	Welch-Horn	Welch-Horn Creative
842	Cavalcanti Sousa S/A	Cavalcanti Sousa S/A Frete
843	Freitas Novais - EI	Freitas Novais - EI Partners
844	Aparecida Sampaio - ME	Aparecida Sampaio - ME Formação
845	Leão Ltda.	Leão Ltda. Legal
846	Siqueira Farias Ltda.	Siqueira Farias Ltda. Advisors
847	Reynolds Group	Reynolds Group Grupo
848	Melo - ME	Melo - ME Distribuidora
849	Salinas-Watkins	Salinas-Watkins Grupo
850	da Rosa S/A	da Rosa S/A Creative
851	Wells-Cox	Wells-Cox Strategies
852	Larson, Matthews and Thomas	Larson, Matthews and Thomas Inovação
853	Carr-Hernandez	Carr-Hernandez Alimentos
854	Cunha	Cunha Advisors
855	Bowman, Richardson and Cortez	Bowman, Richardson and Cortez Soluções
856	Borges Carvalho - ME	Borges Carvalho - ME Inovação
857	Williams, Boyd and Williams	Williams, Boyd and Williams Atelier
858	Lee-Burns	Lee-Burns Assessoria
859	Souza Moura e Filhos	Souza Moura e Filhos International
860	Gomes Silveira - EI	Gomes Silveira - EI Investimentos
861	Bailey, Wilson and Carlson	Bailey, Wilson and Carlson Inovação
862	Pimenta da Mata S/A	Pimenta da Mata S/A Global
863	Costa S/A	Costa S/A Academia
864	Leão Campos e Filhos	Leão Campos e Filhos Boutique
865	da Paz - ME	da Paz - ME Consulting
866	Lima Borges - EI	Lima Borges - EI Worldwide
867	Frazier and Sons	Frazier and Sons Agency
868	Foster-Sosa	Foster-Sosa Treinamento
869	Borges - ME	Borges - ME Next
870	Brown-Bryant	Brown-Bryant Alimentos
871	Cassiano Ltda.	Cassiano Ltda. Atacado
872	Jones, Lopez and Thomas	Jones, Lopez and Thomas Factory
873	Green PLC	Green PLC Smart
874	Boyer Group	Boyer Group Jurídico
875	Sawyer, Obrien and Potter	Sawyer, Obrien and Potter Prime
876	Cruz PLC	Cruz PLC Collective
877	Moran-Caldwell	Moran-Caldwell Varejo
878	Butler-Hahn	Butler-Hahn Delícias
879	Azevedo Fonseca - EI	Azevedo Fonseca - EI Jurídico
880	Mullins, Chavez and Moore	Mullins, Chavez and Moore Ambiental
881	Brown-Pearson	Brown-Pearson Obras
882	Souza e Filhos	Souza e Filhos Eco
883	Vargas Novais - ME	Vargas Novais - ME Jurídico
884	Gomez Inc	Gomez Inc Edge
885	Lyons-Edwards	Lyons-Edwards Alimentos
886	Barrett, Miller and Bowen	Barrett, Miller and Bowen Academia
887	Hansen, Miranda and Wise	Hansen, Miranda and Wise Wellness
888	Carroll, Donaldson and Weaver	Carroll, Donaldson and Weaver Collective
889	Wright LLC	Wright LLC Healthcare
890	Lopes Cardoso S/A	Lopes Cardoso S/A Construções
891	Hill-Strickland	Hill-Strickland Inovação
892	Porto Castro - ME	Porto Castro - ME Collective
893	Siqueira Caldeira S.A.	Siqueira Caldeira S.A. Culinária
894	da Mota Barbosa S/A	da Mota Barbosa S/A Frete
895	King, Avery and Campbell	King, Avery and Campbell Imobiliária
896	Santos S.A.	Santos S.A. Boutique
897	Savage-Clark	Savage-Clark Edge
898	May-Torres	May-Torres Finanças
899	Simmons Ltd	Simmons Ltd Clinic
900	Aparecida Camargo Ltda.	Aparecida Camargo Ltda. Culinária
901	Cunha Novais e Filhos	Cunha Novais e Filhos Estilo
902	Oliver-Holt	Oliver-Holt Sustentável
903	Lewis-Howell	Lewis-Howell Holdings
904	Borges	Borges Obras
905	Strickland, Fuller and Horne	Strickland, Fuller and Horne Tech
906	Moraes Lopes S.A.	Moraes Lopes S.A. Enterprises
907	Davis PLC	Davis PLC Advisors
908	Wallace-Baxter	Wallace-Baxter Boutique
909	Thomas, Lopez and Banks	Thomas, Lopez and Banks Global
910	Moraes Silveira S/A	Moraes Silveira S/A Healthcare
911	Keller LLC	Keller LLC Ambiental
912	Hunt Inc	Hunt Inc Partners
913	Rezende e Filhos	Rezende e Filhos Inovação
914	Silva Camargo - EI	Silva Camargo - EI Agency
915	Araújo Costa Ltda.	Araújo Costa Ltda. Edge
916	Tran-Curry	Tran-Curry Academia
917	da Rosa Ramos Ltda.	da Rosa Ramos Ltda. Next
918	Cirino S/A	Cirino S/A Imobiliária
919	Wilkins Ltd	Wilkins Ltd Advisors
920	Dawson-Green	Dawson-Green Solutions
921	Alexander, Gordon and Warren	Alexander, Gordon and Warren Verde
922	Hines, Frazier and Cuevas	Hines, Frazier and Cuevas Moda
923	da Costa - EI	da Costa - EI Boutique
924	Fogaça Viana e Filhos	Fogaça Viana e Filhos Design
925	Frank-Cook	Frank-Cook Construções
926	Vasquez Inc	Vasquez Inc Jurídico
927	Harris, Smith and Moore	Harris, Smith and Moore Consulting
928	Mendes - EI	Mendes - EI Formação
929	Hamilton PLC	Hamilton PLC Services
930	Villarreal-Richardson	Villarreal-Richardson Estilo
931	Mason-Flores	Mason-Flores Solutions
932	Jenkins and Sons	Jenkins and Sons Logística
933	Ferreira Sales e Filhos	Ferreira Sales e Filhos Finanças
934	Camargo Andrade S.A.	Camargo Andrade S.A. Legal
935	Ingram-Cook	Ingram-Cook Eco
936	da Mota da Cruz e Filhos	da Mota da Cruz e Filhos Enterprises
937	Lyons Inc	Lyons Inc Gastronomia
938	da Cruz Ferreira - ME	da Cruz Ferreira - ME Atacado
939	Butler, Hall and Smith	Butler, Hall and Smith Sustentável
940	Nogueira Abreu e Filhos	Nogueira Abreu e Filhos Capital
941	Lynch PLC	Lynch PLC Next
942	Davis-Newman	Davis-Newman Inovação
943	Pastor S.A.	Pastor S.A. Edge
944	Brown PLC	Brown PLC Agency
945	Vieira S/A	Vieira S/A Tecnologia
946	Cooper, Fitzgerald and Campbell	Cooper, Fitzgerald and Campbell Soluções
947	Heath, Phillips and Johnson	Heath, Phillips and Johnson Legal
948	Garcia S.A.	Garcia S.A. Operações
949	Ryan, Richmond and Tucker	Ryan, Richmond and Tucker Collective
950	Mcdaniel Group	Mcdaniel Group Solutions
951	Gonzales Inc	Gonzales Inc Works
952	da Paz Pereira Ltda.	da Paz Pereira Ltda. Soluções
953	Cunningham and Sons	Cunningham and Sons Wellness
954	Freitas Ltda.	Freitas Ltda. Obras
955	Cross-Wright	Cross-Wright Atelier
956	da Luz Pires - ME	da Luz Pires - ME Hub
957	Pereira S.A.	Pereira S.A. Imobiliária
958	Crawford-Davis	Crawford-Davis Verde
959	Oliveira Rodrigues S.A.	Oliveira Rodrigues S.A. Solutions
960	Ferreira - EI	Ferreira - EI Grupo
961	Blackwell Inc	Blackwell Inc Co
962	Monteiro Nascimento S/A	Monteiro Nascimento S/A Frete
963	Viana S.A.	Viana S.A. Culinária
964	Davis-Newton	Davis-Newton Creative
965	Ribeiro Moreira S/A	Ribeiro Moreira S/A Eco
966	Lyons-Thomas	Lyons-Thomas Verde
967	Oconnell, Flynn and Dawson	Oconnell, Flynn and Dawson Labs
968	Jones Ltd	Jones Ltd Edge
969	Correia Rocha S/A	Correia Rocha S/A Co
970	Sales Albuquerque - EI	Sales Albuquerque - EI Boutique
971	Wells Group	Wells Group Alimentos
972	da Paz da Cruz S/A	da Paz da Cruz S/A Services
973	Jesus S.A.	Jesus S.A. Global
974	Novaes - EI	Novaes - EI Capital
975	Montenegro Ltda.	Montenegro Ltda. Holdings
976	Castro Souza S.A.	Castro Souza S.A. Global
977	Santos - EI	Santos - EI Tech
978	Kerr-Brown	Kerr-Brown Capital
979	Monteiro - ME	Monteiro - ME Consultoria
980	Peixoto S.A.	Peixoto S.A. Digital
981	Morris Inc	Morris Inc Engine
982	Taylor-Ortiz	Taylor-Ortiz Universal
983	Griffin Group	Griffin Group Solutions
984	da Conceição Ferreira - EI	da Conceição Ferreira - EI Next
985	Taylor-Patterson	Taylor-Patterson Works
986	Alvarez LLC	Alvarez LLC Transportes
987	Aragão - EI	Aragão - EI Serviços
988	Pires - EI	Pires - EI Investimentos
989	Souza Camargo S/A	Souza Camargo S/A Clinic
990	Freitas - ME	Freitas - ME Boutique
991	Bailey-Smith	Bailey-Smith Boutique
992	Webb-Gutierrez	Webb-Gutierrez Works
993	Gomes Farias S/A	Gomes Farias S/A Grupo
994	Mack-Parks	Mack-Parks Ambiental
995	Marques - EI	Marques - EI Atacado
996	Araújo Cunha - ME	Araújo Cunha - ME Jurídico
997	Spence Inc	Spence Inc Serviços
998	Delgado-Taylor	Delgado-Taylor Consultoria
999	Ellis PLC	Ellis PLC Factory
1000	Oliver, Williams and Villarreal	Oliver, Williams and Villarreal Enterprises
\.


--
-- TOC entry 5252 (class 0 OID 16498)
-- Dependencies: 237
-- Data for Name: empresa_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa_pais (nro_empresa, id_nacional, nome_pais) FROM stdin;
179	ANG-869224351	Angola
67	PAR-689695377	Paraguay
178	PAR-397619401	Paraguay
561	LEB-245054155	Lebanon
66	BEL-489026246	Belize
44	RWA-826540463	Rwanda
329	PUE-025325879	Puerto Rico
161	CUB-983780038	Cuba
857	LIE-502998010	Liechtenstein
79	PHI-871768327	Philippines
770	KAZ-797032631	Kazakhstan
583	PHI-723291270	Philippines
230	MAL-301301745	Malawi
676	ALB-593137727	Albania
692	POL-431964658	Poland
563	LAO-054263480	Laos
192	ANG-204809829	Angola
536	ISR-506660798	Israel
526	SYR-152716866	Syria
25	JOR-786467026	Jordan
261	KAZ-854870262	Kazakhstan
402	FIJ-258848948	Fiji
294	HON-850025676	Honduras
671	BEL-862731966	Belize
660	SUR-157210986	Suriname
551	ANG-375302390	Angola
66	AFG-923176217	Afghanistan
529	CZE-397978561	Czechia
982	MOZ-383745842	Mozambique
507	AZE-371927331	Azerbaijan
49	VAN-170343338	Vanuatu
207	CUB-163408476	Cuba
231	DEN-415234929	Denmark
429	MON-219738829	Mongolia
570	GIB-446498611	Gibraltar
566	SAI-354090586	Saint Helena, Ascension and Tristan da Cunha
921	ETH-732239527	Ethiopia
618	PNG-300222091	Papua New Guinea
786	ARU-428512225	Aruba
443	FAL-072344129	Falkland Islands
142	PAL-491382404	Palestine
29	BAH-863506519	Bahamas
435	OMA-778119801	Oman
772	SAM-417294824	Samoa
375	SEY-065750368	Seychelles
44	BUR-427524287	Burundi
949	NAM-865389560	Namibia
451	BAH-849075534	Bahrain
784	MAL-134781856	Maldives
917	MEX-107811683	Mexico
639	ERI-106442602	Eritrea
38	MAD-489641215	Madagascar
613	JOR-584984930	Jordan
737	BUL-801212207	Bulgaria
207	MAL-890113264	Maldives
981	SAI-767390815	Saint Helena, Ascension and Tristan da Cunha
81	NOR-463362878	Norway
918	BUR-896136541	Burundi
784	LIB-660823073	Liberia
211	TAT-792547227	Trinidad and Tobago
938	MAC-291868323	Macau
460	SUD-377021192	Sudan
979	LAO-514416668	Laos
284	NIC-246725356	Nicaragua
115	DEN-043131602	Denmark
117	URU-484864550	Uruguay
733	MAL-152837905	Maldives
28	SRI-297427217	Sri Lanka
476	LEB-148282583	Lebanon
428	TUN-223285208	Tunisia
229	SOU-005505300	South Korea
886	LES-452047957	Lesotho
756	BER-612218474	Bermuda
807	PUE-325061104	Puerto Rico
990	NOR-946049136	North Macedonia
561	AND-102283289	Andorra
811	ARM-953355158	Armenia
85	RUS-359707703	Russia
420	MAC-655992566	Macau
278	PHI-599267655	Philippines
77	NIC-041410739	Nicaragua
743	SYR-404557501	Syria
586	LAO-592987936	Laos
303	BAH-116784117	Bahamas
372	IND-889398523	India
926	FAL-529488135	Falkland Islands
817	COS-263157421	Costa Rica
892	NOR-836407946	Norway
574	UKR-909295482	Ukraine
873	SAM-634615126	Samoa
771	GUI-345573872	Guinea
191	RWA-037423681	Rwanda
202	MYA-060330514	Myanmar
603	SER-696720998	Serbia
738	URU-063999819	Uruguay
877	COM-875869913	Comoros
459	CAY-314279928	Cayman Islands
945	MOR-946509262	Morocco
199	SAM-177739840	Samoa
558	MAD-019368981	Madagascar
474	SER-582937645	Serbia
372	YEM-561749638	Yemen
104	CAR-658112543	Central African Republic
817	NIG-130642746	Nigeria
48	YEM-739318555	Yemen
632	BOT-722689376	Botswana
991	BRU-614738048	Brunei
686	CUR-098652674	Curaçao
565	COM-798880181	Comoros
354	YEM-349781173	Yemen
635	MAC-175548117	Macau
677	GIB-417383692	Gibraltar
318	PUE-147029936	Puerto Rico
976	UZB-769125767	Uzbekistan
770	ISR-527370198	Israel
312	NIU-740317836	Niue
733	ROM-083814431	Romania
374	MAL-171209680	Malawi
205	SAU-668550598	Saudi Arabia
343	SRI-774139100	Sri Lanka
588	BAN-074973718	Bangladesh
896	SIN-290300868	Singapore
631	FIJ-771519324	Fiji
629	PUE-045180870	Puerto Rico
799	SER-590584716	Serbia
419	TUN-738062550	Tunisia
489	TAI-985490975	Taiwan
59	MEX-873959868	Mexico
952	SUR-231448723	Suriname
604	SAM-679719527	Samoa
195	YEM-113530476	Yemen
801	SYR-537930285	Syria
20	ROM-180194398	Romania
784	NEP-133308893	Nepal
809	FIJ-728859321	Fiji
685	MAL-433840475	Malaysia
727	NIG-871302095	Nigeria
995	COS-403086004	Costa Rica
268	IND-810921458	India
48	TAI-487357427	Taiwan
320	NIC-114084459	Nicaragua
439	MEX-178528600	Mexico
187	SWE-661575669	Sweden
44	NOR-778547780	Norway
762	ROM-135093235	Romania
457	COM-825029637	Comoros
395	BAH-868808765	Bosnia and Herzegovina
272	SEY-525758041	Seychelles
329	SYR-412709977	Syria
846	NOR-524909923	North Korea
192	JOR-725771169	Jordan
910	CAR-706807516	Central African Republic
962	LIE-750777356	Liechtenstein
925	AZE-945709038	Azerbaijan
792	LEB-037422306	Lebanon
553	DJI-471940611	Djibouti
791	DOM-115203658	Dominican Republic
506	NAM-006016005	Namibia
380	LIB-844088479	Liberia
639	UKR-179363443	Ukraine
890	SAI-406820055	Saint Helena, Ascension and Tristan da Cunha
309	SAI-942379496	Saint Lucia
935	BAH-526574309	Bosnia and Herzegovina
883	SIN-084705421	Singapore
231	TUR-520685327	Turkey
191	GEO-012549207	Georgia
369	AZE-880709108	Azerbaijan
729	DOM-877045990	Dominican Republic
335	BOL-427563123	Bolivia
617	MEX-425484918	Mexico
751	AZE-336995478	Azerbaijan
149	TON-561600639	Tonga
46	MAL-359234566	Malawi
848	BUL-992882951	Bulgaria
861	TUR-780484845	Turkey
363	QAT-209673439	Qatar
892	SWE-076450373	Sweden
486	BAH-754116374	Bosnia and Herzegovina
476	HAI-487689464	Haiti
753	SAI-785145921	Saint Helena, Ascension and Tristan da Cunha
465	BAH-302342830	Bahrain
684	KYR-030086080	Kyrgyzstan
49	QAT-789423694	Qatar
145	LEB-071413685	Lebanon
873	AFG-218777052	Afghanistan
292	SER-219778040	Serbia
163	SUR-975298618	Suriname
46	THA-811839170	Thailand
446	BRU-828917279	Brunei
740	GUI-857442643	Guinea
552	CUB-594907200	Cuba
560	TAI-136554789	Taiwan
172	SUD-015369116	Sudan
151	YEM-150314915	Yemen
270	BOL-987845317	Bolivia
725	DEN-298139800	Denmark
106	PAL-158895141	Palestine
12	PAK-397905521	Pakistan
370	GUA-481551871	Guatemala
308	BAH-863594060	Bahrain
823	GUI-286213568	Guinea
50	AND-896038011	Andorra
494	THA-378709869	Thailand
904	BAH-530612854	Bahrain
855	VIE-328873605	Vietnam
47	UAE-835101972	United Arab Emirates
356	JAP-850102022	Japan
448	PAK-737567627	Pakistan
680	ISR-883519022	Israel
407	CUB-875297323	Cuba
133	YEM-568377780	Yemen
938	CZE-142419338	Czechia
844	SRI-304221605	Sri Lanka
37	MAU-447483707	Mauritius
268	THA-265335903	Thailand
624	AND-407342705	Andorra
803	SER-902899842	Serbia
236	JAP-107359919	Japan
5	SAM-592074308	Samoa
504	ERI-842961296	Eritrea
975	POL-073070686	Poland
841	SIN-669629604	Singapore
304	PAL-263076248	Palestine
282	CZE-534288441	Czechia
908	WES-618047811	Western Sahara
616	BHU-643461406	Bhutan
712	JAP-836948090	Japan
318	DOM-035266756	Dominican Republic
24	COL-309650404	Colombia
539	MAD-743882166	Madagascar
210	ARU-849062253	Aruba
361	CHI-804536765	China
574	BER-034346318	Bermuda
116	PAK-267357786	Pakistan
340	COS-530294194	Costa Rica
623	NOR-598342805	Norway
59	BEL-432785824	Belize
736	ARG-313806739	Argentina
650	KIR-671411897	Kiribati
67	ANG-174442772	Angola
427	CAP-093418289	Cape Verde
418	CAR-050573682	Central African Republic
144	FIJ-810066423	Fiji
388	SER-224251133	Serbia
689	COS-959664981	Costa Rica
90	SEY-534036939	Seychelles
936	SUD-021188143	Sudan
569	DEN-840319757	Denmark
553	ARU-456719886	Aruba
164	ERI-116611392	Eritrea
462	NOR-137569203	Norway
766	MAC-215141417	Macau
260	DJI-536836699	Djibouti
164	CAR-023148382	Central African Republic
149	CUB-665119440	Cuba
653	COS-662419175	Costa Rica
197	CAM-266181101	Cambodia
257	SEY-932748193	Seychelles
753	BAH-607272643	Bahrain
279	BRA-613147295	Brazil
860	BAH-167609174	Bahrain
688	NIU-144575679	Niue
420	KYR-077704953	Kyrgyzstan
879	BHU-640292748	Bhutan
926	HON-654213455	Honduras
747	MEX-015584859	Mexico
894	MAC-374961150	Macau
903	LEB-859772425	Lebanon
35	SWE-703964500	Sweden
374	MYA-892541386	Myanmar
478	BUL-040457058	Bulgaria
66	KAZ-518844459	Kazakhstan
460	SAI-350030359	Saint Lucia
623	FAL-496289547	Falkland Islands
847	LES-726428095	Lesotho
84	BRU-311130428	Brunei
908	TUR-660831656	Turkey
157	VAN-435557600	Vanuatu
715	UZB-671964126	Uzbekistan
559	NEP-176281223	Nepal
477	TAI-024702446	Taiwan
730	BAN-857310415	Bangladesh
95	BEL-052870535	Belize
706	LIB-582239359	Libya
50	HAI-866023344	Haiti
743	MOZ-781692121	Mozambique
689	CUR-265283828	Curaçao
2	CAM-608653645	Cambodia
766	WES-792817021	Western Sahara
295	BRA-296935561	Brazil
967	CAP-984201743	Cape Verde
687	DOM-963553469	Dominican Republic
255	BAN-037109496	Bangladesh
294	CAR-352260196	Central African Republic
285	JAP-023072155	Japan
618	AFG-963105508	Afghanistan
879	COL-115816327	Colombia
552	ISR-657447971	Israel
961	BUR-837330431	Burundi
505	KIR-534373623	Kiribati
679	FIJ-437278688	Fiji
515	PAN-283786452	Panama
631	BRU-810795087	Brunei
386	ROM-829504302	Romania
973	IND-459429790	India
202	SWE-593197243	Sweden
523	GUA-887965630	Guatemala
366	UZB-291077618	Uzbekistan
649	CAY-742299959	Cayman Islands
603	NIG-697853530	Nigeria
915	BAH-807157347	Bahamas
453	YEM-268378098	Yemen
637	SRI-826974601	Sri Lanka
483	SOU-369222328	South Korea
124	SUR-908782011	Suriname
308	NIU-673875330	Niue
609	BRA-031528329	Brazil
725	TAI-624477715	Taiwan
539	TAT-894860435	Trinidad and Tobago
89	KYR-005547393	Kyrgyzstan
346	KYR-612809347	Kyrgyzstan
754	TON-251000971	Tonga
687	NOR-043078450	Norway
146	BER-218879526	Bermuda
172	QAT-099205666	Qatar
305	NIC-927934839	Nicaragua
952	AFG-614094310	Afghanistan
588	COL-930118555	Colombia
534	NOR-626979296	North Korea
535	PAL-503767710	Palestine
282	URU-504432481	Uruguay
384	PHI-141403435	Philippines
88	IND-908807735	India
818	ERI-196048970	Eritrea
521	TAJ-052307364	Tajikistan
292	GEO-617561592	Georgia
630	SOL-587102773	Solomon Islands
829	NIG-936392976	Nigeria
268	SUR-174905319	Suriname
696	CAN-207717033	Canada
549	CAN-614565173	Canada
777	PHI-949847876	Philippines
658	HAI-979593720	Haiti
657	MOR-157097047	Morocco
746	SUD-837404287	Sudan
142	TUN-266203026	Tunisia
962	NIG-983150857	Nigeria
587	CUB-347080420	Cuba
496	PAN-663322629	Panama
303	IND-781101974	India
168	MAC-651769850	Macau
655	GIB-753594931	Gibraltar
92	BUR-829977753	Burundi
612	CHI-920804713	Chile
564	MAU-256105296	Mauritius
850	ROM-712291924	Romania
569	CAM-210474505	Cambodia
699	SUD-496268965	Sudan
824	BRU-073548342	Brunei
947	BAH-371552913	Bahrain
496	TAT-106477148	Trinidad and Tobago
287	DJI-649593859	Djibouti
185	BER-889683355	Bermuda
924	CAP-247846215	Cape Verde
134	KYR-070015406	Kyrgyzstan
446	BAH-335903907	Bahamas
249	AND-334054931	Andorra
429	CZE-648967829	Czechia
555	COL-082660667	Colombia
474	LIB-507899409	Liberia
772	BRA-974762139	Brazil
245	CAN-428075509	Canada
27	NOR-522667139	North Macedonia
825	NOR-515219003	North Macedonia
275	BAH-065101390	Bosnia and Herzegovina
998	BRU-704305482	Brunei
11	NIG-245954127	Nigeria
693	VAN-815823950	Vanuatu
459	SWE-832540830	Sweden
15	ZAM-759872272	Zambia
299	CAY-852660602	Cayman Islands
755	MAU-187621594	Mauritius
373	MAL-039406522	Malaysia
861	CAR-694932189	Central African Republic
32	MEX-233836071	Mexico
35	CUB-182261383	Cuba
631	PAK-909851138	Pakistan
412	BOL-267461407	Bolivia
319	JAP-299977475	Japan
971	CAY-905537805	Cayman Islands
864	PAN-721729195	Panama
944	TUN-297252711	Tunisia
321	SAI-258205636	Saint Helena, Ascension and Tristan da Cunha
760	MAL-074865418	Malaysia
419	MOR-515421932	Morocco
935	SAI-380089114	Saint Lucia
508	CAM-797197296	Cambodia
869	KYR-024610167	Kyrgyzstan
388	RUS-451236233	Russia
729	DJI-585539476	Djibouti
577	CAM-154865465	Cambodia
397	ETH-361122758	Ethiopia
945	MAU-859075700	Mauritius
935	SAI-709936770	Saint Helena, Ascension and Tristan da Cunha
811	COL-059207376	Colombia
180	KAZ-641358259	Kazakhstan
240	NIC-855044248	Nicaragua
16	VAN-960474543	Vanuatu
314	HUN-488103519	Hungary
289	FIJ-245814643	Fiji
789	NIG-864531330	Nigeria
453	SAU-970504769	Saudi Arabia
501	WAF-577224205	Wallis and Futuna
535	THA-091968011	Thailand
186	NAM-777552323	Namibia
907	BOL-068691822	Bolivia
510	BAN-687551639	Bangladesh
801	FIJ-679937389	Fiji
512	SOU-356532339	South Korea
239	COS-880299380	Costa Rica
307	PAN-379995730	Panama
260	GHA-678324983	Ghana
873	BER-115371198	Bermuda
149	NOR-551680874	Norway
698	BOT-455670319	Botswana
263	JAP-383110556	Japan
479	ARM-690166009	Armenia
316	ARG-315065800	Argentina
72	GUI-284390072	Guinea
547	FIJ-483476962	Fiji
520	ARU-186004317	Aruba
146	GEO-553736308	Georgia
767	BAH-685249809	Bosnia and Herzegovina
363	COL-494347336	Colombia
389	SUD-919606282	Sudan
868	COS-901698052	Costa Rica
63	AND-694040093	Andorra
592	AFG-374015516	Afghanistan
220	BOT-441588694	Botswana
492	PER-231064336	Peru
923	BUL-917623220	Bulgaria
903	MYA-741874457	Myanmar
656	KAZ-587965159	Kazakhstan
176	CAN-225696259	Canada
934	GUI-687231051	Guinea
906	SRI-065754816	Sri Lanka
730	BUL-812697628	Bulgaria
260	OMA-169914808	Oman
489	BAH-138945781	Bahamas
911	MEX-239143583	Mexico
548	ARM-158034204	Armenia
318	COM-568797983	Comoros
14	KIR-277389101	Kiribati
617	LIE-689222525	Liechtenstein
712	ARG-469709272	Argentina
433	HAI-202453451	Haiti
22	BRA-181886612	Brazil
181	TON-973835868	Tonga
426	CUB-337361141	Cuba
360	AND-116371487	Andorra
223	DEN-778038157	Denmark
904	UAE-406882599	United Arab Emirates
400	SAM-568508813	Samoa
455	SAI-834913484	Saint Lucia
527	THA-818230019	Thailand
356	PAN-682795915	Panama
664	CHI-904119050	China
95	BER-074546961	Bermuda
996	BAH-680092581	Bahamas
624	CAM-194493806	Cambodia
142	CAY-390906316	Cayman Islands
330	POL-945772383	Poland
744	SER-440367296	Serbia
801	SER-166511434	Serbia
386	DOM-141229810	Dominican Republic
106	CUB-419696963	Cuba
389	MAL-274343368	Maldives
957	LEB-292759091	Lebanon
886	PHI-297631183	Philippines
35	CAP-935943871	Cape Verde
15	PHI-576865052	Philippines
514	UKR-012995908	Ukraine
782	HON-166844741	Honduras
685	NIC-097531729	Nicaragua
721	MYA-307539074	Myanmar
646	AND-715195996	Andorra
159	LES-429457837	Lesotho
591	WES-557531941	Western Sahara
788	NIU-699900127	Niue
159	MYA-330234494	Myanmar
285	ISR-059656976	Israel
286	PNG-445721680	Papua New Guinea
673	MAD-894469298	Madagascar
237	IND-609705025	India
834	WES-009727867	Western Sahara
839	PHI-269369342	Philippines
382	COL-628299668	Colombia
676	NOR-258267909	North Macedonia
5	CAP-201285403	Cape Verde
934	TUN-726165229	Tunisia
772	NAM-955745852	Namibia
712	NOR-466673854	North Korea
429	SIN-025398041	Singapore
793	HON-902599623	Honduras
25	THA-989402170	Thailand
4	PAN-511987340	Panama
391	ERI-832868937	Eritrea
394	ISR-583253588	Israel
936	PNG-481932879	Papua New Guinea
629	LIB-569616891	Liberia
386	NOR-466438087	North Macedonia
439	NEP-527630646	Nepal
875	SAI-871081174	Saint Helena, Ascension and Tristan da Cunha
681	WES-246343418	Western Sahara
969	LIB-920312277	Libya
424	NOR-086033192	Norway
626	TAT-562867177	Trinidad and Tobago
552	KAZ-125261885	Kazakhstan
5	PAR-634529583	Paraguay
624	ARG-360350849	Argentina
217	JAP-519594777	Japan
321	MAL-111148351	Malaysia
353	BOT-043473611	Botswana
248	CUR-054063277	Curaçao
549	PER-267870036	Peru
32	NIU-864501729	Niue
865	PHI-737831015	Philippines
918	ARU-256747589	Aruba
499	CHI-290450898	China
877	MON-185878562	Mongolia
14	MON-485607878	Mongolia
112	TUR-670474795	Turkey
753	DOM-797680235	Dominican Republic
945	TAJ-464702610	Tajikistan
809	CAN-024456717	Canada
185	SAM-126324782	Samoa
915	OMA-773428924	Oman
393	PAL-968944063	Palestine
949	LIB-452120775	Liberia
485	SWE-923044621	Sweden
700	TAT-483258753	Trinidad and Tobago
405	ARM-772030581	Armenia
416	BRU-570670838	Brunei
90	BAH-942694213	Bahrain
898	FAL-400276377	Falkland Islands
90	SRI-874286102	Sri Lanka
781	ETH-926296586	Ethiopia
136	VIE-767226460	Vietnam
233	UKR-807599106	Ukraine
724	BRU-333230467	Brunei
1	PAN-724192601	Panama
906	MAL-280439747	Malaysia
325	LIB-532942892	Liberia
820	BAH-806010323	Bosnia and Herzegovina
976	PAL-917386852	Palestine
91	CZE-291414566	Czechia
566	KIR-059212509	Kiribati
253	NIC-464766898	Nicaragua
690	ISR-341579667	Israel
606	LEB-490400255	Lebanon
106	BUR-079618688	Burundi
903	ISR-494409105	Israel
565	RWA-073210775	Rwanda
444	LES-438538312	Lesotho
792	SAI-138020833	Saint Helena, Ascension and Tristan da Cunha
726	KUW-154040182	Kuwait
454	ARU-567068419	Aruba
456	YEM-532957113	Yemen
817	TUN-033413877	Tunisia
607	KAZ-778014138	Kazakhstan
42	LEB-318241990	Lebanon
364	MAL-012378754	Malawi
424	LIE-102607036	Liechtenstein
687	BUL-094170224	Bulgaria
93	JOR-895918519	Jordan
445	SUR-329955364	Suriname
245	BER-447373923	Bermuda
326	SOU-397926295	South Korea
417	CHI-189696445	Chile
747	ANG-642160904	Angola
204	ERI-547173536	Eritrea
528	MAD-929157637	Madagascar
617	PNG-002398890	Papua New Guinea
84	PAL-592865925	Palestine
832	PNG-645855618	Papua New Guinea
93	KYR-309047817	Kyrgyzstan
509	PAR-762198468	Paraguay
705	RUS-378209289	Russia
328	NOR-439120943	North Korea
563	BER-548485012	Bermuda
309	SEY-130994921	Seychelles
463	PAN-712671305	Panama
180	SAM-964658371	Samoa
320	RUS-057246475	Russia
45	SAI-457580541	Saint Lucia
626	BHU-852187031	Bhutan
745	RUS-219829172	Russia
420	PAL-518544466	Palestine
224	HON-820255761	Honduras
73	QAT-700748436	Qatar
633	GHA-198661683	Ghana
817	WES-585617473	Western Sahara
143	CAN-972591197	Canada
468	SOU-106350131	South Korea
317	SER-980351556	Serbia
300	BRA-114226623	Brazil
997	ERI-419217854	Eritrea
276	COL-048504391	Colombia
187	COM-566352251	Comoros
300	CAY-233278292	Cayman Islands
468	GUA-700716919	Guatemala
464	JAP-849608571	Japan
95	LAO-939716537	Laos
372	BHU-036600875	Bhutan
814	AZE-386423456	Azerbaijan
671	PHI-415682917	Philippines
723	MAD-803742644	Madagascar
670	PAR-019962628	Paraguay
198	GIB-084341524	Gibraltar
854	PUE-911796046	Puerto Rico
250	BRU-821146513	Brunei
240	NOR-258564031	Norway
999	POL-275182107	Poland
550	TAJ-936998141	Tajikistan
455	BHU-255810134	Bhutan
288	BOT-349490034	Botswana
36	QAT-344592611	Qatar
520	CHI-101818805	Chile
41	GUI-052790932	Guinea
405	CAY-012931387	Cayman Islands
108	ARM-833845600	Armenia
991	SIN-379761005	Singapore
546	ROM-805686857	Romania
437	CZE-558018744	Czechia
43	QAT-573708093	Qatar
109	GEO-194002531	Georgia
161	ARG-388939250	Argentina
593	UZB-286077710	Uzbekistan
883	JOR-290442057	Jordan
213	OMA-063742538	Oman
100	ANG-987031323	Angola
632	CAR-713589167	Central African Republic
456	IND-417361413	India
545	PER-476212650	Peru
471	BAN-065899375	Bangladesh
944	DOM-279906098	Dominican Republic
504	PAK-456256020	Pakistan
678	KIR-880373510	Kiribati
329	PAK-535763076	Pakistan
206	PUE-168111990	Puerto Rico
839	KIR-024998803	Kiribati
432	BUL-750341875	Bulgaria
695	JOR-039525191	Jordan
274	CAR-684952411	Central African Republic
788	BRA-260678066	Brazil
751	ISR-677459294	Israel
209	ARG-692293443	Argentina
248	LAO-938580467	Laos
562	KUW-929086273	Kuwait
852	ETH-545741450	Ethiopia
346	UKR-990607776	Ukraine
468	RWA-461510823	Rwanda
953	BER-017111206	Bermuda
771	SAM-904118300	Samoa
877	PAR-184071451	Paraguay
674	PNG-297792142	Papua New Guinea
349	SYR-244287818	Syria
355	SER-160350298	Serbia
361	ALB-492426916	Albania
954	NOR-735957801	North Macedonia
103	VIE-691423485	Vietnam
871	BER-891675646	Bermuda
247	THA-144932322	Thailand
40	ZAM-168704211	Zambia
893	VAN-799755215	Vanuatu
902	CAR-579866608	Central African Republic
463	LEB-385182238	Lebanon
372	MON-613780885	Mongolia
173	ERI-327542562	Eritrea
699	CAR-120656088	Central African Republic
494	BRU-594806039	Brunei
891	TAI-898493897	Taiwan
187	CUR-789090638	Curaçao
874	BAH-077046577	Bahamas
344	GEO-402461814	Georgia
887	MAL-461868498	Maldives
404	NIU-406816370	Niue
942	ROM-961545259	Romania
307	CAR-190568350	Central African Republic
728	WES-294591449	Western Sahara
886	KUW-816948732	Kuwait
197	COL-898694895	Colombia
867	MAD-139548798	Madagascar
39	TUN-741332664	Tunisia
965	SOU-667783625	South Korea
205	HUN-931264486	Hungary
162	SOU-960964254	South Africa
803	LIB-109048546	Libya
321	DJI-491215380	Djibouti
812	CAY-563302861	Cayman Islands
284	TAT-648297144	Trinidad and Tobago
821	UKR-821679434	Ukraine
270	MAC-874887388	Macau
788	ARG-947053016	Argentina
704	CAM-978295966	Cambodia
986	TAJ-915397964	Tajikistan
158	LAO-037489094	Laos
14	WES-515328007	Western Sahara
427	GUI-932753976	Guinea
319	TUR-197202999	Turkey
920	OMA-421821131	Oman
464	TAI-749284805	Taiwan
846	ALB-469518972	Albania
242	NOR-873490635	North Korea
599	NOR-752202082	North Korea
232	SAI-751139556	Saint Helena, Ascension and Tristan da Cunha
654	SAM-598222126	Samoa
625	JAP-714331088	Japan
73	TUR-696931008	Turkey
524	GHA-017029124	Ghana
235	FAL-875453365	Falkland Islands
210	UAE-724922577	United Arab Emirates
564	SIN-646849761	Singapore
484	BAH-550139568	Bahamas
223	PAN-320391010	Panama
717	NEP-453547506	Nepal
373	NIG-241602970	Nigeria
717	CAR-162877394	Central African Republic
513	JAP-079093003	Japan
745	BER-763898348	Bermuda
591	ANG-089065746	Angola
217	PAK-233569348	Pakistan
67	ARU-573509018	Aruba
16	DJI-965222168	Djibouti
269	RWA-528466933	Rwanda
571	NIG-772187898	Nigeria
374	HON-118140312	Honduras
108	TUR-277314864	Turkey
903	SAU-855464997	Saudi Arabia
321	MOZ-314360754	Mozambique
435	NAM-876370865	Namibia
700	HON-838240103	Honduras
757	KYR-734938010	Kyrgyzstan
885	SEY-523818954	Seychelles
640	PAK-498080115	Pakistan
90	MYA-425000678	Myanmar
260	TUN-900306853	Tunisia
969	LEB-700157970	Lebanon
585	BOT-589745009	Botswana
150	LIB-965495832	Liberia
768	GEO-716289664	Georgia
204	DOM-315553632	Dominican Republic
138	NIC-857230379	Nicaragua
928	ZAM-221660435	Zambia
766	ETH-105761995	Ethiopia
494	ANG-683127149	Angola
499	SOU-750035665	South Africa
867	LEB-142115836	Lebanon
674	MON-899288002	Mongolia
212	OMA-222622566	Oman
117	NOR-035220886	North Korea
460	CAR-000217754	Central African Republic
457	VAN-552401893	Vanuatu
511	ZAM-627771704	Zambia
924	NIU-482277463	Niue
377	CAY-328136845	Cayman Islands
402	MON-142825315	Mongolia
635	IRA-960826137	Iraq
306	LAO-937002969	Laos
610	SUR-180450776	Suriname
246	PNG-395409738	Papua New Guinea
366	SAU-292213560	Saudi Arabia
193	ARG-809435836	Argentina
354	BEL-621630600	Belize
324	PAN-328742244	Panama
881	TON-884861904	Tonga
373	BER-397379973	Bermuda
95	SAM-264349290	Samoa
198	VAN-977125133	Vanuatu
465	PAL-785387722	Palestine
556	PNG-874636620	Papua New Guinea
568	WAF-167904342	Wallis and Futuna
302	MAD-773337506	Madagascar
103	CZE-518501416	Czechia
256	GIB-754314972	Gibraltar
941	TAJ-882160589	Tajikistan
902	JOR-677020562	Jordan
924	GHA-480708179	Ghana
186	WES-235666090	Western Sahara
344	PAR-576204994	Paraguay
561	SYR-789238012	Syria
186	DR -499541353	DR Congo
189	BUR-115340804	Burundi
671	LAO-975306219	Laos
651	VIE-716315798	Vietnam
355	SOU-533951375	South Africa
558	URU-430041864	Uruguay
276	ALB-657736567	Albania
242	WES-350327631	Western Sahara
444	LIB-791958252	Libya
567	FAL-645999539	Falkland Islands
674	ARG-425916144	Argentina
986	MAL-372605395	Malaysia
930	MAL-814999039	Malaysia
190	NOR-604817376	North Macedonia
670	IRA-782583849	Iraq
540	MYA-367267533	Myanmar
549	UZB-429783614	Uzbekistan
290	SOL-017871499	Solomon Islands
558	ERI-001649909	Eritrea
59	BRA-132998538	Brazil
304	MON-539056534	Mongolia
885	WES-663373672	Western Sahara
295	MYA-264519914	Myanmar
667	NOR-036112271	North Korea
377	YEM-120387512	Yemen
471	NAM-748599070	Namibia
237	SOL-438815583	Solomon Islands
41	SOU-348655121	South Korea
415	CUR-944259516	Curaçao
367	TAJ-218232807	Tajikistan
151	HON-991649043	Honduras
193	ANG-630805499	Angola
478	GUA-776915142	Guatemala
211	BER-145368781	Bermuda
637	CHI-139174320	China
596	MAC-996941173	Macau
697	HUN-580727590	Hungary
476	ZAM-813263477	Zambia
163	JOR-592653844	Jordan
315	BRU-814790918	Brunei
819	PHI-411207822	Philippines
990	AFG-448464426	Afghanistan
714	GHA-479121447	Ghana
62	BUR-730914699	Burundi
949	DOM-846803787	Dominican Republic
803	SAU-476928272	Saudi Arabia
624	SWE-221047924	Sweden
443	LES-116586065	Lesotho
934	SWE-462365866	Sweden
655	ERI-730384614	Eritrea
724	NIU-706218146	Niue
610	ERI-309197827	Eritrea
11	GUA-584050205	Guatemala
763	NAM-167029896	Namibia
166	HUN-232133202	Hungary
650	LEB-542226666	Lebanon
921	SUR-056645147	Suriname
953	DR -876621032	DR Congo
731	SER-189772813	Serbia
986	SOU-041403695	South Africa
621	SIN-489320245	Singapore
40	SRI-963860378	Sri Lanka
630	ERI-273111828	Eritrea
239	DEN-059703671	Denmark
922	LES-798220203	Lesotho
23	BUL-704702642	Bulgaria
8	HON-167153925	Honduras
876	COL-751783778	Colombia
557	SAU-686891637	Saudi Arabia
547	RUS-962360588	Russia
422	IND-539270786	India
472	COL-963766776	Colombia
736	TAI-470473142	Taiwan
463	UKR-521995442	Ukraine
55	MEX-570252082	Mexico
777	FAL-682003915	Falkland Islands
941	TUR-217875982	Turkey
679	GUA-743218730	Guatemala
516	HAI-907776983	Haiti
486	HON-877130252	Honduras
394	SAI-453398463	Saint Helena, Ascension and Tristan da Cunha
178	MOR-624546305	Morocco
627	POL-100384558	Poland
649	MAL-373378709	Malawi
495	NOR-335470093	North Korea
275	BRA-077193788	Brazil
483	GEO-909591278	Georgia
854	NOR-423600344	Norway
339	BRA-651442608	Brazil
748	CZE-005260945	Czechia
129	POL-961774840	Poland
270	OMA-005056824	Oman
192	WES-578565396	Western Sahara
273	ERI-845259728	Eritrea
882	UKR-704327881	Ukraine
478	MON-634280987	Mongolia
486	RUS-141720011	Russia
966	NIU-232373630	Niue
713	LAO-964589232	Laos
738	DEN-222626854	Denmark
308	BRA-677234449	Brazil
411	CAY-055338181	Cayman Islands
26	RWA-591309495	Rwanda
442	SOL-517932813	Solomon Islands
228	BAH-664710016	Bahamas
912	TAI-633465258	Taiwan
398	SUR-614225827	Suriname
713	SIN-644218269	Singapore
950	PUE-171288660	Puerto Rico
785	POL-654473565	Poland
998	SYR-912533702	Syria
731	NIC-065018142	Nicaragua
256	MAU-244363236	Mauritius
990	KAZ-113220181	Kazakhstan
149	MAL-782776738	Malawi
24	MON-335989290	Mongolia
245	SOU-831026275	South Africa
316	FAL-685395161	Falkland Islands
117	SER-086917677	Serbia
260	SUR-667262700	Suriname
810	CAY-752962979	Cayman Islands
919	ERI-589718927	Eritrea
152	NIU-241163470	Niue
64	CHI-916168840	Chile
870	NAM-655297277	Namibia
276	NOR-323258090	North Macedonia
501	VAN-059986644	Vanuatu
526	ERI-610847739	Eritrea
412	TAI-878754122	Taiwan
573	NIU-143969660	Niue
184	NAM-930864065	Namibia
264	KIR-697518266	Kiribati
252	NIU-521377550	Niue
692	BOT-738193391	Botswana
82	SAU-351976514	Saudi Arabia
951	FIJ-071102578	Fiji
574	BOT-716749114	Botswana
899	ALB-417353710	Albania
32	SOL-332843347	Solomon Islands
91	GHA-782437390	Ghana
249	MAL-462847440	Malaysia
889	TON-921282028	Tonga
918	MAL-208136409	Malaysia
685	BUR-642173433	Burundi
903	TAI-021991512	Taiwan
569	CAY-265711012	Cayman Islands
673	CHI-648086947	China
419	KUW-268908289	Kuwait
970	MOZ-879195973	Mozambique
398	CHI-390256598	Chile
248	CAM-716672115	Cambodia
14	TAJ-012625126	Tajikistan
789	SWE-667416438	Sweden
514	JOR-833429543	Jordan
869	SER-931197006	Serbia
784	BAH-931902951	Bosnia and Herzegovina
61	BAN-023122329	Bangladesh
334	MAD-284777383	Madagascar
609	CAP-396106165	Cape Verde
846	SYR-240540291	Syria
885	FIJ-712286186	Fiji
403	COS-362650353	Costa Rica
426	MAD-923168149	Madagascar
242	SIN-807341407	Singapore
377	BAH-200849859	Bahamas
314	NOR-521457904	North Macedonia
592	CAM-316989984	Cambodia
993	BUL-604913240	Bulgaria
867	BRA-947228180	Brazil
192	GUA-366636570	Guatemala
177	UZB-475977762	Uzbekistan
302	CUR-106574506	Curaçao
988	TAI-584855414	Taiwan
193	CAR-439354728	Central African Republic
952	JOR-520750100	Jordan
447	JAP-902236464	Japan
649	MOZ-547239109	Mozambique
201	NOR-920973074	North Macedonia
729	JAP-160170230	Japan
937	DOM-451556328	Dominican Republic
214	HUN-523569216	Hungary
770	SER-873017785	Serbia
428	BUL-348425039	Bulgaria
553	BAH-874561741	Bahamas
837	GIB-544684072	Gibraltar
320	UZB-114676435	Uzbekistan
994	JOR-204514805	Jordan
7	AFG-393840858	Afghanistan
898	MAL-251334287	Maldives
644	DOM-089283758	Dominican Republic
821	MAL-709213779	Malaysia
426	DEN-500917249	Denmark
59	PNG-832638469	Papua New Guinea
786	ARG-431248191	Argentina
97	OMA-412274279	Oman
12	URU-983801458	Uruguay
312	SAI-142081703	Saint Lucia
952	TAT-792398051	Trinidad and Tobago
142	UAE-343623495	United Arab Emirates
433	BAH-713644984	Bahamas
285	NOR-850131211	North Macedonia
565	MAD-048996956	Madagascar
892	ISR-655626118	Israel
806	BRU-476152351	Brunei
533	ARM-841426623	Armenia
103	COL-451213356	Colombia
67	HUN-199692117	Hungary
189	TAJ-182112189	Tajikistan
420	URU-400339948	Uruguay
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
591	Bolivia	BOB
855	Cambodia	KHR
677	Solomon Islands	SBD
55	Brazil	BRL
500	Falkland Islands	FKP
265	Malawi	MWK
856	Laos	LAK
506	Costa Rica	CRC
95	Myanmar	MMK
94	Sri Lanka	LKR
250	Rwanda	RWF
1	Canada	CAD
243	DR Congo	CDF
244	Angola	AOA
84	Vietnam	VND
93	Afghanistan	AFN
968	Oman	OMR
36	Hungary	HUF
231	Liberia	LRD
962	Jordan	JOD
975	Bhutan	BTN
359	Bulgaria	BGN
350	Gibraltar	GIP
46	Sweden	SEK
1758	Saint Lucia	XCD
374	Armenia	AMD
972	Israel	ILS
73	Russia	RUB
853	Macau	MOP
598	Uruguay	UYU
1809	Dominican Republic	DOP
673	Brunei	BND
886	Taiwan	TWD
685	Samoa	WST
261	Madagascar	MGA
960	Maldives	MVR
264	Namibia	NAD
236	Central African Republic	XAF
91	India	INR
92	Pakistan	PKR
507	Panama	PAB
40	Romania	RON
501	Belize	BZD
63	Philippines	PHP
56	Chile	CLP
82	South Korea	KRW
387	Bosnia and Herzegovina	BAM
420	Czechia	CZK
971	United Arab Emirates	AED
233	Ghana	GHS
90	Turkey	TRY
51	Peru	PEN
1242	Bahamas	BSD
251	Ethiopia	ETB
52	Mexico	MXN
224	Guinea	GNF
297	Aruba	AWG
60	Malaysia	MYR
970	Palestine	EGP
216	Tunisia	TND
505	Nicaragua	NIO
976	Mongolia	MNT
992	Tajikistan	TJS
218	Libya	LYD
686	Kiribati	AUD
964	Iraq	IQD
995	Georgia	GEL
47	Norway	NOK
977	Nepal	NPR
389	North Macedonia	MKD
381	Serbia	RSD
681	Wallis and Futuna	XPF
267	Botswana	BWP
676	Tonga	TOP
66	Thailand	THB
81	Japan	JPY
678	Vanuatu	VUV
258	Mozambique	MZN
248	Seychelles	SCR
963	Syria	SYP
1345	Cayman Islands	KYD
880	Bangladesh	BDT
260	Zambia	ZMW
54	Argentina	ARS
57	Colombia	COP
675	Papua New Guinea	PGK
961	Lebanon	LBP
65	Singapore	SGD
1868	Trinidad and Tobago	TTD
2125288	Western Sahara	DZD
291	Eritrea	ERN
376	Andorra	EUR
973	Bahrain	BHD
504	Honduras	HNL
266	Lesotho	LSL
683	Niue	NZD
269	Comoros	KMF
502	Guatemala	GTQ
965	Kuwait	KWD
53	Cuba	CUC
212	Morocco	MAD
966	Saudi Arabia	SAR
355	Albania	ALL
967	Yemen	YER
253	Djibouti	DJF
423	Liechtenstein	CHF
679	Fiji	FJD
234	Nigeria	NGN
974	Qatar	QAR
257	Burundi	BIF
597	Suriname	SRD
76	Kazakhstan	KZT
380	Ukraine	UAH
249	Sudan	SDG
86	China	CNY
1787	Puerto Rico	USD
996	Kyrgyzstan	KGS
850	North Korea	KPW
238	Cape Verde	CVE
1441	Bermuda	BMD
998	Uzbekistan	UZS
994	Azerbaijan	AZN
230	Mauritius	MUR
599	Curaçao	ANG
27	South Africa	ZAR
45	Denmark	DKK
509	Haiti	HTG
48	Poland	PLN
595	Paraguay	PYG
290	Saint Helena, Ascension and Tristan da Cunha	GBP
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
1	Fonseca Macedo S.A. Schedule	0	638	776	1997-03-21
2	Willis, Perkins and Evans Beat	0	839	665	1990-05-05
3	Rocha Pereira S/A Agora+	0	64	2	1999-04-10
4	Costela S/A CinePlus	0	553	113	2020-06-23
5	Machado e Filhos Stream	0	285	781	2009-11-21
6	Casa Grande S/A Ritmo	0	100	409	2015-01-26
7	Miranda PLC Edge	0	836	346	1994-09-23
8	Smith, Tyler and Hernandez Beat	0	212	731	2022-05-26
9	Barbosa e Filhos Universal	0	579	609	1991-03-21
10	Nascimento Moura Ltda. Studios	0	455	638	1999-11-16
11	Silveira Correia S.A. Select	0	269	933	2005-01-08
12	Peixoto Almeida S.A. Spot	0	151	947	1992-08-25
13	Silva - EI Scene	0	370	67	2007-08-29
14	Ribeiro Abreu - EI PlayLab	0	453	909	2010-09-05
15	Johnston-Payne Radio	0	377	804	2009-11-14
16	Rodrigues Vasconcelos - EI Hub	0	911	86	2022-08-22
17	Keller, Perkins and Yu Originais	0	347	878	2007-04-07
18	Lewis, Obrien and Moore Showcase	0	744	690	1993-06-06
19	Campos - ME Library	0	181	520	1997-08-19
20	Alvarez, Miller and Guzman Universo	0	738	668	2005-06-25
21	Carpenter-Fernandez Cast	0	378	11	2001-06-06
22	Câmara S.A. Sincroniza	0	150	605	2003-01-30
23	Gregory, Thomas and Ramirez Mini	0	141	243	2020-02-06
24	da Luz da Rosa S.A. Reel	0	904	122	2010-05-10
25	Chang, Walter and Harris Sincroniza	0	7	619	2014-05-04
26	Lima Castro - EI Radio	0	704	571	1994-05-22
27	Oconnor, Adams and Jones Pod	0	816	205	2021-07-02
28	Cirino - ME Agora+	0	619	12	2007-07-21
29	Roman-Johnson Collection	0	502	2	2005-12-14
30	Pereira Moraes e Filhos On	0	356	564	2001-01-02
31	Smith-Aguilar CastTV	0	527	478	2013-09-23
32	Clark PLC Agora+	0	398	407	1992-10-21
33	Perry, Fry and Kelley Mais	0	693	590	2010-10-18
34	Payne, Mcgrath and Collins Go	0	640	188	2004-02-16
35	das Neves Caldeira S.A. Play	0	94	578	2019-08-06
36	Bray Ltd Worlds	0	74	576	2004-05-20
37	da Paz Santos e Filhos Reel	0	608	496	1999-11-09
38	Reyes, Lopez and Stone Navigator	0	522	445	2000-06-08
39	Morgan-Guerrero PlayLab	0	154	951	2003-11-25
40	Grant-Smith LiveStream	0	98	281	2003-07-25
41	Novais Andrade - ME Ritmo	0	569	414	2001-06-23
42	Harris Ltd Highlights	0	833	206	2002-06-20
43	Taylor, James and Jordan Entrada	0	364	708	2012-08-07
44	Martin Ltd Live	0	502	972	2011-03-21
45	Blanchard-Martin Hub	0	526	220	1992-10-10
46	Aragão Silva e Filhos Now+	0	622	328	2015-12-10
47	Vargas Sá S/A Radio	0	497	210	2003-01-18
48	Nicholson Group CinePlus	0	566	219	2014-05-23
49	Lin-White Access	0	368	568	2007-03-04
50	Ramos Carvalho - ME Arquivo	0	442	287	2018-05-09
51	da Mota - ME Flow	0	397	661	2019-08-10
52	Griffin-Powell Cast	0	904	770	2017-12-08
53	Knapp-Martin Wave	0	894	687	2006-05-04
54	Moreno, Jackson and Reyes Play	0	227	937	2002-06-06
55	Brito da Paz S/A Showcase	0	341	684	2006-12-18
56	Sales - EI Studio	0	951	339	1995-07-20
57	Bowman, Wilson and Zamora Highlights	0	504	905	2004-07-18
58	Escobar Inc Realm	0	436	673	2001-10-17
59	Summers-Santos Explorer	0	855	746	2016-06-26
60	Duarte Ltda. Reels	0	448	955	2000-08-07
61	King Ltd Streamline	0	781	332	2005-12-17
62	Cunningham Inc Highlights	0	785	34	1993-03-26
63	Farias Ltda. Schedule	0	642	492	2004-01-22
64	Phillips, Clark and Walsh Go	0	757	846	2009-05-09
65	Wagner-Hudson Universe	0	633	252	2008-12-08
66	Costa Santos - EI Vibe	0	724	641	2015-12-14
67	Foley LLC Cast	0	569	167	2008-05-08
68	Boyd-Mitchell Ritmo	0	163	234	2015-06-08
69	Olson PLC Cast	0	104	721	1994-10-10
70	Vang Inc Now	0	141	383	2014-06-15
71	Barrera, Lee and Davis LoopTV	0	300	528	1999-02-16
72	Evans, Wallace and Chase Playground	0	252	635	2019-09-20
73	Hines-Gutierrez Universe	0	508	57	2004-05-18
74	Fowler-Owen Collection	0	146	247	1992-03-30
75	Pereira Albuquerque S.A. Highlights	0	84	610	2018-09-04
76	Osborn PLC Aqui	0	574	718	1994-08-02
77	Cavalcanti S.A. Access+	0	847	658	2000-04-18
78	Fonseca S/A Sync	0	598	983	2025-01-18
79	Cook, Moore and Ray Reels	0	76	637	2024-02-23
80	Gomes - EI Showcase	0	499	511	2019-08-11
81	Aparecida Barbosa S/A Station	0	194	295	1997-07-19
82	Ribeiro Ltda. CastTV	0	235	543	2004-01-17
83	Azevedo - ME Select	0	300	705	1990-02-26
84	Fernandes Teixeira - ME Spotlight	0	905	926	2003-01-31
85	Howell-Gutierrez Edge	0	746	79	2010-03-08
86	Teixeira da Cunha S.A. Network	0	628	354	1990-05-23
87	Tanner-Cochran Go	0	711	941	1991-01-04
88	Vasconcelos - EI Equipe	0	699	820	2004-01-15
89	Leach, Vincent and Chambers Pocket	0	585	803	2011-03-16
90	Rezende - EI Atlas	0	799	605	2009-11-24
91	Chavez PLC Playground	0	588	835	2019-01-29
92	Rios da Luz S/A Entrada	0	521	857	1991-06-06
93	Caldeira Guerra e Filhos Spotlight	0	780	778	2005-07-11
94	das Neves Azevedo S/A HoraNobre	0	432	576	2020-10-24
95	Siqueira da Luz - EI Studios	0	969	728	2022-12-10
96	da Luz - EI Streamers	0	647	413	1990-11-28
97	Campos-Lawrence Portal	0	38	620	2017-02-26
98	Miller, Melendez and Schwartz Streamers	0	846	77	2025-06-18
99	Carvalho - EI Pro	0	153	73	1992-10-21
100	Pacheco das Neves - EI Portal	0	524	779	2018-02-20
101	Morton LLC Explorer	0	993	602	2009-01-08
102	Porto e Filhos Gate	0	580	842	1999-05-03
103	Glover-Wise Beat	0	169	489	2016-05-27
104	Nunes S/A Edge	0	958	367	2006-03-15
105	Anderson Ltd Ir	0	660	961	1995-09-27
106	Mcgee-Dodson Collective	0	468	973	2010-07-06
107	Morales LLC Connect+	0	379	720	2015-08-09
108	Montenegro da Paz Ltda. Filmes	0	63	667	1996-12-23
109	Peixoto S/A Canal	0	449	232	2002-10-05
110	Kim PLC Play	0	578	777	2002-01-25
111	Fernandez, Harding and Reynolds Access+	0	69	452	2007-12-26
112	Gomes Sales - EI Universe	0	91	576	1992-10-18
113	Hunter PLC Box	0	679	103	1995-01-24
114	Lima Rezende Ltda. Collective+	0	492	483	2025-07-30
115	Câmara - ME Mais	0	327	125	1996-01-17
116	da Cunha Fernandes S.A. Ir	0	155	964	2017-10-17
117	Porto Almeida S/A CastTV	0	48	336	2003-12-07
118	Pacheco Ltda. Streamline	0	699	886	2007-06-09
119	White-Patel Flix	0	303	971	1997-08-03
120	Gibson-Parks Box	0	433	977	2004-04-14
121	Mendonça Cunha S.A. Arquivo	0	563	847	2011-08-08
122	da Rosa Fonseca e Filhos Flix	0	801	419	2017-12-10
123	Pastor - EI Box	0	290	536	2025-01-24
124	Camargo Carvalho S.A. Channel	0	219	42	2024-08-07
125	da Costa Almeida Ltda. Select	0	284	937	1996-01-14
126	Reynolds, Morgan and Houston Equipe	0	163	279	2011-04-21
127	Correia - EI Connect+	0	598	758	2010-10-14
128	Phillips, Coleman and Lynch Verse	0	971	303	2012-05-18
129	Davis LLC Portal	0	288	152	2025-10-17
130	Rocha - ME Pass	0	920	74	2024-11-18
131	Howell, Taylor and Johnson Access+	0	196	376	2025-02-17
132	Wallace LLC Lineup	0	158	208	1994-11-30
133	Guerra - EI Broadcast	0	15	702	2001-09-13
134	Jones-Jenkins Library	0	48	109	2019-10-18
135	Pereira Ltda. Box	0	524	538	1990-02-05
136	Cirino e Filhos Loop	0	608	785	2023-06-05
137	da Conceição Ramos S.A. Live	0	617	762	1997-01-30
138	Browning, Williams and Green Universe	0	205	518	2001-10-08
139	Viana Azevedo S.A. Ponto	0	700	979	1991-03-24
140	Jackson, Wells and Barrett Collective+	0	902	899	1995-09-03
141	Cassiano S.A. Access	0	917	240	2021-04-27
142	Aragão Barros - EI Stage	0	971	700	2012-12-13
143	Dias S.A. Transmit	0	702	887	1999-10-09
144	Jennings, Lopez and Barber HoraNobre	0	996	320	2020-04-13
145	Nogueira S/A Channel	0	765	824	2002-08-02
146	Moura da Luz e Filhos Mapa	0	210	794	1999-10-12
147	Stephens PLC Atlas	0	514	229	1992-08-10
148	Correia S/A Spotlight	0	316	127	2022-04-08
149	Siqueira e Filhos PocketTV	0	446	205	2011-07-14
150	Pimenta Martins - ME PrimeTime	0	195	642	2002-11-29
151	Rezende Ribeiro - ME Streamers	0	382	517	2012-05-03
152	da Luz OnRepeat	0	716	596	2024-10-21
153	Rowe-Ruiz Highlights	0	850	133	1997-02-02
154	Green Inc Metaverse	0	501	398	2020-01-23
155	Ferrell Group Spot	0	442	960	2021-04-16
156	Clark-Wilson On	0	822	195	2018-04-17
157	Johnson-Brennan Filmes	0	663	177	2024-04-17
158	Thomas-Hooper Hub	0	49	219	2002-01-31
159	Roberts-Garcia CinePlus	0	703	905	2003-02-16
160	Cohen, Ford and Buchanan Crew	0	652	810	1994-10-20
161	Johnson LLC Ponto	0	103	512	2016-02-27
162	Perez-Miller Navigator	0	829	152	2000-11-10
163	Mitchell-Jones Gate	0	274	686	1991-09-18
164	Bradley, Williams and Arnold Mundo	0	571	726	2025-05-25
165	Cochran Group Play	0	375	47	2018-06-09
166	das Neves da Mata e Filhos Mini	0	170	823	2020-02-01
167	Moraes S.A. LiveStream	0	982	363	2003-07-16
168	Fernandez, Vaughn and Smith Universal	0	834	273	2007-11-11
169	Moura Dias Ltda. Pass	0	659	713	2015-09-19
170	Berger Ltd Universo	0	623	461	2015-04-29
171	Scott-Carr Pocket	0	382	578	2024-09-07
172	Lopez-Lyons Lite	0	738	950	1995-11-28
173	Albuquerque Barros S/A Flow	0	820	278	2005-02-21
174	Farias Moura S/A Exclusive	0	427	758	1994-01-20
175	Silva Fogaça S/A Streamline	0	240	141	2019-08-09
176	Pires S/A Pass	0	650	266	2002-12-18
177	Mendes Cardoso - ME Collective+	0	341	996	2011-03-07
178	Schwartz-Benson Broadcast	0	406	668	2011-12-22
179	Albuquerque Ramos - ME Reels	0	24	751	1993-01-24
180	Morrison, Doyle and Perez Cast	0	820	6	2018-04-17
181	Castro S/A Air	0	330	52	2024-08-14
182	Tanner Inc Stream	0	698	950	2017-10-02
183	Sampaio Novais e Filhos Mais	0	113	999	1993-11-15
184	Brown, Burnett and Kim Fluxo	0	605	182	1997-01-21
185	Santos-Hull Replay	0	939	176	2006-10-24
186	Novaes e Filhos Crew	0	479	83	2019-02-19
187	Ramos Melo - ME Play	0	117	165	2015-02-17
188	Borges Farias S/A Wave	0	630	949	2012-03-24
189	Camargo Pacheco S/A Mundo	0	403	930	2003-08-31
190	Turner and Sons Vibe	0	320	682	2004-01-20
191	Rocha S/A Broadcast	0	437	926	1993-10-22
192	Melo - EI Reel	0	639	234	2008-10-08
193	Mendoza and Sons Future	0	135	646	2007-10-20
194	Santos da Mota - EI Access+	0	319	560	2002-12-24
195	Jackson, Montgomery and Brown Hub	0	405	363	2018-10-17
196	Hobbs-King Broadcast	0	147	349	2011-04-24
197	Camargo - EI Broadcast	0	798	507	2023-10-24
198	Hamilton-Hall Realm	0	945	831	2012-04-30
199	Souza da Luz Ltda. CinePlus	0	350	618	2007-09-10
200	Nascimento - EI Collective+	0	601	347	2013-10-21
201	Jennings-Jones Ponto	0	996	686	2025-06-11
202	Vega Ltd Mapa	0	105	649	2008-05-28
203	Patton, Thompson and Humphrey PrimeTime	0	801	170	2009-05-04
204	Nelson, Henderson and Delgado Scene	0	171	762	2021-04-20
205	Davis Ltd Broadcast	0	794	643	1994-11-03
206	Novaes S.A. LiveStream	0	97	454	1995-12-03
207	Moreira e Filhos Sync	0	59	817	2012-02-25
208	Russell Inc Library	0	220	23	1994-11-27
209	Gamble Group Pro	0	390	433	2015-04-15
210	Rocha-Harvey Queue	0	448	454	2017-10-25
211	Clark and Sons PrimeTime	0	175	809	2023-05-12
212	Burns Inc Explorer	0	880	898	2023-07-03
213	Ford-Henson Streamline	0	135	869	1999-04-05
214	Coleman-Stephens Radio	0	900	380	2005-10-01
215	Brown, Bradley and Skinner Streamline	0	830	199	2001-12-16
216	Nogueira Ltda. PocketTV	0	56	721	2020-03-22
217	Pires Pastor S.A. Ritmo	0	622	905	1995-05-09
218	Page-Marquez Ritmo	0	365	499	2000-09-07
219	King-Johnston Queue	0	797	341	2018-01-12
220	Silveira Vasconcelos e Filhos Stage	0	540	860	1996-06-06
221	Johnson, Evans and Nguyen Scene	0	706	468	2021-01-04
222	Machado Marques Ltda. Playground	0	396	74	1994-09-11
223	Orozco Ltd PlayLab	0	495	5	2019-05-09
224	Thomas-Anderson Play	0	324	851	2023-11-30
225	Navarro Ltd CastTV	0	930	258	1997-08-03
226	Rocha - EI Exclusive	0	484	780	1994-10-24
227	Rose, Farmer and Miller Metaverse	0	128	782	1998-05-12
228	Vasconcelos das Neves S/A Access	0	91	705	2005-05-27
229	Moore and Sons Reels	0	457	695	2007-08-29
230	Poole Inc Reels	0	161	671	2016-08-16
231	Vargas Casa Grande - ME Live+	0	389	169	2025-02-22
232	Andrade Fonseca Ltda. Mini	0	676	516	2000-07-23
233	Mckinney Inc Station	0	582	311	2012-07-29
234	Martinez and Sons CastTV	0	615	466	2011-04-28
235	Mendes S/A Universal	0	447	869	2008-04-15
236	Cook Inc Originals	0	826	873	2024-08-19
237	Marshall Ltd Connect	0	657	777	1996-10-24
238	Sales Vieira - ME Palco	0	537	184	2017-05-22
239	Hurst, Martinez and Dunlap Sincroniza	0	486	555	1996-05-26
240	da Rocha Pereira Ltda. Wave	0	873	774	2015-08-28
241	Pinto Cavalcante - EI Exclusive	0	661	974	2024-08-13
242	Richards PLC Pocket	0	677	127	2006-03-09
243	Rodriguez-Henry Palco	0	477	63	2001-12-26
244	Cavalcanti Pimenta S.A. Hub	0	991	564	2015-09-16
245	Robertson Group Showcase	0	550	226	2017-06-11
246	Davis Inc Plataforma	0	50	282	2014-08-02
247	Brito Souza S/A Agora+	0	432	984	2001-04-18
248	Barbosa Vieira e Filhos Scene	0	111	137	2002-12-02
249	Sousa Mendonça - ME Plataforma	0	907	411	2016-09-07
250	Fernandes S/A Lite	0	756	763	2004-03-23
251	Brito Ltda. Access	0	883	801	1994-02-19
252	Hood, Wallace and Massey Universal	0	715	785	2020-07-18
253	Williams, Daniels and Archer Mundo	0	583	609	1995-12-13
254	Nunes Martins S.A. Canal	0	689	385	2002-05-19
255	da Rocha Sá S.A. Stage	0	723	968	2022-03-20
256	Brown and Sons On	0	127	71	2019-10-29
257	Cassiano S/A Verse	0	775	896	1996-03-03
258	Kennedy Ltd Originals	0	446	992	2009-06-05
259	Souza Pereira - ME Metaverse	0	894	61	1995-11-04
260	Carter, Jackson and Fox Prime	0	631	437	2016-09-23
261	Vasconcelos Siqueira S/A Sync	0	927	211	2011-11-21
262	Moura S/A Fluxo	0	984	890	2021-08-16
263	Reese, Howard and Perry Live	0	481	471	2001-04-29
264	Martinez-Carpenter Loop	0	890	123	1995-11-20
265	Perez LLC Plataforma	0	617	255	2004-08-12
266	Wright-Nelson Ritmo	0	382	103	2006-01-25
267	Oneill, Torres and Cox CastTV	0	790	84	2009-12-21
268	Park, Marshall and Hernandez Channel	0	240	821	2013-03-12
269	Abreu Ltda. Select	0	760	874	2019-11-25
270	Melo da Luz e Filhos Play	0	520	386	2001-02-04
271	Cardoso Gonçalves - EI Exclusive	0	591	616	2007-02-07
272	Wilson PLC Exclusive	0	776	854	1990-06-03
273	Burns and Sons Live+	0	538	24	2010-12-24
274	Nogueira Cavalcante e Filhos Filmes	0	89	486	1993-12-22
275	Almeida Pereira - ME Sync	0	205	395	2001-07-13
276	da Rocha Ltda. Flow	0	214	521	2005-09-17
277	da Paz Pacheco e Filhos Direct	0	792	928	2004-10-20
278	Rodrigues - ME Worlds	0	170	810	2004-07-14
279	Gordon PLC Exclusivo	0	71	139	2003-04-26
280	Riddle-Ballard Future	0	960	363	2023-09-26
281	Gay, Williams and Thompson Transmit	0	436	41	1998-05-29
282	Ramos Moura S.A. Aqui	0	1	871	2020-12-08
283	Fox-Parks Replay	0	10	496	2025-08-09
284	Jackson-Smith Showcase	0	464	778	2006-11-28
285	Sanchez-Wilson Streamline	0	989	348	1993-03-03
286	Barrett-Page CinePlus	0	35	872	1992-06-18
287	Vega Inc Station	0	956	522	1998-06-08
288	Banks Group Lite	0	685	45	1997-04-07
289	Gonçalves Brito S/A OnRepeat	0	608	487	2020-02-07
290	Silveira Ltda. Flow	0	869	68	2003-12-14
291	Murphy Ltd CastTV	0	956	633	2012-06-30
292	Hall, Hill and Brown Ir	0	752	687	2002-06-14
293	Santos Montenegro - EI Crew	0	292	272	2018-10-09
294	Mathis Inc CinePlus	0	504	976	2000-10-25
295	Lopez-Lewis Universo	0	655	41	1996-11-15
296	Rodrigues Câmara S.A. Collection	0	839	924	1995-08-22
297	Duarte Lopes Ltda. Gate	0	498	730	2006-10-25
298	Walker-Moore PrimeTime	0	854	456	1997-01-24
299	Frye Group Highlights	0	63	897	2007-08-22
300	Allen PLC Vault	0	822	373	1994-05-04
301	Ramos Fonseca S.A. Metaverse	0	600	120	2015-11-02
302	Azevedo S.A. Portal	0	328	202	2022-09-26
303	Valentine-Gates Collective	0	714	393	2001-02-10
304	Dodson Ltd Access	0	249	565	1998-08-28
305	Pastor Sampaio e Filhos Hub	0	637	158	2019-03-14
306	Jenkins, Flores and Shaw Direct	0	146	580	2002-04-04
307	Davis-Gonzalez PlayLab	0	674	969	1993-12-01
308	Cavalcanti S/A Portal	0	559	157	1991-12-28
309	Fogaça Ltda. Channel	0	972	79	2010-07-22
310	Lima Jesus - EI Sincroniza	0	810	864	2000-09-12
311	Keller-Cochran Mais	0	221	823	2011-08-30
312	Odonnell-Lewis Ir	0	446	761	2025-02-03
313	Mendes Santos Ltda. Cinema	0	87	769	1999-02-18
314	Pimenta Duarte S/A Canal	0	224	984	2001-11-12
315	Lane and Sons Replay	0	285	584	2002-10-18
316	Araújo Teixeira S/A Hub	0	967	400	2017-03-15
317	Sullivan-Miller Live	0	427	645	2020-12-12
318	Sales S/A Ir	0	469	117	2024-07-31
319	Montenegro - EI CinePlus	0	86	507	2004-05-06
320	Pacheco, Davenport and Miller Hub	0	876	990	2025-03-26
321	Smith-Ponce Worlds	0	170	36	2006-03-10
322	da Paz da Rocha S/A Canal	0	973	112	2006-02-11
323	Ramos Pacheco S.A. Studios	0	175	184	2014-04-27
324	Dias das Neves e Filhos Shows	0	513	879	1998-08-20
325	Sousa Silva e Filhos Schedule	0	386	349	1993-09-10
326	Nogueira Ramos S/A Realm	0	654	55	1994-10-26
327	Carvalho Leão - EI Next	0	381	420	2008-03-18
328	Lynch, Wilson and Stephens Stream	0	4	135	2011-10-23
329	Burns, Baker and Fischer Radio	0	191	397	2002-05-18
330	Heath-Hart Metaverse	0	332	269	2014-09-11
331	da Conceição S/A Sincroniza	0	581	84	2012-04-22
332	Sampaio Peixoto Ltda. Ponto	0	694	13	2011-08-13
333	Dominguez-Young Mini	0	380	89	2009-12-28
334	Alvarado Ltd Crew	0	699	448	2004-06-24
335	Lang and Sons Queue	0	293	157	2006-04-02
336	Mccann, Cunningham and Green Metaverse	0	308	533	1992-05-12
337	Hall Group Gate	0	402	516	1998-11-29
338	Boone and Sons Lineup	0	206	507	2014-12-25
339	Newman Group Collection	0	554	452	2015-03-20
340	Silva Cassiano - ME Plus	0	626	480	2009-10-21
341	Teixeira S.A. Crew	0	154	959	2010-08-04
342	Byrd, Watkins and Arroyo Arquivo	0	405	490	2006-03-16
343	Sá e Filhos Verse	0	743	647	1994-09-16
344	Silva e Filhos Pass	0	751	47	2000-11-09
345	Hawkins-Rosario Plataforma	0	36	662	2010-12-20
346	Pacheco Pinto - ME Portal	0	109	676	2014-01-18
347	Cardoso - ME Broadcast	0	873	188	2019-07-01
348	Snyder PLC Reel	0	842	84	2004-05-17
349	Collins, Hernandez and Glenn Playground	0	392	311	2011-03-29
350	Potter-Gregory Wave	0	179	501	2020-12-16
351	da Mata - EI Pod	0	482	426	2017-02-15
352	Crosby, Pitts and Smith Shows	0	988	88	2017-09-24
353	Andrade S/A Vault	0	738	792	2020-11-22
354	Almeida Cavalcante S/A Cine	0	832	615	2002-10-20
355	Duarte Sampaio - ME Metaverse	0	638	887	1997-04-07
356	Gonzalez-Hines Stage	0	385	609	2001-04-14
357	Barbosa Aparecida - ME Spot	0	474	834	2002-08-24
358	Allen Inc Arquivo	0	222	594	1996-03-13
359	Rezende Rodrigues Ltda. Universe	0	31	456	2024-04-23
360	Kelly LLC Cinema	0	677	787	1994-08-22
361	Rodriguez Inc Premium	0	564	995	2012-09-21
362	Peters-Mack Onda	0	830	7	1990-12-05
363	Simpson-Sanders Aqui	0	683	941	1994-12-18
364	Norman, Morrow and Suarez Worlds	0	552	356	2020-02-01
365	Watkins Ltd Cast	0	25	251	2014-07-18
366	Young and Sons Universe	0	989	667	2000-04-02
367	Moreira Albuquerque - EI Equipe	0	286	785	2025-09-29
368	Aparecida Ltda. Atlas	0	847	752	2008-06-16
369	Sá Nogueira Ltda. Prime	0	845	892	2021-11-08
370	Garcia Pacheco e Filhos Flix	0	930	502	2016-06-21
371	da Cruz da Conceição e Filhos Crew	0	864	49	1991-10-01
372	Walsh PLC Spotlight	0	493	262	1996-12-31
373	Campos Ltda. Atlas	0	21	648	2002-08-11
374	Hunt, Moyer and Baird Connect	0	503	825	1999-06-05
375	Delgado, Schneider and Mullins Universo	0	70	87	2008-01-14
376	Brito da Cruz S.A. Loop	0	543	410	2017-09-24
377	Azevedo Sá - EI Collective	0	681	135	2003-10-05
378	Montenegro - ME NextGen	0	452	242	2010-11-11
379	Rocha Duarte S/A Collective+	0	739	268	1996-03-31
380	Guerra Rezende e Filhos Portal	0	735	88	2014-09-23
381	Day and Sons HoraNobre	0	403	825	1990-01-07
382	Jackson-Bowen Flix	0	228	980	1997-06-20
383	Oliveira da Cruz Ltda. NextGen	0	763	541	2018-07-21
384	Oliveira - EI Ritmo	0	398	347	2006-10-20
385	Todd-Morrow Showcase	0	734	327	2021-10-11
386	Jensen Ltd Worlds	0	219	559	2003-06-24
387	Armstrong, Johnson and Kline PlayLab	0	612	37	1994-12-04
388	da Conceição da Conceição - EI LiveStream	0	309	917	1999-10-10
389	Snyder, Ortiz and Zamora Portal	0	743	708	2014-12-09
390	Pires Borges Ltda. PocketTV	0	386	777	2011-09-20
391	Joseph, Jackson and Williams Flix	0	686	357	2002-07-09
392	Sanders Group Edge	0	187	562	2018-02-04
393	Diaz PLC Future	0	442	536	2006-06-04
394	Robinson LLC Filmes	0	383	90	2013-01-15
395	Santos Guerra - EI Mini	0	822	177	2020-09-04
396	Jones-Zuniga Collective	0	876	672	2014-01-15
397	Macedo Rodrigues S.A. Hub	0	493	28	2018-03-03
398	Cassiano Albuquerque - ME Live+	0	58	505	2014-11-05
399	Câmara Ltda. PrimeTime	0	972	20	2000-11-02
400	Camargo Cardoso - EI CastTV	0	424	695	2006-07-14
401	Rodriguez and Sons Go	0	146	352	2000-07-17
402	Brown, White and Lee Pro	0	425	121	2015-05-11
403	Norman-Bowman Box	0	787	278	1995-03-19
404	Souza - EI Showcase	0	643	947	2005-10-05
405	Caldeira - EI Navigator	0	658	806	2001-04-29
406	Rezende Duarte Ltda. Access	0	245	294	2008-09-28
407	Reyes Group Vault	0	176	721	2016-11-16
408	Smith PLC Ritmo	0	568	725	1991-05-18
409	Garrison Group Radio	0	267	241	1997-07-15
410	Costa S.A. Now	0	855	425	2006-04-20
411	Davis, Jackson and Maldonado Navigator	0	979	885	1991-10-05
412	Hendricks-Salazar Schedule	0	201	434	1999-01-24
413	Mcgee, Mueller and Ellis Mini	0	298	822	2002-11-17
414	Viana Pimenta S/A Direct	0	823	720	2008-03-27
415	Williams, Harvey and Thompson Filmes	0	149	136	2010-12-07
416	Zhang-Green Scene	0	653	906	2024-11-20
417	Mendes Ramos S/A Highlights	0	680	288	2018-05-16
418	Wallace, Lindsey and Martinez Showcase	0	842	387	2025-09-24
419	Ferrell-Miller Streamline	0	13	405	2012-11-19
420	Caldeira - ME Fluxo	0	390	544	2016-05-15
421	Mendes Novais S/A Broadcast	0	760	151	2021-12-13
422	Vasconcelos S/A Sync	0	118	637	2005-03-27
423	Cavalcante Sales Ltda. Explorer	0	333	564	2011-01-09
424	Castro Correia - ME Pass	0	735	128	2011-01-03
425	Elliott, Meyer and Kelley Entrada	0	634	374	1991-09-11
426	Andrade Casa Grande S.A. Mapa	0	632	686	2012-09-25
427	Aparecida Barros - ME Play	0	625	398	2016-10-12
428	Rezende Guerra Ltda. Ritmo	0	459	329	2004-02-16
429	Camargo e Filhos OnRepeat	0	894	752	1994-02-13
430	Duarte Borges - EI Worlds	0	738	681	2021-09-05
431	Guzman, Lopez and Hall Streamers	0	142	709	1990-06-17
432	Kennedy, Wiley and Porter Portal	0	817	386	2017-01-04
433	Borges S/A Wave	0	278	398	1994-09-01
434	Martins - ME Channel	0	432	497	2020-03-26
435	da Luz Moreira S.A. AoVivo	0	912	332	2007-10-09
436	Young-Rodriguez Highlights	0	559	409	2006-02-13
437	Booth, White and Crawford Transmit	0	656	304	2014-12-25
438	Azevedo Moura e Filhos Network	0	584	896	2022-12-07
439	Paul-Ramirez Ir	0	554	711	2017-01-01
440	Potts, Kent and Wong Flix	0	929	293	1998-10-25
441	Gomes Caldeira - ME PrimeTime	0	94	53	1992-12-05
442	Anderson, Hart and Cruz Go	0	878	299	1994-01-20
443	Logan, Russell and Alexander Agora+	0	556	781	1996-07-06
444	Nogueira Jesus Ltda. Stage	0	122	229	2004-03-11
445	Hall Inc Live	0	996	709	1990-03-27
446	Hunt, Hopkins and Davis Gate	0	148	32	2013-01-20
447	Morrison, Chambers and Gomez Hub	0	266	505	2006-09-05
448	Moura Novais S.A. Plataforma	0	882	177	2011-06-19
449	Ramos S/A LiveStream	0	54	433	1994-10-04
450	Gonzalez Ltd Agora+	0	580	128	1993-10-01
451	Wilson-Smith Loop	0	250	211	2014-06-08
452	Morgan Group Vibe	0	612	236	2020-09-05
453	Marques Aragão S.A. Palco	0	152	909	2019-04-15
454	Albuquerque S.A. Stage	0	101	924	2004-12-07
455	Camargo S.A. On	0	461	683	2023-03-19
456	Wright and Sons OnRepeat	0	948	929	1996-06-29
457	Smith, Smith and Randall Prime	0	797	853	2013-07-18
458	Chan-Hughes Mini	0	561	575	2019-06-10
459	Ramos Novaes S/A Showcase	0	951	829	2019-07-04
460	Anderson, Perez and Evans Premium	0	535	813	2011-03-14
461	Johns-King Palco	0	770	516	1995-12-05
462	Allen-Martin Cine	0	736	939	2010-11-13
463	Lynch-Allen Cast	0	846	142	2025-04-02
464	Andrade Castro S.A. Sync	0	311	123	2016-08-18
465	Ingram, Stevens and Escobar Live	0	43	440	2006-08-07
466	Ferreira Sampaio Ltda. Showcase	0	926	566	2000-11-27
467	Hall, Fletcher and Reyes Premium	0	585	944	2022-10-25
468	Carpenter, Weber and Castillo Verse	0	389	448	2009-12-07
469	Mendonça Oliveira Ltda. Pass	0	200	560	2013-04-25
470	Brown-Norton On	0	761	755	2024-10-25
471	da Rosa Correia e Filhos Hub	0	74	495	2009-08-20
472	Vasconcelos Sales S/A Stage	0	956	606	1991-05-31
473	Cavalcante Albuquerque e Filhos Box	0	191	898	2011-02-10
474	Morris PLC Playground	0	905	774	2006-10-20
475	Alvarado Group Ritmo	0	945	157	2010-05-04
476	Sampaio Araújo S.A. Station	0	989	869	2024-12-19
477	Parks, Horn and Simmons Ponto	0	27	540	1997-12-24
478	Fonseca Caldeira - ME Arquivo	0	597	813	1998-11-08
479	Lane-Harrison Plataforma	0	587	467	2009-07-12
480	Barbosa S.A. Play	0	846	377	2008-10-30
481	Pereira Montenegro - EI Direct	0	839	128	2007-09-02
482	Barros Ltda. Broadcast	0	322	451	2001-09-19
483	Wilcox, Lewis and Morris Reel	0	303	914	2021-03-31
484	Vasconcelos - ME Sincroniza	0	4	263	2019-04-12
485	Carrillo-Sims Studio	0	716	501	2004-10-17
486	Daniel Inc Cast	0	548	596	2012-12-08
487	Buck-Davis LiveStream	0	354	35	2003-05-29
488	Hopkins-Acosta Spot	0	754	975	2019-05-28
489	da Mota e Filhos Collection	0	45	304	2024-11-05
490	Combs and Sons PlayLab	0	852	553	2001-05-30
491	Hughes-Mckenzie Fila	0	364	116	1997-06-30
492	Rangel, Gross and Mendoza AoVivo	0	505	382	2001-10-28
493	Meyer, Harmon and Jenkins Broadcast	0	936	345	1994-03-04
494	Costela Rezende - ME Edge	0	415	766	1990-10-16
495	Brock-Barber Queue	0	304	163	2007-02-25
496	Harvey Ltd Universal	0	460	298	2016-11-03
497	Oliveira Pastor S.A. Agora+	0	921	83	2012-10-15
498	Bishop Inc Metaverse	0	822	936	1991-04-04
499	Fonseca Barbosa S/A Fluxo	0	613	773	1992-02-10
500	Gonzalez, King and Roberts Loop	0	848	179	1994-04-18
501	Glover LLC Highlights	0	882	481	2004-09-25
502	Camargo Correia - EI Future	0	67	383	2008-02-15
503	Brown Group Originais	0	895	776	2016-12-09
504	Schultz LLC PlayLab	0	154	10	2000-04-18
505	Nelson, Davis and Lopez Scene	0	657	631	2024-11-29
506	Alves e Filhos Pod	0	418	607	2001-09-28
507	Machado Andrade - EI Scene	0	544	31	2006-03-19
508	Machado Garcia - EI Pro	0	890	889	2001-07-25
509	Azevedo Ltda. Palco	0	673	867	1997-03-08
510	Souza - ME Ritmo	0	59	546	1990-07-16
511	Williams, Munoz and Caldwell Sync	0	84	830	2006-09-10
512	Smith-Schultz Filmes	0	163	356	2001-07-15
513	Clark, Gonzalez and Maldonado Sincroniza	0	596	111	2020-09-25
514	Rodriguez Group Ritmo	0	535	459	2002-05-10
515	Ramos, Flores and Rollins Connect+	0	285	916	2020-10-16
516	Griffin Inc PlayLab	0	14	291	2023-02-25
517	Rasmussen PLC Future	0	62	700	2012-10-11
518	Chapman-King Collective	0	373	691	2001-05-11
519	Craig, Mcgee and Morris Universo	0	297	156	1997-01-17
520	Sloan Inc Pro	0	436	542	2003-12-30
521	Santos S/A Hub	0	163	652	2001-09-06
522	Abreu e Filhos Sync	0	801	727	2005-06-23
523	Sales Vargas Ltda. Cine	0	143	161	2012-10-07
524	Moreira Vargas S.A. Fluxo	0	744	588	1990-07-24
525	Gonçalves - EI Groove	0	493	355	1991-10-11
526	Sampaio S/A Showcase	0	299	753	2010-05-22
527	Murphy PLC Select	0	391	30	2018-02-15
528	Cassiano da Rosa - EI Replay	0	243	759	2007-12-04
529	Glover-Curtis Radio	0	471	167	2011-02-22
530	Houston Ltd Originais	0	649	528	1994-10-10
531	Câmara Farias Ltda. Lite	0	370	665	2018-10-09
532	Love Group Broadcast	0	763	993	2020-12-19
533	Moreira Pimenta S.A. Palco	0	327	437	1999-06-02
534	Farias e Filhos Mais	0	603	876	2022-06-21
535	Martinez-Brown Canal	0	453	311	2000-04-10
536	da Cunha Brito - ME Broadcast	0	36	216	1998-12-02
537	Wilson, Pham and Mullins Future	0	379	515	2000-08-29
538	Pimenta Ltda. Groove	0	945	705	2005-07-20
539	Walker, Torres and Mayo Stage	0	762	131	2017-03-17
540	Monteiro da Rosa - ME Spotlight	0	666	559	2018-07-27
541	Bryant-Anderson Portal	0	450	686	2012-06-06
542	Simon, Anderson and Patterson Verse	0	827	994	1994-06-04
543	Ferguson Group Streamline	0	212	169	2002-06-16
544	da Conceição Castro e Filhos Metaverse	0	770	55	1992-03-08
545	Lee-Wagner Prime	0	352	948	2003-07-20
546	Perez-Abbott Pro	0	892	546	2012-05-23
547	Atkinson, Underwood and Johnson Streamers	0	836	232	2023-09-20
548	Hughes LLC Live	0	422	449	2019-05-08
549	Vieira Cavalcante Ltda. Radio	0	820	129	1991-12-23
550	Macedo Correia - EI Mapa	0	972	968	2006-01-19
551	das Neves e Filhos Collective+	0	558	719	2020-11-10
552	Cavalcante - ME Broadcast	0	899	180	2017-11-08
553	Haynes-Ayala HoraNobre	0	304	340	2023-11-01
554	Phillips LLC Prime	0	755	330	2012-01-25
555	da Rosa Correia S/A Broadcast	0	815	812	1990-12-19
556	da Luz e Filhos Highlights	0	982	694	2000-09-25
557	da Rosa Ltda. Loop	0	993	638	2020-08-16
558	Adams Group Queue	0	772	824	2025-08-17
559	Pinto Moraes - ME Agora+	0	7	480	1996-05-03
560	Martins Sousa - EI Sincroniza	0	91	180	2000-01-08
561	Rodrigues Ferreira e Filhos AoVivo	0	53	218	2021-05-18
562	Johnson-Cox Streamline	0	983	123	2014-04-21
563	Monteiro S/A PrimeTime	0	512	638	2013-08-23
564	Moreira - EI Beat	0	485	504	2007-08-14
565	Ellis and Sons Onda	0	84	584	2002-04-05
566	Moreno-Evans Play	0	66	550	2003-12-06
567	Rezende Machado Ltda. Filmes	0	702	458	2022-06-12
568	Pastor Marques S/A Atlas	0	725	65	1990-06-04
569	Scott-Collins Exclusive	0	683	255	2023-04-26
570	Rocha Albuquerque e Filhos Navigator	0	777	99	2019-11-16
571	da Paz - EI Now	0	983	407	2025-06-15
572	Macedo S.A. Lineup	0	839	828	2019-12-09
573	Jesus S/A Equipe	0	686	636	2021-10-26
574	Morris-Goodwin Exclusive	0	201	200	1997-03-31
575	Davis-Morgan Prime	0	374	809	1990-02-10
576	Pastor S/A Lineup	0	611	934	2024-07-02
577	Lee-Ponce Play	0	8	398	2008-01-03
578	Pinto Garcia e Filhos Pod	0	123	963	1995-07-23
579	das Neves S.A. Pass	0	725	85	1995-09-05
580	Rodriguez Ltd Showcase	0	438	836	2025-09-25
581	Novais Caldeira - EI Equipe	0	704	513	2012-09-21
582	Santos Monteiro S.A. Navigator	0	215	839	2008-04-26
583	Costela Cassiano e Filhos Reels	0	248	927	2004-03-02
584	Viana S/A Now	0	883	163	2011-03-17
585	Costela Ramos - EI Vault	0	618	901	2008-07-19
586	Ewing PLC Mais	0	466	199	1996-05-07
587	das Neves Melo - EI Aqui	0	523	641	1997-01-19
588	Guerra Duarte e Filhos Plus	0	710	109	2019-05-04
589	Johnston LLC Verse	0	939	598	2015-08-28
590	Benson-Nixon Connect	0	903	847	1994-01-26
591	Sousa - EI Agora+	0	540	324	2006-05-04
592	Nascimento Fonseca e Filhos Highlights	0	736	520	1996-06-10
593	Taylor PLC Highlights	0	601	339	2020-09-13
594	Ribeiro Pastor - EI Streamers	0	290	425	2010-08-13
595	Rios e Filhos Aqui	0	584	272	1991-03-21
596	Ortiz-Yates CinePlus	0	606	300	1997-10-15
597	Carter, Davis and Curtis Edge	0	214	51	2014-08-16
598	Gentry, Garrett and Miller Flow	0	7	423	2006-08-11
599	Weber, Roman and Carpenter Stage	0	457	840	2004-07-18
600	Brown-Lee Originals	0	102	30	2022-09-26
601	Sales - ME Channel	0	552	788	2004-05-07
602	Fox LLC Aqui	0	313	292	2021-10-05
603	Rocha Gomes Ltda. Play	0	867	565	2011-12-08
604	Pacheco S.A. Select	0	371	373	2017-02-15
605	Crawford-Patterson Premium	0	303	843	1994-12-17
606	Barker, Williams and Hayes Air	0	497	827	1998-07-07
607	Thompson, Payne and Bennett Play	0	265	86	1997-03-30
608	Phillips, Morrison and Gallegos Groove	0	354	655	1994-03-09
609	Barrera, Watts and Harmon Live	0	692	813	2000-06-04
610	Tyler-Lloyd CastTV	0	885	320	1999-02-12
611	Ribeiro Abreu S.A. Now+	0	753	669	2011-11-14
612	Barbosa S/A Exclusive	0	395	466	2021-10-18
613	das Neves S/A Cast	0	37	823	2016-11-25
614	Guerra Mendes e Filhos Studio	0	575	827	1997-05-24
615	da Cruz Lopes S/A Network	0	719	602	1998-02-11
616	Edwards, Goodwin and Andersen Agora+	0	445	619	2020-10-15
617	Jones-Glover Streamers	0	863	516	2006-02-21
618	Nogueira e Filhos Radio	0	50	896	2004-04-19
619	da Cunha Ltda. Mundo	0	721	676	2023-10-22
620	Abreu da Paz S/A Universe	0	191	616	2013-07-04
621	Manning-Andrews Plus	0	332	975	2009-03-06
622	Carpenter, Montgomery and Velasquez HoraNobre	0	687	613	2015-10-12
623	Bailey-Jackson Universe	0	562	269	2005-12-24
624	Knight Ltd Entrada	0	303	106	2022-03-25
625	Wallace Group Flix	0	332	97	2016-03-29
626	Bradford-Dunlap Access+	0	180	282	2008-12-18
627	Santiago-Lee Portal	0	67	438	1991-10-26
628	Giles LLC Fila	0	129	63	2014-05-03
629	Henderson, Rhodes and Morgan OnRepeat	0	529	448	2008-05-31
630	da Rocha - ME Studio	0	421	176	2000-09-26
631	da Luz Ramos - EI Collective	0	207	409	2018-06-24
632	Cassiano Silva S/A Stage	0	620	629	2021-10-13
633	Azevedo da Rocha S/A Radio	0	904	486	1994-09-25
634	Spence LLC Collection	0	315	486	2012-01-16
635	Silva Porto - EI Aqui	0	192	15	2003-07-07
636	Foley, Woodard and Norris Sincroniza	0	561	130	2024-11-11
637	Souza Araújo S/A Gate	0	785	597	2004-04-30
638	Lucas, Hatfield and Cunningham Sincroniza	0	787	354	2014-10-07
639	Pinto Ltda. Hub	0	787	941	2009-06-08
640	Sampaio Ferreira S.A. Loop	0	597	936	2009-11-03
641	Anderson, Hughes and Armstrong Access+	0	408	360	2007-06-23
642	Sousa Montenegro e Filhos Streamline	0	395	435	1999-12-10
643	Siqueira S/A Highlights	0	437	201	2006-07-23
644	Costa das Neves - EI PrimeTime	0	792	897	1999-02-21
645	Smith, Jones and Duncan Live+	0	940	249	2009-02-20
646	Orr-Wade Future	0	813	447	1992-10-08
647	Kemp, Frederick and Sweeney Replay	0	173	298	2010-02-19
648	Sullivan, West and Norton Playground	0	909	245	2018-06-22
649	Roberts-Chavez Mapa	0	642	440	2011-07-19
650	Montenegro Rios S.A. Play	0	186	125	2012-02-14
651	Vargas - ME Transmit	0	169	551	1994-11-12
652	Coleman Group Access+	0	849	998	2012-07-27
653	Davis-Contreras CastTV	0	314	565	2011-09-20
654	Martins - EI Future	0	975	823	1996-02-11
655	Carvalho Ltda. Portal	0	731	142	2024-10-27
656	Gonzalez-Bond Originais	0	585	345	2011-07-09
657	Moraes Duarte S.A. OnRepeat	0	833	405	1992-05-09
658	Armstrong-Stewart Pro	0	930	127	2021-06-11
659	da Costa Nogueira - ME Hub	0	33	239	1999-03-25
660	Machado Vieira e Filhos Originals	0	394	424	1999-06-24
661	Sanchez, Cole and Brock OnRepeat	0	146	289	2003-09-09
662	Gordon-Brown HoraNobre	0	488	483	1994-04-01
663	Castillo Inc Stream	0	369	566	2002-03-18
664	Vieira da Mata e Filhos Sincroniza	0	648	239	1991-10-06
665	Rocha Cassiano S/A Air	0	900	854	1998-11-10
666	Moraes Silva - EI Prime	0	172	373	2014-07-07
667	da Conceição - ME Radio	0	911	497	2013-07-17
668	Underwood-Allison Spotlight	0	39	219	2014-05-14
669	Gomes Novais Ltda. Hub	0	889	177	1990-04-16
670	da Mata - ME Mapa	0	313	403	2007-07-29
671	Rios S/A Beat	0	908	594	2018-11-15
672	Jackson, Anderson and Ford Future	0	80	142	1994-03-11
673	Pacheco Vargas S.A. Future	0	33	35	2012-06-06
674	Jones, Gaines and Lawrence Premium	0	576	109	2021-08-30
675	Barros S.A. Universal	0	694	457	2011-02-13
676	Jennings-Evans Sync	0	931	871	2009-12-16
677	Rowland, Johnson and Franklin Worlds	0	896	743	2013-08-24
678	Shaffer, Sanchez and Munoz Select	0	994	86	2019-12-16
679	Duarte S.A. Pro	0	631	24	2024-01-14
680	Pires Gonçalves - ME Showcase	0	12	174	2002-09-09
681	Wolf-Sanchez LiveStream	0	219	122	2022-03-19
682	Pinto - ME Cine	0	698	509	2001-08-30
683	Sales S.A. Universe	0	911	878	1995-04-03
684	Freitas Montenegro S.A. Realm	0	416	158	2002-03-08
685	Boone, Grant and Franklin Beat	0	639	341	2025-09-13
686	Aguilar and Sons Cast	0	694	912	1999-05-15
687	Hart, Brown and Rodriguez Library	0	944	412	2007-12-09
688	Huerta and Sons Edge	0	440	781	2024-08-21
689	Montenegro Ramos - EI Atlas	0	205	312	2009-07-15
690	Bush-Bates Originals	0	530	579	2017-04-22
691	Azevedo Alves Ltda. Pro	0	352	157	2024-01-04
692	Foster-Taylor Canal	0	323	261	2001-04-25
693	Ferreira Ribeiro S/A Replay	0	444	645	2001-09-27
694	Parrish-Weber Shows	0	59	619	2006-03-19
695	Silveira da Cruz - ME PrimeTime	0	940	93	1994-03-27
696	Carvalho Campos Ltda. Ir	0	894	985	2013-04-08
697	Lima - EI Collective	0	804	672	2009-02-07
698	Novaes Araújo - EI Universe	0	590	416	1994-12-26
699	Souza S.A. Access+	0	393	42	1990-05-31
700	Abreu da Rosa S/A AoVivo	0	967	997	1997-06-27
701	Dias S/A Prime	0	819	424	1999-06-04
702	Rios da Paz - EI Premium	0	342	486	1994-04-09
703	Tran, Fernandez and Williams Now+	0	397	365	2015-06-04
704	Decker Ltd Live	0	859	341	1996-12-18
705	Erickson, Smith and Parker Stage	0	687	426	2000-10-25
706	Macedo Ltda. Hub	0	846	706	2001-06-23
707	Cox-Barajas Station	0	413	514	2011-06-09
708	Gallegos LLC Live	0	391	813	1993-07-25
709	Rowland-Potter Reel	0	917	472	2006-12-14
710	Mendonça Pereira S/A Plus	0	654	81	2014-07-02
711	Kirk, Mitchell and Watts Queue	0	172	778	2002-05-06
712	Shaw-Martinez Streamline	0	979	281	2009-02-12
713	Wells-Oconnor Cinema	0	870	508	1990-02-10
714	Melendez-Davis CinePlus	0	590	813	2017-04-01
715	Haley-Johnson Universe	0	958	545	2016-07-28
716	das Neves Ltda. AoVivo	0	2	755	2018-11-28
717	Donaldson, Marsh and Moore Universo	0	897	770	1997-09-29
718	Gallagher PLC Select	0	6	166	2011-10-26
719	da Cruz Souza S/A Plus	0	640	827	1999-10-01
720	Siqueira Mendes - ME Equipe	0	900	59	2005-11-07
721	da Mota Ribeiro S/A Stage	0	277	499	2024-11-23
722	Moore, Davis and Strickland Broadcast	0	275	660	2006-11-15
723	Williamson PLC NextGen	0	531	399	2004-02-06
724	Fernandes Nascimento Ltda. Streamers	0	705	991	2018-03-13
725	Novais Moura e Filhos Edge	0	68	656	2004-11-03
726	Sá da Rosa - EI Hub	0	730	340	1998-11-10
727	Ferreira Cavalcanti S/A Crew	0	51	80	2003-06-10
728	Correia Lima e Filhos Schedule	0	903	826	2018-03-30
729	Lima e Filhos LiveStream	0	50	876	2024-02-08
730	Kennedy-Johnson Realm	0	950	957	1991-12-23
731	Costa Brito - ME Flix	0	503	200	2008-12-10
732	Rocha Sales e Filhos Air	0	740	28	1998-08-03
733	Santos Castro S/A Replay	0	903	681	2008-01-04
734	Siqueira Gomes - ME Edge	0	34	491	2024-10-17
735	Cline LLC Network	0	949	105	1992-11-19
736	Everett Inc HoraNobre	0	643	936	2003-03-17
737	Weaver Ltd Play	0	450	504	2018-10-02
738	Freitas - EI Playground	0	832	801	2003-07-26
739	Aparecida Oliveira - EI Direct	0	59	319	2014-10-17
740	Garcia Fonseca S.A. Hub	0	247	770	2025-02-05
741	Souza Brito S/A PocketTV	0	125	344	2009-08-04
742	Santos Pacheco - EI Crew	0	962	326	1998-11-28
743	Eaton Inc Edge	0	107	802	2019-11-02
744	Baker and Sons Streamline	0	302	192	2000-02-12
745	Reed-Arellano OnRepeat	0	594	117	1995-09-06
746	Murray, Ponce and Wilson Originals	0	476	154	2001-12-27
747	Machado - ME Pocket	0	396	720	2015-04-06
748	Benson, Booker and Henson Universal	0	498	213	2002-05-08
749	da Cruz Montenegro S.A. Air	0	449	588	2007-09-05
750	Nascimento Porto - EI Streamers	0	892	85	1999-06-16
751	Cavalcante Lopes e Filhos Box	0	170	335	2009-01-06
752	Cardoso da Rosa S/A Crew	0	404	616	2002-06-27
753	Pastor Ltda. LiveStream	0	871	443	1994-05-08
754	Smith, Rodgers and Kane PlayLab	0	319	431	1997-11-07
755	Rezende Nascimento S/A OnRepeat	0	362	608	2025-04-02
756	Peixoto Martins e Filhos Aqui	0	633	801	2017-01-22
757	Camargo - ME Channel	0	188	398	2021-07-19
758	Silva Oliveira Ltda. AoVivo	0	737	345	2013-05-18
759	Sá Ferreira Ltda. CastTV	0	314	817	2008-10-05
760	Dias Rios Ltda. Groove	0	225	937	1995-12-21
761	da Costa Fogaça Ltda. Originals	0	723	48	1991-04-10
762	Matthews, Walters and Duffy Portal	0	121	321	1997-06-06
763	Dias Fernandes - EI Transmit	0	465	744	1991-10-06
764	Aparecida S.A. Select	0	730	276	2017-11-12
765	Clark-Wise CastTV	0	440	182	2025-06-02
766	Dias Fogaça Ltda. NextGen	0	930	173	1990-10-03
767	Brito - EI Vibe	0	989	44	2014-03-10
768	Lopez and Sons Access+	0	717	885	1996-01-28
769	Pereira e Filhos Filmes	0	799	394	2022-04-02
770	Barros S/A Cine	0	926	7	2025-08-09
771	Zamora-Ingram Flix	0	452	654	2023-01-22
772	da Paz e Filhos Flix	0	539	431	1997-09-05
773	Brito S.A. Live	0	907	243	2022-10-19
774	Burns, Dalton and Bradford Highlights	0	362	662	2025-09-07
775	Miller-Chavez PocketTV	0	665	5	2023-08-15
776	Fogaça S/A PocketTV	0	431	682	2008-11-13
777	Cox Ltd Flow	0	591	186	2022-03-11
778	Henson-Cervantes Hub	0	898	821	2019-02-13
779	Cunha Guerra S.A. Reel	0	709	492	1998-02-14
780	Cavalcante Ltda. Flix	0	274	231	2023-07-12
781	Moura Alves S/A Now	0	109	181	2015-08-24
782	Santos Araújo Ltda. Edge	0	905	946	2009-04-04
783	Blair, Ramirez and Duran Onda	0	831	792	2010-02-12
784	Mendonça Ltda. Originals	0	785	134	2013-08-17
785	Hoover-Graves Channel	0	772	928	2010-05-31
786	Vasconcelos da Luz Ltda. Mini	0	914	62	1990-09-26
787	Costela S.A. Filmes	0	462	557	2001-02-12
788	Peixoto Ltda. Pro	0	499	752	1991-04-08
789	Costela Araújo e Filhos Replay	0	945	386	2017-02-14
790	Glass, Herrera and Stevens Connect+	0	903	524	2014-08-09
791	Aragão S/A Onda	0	76	7	2017-04-05
792	Câmara Costa Ltda. Next	0	281	141	2013-07-17
793	Barros Marques S/A Navigator	0	85	758	1995-06-30
794	Riley, Diaz and Parks On	0	946	54	2006-11-19
795	da Mata Costa e Filhos NextGen	0	132	838	1990-01-16
796	Peixoto e Filhos Scene	0	984	377	2014-02-11
797	Wolf Ltd Metaverse	0	93	535	2010-10-26
798	Sampaio S.A. AoVivo	0	436	235	2006-11-02
799	Mendoza, Wilkins and Salinas Connect+	0	933	712	2019-12-25
800	Rezende Melo - EI Scene	0	324	630	2000-10-02
801	Chambers LLC Universe	0	337	959	1993-03-27
802	das Neves Mendes - EI Originals	0	37	48	2018-02-19
803	Henderson-Rogers Transmit	0	479	167	2012-11-04
804	da Cruz Vieira - ME Originais	0	691	466	1991-09-19
805	Spencer LLC Crew	0	851	4	2011-07-22
806	Martinez LLC Lineup	0	632	39	2000-06-02
807	Souza Caldeira S/A Sync	0	636	79	2003-04-15
808	Lopez, Williams and Martinez Reels	0	181	876	2007-08-14
809	Stanley, Holt and Ray Explorer	0	814	987	2005-08-07
810	Caldeira S/A Lineup	0	505	538	2018-03-24
811	Rezende Ltda. Mais	0	497	706	2002-07-04
812	Albuquerque Cunha - ME Mundo	0	206	784	1998-06-03
813	Vieira - ME Lite	0	654	933	2002-10-03
814	Alves das Neves Ltda. Play	0	895	17	2012-10-23
815	Caldwell Ltd Pocket	0	314	161	2008-01-07
816	Walker-Martin Queue	0	715	750	2008-06-29
817	Logan, Liu and Brown Ritmo	0	57	719	1998-12-10
818	Hawkins, Donovan and Jones Navigator	0	536	125	1997-09-16
819	Brito Casa Grande S.A. Flix	0	822	336	2012-07-23
820	Wallace PLC Reel	0	21	694	2007-07-29
821	Vargas e Filhos Plus	0	274	437	2005-11-04
822	Santos - ME Universe	0	625	467	1999-04-22
823	Ramos da Mata Ltda. NextGen	0	340	278	1994-12-22
824	Ferreira Cassiano e Filhos CastTV	0	931	493	2013-08-09
825	Sales Ribeiro S.A. Sincroniza	0	406	133	1994-09-02
826	Sampaio Cardoso S/A Streamline	0	121	980	2002-01-12
827	Teixeira Melo e Filhos Aqui	0	821	518	1992-04-03
828	Espinoza, Spears and Harrell Sync	0	58	782	2007-06-01
829	Moore, Hogan and White Now+	0	666	294	2020-05-29
830	Cunha - ME Replay	0	464	698	1997-12-20
831	Parker-Davis Collective+	0	75	603	2006-05-15
832	Dunn LLC Entrada	0	570	83	2017-12-23
833	Caldeira Ferreira - ME Spotlight	0	494	227	2017-10-11
834	Bates, Munoz and Perez CastTV	0	147	359	2010-09-19
835	Russo, Deleon and Morse Ponto	0	307	101	1990-05-11
836	George, Spencer and Rodriguez Metaverse	0	503	966	2000-12-13
837	Moore-Macdonald Library	0	148	248	2007-09-05
838	Sampson Group Loop	0	912	780	1995-01-18
839	Murphy, King and Hunt Navigator	0	772	919	1993-07-19
840	da Cruz S/A Verse	0	415	437	2015-08-10
841	Garcia Ferreira - ME Playground	0	407	409	1999-07-22
842	Meyer PLC Beat	0	556	725	2012-11-14
843	Brito Caldeira S/A Spotlight	0	766	666	2011-10-05
844	Albuquerque Cavalcante - ME Reel	0	729	233	1992-01-28
845	Bradley, Campbell and Riley Spotlight	0	336	768	2007-08-18
846	Correia Campos S/A Filmes	0	867	351	2019-02-23
847	Hicks-Rice AoVivo	0	79	809	1999-04-19
848	Armstrong LLC Box	0	967	369	2004-07-17
849	Maxwell Group Gate	0	880	833	2017-05-05
850	Malone, Davis and Harris Access	0	786	688	2009-07-23
851	Parks-Gonzalez Flow	0	775	987	1999-08-16
852	Vargas Martins Ltda. CinePlus	0	566	50	2019-11-07
853	Alves Mendonça e Filhos Flow	0	472	67	2016-08-15
854	Best, Jennings and Vincent Now+	0	46	295	2005-03-18
855	Campos e Filhos Cine	0	237	387	2019-01-26
856	Santos Lopes S/A Highlights	0	903	887	1998-08-03
857	Fletcher, White and Payne Streamers	0	604	529	1991-04-30
858	Gomez-Gomez Fila	0	428	453	1991-03-11
859	Cavalcanti Rezende Ltda. LoopTV	0	534	4	2000-07-31
860	Guerra e Filhos Mini	0	409	131	2014-03-27
861	West, Rice and Barnett Plus	0	409	233	2003-10-30
862	Cavalcante Montenegro e Filhos Fluxo	0	213	836	1992-04-19
863	Gray-Pugh Collection	0	36	330	2011-10-02
864	Hatfield, Smith and Sandoval Exclusive	0	352	641	1996-04-02
865	Azevedo da Cunha - EI Play	0	423	582	1997-05-28
866	Moura - EI Pass	0	897	377	2005-12-21
867	Moraes Silva e Filhos Now+	0	137	675	1999-02-14
868	Collier PLC Beat	0	297	916	1991-09-10
869	Munoz, Juarez and Todd Mini	0	114	333	2013-02-05
870	Correia Sousa Ltda. Radio	0	217	195	1991-11-03
871	Ho-Oliver Mundo	0	989	250	2001-09-06
872	Cardoso Rocha Ltda. Fluxo	0	866	32	2002-08-12
873	Novaes - ME Crew	0	187	545	1998-01-13
874	Viana Aragão S/A Streamline	0	725	765	2007-09-24
875	Cirino Sá e Filhos Sincroniza	0	150	251	2006-05-23
876	Aparecida Sousa - EI Next	0	672	801	1994-07-03
877	Rodriguez, Padilla and Smith HoraNobre	0	816	546	2004-03-04
878	Hanson and Sons Access	0	90	824	2016-12-08
879	Howell-George AoVivo	0	597	469	1996-03-23
880	Harris, Bishop and Butler Vibe	0	501	25	2009-08-18
881	Fonseca e Filhos Studio	0	667	130	2003-12-23
882	Burke, Maldonado and Harrison CastTV	0	218	613	1997-11-22
883	Fonseca Garcia S/A Channel	0	677	621	2007-10-20
884	da Luz Costa - ME Gate	0	190	660	2001-11-27
885	Castro Cunha Ltda. OnRepeat	0	472	626	1999-10-30
886	Carr, Harrington and Carter Collective	0	222	271	1994-03-07
887	Davis, Glass and Gallegos Fluxo	0	11	322	1997-12-24
888	Cavalcanti Guerra S.A. Loop	0	654	834	2009-02-06
889	da Mota Peixoto e Filhos Air	0	150	449	2018-06-30
890	Washington-Green Library	0	902	435	1999-07-29
891	Campos Cavalcanti S/A Exclusivo	0	983	333	2001-01-01
892	Silva S.A. Pro	0	394	612	2000-01-25
893	Mercado, Fox and Fernandez Spot	0	903	629	2018-02-23
894	Gonçalves Leão - ME Flow	0	15	191	2015-04-21
895	Hensley, Jensen and Ross Air	0	837	158	2016-02-17
896	Machado Garcia Ltda. Select	0	224	704	2024-03-12
897	Cavalcante S.A. PlayLab	0	286	106	2010-07-20
898	da Paz Peixoto Ltda. Fila	0	301	583	2021-07-13
899	Sanford, Riley and Bush Schedule	0	5	928	2014-03-17
900	Câmara Abreu - EI Channel	0	726	348	2023-09-19
901	da Rosa Sá e Filhos Air	0	855	655	1993-10-30
902	Pereira Vargas e Filhos Sync	0	687	999	1992-05-03
903	Farias S/A Reels	0	824	228	2006-06-14
904	da Mota Pires Ltda. Channel	0	629	103	2011-05-22
905	Carvalho Fogaça e Filhos Cinema	0	851	640	2009-11-18
906	Sá da Costa - ME Highlights	0	969	491	2023-04-03
907	Palmer Inc Direct	0	416	588	2017-05-18
908	Miller, Martinez and Lynch Entrada	0	335	653	1991-06-24
909	Vieira da Cunha S.A. Library	0	486	242	2017-07-25
910	Carvalho da Mata S/A Navigator	0	234	200	2005-05-09
911	Garcia-Alvarado Mais	0	42	777	2025-02-09
912	Morgan LLC Station	0	26	700	1995-09-18
913	Abreu Gomes - EI Exclusive	0	873	481	1992-12-26
914	Cassiano Andrade - ME Now	0	769	409	1997-11-04
915	Morrow Ltd Agora+	0	212	100	1993-01-09
916	Alexander, Russell and Miller Ritmo	0	936	306	2008-05-15
917	Garcia Pires - ME Now	0	151	409	2003-05-22
918	Montenegro Machado e Filhos Wave	0	203	87	2011-10-17
919	Wilson, Cantu and Austin Loop	0	398	888	2014-06-29
920	Ward LLC Access	0	118	894	2008-07-24
921	Silveira Carvalho S/A Radio	0	499	288	2018-12-11
922	Porto Ltda. Wave	0	605	371	2007-11-15
923	Smith-Cardenas Live	0	515	393	2016-08-07
924	Cassiano Lopes e Filhos Pass	0	289	388	1998-05-05
925	Freitas Abreu - ME PlayLab	0	928	412	2007-01-14
926	Albuquerque Fonseca - EI Ponto	0	374	547	2010-11-30
927	Vargas Lopes S/A Library	0	31	725	2014-12-20
928	Barbosa - ME Cast	0	579	813	2025-08-01
929	Peters, Nguyen and Avery Streamers	0	215	10	1992-04-12
930	Morales, Cox and Montgomery Direct	0	83	470	2000-10-17
931	Smith, Bolton and Anthony PocketTV	0	511	728	1998-09-21
932	Humphrey, Molina and Davis Air	0	738	159	2017-03-09
933	Dias - ME PrimeTime	0	459	962	2016-07-27
934	Moreira Novaes Ltda. Network	0	448	417	2013-06-17
935	Peixoto Pinto e Filhos HoraNobre	0	218	625	2012-10-16
936	Riley Inc Gate	0	325	250	2003-09-16
937	Morris, Lozano and Martin Mini	0	831	502	2001-04-01
938	Schneider Group NextGen	0	870	857	2008-06-21
939	da Rocha da Luz Ltda. Library	0	366	893	1991-07-29
940	Rezende S.A. Now+	0	781	829	2005-12-14
941	Aragão Jesus Ltda. Beat	0	454	182	1997-08-25
942	Vargas Farias - EI HoraNobre	0	135	367	2022-05-30
943	Hopkins-Ingram Flow	0	446	446	2003-06-03
944	Ribeiro Vasconcelos e Filhos Cast	0	635	550	2016-07-12
945	Becker, Gray and Ayers Mapa	0	413	284	2025-03-09
946	Harrison, Rodriguez and Rodriguez Canal	0	401	305	1999-12-15
947	Guerra S/A Hub	0	667	255	2016-07-11
948	Aparecida Melo S/A Stage	0	183	801	1999-11-22
949	Fonseca Nogueira - EI Scene	0	287	896	1990-05-25
950	Sousa S/A Access	0	904	283	1994-05-16
951	Mendonça e Filhos Future	0	910	755	2003-08-26
952	Hernandez-Fuller Explorer	0	719	653	2007-04-08
953	Simpson-Cross Worlds	0	902	95	1991-11-11
954	Meadows, Simpson and Wilson Streamline	0	701	326	2004-11-14
955	Newton, Hughes and Snyder Future	0	747	416	2015-09-16
956	Taylor, White and Ward Play	0	342	780	2011-05-03
957	Oliveira Cavalcante S.A. Metaverse	0	403	42	1990-12-27
958	Sawyer LLC Shows	0	229	198	2024-07-07
959	Garcia S/A Onda	0	494	65	2010-04-12
960	Myers, Riley and Daniels Filmes	0	871	172	1999-12-24
961	Cavalcante Cardoso Ltda. Reel	0	93	37	2007-04-14
962	Perry-Solomon Spot	0	153	844	1990-01-07
963	Hebert-Avila Explorer	0	579	852	1994-12-22
964	Fernandes - EI Pod	0	346	905	2007-05-13
965	Henderson-Daniels Ritmo	0	90	578	2010-03-28
966	Peixoto Guerra e Filhos PocketTV	0	216	116	2007-10-11
967	Azevedo Vieira S/A HoraNobre	0	33	250	2012-08-15
968	Silveira - EI Entrada	0	630	289	2018-10-21
969	Santos e Filhos Pro	0	760	489	2005-08-16
970	Scott-Hunt Sync	0	422	64	2001-10-18
971	Ribeiro S/A Station	0	473	185	2015-06-17
972	Stone Group Direct	0	104	448	2005-01-21
973	Heath-Brady Originais	0	105	895	2008-05-13
974	Viana e Filhos Plataforma	0	452	527	2018-08-25
975	Nunes Teixeira Ltda. Premium	0	233	382	2003-03-11
976	Moreno, Wilson and Hawkins Atlas	0	341	742	2003-01-07
977	Souza Porto - EI Navigator	0	579	821	2002-12-20
978	Fonseca Fonseca e Filhos Mapa	0	500	639	2017-11-28
979	Cassiano e Filhos Sync	0	437	267	1994-02-24
980	Freitas Andrade S.A. Mini	0	84	221	2023-11-10
981	Jenkins, Strong and Becker Transmit	0	300	122	1993-11-30
982	Lopes Araújo - EI Next	0	768	11	2013-02-22
983	White, Johnson and Gilbert On	0	993	93	2001-03-04
984	Ferreira Teixeira - ME Reels	0	382	422	2001-03-05
985	Guerra Pacheco - ME Pod	0	344	984	2016-10-17
986	Pires Monteiro S.A. Now+	0	244	950	2019-02-24
987	Boone Ltd Replay	0	582	552	1995-06-16
988	Ramos Siqueira Ltda. LoopTV	0	768	456	1995-09-20
989	Morales, Hayes and Hunter Broadcast	0	208	418	2015-08-25
990	Castro Martins Ltda. Aqui	0	622	338	2021-10-24
991	Small-Patton PocketTV	0	843	305	2000-08-30
992	Barbosa Rodrigues S.A. Aqui	0	425	525	1995-07-09
993	Rios Alves Ltda. Hub	0	568	71	1999-10-12
994	Vasconcelos Farias S.A. Portal	0	933	329	2016-02-16
995	Aragão - ME LoopTV	0	617	138	2019-11-29
996	Hines-Kline Stream	0	646	876	2021-08-25
997	Vargas da Paz S.A. Queue	0	656	424	2004-08-20
998	Sharp-Webb Originals	0	144	947	2022-06-01
999	Ferreira Brito S/A AoVivo	0	26	624	1991-07-15
1000	Stewart-Gill HoraNobre	0	464	54	1996-12-04
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

COPY public.usuario (nick, email, data_nasc, telefone, end_postal, nome_pais_residencia) FROM stdin;
\.


--
-- TOC entry 5282 (class 0 OID 16636)
-- Dependencies: 267
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.video (nro_plataforma, nome_canal, titulo, datah, tema, duracao_segs, visu_simul, visu_total) FROM stdin;
\.


--
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 220
-- Name: bitcoin_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_nro_plataforma_seq', 1, false);


--
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 221
-- Name: bitcoin_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_seq_comentario_seq', 1, false);


--
-- TOC entry 5328 (class 0 OID 0)
-- Dependencies: 222
-- Name: bitcoin_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_seq_doacao_seq', 1, false);


--
-- TOC entry 5329 (class 0 OID 0)
-- Dependencies: 224
-- Name: canal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.canal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5330 (class 0 OID 0)
-- Dependencies: 226
-- Name: cartao_credito_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_nro_plataforma_seq', 1, false);


--
-- TOC entry 5331 (class 0 OID 0)
-- Dependencies: 227
-- Name: cartao_credito_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_seq_comentario_seq', 1, false);


--
-- TOC entry 5332 (class 0 OID 0)
-- Dependencies: 228
-- Name: cartao_credito_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_seq_doacao_seq', 1, false);


--
-- TOC entry 5333 (class 0 OID 0)
-- Dependencies: 230
-- Name: comentario_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_nro_plataforma_seq', 1, false);


--
-- TOC entry 5334 (class 0 OID 0)
-- Dependencies: 231
-- Name: comentario_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_seq_seq', 1, false);


--
-- TOC entry 5335 (class 0 OID 0)
-- Dependencies: 234
-- Name: doacao_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_nro_plataforma_seq', 1, false);


--
-- TOC entry 5336 (class 0 OID 0)
-- Dependencies: 235
-- Name: doacao_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_seq_comentario_seq', 1, false);


--
-- TOC entry 5337 (class 0 OID 0)
-- Dependencies: 236
-- Name: doacao_seq_pg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_seq_pg_seq', 1, false);


--
-- TOC entry 5338 (class 0 OID 0)
-- Dependencies: 270
-- Name: empresa_nro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_nro_seq', 1, false);


--
-- TOC entry 5339 (class 0 OID 0)
-- Dependencies: 238
-- Name: empresa_pais_nro_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_pais_nro_empresa_seq', 1, false);


--
-- TOC entry 5340 (class 0 OID 0)
-- Dependencies: 240
-- Name: inscricao_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscricao_nro_plataforma_seq', 1, false);


--
-- TOC entry 5341 (class 0 OID 0)
-- Dependencies: 242
-- Name: mecanismo_plat_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_nro_plataforma_seq', 1, false);


--
-- TOC entry 5342 (class 0 OID 0)
-- Dependencies: 243
-- Name: mecanismo_plat_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_comentario_seq', 1, false);


--
-- TOC entry 5343 (class 0 OID 0)
-- Dependencies: 244
-- Name: mecanismo_plat_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_doacao_seq', 1, false);


--
-- TOC entry 5344 (class 0 OID 0)
-- Dependencies: 245
-- Name: mecanismo_plat_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_seq', 1, false);


--
-- TOC entry 5345 (class 0 OID 0)
-- Dependencies: 247
-- Name: nivel_canal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nivel_canal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5346 (class 0 OID 0)
-- Dependencies: 250
-- Name: participa_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participa_nro_plataforma_seq', 1, false);


--
-- TOC entry 5347 (class 0 OID 0)
-- Dependencies: 252
-- Name: patrocinio_nro_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patrocinio_nro_empresa_seq', 1, false);


--
-- TOC entry 5348 (class 0 OID 0)
-- Dependencies: 253
-- Name: patrocinio_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patrocinio_nro_plataforma_seq', 1, false);


--
-- TOC entry 5349 (class 0 OID 0)
-- Dependencies: 255
-- Name: paypal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5350 (class 0 OID 0)
-- Dependencies: 256
-- Name: paypal_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_seq_comentario_seq', 1, false);


--
-- TOC entry 5351 (class 0 OID 0)
-- Dependencies: 257
-- Name: paypal_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_seq_doacao_seq', 1, false);


--
-- TOC entry 5352 (class 0 OID 0)
-- Dependencies: 259
-- Name: plataforma_empresa_fund_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_empresa_fund_seq', 1, false);


--
-- TOC entry 5353 (class 0 OID 0)
-- Dependencies: 260
-- Name: plataforma_empresa_respo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_empresa_respo_seq', 1, false);


--
-- TOC entry 5354 (class 0 OID 0)
-- Dependencies: 261
-- Name: plataforma_nro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_nro_seq', 1, false);


--
-- TOC entry 5355 (class 0 OID 0)
-- Dependencies: 263
-- Name: plataforma_usuario_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_usuario_nro_plataforma_seq', 1, false);


--
-- TOC entry 5356 (class 0 OID 0)
-- Dependencies: 264
-- Name: plataforma_usuario_nro_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_usuario_nro_usuario_seq', 1, false);


--
-- TOC entry 5357 (class 0 OID 0)
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
    ADD CONSTRAINT fk_usuario_pais FOREIGN KEY (nome_pais_residencia) REFERENCES public.pais(nome) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5086 (class 2606 OID 22252)
-- Name: video fk_video_canal; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT fk_video_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES public.canal(nro_plataforma, nome) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2025-10-30 02:34:59

--
-- PostgreSQL database dump complete
--

\unrestrict tPU60J3Re5P3uydPE3utjhhlIMQtas49GSwM4fZU8rfLdy7ckYgdKWA1xdYI1nN

