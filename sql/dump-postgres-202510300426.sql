--
-- PostgreSQL database dump
--

\restrict 5FVC26ZkiKeIWrA2Ff5V5oqfpFmQnr4TxhEq5nqFkepIB36CK9gDboCWlKHGcT8

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-30 04:26:03

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
-- TOC entry 5291 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';


ALTER DATABASE postgres OWNER TO postgres;

\unrestrict 5FVC26ZkiKeIWrA2Ff5V5oqfpFmQnr4TxhEq5nqFkepIB36CK9gDboCWlKHGcT8
\connect postgres
\restrict 5FVC26ZkiKeIWrA2Ff5V5oqfpFmQnr4TxhEq5nqFkepIB36CK9gDboCWlKHGcT8

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
-- TOC entry 5292 (class 0 OID 0)
-- Dependencies: 5291
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


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
-- TOC entry 5307 (class 0 OID 0)
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
-- TOC entry 5308 (class 0 OID 0)
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
-- TOC entry 5309 (class 0 OID 0)
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
-- TOC entry 5310 (class 0 OID 0)
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
-- TOC entry 5311 (class 0 OID 0)
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
-- TOC entry 5312 (class 0 OID 0)
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
-- TOC entry 5313 (class 0 OID 0)
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
-- TOC entry 5314 (class 0 OID 0)
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
-- TOC entry 5315 (class 0 OID 0)
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
-- TOC entry 5316 (class 0 OID 0)
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
-- TOC entry 5317 (class 0 OID 0)
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
-- TOC entry 5318 (class 0 OID 0)
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
-- TOC entry 5319 (class 0 OID 0)
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
-- TOC entry 5320 (class 0 OID 0)
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
-- TOC entry 5321 (class 0 OID 0)
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
-- TOC entry 5322 (class 0 OID 0)
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
-- TOC entry 5323 (class 0 OID 0)
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
-- TOC entry 5324 (class 0 OID 0)
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
-- TOC entry 5325 (class 0 OID 0)
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
-- TOC entry 5326 (class 0 OID 0)
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
    pais_passaporte text CONSTRAINT streamer_pais_nome_pais_not_null NOT NULL
);


ALTER TABLE public.streamer_pais OWNER TO postgres;

--
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN streamer_pais.pais_passaporte; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.streamer_pais.pais_passaporte IS 'Identifica o país do passaporte';


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
-- TOC entry 5328 (class 0 OID 0)
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
-- TOC entry 5329 (class 0 OID 0)
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
DZD	Algerian dinar	4.38007876
XDR	Special drawing rights	5.47483195
XPF	CFP franc	4.64703823
EUR	Euro	2.95560809
ARS	Argentine peso	4.13920654
NZD	New Zealand dollar	2.83177894
DJF	Djiboutian franc	2.84721701
OMR	Omani rial	3.69040815
XOF	West African CFA franc	3.68487894
MAD	Moroccan dirham	0.72175484
IDR	Indonesian rupiah	1.87388845
NPR	Nepalese rupee	1.38578304
RUB	Russian ruble	4.39089900
WST	Samoan tālā	4.80397405
FJD	Fijian dollar	2.25715029
JEP	Jersey pound	4.44506104
UAH	Ukrainian hryvnia	0.97036574
RON	Romanian leu	3.75806352
MVR	Maldivian rufiyaa	1.77543351
HRK	Croatian kuna	5.56986515
MOP	Macanese pataca	1.09129580
BYR	Belarusian ruble	2.23334089
KYD	Cayman Islands dollar	0.95498205
LAK	Lao kip	0.51355566
SDG	Sudanese pound	4.81546899
GIP	Gibraltar pound	3.15776392
MKD	Macedonian denar	1.00723064
VEF	Venezuelan bolívar	5.73699162
SAR	Saudi riyal	1.84963091
BTN	Bhutanese ngultrum	5.25596625
CUP	Cuban peso	4.02003438
TTD	Trinidad and Tobago dollar	6.48200233
CLP	Chilean peso	4.43508928
USD	United States dollar	1.00000000
HKD	Hong Kong dollar	0.62385690
NAD	Namibian dollar	2.65507837
STD	São Tomé and Príncipe dobra	5.72495627
PGK	Papua New Guinean kina	0.17623598
RWF	Rwandan franc	3.72925778
SHP	Saint Helena pound	0.34386690
AOA	Angolan kwanza	2.93924637
FKP	Falkland Islands pound	0.58923465
CZK	Czech koruna	5.29321650
BIF	Burundian franc	1.25770285
TVD	Tuvaluan dollar	1.22692874
PAB	Panamanian balboa	2.74360219
EGP	Egyptian pound	3.36727456
DKK	Danish krone	4.29573025
AWG	Aruban florin	1.36138071
BZD	Belize dollar	3.75956058
COP	Colombian peso	0.10412226
AFN	Afghan afghani	4.48401832
ALL	Albanian lek	3.64994992
SYP	Syrian pound	2.38145486
SZL	Swazi lilangeni	0.57530232
BGN	Bulgarian lev	0.28953642
CDF	Congolese franc	5.93421636
CNY	Renminbi	0.04417503
SRD	Surinamese dollar	6.17507928
PHP	Philippine peso	3.12799570
ZAR	South African rand	1.20343622
LRD	Liberian dollar	2.06381613
PKR	Pakistani rupee	4.64546110
IMP	Manx pound	2.58848446
YER	Yemeni rial	0.95465751
UGX	Ugandan shilling	4.72723487
BHD	Bahraini dinar	3.35162385
AED	United Arab Emirates dirham	4.29424812
TOP	Tongan paʻanga	4.28614621
QAR	Qatari riyal	4.39860369
GHS	Ghanaian cedi	0.25881297
IQD	Iraqi dinar	5.81922461
ISK	Icelandic króna	1.10079644
SOS	Somali shilling	3.31868324
MDL	Moldovan leu	5.80410454
GGP	Guernsey pound	3.50317288
HTG	Haitian gourde	4.23929195
SCR	Seychellois rupee	2.09087544
LTL	Lithuanian litas	5.70120745
CRC	Costa Rican colón	5.93289983
VUV	Vanuatu vatu	5.43396198
LBP	Lebanese pound	4.11886924
GTQ	Guatemalan quetzal	0.39581849
MWK	Malawian kwacha	5.47854547
DOP	Dominican peso	4.13791203
CAD	Canadian dollar	6.47242468
KES	Kenyan shilling	0.04520407
ERN	Eritrean nakfa	4.20481578
BWP	Botswana pula	0.83434612
ETB	Ethiopian birr	0.12897917
GYD	Guyanese dollar	4.93616016
MRO	Mauritanian ouguiya	4.87895800
KPW	North Korean won	0.43729201
SBD	Solomon Islands dollar	0.77135685
HNL	Honduran lempira	0.69851240
TND	Tunisian dinar	1.25252841
BMD	Bermudian dollar	2.42689103
KHR	Cambodian riel	3.75500773
XCD	Eastern Caribbean dollar	3.68843440
MNT	Mongolian tugrik	1.36157028
GBP	Pound sterling	0.93002795
AUD	Australian dollar	2.93466557
BDT	Bangladeshi taka	0.94269019
TWD	New Taiwan dollar	1.09147783
VND	Vietnamese đồng	4.32564241
ANG	Netherlands Antillean guilder	2.24060474
KZT	Kazakhstani tenge	4.03583698
TRY	Turkish lira	5.11518676
GNF	Guinean franc	3.98855381
MYR	Malaysian ringgit	3.04947160
PYG	Paraguayan guarani	0.97608668
SLL	Sierra Leonean leone	2.15912731
SVC	Salvadoran colón	1.16364025
BND	Brunei dollar	1.30358945
LYD	Libyan dinar	5.33834582
TJS	Tajikistani somoni	1.46390856
IRR	Iranian rial	2.76817885
THB	Thai baht	0.59448028
MMK	Burmese kyat	6.25374634
NIS	Israeli new shekel	5.27898147
GMD	Gambian dalasi	1.26230986
KMF	Comorian franc	6.15248450
MGA	Malagasy ariar	6.03357613
HUF	Hungarian forint	4.84049449
NGN	Nigerian naira	3.33980660
CHF	Swiss franc	5.38108522
XAF	Central African CFA franc	0.67349628
UYU	Uruguayan peso	4.95124953
PEN	Peruvian sol	0.28633274
CUC	Cuban convertible peso	4.57919531
SGD	Singapore dollar	3.58809485
RSD	Serbian dinar	5.32472670
ZMW	Zambian kwacha	5.32504192
NIO	Nicaraguan córdoba	4.55793145
JMD	Jamaican dollar	1.31702570
TMT	Turkmenistan manat	4.15630068
NOK	Norwegian krone	0.01469362
KRW	South Korean won	1.76834415
BOB	Bolivian boliviano	3.65423240
LKR	Sri Lankan rupee	3.14888473
AMD	Armenian dram	1.38695974
INR	Indian rupee	1.38553692
CVE	Cape Verdean escudo	6.15909757
PLN	Polish zloty	1.86885993
LSL	Lesotho loti	2.41239119
BRL	Brazilian real	5.04525418
KGS	Kyrgyzstani som	1.33569939
MXN	Mexican peso	4.40878606
JOD	Jordanian dinar	5.39755346
GEL	Georgian lari	4.64224715
TZS	Tanzanian shilling	2.90017862
BSD	Bahamian dollar	0.15326659
UZS	Uzbekistani soʻm	4.50844146
ILS	Israeli new shekel	2.18960763
MUR	Mauritian rupee	2.46038802
SEK	Swedish krona	4.01416287
MZN	Mozambican metical	1.17042190
JPY	Japanese yen	2.60350292
BAM	Bosnia and Herzegovina convertible mark	5.36321297
ZWD	Zimbabwean dollar	6.49527215
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
1	Williams-Johnson	Williams-Johnson Solutions
2	Stevens, Scott and Garcia	Stevens, Scott and Garcia Global
3	Clark-Ramos	Clark-Ramos Verde
4	Warner-Howard	Warner-Howard Finanças
5	Pimenta da Rocha e Filhos	Pimenta da Rocha e Filhos Verde
6	da Costa	da Costa Educação
7	Marques	Marques Worldwide
8	da Rosa Ltda.	da Rosa Ltda. Obras
9	Lynch and Sons	Lynch and Sons Inteligência
10	Lima - ME	Lima - ME Imobiliária
11	Cardoso	Cardoso Varejo
12	Howard Group	Howard Group Ambiental
13	Davis, Blankenship and Mckee	Davis, Blankenship and Mckee Moda
14	Martins	Martins Healthcare
15	Mendonça S.A.	Mendonça S.A. Alimentos
16	Gonzales-Erickson	Gonzales-Erickson Logística
17	Marshall-Lowe	Marshall-Lowe Distribuidora
18	Johnson-Garner	Johnson-Garner Smart
19	Kent-Campos	Kent-Campos Estilo
20	Lopez Ltd	Lopez Ltd Formação
21	Hayes and Sons	Hayes and Sons Varejo
22	Mendonça	Mendonça International
23	Stevens-Walton	Stevens-Walton Consulting
24	Butler Inc	Butler Inc Construções
25	Oliveira	Oliveira Varejo
26	Reynolds, Leon and Neal	Reynolds, Leon and Neal Construções
27	Crawford, Crawford and Lopez	Crawford, Crawford and Lopez Operações
28	Smith, Wall and Villanueva	Smith, Wall and Villanueva Legal
29	Wallace, Bishop and Lopez	Wallace, Bishop and Lopez Imobiliária
30	Fonseca da Costa e Filhos	Fonseca da Costa e Filhos Legal
31	Carlson PLC	Carlson PLC Healthcare
32	Barbosa	Barbosa Solutions
33	da Luz	da Luz Investimentos
34	Johnson and Sons	Johnson and Sons Services
35	da Rocha	da Rocha Advisors
36	Bray Ltd	Bray Ltd Next
37	Viana	Viana Inteligência
38	Henry, Villanueva and Davis	Henry, Villanueva and Davis Consultoria
39	Rocha - EI	Rocha - EI Networks
40	Hicks-Simmons	Hicks-Simmons Educação
41	Gibson, Morales and Sanders	Gibson, Morales and Sanders Construções
42	Alves - ME	Alves - ME Treinamento
43	Nunes	Nunes Advisors
44	Wiggins PLC	Wiggins PLC Consulting
45	da Rosa - EI	da Rosa - EI Hub
46	Wallace, Barker and Curry	Wallace, Barker and Curry Varejo
47	da Mota	da Mota Atelier
48	da Conceição	da Conceição Inovação
49	da Conceição Ltda.	da Conceição Ltda. Consultoria
50	Thompson, Todd and Pena	Thompson, Todd and Pena Academia
51	Shepherd, Jones and Sullivan	Shepherd, Jones and Sullivan Services
52	Guerra Ltda.	Guerra Ltda. Enterprises
53	Fowler-Wilson	Fowler-Wilson Capital
54	Pinto	Pinto Prime
55	Davis, Mclaughlin and Nguyen	Davis, Mclaughlin and Nguyen Obras
56	Douglas LLC	Douglas LLC Construções
57	Moura	Moura Delícias
58	Melo Moreira S.A.	Melo Moreira S.A. Labs
59	Weiss and Sons	Weiss and Sons Enterprises
60	Wilson Group	Wilson Group Serviços
61	Garcia Siqueira - EI	Garcia Siqueira - EI Factory
62	Mcgee, Horton and Davis	Mcgee, Horton and Davis Formação
63	Brito da Paz S.A.	Brito da Paz S.A. Labs
64	Caldwell, Chandler and Olsen	Caldwell, Chandler and Olsen International
65	Silveira S.A.	Silveira S.A. Creative
66	Newman and Sons	Newman and Sons Finanças
67	Souza Araújo S.A.	Souza Araújo S.A. Hub
68	Garcia and Sons	Garcia and Sons Strategies
69	Harmon LLC	Harmon LLC Studio
70	Chavez, Robinson and Avila	Chavez, Robinson and Avila Solutions
71	Gutierrez Inc	Gutierrez Inc Factory
72	Carney PLC	Carney PLC Culinária
73	Moreira Sampaio Ltda.	Moreira Sampaio Ltda. Healthcare
74	Scott, Coleman and Kelly	Scott, Coleman and Kelly Obras
75	Perry, Garcia and Sanders	Perry, Garcia and Sanders Operações
76	Gomes Cardoso S.A.	Gomes Cardoso S.A. Inteligência
77	Pacheco Rios S.A.	Pacheco Rios S.A. International
78	Mullins-Mueller	Mullins-Mueller Engine
79	Pierce, Fletcher and Riley	Pierce, Fletcher and Riley Gastronomia
80	Campos	Campos Atelier
81	Vargas	Vargas Assessoria
82	Wade-Hinton	Wade-Hinton Advisors
83	Borges Souza S/A	Borges Souza S/A Partners
84	Viana Nascimento - EI	Viana Nascimento - EI Eco
85	Martinez-Crawford	Martinez-Crawford Labs
86	Thompson, Thomas and Brown	Thompson, Thomas and Brown Frete
87	Marques Ltda.	Marques Ltda. Tecnologia
88	Wong-Richardson	Wong-Richardson Estilo
89	Garrison-Moore	Garrison-Moore Solutions
90	Livingston, Ross and Davis	Livingston, Ross and Davis Clinic
91	Cassiano	Cassiano Co
92	Siqueira	Siqueira Platform
93	Rios Novaes - EI	Rios Novaes - EI Moda
94	Nielsen-Taylor	Nielsen-Taylor Legal
95	Lopes Mendonça S.A.	Lopes Mendonça S.A. Varejo
96	Bradley-Rivera	Bradley-Rivera Digital
97	Pereira	Pereira Networks
98	Monteiro	Monteiro Moda
99	Peterson LLC	Peterson LLC Frete
100	Ochoa-White	Ochoa-White Consultoria
101	Martin-Ward	Martin-Ward Agency
102	Cavalcante	Cavalcante Atelier
103	Parker-Jordan	Parker-Jordan Verde
104	Simpson Ltd	Simpson Ltd Inteligência
105	Andrade Silva S.A.	Andrade Silva S.A. Assessoria
106	Cunha	Cunha Design
107	Wright-Smith	Wright-Smith Gastronomia
108	Ribeiro S/A	Ribeiro S/A Design
109	Azevedo	Azevedo Universal
110	Barbosa S/A	Barbosa S/A Verde
111	Bray PLC	Bray PLC Finanças
112	Moreira	Moreira Grupo
113	Garcia, Davis and Sanders	Garcia, Davis and Sanders Labs
114	Kelly Inc	Kelly Inc Verde
115	Carr Inc	Carr Inc Frete
116	da Conceição S.A.	da Conceição S.A. Distribuidora
117	Allen-Alexander	Allen-Alexander Delícias
118	Sims-Love	Sims-Love Moda
119	Pires Martins - EI	Pires Martins - EI Creative
120	da Luz - ME	da Luz - ME Delícias
121	Alves S/A	Alves S/A Partners
122	Costela	Costela Enterprises
123	Nascimento S/A	Nascimento S/A Labs
124	Araújo S/A	Araújo S/A Logística
125	Maynard-Fitzgerald	Maynard-Fitzgerald Design
126	Campbell Inc	Campbell Inc Platform
127	Pires	Pires Moda
128	Wilson Ltd	Wilson Ltd Inovação
129	Alves Gomes S/A	Alves Gomes S/A Formação
130	Kennedy-Salazar	Kennedy-Salazar Advisors
131	Sales	Sales Digital
132	Stanley PLC	Stanley PLC Alimentos
133	Andrade	Andrade Universal
134	Aragão - EI	Aragão - EI Factory
135	Duarte e Filhos	Duarte e Filhos Grupo
136	Moraes S.A.	Moraes S.A. Imobiliária
137	Alvarez-Anderson	Alvarez-Anderson Inovação
138	Montoya-King	Montoya-King Design
139	Mcdonald-Meadows	Mcdonald-Meadows Construções
140	Macedo	Macedo Atelier
141	Flowers, Blair and Stephens	Flowers, Blair and Stephens Educação
142	Hartman-Kelley	Hartman-Kelley Boutique
143	Scott PLC	Scott PLC Sustentável
144	Foster, Williams and Sweeney	Foster, Williams and Sweeney Operações
145	Palmer PLC	Palmer PLC Gastronomia
146	Pinto - ME	Pinto - ME Creative
147	Souza Freitas Ltda.	Souza Freitas Ltda. Wellness
148	Hodge, Lee and Williams	Hodge, Lee and Williams Treinamento
149	Blake, Campbell and Gregory	Blake, Campbell and Gregory Engine
150	Martin LLC	Martin LLC Worldwide
151	Porto	Porto Medical
152	Vasconcelos S/A	Vasconcelos S/A Varejo
153	Leão	Leão Advisors
154	Silva	Silva Sustentável
155	Novais S/A	Novais S/A Atacado
156	da Rocha Vieira - ME	da Rocha Vieira - ME Wellness
157	Sanchez LLC	Sanchez LLC Distribuidora
158	Ramos e Filhos	Ramos e Filhos Worldwide
159	Morgan, Ferrell and Maxwell	Morgan, Ferrell and Maxwell Factory
160	da Rosa Macedo S.A.	da Rosa Macedo S.A. Enterprises
161	Jesus	Jesus Services
162	Bell and Sons	Bell and Sons Consultoria
163	Fogaça	Fogaça Studio
164	Vieira	Vieira Moda
165	Williams, Jones and Ho	Williams, Jones and Ho Private
166	Pastor	Pastor Medical
167	Smith and Sons	Smith and Sons Factory
168	Lopez, Graham and Carter	Lopez, Graham and Carter Solutions
169	Silva S/A	Silva S/A Atacado
170	Montenegro Araújo - EI	Montenegro Araújo - EI Prime
171	Castillo Inc	Castillo Inc Partners
172	da Cruz S.A.	da Cruz S.A. Tech
173	Cunningham, Deleon and Black	Cunningham, Deleon and Black Atelier
174	Carvalho	Carvalho Formação
175	Clark-Hernandez	Clark-Hernandez Advisors
176	Brown-Martin	Brown-Martin Culinária
177	Copeland, Simmons and Phillips	Copeland, Simmons and Phillips Academia
178	Lee, Benton and Ross	Lee, Benton and Ross Collective
179	Sousa	Sousa Capital
180	Dias da Paz S.A.	Dias da Paz S.A. Holdings
181	Jones PLC	Jones PLC Hub
182	Peixoto	Peixoto Edge
183	Padilla Ltd	Padilla Ltd Edge
184	Hendricks Ltd	Hendricks Ltd Verde
185	Green, Harvey and Pennington	Green, Harvey and Pennington Inovação
186	Freitas Ltda.	Freitas Ltda. Sustentável
187	Young Ltd	Young Ltd Operações
188	da Mata Caldeira e Filhos	da Mata Caldeira e Filhos Services
189	Sanders Ltd	Sanders Ltd Delícias
190	Aparecida Castro Ltda.	Aparecida Castro Ltda. Inovação
191	da Cunha	da Cunha Tecnologia
192	Mcgee LLC	Mcgee LLC Private
193	Rodriguez, Davis and Hensley	Rodriguez, Davis and Hensley Solutions
194	Albuquerque Ltda.	Albuquerque Ltda. Design
195	Freitas	Freitas Assessoria
196	Shepard-Wright	Shepard-Wright Advisors
197	Wade-Perry	Wade-Perry Consultoria
198	Martins Pastor - ME	Martins Pastor - ME Medical
199	Walker Inc	Walker Inc Engine
200	Pires Ltda.	Pires Ltda. Networks
201	Green PLC	Green PLC Sustentável
202	Macedo - EI	Macedo - EI Frete
203	Cunningham Ltd	Cunningham Ltd Labs
204	Camargo	Camargo Atelier
205	Wilson, Hart and Jones	Wilson, Hart and Jones Medical
206	Gonçalves Duarte - EI	Gonçalves Duarte - EI Inteligência
207	Smith Group	Smith Group Advocacia
208	Gonçalves Porto e Filhos	Gonçalves Porto e Filhos Finanças
209	Schultz-Malone	Schultz-Malone Assessoria
210	Teixeira - ME	Teixeira - ME Clinic
211	Waller-Kelly	Waller-Kelly Gastronomia
212	Campbell Group	Campbell Group Tech
213	Almeida	Almeida Serviços
214	Rodriguez-Cortez	Rodriguez-Cortez Prime
215	Ferreira	Ferreira Agency
216	Woodward, Allen and Ferrell	Woodward, Allen and Ferrell Delícias
217	Alexander-Grimes	Alexander-Grimes Academia
218	Rios	Rios Verde
219	Gonçalves Cassiano S.A.	Gonçalves Cassiano S.A. Empreendimentos
220	Sullivan Ltd	Sullivan Ltd Solutions
221	Cunha Ribeiro e Filhos	Cunha Ribeiro e Filhos Private
222	Macedo S.A.	Macedo S.A. Gastronomia
223	Leão S.A.	Leão S.A. Eco
224	Santos Vieira - ME	Santos Vieira - ME Prime
225	Sá	Sá Legal
226	da Rosa Campos Ltda.	da Rosa Campos Ltda. Labs
227	Barrera-Smith	Barrera-Smith Networks
228	Moreira Ltda.	Moreira Ltda. Jurídico
229	Leach Ltd	Leach Ltd Transportes
230	Guzman-Dorsey	Guzman-Dorsey Frete
231	Howard, Jones and Smith	Howard, Jones and Smith Gastronomia
232	Ribeiro	Ribeiro Private
233	Crawford-Mitchell	Crawford-Mitchell Enterprises
234	Reynolds-Bailey	Reynolds-Bailey Imobiliária
235	Lima	Lima Solutions
236	Barbosa e Filhos	Barbosa e Filhos Ambiental
237	Miller-Freeman	Miller-Freeman Digital
238	da Costa S.A.	da Costa S.A. Co
239	Cardoso Caldeira - ME	Cardoso Caldeira - ME Partners
240	da Rosa	da Rosa Serviços
241	Barros Moura - EI	Barros Moura - EI Worldwide
242	Costela S/A	Costela S/A Formação
243	Hart-Valenzuela	Hart-Valenzuela Imobiliária
244	Ortiz-Hanson	Ortiz-Hanson Solutions
245	da Mata	da Mata Healthcare
246	Abreu S.A.	Abreu S.A. Advocacia
247	Garcia e Filhos	Garcia e Filhos Formação
248	Fernandes Martins - EI	Fernandes Martins - EI Global
249	Thomas LLC	Thomas LLC International
250	Hunt-Bruce	Hunt-Bruce Partners
251	Spencer and Sons	Spencer and Sons Varejo
252	da Cunha Castro - ME	da Cunha Castro - ME International
253	Alves Brito S.A.	Alves Brito S.A. Eco
254	Beck-Bowers	Beck-Bowers Creative
255	Hodges, Henson and Fernandez	Hodges, Henson and Fernandez Grupo
256	Rocha Fernandes - EI	Rocha Fernandes - EI Serviços
257	Bruce, Clark and Turner	Bruce, Clark and Turner Obras
258	West and Sons	West and Sons Grupo
259	Webb and Sons	Webb and Sons Serviços
260	Robinson-Holt	Robinson-Holt Partners
261	Smith-Hill	Smith-Hill Jurídico
262	Sousa Ltda.	Sousa Ltda. Solutions
263	Jones-Conway	Jones-Conway Design
264	Ramos	Ramos Private
265	Carvalho Moura - EI	Carvalho Moura - EI Comércio
266	Rezende S/A	Rezende S/A International
267	Morales, White and Thornton	Morales, White and Thornton Atacado
268	Moura e Filhos	Moura e Filhos Grupo
269	Teixeira Cavalcanti S/A	Teixeira Cavalcanti S/A Assessoria
270	Reyes-Allison	Reyes-Allison Transportes
271	Gordon and Sons	Gordon and Sons Culinária
272	Costa	Costa Systems
273	Ewing, Conley and Perez	Ewing, Conley and Perez Grupo
274	Pimenta S/A	Pimenta S/A Boutique
275	Merritt-Smith	Merritt-Smith Creative
276	Valenzuela, Lopez and Taylor	Valenzuela, Lopez and Taylor Alimentos
277	Anthony Group	Anthony Group Co
278	Cirino S.A.	Cirino S.A. Global
279	Vieira e Filhos	Vieira e Filhos Moda
280	Gonzalez-Wilson	Gonzalez-Wilson Collective
281	Williams-Campos	Williams-Campos Solutions
282	White-Evans	White-Evans Agency
283	Almeida Silveira S.A.	Almeida Silveira S.A. Factory
284	Mills, Murray and Freeman	Mills, Murray and Freeman Varejo
285	Bell-Marshall	Bell-Marshall Co
286	Castro - ME	Castro - ME Treinamento
287	Novais	Novais Global
288	Sá da Cunha S.A.	Sá da Cunha S.A. Networks
289	Mejia Ltd	Mejia Ltd Formação
290	Costa Camargo S/A	Costa Camargo S/A Ambiental
291	Woods PLC	Woods PLC Works
292	Cain-Campbell	Cain-Campbell Systems
293	Gonçalves - ME	Gonçalves - ME Tecnologia
294	Pires da Conceição - ME	Pires da Conceição - ME Works
295	Powell and Sons	Powell and Sons Universal
296	Costela Brito e Filhos	Costela Brito e Filhos Next
297	Peixoto S.A.	Peixoto S.A. Networks
298	Young, Thompson and Santos	Young, Thompson and Santos Assessoria
299	da Rosa Lima e Filhos	da Rosa Lima e Filhos Boutique
300	Diaz, Dennis and Williams	Diaz, Dennis and Williams Hub
301	Williams Inc	Williams Inc Clinic
302	da Conceição S/A	da Conceição S/A Universal
303	Anderson LLC	Anderson LLC Consultoria
304	Araújo Brito e Filhos	Araújo Brito e Filhos Hub
305	Moraes	Moraes Labs
306	Sales e Filhos	Sales e Filhos Varejo
307	Rocha	Rocha Tecnologia
308	Jordan Group	Jordan Group Construções
309	Moon, Carroll and May	Moon, Carroll and May Systems
310	Richardson-Harris	Richardson-Harris Academia
311	Nunes S.A.	Nunes S.A. Creative
312	Pinto S.A.	Pinto S.A. Studio
313	Duncan, Ochoa and Jones	Duncan, Ochoa and Jones Culinária
314	Smith LLC	Smith LLC Construções
315	Aparecida	Aparecida Prime
316	Matthews Inc	Matthews Inc Educação
317	Caldeira e Filhos	Caldeira e Filhos Sustentável
318	Graham and Sons	Graham and Sons Inovação
319	Campos da Mota S.A.	Campos da Mota S.A. Co
320	Gomes	Gomes Universal
321	Nascimento Almeida - ME	Nascimento Almeida - ME Gastronomia
322	Vargas, Acevedo and Miranda	Vargas, Acevedo and Miranda Universal
323	Borges Carvalho - ME	Borges Carvalho - ME Educação
324	Azevedo Montenegro Ltda.	Azevedo Montenegro Ltda. Tech
325	Bryan-Santiago	Bryan-Santiago Worldwide
326	Borges	Borges Imobiliária
327	Ball-Nelson	Ball-Nelson Smart
328	Garcia Ltda.	Garcia Ltda. Grupo
329	Cardoso Carvalho - EI	Cardoso Carvalho - EI Solutions
330	Hanson, Hale and Kramer	Hanson, Hale and Kramer Atelier
331	Gonzales-Pitts	Gonzales-Pitts Smart
332	Lima S.A.	Lima S.A. Prime
333	Lewis, Collins and Woods	Lewis, Collins and Woods Frete
334	Solis, Thomas and Crosby	Solis, Thomas and Crosby Medical
335	Conley-Donaldson	Conley-Donaldson Imobiliária
336	Correia	Correia Comércio
337	Kennedy, Sherman and Green	Kennedy, Sherman and Green Engine
338	Griffin, Diaz and Solis	Griffin, Diaz and Solis Inovação
339	Farias	Farias Gastronomia
340	Rogers, Mccall and Martinez	Rogers, Mccall and Martinez Comércio
341	da Paz da Luz Ltda.	da Paz da Luz Ltda. Smart
342	Cassiano S/A	Cassiano S/A Finanças
343	Wallace Group	Wallace Group Advisors
344	Casa Grande	Casa Grande Services
345	Macedo Novais - EI	Macedo Novais - EI Delícias
346	Ramos da Conceição - ME	Ramos da Conceição - ME Logística
347	Barros S/A	Barros S/A Transportes
348	Araújo	Araújo Partners
349	Moreno-Willis	Moreno-Willis Inteligência
350	Rogers, Coleman and Hubbard	Rogers, Coleman and Hubbard Educação
351	Azevedo S.A.	Azevedo S.A. Solutions
352	Chavez Ltd	Chavez Ltd Treinamento
353	Hunter-Dillon	Hunter-Dillon Grupo
354	Rocha Castro S/A	Rocha Castro S/A Platform
355	Garcia, Kim and Richards	Garcia, Kim and Richards Worldwide
356	Nunez-Berger	Nunez-Berger Medical
357	Thompson-Moore	Thompson-Moore Studio
358	Novaes Alves S/A	Novaes Alves S/A Tecnologia
359	Novais - EI	Novais - EI Inovação
360	Conley LLC	Conley LLC Services
361	Abreu	Abreu Studio
362	Azevedo - ME	Azevedo - ME Inteligência
363	Pastor e Filhos	Pastor e Filhos Assessoria
364	Mosley PLC	Mosley PLC Works
365	Novaes	Novaes Boutique
366	Mcclain-Jones	Mcclain-Jones Logística
367	Novaes S.A.	Novaes S.A. Global
368	Bright-Arnold	Bright-Arnold Treinamento
369	Medina PLC	Medina PLC Worldwide
370	Cain LLC	Cain LLC Works
371	Leão Rocha S.A.	Leão Rocha S.A. Consultoria
372	Lopes Ltda.	Lopes Ltda. Boutique
373	Borges Araújo e Filhos	Borges Araújo e Filhos Culinária
374	Pacheco Porto S/A	Pacheco Porto S/A Treinamento
375	Parker Inc	Parker Inc Serviços
376	Calhoun Ltd	Calhoun Ltd Hub
377	Duke, Johnson and Reeves	Duke, Johnson and Reeves Global
378	Guerra	Guerra Eco
379	White-Brown	White-Brown Finanças
380	Rezende S.A.	Rezende S.A. Logística
381	Lopez Group	Lopez Group Creative
382	Bishop-Leonard	Bishop-Leonard Smart
383	Ford-Maddox	Ford-Maddox Tecnologia
384	Garcia - EI	Garcia - EI Estilo
385	Burgess-Chapman	Burgess-Chapman Tecnologia
386	Pires S.A.	Pires S.A. Varejo
387	Smith-Mccoy	Smith-Mccoy Varejo
388	Hill Group	Hill Group Services
389	Araújo Porto Ltda.	Araújo Porto Ltda. Enterprises
390	Munoz LLC	Munoz LLC Healthcare
391	Melo	Melo Digital
392	Moraes da Luz - EI	Moraes da Luz - EI Solutions
393	Patel, Lee and Stephens	Patel, Lee and Stephens Boutique
394	Moore Ltd	Moore Ltd Inteligência
395	Mcintosh LLC	Mcintosh LLC Studio
396	Nichols LLC	Nichols LLC Services
397	Howell, Martinez and Ball	Howell, Martinez and Ball Solutions
398	Cavalcanti	Cavalcanti Advocacia
399	Aragão	Aragão Tecnologia
400	Peterson-Mack	Peterson-Mack Solutions
401	Brito - ME	Brito - ME Agency
402	Leão Costa - ME	Leão Costa - ME Academia
403	Ruiz Group	Ruiz Group Healthcare
404	Martin, Oliver and Silva	Martin, Oliver and Silva Ambiental
405	Silveira S/A	Silveira S/A Atacado
406	Nascimento	Nascimento Obras
407	Duarte S.A.	Duarte S.A. Frete
408	Dias - ME	Dias - ME Varejo
409	da Costa e Filhos	da Costa e Filhos Design
410	Vargas S.A.	Vargas S.A. Ambiental
411	Rezende Martins - EI	Rezende Martins - EI Private
412	Harrison, Nichols and Hartman	Harrison, Nichols and Hartman Gastronomia
413	Aparecida S/A	Aparecida S/A Healthcare
414	Williams Ltd	Williams Ltd Gastronomia
415	Walker, Hinton and Mcbride	Walker, Hinton and Mcbride Varejo
416	Smith Inc	Smith Inc Sustentável
417	Pimenta	Pimenta Investimentos
418	Silveira	Silveira Labs
419	Griffin, Miller and Curry	Griffin, Miller and Curry Investimentos
420	Mckee-Hunter	Mckee-Hunter Services
421	Ware LLC	Ware LLC Wellness
422	Teixeira	Teixeira International
423	Pinto Farias Ltda.	Pinto Farias Ltda. Imobiliária
424	Johnson Ltd	Johnson Ltd Legal
425	Teixeira e Filhos	Teixeira e Filhos Inteligência
426	Johnson, Webb and Ryan	Johnson, Webb and Ryan Hub
427	Silva da Cruz S/A	Silva da Cruz S/A Atacado
428	Munoz, Carroll and James	Munoz, Carroll and James Investimentos
429	Hamilton and Sons	Hamilton and Sons Enterprises
430	da Mota Ltda.	da Mota Ltda. Healthcare
431	Ellis, Harmon and Rollins	Ellis, Harmon and Rollins Labs
432	Russell LLC	Russell LLC Inteligência
433	Mccullough, Jackson and Clark	Mccullough, Jackson and Clark Networks
434	Cirino Silva S/A	Cirino Silva S/A Atelier
435	Viana Rocha S.A.	Viana Rocha S.A. Hub
436	da Costa Cirino e Filhos	da Costa Cirino e Filhos Frete
437	Viana - ME	Viana - ME Estilo
438	Campos e Filhos	Campos e Filhos Strategies
439	Pereira Fogaça S.A.	Pereira Fogaça S.A. Creative
440	Davis, Cortez and Horn	Davis, Cortez and Horn Eco
441	Lewis-Gonzalez	Lewis-Gonzalez Global
442	James Group	James Group Ambiental
443	Machado - EI	Machado - EI Wellness
444	Carvalho Ltda.	Carvalho Ltda. Formação
445	Miller-Hays	Miller-Hays Edge
446	Johnson-Wright	Johnson-Wright Moda
447	Nunes - ME	Nunes - ME Medical
448	Oliveira Cavalcanti - ME	Oliveira Cavalcanti - ME Empreendimentos
449	Davis-Norris	Davis-Norris Atelier
450	Taylor, Sims and Pham	Taylor, Sims and Pham Ambiental
451	Machado	Machado Clinic
452	Montenegro	Montenegro Investimentos
453	Livingston Inc	Livingston Inc Services
454	Dunlap-Perkins	Dunlap-Perkins Design
455	Harris, Lynn and Caldwell	Harris, Lynn and Caldwell Clinic
456	Novaes S/A	Novaes S/A Frete
457	Albuquerque - EI	Albuquerque - EI Platform
458	Butler-Nelson	Butler-Nelson Sustentável
459	Rocha S.A.	Rocha S.A. International
460	Hall, Garcia and Gutierrez	Hall, Garcia and Gutierrez Smart
461	Johnson, Williams and Quinn	Johnson, Williams and Quinn Factory
462	Dias	Dias Solutions
463	Ramos Peixoto e Filhos	Ramos Peixoto e Filhos Alimentos
464	Andrade LLC	Andrade LLC Transportes
465	Cuevas Inc	Cuevas Inc Construções
466	Meyers, Hess and Villarreal	Meyers, Hess and Villarreal Capital
467	Pereira Ltda.	Pereira Ltda. Verde
468	Fischer PLC	Fischer PLC Operações
469	Dillon-Morrison	Dillon-Morrison Systems
470	da Mata S/A	da Mata S/A Labs
471	Gonzales Group	Gonzales Group Treinamento
472	Castro	Castro Next
473	Viana Cunha S/A	Viana Cunha S/A Comércio
474	Costa S.A.	Costa S.A. Investimentos
475	Cardoso S/A	Cardoso S/A Construções
476	Macedo Moreira e Filhos	Macedo Moreira e Filhos Advocacia
477	Teixeira da Rosa - ME	Teixeira da Rosa - ME Delícias
478	Vasquez and Sons	Vasquez and Sons Medical
479	Pinto Rocha S/A	Pinto Rocha S/A Varejo
480	Viana S.A.	Viana S.A. International
481	Machado - ME	Machado - ME Consulting
482	Campos - EI	Campos - EI Alimentos
483	Martin Inc	Martin Inc Inovação
484	Câmara	Câmara Tech
485	Carey, Elliott and Smith	Carey, Elliott and Smith Atelier
486	Martin, Galvan and Cox	Martin, Galvan and Cox Operações
487	Yates PLC	Yates PLC Worldwide
488	Smith-Simmons	Smith-Simmons Inovação
489	Leão e Filhos	Leão e Filhos Advisors
490	Oliveira da Mota S.A.	Oliveira da Mota S.A. Varejo
491	Castro S/A	Castro S/A Eco
492	Lima S/A	Lima S/A Engine
493	Farias da Cunha S/A	Farias da Cunha S/A Labs
494	Mooney PLC	Mooney PLC Empreendimentos
495	Fonseca Duarte - EI	Fonseca Duarte - EI Studio
496	Vieira - ME	Vieira - ME Private
497	Valentine and Sons	Valentine and Sons Obras
498	Walker Ltd	Walker Ltd Studio
499	Cole Ltd	Cole Ltd Clinic
500	Ribeiro Araújo Ltda.	Ribeiro Araújo Ltda. Prime
501	Farias - EI	Farias - EI Design
502	Smith Ltd	Smith Ltd Studio
503	Martins Pimenta S/A	Martins Pimenta S/A Eco
504	Hawkins-Anderson	Hawkins-Anderson Enterprises
505	Garcia	Garcia Construções
506	Wilson LLC	Wilson LLC Next
507	Gonçalves - EI	Gonçalves - EI Grupo
508	Araújo S.A.	Araújo S.A. Distribuidora
509	Oneal, Maxwell and Ray	Oneal, Maxwell and Ray Hub
510	Pires Fogaça - ME	Pires Fogaça - ME Inovação
511	Vasconcelos	Vasconcelos Grupo
512	Nelson-Dickerson	Nelson-Dickerson Agency
513	Castro, Mccall and Savage	Castro, Mccall and Savage Smart
514	Alexander, White and Phelps	Alexander, White and Phelps Culinária
515	Cirino Cavalcante e Filhos	Cirino Cavalcante e Filhos Estilo
516	Brown Group	Brown Group Delícias
517	Araújo da Cruz S.A.	Araújo da Cruz S.A. Delícias
518	Souza da Rosa - EI	Souza da Rosa - EI Agency
519	Carter Inc	Carter Inc Boutique
520	Nichols-Adams	Nichols-Adams Assessoria
521	Madden Ltd	Madden Ltd Tecnologia
522	Chapman Group	Chapman Group Formação
523	Camargo Rios - ME	Camargo Rios - ME Ambiental
524	Barbosa Ltda.	Barbosa Ltda. Global
525	Oliveira S.A.	Oliveira S.A. Studio
526	Taylor-Anderson	Taylor-Anderson Imobiliária
527	Dias da Cunha - EI	Dias da Cunha - EI Consulting
528	Campos Leão - ME	Campos Leão - ME Smart
529	Harrell and Sons	Harrell and Sons Ambiental
530	Hayes LLC	Hayes LLC Ambiental
531	Cavalcante S/A	Cavalcante S/A Verde
532	Petersen Ltd	Petersen Ltd Gastronomia
533	Oliveira Rocha Ltda.	Oliveira Rocha Ltda. Logística
534	Mendes	Mendes Obras
535	Moura Machado e Filhos	Moura Machado e Filhos Universal
536	Bennett Group	Bennett Group Culinária
537	Pacheco - ME	Pacheco - ME Inovação
538	Moreira Ribeiro - EI	Moreira Ribeiro - EI Soluções
539	Hammond-Gardner	Hammond-Gardner Networks
540	Bryant, Peterson and Hodges	Bryant, Peterson and Hodges Formação
541	Taylor, Green and King	Taylor, Green and King Culinária
542	Miller, Davis and Mays	Miller, Davis and Mays Healthcare
543	Anderson Inc	Anderson Inc Transportes
544	Robbins-Sanchez	Robbins-Sanchez Private
545	Perkins-Carter	Perkins-Carter Solutions
546	Nogueira	Nogueira Verde
547	Carroll, Bonilla and Conley	Carroll, Bonilla and Conley Alimentos
548	Gonçalves Cassiano - ME	Gonçalves Cassiano - ME Platform
549	Duarte	Duarte Smart
550	Gomes Ltda.	Gomes Ltda. Distribuidora
551	Fonseca	Fonseca Services
552	Vang-Ho	Vang-Ho International
553	Brito - EI	Brito - EI Holdings
554	Evans Group	Evans Group Grupo
555	Thompson, Ayers and Cross	Thompson, Ayers and Cross Private
556	Moraes da Mota S/A	Moraes da Mota S/A Moda
557	Dias Pinto S.A.	Dias Pinto S.A. Factory
558	Mullen Ltd	Mullen Ltd Design
559	Thompson-Lopez	Thompson-Lopez Wellness
560	Ferrell-Berry	Ferrell-Berry Assessoria
561	Dickerson, White and Martinez	Dickerson, White and Martinez Smart
562	Stewart and Sons	Stewart and Sons Engine
563	Flores-Payne	Flores-Payne Works
564	Owens Group	Owens Group Solutions
565	Johnson-Kelley	Johnson-Kelley Studio
566	Pires Nascimento - ME	Pires Nascimento - ME Advocacia
567	Alves	Alves Capital
568	Stanley, Mitchell and Morgan	Stanley, Mitchell and Morgan Universal
569	Joseph Group	Joseph Group Consulting
570	Vance and Sons	Vance and Sons Worldwide
571	Santos	Santos Engine
572	Williams, Ellison and Moyer	Williams, Ellison and Moyer Serviços
573	Andrews, Bradley and Coleman	Andrews, Bradley and Coleman Holdings
574	Johnson-Patterson	Johnson-Patterson Grupo
575	Cardenas-Buckley	Cardenas-Buckley Partners
576	Jesus Caldeira e Filhos	Jesus Caldeira e Filhos Jurídico
577	Bailey, Robinson and Sullivan	Bailey, Robinson and Sullivan Atacado
578	Pinto Oliveira S/A	Pinto Oliveira S/A Strategies
579	Acosta, Ali and Miller	Acosta, Ali and Miller Healthcare
580	Martins Porto e Filhos	Martins Porto e Filhos Factory
581	das Neves S.A.	das Neves S.A. Grupo
582	Payne and Sons	Payne and Sons Operações
583	Brooks Ltd	Brooks Ltd Imobiliária
584	Burns and Sons	Burns and Sons Agency
585	Rodriguez-Kim	Rodriguez-Kim Formação
586	Fogaça S.A.	Fogaça S.A. Serviços
587	Steele-Collins	Steele-Collins Partners
588	Cobb, Meyer and Romero	Cobb, Meyer and Romero International
589	Macedo Rodrigues S/A	Macedo Rodrigues S/A Design
590	Alvarez, White and Thompson	Alvarez, White and Thompson Networks
591	Lopes	Lopes Academia
592	Rodrigues Silva e Filhos	Rodrigues Silva e Filhos Assessoria
593	Weaver, Glover and Fisher	Weaver, Glover and Fisher Digital
594	Câmara Ltda.	Câmara Ltda. Worldwide
595	Pastor Almeida e Filhos	Pastor Almeida e Filhos Delícias
596	Harris, Roth and Hill	Harris, Roth and Hill Educação
597	da Cruz - EI	da Cruz - EI Logística
598	Flores-Wallace	Flores-Wallace Healthcare
599	Harding Inc	Harding Inc Design
600	Silveira Mendonça Ltda.	Silveira Mendonça Ltda. Inteligência
601	King Inc	King Inc Empreendimentos
602	Siqueira - EI	Siqueira - EI Delícias
603	Melo Melo S.A.	Melo Melo S.A. Systems
604	da Mata e Filhos	da Mata e Filhos Logística
605	Correia Novais S/A	Correia Novais S/A Creative
606	Vieira Santos - ME	Vieira Santos - ME Solutions
607	Chavez-Thompson	Chavez-Thompson Consulting
608	Rodriguez Ltd	Rodriguez Ltd Solutions
609	Bruce, Webb and Martinez	Bruce, Webb and Martinez Next
610	Fonseca Castro S/A	Fonseca Castro S/A Sustentável
611	Cirino	Cirino Legal
612	Singleton-Mitchell	Singleton-Mitchell Moda
613	Paul-Rivers	Paul-Rivers Holdings
614	Howard-Brock	Howard-Brock Edge
615	Young, Benjamin and Howe	Young, Benjamin and Howe Collective
616	Ray, Harris and Dodson	Ray, Harris and Dodson Inteligência
617	Acosta-Newman	Acosta-Newman Platform
618	Blankenship-Webster	Blankenship-Webster Eco
619	Stewart-Mccall	Stewart-Mccall Agency
620	Stone, Smith and Hall	Stone, Smith and Hall Finanças
621	Nascimento Garcia Ltda.	Nascimento Garcia Ltda. Advisors
622	Gonçalves Cavalcante S.A.	Gonçalves Cavalcante S.A. Networks
623	Câmara Martins e Filhos	Câmara Martins e Filhos Construções
624	Sousa Teixeira e Filhos	Sousa Teixeira e Filhos Jurídico
625	Aragão S/A	Aragão S/A Design
626	Almeida Aragão Ltda.	Almeida Aragão Ltda. Comércio
627	Farias - ME	Farias - ME Culinária
628	da Rosa Pimenta S.A.	da Rosa Pimenta S.A. Inovação
629	Smith, Cooper and Lee	Smith, Cooper and Lee Solutions
630	Lima Freitas - EI	Lima Freitas - EI Next
631	Moraes Monteiro e Filhos	Moraes Monteiro e Filhos Transportes
632	Hall, Harris and Thomas	Hall, Harris and Thomas Boutique
633	Zamora Group	Zamora Group Frete
634	Foster, Pearson and Acosta	Foster, Pearson and Acosta Imobiliária
635	Camacho Inc	Camacho Inc Varejo
636	Alves Farias - ME	Alves Farias - ME Advocacia
637	Hess, Hartman and Rivera	Hess, Hartman and Rivera Frete
638	Brown-Grant	Brown-Grant Tecnologia
639	Vieira Ltda.	Vieira Ltda. Legal
640	Ramirez, Freeman and Guzman	Ramirez, Freeman and Guzman Wellness
641	Stewart-Barrett	Stewart-Barrett Treinamento
642	Pastor Ltda.	Pastor Ltda. Frete
643	Fox PLC	Fox PLC Tecnologia
644	Blake, Sandoval and Green	Blake, Sandoval and Green Works
645	Evans PLC	Evans PLC Atelier
646	Lima Dias S.A.	Lima Dias S.A. Legal
647	Hamilton, Williams and Mendoza	Hamilton, Williams and Mendoza Engine
648	Pena Inc	Pena Inc Works
649	Maynard-Ortiz	Maynard-Ortiz Labs
650	Welch, Perkins and Roberts	Welch, Perkins and Roberts Advocacia
651	da Cruz	da Cruz Strategies
652	Oliveira e Filhos	Oliveira e Filhos Solutions
653	Vieira Fonseca S/A	Vieira Fonseca S/A Empreendimentos
654	Abreu Oliveira e Filhos	Abreu Oliveira e Filhos Edge
655	Strong-Campbell	Strong-Campbell Boutique
656	Johnson, Carpenter and Mcdonald	Johnson, Carpenter and Mcdonald Obras
657	da Rocha da Cruz - ME	da Rocha da Cruz - ME Prime
658	Anderson PLC	Anderson PLC Alimentos
659	das Neves	das Neves Design
660	Navarro LLC	Navarro LLC Finanças
661	Moran, Baxter and Simmons	Moran, Baxter and Simmons Clinic
662	Alves da Mata e Filhos	Alves da Mata e Filhos Formação
663	da Paz	da Paz Sustentável
664	Conway-Jacobs	Conway-Jacobs Engine
665	Borges e Filhos	Borges e Filhos Sustentável
666	Ribeiro Pacheco Ltda.	Ribeiro Pacheco Ltda. Investimentos
667	Manning-Vega	Manning-Vega Inteligência
668	Sousa S.A.	Sousa S.A. Academia
669	Powers-Ray	Powers-Ray Design
670	Costa Cavalcanti - ME	Costa Cavalcanti - ME Smart
671	da Rosa Ramos S/A	da Rosa Ramos S/A International
672	Robinson, James and Espinoza	Robinson, James and Espinoza Varejo
673	Vieira da Rocha S/A	Vieira da Rocha S/A Consultoria
674	Wolfe Inc	Wolfe Inc Global
675	Fogaça Ltda.	Fogaça Ltda. Works
676	Green, Thompson and Cortez	Green, Thompson and Cortez Transportes
677	Rios da Mota S/A	Rios da Mota S/A Strategies
678	Ribeiro e Filhos	Ribeiro e Filhos Creative
679	Gomes Ribeiro S/A	Gomes Ribeiro S/A Hub
680	Mendonça Viana e Filhos	Mendonça Viana e Filhos Transportes
681	Garcia, Miller and Chang	Garcia, Miller and Chang Inteligência
682	Browning LLC	Browning LLC Services
683	Souza - EI	Souza - EI Comércio
684	Vasquez-Hart	Vasquez-Hart Inteligência
685	Siqueira Pires Ltda.	Siqueira Pires Ltda. Solutions
686	Nogueira e Filhos	Nogueira e Filhos Atacado
687	Carlson, Cortez and Rivera	Carlson, Cortez and Rivera Atelier
688	Ward-Golden	Ward-Golden Treinamento
689	Hughes Inc	Hughes Inc Digital
690	Anderson Group	Anderson Group Academia
691	Peixoto Siqueira - ME	Peixoto Siqueira - ME Next
692	Nogueira Costa S/A	Nogueira Costa S/A Tecnologia
693	Cassiano Lima Ltda.	Cassiano Lima Ltda. Global
694	Pacheco	Pacheco Frete
695	Parrish-Adkins	Parrish-Adkins Moda
696	Johnson LLC	Johnson LLC Design
697	Almeida e Filhos	Almeida e Filhos Gastronomia
698	Castro-Mitchell	Castro-Mitchell Networks
699	Garcia, Ellison and Crawford	Garcia, Ellison and Crawford Smart
700	Montenegro Lopes - ME	Montenegro Lopes - ME Co
701	Farias Rodrigues S.A.	Farias Rodrigues S.A. Prime
702	Bradley, Hamilton and Conner	Bradley, Hamilton and Conner Smart
703	Johnson Inc	Johnson Inc Construções
704	Sanders, Thompson and Harris	Sanders, Thompson and Harris Distribuidora
705	Siqueira Borges Ltda.	Siqueira Borges Ltda. Universal
706	Ramirez-Hahn	Ramirez-Hahn Delícias
707	Ferreira e Filhos	Ferreira e Filhos Private
708	Hunter-Juarez	Hunter-Juarez Solutions
709	Murphy Inc	Murphy Inc Studio
710	Gomes - ME	Gomes - ME Alimentos
711	Fonseca e Filhos	Fonseca e Filhos Studio
712	Caldeira	Caldeira Prime
713	da Cruz Pacheco - ME	da Cruz Pacheco - ME Networks
714	Nascimento Ltda.	Nascimento Ltda. Worldwide
715	Correia Montenegro S/A	Correia Montenegro S/A Wellness
716	Correia e Filhos	Correia e Filhos Legal
717	Tucker, Caldwell and Gonzalez	Tucker, Caldwell and Gonzalez Networks
718	Olson-Thomas	Olson-Thomas Agency
719	Moraes - ME	Moraes - ME Advisors
720	Novaes - ME	Novaes - ME Global
721	Novaes Mendes S/A	Novaes Mendes S/A Logística
722	Jenkins Inc	Jenkins Inc Distribuidora
723	Souza das Neves S.A.	Souza das Neves S.A. Finanças
724	Sá e Filhos	Sá e Filhos Logística
725	Caldeira Ferreira Ltda.	Caldeira Ferreira Ltda. Medical
726	Mendes Ltda.	Mendes Ltda. Frete
727	da Mata - EI	da Mata - EI Collective
728	Hunt-Lewis	Hunt-Lewis Sustentável
729	Norris-Campbell	Norris-Campbell Operações
730	Nunes e Filhos	Nunes e Filhos Healthcare
731	Cohen-Gordon	Cohen-Gordon Co
732	Clark Ltd	Clark Ltd Tecnologia
733	Curry Inc	Curry Inc Academia
734	Franklin, Cooper and Scott	Franklin, Cooper and Scott Delícias
735	Cook-Rodriguez	Cook-Rodriguez Healthcare
736	Duarte - ME	Duarte - ME Atacado
737	Henderson-Anderson	Henderson-Anderson Partners
738	Vasconcelos S.A.	Vasconcelos S.A. Frete
739	Abreu Sales - ME	Abreu Sales - ME Factory
740	Moura S/A	Moura S/A Collective
741	Stokes-Oliver	Stokes-Oliver Advisors
742	Parker-Ingram	Parker-Ingram Tech
743	Lopes Casa Grande S/A	Lopes Casa Grande S/A Varejo
744	Vieira Andrade e Filhos	Vieira Andrade e Filhos Tech
745	Mcintyre and Sons	Mcintyre and Sons Verde
746	Aparecida - EI	Aparecida - EI Solutions
747	Levine-Love	Levine-Love Atacado
748	Gonzalez-Mccormick	Gonzalez-Mccormick Culinária
749	Gonçalves	Gonçalves Verde
750	Nogueira Oliveira - ME	Nogueira Oliveira - ME Tech
751	Vasconcelos - ME	Vasconcelos - ME Engine
752	Bradley Inc	Bradley Inc Serviços
753	Richardson and Sons	Richardson and Sons Atacado
754	Benton Inc	Benton Inc Engine
755	Copeland, Jones and Sims	Copeland, Jones and Sims Partners
756	King, Holmes and Yoder	King, Holmes and Yoder Edge
757	Wiley, Hunt and Sandoval	Wiley, Hunt and Sandoval Wellness
758	Cruz, Dominguez and Johnson	Cruz, Dominguez and Johnson Sustentável
759	Borges Pimenta Ltda.	Borges Pimenta Ltda. Edge
760	Fonseca - ME	Fonseca - ME Labs
761	Phillips, Robertson and Rodriguez	Phillips, Robertson and Rodriguez Jurídico
762	Sousa - ME	Sousa - ME Creative
763	Williamson, Lopez and Rangel	Williamson, Lopez and Rangel Atacado
764	Marques - ME	Marques - ME Comércio
765	Machado da Rocha S/A	Machado da Rocha S/A Imobiliária
766	Santos Lopes e Filhos	Santos Lopes e Filhos Comércio
767	Aguirre, Kim and Davila	Aguirre, Kim and Davila Edge
768	Souza e Filhos	Souza e Filhos Creative
769	Cardoso da Rocha S/A	Cardoso da Rocha S/A Frete
770	Bennett-Sanchez	Bennett-Sanchez Atelier
771	Porto Leão S.A.	Porto Leão S.A. Worldwide
772	Turner, Harris and Hardy	Turner, Harris and Hardy Estilo
773	Porto Ltda.	Porto Ltda. Studio
774	da Paz Rodrigues S.A.	da Paz Rodrigues S.A. Operações
775	Hall, Ibarra and Smith	Hall, Ibarra and Smith Creative
776	Glover, Allen and Woods	Glover, Allen and Woods Platform
777	Brito	Brito Moda
778	Guerra S/A	Guerra S/A Inovação
779	Andrade - ME	Andrade - ME Solutions
780	Melton Ltd	Melton Ltd Studio
781	Camargo e Filhos	Camargo e Filhos Tecnologia
782	da Cruz Borges S/A	da Cruz Borges S/A Operações
783	Siqueira Cirino S/A	Siqueira Cirino S/A Operações
784	Machado Ltda.	Machado Ltda. Delícias
785	Boyd-Allen	Boyd-Allen Networks
786	Dias S.A.	Dias S.A. Enterprises
787	Siqueira Moreira S.A.	Siqueira Moreira S.A. Inteligência
788	Brito e Filhos	Brito e Filhos Prime
789	Smith-Norris	Smith-Norris Works
790	da Mata Cardoso - ME	da Mata Cardoso - ME Inovação
791	da Rocha Lopes - EI	da Rocha Lopes - EI Academia
792	Marques Rodrigues S/A	Marques Rodrigues S/A Treinamento
793	Peixoto Ltda.	Peixoto Ltda. Clinic
794	Harris, Dudley and Freeman	Harris, Dudley and Freeman Worldwide
795	da Costa - ME	da Costa - ME Services
796	Avila-Jones	Avila-Jones Tecnologia
797	Frazier-Sullivan	Frazier-Sullivan Tecnologia
798	Lopez-Barrett	Lopez-Barrett Collective
799	Baker Inc	Baker Inc Clinic
800	Garcia Moreira S.A.	Garcia Moreira S.A. Universal
801	Rocha Marques Ltda.	Rocha Marques Ltda. Construções
802	Mayer, Banks and Sellers	Mayer, Banks and Sellers Boutique
803	Johnston-Dixon	Johnston-Dixon Systems
804	Walker PLC	Walker PLC Worldwide
805	Sanders PLC	Sanders PLC Works
806	Fuller-Reyes	Fuller-Reyes Obras
807	Miller, Burns and Marshall	Miller, Burns and Marshall Advocacia
808	das Neves - ME	das Neves - ME Operações
809	Jesus - ME	Jesus - ME Varejo
810	Camargo S.A.	Camargo S.A. Design
811	Rodrigues	Rodrigues Hub
812	Fleming and Sons	Fleming and Sons Advocacia
813	Freitas S/A	Freitas S/A Factory
814	Marques e Filhos	Marques e Filhos Consulting
815	Sampaio - EI	Sampaio - EI Grupo
816	Wilcox Ltd	Wilcox Ltd Investimentos
817	Montenegro Farias - EI	Montenegro Farias - EI International
818	Moreira Fernandes S/A	Moreira Fernandes S/A Construções
819	da Cunha Rocha S/A	da Cunha Rocha S/A Tech
820	Taylor-Parker	Taylor-Parker Assessoria
821	Walsh, Garcia and Miller	Walsh, Garcia and Miller Legal
822	Watson Inc	Watson Inc Next
823	Padilla-Preston	Padilla-Preston Worldwide
824	Vazquez and Sons	Vazquez and Sons Next
825	Moura - ME	Moura - ME Studio
826	Teixeira Nascimento - EI	Teixeira Nascimento - EI Consultoria
827	Cassiano Moura Ltda.	Cassiano Moura Ltda. Partners
828	Gomes Campos S.A.	Gomes Campos S.A. Platform
829	Duran-Jordan	Duran-Jordan Obras
830	Morales, Cox and Russell	Morales, Cox and Russell Private
831	Bullock-Whitehead	Bullock-Whitehead Consulting
832	Page and Sons	Page and Sons Soluções
833	Hicks Group	Hicks Group Solutions
834	Murray, Rodriguez and Lee	Murray, Rodriguez and Lee Consultoria
835	Casa Grande S.A.	Casa Grande S.A. Creative
836	Smith-Mitchell	Smith-Mitchell Soluções
837	Barbosa Castro Ltda.	Barbosa Castro Ltda. Design
838	Brito Andrade - ME	Brito Andrade - ME Formação
839	Novaes Sales e Filhos	Novaes Sales e Filhos Wellness
840	da Rocha Vasconcelos - ME	da Rocha Vasconcelos - ME Varejo
841	Vasconcelos Nogueira Ltda.	Vasconcelos Nogueira Ltda. Treinamento
842	Machado Correia Ltda.	Machado Correia Ltda. Alimentos
843	Trevino, Rivera and Contreras	Trevino, Rivera and Contreras Treinamento
844	Camacho-Valdez	Camacho-Valdez Digital
845	Weaver, Gill and Johnson	Weaver, Gill and Johnson Healthcare
846	Dias Ltda.	Dias Ltda. Smart
847	Rezende	Rezende Inteligência
848	Miller-Mccarty	Miller-Mccarty Holdings
849	Cavalcante da Rocha S/A	Cavalcante da Rocha S/A Distribuidora
850	da Mota - EI	da Mota - EI Logística
851	Gray, Long and Snyder	Gray, Long and Snyder Educação
852	Pires Gonçalves Ltda.	Pires Gonçalves Ltda. Creative
853	Newman-Hall	Newman-Hall Investimentos
854	Green LLC	Green LLC Private
855	Harris-Lee	Harris-Lee Treinamento
856	Moore-Vasquez	Moore-Vasquez Enterprises
857	Peixoto Rios - EI	Peixoto Rios - EI Assessoria
858	Johnson, Thompson and Floyd	Johnson, Thompson and Floyd Delícias
859	Crawford LLC	Crawford LLC Moda
860	Weaver Inc	Weaver Inc Worldwide
861	Thomas, Black and Lee	Thomas, Black and Lee Educação
862	Price, Hartman and Ferguson	Price, Hartman and Ferguson Atacado
863	Almeida da Cruz S/A	Almeida da Cruz S/A Soluções
864	Hawkins-Holt	Hawkins-Holt Legal
865	Johnson-Woods	Johnson-Woods Alimentos
866	da Cruz - ME	da Cruz - ME Next
867	Lewis-Moss	Lewis-Moss Works
868	Brooks-Smith	Brooks-Smith Solutions
869	Wilson, Barnes and Hill	Wilson, Barnes and Hill Systems
870	Cook Inc	Cook Inc Edge
871	Russell, Walker and Johnston	Russell, Walker and Johnston Advocacia
872	Hale, Young and Martin	Hale, Young and Martin Atelier
873	Cunha Jesus Ltda.	Cunha Jesus Ltda. Operações
874	Jones, Haynes and Jones	Jones, Haynes and Jones Digital
875	Contreras-Stevens	Contreras-Stevens Tecnologia
876	Sheppard, Olson and Crawford	Sheppard, Olson and Crawford Global
877	Moreira Cardoso - EI	Moreira Cardoso - EI Boutique
878	Romero Group	Romero Group Smart
879	Albuquerque da Costa S.A.	Albuquerque da Costa S.A. Medical
880	Crane PLC	Crane PLC Obras
881	Lopez-Mejia	Lopez-Mejia Atacado
882	Almeida S/A	Almeida S/A Soluções
883	Park, Singleton and Barrett	Park, Singleton and Barrett Verde
884	Pereira S.A.	Pereira S.A. Studio
885	Gaines, Yang and Casey	Gaines, Yang and Casey Co
886	Higgins-Holloway	Higgins-Holloway Clinic
887	Mendonça Pacheco S/A	Mendonça Pacheco S/A Estilo
888	Cardoso Gomes - ME	Cardoso Gomes - ME Investimentos
889	Pimenta Brito e Filhos	Pimenta Brito e Filhos Delícias
890	Brown, Kennedy and Hardy	Brown, Kennedy and Hardy Systems
891	Navarro, Ortega and Roberts	Navarro, Ortega and Roberts Construções
892	Rocha Pires - ME	Rocha Pires - ME Transportes
893	Pinto Pimenta S/A	Pinto Pimenta S/A Tech
894	Martinez-Mitchell	Martinez-Mitchell Hub
895	Reed, Morgan and Perez	Reed, Morgan and Perez Verde
896	Jones, Fletcher and Garcia	Jones, Fletcher and Garcia Partners
897	da Cunha - EI	da Cunha - EI Consultoria
898	Aragão Ltda.	Aragão Ltda. Gastronomia
899	Ryan, Ross and Jones	Ryan, Ross and Jones Healthcare
900	Pacheco S/A	Pacheco S/A Systems
901	Silva Moraes S.A.	Silva Moraes S.A. Atelier
902	Leão - EI	Leão - EI Capital
903	Gonçalves Cavalcanti S.A.	Gonçalves Cavalcanti S.A. Grupo
904	Ferguson Inc	Ferguson Inc Academia
905	Jarvis-Nelson	Jarvis-Nelson Agency
906	Downs Inc	Downs Inc Consultoria
907	Harvey, Butler and Campbell	Harvey, Butler and Campbell Educação
908	Schmidt, Larson and Stewart	Schmidt, Larson and Stewart Creative
909	Baxter-Vargas	Baxter-Vargas Grupo
910	Moura - EI	Moura - EI Legal
911	Guerra Moura Ltda.	Guerra Moura Ltda. Platform
912	Reynolds, Kramer and Zimmerman	Reynolds, Kramer and Zimmerman Healthcare
913	Sampaio Moreira Ltda.	Sampaio Moreira Ltda. Academia
914	Garcia da Cruz - ME	Garcia da Cruz - ME Creative
915	Barr, Mendez and Shepherd	Barr, Mendez and Shepherd Solutions
916	da Paz S.A.	da Paz S.A. Labs
917	Martin-Thompson	Martin-Thompson Co
918	Nascimento e Filhos	Nascimento e Filhos Empreendimentos
919	Martins S/A	Martins S/A Digital
920	Watts, Duncan and Martinez	Watts, Duncan and Martinez Investimentos
921	da Mota Novaes e Filhos	da Mota Novaes e Filhos Verde
922	Almeida S.A.	Almeida S.A. Private
923	Cole PLC	Cole PLC Grupo
924	Lopes Albuquerque e Filhos	Lopes Albuquerque e Filhos Enterprises
925	Moreira Viana e Filhos	Moreira Viana e Filhos Assessoria
926	Albuquerque S/A	Albuquerque S/A Culinária
927	Casa Grande Ltda.	Casa Grande Ltda. Prime
928	Douglas, Watson and Harris	Douglas, Watson and Harris Ambiental
929	Rios Moura Ltda.	Rios Moura Ltda. Holdings
930	da Cunha Andrade e Filhos	da Cunha Andrade e Filhos Investimentos
931	Gomes Nascimento - EI	Gomes Nascimento - EI Design
932	Peixoto e Filhos	Peixoto e Filhos Digital
933	Espinoza and Sons	Espinoza and Sons Clinic
934	Santana, Ayers and Sloan	Santana, Ayers and Sloan Grupo
935	Leão Cassiano Ltda.	Leão Cassiano Ltda. Networks
936	Lima Cirino - ME	Lima Cirino - ME Global
937	Barbosa Vargas S/A	Barbosa Vargas S/A Studio
938	Souza	Souza Logística
939	Golden Inc	Golden Inc Global
940	Silveira Silva - EI	Silveira Silva - EI Smart
941	Melo Viana S.A.	Melo Viana S.A. International
942	Melo - ME	Melo - ME Estilo
943	Rios Sá e Filhos	Rios Sá e Filhos Holdings
944	Ramos S/A	Ramos S/A Works
945	Barber-Ferguson	Barber-Ferguson Consulting
946	Marques Barbosa - EI	Marques Barbosa - EI Networks
947	Luna-Moore	Luna-Moore Ambiental
948	Lima Vieira - EI	Lima Vieira - EI Inovação
949	Casa Grande Machado S.A.	Casa Grande Machado S.A. Worldwide
950	Mccarthy, Peters and Smith	Mccarthy, Peters and Smith Educação
951	Cassiano Santos - EI	Cassiano Santos - EI Estilo
952	Silveira Moura - ME	Silveira Moura - ME Co
953	Vasconcelos - EI	Vasconcelos - EI Construções
954	Barbosa Cunha S/A	Barbosa Cunha S/A Platform
955	Aragão Cavalcante - ME	Aragão Cavalcante - ME Alimentos
956	Castro e Filhos	Castro e Filhos Ambiental
957	Wilson, Johnston and Sherman	Wilson, Johnston and Sherman Co
958	Barry-Rosales	Barry-Rosales Consultoria
959	Teixeira Sá - ME	Teixeira Sá - ME Gastronomia
960	Potter LLC	Potter LLC Comércio
961	Cunha - EI	Cunha - EI Universal
962	Guerra S.A.	Guerra S.A. Tech
963	Hall, Pena and Lee	Hall, Pena and Lee Design
964	Cline, Dixon and Lewis	Cline, Dixon and Lewis Jurídico
965	Camargo - ME	Camargo - ME Inovação
966	Flores LLC	Flores LLC Comércio
967	Guerrero, Nelson and Sanders	Guerrero, Nelson and Sanders Frete
968	Johnston-Lane	Johnston-Lane Global
969	Cavalcanti Ltda.	Cavalcanti Ltda. Alimentos
970	Brown Ltd	Brown Ltd Legal
971	Macedo Nascimento S.A.	Macedo Nascimento S.A. Wellness
972	Sousa Martins Ltda.	Sousa Martins Ltda. Wellness
973	Marques Ferreira e Filhos	Marques Ferreira e Filhos Worldwide
974	Rodgers, Evans and Lowe	Rodgers, Evans and Lowe Services
975	da Cruz Ltda.	da Cruz Ltda. Consultoria
976	Siqueira S.A.	Siqueira S.A. Universal
977	Davila-Lee	Davila-Lee Platform
978	Reynolds Group	Reynolds Group Enterprises
979	Dias Borges e Filhos	Dias Borges e Filhos Advisors
980	Scott-Dunn	Scott-Dunn Boutique
981	Hull Group	Hull Group Holdings
982	Pearson, Richardson and Leonard	Pearson, Richardson and Leonard Strategies
983	da Paz e Filhos	da Paz e Filhos Studio
984	Moody, Allen and Booth	Moody, Allen and Booth Varejo
985	Harris Inc	Harris Inc Frete
986	Andrews, Palmer and Perez	Andrews, Palmer and Perez Soluções
987	Barros	Barros Systems
988	Cooper, Graham and White	Cooper, Graham and White Systems
989	da Mota S.A.	da Mota S.A. Tech
990	Pereira - EI	Pereira - EI Co
991	Monteiro S/A	Monteiro S/A Strategies
992	Johns, Mcintyre and Miller	Johns, Mcintyre and Miller Next
993	Cirino - EI	Cirino - EI Labs
994	Rodriguez and Sons	Rodriguez and Sons Soluções
995	Leão Caldeira S/A	Leão Caldeira S/A Construções
996	Cain-Cole	Cain-Cole International
997	Pimenta S.A.	Pimenta S.A. Assessoria
998	Costa Rocha S.A.	Costa Rocha S.A. Services
999	Borges - ME	Borges - ME Solutions
1000	Hardy, Watson and Landry	Hardy, Watson and Landry Obras
\.


--
-- TOC entry 5252 (class 0 OID 16498)
-- Dependencies: 237
-- Data for Name: empresa_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa_pais (nro_empresa, id_nacional, nome_pais) FROM stdin;
870	COL-401858068	Colombia
272	VIE-176116927	Vietnam
48	SOM-355096984	Somalia
890	ETH-225903465	Ethiopia
578	HON-327957297	Hong Kong
53	NIU-985518475	Niue
891	ESW-324555907	Eswatini
283	BUL-929114132	Bulgaria
473	MAD-650272517	Madagascar
364	LIB-116638306	Liberia
126	BAH-052692670	Bahrain
966	PAL-170049046	Palestine
472	WES-937583392	Western Sahara
635	ISR-407595620	Israel
27	MOR-419011727	Morocco
300	KAZ-872247388	Kazakhstan
625	ETH-347232440	Ethiopia
20	MAD-295106078	Madagascar
752	BAH-074837211	Bosnia and Herzegovina
72	UAE-967926702	United Arab Emirates
706	HON-767840466	Honduras
49	RUS-240908678	Russia
659	MOL-772278896	Moldova
293	NIG-761834723	Nigeria
287	ERI-281800166	Eritrea
793	CAR-539063637	Central African Republic
609	LIE-016463476	Liechtenstein
549	SOU-327677527	South Korea
783	KYR-889878502	Kyrgyzstan
617	BAH-941587919	Bosnia and Herzegovina
125	UAE-666855476	United Arab Emirates
667	NOR-797429535	Norway
580	PAL-006281145	Palestine
934	WES-781655544	Western Sahara
795	UKR-935944333	Ukraine
249	DR -312988842	DR Congo
590	POL-096320930	Poland
30	YEM-953529892	Yemen
149	BAH-279497549	Bahrain
339	UZB-096178407	Uzbekistan
541	IRA-784664772	Iran
646	RUS-647388582	Russia
537	UAE-305675989	United Arab Emirates
371	DOM-454991733	Dominican Republic
569	VAN-212147998	Vanuatu
567	CUB-622407124	Cuba
580	OMA-937544328	Oman
491	BOL-019819467	Bolivia
908	VIE-314745221	Vietnam
579	ZAM-478353455	Zambia
73	NOR-599139708	North Korea
896	GEO-736263099	Georgia
452	NOR-691433830	North Korea
419	VIE-505215816	Vietnam
786	MOL-348947473	Moldova
784	LIE-503125315	Liechtenstein
216	MAL-746185088	Malawi
607	UGA-679171982	Uganda
133	PAL-964727053	Palestine
617	LIB-822280833	Liberia
896	GHA-239460760	Ghana
224	MEX-899973591	Mexico
6	BAH-389971152	Bosnia and Herzegovina
104	SER-435339494	Serbia
883	NIC-578867221	Nicaragua
757	SAI-270857782	Saint Helena, Ascension and Tristan da Cunha
814	ARG-328252025	Argentina
622	PUE-594183143	Puerto Rico
208	SIN-773666688	Singapore
874	MAL-611147775	Maldives
827	IVO-288767936	Ivory Coast
980	SAI-667062791	Saint Lucia
147	BAH-122522714	Bosnia and Herzegovina
411	CUB-367073199	Cuba
965	SWE-670798902	Sweden
962	BER-959863351	Bermuda
718	TUR-023380937	Turkey
514	ERI-115473089	Eritrea
800	SUR-654365492	Suriname
955	BUR-911701584	Burundi
464	CAR-610116483	Central African Republic
708	KAZ-514607461	Kazakhstan
838	MAL-799141831	Maldives
733	BAH-406910111	Bahamas
906	UAE-307431230	United Arab Emirates
640	BRU-535962264	Brunei
685	IND-456067705	Indonesia
965	MAL-833709012	Maldives
36	KYR-230442081	Kyrgyzstan
451	PAR-512879582	Paraguay
243	NAM-453390501	Namibia
71	GUI-688121222	Guinea
840	LAO-043615437	Laos
129	IVO-145001240	Ivory Coast
618	SAU-603391614	Saudi Arabia
672	NIU-400771680	Niue
719	IRA-645590092	Iran
224	ZAM-969221919	Zambia
193	UGA-579516545	Uganda
713	KYR-172747933	Kyrgyzstan
216	PER-977751560	Peru
585	TUR-424404245	Turkey
907	MAL-881067403	Maldives
844	ESW-445214045	Eswatini
675	RUS-886977162	Russia
600	BOL-232358837	Bolivia
730	KAZ-661265955	Kazakhstan
78	PAK-408783857	Pakistan
385	IRA-451146835	Iran
366	POL-681124765	Poland
167	SER-755348731	Serbia
393	CAR-247636613	Central African Republic
361	SAI-295557578	Saint Lucia
638	PHI-668201075	Philippines
888	BEL-978368037	Belize
520	FAL-384953456	Falkland Islands
629	SEY-729570260	Seychelles
933	LES-124692282	Lesotho
950	PAK-710717988	Pakistan
792	SAM-858499532	Samoa
170	TAT-016046966	Trinidad and Tobago
126	PAL-147478284	Palestine
770	UZB-956219099	Uzbekistan
174	WES-386261995	Western Sahara
942	UAE-892136003	United Arab Emirates
772	KAZ-395880566	Kazakhstan
992	SAI-897492060	Saint Helena, Ascension and Tristan da Cunha
142	SOU-902108344	South Africa
396	ARM-318742772	Armenia
822	SOU-695201893	South Africa
971	ERI-656317700	Eritrea
944	NOR-874386078	North Korea
626	PAK-801467069	Pakistan
598	ARM-491802037	Armenia
657	ISR-496868136	Israel
691	PAL-771841950	Palestine
357	HON-197381495	Honduras
126	RUS-183874480	Russia
14	NOR-723610674	Norway
566	NOR-786605874	Norway
34	YEM-566029467	Yemen
785	ALB-018040899	Albania
274	DOM-246493335	Dominican Republic
704	OMA-845126291	Oman
343	VIE-611222729	Vietnam
517	WAF-400334401	Wallis and Futuna
345	PAR-545522163	Paraguay
340	CUR-561212610	Curaçao
238	SUR-307368225	Suriname
282	NAM-691319300	Namibia
355	VIE-899738852	Vietnam
483	CAN-758393186	Canada
577	HAI-084176848	Haiti
91	ROM-427442027	Romania
45	CAY-059292839	Cayman Islands
782	BOT-417904895	Botswana
996	TAN-207076662	Tanzania
72	BOT-454244945	Botswana
179	CAR-471549849	Central African Republic
841	MAD-202627465	Madagascar
515	MON-797305993	Mongolia
795	BOT-647820839	Botswana
902	SRI-066997450	Sri Lanka
903	UAE-785540044	United Arab Emirates
853	BEL-217311230	Belize
95	OMA-304910470	Oman
876	WES-998803653	Western Sahara
518	SAU-528749011	Saudi Arabia
992	LIB-272984012	Liberia
629	CAP-060730042	Cape Verde
597	MYA-827698925	Myanmar
784	BRU-084533148	Brunei
207	GAM-232094024	Gambia
943	HON-975112283	Hong Kong
737	TUR-326585962	Turkey
713	HUN-402665103	Hungary
489	SAI-277658808	Saint Helena, Ascension and Tristan da Cunha
11	BAH-209584429	Bahamas
387	TAT-088102578	Trinidad and Tobago
807	UGA-747450370	Uganda
72	KIR-544521996	Kiribati
925	TUR-467330065	Turkmenistan
878	TAT-052362644	Trinidad and Tobago
952	ESW-981389002	Eswatini
504	BUL-396555410	Bulgaria
102	NIC-978503089	Nicaragua
55	ROM-416106226	Romania
337	MOR-340958293	Morocco
548	NOR-621699798	Norway
568	SAI-617021389	Saint Lucia
405	NIU-955402331	Niue
441	AND-598752583	Andorra
766	NAM-849619371	Namibia
241	KYR-961150405	Kyrgyzstan
610	OMA-351004884	Oman
902	BUR-027398197	Burundi
506	RUS-466829513	Russia
195	SEY-954797886	Seychelles
38	CUR-020550603	Curaçao
108	MAL-041267149	Malaysia
48	BAN-176577520	Bangladesh
706	SYR-010447436	Syria
136	ROM-513747860	Romania
499	ERI-440757489	Eritrea
857	THA-555374437	Thailand
887	CAM-013404340	Cambodia
713	BER-035541056	Bermuda
992	BEL-633720752	Belize
422	COM-043458605	Comoros
140	BAH-087444275	Bahrain
443	SRI-040283437	Sri Lanka
739	ARU-494163908	Aruba
200	ROM-926152032	Romania
438	SRI-862333165	Sri Lanka
440	DOM-433837331	Dominican Republic
434	TUR-063866065	Turkey
946	TUN-935665239	Tunisia
553	CUB-958507872	Cuba
520	BER-375204950	Bermuda
595	JAM-921907943	Jamaica
505	WES-887431421	Western Sahara
631	SUR-108396222	Suriname
791	BAH-999353677	Bahrain
566	PUE-403313187	Puerto Rico
783	LES-960465471	Lesotho
731	CHI-689193037	China
182	ESW-265974037	Eswatini
669	TAN-151441843	Tanzania
444	COM-171572000	Comoros
659	GIB-791923702	Gibraltar
736	BAH-632628967	Bahrain
753	PAL-967193009	Palestine
558	POL-680667531	Poland
386	BUR-734465854	Burundi
631	NIG-835661528	Nigeria
59	GUA-743087362	Guatemala
812	CUB-046735733	Cuba
112	IND-288218476	India
752	MAL-936750672	Maldives
929	LIE-470873188	Liechtenstein
425	WAF-431325486	Wallis and Futuna
411	SIN-519652605	Singapore
320	SIN-653487420	Singapore
921	DOM-480196902	Dominican Republic
855	MAL-214418760	Maldives
465	MAD-048609483	Madagascar
565	TUR-548670826	Turkmenistan
964	UAE-832708709	United Arab Emirates
151	JOR-503397781	Jordan
417	CHI-405037555	China
24	THA-131650666	Thailand
468	CAM-989069439	Cambodia
71	VAN-938100495	Vanuatu
456	VIE-216284602	Vietnam
389	TUN-349086043	Tunisia
135	ARG-234619319	Argentina
188	MEX-881885750	Mexico
513	BOL-694358752	Bolivia
373	CAY-304284649	Cayman Islands
599	BEL-519671307	Belize
920	HON-593700608	Hong Kong
914	POL-706621673	Poland
704	AND-666124629	Andorra
185	KEN-863233925	Kenya
26	SIN-021845329	Singapore
785	MAL-861661578	Malaysia
266	SER-873766228	Serbia
737	HON-606885707	Honduras
104	CZE-340021992	Czechia
395	VIE-999403710	Vietnam
335	BRU-038305021	Brunei
227	SOU-425341647	South Africa
6	SUD-866652031	Sudan
557	BAH-886015447	Bahamas
770	GEO-445649739	Georgia
631	MAC-164104244	Macau
814	BOL-645970013	Bolivia
315	CZE-977644287	Czechia
380	CAY-989132088	Cayman Islands
717	ARM-581416447	Armenia
114	DJI-086718304	Djibouti
546	BER-355583643	Bermuda
197	GIB-250594450	Gibraltar
446	COS-924567217	Costa Rica
160	CAY-956560758	Cayman Islands
455	UKR-873172294	Ukraine
461	GIB-742681447	Gibraltar
484	PAL-697095919	Palestine
301	TUR-406131218	Turkey
626	BAH-707361729	Bahrain
271	POL-330749261	Poland
552	UKR-249735481	Ukraine
48	SAI-845265750	Saint Helena, Ascension and Tristan da Cunha
67	HUN-844706372	Hungary
467	DR -992750877	DR Congo
361	MAD-343039517	Madagascar
565	UKR-787234243	Ukraine
199	ARU-248359521	Aruba
286	ICE-896504012	Iceland
481	TAJ-204834799	Tajikistan
766	CAN-322534477	Canada
157	BAN-711678757	Bangladesh
33	UZB-142936904	Uzbekistan
105	CHI-920367028	Chile
114	RWA-700493908	Rwanda
710	BRA-393675787	Brazil
968	SRI-663968921	Sri Lanka
784	SUR-590110930	Suriname
59	UAE-756974332	United Arab Emirates
715	HON-339402765	Honduras
395	URU-779004604	Uruguay
585	MAU-881549219	Mauritius
684	DJI-861518560	Djibouti
413	VIE-997784842	Vietnam
764	KAZ-999472031	Kazakhstan
173	BAN-817443216	Bangladesh
206	IRA-718201446	Iran
126	LAO-238313915	Laos
272	SYR-494713679	Syria
711	GUA-564144411	Guatemala
739	TAJ-286729714	Tajikistan
730	SYR-432111511	Syria
371	OMA-825719377	Oman
911	BUL-399395691	Bulgaria
898	SWE-330402334	Sweden
852	LES-002662341	Lesotho
145	IRA-196719819	Iran
777	HON-281998829	Honduras
813	KAZ-471950057	Kazakhstan
758	MEX-706927765	Mexico
472	SUD-636392301	Sudan
681	HON-906252442	Honduras
638	CUB-237305551	Cuba
84	SUD-787410057	Sudan
816	RUS-222255888	Russia
142	PAL-535723963	Palestine
80	MON-888892023	Mongolia
216	GAM-916887717	Gambia
457	MEX-345120520	Mexico
156	GUI-288641130	Guinea
232	KIR-731863534	Kiribati
512	CAR-456513676	Central African Republic
74	NAM-312653463	Namibia
642	BOT-785933032	Botswana
677	GIB-870877893	Gibraltar
972	UGA-916242261	Uganda
333	SWE-343672297	Sweden
886	COS-247233771	Costa Rica
119	RUS-583184450	Russia
656	PER-408442737	Peru
976	BUL-704829742	Bulgaria
494	BOT-007491868	Botswana
479	IRA-636651997	Iran
791	HON-793347989	Honduras
211	AND-748137233	Andorra
932	NIU-705191365	Niue
844	BUR-225355439	Burundi
741	CAP-270902632	Cape Verde
811	UAE-321759852	United Arab Emirates
804	THA-808237997	Thailand
972	OMA-595281309	Oman
763	ZAM-819875537	Zambia
45	SOU-651177840	South Africa
867	PUE-126799324	Puerto Rico
448	ETH-082266695	Ethiopia
631	HAI-706376024	Haiti
387	PAK-524171766	Pakistan
113	BEL-649381357	Belize
125	BRA-160154836	Brazil
257	CUB-577441228	Cuba
210	NOR-991417450	Norway
260	MAL-440211789	Malaysia
984	SUD-915175637	Sudan
395	CAP-972344876	Cape Verde
91	SUR-761610020	Suriname
312	TON-717875617	Tonga
398	DJI-140587735	Djibouti
922	TUN-759315181	Tunisia
980	THA-817058995	Thailand
504	IND-280549746	Indonesia
45	ICE-818427474	Iceland
977	SER-124139136	Serbia
20	BRU-204857848	Brunei
438	PAK-330203119	Pakistan
824	TAN-910895719	Tanzania
228	TAJ-593159402	Tajikistan
866	GUI-540127110	Guinea
719	VAN-740083834	Vanuatu
895	ERI-875479892	Eritrea
699	CUB-124836712	Cuba
463	SAI-231863266	Saint Lucia
168	PAK-532987583	Pakistan
529	WES-808434434	Western Sahara
871	URU-403448911	Uruguay
76	PUE-764671873	Puerto Rico
975	CHI-678221686	Chile
37	COM-542900921	Comoros
202	SRI-158510851	Sri Lanka
506	TAT-162617311	Trinidad and Tobago
413	PER-067483305	Peru
234	URU-384473498	Uruguay
634	CAR-438103929	Central African Republic
55	MON-384346034	Mongolia
670	POL-927906805	Poland
948	MAL-669135842	Malawi
516	YEM-312706976	Yemen
3	VAN-325257192	Vanuatu
642	LAO-690970008	Laos
269	CUB-763663836	Cuba
975	CUR-241744373	Curaçao
431	VAN-921651129	Vanuatu
485	BEL-221646173	Belize
66	MAU-404063124	Mauritius
913	PER-656309041	Peru
376	BUL-877286816	Bulgaria
932	TAJ-660060835	Tajikistan
68	IND-852923425	Indonesia
529	MON-628728409	Mongolia
601	SEY-209406710	Seychelles
570	ERI-588344483	Eritrea
788	SOM-838869726	Somalia
190	SER-675449311	Serbia
315	BAN-914161954	Bangladesh
952	SAU-374493490	Saudi Arabia
138	KIR-632114901	Kiribati
337	BRA-419053450	Brazil
118	URU-470941328	Uruguay
519	ETH-392453345	Ethiopia
866	SAI-401196499	Saint Helena, Ascension and Tristan da Cunha
414	TUR-481193992	Turkey
93	POL-935500368	Poland
118	IVO-202861204	Ivory Coast
929	CAM-796786853	Cambodia
675	UZB-931454021	Uzbekistan
366	SOM-112545671	Somalia
198	IRA-745715446	Iran
719	BOT-997160477	Botswana
823	SUD-194577951	Sudan
294	PAL-441428069	Palestine
184	NIU-309375133	Niue
828	CAM-643164032	Cambodia
580	GUA-275315404	Guatemala
571	MAC-225071657	Macau
572	HAI-571487300	Haiti
202	PAR-958000678	Paraguay
662	ALB-947510927	Albania
486	PNG-059988271	Papua New Guinea
889	CAN-119567789	Canada
506	CAN-542061090	Canada
456	BOL-015403546	Bolivia
408	CZE-648666030	Czechia
309	BRA-628406187	Brazil
554	KAZ-536101700	Kazakhstan
166	DJI-998222709	Djibouti
664	BEL-551077953	Belize
922	SYR-782293661	Syria
340	PAN-182567277	Panama
999	UKR-921322094	Ukraine
74	YEM-037002010	Yemen
127	BAN-536002702	Bangladesh
250	SAU-462046333	Saudi Arabia
763	RUS-749887197	Russia
110	JAP-327256981	Japan
199	MAD-977120093	Madagascar
926	GAM-988263411	Gambia
3	WAF-817554613	Wallis and Futuna
449	ARM-849638746	Armenia
678	CAR-960125323	Central African Republic
128	HAI-774276912	Haiti
187	AND-165703844	Andorra
109	CAP-353809125	Cape Verde
3	IVO-017918831	Ivory Coast
334	VIE-013813990	Vietnam
811	SEY-129488253	Seychelles
784	TAN-092520390	Tanzania
133	NOR-436246898	Norway
469	CAY-021776009	Cayman Islands
261	POL-176161708	Poland
639	MYA-865279077	Myanmar
500	GIB-234071468	Gibraltar
312	NIC-864595264	Nicaragua
145	THA-307599708	Thailand
248	HON-252550616	Hong Kong
845	IRA-893832253	Iran
899	ESW-629947793	Eswatini
127	COS-180988245	Costa Rica
587	OMA-889375016	Oman
665	PUE-016505771	Puerto Rico
897	YEM-784472808	Yemen
205	PAK-287841695	Pakistan
676	UZB-699145760	Uzbekistan
87	TAN-152403178	Tanzania
270	JOR-382011737	Jordan
685	YEM-512640787	Yemen
12	PER-929377310	Peru
796	GEO-372452364	Georgia
497	SWE-392037131	Sweden
200	TUR-075189719	Turkmenistan
954	MAL-713495777	Malawi
244	HON-615327743	Honduras
426	MEX-587910352	Mexico
556	GEO-320641684	Georgia
390	SUR-309288957	Suriname
433	MON-215636089	Mongolia
758	BER-617044546	Bermuda
304	HUN-553952364	Hungary
608	ISR-701593917	Israel
440	MOR-168925071	Morocco
860	COL-521696790	Colombia
535	DOM-252881475	Dominican Republic
114	DR -013709312	DR Congo
528	CHI-110710724	Chile
111	AND-609586885	Andorra
143	MAL-785289428	Maldives
958	SAI-317751912	Saint Helena, Ascension and Tristan da Cunha
877	MOR-580691773	Morocco
299	ISR-682126331	Israel
778	HON-596769952	Hong Kong
264	CAP-526682454	Cape Verde
499	ARM-201049655	Armenia
42	POL-382475174	Poland
71	BAN-809681015	Bangladesh
824	DR -319711285	DR Congo
271	UZB-172021252	Uzbekistan
735	PER-294177524	Peru
998	SOM-025538535	Somalia
300	COL-000425835	Colombia
256	HON-663456631	Honduras
394	ISR-226409417	Israel
428	MOR-922161669	Morocco
794	JAM-783865304	Jamaica
75	BOL-844178977	Bolivia
364	KIR-218130902	Kiribati
859	ROM-769206961	Romania
374	TAJ-192362840	Tajikistan
167	PER-329993772	Peru
711	ARM-029494954	Armenia
702	BAH-359771189	Bosnia and Herzegovina
723	TAJ-680689983	Tajikistan
271	ETH-409573319	Ethiopia
447	PHI-612821934	Philippines
32	NOR-861637165	Norway
797	LAO-734600510	Laos
273	UKR-237778946	Ukraine
881	TUR-266297155	Turkmenistan
953	LIE-311215619	Liechtenstein
678	TAI-893914223	Taiwan
937	MAL-491942171	Malawi
578	GUI-973043241	Guinea
56	VIE-536035592	Vietnam
929	JAP-619329647	Japan
165	SAI-642826027	Saint Lucia
946	JOR-501861311	Jordan
998	MYA-674535185	Myanmar
854	TUN-907274882	Tunisia
122	MAL-122424598	Malawi
712	CUB-331800763	Cuba
149	KIR-213949789	Kiribati
308	SOU-615583835	South Korea
932	UGA-385324004	Uganda
999	TUN-311360823	Tunisia
969	COS-758590846	Costa Rica
271	GIB-203861962	Gibraltar
179	JAM-403331762	Jamaica
235	IND-818239498	India
45	ARM-845857775	Armenia
60	MYA-134223421	Myanmar
18	VIE-193143885	Vietnam
803	PAR-713724875	Paraguay
679	SAU-665730098	Saudi Arabia
38	BUR-507686756	Burundi
774	DR -599439459	DR Congo
211	SAM-662014276	Samoa
713	CZE-215970241	Czechia
211	ERI-381583987	Eritrea
124	UKR-941602922	Ukraine
657	DOM-423836888	Dominican Republic
471	COM-684045623	Comoros
89	JAP-798367645	Japan
175	RWA-229181557	Rwanda
294	TAJ-334556279	Tajikistan
509	SAM-530493697	Samoa
7	ESW-644069226	Eswatini
289	ALB-321735257	Albania
768	CUR-690846209	Curaçao
246	TON-567435195	Tonga
907	HON-632618939	Hong Kong
454	MAD-898587662	Madagascar
689	PER-837921952	Peru
239	URU-517252877	Uruguay
306	BRA-095714677	Brazil
524	ZAM-920835850	Zambia
444	VIE-359746397	Vietnam
980	JAP-195460686	Japan
271	KEN-124551437	Kenya
693	BAH-673154698	Bosnia and Herzegovina
984	LIE-650779202	Liechtenstein
629	THA-113963176	Thailand
288	LIB-561295915	Liberia
213	KYR-780997698	Kyrgyzstan
903	DR -526817077	DR Congo
32	CAR-897232337	Central African Republic
24	ETH-629351150	Ethiopia
9	DJI-678934569	Djibouti
645	COL-517830382	Colombia
906	UKR-281545251	Ukraine
640	SYR-528309662	Syria
662	DJI-449841878	Djibouti
925	SWE-245011726	Sweden
862	YEM-037250018	Yemen
955	NOR-077386844	Norway
552	MON-213142530	Mongolia
701	FIJ-745765131	Fiji
788	JAM-307207217	Jamaica
295	BAN-549538013	Bangladesh
669	SAM-518242967	Samoa
128	TAJ-070984818	Tajikistan
113	SOU-079196946	South Africa
127	IVO-864709839	Ivory Coast
457	IND-028997266	India
446	KIR-002126639	Kiribati
945	CAM-331657478	Cambodia
470	WAF-619471978	Wallis and Futuna
161	VAN-197843516	Vanuatu
397	DR -556265600	DR Congo
529	UAE-980459854	United Arab Emirates
840	CZE-620980972	Czechia
780	CUB-980696537	Cuba
2	KEN-826593174	Kenya
66	JAM-866798433	Jamaica
837	ARU-830159795	Aruba
969	HAI-864452001	Haiti
2	BEL-023029883	Belize
374	NOR-253179667	Norway
276	GEO-684221501	Georgia
205	TAT-741128917	Trinidad and Tobago
374	MAD-849337507	Madagascar
494	JAP-526308386	Japan
742	HON-820328902	Hong Kong
239	ESW-932133011	Eswatini
291	HAI-685588608	Haiti
889	KIR-309706822	Kiribati
503	POL-101309224	Poland
239	MAL-741171253	Malawi
243	MAL-642297926	Malaysia
536	PAL-117912458	Palestine
847	VIE-750397843	Vietnam
365	VAN-964221690	Vanuatu
910	GHA-422957167	Ghana
766	SWE-495250796	Sweden
445	WAF-031696497	Wallis and Futuna
341	PAL-671741485	Palestine
40	WAF-862740808	Wallis and Futuna
890	GAM-119617091	Gambia
697	ICE-892854941	Iceland
963	GHA-799374118	Ghana
845	UGA-589470767	Uganda
23	LES-206172808	Lesotho
81	SEY-078527539	Seychelles
763	LES-105599419	Lesotho
91	HON-465420436	Hong Kong
43	TAI-091185515	Taiwan
34	JAM-854028339	Jamaica
35	CAP-414416693	Cape Verde
868	CAP-613586336	Cape Verde
444	COS-412098121	Costa Rica
672	SAU-110659409	Saudi Arabia
277	NOR-838617005	North Korea
482	IND-542152729	Indonesia
613	AND-643056024	Andorra
327	KAZ-905551932	Kazakhstan
922	LIE-845829605	Liechtenstein
525	MOR-859910837	Morocco
268	ROM-628659064	Romania
794	MAL-979893406	Malaysia
466	ERI-418899018	Eritrea
744	MAC-240037274	Macau
170	LAO-949470261	Laos
385	SOU-171220463	South Africa
76	MEX-163399624	Mexico
295	ERI-208934214	Eritrea
767	TUR-438111255	Turkmenistan
485	PAL-468391175	Palestine
227	PHI-303837344	Philippines
855	CHI-012023665	Chile
803	SOU-986719582	South Korea
933	HON-901150195	Honduras
422	KIR-104052379	Kiribati
110	SRI-762330322	Sri Lanka
33	BOL-657732515	Bolivia
648	RUS-462915232	Russia
661	MAC-130544424	Macau
6	VIE-882408322	Vietnam
45	IND-921118132	India
775	MAD-556050495	Madagascar
460	CAR-214563832	Central African Republic
672	GHA-522471483	Ghana
488	MOL-067193226	Moldova
691	GUI-287912188	Guinea
856	GAM-838689456	Gambia
100	HON-016324887	Honduras
534	CAM-638903919	Cambodia
82	DR -552206277	DR Congo
852	CUR-122188347	Curaçao
340	MAC-871889559	Macau
579	GEO-820474689	Georgia
935	ARM-396976617	Armenia
905	SAM-100396356	Samoa
819	DJI-499966325	Djibouti
148	TAJ-679099016	Tajikistan
370	BAN-951900590	Bangladesh
791	SOU-549434480	South Korea
974	SEY-812728102	Seychelles
404	GUA-387033847	Guatemala
956	MYA-345656697	Myanmar
165	MAD-651246173	Madagascar
396	ISR-493648729	Israel
542	SOU-267653315	South Africa
956	MON-099208230	Mongolia
647	LIE-655634423	Liechtenstein
638	CAN-453800705	Canada
657	PAL-125898599	Palestine
905	RWA-057354196	Rwanda
491	JAP-867187472	Japan
252	TON-007633675	Tonga
639	TAI-546402642	Taiwan
178	DJI-073502188	Djibouti
118	ZAM-653946591	Zambia
443	ARG-849545109	Argentina
1000	ICE-954537401	Iceland
788	FIJ-482428119	Fiji
41	VIE-826060010	Vietnam
96	COL-412247394	Colombia
241	SWE-428929420	Sweden
685	SEY-280279228	Seychelles
169	PER-176181702	Peru
153	TUN-748352413	Tunisia
311	ESW-271366155	Eswatini
120	TUR-232024310	Turkmenistan
588	MOR-007690269	Morocco
224	KAZ-063710466	Kazakhstan
821	GUA-329145655	Guatemala
345	OMA-872119403	Oman
938	RWA-524419411	Rwanda
952	ALB-858427773	Albania
201	SUD-268500932	Sudan
8	BER-760138200	Bermuda
794	COL-861251845	Colombia
181	COM-587411161	Comoros
964	MOR-680416704	Morocco
467	DOM-282500876	Dominican Republic
282	FIJ-471275626	Fiji
129	BER-418303078	Bermuda
754	CHI-838539028	China
243	SRI-114485805	Sri Lanka
425	COL-362020932	Colombia
704	BOL-536932647	Bolivia
48	ROM-532429539	Romania
618	DR -142963580	DR Congo
465	JAM-485028734	Jamaica
335	PUE-730810874	Puerto Rico
221	HAI-233495696	Haiti
458	MOR-189777428	Morocco
984	BUL-228223270	Bulgaria
545	SAM-786521878	Samoa
475	JAM-737556003	Jamaica
768	SAI-190734392	Saint Helena, Ascension and Tristan da Cunha
858	TUR-350700798	Turkey
692	DR -484420920	DR Congo
884	SUD-552949961	Sudan
925	BAH-054577020	Bahrain
429	SEY-067225044	Seychelles
157	RWA-823579125	Rwanda
2	DJI-477566390	Djibouti
14	BAN-559523728	Bangladesh
542	BAH-737303241	Bahamas
521	DOM-508922811	Dominican Republic
299	PER-546310553	Peru
380	TAN-441717304	Tanzania
841	PUE-028422338	Puerto Rico
729	GEO-637065111	Georgia
400	CAY-079131689	Cayman Islands
495	SWE-365134847	Sweden
737	SEY-375094159	Seychelles
111	PAL-475775016	Palestine
778	MAL-139356318	Maldives
645	DOM-284883761	Dominican Republic
135	OMA-477202555	Oman
854	FIJ-305206423	Fiji
847	MON-113328240	Mongolia
250	UGA-310144601	Uganda
836	CUB-412995969	Cuba
515	RUS-518341362	Russia
727	NAM-317053582	Namibia
462	TUR-845012553	Turkey
283	MYA-632996644	Myanmar
312	MOR-346825225	Morocco
764	TON-609227205	Tonga
742	GHA-623746005	Ghana
767	SOM-999746167	Somalia
266	COL-141736235	Colombia
830	IND-023946631	India
556	PER-948541004	Peru
872	MAD-547188500	Madagascar
267	MOR-994010932	Morocco
908	JAM-788034602	Jamaica
341	TUN-830105046	Tunisia
623	MAD-561052973	Madagascar
538	TON-529515494	Tonga
448	COS-248580825	Costa Rica
104	BRU-397519039	Brunei
104	GEO-652842256	Georgia
713	COS-682534332	Costa Rica
370	LAO-897179147	Laos
659	PAK-158260120	Pakistan
262	CAR-706801137	Central African Republic
697	ARM-379366428	Armenia
963	ARM-048458928	Armenia
973	BUR-571060515	Burundi
219	ESW-716078424	Eswatini
520	KIR-064830173	Kiribati
571	HAI-201148038	Haiti
261	SAU-981426998	Saudi Arabia
757	VIE-117460447	Vietnam
431	TUN-029052527	Tunisia
220	BAH-999718000	Bosnia and Herzegovina
217	IRA-710613762	Iran
3	ALB-470840275	Albania
556	FAL-992833323	Falkland Islands
466	SUD-515054014	Sudan
560	TUN-690726712	Tunisia
85	KYR-981452014	Kyrgyzstan
321	TAI-328539359	Taiwan
150	ARU-516579061	Aruba
462	GAM-418069716	Gambia
52	BAH-212056348	Bosnia and Herzegovina
1000	COM-768598858	Comoros
876	ARU-384043991	Aruba
741	RWA-095653737	Rwanda
496	FAL-529839570	Falkland Islands
755	MAL-311534677	Malawi
634	THA-767116385	Thailand
40	MYA-700239761	Myanmar
717	WAF-481598953	Wallis and Futuna
864	GUI-238291380	Guinea
591	GAM-028917618	Gambia
764	KIR-828334371	Kiribati
309	GAM-129337919	Gambia
594	TAT-272120596	Trinidad and Tobago
171	PAR-680636174	Paraguay
283	PER-039304475	Peru
983	LIB-722631236	Liberia
52	CHI-023201403	Chile
50	PAL-662723387	Palestine
32	SAU-855246369	Saudi Arabia
575	TAN-412881001	Tanzania
481	MAC-807405938	Macau
928	PAL-828475144	Palestine
114	VIE-279230845	Vietnam
591	LIB-650847568	Liberia
115	SUR-553272363	Suriname
37	KIR-330870346	Kiribati
1000	ARG-288996294	Argentina
267	VAN-257492420	Vanuatu
254	ERI-306921610	Eritrea
37	CUR-392881437	Curaçao
490	LIE-801632221	Liechtenstein
3	UZB-582811041	Uzbekistan
61	SRI-730810666	Sri Lanka
224	HAI-220675973	Haiti
490	PUE-390193928	Puerto Rico
787	RUS-888773557	Russia
452	MOL-432773366	Moldova
476	UZB-937962337	Uzbekistan
63	ISR-500307912	Israel
169	NOR-858636474	North Korea
96	SAI-765149339	Saint Lucia
559	SWE-809198590	Sweden
632	GAM-382142175	Gambia
214	MOL-651170872	Moldova
604	BRU-336196967	Brunei
686	GUA-881648767	Guatemala
249	SRI-165045255	Sri Lanka
125	PER-155345606	Peru
298	PHI-567524376	Philippines
692	CUB-125683183	Cuba
202	MAD-243835984	Madagascar
700	ERI-394044988	Eritrea
441	SOM-891851403	Somalia
943	SER-793301332	Serbia
242	PER-709014285	Peru
262	DR -616004666	DR Congo
789	MAU-843407480	Mauritius
25	JAM-048059763	Jamaica
847	ICE-811206557	Iceland
562	POL-298774453	Poland
178	ARM-348124432	Armenia
100	UAE-247814993	United Arab Emirates
953	SOM-957451680	Somalia
269	BAH-676077643	Bosnia and Herzegovina
268	CUR-464941789	Curaçao
341	BUL-373511884	Bulgaria
581	TUR-052660036	Turkey
788	MOL-010732302	Moldova
211	KYR-234752474	Kyrgyzstan
211	PAN-146884144	Panama
611	ROM-498264837	Romania
44	PHI-267674401	Philippines
628	JOR-414348156	Jordan
956	TON-620308578	Tonga
397	NOR-525865693	North Korea
69	BRU-651846490	Brunei
403	MYA-843339495	Myanmar
302	DJI-577915834	Djibouti
431	CAN-546412918	Canada
266	NOR-001741468	North Korea
779	IND-541552792	Indonesia
346	UAE-171092446	United Arab Emirates
347	ISR-707309418	Israel
578	ESW-490778277	Eswatini
23	IVO-314638592	Ivory Coast
670	LAO-001146889	Laos
210	PAR-374882181	Paraguay
569	SAI-366795412	Saint Helena, Ascension and Tristan da Cunha
143	NIU-872990389	Niue
401	IVO-119094109	Ivory Coast
707	BAH-129059457	Bahrain
294	KYR-317663152	Kyrgyzstan
447	BRA-505297579	Brazil
64	DJI-721911612	Djibouti
943	SEY-223286335	Seychelles
7	CUR-374413290	Curaçao
164	GAM-051594794	Gambia
34	DR -691742697	DR Congo
974	MAL-613194907	Malawi
368	IND-757609659	Indonesia
872	FIJ-498306292	Fiji
758	SEY-323394634	Seychelles
875	PNG-783641059	Papua New Guinea
296	HAI-053305154	Haiti
474	HAI-741522103	Haiti
792	NOR-447009850	Norway
28	MAL-376682332	Malawi
973	ZAM-565378200	Zambia
441	GUA-831053884	Guatemala
194	COM-979917178	Comoros
641	JAM-205070400	Jamaica
212	CHI-928186493	China
25	ETH-456918429	Ethiopia
164	LAO-808143398	Laos
917	PHI-962551583	Philippines
473	TUN-026109736	Tunisia
343	ARM-530622365	Armenia
69	SEY-056273921	Seychelles
280	RUS-491847489	Russia
701	BOL-038502944	Bolivia
731	BER-421038969	Bermuda
977	ISR-705634373	Israel
854	CAN-928767121	Canada
738	GUA-876133915	Guatemala
577	URU-825088415	Uruguay
949	UGA-702330172	Uganda
394	SEY-664080081	Seychelles
495	SOU-695380110	South Korea
475	MAC-766619353	Macau
452	PHI-384602040	Philippines
751	VIE-922872595	Vietnam
220	JAM-382906292	Jamaica
300	TAI-982570464	Taiwan
519	SAI-428383896	Saint Lucia
411	GIB-088820596	Gibraltar
83	DOM-019046354	Dominican Republic
892	SER-360424570	Serbia
923	ISR-091817219	Israel
22	GAM-029576082	Gambia
486	BER-556654688	Bermuda
844	SAI-103646317	Saint Helena, Ascension and Tristan da Cunha
668	ALB-426702389	Albania
51	GUI-809362497	Guinea
168	SER-029607805	Serbia
545	NAM-103803919	Namibia
514	BUR-160077589	Burundi
372	SRI-139649362	Sri Lanka
705	TAJ-167137814	Tajikistan
951	SAI-715025127	Saint Lucia
310	ARU-326952839	Aruba
916	MEX-593476218	Mexico
555	ICE-789416803	Iceland
744	MAL-567547346	Malawi
884	BER-097103261	Bermuda
203	SYR-254750169	Syria
998	VIE-252087199	Vietnam
835	TAT-523268128	Trinidad and Tobago
43	MAU-420643603	Mauritius
959	TON-909049837	Tonga
272	MOL-753544508	Moldova
806	JOR-812115762	Jordan
482	KYR-890871595	Kyrgyzstan
230	LIE-316564158	Liechtenstein
384	SIN-302814429	Singapore
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
94	Sri Lanka	LKR
998	Uzbekistan	UZS
76	Kazakhstan	KZT
260	Zambia	ZMW
66	Thailand	THB
679	Fiji	FJD
504	Honduras	HNL
254	Kenya	KES
354	Iceland	ISK
53	Cuba	CUC
686	Kiribati	AUD
355	Albania	ALL
886	Taiwan	TWD
220	Gambia	GMD
266	Lesotho	LSL
976	Mongolia	MNT
374	Armenia	AMD
597	Suriname	SRD
501	Belize	BZD
675	Papua New Guinea	PGK
1787	Puerto Rico	USD
673	Brunei	BND
971	United Arab Emirates	AED
1876	Jamaica	JMD
972	Israel	ILS
231	Liberia	LRD
62	Indonesia	IDR
373	Moldova	MDL
970	Palestine	EGP
238	Cape Verde	CVE
1868	Trinidad and Tobago	TTD
880	Bangladesh	BDT
968	Oman	OMR
249	Sudan	SDG
967	Yemen	YER
506	Costa Rica	CRC
291	Eritrea	ERN
233	Ghana	GHS
91	India	INR
856	Laos	LAK
216	Tunisia	TND
261	Madagascar	MGA
1242	Bahamas	BSD
267	Botswana	BWP
236	Central African Republic	XAF
993	Turkmenistan	TMT
255	Tanzania	TZS
46	Sweden	SEK
595	Paraguay	PYG
81	Japan	JPY
90	Turkey	TRY
51	Peru	PEN
599	Curaçao	ANG
359	Bulgaria	BGN
297	Aruba	AWG
507	Panama	PAB
685	Samoa	WST
1345	Cayman Islands	KYD
992	Tajikistan	TJS
27	South Africa	ZAR
52	Mexico	MXN
65	Singapore	SGD
850	North Korea	KPW
248	Seychelles	SCR
73	Russia	RUB
678	Vanuatu	VUV
225	Ivory Coast	XOF
995	Georgia	GEL
420	Czechia	CZK
84	Vietnam	VND
500	Falkland Islands	FKP
852	Hong Kong	HKD
269	Comoros	KMF
962	Jordan	JOD
381	Serbia	RSD
1441	Bermuda	BMD
265	Malawi	MWK
973	Bahrain	BHD
92	Pakistan	PKR
251	Ethiopia	ETB
54	Argentina	ARS
1	Canada	CAD
57	Colombia	COP
56	Chile	CLP
963	Syria	SYP
290	Saint Helena, Ascension and Tristan da Cunha	GBP
380	Ukraine	UAH
350	Gibraltar	GIP
224	Guinea	GNF
591	Bolivia	BOB
98	Iran	IRR
676	Tonga	TOP
502	Guatemala	GTQ
376	Andorra	EUR
387	Bosnia and Herzegovina	BAM
252	Somalia	SOS
234	Nigeria	NGN
2125288	Western Sahara	DZD
264	Namibia	NAD
212	Morocco	MAD
505	Nicaragua	NIO
256	Uganda	UGX
95	Myanmar	MMK
509	Haiti	HTG
966	Saudi Arabia	SAR
47	Norway	NOK
960	Maldives	MVR
82	South Korea	KRW
996	Kyrgyzstan	KGS
63	Philippines	PHP
55	Brazil	BRL
1809	Dominican Republic	DOP
268	Eswatini	SZL
250	Rwanda	RWF
243	DR Congo	CDF
36	Hungary	HUF
423	Liechtenstein	CHF
60	Malaysia	MYR
48	Poland	PLN
86	China	CNY
40	Romania	RON
853	Macau	MOP
683	Niue	NZD
1758	Saint Lucia	XCD
855	Cambodia	KHR
598	Uruguay	UYU
681	Wallis and Futuna	XPF
230	Mauritius	MUR
257	Burundi	BIF
253	Djibouti	DJF
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
1	Teixeira S.A. Spotlight	0	654	469	1994-12-25
2	Pastor Campos S/A Aqui	0	464	741	2011-10-28
3	Pinto Ltda. Cast	0	262	219	2007-07-09
4	Jesus Jesus S.A. HoraNobre	0	5	784	2020-01-29
5	Mendoza, Knight and Lynn LiveStream	0	998	596	2020-04-20
6	Meyer-Jones Exclusivo	0	440	907	1996-08-05
7	Mendonça Ltda. Flow	0	786	240	2024-05-16
8	da Rocha e Filhos Playground	0	473	641	2011-12-05
9	Howard, Green and Hopkins Prime	0	978	415	2009-08-21
10	Rocha Araújo S.A. Air	0	218	127	2020-07-15
11	White PLC Connect+	0	937	261	2015-01-18
12	Rose, Carter and Cervantes Exclusivo	0	176	925	1999-10-22
13	da Mata Barros - EI Stage	0	882	169	2021-11-15
14	Reed-Russo PrimeTime	0	363	168	1990-05-17
15	Albuquerque Transmit	0	934	234	2018-07-29
16	Leão - ME Explorer	0	254	855	1999-10-08
17	Fogaça Cavalcanti - EI Scene	0	991	708	2010-12-10
18	Farias Leão e Filhos Showcase	0	702	73	2018-09-23
19	Rios e Filhos Equipe	0	176	504	2005-01-30
20	Garcia-Martin AoVivo	0	871	640	2012-11-25
21	Casa Grande Moura - ME Next	0	766	37	2005-02-08
22	Fernandes Premium	0	483	255	1991-04-05
23	Turner Inc Stage	0	570	440	1993-10-19
24	Mahoney, Reese and Johnson Navigator	0	986	181	1991-05-15
25	Everett LLC Future	0	7	236	2003-02-19
26	Clark-Jackson Gate	0	127	79	2003-12-01
27	Porto e Filhos Next	0	482	481	2007-04-28
28	Hubbard, Kim and Kirk Sync	0	821	177	2015-02-16
29	Carroll Inc Access+	0	27	876	1997-10-21
30	Wright, Cantrell and Jackson Now	0	244	507	1997-08-15
31	Osborn-Williams Play	0	212	198	1997-05-22
32	Brito Ltda. Reels	0	897	519	2023-02-19
33	Wells, Knight and Johnson Spot	0	600	853	2001-06-28
34	Ibarra-Mitchell Hub	0	454	624	2007-10-25
35	Leão Moreira - ME Spot	0	229	19	2020-01-12
36	Jones-Vaughan Universe	0	849	71	2002-06-24
37	Fisher and Sons Plataforma	0	852	216	2010-01-05
38	da Rosa Brito S.A. Plus	0	601	280	2021-01-21
39	Cantu-Roach Arquivo	0	883	27	1992-02-12
40	Macedo Ltda. Plus	0	179	65	2011-06-10
41	Adams, Pham and Carter Stage	0	730	822	2000-02-17
42	Rios-Anderson Navigator	0	822	993	2023-03-15
43	Cirino Vieira - ME Arquivo	0	820	652	2010-11-25
44	Diaz, Campbell and Russell Reels	0	249	91	2005-04-20
45	Gonzalez PLC Ritmo	0	450	292	2005-08-25
46	Fonseca Cardoso - EI Playground	0	870	431	1992-09-23
47	Câmara - ME Play	0	965	712	2024-05-16
48	Jones-Davis Navigator	0	160	741	1990-05-12
49	Hodge PLC Collection	0	922	597	1991-02-17
50	Costela S.A. Canal	0	901	62	2004-07-14
51	Camargo Barbosa - ME Streamline	0	951	212	2003-08-06
52	Davis, Peters and Baker CinePlus	0	225	741	2017-12-11
53	Sá Mendes S/A Vault	0	247	146	2004-07-01
54	Jesus - EI Ponto	0	54	126	1996-05-26
55	Ellis, Harris and Harvey Radio	0	551	779	2003-04-08
56	Harris, Aguirre and Mcpherson Sincroniza	0	603	101	1994-04-28
57	Araújo - EI Stream	0	751	49	2019-12-14
58	Camargo Novaes - EI Atlas	0	365	882	1992-12-25
59	Molina-Harper Spotlight	0	883	894	2000-08-07
60	da Conceição Araújo - EI Replay	0	706	179	2018-07-30
61	da Rosa S/A Cine	0	472	796	2015-10-21
62	Sousa Marques - EI Canal	0	115	909	2018-06-25
63	Ribeiro S.A. Crew	0	19	27	2022-06-29
64	Gonzales-Mcdonald Stage	0	909	547	2007-11-13
65	Marques S.A. Streamline	0	897	884	1996-06-12
66	Pittman-Steele Radio	0	950	875	1990-10-10
67	Cunha Costa S.A. Premium	0	789	293	2023-10-22
68	Reyes, Hernandez and Mullins Streamline	0	191	362	2003-10-22
69	Wright-Robinson Ritmo	0	241	739	2001-06-11
70	Flores-Hunt Mini	0	972	612	2013-09-15
71	Cardoso Ltda. Equipe	0	993	621	2001-11-22
72	Camargo Jesus Ltda. Lite	0	432	593	1993-08-07
73	Gonçalves S.A. Replay	0	69	621	2015-08-05
74	Gonzalez-Lopez Collection	0	547	112	2015-11-03
75	Nascimento Brito S/A Stage	0	751	3	1999-04-23
76	Riggs-Miller Ritmo	0	247	311	2017-11-21
77	Moss-Strong Navigator	0	503	926	2016-03-23
78	Moreira S.A. Collective	0	413	478	2000-01-25
79	Williams LLC LoopTV	0	899	639	2010-02-27
80	Nguyen and Sons Lite	0	613	408	1994-02-21
81	Lewis-Evans Ritmo	0	583	545	1999-06-06
82	Williams-Rodriguez HoraNobre	0	866	747	2025-10-12
83	Jesus Moreira S.A. Direct	0	65	35	2011-07-21
84	Maxwell Group Exclusive	0	13	776	2001-06-08
85	Pastor - EI Studio	0	414	180	2003-07-30
86	Baker-White AoVivo	0	925	616	1992-11-04
87	Teixeira Gomes e Filhos Fluxo	0	307	979	1991-03-17
88	Souza Mendes Ltda. Fluxo	0	289	200	1994-10-03
89	Fogaça - EI Collective	0	625	760	2016-04-02
90	Silveira Moura - EI Portal	0	698	334	1993-05-16
91	Mcintyre-Pratt Cinema	0	147	460	2015-01-27
92	Bishop Inc Studios	0	327	95	2017-07-25
93	Souza Cavalcanti - EI Equipe	0	573	319	2010-03-24
94	Stevens Group Cine	0	366	247	1997-02-22
95	Zimmerman-Walker Exclusivo	0	869	803	2008-11-05
96	Wheeler Ltd Navigator	0	921	720	2020-08-10
97	Castro-Vega Sync	0	770	934	2001-12-24
98	Pastor Vargas - ME Flix	0	252	679	2009-04-13
99	Carter-Mendez Cine	0	837	568	2009-12-06
100	Wood-Herrera Atlas	0	78	942	2005-03-15
101	Levy-Boyle Universe	0	281	372	2004-05-29
102	Coleman, Sutton and Long Originais	0	944	678	1993-05-02
103	Vargas - ME Vibe	0	659	226	2023-11-17
104	Aparecida e Filhos Loop	0	702	972	1998-08-09
105	da Rosa - ME Box	0	318	414	2019-05-05
106	da Luz Marques - ME Studios	0	702	193	2024-11-13
107	Cavalcanti S/A Navigator	0	204	422	1994-09-16
108	Glenn Inc LoopTV	0	629	645	1994-01-21
109	Nogueira Cavalcante S/A Groove	0	905	984	2014-08-21
110	Nunes Duarte e Filhos Access+	0	978	349	2010-10-13
111	Thomas Ltd Loop	0	862	18	2004-01-08
112	Adams and Sons Entrada	0	972	265	2017-12-24
113	Walsh Inc Broadcast	0	444	457	2017-04-02
114	Correia Monteiro - EI Mini	0	34	369	2023-08-13
115	Robles LLC Mais	0	514	734	2010-07-28
116	Kennedy, Cole and Boyd Play	0	564	887	2023-02-06
117	Garcia-Taylor Prime	0	346	707	2003-01-22
118	Ferreira - EI Streamline	0	9	851	2022-06-08
119	Silva - ME Lineup	0	172	627	1991-06-11
120	das Neves e Filhos Showcase	0	640	67	2021-04-26
121	Welch-Gould Pocket	0	874	246	2013-12-26
122	Booth, Little and Hill Portal	0	992	205	2011-09-24
123	Campos - ME Mini	0	410	863	2003-01-14
124	Holt, Murphy and Sheppard Filmes	0	929	173	2005-10-05
125	Taylor, Rodriguez and Guzman Reel	0	173	633	2024-01-14
126	Zamora, Martinez and Reed Plus	0	694	751	1990-09-25
127	Vargas PLC Highlights	0	42	525	1997-04-07
128	Mitchell-Howard Stream	0	182	35	2010-11-08
129	Norton, Case and Ramirez Exclusive	0	938	758	2024-11-30
130	Farley LLC Mini	0	955	149	2024-04-07
131	Fogaça Almeida - EI Cinema	0	943	376	2005-11-19
132	Best-Mack Portal	0	432	534	2001-12-08
133	Smith PLC Stage	0	502	273	2006-11-23
134	da Rocha - ME PlayLab	0	649	955	1991-03-12
135	Farias Novaes S.A. Network	0	723	13	1991-10-20
136	Gonzales, Woods and Bowers Broadcast	0	640	496	2022-09-05
137	Barbosa Cassiano - ME Station	0	92	976	1997-08-10
138	Pimenta e Filhos Studio	0	61	810	2007-10-29
139	Smith-Blair Play	0	764	249	2003-04-09
140	Sá Caldeira - ME Play	0	995	871	2022-12-16
141	Gross-Coleman Ritmo	0	552	57	2015-11-04
142	Clark-Ortiz Sincroniza	0	144	632	2005-05-19
143	Lima da Luz e Filhos Exclusive	0	593	653	2018-10-20
144	Sampaio Edge	0	736	164	2021-11-07
145	Arellano, Murray and Bender Showcase	0	212	218	2024-12-18
146	Flynn LLC Studios	0	715	863	2012-12-25
147	Moreira da Mota e Filhos Navigator	0	753	340	1999-04-06
148	Cole LLC Originais	0	669	620	2007-08-05
149	Moura Alves S.A. Streamline	0	802	946	2013-06-04
150	Williams-Brooks Universo	0	883	170	2000-11-28
151	Glass-Ramsey Pod	0	618	377	2000-05-02
152	Guerra - EI Equipe	0	130	603	2015-01-08
153	da Conceição e Filhos Play	0	585	61	2011-11-02
154	das Neves S/A Palco	0	62	887	2021-04-16
155	Lyons, Conrad and Williams Wave	0	650	68	2016-12-14
156	Silveira Rodrigues S/A Replay	0	605	109	2008-03-13
157	Schneider-Edwards Collection	0	343	208	2017-03-17
158	Porto S/A Select	0	957	720	2009-07-13
159	Williams, Hoover and Terrell Ponto	0	967	89	1992-08-15
160	Snyder LLC Connect	0	560	500	1990-03-29
161	Lopes Pinto S.A. Worlds	0	988	703	2005-04-21
162	Bradley, Dickson and Hall PlayLab	0	608	274	2007-07-29
163	Sá Jesus e Filhos Entrada	0	914	736	2009-04-29
164	Smith-Sanchez Studio	0	810	59	2012-04-08
165	da Costa S/A Mais	0	795	581	2003-04-06
166	Clark, Howell and Carson Universo	0	789	857	1999-01-30
167	Silveira Ltda. Library	0	372	693	2019-05-11
168	Elliott Group Wave	0	672	779	1996-11-07
169	Viana Ltda. Originais	0	488	738	1999-07-18
170	Spencer, Munoz and Campbell Navigator	0	4	322	2020-05-09
171	Abreu - ME Lite	0	323	515	2011-03-17
172	Sawyer, Bolton and Perkins PrimeTime	0	244	910	2004-08-02
173	Reid, Walters and Hunter Exclusivo	0	939	24	2019-09-04
174	Freitas Cardoso - ME PocketTV	0	616	698	1993-06-22
175	Moraes Machado S.A. LoopTV	0	826	155	2023-01-14
176	da Mota Cassiano e Filhos On	0	79	546	2001-04-15
177	Russell-Jones Mundo	0	598	817	1990-03-31
178	Duarte Rocha e Filhos Spot	0	881	873	2010-05-17
179	da Paz Costa Ltda. Channel	0	290	882	2001-12-04
180	Watkins-Adams Universo	0	703	448	2014-06-13
181	Barnes PLC Onda	0	385	563	2004-12-09
182	Peixoto Barbosa e Filhos Wave	0	693	703	2008-10-04
183	Barry Group Access+	0	547	715	2019-02-20
184	Harper Group Realm	0	217	910	2021-08-03
185	Pacheco Ltda. Cast	0	244	125	2014-01-02
186	Rodrigues - ME Live+	0	14	781	1990-11-12
187	Davidson Inc Universo	0	136	976	2014-08-07
188	Lima Ltda. Select	0	961	541	2005-07-19
189	Walker-Schwartz Pod	0	487	308	2009-07-01
190	Curry, Andersen and Nguyen Ritmo	0	721	558	2002-03-07
191	Wilson-Solis OnRepeat	0	843	847	2017-05-13
192	Hudson Inc Mundo	0	458	120	2011-12-12
193	Johnson Group Plus	0	943	965	1996-05-11
194	Gomes Pinto - ME Flow	0	368	857	1999-04-22
195	Martins Araújo S.A. Mapa	0	518	374	2020-05-21
196	Campos Rezende S.A. Radio	0	917	393	1991-09-27
197	Reyes, Gonzalez and Thomas Edge	0	423	245	2024-05-26
198	Costa Câmara S.A. Premium	0	278	805	2013-04-30
199	Mcknight-Hansen Reel	0	564	632	2005-09-08
200	Kennedy LLC Aqui	0	400	944	2014-09-24
201	Ferguson-Chapman Sync	0	418	593	1993-11-30
202	Watkins-Collins Spot	0	595	110	2012-03-04
203	Harris, Vargas and Rivera Live	0	386	354	2006-08-29
204	Vargas Novaes - ME HoraNobre	0	229	729	1996-02-09
205	Farias Pires - EI LoopTV	0	259	972	1997-01-02
206	Cox and Sons Wave	0	573	167	2018-05-19
207	Santos S.A. Flow	0	903	509	2024-03-05
208	da Rocha S/A Pocket	0	629	24	2011-09-22
209	Montenegro S/A Gate	0	275	441	2023-04-02
210	Adams-Larson Prime	0	239	805	2011-02-12
211	da Mata Farias Ltda. Verse	0	552	637	2002-05-25
212	Davis, Soto and Fletcher Replay	0	354	515	2002-08-30
213	Bailey-Silva Spot	0	5	634	1998-11-29
214	Jackson PLC Worlds	0	821	115	1993-05-28
215	Rocha - ME Select	0	488	561	2000-06-20
216	Liu, Johnson and Wright Live	0	985	289	2023-05-22
217	Turner-Conner AoVivo	0	683	969	1994-05-10
218	Sparks, Allen and Christensen Exclusive	0	569	220	2005-04-07
219	Liu-Fleming Ponto	0	804	286	1993-09-22
220	Nelson-Brown Stream	0	964	377	1990-05-19
221	Casa Grande Câmara Ltda. CinePlus	0	406	383	2016-08-17
222	Rodrigues Azevedo - EI Plataforma	0	582	350	2011-10-15
223	Pereira S/A On	0	29	978	2014-03-07
224	Lopez-Woods Navigator	0	934	866	1991-11-06
225	Sousa e Filhos Exclusivo	0	240	918	2022-07-05
226	Reyes-Lowe Plus	0	925	926	1991-07-23
227	Silva Azevedo Ltda. Loop	0	858	226	2002-02-10
228	Montenegro Campos S.A. Access	0	28	481	1998-08-06
229	Fernandes da Rosa S.A. Hub	0	178	819	2011-08-17
230	Brito Cassiano - ME Universo	0	467	238	1999-04-20
231	Brown-Gregory Hub	0	671	860	2022-03-09
232	Campos Ltda. Pod	0	795	110	1999-05-16
233	Wilson-Ferguson Studios	0	95	142	1991-12-26
234	Perez LLC Universe	0	396	636	2004-03-17
235	Vieira S.A. Cine	0	845	110	2023-12-11
236	Webster, Johnson and Wright Network	0	641	221	2007-02-24
237	Clark Inc LoopTV	0	976	384	2011-06-19
238	Hunter and Sons LiveStream	0	662	966	2006-09-16
239	Patterson PLC Vibe	0	464	852	2007-08-20
240	Rocha Monteiro - EI Lineup	0	563	954	1996-02-09
241	Mendonça Nunes e Filhos Mini	0	344	376	2001-02-27
242	Andrade Cunha S/A Canal	0	253	57	1999-09-19
243	Moody, Watson and James Transmit	0	905	487	2009-04-07
244	Novais e Filhos Plus	0	59	871	1996-04-26
245	Costela Rodrigues - EI On	0	475	669	1992-07-03
246	Hammond-Cook Access+	0	779	606	2024-11-28
247	Guerra - ME Access+	0	997	49	1998-12-23
248	Peixoto - EI Highlights	0	464	258	2016-11-23
249	Cardoso - EI Streamline	0	884	874	2011-11-29
250	Taylor-Gonzales Access+	0	21	453	1992-10-14
251	Cowan-Moss Queue	0	535	91	1993-08-11
252	Silva S.A. Loop	0	576	124	1991-02-27
253	da Cunha Ltda. Originais	0	263	759	1992-07-19
254	Sales Ltda. Connect	0	972	469	2016-06-14
255	Peterson-Larson Filmes	0	29	233	2002-09-25
256	Peterson-Chavez Sync	0	798	167	1992-01-21
257	Moura Novaes S/A PocketTV	0	664	701	2016-10-21
258	Peixoto Vieira - ME Replay	0	860	538	2020-12-18
259	Harrington, Nelson and Dominguez Universal	0	187	989	2015-07-27
260	Rezende - ME Universal	0	71	574	1998-10-17
261	Rodriguez-Williams Now+	0	775	168	2011-01-25
262	Rivera, Stevenson and Nguyen Verse	0	618	83	2025-04-28
263	Cassiano - ME PrimeTime	0	184	520	1998-04-28
264	Hubbard Inc Replay	0	383	812	2012-01-09
265	Ferguson, Nunez and Rodriguez Shows	0	300	584	2013-08-07
266	Allen, Rogers and Baker Universo	0	656	61	2025-03-13
267	Mason-Bonilla Flix	0	506	520	2005-07-15
268	Caldeira Abreu Ltda. Beat	0	844	358	1994-05-04
269	Parker, Patton and Pearson Explorer	0	657	180	2017-07-24
270	Chavez-Arroyo CinePlus	0	984	499	2001-08-27
271	Patel LLC Universo	0	557	903	1994-08-30
272	Alvarez and Sons Queue	0	805	923	2005-03-25
273	Williamson-Le Pocket	0	853	708	2019-01-31
274	Knox-Gallegos Navigator	0	326	155	2013-02-12
275	Taylor-Walton Originals	0	117	212	1990-03-24
276	Parker, Thompson and Jackson PrimeTime	0	576	147	1998-03-09
277	White-Garner Vault	0	837	960	2005-09-30
278	da Mota Andrade Ltda. Vibe	0	404	719	2003-09-28
279	Cruz, Williams and Dixon Equipe	0	467	609	2002-11-28
280	da Costa - EI Lineup	0	764	673	2023-01-08
281	Fonseca da Luz - EI Pod	0	932	692	2009-11-09
282	Quinn Inc Equipe	0	636	253	1990-09-01
283	Scott, Hayes and Warner CinePlus	0	816	471	2011-08-16
284	Barros Araújo Ltda. Atlas	0	187	714	2005-10-04
285	Manning, Thomas and Lindsey Highlights	0	675	349	2024-01-04
286	Azevedo S/A Select	0	997	911	1993-09-05
287	Hess-Miller Stage	0	683	350	2015-03-19
288	Santana and Sons Flow	0	877	675	1991-10-03
289	Soto, Owens and Bennett Cast	0	820	880	2011-01-12
290	Cassiano S.A. LoopTV	0	978	690	2006-02-06
291	Casa Grande - EI Universo	0	828	340	2018-09-11
292	Ballard Inc Prime	0	713	652	1997-08-22
293	Nogueira Freitas S.A. Studios	0	728	299	1993-12-06
294	Mendonça S/A Realm	0	728	993	1995-01-19
295	Fernandez Group Aqui	0	673	485	2016-01-22
296	Oliveira Guerra Ltda. Spotlight	0	695	119	1990-10-30
297	Barbosa Câmara S/A Lite	0	306	503	2018-01-06
298	Anderson-Johnson Live+	0	393	267	1994-08-16
299	Parker, Compton and Wood Stream	0	270	577	2001-09-09
300	Orozco Group Canal	0	624	14	2024-09-13
301	Wheeler-Robbins Replay	0	53	875	2005-09-22
302	Rosales Inc Loop	0	252	596	2025-04-29
303	Cunha Vargas S.A. Pod	0	621	591	2003-09-09
304	Kim, Williams and Carter PrimeTime	0	473	223	2019-09-01
305	Duarte Cassiano S.A. Fila	0	850	341	1993-01-29
306	Vasconcelos Rios - EI Now+	0	790	111	2019-04-02
307	Gonzalez, Chavez and Dillon Now+	0	699	942	2003-09-01
308	Gregory, Long and Ochoa Queue	0	62	196	2000-02-06
309	Mckee, Turner and Gillespie Edge	0	962	81	2008-06-29
310	Hall, Espinoza and Rodriguez CastTV	0	346	176	1990-11-28
311	Montenegro Ltda. Originals	0	701	969	2013-08-23
312	Melo Almeida e Filhos Ponto	0	44	410	2006-05-25
313	Leão Costela e Filhos Now	0	199	538	1991-11-17
314	Paul-Atkinson Loop	0	479	630	1999-02-17
315	Fletcher, Nichols and Clark Mundo	0	387	977	1992-03-29
316	Nogueira Araújo S/A Access	0	435	453	2019-06-11
317	Brown-Lopez Explorer	0	370	158	2014-11-29
318	Souza Aragão S/A Plataforma	0	559	632	2004-05-06
319	Best-Robinson PlayLab	0	639	378	2018-07-18
320	Collins, Taylor and Duran Sync	0	694	454	2024-03-01
321	Vasconcelos Siqueira S.A. Pocket	0	470	189	1999-05-24
322	Alves Jesus e Filhos Fila	0	548	548	1999-12-02
323	Mendonça Montenegro S.A. Cast	0	602	902	2001-12-06
324	da Conceição - ME Hub	0	965	823	2014-04-16
325	Mathis-Butler PlayLab	0	908	462	2022-01-06
326	Lawrence PLC Portal	0	975	637	1996-03-06
327	Ribeiro Ramos S/A Scene	0	183	97	2013-03-09
328	Alvarez, Murphy and Jones Explorer	0	194	851	2012-08-22
329	Castro das Neves - EI Go	0	234	20	2005-09-07
330	Burke, Brown and Farrell On	0	619	545	1998-03-31
331	Hudson LLC OnRepeat	0	335	65	2006-10-16
332	Ramsey-Singleton Showcase	0	466	143	2000-09-20
333	Brito Caldeira Ltda. Ponto	0	752	584	2022-06-13
334	Franklin, Good and Robinson Broadcast	0	955	543	2003-09-27
335	Martinez-Rodriguez Pass	0	961	982	1999-10-27
336	da Cunha Câmara e Filhos Crew	0	577	781	1993-02-14
337	Gonçalves S/A Access	0	842	536	2015-10-21
338	Johnston Group Pro	0	339	710	1997-11-11
339	Nelson Inc Originals	0	7	11	2020-05-16
340	Pastor Barros S/A Transmit	0	449	526	2005-05-05
341	Fonseca S/A Equipe	0	227	576	2009-05-11
342	da Rocha - EI Worlds	0	244	64	2019-09-11
343	Hernandez LLC Collective	0	953	220	2019-12-20
344	Macedo Pimenta S.A. Lite	0	956	546	2023-10-01
345	Pastor da Cruz e Filhos Station	0	457	660	2002-07-09
346	Rodriguez-Little Sync	0	385	854	2009-04-22
347	Cavalcante Duarte S/A Flow	0	935	278	1999-12-09
348	Collins-Johnson Entrada	0	437	216	2002-05-11
349	Pierce-Shepard Originais	0	603	944	2022-03-07
350	Gonzalez-Smith Mapa	0	326	123	2007-12-16
351	Middleton-Cole Originals	0	468	570	1993-05-15
352	Herring-Jones Connect	0	164	926	2002-05-19
353	Tran-Acosta PocketTV	0	595	660	2022-09-22
354	Correia Camargo Ltda. Pro	0	410	738	2007-04-18
355	Ramos - EI Equipe	0	739	762	1996-09-01
356	Almeida da Rocha e Filhos Studio	0	43	88	2006-03-27
357	Pacheco - EI Select	0	368	878	1996-10-21
358	Ryan-Marquez Groove	0	295	187	2007-05-30
359	Cochran, Walker and Smith CastTV	0	129	705	2008-09-03
360	Davila Group Pod	0	796	995	2010-09-07
361	Montenegro Pimenta e Filhos Broadcast	0	900	271	2015-05-21
362	Cervantes, Alvarez and Johnson Playground	0	570	539	2012-08-28
363	Pacheco Moreira - EI NextGen	0	236	277	1996-01-02
364	Bowen-Scott Universo	0	597	473	2002-10-07
365	Pinto e Filhos Equipe	0	45	194	2001-07-25
366	Moraes - EI Universal	0	168	50	1993-04-28
367	Pastor S.A. Vibe	0	13	881	1995-05-15
368	Macedo S/A Studio	0	586	893	2017-04-14
369	Wilkins and Sons Cine	0	588	461	2014-10-05
370	Hayes Ltd Studio	0	496	292	2009-04-13
371	Vieira Silveira S.A. Stream	0	393	791	2006-12-06
372	da Cruz Aragão - EI Collection	0	961	920	2022-01-09
373	Reid PLC Arquivo	0	440	741	2011-02-21
374	Novaes Cirino Ltda. Sincroniza	0	243	849	1992-10-09
375	Singleton LLC Palco	0	428	347	2011-04-26
376	Barros Teixeira S.A. Broadcast	0	94	753	2024-11-03
377	Watts LLC Reels	0	926	395	2025-06-09
378	Sales Pacheco - ME Atlas	0	286	796	2012-08-23
379	Sá - ME Network	0	394	403	2003-06-15
380	Tucker, Carter and Ferguson Hub	0	728	999	2009-09-15
381	Morrison Group Pass	0	663	381	2008-06-08
382	Rios Silveira S.A. Stage	0	568	162	2019-09-17
383	Machado Fogaça Ltda. Pro	0	806	278	1995-04-24
384	Pires Gomes - EI Portal	0	474	493	2023-05-23
385	Fisher Group AoVivo	0	854	343	2013-02-04
386	Smith, Simmons and Moore Cine	0	634	693	2022-09-06
387	Poole-Schultz Universal	0	471	859	2022-04-17
388	Rivera, Gonzalez and Howard Agora+	0	391	137	2003-05-27
389	Vargas Leão e Filhos Schedule	0	904	985	2023-02-17
390	da Rocha Almeida S.A. CastTV	0	373	1000	2023-03-11
391	Pastor - ME Originals	0	540	967	2010-09-02
392	da Rocha S.A. Select	0	131	580	2015-12-16
393	Martins Nascimento - EI Arquivo	0	26	532	2005-11-04
394	Aguilar-Warren Showcase	0	316	658	2022-03-30
395	Key Ltd Vibe	0	438	75	1991-12-08
396	Rocha Jesus e Filhos Access	0	14	860	2002-06-02
397	Macedo da Cunha - EI Hub	0	798	368	1997-08-25
398	Walters, Thomas and Carter Metaverse	0	256	901	2021-05-25
399	Peters-James Metaverse	0	874	929	1990-04-02
400	Aparecida Rios - ME Stage	0	322	813	2008-05-28
401	Machado S.A. Studios	0	128	487	2006-10-18
402	Lane-Jackson Prime	0	481	595	2006-08-28
403	Marsh Inc LiveStream	0	933	874	2009-08-09
404	Rezende Aragão - ME Prime	0	85	242	2017-10-29
405	Santos Barbosa S/A Highlights	0	390	375	2023-09-11
406	Cavalcante da Cruz S/A OnRepeat	0	121	790	1990-11-15
407	da Mota Rios e Filhos Future	0	884	408	1993-10-15
408	Moraes Andrade S/A Mundo	0	163	512	1990-12-26
409	Nguyen-Moore Flow	0	937	503	1998-01-20
410	Black Ltd Beat	0	631	839	2007-12-25
411	Souza Ltda. LoopTV	0	626	906	2025-06-25
412	Mcbride, Ortega and Armstrong Live	0	792	255	2018-01-23
413	Barros Leão Ltda. Stream	0	420	327	2017-06-28
414	Reynolds, Holt and Turner AoVivo	0	33	30	2017-10-19
415	Aragão - ME Stage	0	255	840	2002-08-13
416	Rios Monteiro S/A Network	0	699	794	2005-12-29
417	Novais Oliveira S.A. Arquivo	0	378	363	2009-03-08
418	Wells-Leon Showcase	0	795	941	2016-10-22
419	Fields-Saunders Lineup	0	363	398	2010-07-23
420	Robinson, Hardy and Beltran Exclusivo	0	419	799	1997-05-07
421	da Costa Duarte - ME Connect+	0	973	255	1998-07-07
422	Morris-Fisher Cine	0	111	398	1995-07-12
423	Castro Vieira e Filhos Prime	0	866	972	2022-01-04
424	Steele-Bentley Spotlight	0	905	734	2001-04-05
425	Aragão Teixeira S/A Verse	0	304	519	2009-10-17
426	Lima Macedo - ME Originals	0	425	516	2001-08-10
427	Novais Sampaio Ltda. Queue	0	63	923	2023-11-03
428	Brito Campos S/A Play	0	387	951	2015-01-01
429	Mendes e Filhos Flow	0	992	566	2018-03-29
430	Ramirez Ltd Loop	0	767	595	1990-10-04
431	Campos Nunes e Filhos Streamline	0	201	185	2007-02-23
432	Cohen-Chavez Pocket	0	338	966	1991-04-14
433	Lyons, Clark and Miller Connect	0	85	60	2011-09-21
434	Novaes Monteiro S/A OnRepeat	0	702	731	1998-01-05
435	Adkins, Hansen and Guzman Scene	0	908	86	2006-12-25
436	Hill and Sons Collective+	0	138	428	2014-05-10
437	Sampaio S/A Mini	0	821	142	2017-07-10
438	da Mota e Filhos Flow	0	169	522	2011-11-12
439	Nascimento Moraes - ME Live	0	528	358	1995-12-13
440	da Paz Porto S.A. Flix	0	996	405	2002-11-01
441	Calhoun-Williams Spotlight	0	434	841	1998-07-15
442	Pacheco e Filhos Exclusivo	0	831	260	2024-04-11
443	Riley-Becker Ponto	0	257	856	2011-09-01
444	Hatfield Group Air	0	917	919	2005-03-22
445	Morgan, Knight and Best Plus	0	333	546	2008-05-07
446	Andrade e Filhos Equipe	0	119	433	2020-02-22
447	Duncan and Sons Pocket	0	638	333	2013-12-19
448	Sanchez, Dominguez and Wolfe Ritmo	0	216	747	2021-04-17
449	Costela - EI Vibe	0	534	859	1993-04-04
450	Pinto Moura - EI Pocket	0	497	118	2002-02-24
451	Gomes Gomes Ltda. Navigator	0	986	608	2020-06-29
452	Moreira da Mata - EI Plataforma	0	130	22	2007-05-14
453	Leão Rocha S/A Cine	0	886	955	2021-01-22
454	Mendes Campos Ltda. PrimeTime	0	335	89	1993-11-18
455	Myers-Holmes On	0	177	83	1995-11-19
456	Rezende Sousa - EI Play	0	631	431	2016-10-08
457	Tran, Collins and Smith Station	0	195	392	1998-10-20
458	Perez, Rivera and Garza Exclusive	0	812	836	2023-12-08
459	Marques S/A OnRepeat	0	285	271	2022-03-11
460	Siqueira - ME CinePlus	0	834	497	1991-02-04
461	Daniels-Curry Originals	0	886	233	2011-03-24
462	Clark LLC Ir	0	386	523	1997-05-13
463	Day-Kelley Mundo	0	553	293	2011-04-27
464	Leão Lima S/A Air	0	10	72	2017-02-18
465	Pinto Jesus - EI Entrada	0	771	645	2009-11-06
466	Rush, Massey and Steele Replay	0	721	51	2002-02-21
467	Friedman Group PocketTV	0	594	172	1998-02-21
468	Davis-Powell Ir	0	142	452	2024-07-08
469	Teixeira Ltda. Atlas	0	484	241	2003-03-08
470	Gonçalves da Paz - ME Live	0	169	748	2001-06-13
471	Camargo Porto S.A. Metaverse	0	284	4	1990-10-02
472	Miller LLC Universe	0	599	460	2007-09-28
473	Abreu - EI Ritmo	0	333	455	1998-10-30
474	Potter, Brady and Kim Schedule	0	235	64	2013-02-21
475	Jones Ltd Broadcast	0	123	47	1992-06-19
476	Câmara Lopes - EI Highlights	0	630	51	2002-01-24
477	Correia - ME Ponto	0	573	494	1993-12-12
478	Teixeira Peixoto - ME PrimeTime	0	134	827	2022-06-15
479	Fitzgerald-Thomas NextGen	0	313	813	1997-05-28
480	Mcbride, Thomas and Wilson Aqui	0	302	743	2001-11-15
481	Taylor LLC Play	0	448	102	2013-02-07
482	Sullivan LLC Live+	0	83	12	2001-09-14
483	Reeves PLC Ritmo	0	905	810	2019-04-07
484	Vaughan PLC Mais	0	741	559	1995-02-28
485	da Costa Novaes - ME Streamline	0	485	502	2009-04-20
486	Câmara Rezende S/A Portal	0	911	976	2016-03-01
487	Rosales-George Navigator	0	893	103	2010-08-24
488	Azevedo - EI Live	0	957	527	1994-06-12
489	Câmara S.A. Collective+	0	170	188	2001-11-26
490	Nogueira Silveira S.A. Entrada	0	98	923	2015-05-04
491	Sanford-Bryan Worlds	0	302	952	2019-12-18
492	Lewis, Ryan and Bailey Connect+	0	366	346	2011-05-14
493	Warren Group Play	0	896	437	2012-09-06
494	Skinner-Price Studio	0	659	642	1996-08-18
495	Luna PLC Loop	0	67	385	1995-09-01
496	Machado Fogaça - EI Arquivo	0	988	101	2022-11-23
497	Marques Novais S/A Library	0	563	553	2000-03-18
498	Benson and Sons Access+	0	431	200	1994-06-04
499	Caldeira S.A. Broadcast	0	359	949	1998-06-12
500	Jesus Correia e Filhos Schedule	0	756	382	2018-08-30
501	Jesus Oliveira - EI Mais	0	282	677	2024-05-16
502	Hopkins, Brewer and Riddle Broadcast	0	637	528	2000-07-18
503	Perry-Allen Studios	0	660	148	2015-01-30
504	Duncan, Kelly and Moore Exclusivo	0	576	758	2005-05-16
505	Pastor Marques - EI Loop	0	672	811	2023-06-01
506	Mccarty-Turner Worlds	0	275	734	1994-10-23
507	Ribeiro - EI Explorer	0	712	560	2001-08-06
508	Mcneil, Cook and Banks Mini	0	15	772	1992-11-24
509	Pinto Ramos - ME Ponto	0	228	561	2005-07-02
510	Pittman, Moyer and Morrow Live+	0	804	277	2003-04-15
511	Dias S/A Reels	0	564	885	2008-01-05
512	Rios Dias e Filhos LiveStream	0	266	224	2006-11-09
513	Andrade Araújo - ME Gate	0	623	563	2020-11-05
514	Castro Ltda. Live	0	515	708	1993-11-16
515	Rezende Costa S/A Fila	0	407	807	1998-06-10
516	Olson, Reese and Hunter LoopTV	0	537	815	2000-05-05
517	Crawford-Dougherty NextGen	0	813	659	2010-06-19
518	Montenegro Rodrigues S/A Entrada	0	303	422	2008-01-10
519	Cunha e Filhos Reel	0	101	367	2010-10-12
520	Vasconcelos das Neves e Filhos LoopTV	0	687	837	2003-10-22
521	Cavalcanti Souza S.A. Shows	0	467	448	2004-02-07
522	Brooks, Wallace and Hansen Atlas	0	368	519	1997-06-21
523	Stout Ltd Premium	0	550	98	2014-10-26
524	Fogaça Freitas e Filhos NextGen	0	881	136	2017-08-13
525	Walker-Hunter Showcase	0	36	261	2013-07-08
526	Castro, Cameron and Grant Scene	0	818	136	2000-04-15
527	Hartman Ltd Flow	0	537	581	1999-06-05
528	das Neves Ltda. AoVivo	0	278	232	2002-12-17
529	Barron LLC LoopTV	0	827	12	1995-09-21
530	Daniel-West Library	0	235	847	2006-08-15
531	Evans Ltd Agora+	0	897	732	2006-06-13
532	Garcia Moreira S/A Explorer	0	326	822	2018-07-06
533	Barrera-Bailey Filmes	0	519	198	2006-04-23
534	Jones-Taylor Exclusive	0	799	325	2004-10-14
535	Moura Gonçalves Ltda. Station	0	195	73	2021-02-12
536	Schwartz Ltd Plataforma	0	988	410	2023-10-21
537	Sampaio Pinto S/A Connect	0	904	133	1999-04-07
538	Austin, Ball and Reed Navigator	0	202	1	1997-12-08
539	Câmara da Cruz e Filhos Vault	0	761	652	1999-01-20
540	Rojas-Fox Onda	0	345	783	1995-02-22
541	Cirino Ltda. Equipe	0	181	968	2003-05-13
542	Gonçalves Cunha S/A Exclusivo	0	402	243	2008-01-31
543	da Paz Ltda. Pro	0	702	404	1993-06-21
544	Rogers, Martin and Moreno Crew	0	766	128	1993-04-02
545	Farias Moraes Ltda. Crew	0	684	929	2006-06-20
546	Marquez-Lyons Pass	0	36	46	2006-09-09
547	Souza - ME Aqui	0	263	113	1993-11-14
548	Sampaio S.A. Hub	0	104	46	2022-07-11
549	Jesus Costela - ME Scene	0	476	752	1999-02-07
550	Aragão e Filhos PocketTV	0	525	391	2022-12-13
551	Ellis, Choi and West Onda	0	963	152	2023-05-17
552	Abreu Costela S.A. Mapa	0	341	348	2020-12-23
553	Pacheco Fogaça - ME Exclusivo	0	58	488	2014-03-24
554	Hunt, Mendez and Jimenez Direct	0	606	223	2021-06-16
555	Carvalho Câmara - ME Pod	0	284	674	2008-02-28
556	Oliveira S/A Collective+	0	248	680	2019-07-26
557	Novaes e Filhos Exclusivo	0	800	657	2002-07-22
558	Henry-Brown Explorer	0	321	517	2012-04-08
559	Pires - EI Future	0	973	948	2000-11-14
560	Pinto Pinto S/A Filmes	0	370	59	2017-08-02
561	Pratt, Ellis and Esparza Pro	0	708	872	2007-04-16
562	Silveira e Filhos Palco	0	12	855	2014-01-10
563	Silva Nogueira e Filhos Spotlight	0	215	30	2024-12-06
564	Vasconcelos Araújo - ME Entrada	0	77	88	2013-08-05
565	Carvalho Fernandes S/A Universo	0	444	558	1994-06-24
566	James-Matthews Broadcast	0	479	555	2012-11-19
567	Fogaça Caldeira S.A. Replay	0	616	507	2011-05-13
568	Everett, Baker and Lindsey Queue	0	561	18	1994-06-26
569	Brown PLC Edge	0	643	280	2007-02-04
570	Jesus S.A. Ponto	0	417	857	2018-01-21
571	Moura Nogueira - ME Palco	0	21	835	2007-01-19
572	Parks-Martin Palco	0	156	138	1999-04-20
573	Miller-Allen Radio	0	52	466	1990-12-21
574	Rice Group Plus	0	711	766	2001-06-22
575	Stephens, Wolfe and Arroyo Go	0	156	934	2018-10-03
576	Kaiser, Vasquez and Clark Gate	0	293	99	2019-11-05
577	Hill, Miller and Marks Loop	0	645	312	2015-10-08
578	Brown-Sullivan Streamers	0	742	522	2014-04-01
579	Mendes Fogaça S.A. Highlights	0	188	596	2022-01-09
580	Arroyo-Lewis Queue	0	557	817	2021-11-27
581	Pires - ME Mini	0	504	944	2023-04-08
582	Reeves-Harrison Network	0	508	322	2010-12-19
583	Farias Cassiano - EI Universo	0	266	479	2006-03-24
584	David, James and Brown Stage	0	617	906	2004-11-10
585	Ferreira - ME Scene	0	672	962	1992-11-21
586	Tanner and Sons Connect	0	993	741	2006-12-13
587	Fernandes S/A Realm	0	241	88	2021-08-27
588	Vargas - EI AoVivo	0	273	988	2016-08-28
589	Fernandez-Webb Shows	0	360	316	2000-03-08
590	das Neves Sampaio - EI Worlds	0	163	604	2011-07-15
591	West LLC Streamers	0	716	28	1997-01-12
592	Vasquez-Walker Gate	0	11	277	2016-10-25
593	Cassiano da Mata - EI Broadcast	0	992	103	2000-07-24
594	Cavalcanti Fernandes S.A. Vibe	0	559	4	2002-10-23
595	Cardoso e Filhos Filmes	0	150	728	1994-10-22
596	Parsons, Petersen and Holland Reels	0	985	999	2013-04-09
597	Novais Nunes S.A. Pass	0	746	751	2024-08-20
598	Frederick-Beck Beat	0	462	846	1996-09-22
599	Taylor-Powers Fluxo	0	288	632	1993-07-22
600	Montenegro Pires - ME HoraNobre	0	524	795	2018-09-28
601	Costa Ltda. Library	0	609	895	2016-02-29
602	Monteiro - ME Onda	0	782	94	2013-03-30
603	Armstrong-Hull Realm	0	37	364	2019-10-13
604	Anderson and Sons Collection	0	505	166	2004-04-28
605	Rios S.A. Universal	0	22	871	1991-05-17
606	Yates-Potts Flow	0	880	981	1990-12-12
607	Henry and Sons Groove	0	505	751	2010-03-21
608	Nogueira Pinto Ltda. Hub	0	365	611	2012-10-05
609	Wright, Weber and Walker Ritmo	0	463	365	2018-08-15
610	Hood-Perez Access+	0	474	524	2023-12-22
611	Short, Hansen and Hebert Premium	0	991	620	2009-02-28
612	Delgado PLC Ritmo	0	931	841	1994-05-07
613	da Rosa Araújo e Filhos Reels	0	613	835	2019-01-03
614	White-Zimmerman Pass	0	215	472	1997-04-08
615	Vega, Hernandez and Martin Plataforma	0	647	173	2002-01-22
616	Hamilton-Hobbs Collective	0	965	82	2014-02-01
617	Moraes Ltda. Pod	0	452	477	2024-04-02
618	Diaz, Patel and Tyler Universal	0	992	624	2021-12-29
619	Hernandez-Reyes Vault	0	754	699	2006-05-18
620	Rodrigues Mendes S/A Mini	0	243	839	2000-05-07
621	Key Group Entrada	0	861	323	2025-10-22
622	da Mota Pastor Ltda. Radio	0	59	551	2016-12-09
623	Vieira Porto Ltda. Atlas	0	860	428	1991-11-17
624	Castro Farias e Filhos Streamline	0	914	732	2023-03-11
625	Freitas S.A. Now	0	57	649	2024-11-13
626	Wright-Howe Studio	0	286	108	1994-04-07
627	Peixoto Barros e Filhos Select	0	199	605	2017-07-22
628	Rodriguez LLC Shows	0	264	392	2002-11-13
629	Peterson Ltd Mais	0	551	427	2009-04-03
630	Webb-Mooney Sync	0	684	378	1997-04-23
631	Martins S.A. Collection	0	485	130	2020-03-20
632	Cavalcanti Brito S/A Live+	0	110	781	2023-12-22
633	Wilkinson-Martin Connect+	0	53	487	2021-05-14
634	Hill, Cohen and Rogers Reels	0	383	683	2021-01-16
635	Ross and Sons Navigator	0	604	334	2017-07-14
636	Haynes-Butler Pro	0	420	438	2021-02-16
637	Pruitt-Watson Ir	0	758	807	1999-01-10
638	Azevedo Melo - EI Studio	0	644	574	1993-04-14
639	Thompson, Dean and Phillips CinePlus	0	180	99	2024-01-19
640	Pratt, Robinson and Vargas Box	0	152	564	2024-06-19
641	Dennis LLC Mundo	0	611	672	1990-09-15
642	Brito Almeida Ltda. NextGen	0	466	575	2024-12-10
643	Chen, Myers and Collins Connect	0	767	819	2007-08-25
644	Mcmahon PLC Worlds	0	430	940	2000-10-22
645	Vargas Nascimento - ME Canal	0	988	669	1998-09-07
646	Martins Nascimento Ltda. Universo	0	562	3	2021-03-31
647	Hawkins, Simmons and Johnson Metaverse	0	311	419	2017-07-11
648	Ribeiro - ME Mini	0	45	885	2002-08-14
649	Ferreira S.A. Groove	0	98	437	2003-11-12
650	Rich Inc Future	0	841	385	1994-01-28
651	Russell, Peters and Jones Connect	0	134	825	2005-07-17
652	Henry-Turner Universe	0	324	639	2021-08-04
653	Hogan, Wong and Hayes Highlights	0	308	411	2002-10-15
654	Silva - EI Select	0	82	753	2001-12-14
655	Harris LLC Collection	0	556	502	1992-05-06
656	Garcia da Mota - ME Verse	0	117	187	1999-08-17
657	Murray, Winters and Bradley Groove	0	788	143	1999-10-31
658	Dias Moura - ME Hub	0	40	278	2012-12-26
659	Mcdowell, Torres and Mcgee Fila	0	901	364	2003-12-24
660	Melo - EI Sincroniza	0	823	114	2001-01-26
661	da Cunha S/A Mapa	0	403	950	1991-04-18
662	Diaz-Perez On	0	909	885	2020-04-09
663	Oliveira Ltda. Canal	0	55	559	1999-09-16
664	Howard, Wilson and Meadows Worlds	0	422	644	2003-05-12
665	Nunes Oliveira S.A. Channel	0	170	49	2018-01-23
666	Garcia Pires e Filhos Agora+	0	287	43	2012-01-08
667	Camargo Ltda. Exclusivo	0	737	606	2015-12-13
668	Moraes e Filhos Agora+	0	925	34	2012-05-19
669	Rodriguez-Palmer Box	0	742	361	2018-07-26
670	Campos Correia S.A. HoraNobre	0	397	207	2016-08-23
671	Ferrell-Pierce Go	0	848	982	2012-09-14
672	Cross, Williams and Chapman Network	0	95	786	2018-01-18
673	Macedo Casa Grande Ltda. Stage	0	661	966	2008-02-17
674	Rios Ferreira e Filhos Shows	0	978	482	2006-10-02
675	Nelson, Bennett and Miller Hub	0	76	162	1992-04-13
676	Albuquerque Ramos Ltda. Shows	0	450	758	1997-04-21
677	Peixoto - ME Mundo	0	80	602	2014-10-14
678	Sherman Ltd Hub	0	349	149	2009-12-28
679	da Rocha Oliveira S/A Stage	0	225	557	2020-03-07
680	Wells Group Edge	0	979	825	2014-03-06
681	Aparecida Fogaça S/A CastTV	0	45	172	2008-01-16
682	Nguyen-Reeves Showcase	0	679	98	1995-04-11
683	Macias, White and Meyer Equipe	0	41	74	1995-02-11
684	Contreras, Beck and Price Ir	0	172	584	2000-02-09
685	Nunes Ltda. Hub	0	632	873	2004-09-27
686	Ramos Cavalcanti Ltda. LiveStream	0	514	333	2016-01-16
687	Espinoza-Blankenship Mini	0	29	744	2003-05-15
688	Sousa - EI LoopTV	0	427	176	2025-03-21
689	Jones, Knapp and Garcia Portal	0	946	283	1992-05-22
690	Braun-Gibson Channel	0	314	551	2024-09-18
691	Andrade Rocha S.A. Scene	0	478	968	1992-10-14
692	Ribeiro Alves S.A. Reel	0	962	374	2018-08-05
693	Harvey Inc Lineup	0	784	850	2024-02-17
694	Porto Cavalcante - ME Pro	0	121	852	1990-10-04
695	Mendes - ME Sync	0	742	707	2014-11-14
696	Cavalcante Rezende e Filhos Spotlight	0	207	491	1992-09-07
697	Boyer-Davis Studios	0	657	169	1997-08-31
698	Adkins LLC Universal	0	451	489	2015-03-02
699	May LLC Mapa	0	944	572	2004-03-30
700	Nelson-Hall Play	0	583	73	2015-03-11
701	Ferreira Abreu e Filhos Pass	0	875	54	2021-08-18
702	Macedo Gomes - ME Ponto	0	789	884	2004-12-12
703	Flynn-Butler Agora+	0	745	616	2014-03-30
704	Robertson and Sons Collective	0	568	97	2001-11-14
705	Marques Fernandes S/A Aqui	0	622	202	1999-10-29
706	Sweeney-Blackwell Lite	0	133	241	2011-03-20
707	Correia S.A. Canal	0	960	482	1998-06-08
708	Williams-Gutierrez Library	0	258	894	1997-08-10
709	Cavalcanti Sousa S/A Realm	0	581	204	2006-05-26
710	Castro Pinto e Filhos Studios	0	879	772	2017-07-28
711	Buck, Carrillo and Vega Reels	0	155	40	1994-05-02
712	Araújo Pimenta S.A. Cinema	0	283	241	2009-10-28
713	Taylor, Osborne and Fisher Play	0	404	32	2021-07-19
714	Leão Ribeiro S/A CastTV	0	205	776	2022-08-30
715	Johnson-Dixon Groove	0	798	655	2006-07-22
716	Lang Ltd Streamline	0	945	348	1995-03-20
717	Pereira Borges - ME Exclusivo	0	845	82	2011-07-11
718	Gutierrez, Jackson and Johnson Metaverse	0	946	479	2001-04-18
719	Fernandes Ltda. Beat	0	56	113	1996-06-08
720	Porto - ME CinePlus	0	44	183	2018-07-31
721	Barrera, Reed and Henry Channel	0	800	53	2010-12-13
722	Gonçalves Pinto S/A Mini	0	746	963	2004-01-06
723	Lawrence-Serrano Play	0	740	657	2012-08-03
724	Zavala Inc Cine	0	117	152	2011-01-14
725	da Rosa e Filhos Streamers	0	460	298	2022-12-31
726	Azevedo Ferreira Ltda. Mini	0	520	436	2002-07-07
727	Ballard, Deleon and Malone Shows	0	514	451	1993-05-07
728	Rios Lopes S/A Cine	0	334	800	2007-05-23
729	Borges - EI Library	0	155	797	2000-01-23
730	Azevedo Fogaça - ME Network	0	744	950	2011-06-14
731	Oliveira Novaes Ltda. Pro	0	1000	880	1999-04-14
732	Hernandez-Dickerson Vault	0	842	870	1991-08-19
733	Garcia Gomes Ltda. Next	0	161	462	1996-05-26
734	Graham, Howell and Taylor Lineup	0	141	952	2022-08-02
735	Novais da Rocha Ltda. Entrada	0	830	375	2007-12-29
736	Costa S/A PocketTV	0	534	655	1992-10-21
737	Torres, Lowe and Brown Spot	0	886	863	2013-08-28
738	Oliveira Caldeira S.A. Wave	0	568	941	2007-02-25
739	Scott, Clark and Tapia Schedule	0	142	386	1992-02-03
740	Velasquez Ltd Pocket	0	670	903	2018-11-01
741	Gonzalez-Nguyen Originais	0	760	511	2014-06-03
742	Holder-Davis Channel	0	922	640	2013-01-11
743	Pacheco Souza S/A Entrada	0	783	319	2024-09-25
744	Costa Fonseca e Filhos Library	0	840	937	2009-10-13
745	Barrett and Sons Direct	0	193	980	1992-05-21
746	Porto Rodrigues - ME Now+	0	174	91	1998-06-06
747	Peixoto Pimenta S.A. Exclusive	0	627	478	1992-06-30
748	Rocha Ltd Portal	0	302	234	2007-12-06
749	King, Dudley and Herrera Ponto	0	663	409	2021-09-04
750	Pires Cavalcante S.A. Mundo	0	733	401	2023-11-02
751	Barbosa Machado e Filhos Portal	0	116	78	1999-11-19
752	Contreras, Conner and Thompson Streamline	0	510	617	2002-08-05
753	da Conceição Ribeiro S.A. Flix	0	729	860	2009-03-26
754	Melo e Filhos PocketTV	0	492	266	1991-10-06
755	Miles, Caldwell and Guerra Mais	0	787	921	2013-06-11
756	Pacheco Almeida S.A. Station	0	499	659	2001-03-05
757	Ramos Viana - ME Studio	0	906	520	2007-02-22
758	Johnson, Miller and Rivers LoopTV	0	815	862	2006-10-29
759	Campos Campos e Filhos Showcase	0	609	926	2013-03-06
760	Freitas e Filhos Exclusive	0	923	330	2017-05-07
761	Teixeira Peixoto - EI Pocket	0	408	232	2008-08-26
762	da Luz S/A Agora+	0	659	560	2019-08-07
763	Barnes Ltd Arquivo	0	307	451	2020-03-05
764	Camargo Cunha S.A. On	0	699	262	2001-04-04
765	Bruce, Wilson and Gonzales PocketTV	0	168	846	1998-10-17
766	Snyder, Anderson and Thomas Access+	0	523	531	2022-01-01
767	Nelson-Mitchell Queue	0	170	861	2020-12-05
768	Aragão Câmara S.A. Reel	0	621	472	1993-09-18
769	Pacheco Borges S/A Onda	0	449	830	2001-03-05
770	Cavalcanti da Cunha e Filhos Mini	0	336	388	2016-10-19
771	Santos Ltda. Streamline	0	655	509	2000-07-29
772	Ferguson and Sons Channel	0	805	105	1993-05-04
773	Siqueira Nascimento e Filhos OnRepeat	0	963	698	2005-01-24
774	Cassiano Ltda. Access+	0	745	408	2012-10-21
775	Marsh and Sons Go	0	722	501	1994-09-25
776	Correia Rios - ME PrimeTime	0	617	258	2003-06-01
777	Rivas Ltd Hub	0	280	224	1998-02-01
778	Silveira Aparecida - EI Realm	0	580	869	2015-08-06
779	Cruz, Cervantes and James Radio	0	458	257	1996-10-19
780	Morales, Spencer and Morgan Mais	0	342	797	2021-12-31
781	Cannon-Williams Next	0	277	591	2009-02-12
782	Sampaio Ltda. Spot	0	476	551	1998-11-24
783	Dias Silveira - ME Future	0	448	303	1991-08-05
784	Dodson and Sons Explorer	0	167	869	2020-08-31
785	Cavalcanti Silveira S.A. On	0	928	806	1994-03-18
786	Lucas Group Atlas	0	588	437	2008-10-05
787	Ramos-Miller AoVivo	0	470	977	2010-01-04
788	Garcia-Young Queue	0	790	47	2024-12-06
789	Caldeira Garcia S.A. Direct	0	696	681	2001-01-23
790	Jenkins-Jackson Flow	0	119	631	2025-03-02
791	Green-Ryan PlayLab	0	57	606	2008-08-01
792	da Conceição Guerra - EI Pass	0	692	874	1992-04-27
793	da Mota - ME Studios	0	672	948	2023-11-27
794	Carvalho e Filhos Universo	0	87	852	2005-06-25
795	Edwards, Nguyen and Smith CastTV	0	685	18	2011-03-01
796	Cirino Cassiano e Filhos Portal	0	706	454	2014-01-28
797	Pinto Mendes e Filhos Edge	0	571	49	2018-05-25
798	Casa Grande Monteiro Ltda. Gate	0	265	740	1996-04-09
799	Davis-Gonzalez Entrada	0	133	236	2007-11-11
800	Santos Azevedo S.A. Cast	0	455	55	2019-04-11
801	Borges S.A. Live	0	219	449	2005-06-29
802	Farias e Filhos Lite	0	264	841	1991-10-03
803	Johnson-Lewis Live	0	665	560	2013-08-01
804	Williams-Terry OnRepeat	0	603	477	2015-05-29
805	Macdonald Ltd Originais	0	142	194	1999-10-06
806	Burton-Conway Ponto	0	330	966	2001-08-10
807	White-Goodman Explorer	0	481	648	1996-09-06
808	Vieira S/A Studio	0	6	623	2005-05-08
809	Barbosa Rezende S/A Cinema	0	60	668	2001-06-22
810	Cassiano e Filhos Spot	0	467	797	2004-10-16
811	Reynolds-Rivas Filmes	0	607	991	2007-04-10
812	Barros - ME Showcase	0	727	577	2022-12-10
813	Powell-Hernandez Spot	0	341	729	2007-04-20
814	Freitas Nunes Ltda. Streamline	0	356	53	2011-01-20
815	da Luz Aragão Ltda. Ponto	0	846	840	2014-08-10
816	Ribeiro Correia S.A. Plataforma	0	95	449	2013-11-04
817	Cunha Borges - EI PlayLab	0	811	204	1996-03-31
818	Oliveira Cavalcante S/A Prime	0	248	865	2010-12-12
819	Abreu e Filhos LoopTV	0	875	585	2000-12-18
820	Tucker, Simpson and Acevedo Sync	0	869	422	1998-09-24
821	Rodrigues Macedo Ltda. Flow	0	768	135	2012-01-12
822	Harper, Rice and Haynes Verse	0	2	44	2023-07-12
823	Câmara Macedo - ME PocketTV	0	13	31	1995-11-14
824	Machado e Filhos Collective	0	670	766	2025-06-18
825	Ribeiro Pastor - EI PlayLab	0	163	844	1992-02-23
826	Siqueira Ribeiro e Filhos Gate	0	545	887	1998-01-27
827	Costela Leão S/A Studios	0	885	160	2023-07-10
828	Campos Pereira - EI Flow	0	555	838	2001-06-12
829	Carvalho Montenegro S/A Onda	0	848	48	2016-12-25
830	Ramos - ME Universe	0	77	540	2018-04-05
831	Larsen Ltd Beat	0	682	727	2022-09-08
832	Wu and Sons Wave	0	365	292	2007-05-15
833	Carlson, Jensen and Patterson Reel	0	220	14	1992-10-24
834	Santos Farias e Filhos Plataforma	0	921	536	1990-11-10
835	Garcia Campos - ME Navigator	0	478	735	2003-03-05
836	Jordan, Brown and Manning Palco	0	643	117	1999-04-17
837	da Rocha Albuquerque - EI Air	0	171	709	2015-11-01
838	Rodgers-Carter Studio	0	877	979	2020-05-16
839	Freitas Moreira - ME Now	0	542	690	1993-03-29
840	Gibbs, Hunt and Franklin Universo	0	566	287	2013-07-15
841	Melo Cunha S/A Next	0	684	736	2020-07-05
842	Correia Ltda. Universo	0	40	910	1995-04-17
843	Pires S/A Streamers	0	640	395	2013-07-23
844	Sales S.A. Reel	0	654	237	2010-06-07
845	Cardenas-Nichols Station	0	324	151	2007-03-29
846	Albuquerque S.A. Stream	0	304	210	2011-02-26
847	Rios Duarte - ME Sincroniza	0	482	406	2010-01-10
848	das Neves Casa Grande Ltda. CastTV	0	647	786	2013-07-02
849	Vargas da Mota Ltda. Access+	0	599	915	2024-05-31
850	Bennett-Castro Sincroniza	0	730	162	1997-03-07
851	Durham-Vargas Pro	0	622	196	1998-07-27
852	Rocha Câmara S/A Verse	0	320	52	1995-03-17
853	Ramos Vieira S.A. Next	0	436	335	2019-03-25
854	Costela Macedo S/A Hub	0	645	147	2015-04-23
855	Cox Ltd Radio	0	777	816	2022-12-25
856	da Paz S/A Queue	0	143	498	1994-04-01
857	Moon-Lopez Fila	0	561	392	1996-03-13
858	King, Marshall and Jackson Scene	0	315	591	2015-01-22
859	Ferreira Abreu - EI Ponto	0	628	570	1994-12-14
860	West Ltd CastTV	0	456	376	2025-06-04
861	Costa, Cummings and Gordon Aqui	0	928	253	2014-10-27
862	Hall, Schaefer and Acevedo LoopTV	0	1000	416	2018-01-02
863	Thompson, Ingram and Wood LiveStream	0	164	345	2005-10-25
864	Lyons-Hernandez Equipe	0	537	490	2023-07-03
865	Garcia Novaes S/A Aqui	0	794	589	2011-12-04
866	Almeida Fernandes Ltda. Playground	0	151	394	2023-05-08
867	Perez-Martinez Broadcast	0	728	846	1997-12-19
868	Barbosa - ME Groove	0	767	371	2025-06-10
869	Nicholson-Wallace Streamline	0	652	162	1998-09-18
870	Pinto Santos S/A Shows	0	154	517	2004-05-15
871	Lopes - EI Air	0	913	886	2011-04-28
872	Harper, Schwartz and Jenkins Sincroniza	0	725	426	2010-01-02
873	Chavez PLC Crew	0	769	181	2015-04-26
874	Cardoso Gonçalves e Filhos Streamline	0	559	386	2017-11-28
875	Souza da Cunha - ME Vault	0	830	583	2014-09-05
876	Rangel-Rogers Collective	0	854	193	2003-01-12
877	Grimes LLC Studios	0	454	834	2018-07-07
878	Brown, Jennings and Roach Vibe	0	912	998	1998-11-16
879	Sanchez, Webb and Harris Originais	0	747	780	1990-08-16
880	Dawson and Sons Stream	0	523	247	2017-05-09
881	Cox PLC Entrada	0	581	187	2007-02-01
882	Lopez, Fox and Shaw Ir	0	527	335	2006-11-13
883	Valenzuela, Wilson and Burgess Portal	0	359	776	2024-09-26
884	Martin-Mosley Showcase	0	9	732	1994-02-14
885	Carlson, Love and Foster Groove	0	906	567	1995-03-09
886	Reilly, Clay and Wall Streamers	0	853	382	2021-06-20
887	Bernard-Higgins Palco	0	931	904	2021-09-17
888	Murray, Ruiz and Mueller Vibe	0	74	826	2022-11-03
889	Houston Ltd Queue	0	672	865	1997-05-11
890	Garrison, Horne and Webb Prime	0	343	436	1990-01-01
891	Nascimento Porto S/A Radio	0	392	563	1997-05-28
892	Albuquerque Lopes S/A Explorer	0	985	956	2015-04-09
893	Aparecida S.A. Portal	0	90	708	2010-07-11
894	Nunes - EI Broadcast	0	747	147	2001-01-07
895	Brito S/A CinePlus	0	908	536	2019-08-06
896	Jones, Ewing and Garcia Aqui	0	928	381	2022-08-31
897	Hernandez PLC Loop	0	353	741	2023-03-14
898	Duarte Aparecida - EI Radio	0	12	298	1996-11-07
899	George-Booth Access+	0	664	325	2018-05-11
900	da Cruz Mendonça Ltda. Now+	0	599	421	2025-10-24
901	Rios Ltda. On	0	846	277	2016-05-06
902	Alvarez, Moore and Holder Now+	0	33	381	2015-09-23
903	Harrison-Stevens Universe	0	871	452	2021-07-03
904	Contreras LLC AoVivo	0	449	921	2013-12-22
905	Caldeira Carvalho - EI On	0	712	167	2016-01-28
906	Frost Inc Verse	0	391	671	2015-11-10
907	Martinez Group Atlas	0	687	766	1990-12-07
908	Nascimento - ME Collective	0	310	927	2001-08-28
909	Murray, Phillips and Allen Agora+	0	86	928	2017-11-26
910	da Mota Borges - EI Equipe	0	104	258	1998-10-13
911	Santos e Filhos Atlas	0	507	818	2014-05-20
912	Bautista, Barnes and Lang HoraNobre	0	148	412	1997-03-13
913	Jackson Ltd Crew	0	626	683	2021-05-01
914	Ortiz, Gross and Williams Lineup	0	914	721	2000-01-12
915	Sá da Luz - EI PrimeTime	0	885	503	2002-01-01
916	da Luz Ltda. HoraNobre	0	832	366	2000-11-02
917	Oliveira da Costa S.A. Exclusive	0	138	3	1990-11-17
918	Santos-Holmes Universe	0	588	658	2024-05-27
919	Garcia Group Cast	0	596	298	2012-09-02
920	Waller-Macdonald Streamline	0	28	516	1993-03-24
921	Flowers, Conrad and King Live+	0	541	649	2017-08-03
922	Silva Cunha Ltda. Gate	0	915	794	2002-05-11
923	Patterson and Sons Channel	0	805	660	1998-03-03
924	Barbosa - EI Groove	0	362	47	1993-10-30
925	Alves e Filhos Universal	0	173	682	2025-06-24
926	Brooks-Hanson Onda	0	808	207	2002-03-16
927	da Mata Ltda. Explorer	0	779	161	1990-03-02
928	Pham, Harris and Miller Plus	0	183	195	1995-10-23
929	Rocha Siqueira S.A. Ponto	0	460	215	2019-08-18
930	Teixeira Moraes S.A. Pro	0	739	410	2009-05-24
931	Castro Campos S/A Vault	0	894	734	2024-06-26
932	Cowan-Watson Aqui	0	455	180	2013-06-10
933	Carvalho Nascimento - ME Metaverse	0	552	647	2009-02-13
934	Harris-Richards Universe	0	61	430	2025-09-22
935	Olson, Rich and Wood Portal	0	809	556	2007-07-18
936	Austin-Reyes Play	0	568	811	2006-03-07
937	Gonçalves e Filhos Verse	0	952	30	1990-09-29
938	Parker-York Live+	0	39	343	1990-08-08
939	Costela Gonçalves - ME Cast	0	890	405	2004-04-03
940	Gibson, Sanchez and Martin Lineup	0	703	887	2005-07-02
941	Wu-Hawkins Collective	0	915	86	2002-01-20
942	das Neves Jesus - EI Collective	0	132	838	2006-06-23
943	Foster, Peterson and Mccoy Prime	0	260	970	2012-11-09
944	Pratt PLC Station	0	482	863	2014-11-02
945	Santos - ME Replay	0	342	724	1996-03-20
946	Costela Vieira Ltda. Ritmo	0	281	84	1993-10-11
947	Mendes Santos - EI Spot	0	178	54	2007-08-26
948	King and Sons Exclusivo	0	827	410	2017-07-24
949	Moura Ltda. Stage	0	422	808	2015-01-23
950	Duncan Ltd Hub	0	165	879	2018-10-09
951	Sá Vargas S/A CinePlus	0	595	667	1998-09-17
952	Terrell, Sanchez and Long Schedule	0	29	89	2000-05-15
953	Shaffer, Berry and Berry Hub	0	457	683	1990-12-07
954	Hayes, Zuniga and Smith Station	0	431	52	2022-08-08
955	Sousa Cavalcante S/A Universo	0	649	232	2009-12-02
956	Ramos LLC Schedule	0	652	420	1999-07-02
957	Bruce, Wright and Wilson Mini	0	334	811	2016-01-24
958	Craig PLC Exclusive	0	713	616	2005-06-14
959	Reid and Sons Vibe	0	388	724	2002-06-21
960	Fogaça Fogaça S.A. Reel	0	94	805	2005-07-10
961	Nguyen-Horn Explorer	0	607	353	1999-01-18
962	Moore, Dunn and Luna Stage	0	528	979	2020-04-01
963	da Cunha Caldeira e Filhos Pocket	0	540	300	2016-10-02
964	Mendes Cassiano - EI Go	0	908	945	2023-07-03
965	Baker, Murphy and Beasley Plus	0	264	599	2004-04-22
966	Anderson-Bray Gate	0	818	764	2014-02-05
967	Perez and Sons Showcase	0	963	681	2010-09-23
968	Michael-Morse Spotlight	0	39	714	1997-07-22
969	Beard, Curry and Becker Sincroniza	0	551	13	1999-06-01
970	Araújo e Filhos Future	0	766	792	1995-10-02
971	Dunn-Dixon Box	0	963	609	1998-06-15
972	Williams, Scott and Raymond PocketTV	0	9	515	1996-07-09
973	Sousa Araújo e Filhos Stage	0	898	247	1996-06-15
974	Carvalho - ME Fila	0	619	969	2013-01-12
975	Chambers-Ramsey LiveStream	0	109	164	2011-05-28
976	Holland, Hernandez and Gibson Access+	0	684	600	2018-08-06
977	Marquez, Duncan and White Go	0	754	490	1996-01-11
978	Smith, Hampton and Walsh Onda	0	609	763	1995-09-21
979	Edwards and Sons Entrada	0	121	19	2000-01-25
980	Stout and Sons Universal	0	460	228	1995-05-11
981	Câmara Ribeiro Ltda. CastTV	0	5	87	2024-09-25
982	Mclaughlin-Henson Studios	0	379	798	2016-09-02
983	Crosby-Lopez Gate	0	410	293	2016-10-02
984	Cruz, Walker and Prince Spot	0	344	65	1994-01-12
985	Hull PLC Ir	0	555	791	2022-01-18
986	Brady-Lopez Mundo	0	297	75	2005-02-27
987	Freeman, Mendoza and Becker Originals	0	348	346	2003-11-11
988	Carvalho Fernandes Ltda. Plus	0	931	296	2019-07-07
989	Hudson-Edwards Now+	0	292	440	2018-08-07
990	Alvarado Ltd Streamline	0	119	312	1991-05-24
991	Cunha Alves - EI PocketTV	0	956	277	2001-09-22
992	Farrell PLC Realm	0	471	747	1996-01-05
993	Carvalho Lima S.A. Atlas	0	601	536	2003-10-16
994	Barros Aragão - ME Access	0	524	181	2016-03-20
995	Barron Ltd Flix	0	233	889	2006-08-27
996	Silveira Novais e Filhos Navigator	0	498	889	1990-11-07
997	Nunez-Morris Atlas	0	305	480	2001-06-28
998	Novais Cirino - EI Premium	0	963	389	2006-07-17
999	Jackson-Gross Go	0	814	812	2002-09-18
1000	Pacheco Melo S.A. Access	0	223	753	2004-04-26
\.


--
-- TOC entry 5277 (class 0 OID 16607)
-- Dependencies: 262
-- Data for Name: plataforma_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plataforma_usuario (nro_plataforma, nick_usuario, nro_usuario) FROM stdin;
771	dhoffman	916
791	rhavi72	243
506	rcassiano	322
18	josue04	870
846	zvieira	104
537	ana-clara04	144
486	da-luzluiz-gustavo	68
417	christine35	12
629	alyssa90	877
172	spastor	643
922	dawn99	614
65	samanthalee	426
698	taylordiana	758
874	rcassiano	351
456	lauramoura	633
107	zmcknight	366
943	valentinejacob	259
637	gael17	578
906	lunnasilva	778
947	andrewhughes	104
684	daniloazevedo	162
54	matthewacosta	630
225	ana-lauranovais	428
643	ysilva	526
337	lvargas	631
109	raquel37	892
206	mcardoso	46
379	nascimentovitor	798
320	mcardoso	990
877	ortizedward	690
535	jbrewer	905
585	cody07	709
92	qsolis	607
502	tranjonathan	631
617	amacedo	200
396	raquel37	113
477	henry03	634
874	lizsales	313
670	xharper	27
434	williamsondennis	806
104	gramos	253
431	davi-lucasda-cunha	612
223	jeremyjohnson	107
285	ldavis	371
726	sanchezjessica	239
929	bjesus	627
915	maria-laura70	468
9	loriestes	75
476	vasconcelosliz	954
496	chadhutchinson	299
776	nascimentovitor	817
258	lunna98	856
892	cunhamateus	637
470	jgarcia	683
485	paulo68	39
619	sampaiohellena	503
346	qguerra	97
834	qpastor	605
857	wcaldeira	888
989	allenjamie	415
799	maria-luiza19	211
767	lais30	364
341	milenamonteiro	63
115	yparks	783
573	poliveira	78
468	jonestimothy	83
683	bowmanmark	220
77	paulo26	32
872	atkinstyler	729
37	asmith	22
649	zlima	77
62	bethanymoore	860
212	stantonseth	782
269	chadhutchinson	705
289	brookstina	293
946	zoe06	609
88	zda-mota	257
115	viniciusmarques	957
174	novaessophia	102
169	luisa32	287
869	apacheco	897
54	brenda29	939
659	kellygonzalez	743
428	qguerra	866
341	jonesalexander	403
579	larissa57	765
273	rodrigueslorenzo	210
262	andreadunn	342
677	daviskristin	413
211	abigail94	462
377	william28	873
602	kevin57	223
645	kparker	470
222	richard41	573
409	sophiepimenta	923
794	zramirez	742
954	derrickbooker	13
32	ambershepherd	123
575	sousatheodoro	525
168	yago18	94
818	melina07	569
28	nclayton	110
739	ryanfernandes	346
643	oliverrocha	367
262	timothy01	123
963	hcline	353
101	rodriguesana-vitoria	616
304	nclayton	227
149	alexanderwalsh	117
990	bwright	533
12	hcline	3
580	thiagocastro	327
471	poliveira	744
320	chadhutchinson	703
32	onogueira	465
302	heloisa08	878
898	troy86	670
368	lauranovais	660
380	moreiraarthur-gabriel	996
708	kamilly26	956
522	yda-conceicao	454
89	yago18	102
627	carteralexander	131
913	vaparecida	554
436	derrickbooker	177
21	serranoleslie	484
305	srocha	947
446	taragao	23
372	scott63	893
95	fhaynes	293
101	clopes	47
539	wangjennifer	149
288	vargaselisa	906
269	costelabrenda	571
867	castanedamelanie	162
792	petergonzales	728
727	carlos-eduardo98	723
799	gda-cruz	731
642	tranjonathan	983
268	meloyan	123
401	cmorrison	595
238	gabriela30	419
321	albuquerquepietra	131
956	allentina	72
449	osoto	304
765	carteralexander	128
681	jeffreylewis	12
607	erikarogers	887
84	tuckergregory	92
864	ana-luizateixeira	632
478	cshort	641
104	leticia04	848
474	agatha07	476
605	rodriguezjohn	885
878	smithsarah	587
198	camarabenjamin	430
360	antoniothompson	329
743	julie29	299
779	bianca52	562
226	scott56	855
377	lesterpaul	478
290	xmartins	251
970	hmarques	917
529	amberhernandez	360
724	nascimentovitor	770
353	lparker	386
336	zoe06	555
152	pereiraclara	629
850	tmcdonald	440
19	lesterpaul	974
356	carolineda-rocha	37
43	osoto	962
873	stantonseth	947
571	josephmartinez	554
832	alexandrefernandes	853
535	mfogaca	455
765	davidgilbert	291
613	lavinia45	981
463	sullivanhannah	475
521	nsilva	414
258	davi00	574
660	agatha00	656
167	rborges	891
86	kbarnes	116
559	smendez	87
103	speixoto	611
546	camaramariane	869
945	benjamin72	642
772	pedro-lucasmachado	975
150	joshua52	676
254	augustomoraes	352
915	bernardomoraes	122
917	cainjames	909
538	gleao	749
907	mckinneyanthony	641
689	tpimenta	732
938	caroline88	391
858	ocavalcante	942
657	zsilva	813
951	smoreira	606
963	carlos-eduardo98	524
848	gael17	365
180	olivia86	234
629	novaescarlos-eduardo	440
240	phillipssteven	6
605	laurenramirez	44
609	caseyscott	417
515	oliverrocha	246
336	serranoleslie	630
344	wjones	802
372	correiajose-miguel	885
855	jsiqueira	424
560	robertstrickland	98
306	mckinneyanthony	18
281	benjamin35	751
959	aparecidajose-pedro	328
970	ashleysmith	715
816	petergonzales	965
273	xhancock	62
59	da-rochapietra	818
797	luanpacheco	845
824	sampaiohellena	238
273	mayasousa	886
651	gonzalezamanda	484
240	barrosliz	58
516	laurenramirez	869
80	lauranovais	169
810	shannontaylor	565
400	katherine43	971
796	caroline88	424
333	lopezpatrick	367
434	moraeseduarda	344
414	charles88	255
618	fwilliams	895
590	hmarques	906
749	fgarcia	874
127	nduarte	438
591	rbennett	872
273	lgonzales	777
381	marianapimenta	558
147	sullivanhannah	888
468	maria-fernandacavalcante	110
534	clopes	657
174	cmorrison	527
892	luiza38	883
862	vitor-hugomachado	788
901	xellison	170
842	johnsonrhonda	990
337	qcarvalho	808
715	daniela39	915
512	lgonzales	758
913	leaoravi	272
332	davidgilbert	769
245	carldonovan	641
774	warnernicholas	458
592	ana-liviabarros	982
665	annette61	702
531	andrea86	730
125	salesana-julia	25
443	ashley53	238
637	machadovalentina	623
992	dom48	757
354	camaravicente	87
338	martinezchristopher	345
824	zfreitas	754
860	toddburton	11
579	michele07	93
648	janebrown	128
15	vegatiffany	117
447	manuella08	399
657	pedrorocha	920
506	igeorge	579
181	raraujo	50
25	xmartins	768
779	murilo83	211
51	simsalan	779
133	martinlauren	352
773	carrie24	640
158	miguel11	505
36	sean43	821
15	isabella37	203
597	kimberly61	869
210	goldenlauren	655
283	fleao	201
278	jasminerodriguez	416
252	xmartins	673
783	kellyroy	218
841	benjamin35	599
337	qsolis	331
36	camaravicente	32
95	sheltonstacey	287
210	websterstephanie	273
601	gmendonca	228
48	jacobmcconnell	331
565	stantonseth	859
591	xmartins	207
621	conniebaker	610
289	rileyjames	361
942	igeorge	654
514	eduardosousa	584
103	fbullock	734
89	lopeshenry	915
800	melissawilliams	952
262	ntapia	858
13	pvasquez	915
71	christinevazquez	806
297	bernardomoraes	117
147	ucastaneda	247
822	aylamacedo	779
18	saantony	161
447	santoscamila	893
159	villaricky	550
250	christine35	518
350	lizsales	257
642	pedro-henrique65	78
690	camposfernando	231
789	carolinacastro	696
246	maria-isis12	125
516	duncanjacob	28
838	sarahmanning	707
231	vitornogueira	677
525	nogueirajuliana	27
548	sarah14	681
893	kevin72	219
888	leticia04	834
85	williamwoodward	130
494	usilva	760
763	mcopeland	971
42	brownlisa	818
344	antonio97	56
97	hernandezjason	280
432	emilyrogers	472
604	brenda29	829
714	lrocha	167
1	mariane71	13
57	goncalvesmilena	109
187	christine16	92
268	felipe12	574
367	henrythomas	412
159	leo22	255
325	anthony-gabrielfernandes	598
267	zvieira	317
278	davidgilbert	193
882	kamilly26	932
469	petergonzales	356
586	sullivanhannah	68
713	petergonzales	445
387	imoore	212
588	richardjim	282
418	whiteandrew	653
152	jessicahenson	347
981	borgesmilena	236
69	syates	558
677	borgesheitor	13
85	barbara39	620
269	heloisa08	746
968	peixotojosue	312
841	andre53	113
737	maitepimenta	733
855	zimmermankevin	265
383	aparecidajose-pedro	145
441	srocha	731
115	jabreu	323
546	angela74	186
168	lynnsamuel	127
868	cmclaughlin	573
232	stephanie20	883
144	marywilliams	475
307	rhernandez	702
746	viniciusmarques	361
529	xellison	423
634	anada-cunha	576
393	mendoncaana-carolina	980
145	cunhajoana	293
497	vitor-gabriel29	452
616	kimberly61	781
392	calebecirino	29
461	diassofia	927
16	james30	301
531	kcunha	865
49	rborges	413
806	lcampbell	805
20	mayasousa	481
289	luiz-otavionovais	895
421	mirella39	643
862	crystal01	665
246	sofia93	400
292	brunamendonca	772
59	aylamoraes	777
1	thomas21	881
20	qda-cunha	240
88	qsolis	322
470	brownmark	186
126	christopher29	742
639	maria-eduarda01	377
319	mcavalcanti	461
311	xhernandez	884
189	anabrito	811
310	paulo26	682
417	tracywalls	376
751	zda-mota	828
307	mooneyamber	863
900	sampaiomaria-cecilia	508
923	josue67	210
658	sullivanandrew	936
995	darrell34	163
992	cmorrison	398
585	benjamin34	182
336	amanda40	907
842	adamsdesiree	777
762	andrademaria-luisa	871
919	rcamargo	615
69	larissa57	225
125	sousacalebe	702
522	kylehuang	63
58	joao-miguel27	904
509	ana-lauranovais	878
509	pclark	584
430	calebecirino	538
13	gardnerwendy	146
939	aprilrocha	857
502	ana-lizmelo	36
615	vegatricia	459
379	xharper	374
68	uribeiro	990
872	carldonovan	975
376	kellyhampton	705
741	catarina87	20
104	fda-paz	381
9	hellena59	100
598	brenda29	698
131	maria-eduarda23	819
798	raraujo	415
548	dawn99	468
570	tuckergregory	835
708	angelapatel	154
750	fhaynes	989
210	rebeccaperez	797
442	carteralexander	217
29	brownmark	173
672	brush	752
924	viniciusmarques	242
526	marquescarlos-eduardo	970
999	teixeiragabriela	248
935	scottpayne	615
537	cerickson	385
74	dclark	493
459	nclayton	530
632	donaldmiller	849
202	castanedamelanie	559
407	cmorrison	208
982	zlima	208
480	chernandez	675
446	mistymartinez	969
530	rcassiano	805
150	guerrasofia	419
923	aparecidajose-pedro	148
714	moraesdavi-luiz	391
856	kwells	863
616	erikarogers	13
202	anagarcia	71
837	bellaribeiro	332
600	cda-cruz	664
51	levisampaio	779
785	nascimentovitor	218
917	chelseyjackson	385
252	wjones	788
747	lisa85	380
656	crystalfrank	765
209	hannah47	892
122	christine16	623
376	joao-guilherme76	644
343	goldenlauren	869
173	andresbrooks	866
515	zsilva	453
274	brownsydney	296
543	robertmoran	875
254	josephmartinez	456
288	tallison	831
88	leticia04	668
171	limatheodoro	936
153	isaac15	862
315	santoscamila	71
467	gardnerwendy	849
781	marianapimenta	976
563	sarah14	976
319	novaisalice	455
201	leaoravi	826
498	brookstina	865
373	larissagarcia	902
174	mayasousa	431
447	williamdean	18
582	theresacabrera	871
349	asilva	908
203	nogueirajuliana	722
43	ferreirapaulo	781
865	joao91	239
889	murillomelissa	658
99	ucastaneda	680
834	teixeirastella	887
121	spastor	261
683	wangjennifer	744
754	bjesus	943
989	michele07	904
357	albuquerquefernando	796
588	marierogers	261
407	yuricavalcante	215
265	aparecidajose-pedro	343
829	paulwilliam	326
885	theodoroda-costa	574
616	henrythomas	924
303	amandajackson	194
382	anada-rocha	815
559	igor17	19
968	luarajesus	727
384	brendabolton	419
53	hannah47	824
263	robertjones	46
184	yparks	465
305	paulo68	930
944	bradleysmith	861
658	keithhernandez	951
637	smoreira	739
671	martinezchristopher	722
983	jermainejohnson	415
519	tuckergregory	951
610	barbara39	694
127	da-cunhaaugusto	418
684	crystal01	97
53	fwilliams	171
266	maitearaujo	726
603	tallison	357
594	camposfernando	767
171	zcardoso	723
915	aylamacedo	712
640	mharrison	517
495	fernandacirino	102
100	luarajesus	449
241	allenjamie	896
620	michele07	400
489	felipe12	472
320	wangjennifer	180
661	ana-cecilia54	56
668	qguerra	637
243	maryramirez	401
449	brendabolton	529
574	antoniosalinas	678
131	aschneider	450
145	maria-laura70	147
647	anna-liz69	247
643	leaolucas-gabriel	157
890	bianca52	416
509	agathapacheco	905
362	johnsonrhonda	161
558	xhernandez	204
399	cavalcantihadassa	182
405	maria-fernandacavalcante	472
4	asilveira	335
741	ana82	302
277	alexandrefernandes	773
396	camaravicente	776
568	duarteheitor	643
342	wsales	342
209	abigail94	103
653	maitepimenta	329
514	luiza38	205
933	torreswyatt	659
76	sara35	139
781	scott56	49
288	maxwelllaura	265
347	richard62	873
506	nicolas74	685
918	qsolis	432
334	liammontenegro	278
504	da-cunhaaugusto	699
218	vegatricia	56
705	lunnaalves	813
622	xmack	366
427	loriestes	284
112	christine94	567
431	ravyribeiro	930
999	ana-luiza88	288
402	laurarios	684
341	pvasquez	25
919	ysilveira	568
805	gleao	670
846	stephanie20	230
138	vasconcelosliz	998
10	maysaaraujo	711
537	richard62	538
622	carrie95	455
802	yda-conceicao	576
164	qsolis	668
410	lsilva	541
808	patrick70	13
605	castanedamelanie	748
164	duarteheitor	337
123	taylordiana	127
914	cunhastephany	458
606	meloyan	58
769	kari51	345
23	cassianothomas	972
734	pereiraclara	330
72	luiz-otavioda-costa	253
465	meyermelanie	69
320	carolineda-rocha	805
676	theosales	966
832	scott09	913
591	luiz-otavionovais	946
278	bcardoso	343
898	qda-cunha	488
777	antoniothompson	173
240	syates	528
352	bellagarcia	958
651	laurarios	681
734	ruiztammy	52
792	uribeiro	775
583	ffernandes	554
591	lcaldeira	656
76	qpastor	527
419	zpimenta	34
142	gonzalezamanda	9
60	eduardosousa	634
827	da-pazana-cecilia	890
585	lopezcrystal	289
289	williamdean	900
611	nchambers	129
115	tsanchez	767
582	montenegroaurora	353
801	barbara39	493
222	zferreira	86
880	toliveira	955
459	richard41	68
710	otto82	407
17	brownlisa	659
445	cda-rocha	230
28	gcorreia	925
675	davi-luizda-conceicao	261
691	martinlauren	518
832	carldonovan	371
275	agatha07	647
81	albuquerquepietra	690
365	theodoroda-costa	316
836	tracywalls	348
237	williamdean	400
103	craig05	778
357	mirella55	776
55	kingelizabeth	156
707	emanuellysilveira	398
480	calebe53	390
695	madisonholland	393
978	pclark	278
479	maria-florpinto	760
286	luigi17	761
119	cda-cruz	770
816	bgonzalez	611
217	loriestes	555
35	laisda-mata	466
233	brunamendonca	368
388	pteixeira	807
173	thomas21	139
337	mariane71	789
915	ynash	140
77	joao-guilherme76	908
530	marianapimenta	252
823	hornejoshua	900
122	taylordiana	973
425	troy86	404
684	amanda12	4
952	fcamara	854
263	amacedo	537
568	teixeiragabriela	95
639	kimberly23	387
900	sanchezjessica	281
453	palmeida	767
358	isaac51	712
142	megan60	338
556	fcruz	621
949	chris52	251
523	elisa35	753
369	brownlisa	758
346	wrezende	795
792	nicolas74	183
978	nliu	138
205	alantrujillo	978
61	hhernandez	842
992	rileyjames	861
799	donaldwalker	962
622	muellertracey	442
488	peter38	943
145	eduardosousa	43
539	erinhernandez	328
248	brush	685
194	chris52	910
766	daniel54	540
835	tallison	731
630	ana-julia54	930
156	dom48	916
541	kinglauren	200
12	ysilva	411
168	lamblindsay	620
210	oliverrocha	833
366	fda-paz	525
670	bjesus	469
145	agatha00	688
12	jason96	411
324	ana-cecilia54	286
54	diassofia	149
511	melindagallegos	676
453	chernandez	64
274	ayla27	729
697	hornejoshua	181
669	carrie95	273
205	marianegomes	557
49	vitor-hugomachado	379
68	pamela23	460
695	julia68	843
680	ana-vitoriaaraujo	493
94	xmendes	523
122	vasconcelosliz	796
450	jcamacho	606
731	josue67	363
584	robertmoran	387
219	john03	656
914	da-pazluiz-henrique	355
473	benicioaragao	258
419	thomas21	141
394	jose-miguelmoreira	658
413	zsilva	810
271	hmiller	377
260	james30	454
674	philip04	374
601	sean43	170
316	melina07	388
823	brenda29	939
252	sofia93	1
152	alexandre86	473
251	kinglauren	994
861	guilherme94	741
865	lopesguilherme	867
77	kevin91	925
423	lisahernandez	868
741	janebrown	684
507	xhernandez	364
676	rwilson	516
791	fernandacirino	244
46	isaac15	94
611	theresacabrera	90
996	dom48	494
422	ewalters	486
409	atkinstyler	672
673	rwilson	424
756	mcdonalddawn	621
480	erikarogers	660
125	rael84	588
46	davi-lucasda-cunha	77
788	john13	467
278	whiteandrew	48
322	kellygonzalez	726
616	kamilly26	258
763	machadodavi	54
986	carolinacastro	929
277	qguerra	675
981	gaelda-luz	662
740	kevin57	949
813	kinglauren	519
38	viniciusmarques	108
252	guilherme94	385
47	megan60	624
561	pgreen	339
594	lawrence63	818
59	atkinstyler	432
400	maria-isis09	976
724	fpeixoto	2
386	timothyhuang	74
858	leticia04	556
517	moreiraarthur-gabriel	982
198	abigail94	667
959	ortizedward	795
294	carteralexander	433
288	erinhernandez	683
354	aprilrocha	693
35	arthur09	168
268	kristie75	180
547	carolineda-rocha	783
326	siqueiradaniel	614
216	vleonard	177
624	bowmansylvia	494
331	ymarques	401
778	kellygonzalez	207
236	katherine43	666
469	poliveira	200
249	lesterpaul	472
332	richard44	750
286	taylordiana	665
288	aprilrocha	189
173	ana-lauranovais	567
244	yuricavalcante	420
220	ottocostela	770
533	marierogers	167
734	ana-luiza74	180
575	fleao	625
691	xoliveira	625
938	christinevazquez	928
145	bryan07	451
35	cunhajoana	197
105	karen45	785
806	simsalan	684
600	hornkathryn	915
594	gfogaca	320
441	lauramoura	951
885	moraesdavi-luiz	155
727	camila29	179
95	jacqueline07	166
765	usilva	739
841	rhavi72	646
12	foleymargaret	499
501	maysaaraujo	758
38	tracywalls	663
444	bellagarcia	787
924	richard41	642
766	megan60	805
364	aylaferreira	295
364	lcaldeira	683
545	gustavo-henriquemartins	269
39	caleb01	803
365	joshua72	603
514	kparker	47
24	pedro-lucasmachado	630
590	bfreitas	577
468	barrosliz	330
27	julia16	750
75	rodriguezjohn	2
530	patrick70	384
798	guerrajoao-gabriel	220
594	villaricky	331
758	loriestes	253
198	luiz-felipealbuquerque	380
11	da-cunhaaugusto	812
213	robertjones	987
438	cunhastephany	791
450	ncosta	823
671	loriestes	367
181	lisahernandez	803
462	lunnaalves	349
635	joshua52	461
171	maria-flor01	374
654	hvasconcelos	18
809	jose-pedro32	14
727	camaramaria-helena	481
143	owenkatie	469
518	gda-rocha	552
495	gcooper	252
280	sullivanandrew	57
921	daniel54	590
727	cindy39	285
776	margaret46	750
96	rael29	436
621	paulo26	827
989	derrickbooker	206
814	lsilva	118
96	agatha00	493
922	cirinomaya	650
641	phillip92	454
741	hannah47	249
353	pereiraclara	530
858	philip04	96
994	gaelda-luz	732
67	jsales	824
485	zazevedo	622
873	lvargas	755
708	richard41	54
810	lrocha	679
695	kamillysampaio	266
293	srocha	891
427	osoto	849
877	limapietro	150
945	xellison	384
349	lais30	352
807	scott56	818
880	ysilva	567
532	hornejoshua	504
5	phillip92	947
26	maria-eduarda01	459
285	carlos-eduardo98	634
131	maria-cecilianovaes	885
982	renanrodrigues	133
668	anada-rocha	787
287	adamsdesiree	32
330	ahill	711
9	vargaselisa	813
863	leticia04	739
573	maria-isis12	577
176	hwilson	502
784	gonzalezrobert	764
661	enogueira	611
315	ana-luiza88	446
713	amanda12	74
966	mirella55	852
859	smeyers	413
765	derrickbooker	846
160	jcruz	775
956	santosotavio	827
560	melissawilliams	163
362	ericjordan	954
729	lorena64	359
10	goldenlauren	296
365	whiteandrew	868
823	torreswyatt	249
31	nsilva	224
884	reynoldstravis	283
946	davi-luccaazevedo	860
182	albuquerquefernando	29
644	lunnaalves	951
166	bowmansylvia	952
587	daniellesalas	913
385	albuquerquepietra	500
140	monica86	700
468	joao-miguel27	798
391	agatha91	591
549	cauecamargo	876
612	pietro81	15
698	fthomas	606
255	mariane71	943
381	melissa41	310
460	luigi16	165
808	cunhamateus	509
958	wsales	472
812	bianca52	89
258	laurarios	44
81	agatha37	369
431	christopher27	990
608	johnathan94	780
149	jroberts	205
604	hvasconcelos	69
839	vieiramarcela	506
286	da-cruzbruna	438
344	annette61	927
506	cassianothomas	756
491	joanna34	759
74	sandrarice	677
928	cirinomaya	575
480	ntapia	535
484	alexandre86	129
140	zfreitas	430
866	cda-rocha	953
136	saemanuella	246
449	sabreno	405
961	alantrujillo	960
272	sara35	602
647	flima	925
949	kristie75	903
772	brendabolton	846
303	john03	226
147	hernandezjason	687
47	fmendes	776
480	murilo15	830
405	vitor-gabriel29	372
324	kevin42	233
658	ruiztammy	872
80	reynoldstravis	833
395	wrezende	248
419	alexandrefernandes	771
938	maria-isis09	56
947	ppereira	59
953	websterstephanie	894
681	sara35	546
556	felipepastor	698
461	qmoreira	860
500	camaramariane	904
869	qda-cunha	456
868	albuquerquefernando	662
852	maria-isis12	69
336	davi00	319
748	ksales	794
324	christine16	787
149	cmorrison	463
789	aylamoraes	371
540	sheltonstacey	47
132	jonesalexander	606
347	upacheco	471
797	robertstrickland	456
849	fernanda14	424
421	mirella55	40
552	owenkatie	395
483	oliveiraandre	428
258	kingshannon	615
505	xmack	210
850	theosales	256
348	stella93	172
219	atkinstyler	218
648	marianegomes	320
815	zmcknight	552
4	machadodavi	876
572	beatrizfarias	65
123	vasconcelosliz	366
304	darrell34	706
666	da-pazana-cecilia	989
692	lcampbell	272
212	catherineallen	526
\.


--
-- TOC entry 5280 (class 0 OID 16617)
-- Dependencies: 265
-- Data for Name: streamer_pais; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.streamer_pais (nick_streamer, nro_passaporte, pais_passaporte) FROM stdin;
maria-eduarda18	604002972	Ivory Coast
hadassafernandes	228588923	Singapore
vitoria15	D09912872	Vanuatu
michaelcox	725963684	Israel
ana-lauranovais	V89011445	Philippines
qfarias	669408266	Cayman Islands
luanaaragao	040976813	Romania
raul65	573133019	Canada
xmarques	Z20789887	Papua New Guinea
lorenzovargas	951772705	Trinidad and Tobago
erikarogers	J73512174	Bulgaria
teixeiragabriela	817848793	Colombia
curtisbuck	748470733	Maldives
mfogaca	Q67811011	Norway
rebecada-mota	L86008167	Chile
cainjames	814294271	Laos
troy86	T46839127	Central African Republic
lisa85	C12559230	Iceland
luizafernandes	Z98101414	Djibouti
eileenritter	497035588	Bosnia and Herzegovina
guerrasofia	P68036038	Romania
wcaldeira	074906252	Sri Lanka
wrocha	462212964	Georgia
allenjamie	855412592	Palestine
martinlauren	812417355	Albania
tsanchez	D73219625	Tonga
tyronerichard	174973349	Ghana
zpimenta	V15751224	Singapore
labreu	862473609	Zambia
ksales	I89981393	South Korea
zcardoso	R22932387	Kazakhstan
lizsales	790213755	Singapore
joshua52	X83040607	Papua New Guinea
gregory22	702803049	South Africa
laurenchan	715063324	Uruguay
maryramirez	N01572391	Cambodia
benjamin35	127203068	Bangladesh
mmontenegro	C36097370	Indonesia
saantony	D77193728	Vanuatu
kwells	H38806480	Tunisia
michaelcox	584732989	Brunei
janebrown	170442620	Djibouti
mendoncaana-carolina	953109026	Cambodia
tpotter	B60182078	Hong Kong
kamilly26	803334871	Mongolia
cpope	T62176060	Belize
pwilson	M95984080	Mexico
davi-lucasda-cunha	255700243	Pakistan
rhavi72	S18868437	Russia
eda-rocha	013786867	Zambia
lopesguilherme	960309556	Malawi
nfernandes	T62484618	Romania
kimberly61	F63892235	Oman
wrezende	245048732	Liechtenstein
felipe12	E03465044	Taiwan
eric07	L24677984	Poland
ufrederick	J89914316	Tunisia
sousatheodoro	391756911	Burundi
bellaborges	665590425	Puerto Rico
aparecidajose-pedro	Q79858350	Malaysia
rodriguesbento	Z09526998	Palestine
morgan48	Z98947976	Brunei
xhancock	079960195	Iran
daniellesalas	J20334836	Maldives
andre53	782040146	Tajikistan
tyronerichard	G46291605	Canada
da-cruzbruna	R05464459	Mongolia
maryramirez	J63770331	Fiji
rbennett	X38737672	Costa Rica
allentina	390166308	Suriname
donaldwalker	065719961	Vietnam
da-motaaurora	J80748277	Rwanda
maria-vitoriada-conceicao	034675260	Panama
vaparecida	G29486769	Samoa
tracy86	S54244197	Nicaragua
zazevedo	378143410	Bangladesh
mirella55	585145534	North Korea
josue67	W26246296	Pakistan
andresbrooks	Q34713840	Norway
ana-julia54	528564338	Nigeria
rhavinovaes	038381657	Tanzania
carrie24	223100606	Malaysia
anagarcia	294304593	Cayman Islands
andre53	T25708422	Turkmenistan
scamara	817511299	Comoros
osoto	628291193	Maldives
isaac15	018800314	Saint Helena, Ascension and Tristan da Cunha
villaricky	T50870796	Belize
lparker	Q89905559	Bangladesh
rodrigueslorenzo	640240343	Costa Rica
zmcknight	P24033807	Kenya
ocavalcante	342792054	Russia
samaria-flor	591293256	Moldova
fabreu	T28059500	Vietnam
bowmansylvia	034263404	Andorra
hwilson	O22027377	Botswana
felipe12	Q09608364	Madagascar
erikarogers	708565950	South Africa
sanchezjessica	X62588923	Sri Lanka
speixoto	E98284441	Guinea
thiagocastro	316684948	Comoros
vaparecida	A44551148	Albania
joaquim10	492198024	Iceland
maria-isis12	T96638073	Singapore
amybaker	W28389421	Malaysia
vleonard	O64478911	Argentina
lrocha	438590591	Iran
carldonovan	532715609	Bangladesh
gabriela30	O17937127	Liberia
emanuellysilveira	902982710	Tunisia
richardjim	161583898	Trinidad and Tobago
ana-liviabarros	O11826238	Georgia
siqueiradaniel	C47828721	Madagascar
melinaoliveira	508772194	Bermuda
ianaparecida	X20185689	Pakistan
enogueira	644409021	Peru
cassianothomas	554453001	Saint Helena, Ascension and Tristan da Cunha
ynash	407188242	Gambia
laurenchan	K78708923	Western Sahara
ana-vitoriaaraujo	125874318	Jordan
da-cruzbruna	875397456	Singapore
fleao	208395719	Suriname
hernandezjason	818256371	Singapore
megan60	G63912133	Indonesia
alexanderwalsh	I80766868	Philippines
zcastaneda	C82007891	Gibraltar
anagarcia	Z57281616	Vanuatu
ana82	426580926	Uzbekistan
mendoncaana-carolina	J00723732	Suriname
eduardosousa	P33494348	Costa Rica
moraeseduarda	R39547022	Nicaragua
gramos	036159616	Poland
francisco74	D11956822	Syria
vitor-hugomachado	253083308	Poland
fcamara	077179001	Jordan
michaelmolina	V90034809	Jordan
jacobmcconnell	101497712	Vietnam
speixoto	174964423	Papua New Guinea
josephmartinez	884466313	Kazakhstan
kellygonzalez	221945873	Syria
marierogers	M66958933	Cape Verde
carlos-eduardo98	V67369006	Sri Lanka
rferguson	609347243	Turkey
maria-fernandacavalcante	973518124	Hungary
luarajesus	660093665	Bangladesh
ysilveira	949567804	Pakistan
lais30	546963995	Cambodia
ortizedward	N09201313	Belize
felipe12	V80571963	Bosnia and Herzegovina
melindagallegos	336902414	Uzbekistan
rebeccaperez	B04221206	Oman
alantrujillo	637444214	Ghana
fda-mota	113210191	Mongolia
samaria-flor	V88275250	Mongolia
david13	407916852	Andorra
dawn99	B05854269	Somalia
samaria-flor	459063951	Serbia
mariane71	P99660620	Honduras
borgesmilena	B29223358	Ghana
curtisbuck	110706990	China
cerickson	656872209	South Africa
chernandez	495149081	Colombia
amacedo	528713319	Falkland Islands
fernandacirino	809261871	Yemen
lavinia45	778380039	Botswana
elisa35	543813499	Taiwan
mirella55	786428420	Tajikistan
christopher29	K75461522	Turkmenistan
jacobmcconnell	156451222	Djibouti
iwright	242091146	Saudi Arabia
sabreno	299600019	Fiji
martinlauren	Z41313415	Gambia
andreadunn	991862910	Poland
danielsfrank	287709352	Kazakhstan
lunna98	066259055	Sudan
dhoffman	471222249	India
cassianothomas	752464962	Tonga
kari51	W26036970	Madagascar
hellena59	603270951	Honduras
camila29	070440077	Sweden
sara35	294632474	Aruba
bruno15	697978396	Iceland
meloyan	L04024814	Iceland
esa	Y57341557	Saudi Arabia
nclayton	029748358	Fiji
michaelramos	O26632991	Hong Kong
thomasnguyen	831036224	Japan
martinlauren	I70237181	Paraguay
annette61	376997042	Taiwan
bethanymoore	873045421	Myanmar
brush	540881648	Tajikistan
fernando10	G19820293	Sri Lanka
guerrajoao-gabriel	H66532816	Seychelles
xturner	825120305	Cambodia
madison68	B48242107	Liberia
carrie24	O00906004	China
daniela16	810753180	Jamaica
asilveira	E00139337	Puerto Rico
brookstina	004028505	Ghana
correiajose-miguel	573923979	North Korea
marywilliams	Z14030832	Zambia
lporto	619191559	Serbia
anagarcia	G37421763	Hong Kong
lopesguilherme	374635095	Wallis and Futuna
lparker	883947014	Bolivia
tyronerichard	151187972	Pakistan
camaramariane	982945968	Burundi
bruno15	W00734147	North Korea
carlos-eduardo98	148719180	Canada
michaeldavis	665896813	Turkey
clopes	182495702	Hungary
zduarte	377946025	Jordan
sullivanandrew	P76179866	Moldova
rhavinovaes	704151704	Syria
da-cruzbruna	174254609	Madagascar
das-nevesmiguel	S81369600	Madagascar
chadhutchinson	400820531	South Africa
cmorrison	337138649	Hungary
levisampaio	721431891	Aruba
cunhamateus	382145049	South Africa
ana82	980858011	Kenya
albuquerquefernando	H27294230	Cambodia
omiller	I75927111	Cuba
mistymartinez	W20010923	DR Congo
donald58	B51932165	Haiti
theo52	312684790	Israel
marywilliams	075346493	Sri Lanka
ucastaneda	671034028	Puerto Rico
correiaheloisa	D02697380	DR Congo
ufrederick	248691724	Trinidad and Tobago
barbara39	632189420	Chile
joao-pedrosouza	442167527	Albania
hicksseth	D80267659	Haiti
zfreitas	C30027238	Uruguay
siqueiracecilia	M42570562	Mongolia
aylaferreira	U33549795	Western Sahara
juan10	099909945	Uganda
levisampaio	763332766	Indonesia
davi00	L46411385	Oman
rael84	945896547	Indonesia
leaoravi	205637849	Falkland Islands
maria-isis12	K55633099	Kazakhstan
robertmoran	M66415912	Aruba
eda-rocha	772877679	Western Sahara
jason06	845754546	Seychelles
tylerglenn	405820573	Gambia
laisda-mata	944542605	Botswana
jasminerodriguez	036062720	Bulgaria
ericjordan	797857867	Panama
xturner	Y61759593	Samoa
chadhutchinson	094148334	Kiribati
stantonseth	J77360682	Panama
meyermelanie	G63434416	Rwanda
reynoldstravis	O22567166	India
angela74	373269093	Trinidad and Tobago
henrythomas	605293424	North Korea
igeorge	V14402456	Laos
brownmark	H00908475	Russia
iteixeira	060492091	Botswana
laurenchan	Y04116642	Canada
rael29	541641037	Palestine
kentnancy	F87174436	Yemen
kevin57	P32436602	Russia
machadovalentina	M92406153	Palestine
ana-vitoriafernandes	K66001149	Gambia
jesusana-sophia	946442775	Vietnam
xhernandez	389758742	Armenia
jamiemorris	S61958260	Sudan
lavinia45	708314849	Saint Lucia
uwalker	406714323	Philippines
carrie24	196841053	Cayman Islands
davi-miguelporto	L94470994	DR Congo
luizafernandes	S38034087	Yemen
wcaldeira	M66663286	Hong Kong
curtisbuck	436845610	Cuba
gregory22	896539813	Curaçao
poliveira	U47791557	Belize
ana-lizfernandes	V42997066	Nicaragua
gael17	119991689	Zambia
scamara	826907422	Dominican Republic
brownmark	955472296	Curaçao
paulo68	745240834	Cuba
lauranovais	I69389102	Macau
vitoria36	263594617	Vanuatu
daniel54	576223319	Guinea
melina07	C21916635	Kiribati
stephanie54	B20094208	Mongolia
drocha	E33470351	Kenya
thomasnguyen	E00797831	Malaysia
lcaldeira	973289631	Brazil
richard62	657833969	Honduras
clarice02	021284505	Chile
bryan07	H89562012	Hungary
limatheodoro	C14481507	China
carolineda-rocha	Z61025179	Romania
murilo83	E98459012	Jordan
melissawilliams	840573721	Chile
gardnerwendy	827680165	India
rhavinovaes	853585680	Burundi
poliveira	Y99966702	Bulgaria
fgarcia	A14611656	Israel
cainjames	Z72522762	Uruguay
amanda12	676799563	Oman
erichard	N55062827	Guatemala
jonathonhernandez	N48780002	Bahrain
caueda-cruz	734342502	Thailand
atkinstyler	J70714048	Gibraltar
catherineallen	242736081	Belize
jgarcia	872184424	Nigeria
bellagarcia	005386716	Colombia
andrewhughes	248861830	North Korea
lorenzovargas	T98882641	Philippines
ortizedward	096541648	Uruguay
usilva	K08074885	Tunisia
heitorda-mota	908488108	Maldives
fhaynes	387323649	Bulgaria
davi-miguelborges	081600478	Poland
xmarques	F89345677	Tonga
dmurillo	658687855	Niue
stephanie52	C50413823	Ethiopia
alexandre86	M50419263	Hong Kong
richardjim	246683172	Bermuda
marcelafogaca	W03344606	Malaysia
ppereira	I33518246	Wallis and Futuna
carolineda-rocha	A90906046	Yemen
kristisanchez	865031063	Chile
gda-cruz	774946070	Liechtenstein
zfreitas	E97499069	Ghana
vitoria36	319649653	Bahamas
gda-cruz	Z03793003	DR Congo
ottoribeiro	672971644	Vietnam
pamela23	412435940	Trinidad and Tobago
hicksseth	A25633162	Sudan
millermichael	198664264	Kyrgyzstan
andre99	S01014913	Israel
nmoraes	540670117	Panama
owenkatie	102045201	Jordan
lunnasilva	D25001645	Peru
daniloazevedo	P95044344	Brunei
agathapacheco	K58610542	Saint Lucia
steven81	558885564	Georgia
phillip92	R79404470	Western Sahara
upacheco	824417451	Central African Republic
butlerelizabeth	A00922677	Armenia
ayla27	079699524	Paraguay
rael84	889410308	Trinidad and Tobago
allentina	I34499603	Morocco
jermainejohnson	758210411	Bangladesh
bellaribeiro	191245672	Gibraltar
josue67	511107791	Ivory Coast
miguel11	W97194896	Syria
troy86	556979678	Mongolia
zachary05	D66219035	Jordan
kellygonzalez	U49958012	Ivory Coast
nsilva	878298829	Mongolia
kingshannon	230896235	Albania
joao91	900211576	Pakistan
sousatheodoro	744337225	Gibraltar
matthew55	M27847779	Guatemala
gael17	A26747982	Maldives
angelapatel	Y77304609	Vanuatu
richard44	G92865513	Ukraine
shannontaylor	413963527	Iran
paulwhitaker	G33655317	Haiti
ana-julia54	796436291	Vanuatu
qcarvalho	C01198223	Cuba
maryramirez	453923473	Singapore
lgonzales	N35862554	Andorra
cindy39	378981614	Honduras
antonio97	G54084463	DR Congo
bda-costa	F79181511	Andorra
josue67	799506316	United Arab Emirates
tsanchez	240499526	Laos
eric07	G51853154	Ivory Coast
sullivanhannah	N64906347	Liechtenstein
bianca52	H54982234	Curaçao
tammy33	811408219	Turkey
benjamin35	082347839	Hong Kong
zoe06	V84229035	Kazakhstan
luiz-felipe82	J08459768	Ethiopia
jroberts	591871802	Norway
chelseyjackson	736908411	Gibraltar
phillipsmark	696189789	Mauritius
luana98	269425028	Sweden
vitornogueira	070219566	Philippines
nogueirajuliana	470007111	Mexico
thompsonadam	Z73534695	Thailand
michaelmolina	L71853611	Sri Lanka
dawn99	694468414	Romania
wangjennifer	M92385691	Somalia
smoreira	969850905	Brunei
michaelblack	653264016	Malawi
joao-pedrosouza	622598271	Somalia
das-nevesmiguel	606321432	Aruba
anabrito	J97169805	Burundi
lcampbell	612057704	Gibraltar
alice85	G65920822	Cuba
ntapia	339547741	Trinidad and Tobago
anthony24	E29358790	Brazil
nicolemartins	277691014	Suriname
allentina	494017879	Cape Verde
michellerussell	100180135	Samoa
leticia04	331055760	Hungary
ymarques	E01397060	Kazakhstan
allentina	322618835	Puerto Rico
nchambers	Y06858133	Laos
scott56	Y25193399	Saint Lucia
joshua52	655344510	Indonesia
jabreu	299430286	Syria
ashley53	F55180339	DR Congo
andre99	575615209	Poland
reynoldstravis	543772486	Nicaragua
scamara	W89808798	Rwanda
clarice02	Y80199655	Saint Lucia
ewalters	383319518	Turkmenistan
kevin72	T66958472	Western Sahara
ralves	007991163	Guatemala
wpeters	135750855	Costa Rica
lopezpatrick	745217958	Kyrgyzstan
bethanymoore	X92418407	Falkland Islands
matthew55	R93785429	Cayman Islands
anthony24	591269044	Vanuatu
phillip92	065930373	Belize
mayasousa	U61187229	Fiji
kmoraes	O88872140	Peru
jeffreylewis	595143582	Zambia
ana82	I92178414	Lesotho
gonzalesrobert	E01721274	Rwanda
clopes	484019776	Fiji
gfogaca	650488003	Seychelles
pwilson	336849273	Belize
kingelizabeth	046491524	Panama
megan60	J22348153	Honduras
daniel27	428054635	South Korea
mistymartinez	070360364	Liberia
maria-cecilianovaes	604638891	Palestine
jeffreylewis	C66287383	Lesotho
fwilliams	W60140519	Brunei
kylehuang	125638725	Western Sahara
turnerashley	802175335	United Arab Emirates
daviskristin	605299875	Uganda
peter38	Z89736966	Bahrain
alexandremachado	564772738	Namibia
qmendes	009931265	Mongolia
toliveira	559214814	Nicaragua
dclark	983360082	Thailand
henrythomas	A21691546	Canada
gonzalezamanda	C24687892	Jamaica
donaldmiller	Q00817683	Haiti
ncosta	B54517421	Russia
webstertara	L24553926	Mongolia
melissawilliams	S15269946	Cuba
wsales	305727361	Dominican Republic
zfreitas	837531252	Japan
peter38	H88881817	Uganda
bernardomoraes	437044793	Fiji
pvasquez	Z97282621	Iran
hwilson	411853265	Bangladesh
gda-rocha	U93807185	Malaysia
rebeccaperez	763736504	Ghana
ksiqueira	901208314	Colombia
bradleysmith	G19544009	Oman
emilyrogers	D60757115	Iceland
megan60	600850988	Vietnam
nsilva	129112460	Guinea
breno23	R00844872	Malawi
siqueiradaniel	D01293910	Papua New Guinea
jacqueline07	332343435	Central African Republic
siqueiracecilia	773233345	Moldova
roberto71	441787622	Mauritius
kristisanchez	S95177182	Maldives
theosales	472444817	Morocco
luiz-felipealbuquerque	M97012146	Namibia
goncalvesmilena	795715448	Niue
tuckergregory	I38918056	Bosnia and Herzegovina
davi-miguelporto	814011958	Mongolia
zrodriguez	M72008033	Georgia
maria-fernandacavalcante	541644373	Philippines
john03	521752436	Cape Verde
sabreno	119403183	India
andre99	546909186	Saint Lucia
lrocha	K61153028	Bahrain
lopeshenry	D40618485	Panama
lauramoura	L06480480	Jordan
davi-luiz05	175405146	Malaysia
mendoncaana-carolina	R90612994	Uzbekistan
rcassiano	J87631408	Turkey
rodriguesisaac	C85556317	Burundi
gabrielcastro	178583355	Central African Republic
machadodavi	257167822	Hong Kong
raquel37	838059003	Nicaragua
tpires	D49333026	Saint Helena, Ascension and Tristan da Cunha
duarteheitor	F70900060	Belize
melindagallegos	599424001	Turkmenistan
vegatiffany	C01169180	Tunisia
isaac51	N61079561	Vietnam
luiz-felipealbuquerque	T22355709	Laos
fbullock	R06687920	Saint Lucia
anada-cunha	J14721540	Georgia
fabreu	604366075	Bahamas
wsales	187881403	Tajikistan
camarabenjamin	G83955980	Georgia
salasdebra	934775764	Thailand
maria-luiza19	818606465	Uzbekistan
stephanie54	434869262	Namibia
nliu	843524822	Bulgaria
vieiramarcela	Z74402519	Liberia
ottoribeiro	128075646	Namibia
poliveira	X45316453	Cuba
zrodriguez	722386526	South Korea
morgan48	475516702	Hungary
marianegomes	594944242	Cambodia
cunhamateus	945205980	Russia
bda-costa	F82735053	Sweden
gonzalezamanda	031741920	Madagascar
ana-luiza74	074575869	Saint Lucia
abigail94	829784734	Thailand
gardnerwendy	480071323	Lesotho
esa	796309162	Tajikistan
ldavis	790763625	Fiji
mcopeland	880601763	Thailand
moraesdavi-luiz	R02344887	Bahamas
matthewacosta	933361215	Romania
correiaheloisa	279109885	Sudan
lunnasilva	T88564017	Fiji
cauecamargo	665161619	Tajikistan
zmcknight	B38371118	Turkey
vitor-gabriel29	858442128	Mongolia
olivia23	B99120327	Russia
daniel54	125370540	Tajikistan
hfarias	170801626	Bahrain
amandaglass	M90162509	Poland
amacedo	Q24121804	Central African Republic
yago18	554714604	Brunei
davidwilliams	560501892	Papua New Guinea
tylerglenn	U53639451	Saint Lucia
lais30	Q19440400	Czechia
toliveira	T53287073	Tanzania
joshua52	J38551814	Belize
jcorreia	729976471	Haiti
fernandacirino	704079104	Mexico
kirbyjoseph	I79649125	Comoros
fsampaio	160371864	Malaysia
cerickson	572953095	Sudan
mcavalcanti	496085324	Nicaragua
wrocha	B53087586	Peru
camarabenjamin	F36120980	Costa Rica
lcaldeira	907610391	Moldova
andrademaria-luisa	695857684	Syria
montenegroaurora	302613870	Malaysia
kevin42	411429617	Papua New Guinea
amacedo	383515167	Mongolia
sanchezjessica	198911924	Yemen
da-pazrebeca	M10775887	Kiribati
linda57	G38901276	Lesotho
jroberts	L54131579	Sweden
leemiguel	V53992580	Falkland Islands
jeffreydavis	L84276767	Tonga
nfernandes	J78278377	Georgia
hmarques	705757701	Cayman Islands
igeorge	794605384	Thailand
lopezpatrick	L24167433	Vietnam
williamsondennis	231939748	Cuba
dda-rosa	B37880562	Trinidad and Tobago
qmendes	041732515	Botswana
xhernandez	V57334673	Kazakhstan
heloisa08	O46033017	Malawi
duanehatfield	N47267589	Bahrain
tylerglenn	358965524	DR Congo
maria-cecilia07	975342910	Andorra
toddbanks	175460445	Nicaragua
scott09	158001815	Jordan
zcastaneda	319402453	Israel
agatha91	G11807020	Brazil
vasconcelosliz	M62213009	Central African Republic
matteo90	915229600	Hong Kong
curtisbuck	L41535052	Panama
josephmartinez	A50805558	Kiribati
ymarques	V41889565	Curaçao
thomasgeorge	C26464621	Turkey
melindagallegos	W92737371	Eritrea
ericjordan	821807825	Guinea
camaramaria-helena	691638381	Gibraltar
pedro-henrique65	468999437	Uruguay
larissa57	Y75467536	Bosnia and Herzegovina
da-motavitor-hugo	B45855194	Bosnia and Herzegovina
sousatheodoro	934491901	Brazil
reginaldhines	745977984	Peru
lauranovais	741550476	Cayman Islands
danilo62	539055759	Yemen
nogueirajuliana	966427013	Cayman Islands
smoreira	U42813558	Puerto Rico
sheltonstacey	D48342759	Palestine
asilveira	773197962	Maldives
viniciusmarques	275989746	Bulgaria
yda-costa	Y76754457	Kyrgyzstan
jeremy36	975858365	Kiribati
lunnaalves	827294886	Hong Kong
caroline39	697830930	Thailand
rebeccaperez	897786039	Haiti
pedrorocha	049831536	Comoros
tallison	183099480	Kazakhstan
fleao	123626397	Ghana
daviskristin	902704757	Mauritius
scamara	571150136	Trinidad and Tobago
yangnicole	106929090	South Africa
maria-isis09	R16556247	Turkmenistan
rezenderael	242056294	Samoa
rodriguesana-vitoria	F46161751	Iran
anna-liz69	996651044	Turkmenistan
jbrewer	385102322	Eswatini
bfreitas	U47260429	Vanuatu
kylehuang	U95995257	Tunisia
hfarias	220131105	Lesotho
kcunha	I93318519	Russia
djackson	568009574	Bulgaria
olivia86	396066901	Philippines
gfogaca	Q37666992	Saint Lucia
leemiguel	092832845	United Arab Emirates
larissa57	488863434	Ghana
ysilva	969090262	South Africa
luiza38	O71833392	Indonesia
wnascimento	P89025336	Uruguay
ahill	G52240398	Gambia
jonathonhernandez	052174186	Djibouti
lisahernandez	659432526	Bahrain
stantonseth	491448182	Armenia
ocavalcante	W35068828	Cambodia
ana-clara04	Q20544628	United Arab Emirates
fwilliams	744308730	Samoa
otto82	999692290	Kyrgyzstan
da-cunhaaugusto	232633659	Thailand
benjamimduarte	X36293413	Thailand
heloisa08	F56175043	Seychelles
saantony	Z82890936	Ukraine
ksales	149979116	Liberia
rferguson	X03819678	Namibia
kevin57	F47036368	Lesotho
calebe53	O94367078	Hong Kong
andrewarmstrong	W48651371	Costa Rica
maria-helenaribeiro	670364224	Philippines
machadoenrico	C72541212	Niue
stephanie20	815136049	Bermuda
da-rochagael-henrique	D84042811	Dominican Republic
erikarogers	751279867	Rwanda
nchambers	685200498	Turkey
andre99	834984434	Hungary
yago18	043732102	Suriname
montenegroaurora	Q13167242	Madagascar
danilo62	U16003713	Bahamas
alecmurray	Q76204561	Nicaragua
mendoncaana-carolina	U02473428	Moldova
albuquerquelucca	G90735668	Cape Verde
kellyhampton	P31762437	Uruguay
zda-mota	Z53986981	Serbia
allentina	Y09450813	Taiwan
john13	A49843017	Cambodia
uwalker	171829520	Namibia
maria-cecilia07	867880545	Mongolia
qsolis	080336759	Botswana
foleymargaret	G00151201	Papua New Guinea
amystanley	456159601	Liberia
luiz-otavioda-costa	L30134849	Jordan
ymejia	352264853	Ukraine
darrell34	712366184	Honduras
mharrison	468735488	Singapore
andrewhughes	E94205102	Indonesia
stella93	951369120	Pakistan
camaravicente	930429684	Eswatini
toddbanks	197161610	Uzbekistan
brownmark	C34553751	Jamaica
benjamimduarte	918306484	Samoa
karen45	928198078	Saudi Arabia
sandrarice	728042819	Jordan
danilo62	J45201442	Andorra
davi-miguelporto	N58770251	Iceland
barbara39	851216286	India
clarice02	959984652	Kazakhstan
kimberly23	I55463384	Albania
amacedo	D64751388	Mexico
ottoribeiro	W60321494	Andorra
dawn99	277114205	Hungary
gcorreia	306523538	Hong Kong
igeorge	873269787	Falkland Islands
leemiguel	161662571	Czechia
jcorreia	G63880592	Gambia
xharper	U29284976	Indonesia
aylamoraes	182724051	Singapore
josue67	P06648364	Saint Lucia
andreadunn	036621833	Jordan
jose-pedro32	E39127742	Bangladesh
christine94	487094393	Cape Verde
machadodavi	093255623	Eritrea
sara35	I61667368	Serbia
antoniosalinas	009117690	Ukraine
tmcdonald	S99925376	Puerto Rico
chadhutchinson	G15863294	Mexico
lawrence63	520830671	Madagascar
luanaaragao	F51574168	Eritrea
carrie86	S12434355	Ethiopia
sanchezjessica	965832206	Kiribati
tammy33	795753572	Bangladesh
erinhernandez	323612311	Israel
usilva	291971463	Iran
fda-mota	J23873806	Eritrea
joao98	T45262742	Chile
novaisalice	344687393	Saint Lucia
andresbrooks	W58664612	Georgia
kingshannon	B65738168	Bahrain
sabreno	134945054	Israel
milenamonteiro	E41940085	Zambia
scott63	085938951	Falkland Islands
nsilva	J48099044	Cape Verde
hellena59	X09775814	Maldives
bcarvalho	560998484	Liechtenstein
wcaldeira	J67119088	Comoros
pwilson	R33805081	South Africa
daniellesalas	D86165325	Papua New Guinea
hnunes	871554512	Ethiopia
antonio97	514978569	Thailand
kmoraes	F85326848	Bulgaria
timothybecker	286739888	Bahrain
sara13	G66777378	Zambia
carrollleslie	F44286215	DR Congo
ana-lizmelo	592334931	South Africa
richardclark	347315044	Paraguay
peter38	832545425	Canada
tuckermichele	577080603	Argentina
angelapatel	T42534905	North Korea
ana-lauranovais	Q04716359	Ethiopia
luiz-felipe82	094428490	Brazil
joshua72	730512530	Belize
anthony24	431773354	Liberia
pgreen	W86447959	Singapore
marymontgomery	826070778	Vanuatu
kimberly61	Z50635363	Cambodia
toliveira	257566120	Bosnia and Herzegovina
amandahernandez	X88423008	Bahamas
hannah47	753694571	Haiti
luana98	Y28859504	Mexico
hnogueira	R26898324	Syria
benjamin72	F72400831	Cuba
newtonkevin	W50595955	Laos
milenamonteiro	U07056029	Cambodia
esa	U96916298	Tonga
fsampaio	193083571	Tunisia
michaelclayton	F95549724	Jordan
loriestes	407553132	Tajikistan
johnathan94	432862710	Belize
hansonsean	A62377936	Sudan
norriskelly	I59381860	Belize
david13	O23022569	Malawi
lamblindsay	647464945	Hong Kong
lynnsamuel	G63588003	Kazakhstan
hmiller	P79340126	Wallis and Futuna
petergonzales	567637914	Madagascar
joao-guilherme76	596072771	Belize
christine35	P81825729	Somalia
tylerglenn	360433111	Guatemala
rwilson	157130993	Oman
mariamendonca	Z78159219	Peru
brandismith	Y74900253	Burundi
sampaiohellena	O32974413	Saudi Arabia
michaelhoward	831648232	Japan
siqueiradaniel	P11305109	Ukraine
ashleysmith	O39040770	Czechia
troy86	123787057	North Korea
megan60	I61886736	Somalia
imoore	414322654	Kiribati
andrewhughes	E39458683	Lesotho
christine16	E48065866	Papua New Guinea
johnathan94	153676194	Bangladesh
paulwhitaker	X32395800	Burundi
luigi16	008890880	Zambia
bianca33	P72490371	Djibouti
maria-vitoriada-conceicao	Q18759879	Taiwan
margaret46	M45145422	Norway
elizabeth56	Q67439908	Pakistan
levisampaio	A13891561	Mongolia
stephanie52	S77406817	Hong Kong
marcelo49	N02229886	Norway
kcunha	246316394	Comoros
caua91	N15047016	Laos
oliviaaparecida	I36215382	Canada
carrollleslie	U04476163	Nigeria
speterson	777650401	Comoros
jason96	978363488	South Korea
marianapimenta	710121374	Peru
bellagarcia	P71843773	Central African Republic
zpimenta	134313170	Malawi
larissa57	153395507	North Korea
benicio42	V01029038	Nigeria
yago18	683852971	Niue
christine16	179175283	Guinea
rodriguesfernando	D09049286	Andorra
matteo40	596328183	Kyrgyzstan
caitlinhiggins	S08090689	Liberia
edwardstravis	A87837219	Hong Kong
ana-clara04	H31837468	Rwanda
ralves	424515870	Russia
erikarogers	X55220852	Ethiopia
crystal01	088035837	Palestine
ksales	O76517183	Bosnia and Herzegovina
laurenramirez	O45374994	Brazil
davi-luizda-conceicao	588260307	Central African Republic
melina07	K09017747	Serbia
ashleysmith	V99768409	Mongolia
villaricky	682217140	Dominican Republic
scott56	O10781420	Bermuda
anna-liz69	588656483	Burundi
wnascimento	V91658351	United Arab Emirates
da-pazluiz-henrique	036812823	Philippines
hvasconcelos	193890693	Andorra
asilva	H45986327	Bahrain
anada-cunha	Q48133753	Chile
apacheco	262162352	Peru
cda-cruz	795334001	Rwanda
nunesguilherme	Q18795646	Brazil
ana-lizfernandes	551054124	Kazakhstan
mcopeland	Z92499042	Cayman Islands
lvieira	362252819	Kiribati
marianegomes	792018678	Kazakhstan
ksales	556731512	Chile
zmalone	005682156	Kazakhstan
gregory22	368233785	Russia
breno23	W11955594	Central African Republic
cohencarmen	823734911	Chile
stephanie20	N10265209	Bosnia and Herzegovina
teresapierce	B07690848	Cuba
hornejoshua	M48421071	Yemen
josephstewart	224322372	Cuba
igor17	311268215	Belize
igor17	K12267603	Namibia
sara35	259051509	Brunei
ffernandes	915315338	Ethiopia
mirella39	426331869	Sweden
butlerelizabeth	F96625474	Western Sahara
matteo40	R25349425	Vanuatu
ipastor	H98875717	Fiji
brandismith	O07802308	Sudan
mistymartinez	367155796	Western Sahara
richard62	591632006	Peru
ana-beatriz19	Y73545400	Hungary
siqueiracecilia	L45750156	Guinea
marianegomes	436338353	Dominican Republic
thompsonadam	847494638	Serbia
bellaborges	607268303	Andorra
pietro81	984911500	Argentina
jacobmcconnell	241861259	South Korea
rodneyrosales	W57471213	Taiwan
bellagarcia	S25091344	Djibouti
janebrown	Y28764251	Suriname
torreswyatt	X92904817	Costa Rica
danilo62	J57981717	Oman
reynoldstravis	Q62156817	Central African Republic
jcamacho	181230434	Macau
isaac15	B83551908	Poland
henrythomas	263787640	Pakistan
julia16	102844136	Papua New Guinea
imoore	G31325449	Ivory Coast
rcassiano	474912910	Papua New Guinea
allenashley	P53991325	North Korea
kristie75	601638944	United Arab Emirates
benjamin34	371438115	Kyrgyzstan
qmendes	541350016	Kyrgyzstan
vasconcelosliz	734931500	Costa Rica
john03	G32876524	Malawi
juanda-costa	956240464	Bulgaria
anna-liz69	637172531	Serbia
cpope	C32373491	Romania
albuquerquefernando	970254980	Iceland
duanehatfield	761979173	Bosnia and Herzegovina
carolineda-rocha	581420449	Morocco
qmoreira	150220879	Aruba
ana-lauranovais	345053682	Poland
peixotojosue	Q38266147	Cuba
crystal01	R59723987	Malawi
josephmartinez	810007488	Iceland
nicolas74	584844057	Namibia
lporto	D93738379	Suriname
kparker	219400513	Morocco
leo22	C91335157	Suriname
amanda12	T94286994	Ethiopia
portolivia	C08631805	Ukraine
cavalcantiana-luiza	Q95975278	Belize
bianca52	D81727512	South Korea
loriestes	Y24624587	Wallis and Futuna
igeorge	C11545395	Curaçao
kwells	385021945	Guatemala
speixoto	477296175	Indonesia
melissawilliams	521750578	Haiti
zramirez	R30585468	Argentina
zpimenta	625994121	Iceland
bda-costa	S76333057	Tajikistan
sampaiomaria-cecilia	450616986	Kyrgyzstan
borgesheitor	870285361	Macau
yago18	751639485	Nigeria
mfogaca	177574525	Georgia
henrythomas	128463606	Vietnam
lpimenta	699546188	Myanmar
duarteheitor	622420952	Bahamas
kevin72	V15417859	Papua New Guinea
da-rochapietra	084918237	Brunei
anthonybreanna	U68836777	Thailand
thomasgeorge	680375588	Chile
cunhamateus	L57738472	Uruguay
ysilveira	411812543	Liberia
ottoribeiro	L89651108	China
johnsonmichele	789101840	Ethiopia
heitorda-mota	X25858326	Israel
angelapatel	399497139	Peru
kellyreyes	K00088694	Trinidad and Tobago
krystalsanchez	183999414	Niue
davi-miguelporto	359238286	Namibia
nunesguilherme	592024049	Andorra
jcamacho	J86509445	Brunei
amandajackson	213060006	Dominican Republic
zramirez	008844098	Hong Kong
maria-florpinto	805113197	Andorra
sperry	592715590	Iran
fdiaz	P21486941	Ghana
cerickson	803684901	Kazakhstan
rcassiano	I90986737	Brazil
xoliveira	Z04928397	Somalia
esa	G60596484	Liberia
bradshawkristy	169136012	Niue
brandonmendoza	511442083	United Arab Emirates
thomas16	O43344318	Mongolia
ntapia	349794172	Gambia
angela41	831625657	Argentina
mharrison	382799290	Mongolia
ipastor	H19966358	Bahamas
agatha07	536131813	Mexico
hmiller	N80665007	Tajikistan
luiz-felipealbuquerque	045198025	Central African Republic
amberhernandez	189521075	Liberia
cunhamateus	648058625	Bangladesh
yago18	278114983	Peru
cmclaughlin	081387223	Cambodia
luigi16	F80933772	Moldova
gda-rocha	B52022593	Nigeria
wpeters	694987555	Thailand
eric07	Y37191704	Suriname
castanedamelanie	Y17272409	India
fcamara	119251421	India
yparks	C21888240	Maldives
nogueirajuliana	150459559	Colombia
devin93	C57223319	Guinea
amygarza	W74841645	Pakistan
michaelmolina	H49646763	Yemen
kevin57	626289929	United Arab Emirates
felipe12	W52480613	China
caitlinmckenzie	837709275	China
bnovaes	P17662093	Madagascar
pteixeira	G44039415	Maldives
richard44	583556394	Cayman Islands
leaoravi	162516972	China
rebecada-mota	Q43846162	Bolivia
alyssadorsey	T64666841	Suriname
eileenritter	972608324	Yemen
rhavi72	R09144869	Syria
elizabethjohnson	A82928481	Bulgaria
amandajackson	032028861	Ghana
alice85	902432879	Philippines
labreu	F35471419	Liberia
ida-luz	010067084	China
rodriguesfernando	S73880862	Bosnia and Herzegovina
carrie86	534452186	Tonga
maxwelllaura	840717364	Comoros
liz61	507046446	Lesotho
mcardoso	179317241	Russia
johnathan94	954848919	Somalia
sampaiomaria-cecilia	L26922544	Nicaragua
palmeida	G89159834	Curaçao
machadovalentina	C76558706	Bolivia
amacedo	001301500	Turkey
bjesus	266100568	Macau
bowmansylvia	386827097	Liechtenstein
nsilva	034102711	Tajikistan
zrodriguez	731824732	Macau
josue67	G72672258	Burundi
qda-cunha	J78749212	Turkmenistan
cody07	L03340162	Sweden
warnernicholas	C97105788	Nicaragua
uribeiro	459645131	Oman
juanvargas	553198830	Brazil
ana-julia54	570894297	Falkland Islands
gleao	261579595	Zambia
amanda40	730784331	Ivory Coast
maitepimenta	483157336	Papua New Guinea
jeffreydavis	648574653	Ukraine
williamsondennis	403370268	Kyrgyzstan
joao-guilherme76	O46984177	Dominican Republic
paul07	230816618	Guatemala
dda-rosa	715260414	Djibouti
jsales	O55551171	Nicaragua
leo22	O95279650	Philippines
qsolis	780559767	Macau
bradshawkristy	U63122208	Kiribati
borgesmilena	M50160873	Jordan
\.


--
-- TOC entry 5281 (class 0 OID 16625)
-- Dependencies: 266
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (nick, email, data_nasc, telefone, end_postal, pais_resid) FROM stdin;
anthony24	qbarros@example.com	1924-03-09	001-780-770-4579x9313	Parque Pereira, 16, São José, 20122318 Pimenta / RN	Argentina
amandaglass	cassandra98@example.org	1919-04-28	676-483-7259	Largo de Cavalcante, 74, Vila Nova Dos Milionarios, 19978220 Câmara de da Rocha / SP	Panama
hhernandez	snyderandrew@example.net	1951-11-05	(081) 1203-1189	Colônia da Luz, 822, Vila Santa Rosa, 20067961 da Rosa Grande / PA	South Korea
nsilva	asingh@example.org	1986-09-23	(544)592-1907x9058	3048 Brenda Road, Jasonland, MD 07585	Jordan
ufrederick	weberkimberly@example.com	1956-12-22	(544)878-9607	Rua Casa Grande, 198, Jatobá, 13366-760 Mendes da Serra / TO	Yemen
agathapacheco	wilsonaaron@example.net	1980-12-26	443-547-2838x809	98206 Gerald Row, Joshuaview, FL 20448	Samoa
maria-fernandacavalcante	novaisjose@example.net	1949-02-12	(217)374-9615x44504	Estrada Pacheco, 331, Gutierrez, 47446104 das Neves / RJ	Ukraine
tyronerichard	aragaomaria-liz@example.net	2000-09-27	+55 84 9083-8122	Via Arthur Gabriel Pimenta, 22, Cidade Jardim Taquaril, 61005-323 Vieira das Flores / SE	Andorra
osoto	lydia87@example.com	2012-03-23	61 0646 4098	23650 Michaela Island, East Danielville, ID 62766	Bosnia and Herzegovina
zramirez	james70@example.org	1929-07-15	+1-918-803-4337	Viaduto Calebe Araújo, 768, Pindorama, 85834293 da Costa da Prata / GO	India
julia29	peixotoanna-liz@example.net	1946-06-29	(576)464-9636x2835	Unit 8886 Box 2932, DPO AP 46735	Iceland
diasrhavi	johnsonchristina@example.net	1997-07-08	691.364.8848x426	2823 Denise Road, Port Aaron, RI 08427	Philippines
kingshannon	joana73@example.org	1967-07-02	51 2377 0357	Viela Rael Ferreira, 33, Salgado Filho, 14582211 Pastor / RR	Romania
stephanie52	ismith@example.com	1925-01-13	0500-158-0849	Vila Henry Pimenta, 66, Vila Madre Gertrudes 3ª Seção, 53407-372 Pinto / DF	Syria
kellyroy	portoluara@example.org	1979-02-12	685.670.8218	74187 Joshua Mission Apt. 252, South Michaelburgh, AL 54609	Sri Lanka
petergonzales	heloisacirino@example.net	1982-06-26	800-319-2022	Praia Silveira, 42, Leonina, 68725958 Macedo Paulista / MA	Brunei
angela74	cecilia42@example.org	1913-06-23	2753887754	Favela de Casa Grande, 87, Álvaro Camargos, 97595823 Barbosa / SC	Panama
oazevedo	kelliferguson@example.com	2011-08-18	21 6031 2138	Viaduto Moraes, 24, Vila Nova Gameleira 3ª Seção, 75593836 Cirino / MA	Trinidad and Tobago
sanchezjessica	anthony19@example.com	1929-05-16	+55 (031) 9314-7525	Viela Enrico Viana, 7, Aparecida, 43260284 da Rosa de Garcia / MA	Russia
maxwelllaura	angela66@example.org	1935-12-26	619.485.6473	3136 Wong Radial Apt. 676, Port Melissa, MD 23195	Argentina
conniebaker	agatharibeiro@example.org	1962-08-11	(061) 6608 9068	Esplanada da Paz, 7, Pirineus, 32450667 Macedo / BA	Serbia
joao-lucasabreu	isadora95@example.net	1986-03-07	(672)441-4142x5986	1037 Nelson Ports Apt. 449, Nicholstown, NH 95332	Chile
eloasouza	matthew26@example.net	1933-01-07	583.861.3952x2748	Via Ana Sophia da Rosa, 84, Mangabeiras, 83423-450 Carvalho / RR	Comoros
kevin91	anne25@example.org	1955-09-29	11 0059 4547	8814 Long Lodge Apt. 146, Crawfordhaven, IN 19686	Rwanda
theosales	arthurwhite@example.com	1958-10-19	+55 (011) 2199 3773	Aeroporto de Costela, 42, Outro, 45345-981 da Rocha Paulista / PR	Wallis and Futuna
aylla93	ramirezwendy@example.com	1976-12-12	(021) 6935-2890	Conjunto Caldeira, 445, Alta Tensão 2ª Seção, 67736-725 Costa de Vieira / PE	Ukraine
john03	kelly84@example.com	1965-02-04	635.627.5335x70648	Aeroporto Amanda Lima, 346, Penha, 52041471 Lopes do Amparo / RS	Ivory Coast
darrell34	isis20@example.net	1980-09-17	+55 71 2762 3346	773 Emily Cliffs Suite 027, East Kentstad, TN 36730	Taiwan
zsilva	ricky04@example.org	1911-06-05	+55 (061) 5549 9641	773 Perry Roads Suite 206, North Christineburgh, WV 13658	Liechtenstein
mirella39	lindaallison@example.org	1936-10-30	001-452-754-6397x66711	16023 Flores Road Apt. 140, Wisemouth, CT 88118	Uruguay
aparecidajose-pedro	diasraquel@example.com	1946-08-17	(051) 6112-9134	Vale de Costa, 43, Bandeirantes, 14485313 Pereira / RN	Lesotho
fda-mota	ateixeira@example.org	1960-08-16	+1-649-288-1234x5604	6178 Young Isle Suite 330, New Darrenview, FM 40263	Jordan
xfoster	hadassa88@example.org	1925-05-24	(889)906-8727	Quadra Fogaça, 91, Vila Nova Gameleira 1ª Seção, 28638651 Campos do Campo / TO	India
bnovaes	derek63@example.org	1996-12-23	(217)819-7122x072	Morro Aparecida, 1, Nova Granada, 31404-887 Pimenta de das Neves / PE	Gambia
keithhernandez	monteiroleandro@example.com	1970-03-25	+55 (061) 4532 7616	Alameda Caroline Melo, 89, Túnel De Ibirité, 62514962 Sales / RO	Guatemala
gerald64	stephanie78@example.com	1958-05-18	+1-435-547-0797	29791 Rios Square, West Michael, TN 40480	Liechtenstein
mckinneyanthony	ryan27@example.net	2007-10-14	9452443079	355 Meyer Bridge, North Tanya, NM 46468	Saint Lucia
michele07	yagogarcia@example.org	1951-08-18	865.767.5789	Praça Fernandes, 27, Paquetá, 07516504 Vargas / RR	Sudan
rodneyrosales	joaquimgomes@example.org	1915-12-05	(084) 4907-7037	1124 Cobb Plain, New Julieborough, NY 78035	Syria
christine16	eloa45@example.com	1993-05-19	963-337-2537x0959	45637 Ashley Stravenue Apt. 521, North Matthew, CT 30292	Guinea
jesusdanilo	jamie00@example.org	1935-02-07	256.657.8574	Lago de Martins, 920, Cidade Jardim Taquaril, 18560-091 da Rocha / PE	Kiribati
speterson	spimenta@example.net	1990-05-27	+55 (041) 0211-7324	Quadra Ferreira, Vila Cloris, 90610-369 Vargas / AL	Hungary
cunhajoana	normanstark@example.net	1954-10-01	7187651226	Conjunto de Camargo, Novo Das Industrias, 23259441 Rocha Grande / BA	Palestine
meghan16	psantos@example.com	1993-05-16	(294)926-1694	Vale Casa Grande, 48, Floramar, 90593-605 Alves das Flores / AC	Djibouti
machadoenrico	enzofernandes@example.com	1978-09-01	0500-867-0821	Alameda Ana Vitória Brito, 73, São Jorge 1ª Seção, 46097178 Costa do Galho / MS	Guatemala
mariane71	hernandeztina@example.org	1994-09-26	722-782-9996x42126	Vila Letícia das Neves, Jardim Montanhês, 08630-367 Costa / PI	Bosnia and Herzegovina
liammontenegro	ldas-neves@example.net	1919-01-30	726-896-4618	Esplanada de Azevedo, 66, Flavio Marques Lisboa, 09750-143 Ramos / SC	Saudi Arabia
da-motavitor-hugo	robert79@example.com	1974-11-02	(528)297-2684	23900 Saunders Court, Amberland, AS 46503	Honduras
ffernandes	nicole64@example.net	1945-05-05	001-253-995-1936x378	322 Prince Islands, Bushport, PA 93341	India
tblevins	quinndiane@example.net	1940-09-21	+55 (081) 1655-9805	Vila de Machado, 51, Vila Barragem Santa Lúcia, 29091-336 Câmara do Sul / RO	Czechia
krystalsanchez	william67@example.org	1999-10-31	(051) 3506-1903	9409 Ann Cove, Griffinbury, CT 41539	Central African Republic
thiagocastro	gordondanielle@example.com	1934-09-08	275-724-3011	07031 Jonathan Run Suite 242, East Kristen, FM 87659	Central African Republic
montenegroaurora	caldeiraravi-lucca@example.org	2002-03-27	788.268.1868x63613	Loteamento Lima, 720, Estoril, 46441-666 Pimenta da Serra / SE	Kiribati
ericjordan	isabellada-cruz@example.net	1945-06-19	796-868-3350x5631	Condomínio Cirino, Conjunto Capitão Eduardo, 58917047 Melo das Pedras / TO	Kyrgyzstan
correiaheloisa	maysarah@example.org	1950-11-29	71 1442 5122	Condomínio da Luz, 801, Itatiaia, 08215-955 Santos / RR	Eritrea
andreadunn	ssmith@example.com	1957-10-16	+1-410-692-2999	215 Stephen Stravenue, New Garyborough, KS 19302	Bulgaria
francisco74	millerjohnny@example.com	1935-02-27	+55 41 9046 4639	Largo Porto, 33, Jardim Do Vale, 48071-566 Rios de Cirino / PA	Philippines
gonzalesrobert	lweaver@example.org	1992-05-26	+55 84 3614-9619	3424 Jose Mission, Stevenmouth, NJ 54345	Yemen
lgonzales	zsantos@example.com	1925-09-12	581-910-3443x79965	96320 Gardner Station, Smallfurt, WY 08430	Cape Verde
gmontoya	jeffreyrivera@example.org	1948-09-13	41 0832-6577	62161 Charles Pine Apt. 560, New Mark, FM 07233	Bahamas
raquel37	pedro-lucasfonseca@example.com	1961-05-02	001-868-252-2542x47595	Trevo de Gomes, 52, Santa Tereza, 09762004 da Costa / CE	Maldives
thomasnguyen	ianherman@example.org	1981-08-13	438.579.7170x09762	1329 Fletcher Manor Suite 589, Englishmouth, VI 67888	Jamaica
paulwhitaker	jenkinssharon@example.org	1913-01-16	001-210-297-5569x103	Conjunto Diego Nunes, Aarão Reis, 28488141 da Conceição das Pedras / AC	Chile
jason96	torrespaul@example.org	1968-01-27	84 5783-6551	139 Taylor Roads, North Richard, PR 28906	Moldova
jose-miguelmoreira	opeterson@example.org	1935-04-11	0300 927 0690	338 Anderson Gardens, Nelsonton, NM 10296	Dominican Republic
martinlauren	wsims@example.net	1956-08-28	001-592-741-2742x388	7836 Villegas Fields Suite 517, North Justinberg, IL 18534	Cuba
tpimenta	esterdias@example.com	1997-12-12	(632)655-8409	58409 Greer Dam, Duranburgh, IN 86652	Botswana
pietro81	agatha46@example.net	2007-10-04	(051) 3639 4483	Vereda de Silveira, Nova Suíça, 00672-493 da Cruz / BA	Hungary
westcollin	monteszachary@example.org	1968-08-31	+55 31 5828-6478	183 Long Pines, New Kathy, MH 32885	Western Sahara
fernandacirino	caldeirabenjamim@example.org	1987-08-19	(011) 4171 1650	605 Michael Land Apt. 074, Williamsberg, NC 36119	Yemen
siqueiracecilia	johnsonkristen@example.org	1959-08-10	383-742-4451	Viela Henry Machado, 900, Saudade, 40506158 da Rocha do Campo / AL	Bermuda
murillomelissa	brunolima@example.com	1912-03-18	767-578-6994x5309	Recanto de Rocha, 242, Leonina, 19524195 Pastor / SC	Moldova
kinglauren	sarah81@example.org	1959-09-02	001-234-584-5004x17627	Estrada Mathias Araújo, 9, Heliopolis, 49513-151 Nogueira das Flores / SP	Turkmenistan
anthonybreanna	velasquezsteven@example.com	1919-09-27	+1-693-724-1451x375	40318 Devin Prairie Apt. 555, New Pamela, TN 95825	Saudi Arabia
lewing	qpereira@example.org	1938-01-24	819.706.7444x1412	50148 Carrie Landing Apt. 774, Mannville, SC 28389	Maldives
vleonard	omoura@example.net	1947-03-13	001-575-304-6796x76277	35444 Carroll Falls, Kathrynborough, MN 54414	Aruba
rael29	rribeiro@example.com	1979-04-12	+55 (031) 3054 9158	289 Alexander Radial, Williamsborough, DC 93955	Uzbekistan
davi-miguelborges	sullivanchristopher@example.net	1936-12-28	0900 360 9938	7352 William Garden, North Samuel, AS 74373	Seychelles
ana82	dreed@example.net	1976-04-19	432-965-8290x62847	95903 Moore Haven, West Joannefort, NH 72765	Bahrain
smoreira	lorenzopereira@example.org	1992-09-22	+1-642-299-2550	Conjunto de Vargas, 4, Lagoinha, 53757595 Campos de da Mata / RS	India
milenamonteiro	vbarbosa@example.net	1922-11-01	84 2598-3938	008 Michael Square Suite 877, Dunlapland, CO 53226	Falkland Islands
smeyers	nascimentoana@example.net	1926-04-27	(021) 5515-2877	Trecho Barbosa, 5, Graça, 06054022 Fernandes / RO	Paraguay
luisaduarte	ashleychase@example.com	1926-02-25	301-435-3677x776	575 Christy Prairie Suite 404, Lake Ralph, CT 05611	Kyrgyzstan
camposana-julia	dmoore@example.org	1947-04-12	762-290-8336	3311 White Coves, Martineztown, VI 23786	Hungary
roberto71	fordstephanie@example.com	2002-06-13	+1-511-929-5914	44188 Johnson Crescent Suite 553, North David, KS 93875	South Korea
mariamendonca	guilherme82@example.com	1992-07-10	992-393-4750	Esplanada de da Conceição, 690, Santa Margarida, 31607937 Mendes / SE	Samoa
da-cruzbruna	matheuslopes@example.net	1981-03-22	81 6779 6536	Quadra da Rosa, 34, Bonfim, 73465843 Mendes de Camargo / PB	Costa Rica
annette61	imoura@example.com	1997-11-24	+55 71 4605 0126	Trevo Vasconcelos, São Jorge 1ª Seção, 13925493 Pastor / PR	Norway
salasdebra	iwarren@example.net	1952-04-08	(616)771-9005x99172	Loteamento de da Cruz, 6, Vila São Gabriel Jacui, 49511-724 Pires das Flores / PE	Tunisia
wpeters	benicio98@example.org	1971-04-16	+55 (084) 0538 3702	7270 Wayne Circles Suite 323, West Micheleshire, WA 84867	Brunei
wdas-neves	jasmine29@example.org	1937-02-20	756.816.3589	48729 Kristine Stream, New Paulmouth, IN 78661	Tanzania
das-nevesmiguel	dhall@example.org	1991-11-10	(061) 1310-4124	39543 Thomas Curve Apt. 806, South Raymond, MS 77075	Guatemala
james30	marina15@example.net	1999-09-15	773-993-6430	572 Taylor Inlet Suite 642, Lake Felicia, VI 53782	Colombia
xrandolph	ncamargo@example.com	1919-09-14	001-889-933-8660x896	8761 Kevin Ville Suite 886, East Taylorport, AS 67144	Trinidad and Tobago
qda-cunha	sabrina87@example.net	2008-04-13	+55 (021) 3928-1540	Quadra Ana Lívia Silveira, Vila Jardim São José, 15090528 Silva de Minas / SP	India
matteo90	reevesandrew@example.com	1922-05-06	0800-699-2784	03658 Robert Cliffs Suite 817, Lake Andrew, MN 93652	Ethiopia
yuricavalcante	melissa38@example.net	1940-08-13	+55 (081) 7187 3721	165 Christopher Stravenue Suite 412, Gordonville, NY 16667	Israel
anagarcia	maria-luisarocha@example.net	1942-03-03	+1-288-594-2774x083	Lago Davi Luiz Nogueira, 40, Jardinópolis, 28592153 Lima das Pedras / MA	Israel
dnogueira	brittany58@example.net	1970-01-12	+55 81 7670 5633	86342 Lacey Ports, Greeneborough, NH 00605	Philippines
turnerashley	smithmichael@example.org	1981-05-17	677.594.8415x44630	Rodovia Andrade, 45, Tiradentes, 99628883 Jesus Verde / PI	Indonesia
iansampaio	qandrade@example.com	1994-11-16	21 2369-6743	Condomínio Dias, 157, Alípio De Melo, 85426362 Moraes / MT	Papua New Guinea
wcaldeira	borgesisabelly@example.org	1914-02-12	+55 51 2941 7939	32763 Jennifer Spur Suite 496, Floresland, VI 20271	Lesotho
allenjamie	guerrakamilly@example.org	1944-08-05	84 5003-5036	4238 Hayes Shoals Suite 622, Gordonmouth, IN 39513	Mauritius
josephstewart	pgomes@example.com	1977-08-10	(031) 0628 0021	Estação José Miguel Ribeiro, 4, São Francisco Das Chagas, 91052-414 Siqueira / PE	Georgia
qporter	amandalindsey@example.com	1921-08-27	857-652-9326	Setor de da Mata, 27, Vila Bandeirantes, 49463-068 Pastor / SP	Bahrain
stantonseth	michael54@example.com	1912-11-25	001-660-633-6401x08564	Colônia de da Costa, 16, São Gabriel, 91646-676 Teixeira / RR	Paraguay
kevin72	lopeznicholas@example.org	1969-05-05	001-802-680-9119x10272	Alameda Luiz Henrique Fogaça, 6, Prado, 85797121 Sampaio / MG	Zambia
anna-liz69	enzocarvalho@example.com	2003-09-30	51 7249 5472	Vereda Barbosa, 274, Nazare, 73057053 Fogaça / SC	North Korea
rbennett	nathanrocha@example.net	1989-03-10	+1-819-410-3097x99073	Chácara da Paz, 58, Estrela, 76846-208 da Mota / SP	Syria
rileyjames	hburns@example.net	1916-12-11	41 7149 8246	Largo Correia, 3, Ermelinda, 53369041 Campos / ES	Papua New Guinea
teresapierce	browndavid@example.org	1986-10-13	+55 (041) 3443-6882	Viela Farias, 680, Barroca, 09354-740 Lima da Prata / PI	Lesotho
dustin67	amyrandolph@example.org	1963-06-15	+1-788-842-5167	Área Cecilia da Cruz, 46, Jardim Do Vale, 32722507 das Neves / MT	Haiti
amanda03	goncalvesarthur-miguel@example.org	1958-09-23	599-300-2770	17164 Weber Manor Apt. 131, East Victoriafort, KS 11702	Kyrgyzstan
brenda29	erick71@example.net	1951-10-15	+55 (021) 6698 8499	Sítio de Araújo, 58, Vila São Paulo, 75564-658 Sousa da Serra / RJ	Eswatini
phillip92	lorenzopinto@example.net	1937-07-25	(435)491-1899	Praia da Rosa, 324, Vila São João Batista, 08488-795 Pimenta / SE	Macau
guilherme94	kda-mota@example.org	2002-07-08	+55 81 6526 2713	317 Tucker Villages, South Steven, GA 16930	Hungary
gleao	stephaniehanson@example.net	2008-02-03	884-502-6866	8577 Christopher Villages, Nashtown, OR 49482	Rwanda
ana-clara04	conradrobert@example.org	2004-12-07	81 7286-3953	Condomínio Macedo, 968, Marieta 3ª Seção, 52234551 Fonseca / SE	Ivory Coast
lcaldeira	jhall@example.org	1980-11-19	(418)825-6293x8743	Praia de Ferreira, 22, Inconfidência, 29614-527 da Mota do Campo / PA	Haiti
kingelizabeth	da-luzevelyn@example.org	1937-02-03	(574)500-2687x52259	776 John Fork, Dianachester, WY 73201	Oman
david13	samuelbarker@example.net	1923-07-08	958-577-2343x80498	1620 Stephanie Park Suite 396, Perezshire, OH 46762	Bahamas
angel37	larissacavalcanti@example.com	1998-08-08	+55 31 6731-1693	Parque Marques, 24, Granja Werneck, 59008-873 Sá Alegre / BA	Somalia
megan60	troyperry@example.org	1909-12-22	(081) 5126 1163	504 Fowler Islands Apt. 120, Derekberg, IA 21595	Poland
anthony-gabriel35	pedro-miguelaparecida@example.net	1968-11-05	0300 051 4774	419 Frederick Islands Apt. 003, West Jennifer, VI 80967	Central African Republic
anthony02	lunna38@example.org	1941-03-11	367-301-0211x25729	Quadra da Luz, 80, São Gonçalo, 40017406 Marques de Gonçalves / MT	Mauritius
omiller	viniciusda-conceicao@example.net	1936-03-23	51 4237 6851	Vale de Barbosa, 33, Horto, 40454-869 Nascimento Alegre / RO	Bangladesh
saemanuella	ramosjoao-vitor@example.net	1951-03-20	205.367.0814x2414	4999 Samuel Inlet, Williamville, PR 49716	Canada
barrosliz	rcardoso@example.net	1972-06-17	+55 61 4706 5758	Vereda Paulo Silva, 1, Nossa Senhora Da Conceição, 44550-095 Aragão / BA	Rwanda
taragao	piresluiz-fernando@example.net	1996-01-24	+55 (071) 8539 4118	PSC 2321, Box 9914, APO AA 35931	Cuba
gonzalezrobert	ericksonsarah@example.org	1947-12-09	81 1238 3154	Rua Cassiano, 7, Vila Nova Gameleira 3ª Seção, 94730-161 Mendes do Amparo / BA	Israel
crystalfrank	lunnalima@example.org	1986-12-08	+55 (081) 8998-6561	8055 Veronica Motorway Suite 381, Mckayview, WV 02561	Liberia
srocha	barrosdiogo@example.org	1963-07-07	+55 (021) 0128 6756	031 Jasmin Trace, Aimeeborough, DE 70353	Liechtenstein
curtisbuck	sophiepacheco@example.net	1998-10-24	7707069569	4880 Jaime Ridge Suite 088, Paulborough, NE 28425	India
vasconcelosliz	enrico84@example.net	1999-10-19	51 0849 3122	1417 Koch Overpass, West Codyside, NV 68260	Cuba
toddbanks	eloahmendonca@example.com	1962-05-26	736-323-2502x059	05494 Jackson Inlet Apt. 798, South Samanthaport, TX 89339	Andorra
marymontgomery	maria-helenaramos@example.com	1919-10-29	(011) 6508 0367	3690 Phillips Plains Apt. 749, Port Deborah, VA 45066	Puerto Rico
sheltonstacey	ipires@example.org	1982-01-16	(021) 5526-9054	Lago Pimenta, 31, Vila Copasa, 75447-920 Borges / PA	India
bowmanmark	rachelanderson@example.net	1991-02-22	936.961.1015x2421	Parque Dias, 51, Primeiro De Maio, 79102801 Albuquerque Paulista / PA	Namibia
cmclaughlin	nramirez@example.org	1912-11-04	0500 886 7471	34185 Bond Meadows, Julieville, UT 16470	Uganda
luigi16	ihudson@example.org	1961-08-31	460.541.6387x7729	Residencial Monteiro, 73, Capitão Eduardo, 73841766 Sales / ES	Czechia
siqueiradaniel	elizabeth05@example.net	1967-04-09	+55 (031) 2826 7239	Lago Machado, 4, Jardim Atlântico, 65955605 Guerra / PA	Macau
nicolas74	hudsonjennifer@example.com	1970-02-01	+1-904-883-0016x45367	00207 Kevin Pass, New Stacey, AL 58427	Mongolia
bwright	whitney94@example.net	1915-09-08	929-448-5500x769	199 Hensley Underpass Suite 705, New Katherinebury, PA 83083	Belize
torreswyatt	carrielynn@example.com	1924-02-20	(084) 7787 6696	Condomínio Teixeira, 3, Castanheira, 84012-880 Ribeiro do Campo / MT	Saint Helena, Ascension and Tristan da Cunha
cpope	nalbuquerque@example.net	2001-12-21	+55 (021) 4823-1470	522 Margaret Stravenue, Port Marcus, WV 68231	Tanzania
liz61	jamie49@example.org	1977-08-06	664.486.0621	Esplanada Emanuelly das Neves, 654, Santa Rita, 61868016 Sousa das Flores / MG	Laos
alyssa90	jose-miguelfarias@example.org	2007-07-16	211.624.1589x3925	PSC 1253, Box 0843, APO AP 36519	Comoros
arthur09	albuquerquegustavo-henrique@example.net	1961-11-04	41 9689 1271	Praça Diego Gomes, 248, Vila Do Pombal, 49423317 Novais de Pereira / ES	North Korea
fernando10	vasquezhoward@example.net	1924-10-04	+55 (051) 2371 3098	Quadra de Sousa, 49, Jardim São José, 46672-836 Duarte do Oeste / AC	Brazil
melissawilliams	smithaaron@example.com	1977-07-04	(071) 3614-9884	5461 Taylor Harbor Apt. 426, North Ethanfort, NV 68208	Gibraltar
john23	silvazachary@example.com	1955-08-02	61 4786-0923	Vereda de Abreu, 83, Centro, 78025-727 Pires / RS	Papua New Guinea
camarabenjamin	vieiraguilherme@example.net	1928-03-02	+1-345-870-4331	5547 Hancock Estate Apt. 026, Floreston, VT 97986	Japan
ymarques	morrisonmelissa@example.net	1921-12-01	+55 (021) 2074 9396	Chácara Maria Clara Novais, 38, Bernadete, 55275321 Camargo do Sul / PA	Djibouti
lauramoura	eloapacheco@example.net	1949-08-31	365-797-1132x4042	Residencial de Monteiro, 85, Alto Caiçaras, 77205-441 Martins da Mata / MT	Fiji
iwright	john24@example.org	1963-08-19	(061) 7292-7821	Rodovia Stephany Guerra, 82, Buritis, 58961670 Rocha / AP	Armenia
angelapatel	pedro-henrique70@example.net	1982-07-18	001-488-898-7530x46330	1140 Cruz Bypass, Moralesstad, DC 02334	Dominican Republic
andrewhughes	ccassiano@example.com	1975-01-13	001-748-833-9689	524 Alicia Shoals, New Shawnport, WY 17596	Botswana
vegatricia	ottofarias@example.com	1937-02-04	(209)467-8681	Quadra Costela, 33, Frei Leopoldo, 54175-505 Souza / MT	Colombia
christine35	traci91@example.com	1956-02-01	(342)276-0298x816	Vila Nunes, 92, Caiçara - Adelaide, 70327139 da Luz / MA	Wallis and Futuna
luiza38	wguerra@example.com	1918-07-08	0900-097-9272	Unit 4207 Box 4094, DPO AE 55494	Wallis and Futuna
caroline39	waltersmatthew@example.net	2008-06-14	51 9367 4535	8818 Stephanie Shore Apt. 261, Alexisberg, AK 45875	Zambia
patrick44	harringtonmark@example.org	1943-06-29	526-344-3890	Trecho Nogueira, 84, Pirineus, 73936-625 Novaes / PB	Niue
caitlinmckenzie	machadoclarice@example.org	1953-01-10	300-932-4003	6060 Aaron Trace Apt. 436, Hicksfurt, ID 14228	Seychelles
brandonmendoza	jesuspedro-lucas@example.net	1983-10-06	282.429.9613x411	Via Rodrigues, Rio Branco, 63864560 Gomes / PB	Rwanda
limapietro	danielyoung@example.net	1995-09-17	(051) 4918-4217	Distrito Laura Campos, 2, Mangueiras, 26947059 Oliveira de Abreu / AM	Falkland Islands
richardjim	bryan44@example.com	2004-06-23	(041) 6076-8640	0361 Gates Fields, Williamschester, WA 54748	South Africa
lamblindsay	oaparecida@example.net	2000-10-10	+1-980-457-6054x1499	116 Barnett Streets, Toddville, DC 02110	Tonga
novaisisadora	ssmith@example.net	1963-12-29	(041) 2372-8001	Lago da Luz, Vila Coqueiral, 41426-461 da Rosa de Fonseca / RO	Mexico
alexandrefernandes	ryandas-neves@example.org	1984-04-09	+55 51 6380 1861	Trevo de Araújo, Esperança, 68938837 Cardoso / RS	Liberia
meaganbrown	amy24@example.org	2010-12-21	+55 (021) 0813-3149	0344 Michael Parks, Coryberg, ME 17964	Thailand
drogers	whitejoshua@example.net	1970-11-24	662-359-0518	Recanto de Martins, 28, Sion, 42103488 Peixoto / DF	Malaysia
speixoto	adam05@example.org	1917-10-19	(242)841-6278	890 James Parkways Apt. 094, Wadeville, SC 75734	Tanzania
andresbrooks	tcohen@example.net	1913-10-15	(488)633-5015x85310	032 Price Spring, Alvarezton, IA 93511	Malawi
ianaparecida	thomas72@example.org	1978-08-07	(809)373-9207	Distrito Julia Gomes, 10, Nova America, 23706-066 Duarte do Norte / PA	Malaysia
nogueirajuliana	albuquerqueeloah@example.com	1942-11-06	001-588-343-2679x0624	59743 Ernest Freeway, Lake Davidmouth, MA 25464	Moldova
barbara39	mariah90@example.net	1945-05-06	+55 (061) 0879 1384	083 Lowery Circles, Andersonside, MN 87952	Madagascar
marcelafogaca	xeaton@example.org	1964-05-19	+55 31 7369 8648	0221 Ross Terrace Apt. 943, Lambertmouth, AL 16439	Serbia
marquescarlos-eduardo	vieiramaria-clara@example.org	1982-09-17	+55 (084) 2873-1115	Parque de Vargas, 59, Marieta 3ª Seção, 03268560 Almeida de Pastor / MG	Nigeria
anabrito	casa-grandecaio@example.com	1924-09-20	84 2272 7349	Estrada de Pires, 247, Guaratã, 39951227 Machado de Aparecida / CE	Colombia
jeremyjohnson	abreujoao-vitor@example.org	2003-03-19	11 8240-2149	01097 Goodman Bypass Apt. 842, New Elijahchester, TX 23710	Iran
agatha00	franciscovasconcelos@example.com	1923-03-01	(061) 9226 5172	Unit 6736 Box 3942, DPO AP 25464	Costa Rica
pereiraclara	aaronjohnson@example.com	1936-02-12	+1-609-460-9140	47006 Heather Port, Port Ryanshire, VA 02811	Taiwan
morgan48	charlesthomas@example.net	2007-03-20	713-277-1565x8258	Viaduto Cardoso, 84, Bairro Das Indústrias Ii, 50522528 Fernandes do Sul / SC	Japan
tmontgomery	matheus11@example.org	1930-07-09	81 3615 5357	Largo Gonçalves, 45, Chácara Leonina, 54323-966 da Mata / DF	Dominican Republic
monica86	andraderavi-lucca@example.net	1970-10-20	81 5156 5322	Chácara Maria Luísa da Conceição, 971, Ouro Minas, 31016199 Borges de Barros / PE	India
lamdavid	kristen81@example.com	1912-07-12	(315)609-0405	58319 Becky Landing, New Luis, NV 29186	Oman
davi-luizda-conceicao	xdodson@example.net	1955-05-21	+55 81 7985 7678	595 Gabrielle Causeway Apt. 583, Barbaratown, NE 20589	Czechia
kparker	unogueira@example.net	1970-01-18	+55 41 7893-1729	Conjunto Vargas, 13, Havaí, 52917413 da Mata do Oeste / PA	Madagascar
michaelclayton	efarias@example.com	1921-09-29	(445)986-2650x767	597 Hill Way Suite 017, Vanessaview, AR 90157	Chile
lvargas	liviaandrade@example.net	1979-02-06	001-897-212-4535x897	Residencial Leão, 4, Vila Paris, 94218119 da Conceição de Moraes / CE	Oman
nunesguilherme	vvega@example.com	1967-11-04	11 8478 9236	Estrada Aparecida, 261, João Paulo Ii, 18561-892 Vargas / TO	Sri Lanka
tammy33	hcruz@example.com	2013-06-18	11 1218 7462	Condomínio Rocha, Aparecida 7ª Seção, 07461980 Teixeira de da Paz / ES	Liberia
fcamara	vwiggins@example.net	2000-10-27	0500 777 9313	217 Hall Route Apt. 080, Kellymouth, IL 78293	Guinea
ana-lizmelo	anthony46@example.org	1959-09-30	(796)639-2671x009	Setor Sousa, 55, Luxemburgo, 41180782 Moreira / SP	Vietnam
allentina	luiz-henriquemachado@example.net	1959-05-10	+55 61 7027 7113	8774 Anderson Via, Cohenmouth, VI 68734	Vietnam
ryanfernandes	mrobinson@example.net	1950-07-29	001-701-974-1540	2576 Andrew Causeway Suite 506, Matthewburgh, GA 98849	Bangladesh
da-rochacarolina	marcelo13@example.org	1985-01-16	755.344.7455x864	Viela Macedo, 8, Nova Suíça, 90928-209 Camargo / TO	Botswana
jonesalexander	miguelmachado@example.com	1952-12-23	(051) 1350-8216	6863 Eaton Views, Port Sydney, ME 26760	Paraguay
yuriporto	tda-cruz@example.org	1986-10-02	+1-401-238-4179x51360	Passarela de Moraes, 26, Vila Atila De Paiva, 53516869 Abreu / BA	South Korea
bianca52	msilva@example.net	1946-07-22	84 2838-7946	Esplanada Azevedo, 37, São Jorge 3ª Seção, 84835-643 Abreu dos Dourados / BA	Malaysia
andrea86	snovaes@example.com	1914-07-19	403.814.2728x76415	Conjunto de Vasconcelos, Bacurau, 79228-268 Monteiro do Amparo / MA	Georgia
pedrorocha	goncalvesmaya@example.net	1986-01-10	+55 81 2117-3882	61290 Sean Ville Suite 783, North Marcusbury, RI 55782	India
scott63	jordan24@example.net	1957-07-06	61 5739 1683	Favela Costela, 57, João Pinheiro, 91475-774 Sá / GO	Tunisia
carlos-eduardo98	ucamara@example.net	1918-01-21	556-207-2377x0466	412 Coleman Land, Zhangfort, CA 36152	Costa Rica
albuquerquepietra	santosalicia@example.net	2005-12-14	921-455-1653x7656	USNS Kim, FPO AE 17409	Eritrea
kellyreyes	charles26@example.net	1995-06-15	41 8377 2151	Jardim de Lima, 16, Santa Maria, 10140-260 Azevedo Paulista / DF	Paraguay
da-motaaurora	christina59@example.net	1966-07-13	+1-888-569-4696x6287	3263 King Skyway Suite 319, Cobbshire, DE 49201	Vanuatu
lavinia45	caitlinrogers@example.net	1961-12-02	+55 (081) 2463 4690	7003 Price Dam Suite 334, Matthewtown, SC 62991	Lesotho
jeffreylewis	joao-guilherme50@example.org	1977-07-12	537.721.6947	946 Robert Highway, Port Charlesfort, DE 71347	Yemen
cindy39	hwright@example.com	1964-10-19	(041) 9218-5931	71304 Natasha Motorway, East Michael, OH 93569	Jamaica
joao-miguel27	melindawall@example.net	1946-12-30	61 8789-9779	Unit 5484 Box 1237, DPO AA 40330	Suriname
lcampbell	dross@example.org	1972-03-16	4959776357	Feira Ana Lívia Ferreira, 244, Vila Petropolis, 49987-204 Gonçalves de Goiás / SC	Belize
benicio42	udouglas@example.com	1921-01-01	0800-885-9769	885 Dawn Inlet Suite 080, New Sydneyfurt, VT 09431	Burundi
vieirabeatriz	chadhicks@example.net	1957-06-09	+1-272-607-7098x624	45687 Dave Light, Wardtown, PR 02644	Morocco
yparks	crystalhawkins@example.org	1934-06-27	(061) 6351-2937	Vila Raul Aragão, 395, Miramar, 42728299 Silveira das Flores / BA	Malawi
bcarvalho	torresross@example.net	1970-07-12	(705)593-4297x772	812 Barber Port, Moodyhaven, MD 76586	Nicaragua
george31	montenegroantony@example.net	1969-08-01	(081) 1147-9771	75380 Louis Unions, North Amanda, MI 40498	Papua New Guinea
maria-flor01	lucas-gabrielbrito@example.com	2001-08-09	+55 (081) 9635-5236	Esplanada Maria Julia Barbosa, São Vicente, 69564853 da Mata / AM	Liechtenstein
jeremy36	mda-cunha@example.org	1944-05-27	890-371-0005	209 Gray Common Apt. 591, Lake Claudia, AZ 90472	Somalia
phillipssteven	bentosilveira@example.com	1921-06-26	001-495-543-7586x404	3850 Freeman Causeway Apt. 355, East Bradley, IA 71779	Argentina
teixeirastella	gfonseca@example.net	2004-02-12	001-741-792-7544x5827	344 Joshua Parkways, Crawfordberg, UT 04845	Seychelles
gramos	wrezende@example.org	1971-11-12	+1-319-903-7127	33716 Justin Green Suite 231, Adamton, IN 65243	Serbia
norriskelly	davi-lucasaparecida@example.net	1928-03-09	001-982-879-6245x379	204 Morales Garden, Penaside, AR 46767	Uruguay
cavalcantececilia	maria-eduardapinto@example.com	1978-11-12	51 3021 1102	967 Smith Rue Apt. 620, Francisstad, RI 46392	Iceland
jasminerodriguez	aaragao@example.org	2000-07-30	+55 (071) 5855-9153	Condomínio Costa, 18, Xodo-Marize, 97017-638 Vargas / AC	Moldova
bruno15	josephcantrell@example.org	1916-07-08	919.601.3880x873	Aeroporto Camargo, 86, Floramar, 01564186 Sales do Oeste / BA	Eritrea
richard41	aporto@example.com	1914-03-10	(219)604-7096x6762	02670 Cortez Locks, Colechester, WI 20703	Pakistan
caleb01	goodjohn@example.net	1932-01-09	+55 (084) 4430 4628	Área Nunes, 81, Jonas Veiga, 63885535 Lima / MA	Botswana
hornejoshua	nicholasstrickland@example.net	1921-11-11	541.412.1893x055	Lago de Viana, Alto Caiçaras, 60898-249 Silva do Galho / RN	Haiti
benicioaragao	wgray@example.net	1929-11-06	(617)732-4628x165	Núcleo da Mata, 78, Santa Rita De Cássia, 50942-480 Fonseca / ES	Ghana
alexandremachado	douglas18@example.com	1984-10-07	61 4757 7919	Travessa Caldeira, 3, Vila União, 03126-135 Ferreira / AM	Cuba
kaique94	ottoborges@example.com	1925-06-30	51 8106 1616	39076 Melissa Summit Apt. 958, Beasleyport, VT 06337	North Korea
tmcdonald	livia51@example.com	1983-05-14	(956)370-7455x1536	Viaduto Yuri Costa, 762, Vila Nova Gameleira 1ª Seção, 06911-336 Lima / CE	Haiti
erikarogers	josue04@example.org	1917-04-28	520.428.2419x2253	210 Micheal Rapid, Rhondamouth, NC 59100	Malawi
hernandezjason	chavezkatelyn@example.com	1964-06-06	001-456-636-0467x76738	Unit 9251 Box 8564, DPO AA 96493	Thailand
xmarques	lisa22@example.com	1993-08-27	001-671-565-5839x1545	PSC 0771, Box 8465, APO AA 47813	Lesotho
loriestes	garyhester@example.net	1950-04-24	+1-988-950-9139x29750	77512 Amy Flats Apt. 176, North Jeffrey, AS 72207	Paraguay
carrollleslie	robert70@example.com	1929-10-11	+55 (011) 3597-0451	Campo de Duarte, 6, Bonsucesso, 75857294 Guerra / SE	Cuba
aylamoraes	james98@example.net	1980-06-26	380.448.7377x722	665 Parker Burg, Watkinsfurt, OK 31005	Saudi Arabia
imartins	maria-helena58@example.com	1950-08-13	(081) 8794 6491	Via de Moreira, 73, Vila Antena Montanhês, 77192-156 Ramos do Sul / PA	Eritrea
kimberly23	andraderodrigo@example.org	2009-06-13	31 4860 2715	899 Carter Well Apt. 636, Port Krystalburgh, IN 82620	Malawi
melissa41	shannongraves@example.com	2006-01-02	+55 (071) 1723 8761	PSC 0434, Box 4480, APO AA 73519	Gambia
andre53	xrezende@example.com	1947-10-12	0300 684 1452	77158 Simpson Extension Apt. 066, Martinezfurt, TX 89306	Saint Lucia
madisonholland	marcos-viniciuspereira@example.org	1926-08-24	895.913.3749	Rua Moura, 1, Cidade Nova, 59022510 Campos de Mendonça / ES	Maldives
velazquezalan	qschultz@example.net	1984-07-11	(800)803-8050x0386	Esplanada de Andrade, 4, Eymard, 65312258 Novaes / BA	Thailand
fsampaio	olsonholly@example.org	1919-12-13	(011) 8875 9355	Favela Fernandes, 890, Beira Linha, 83941482 Pimenta / DF	Liberia
gda-cruz	costazoe@example.net	1972-01-07	(365)609-5300	673 Smith Meadows, New Rhonda, GU 14075	Cape Verde
zmcknight	zsnyder@example.net	2008-01-20	+1-201-561-5503x930	4258 Nicole Park, Laurashire, IL 12374	Norway
ottocostela	daviddiaz@example.net	1972-02-29	342.758.1752x83466	Largo da Luz, 66, Vila Pilar, 11262312 Garcia / SC	Namibia
hansonsean	labreu@example.net	2001-09-24	+55 61 9997-5282	86552 Fisher Haven, East Nicoleview, TN 34438	Pakistan
fhaynes	garciamariah@example.com	1917-10-20	4758845478	272 Christina Radial Suite 459, North Ianstad, DE 65956	Madagascar
wrezende	gomesenzo@example.org	2000-02-26	+1-677-668-4355x227	42064 Harris Stravenue, East Davidfurt, NE 17355	Rwanda
jgarcia	mcavalcante@example.org	1970-11-05	+55 11 9591-3431	64238 Ramirez Streets, East Richard, MN 53859	Belize
valentinejacob	trezende@example.com	1922-12-03	870.784.3187	Travessa de das Neves, 52, São Luiz, 21949645 Guerra das Flores / PR	Iran
daniela16	brianramos@example.org	1936-04-25	001-353-255-0078	Sítio de Sá, 16, Pantanal, 32840-813 Aragão / RR	Taiwan
wangjennifer	schwartzjessica@example.net	1970-05-11	+1-717-408-6741	Vereda de Pires, 25, Santa Rosa, 27065-934 Porto das Pedras / PA	Bulgaria
rezenderael	camposlucas@example.net	1994-08-10	+1-990-602-2269x360	95516 Hoffman Rest, Garciachester, AL 55775	Bahrain
webstertara	isa@example.net	1910-03-02	(309)433-0928x6031	7667 Judith Center Apt. 458, Coletown, CT 15890	Singapore
williamwoodward	gevans@example.org	1911-12-12	496-544-1653x656	809 Anna Center Apt. 836, Henryton, GU 79142	Sri Lanka
charles88	xgarcia@example.net	1920-08-07	(533)273-9560x8065	Vila Vargas, 29, Corumbiara, 70575-918 Nunes dos Dourados / RN	Norway
newtonkevin	simmonstanya@example.com	1948-10-24	31 6969-3926	1153 Brown Harbor, Jonathanbury, KY 55829	Mauritius
amacedo	baxterrebecca@example.net	1983-09-13	21 7635 6782	Estrada de Pinto, 94, Grajaú, 29646-661 da Rosa / MS	Oman
joao-guilherme76	perezhoward@example.com	1971-10-26	419.653.5511	Fazenda de Abreu, 65, Vila Cloris, 77185-970 Aparecida das Flores / GO	Maldives
madison68	brayanmarques@example.net	1920-11-08	+55 81 7922-3769	Rodovia de Silva, 2, Lourdes, 89152-714 da Luz Grande / PA	Sri Lanka
gregory22	lori58@example.net	2010-08-01	+1-455-742-5300	920 Donald Corners Apt. 427, North Jacob, CT 88533	Kiribati
hornkathryn	jwilliams@example.com	1986-07-28	001-514-783-2213	Distrito Sofia Monteiro, 1, Etelvina Carneiro, 66289-989 Pereira / PA	Eswatini
kamilly26	amberburns@example.com	1933-06-09	(051) 0385-2438	Setor de da Costa, 81, Santa Branca, 55620-127 Casa Grande da Mata / MT	Wallis and Futuna
agatha91	michaelmarshall@example.org	1997-09-09	350-729-8804	Trecho Pastor, 923, Pedreira Padro Lopes, 64083-822 da Luz / MA	Mongolia
villaricky	lavinia68@example.net	2002-05-30	61 4446 3794	Conjunto de Mendonça, Vila Fumec, 42830214 Pereira de Novais / AM	Gibraltar
calebe53	rachel81@example.net	1994-03-09	783.485.2752x74965	Área de Montenegro, 2, Cônego Pinheiro 1ª Seção, 46479-816 da Conceição / PR	DR Congo
joshua52	heitorda-luz@example.com	1994-08-29	(031) 8325 7858	59483 Vanessa Plains Suite 463, South Susan, WI 76713	Kiribati
hvasconcelos	ana-sophiaazevedo@example.com	1939-12-17	001-517-522-8326x18140	7738 Veronica Garden, South Lauratown, CA 02036	Uruguay
elizabeth56	ana-vitoriacosta@example.com	1936-06-07	+55 61 6316-4143	Quadra Maria Luiza Mendonça, 81, São Lucas, 16265-725 Albuquerque / AM	Tajikistan
jeffreydavis	vitor32@example.com	1987-02-21	(051) 3135 8297	Condomínio Araújo, Confisco, 36732302 Machado / MT	Uzbekistan
ana-luiza88	brayan43@example.net	1948-06-18	+55 21 7129-7360	94078 Beth Avenue, Johnnyville, NH 02587	Czechia
stephen26	elizabethroberts@example.net	2012-05-15	+55 (081) 6067-0020	Parque de Ferreira, 33, Conjunto Jardim Filadélfia, 12252949 Rios / RN	Tonga
yda-conceicao	ribeiroanna-liz@example.org	1999-01-12	327.948.7012x418	89288 Caleb Roads, West Kerryville, MS 50123	Costa Rica
bjesus	kamilly03@example.com	1940-06-17	4865542801	Alameda Vitória Novais, Minaslandia, 25452614 Moraes Grande / BA	Botswana
wnascimento	alfred69@example.org	1945-07-05	668-585-9662	4475 Sullivan Villages, Martinport, RI 89500	Nigeria
yda-costa	carol69@example.net	1995-08-03	(051) 5417 1362	656 Jones Greens, Savageville, FL 95076	Pakistan
toliveira	jaraujo@example.net	1992-05-04	(011) 3249 9889	Praia de da Cruz, 20, Palmares, 12917509 Mendonça / PI	Cape Verde
samanthalee	tammy70@example.org	1966-07-03	+55 11 6565-5727	40039 Kristina Dale, North Janice, MA 11536	Morocco
jcorreia	joneshayley@example.net	1991-06-19	0300-725-2441	Setor Thales Cavalcanti, 8, Universo, 05463-955 Barros / RS	Israel
reynoldstravis	mackenziecooper@example.com	2008-03-02	(081) 0781-4928	2432 Villa Union, North Lauren, WA 01735	Belize
ambershepherd	pacosta@example.org	1914-01-10	11 9999-6129	Via de Martins, 27, São Salvador, 42355-981 Mendonça da Serra / BA	Thailand
leaoravi	tiffanyrangel@example.com	1985-05-25	+1-957-360-7604x68675	Parque Luana Teixeira, 19, Campo Alegre, 68301-327 Ferreira / AC	Burundi
kimberly61	peckkevin@example.net	1994-07-21	31 4455-7267	2874 Mark Flat, Tylerberg, GA 77134	Bosnia and Herzegovina
kamillysampaio	davi64@example.net	1993-11-02	001-942-694-8569	44069 Natalie Park Suite 174, Chelseaburgh, WY 15946	China
pereiralivia	martin80@example.com	2007-04-19	41 3405 8738	5497 Maria Burgs, Charlesbury, AL 20372	Gambia
lisa85	anthonypatel@example.net	1992-06-06	+55 51 6558 2574	460 Wright Neck, Lake Samantha, NJ 44802	Morocco
kristen24	deancooper@example.net	1970-05-04	+1-200-779-8191x264	5607 Solis Valleys Apt. 101, Miguelberg, NE 11865	Kenya
warnernicholas	heitor89@example.org	1913-12-27	0300-229-6984	USNS Ferrell, FPO AA 34485	Czechia
michellerussell	eloah59@example.com	2012-12-01	0500 257 2747	Estrada José Miguel Nogueira, 6, Leonina, 54568-022 Gonçalves da Serra / CE	Maldives
ferreirapaulo	caleblove@example.com	1986-07-04	81 8897-3420	Chácara Vargas, Grotinha, 98342-997 da Mata da Mata / AC	Turkmenistan
asmith	araujoana-julia@example.org	1935-11-25	61 0830 9285	748 Donald Islands Suite 908, South Alexandraview, CO 87095	Myanmar
bernardomoraes	nda-paz@example.org	1912-05-24	001-606-715-6749x185	PSC 4926, Box 3741, APO AA 40139	Dominican Republic
clarice02	caldeiravitor-gabriel@example.com	1916-04-11	31 5049 6017	Núcleo de Marques, 19, Paraíso, 04059747 Cunha / MA	Puerto Rico
pteixeira	meganwilson@example.com	1986-05-29	51 0014 1941	83786 Trevor Corner, Lake Krystalside, MP 01778	Colombia
wsales	jamieryan@example.org	1918-09-01	+55 (031) 4274 3243	203 Wanda Tunnel Suite 277, Banksfurt, UT 71353	Macau
xoliveira	pnovaes@example.net	2008-11-08	351.358.6245x53499	Morro Lavínia Moraes, 83, Novo Tupi, 43553-330 Correia / PB	Curaçao
nogueirajoao-vitor	christopheralvarez@example.net	1950-07-13	(081) 0173 9353	Conjunto Arthur Miguel Cunha, 66, São João, 95972920 Pacheco / MG	Moldova
anada-rocha	harveygeorge@example.com	1945-06-18	414.442.1399	Unit 0217 Box 2743, DPO AE 92650	Costa Rica
gabriela30	laraaparecida@example.com	1940-03-11	+1-975-395-4767x525	Campo Isabela Novaes, 6, Heliopolis, 59266578 Sales dos Dourados / AP	India
da-cunhaaugusto	mendeseduardo@example.com	1927-02-01	434-624-2339x7763	Trecho Campos, 59, Vila Piratininga, 86482-154 Nogueira de da Cruz / AL	Costa Rica
luizafernandes	zschwartz@example.net	1983-09-29	(970)524-7303x823	Vereda de Cassiano, 582, Conjunto Paulo Vi, 27974-373 Aparecida / MA	Eswatini
correiajose-miguel	kellyshaw@example.com	1913-09-05	+55 81 7600-8926	Parque Stella Viana, 55, Das Industrias I, 43759843 Lima / SC	Ethiopia
tpires	david88@example.com	1986-09-05	+1-811-542-8579x945	85059 Brenda Place Apt. 567, East Katherineside, MP 60383	Ukraine
ortizedward	uguerra@example.org	1974-06-29	(369)424-0544	59936 John Crossroad, West Karlside, SD 78256	Pakistan
ana-julia54	parkerpaul@example.com	1937-12-24	354.888.8796x6763	141 Lin Unions, Melaniestad, ME 72820	Tunisia
pimentajoao-pedro	maria-isis94@example.com	1933-06-29	(031) 7746-7397	119 Kevin Oval, Catherinefort, NE 84284	Bulgaria
emilyrogers	barbosalara@example.org	1923-03-18	+1-372-234-8874x482	Esplanada de Carvalho, 45, Ermelinda, 54809-318 Almeida / GO	Malaysia
fpastor	rebecca09@example.com	1992-10-20	+55 (061) 2050 3055	774 Samuel Vista, Hernandezborough, CT 77604	Poland
luiz-felipealbuquerque	brownmichael@example.com	1933-09-11	+55 (071) 1087 1084	Favela de Ferreira, 98, Taquaril, 43885229 da Costa das Flores / RN	Andorra
michaelmolina	william03@example.org	1958-06-20	265.552.7899	9189 Michael Valley Apt. 926, Lake Elizabeth, CA 58776	Comoros
lpimenta	vitoriaborges@example.net	1993-03-27	001-275-340-8447x04404	83426 Hurst Trail Suite 147, Mendezborough, PR 92949	Oman
rmontenegro	gael-henrique80@example.org	1947-03-28	+1-525-436-9041x7344	USCGC Melton, FPO AP 07334	Bosnia and Herzegovina
anthony-gabrielfernandes	mccarthybrenda@example.com	1931-08-31	306-777-2300x5591	03714 Hall Forks, Colonfort, SD 89000	Argentina
maria-laura70	maria-flor67@example.org	1971-06-15	961-385-8132x0530	Setor Borges, 65, Flavio De Oliveira, 00394518 Monteiro / PA	Palestine
brandismith	camposjoao-vitor@example.net	2009-05-24	001-949-586-3277x468	Morro Theo Nogueira, 64, Vila Rica, 36922612 Moura / AL	Nigeria
wrocha	martinezsara@example.net	1983-03-21	(610)600-9539	Passarela Oliver Novaes, 1, Jardim Felicidade, 52970-583 Pinto / PB	Panama
jabreu	rochaarthur-miguel@example.org	1987-07-28	0900 163 1163	Setor Catarina Garcia, Vila Novo São Lucas, 23165937 Correia / SC	South Korea
kevin42	jalbuquerque@example.net	1983-10-03	+1-864-514-6122x4242	Fazenda Vieira, Dona Clara, 09044778 Casa Grande do Oeste / PR	Iran
castanedamelanie	blackderek@example.net	2009-10-15	(041) 5457-5564	4614 John Plaza, Kaneville, MN 02717	Cuba
daniela39	yyang@example.org	1933-02-08	(441)865-2033x5172	14618 Melissa Forge, Stevenshaven, CO 92995	Somalia
aprilrocha	camachoalyssa@example.net	1918-01-31	+55 81 7620 6698	Vereda Porto, 2, Dom Silverio, 20140-436 Sousa de Sales / PB	Bahamas
kentnancy	estherlima@example.com	1962-05-19	+55 (031) 7461 5354	Alameda de Macedo, 77, Marieta 1ª Seção, 43685-744 Aparecida de Duarte / CE	Wallis and Futuna
kbarnes	fisheramanda@example.net	1977-12-12	84 3594-4514	433 Lutz Fields Suite 432, Michaelhaven, VT 07959	Ghana
rael84	tmelo@example.org	1944-04-03	(518)950-0747	5895 Hill Plaza Apt. 869, New Kathryn, TN 65077	Liechtenstein
lawrence63	stephaniegutierrez@example.com	1913-04-18	(981)873-8595	Jardim Diego Pimenta, 18, Novo Tupi, 63416216 Santos / RN	Bahamas
yangnicole	brent01@example.com	1970-07-05	0300-694-3597	Praça Matheus Casa Grande, Estoril, 34645-839 Albuquerque da Serra / GO	Bosnia and Herzegovina
camila29	nancy67@example.net	1993-12-11	+1-560-738-1355x2410	Morro Garcia, 829, Acaiaca, 74437080 da Costa das Flores / AM	Oman
adamspaul	ynogueira@example.com	1931-11-16	001-324-763-6897	37047 Gonzalez Bypass, Andersenview, GA 12708	Indonesia
jcruz	nicolegentry@example.org	1979-11-13	(782)981-3700	00437 Kelly Ford Apt. 651, Port Karen, SD 96887	Falkland Islands
ana-cecilia54	dom94@example.net	1929-09-13	327.767.1235x74107	66409 Dalton Manors, New Samanthaburgh, DE 54150	Djibouti
jonestimothy	melendezscott@example.com	1910-03-03	954-714-5710	Travessa Lima, 833, Pilar, 46767-940 da Paz de Cavalcante / ES	Eswatini
tuckermichele	cantuchris@example.net	1923-06-04	+1-849-839-9222x788	Favela Igor da Mata, 641, Oeste, 99013793 da Conceição / PB	Kiribati
paulwilliam	alana48@example.org	1978-12-07	(061) 9841 4788	Lagoa Silveira, 890, Conjunto Taquaril, 42026416 Sousa / GO	Yemen
erickporto	carrollkelly@example.com	1958-06-20	+55 71 7552-5709	Vereda Ana Liz Freitas, 68, Dom Silverio, 72567029 Pereira da Serra / RJ	Iran
richard17	brian23@example.com	1966-02-10	231-505-4529	Via de Cavalcanti, 95, São Francisco Das Chagas, 57156-604 da Conceição de Costa / RR	Kyrgyzstan
gregory00	jmartins@example.net	1957-04-25	+55 (051) 4466-3304	5685 Teresa Springs Suite 707, Mitchellchester, OH 73059	DR Congo
daniel54	jonesbrandon@example.org	1939-09-22	392.817.4561x814	Vila de Souza, Conjunto Serra Verde, 03629887 da Costa do Galho / AM	Suriname
owenkatie	cgarrett@example.org	1947-08-25	3506309686	Rodovia de Moraes, 33, Vila Madre Gertrudes 3ª Seção, 56904-548 Souza Verde / CE	Somalia
zduarte	barroscecilia@example.org	1999-03-12	+55 41 5399-5900	29136 Brooks Knolls, Johnview, NY 17480	Uzbekistan
donald58	bbrito@example.com	1999-06-10	+55 (031) 4436 4610	Praça de Pimenta, 2, Santa Maria, 96184-739 da Cunha de Novais / BA	Ethiopia
lsilva	lucas-gabriel98@example.org	1926-06-27	347-520-8827	93057 Alicia Villages Suite 457, Emilyborough, KS 10351	Gibraltar
cunhastephany	enunes@example.com	1941-10-06	+55 (041) 9164-6825	5026 Ortega Rest, East Danielton, VA 77482	Morocco
maryramirez	oda-conceicao@example.com	1983-02-24	001-655-367-0226x9126	Recanto Pinto, 65, Vila Califórnia, 49111-885 Caldeira do Amparo / SP	Mongolia
olivia86	hadassa64@example.com	1951-01-13	645.752.1348	50774 Kenneth Mountains Apt. 492, Margaretstad, MI 61023	Somalia
luisa32	asafe20@example.org	1976-04-09	001-578-672-2804	Vereda Maria Alice Teixeira, Conjunto Bonsucesso, 11909907 Moreira / MA	Puerto Rico
cavalcantihadassa	ryangoodman@example.org	1949-05-19	+55 (041) 2632 0508	733 Hoffman Fords, Krystalstad, MN 34022	Brunei
ldavis	xhiggins@example.org	1912-10-08	(071) 6213 2405	Trevo Teixeira, 17, Ambrosina, 21624292 Machado Alegre / ES	Gibraltar
usilva	elizabeth62@example.org	1965-03-04	(011) 5038-5984	60661 Brian Spring Apt. 027, Phillipsfort, DC 05571	Cambodia
caueda-cruz	shawnanderson@example.com	1942-03-18	+1-432-507-0121	8359 Tina Radial, West Charles, SC 23650	Fiji
vitornogueira	milenasampaio@example.org	2012-08-02	+55 (041) 4304 8443	Vale José Lima, 40, Santo André, 81343-419 Costela de Minas / MG	Indonesia
luigi17	da-rosaclarice@example.com	2002-08-06	316.520.3464x281	6397 Andrew Square Suite 385, Port Kendratown, PR 30937	Andorra
vegatiffany	cecilia36@example.org	1915-07-28	(542)224-7737x5467	Residencial de Ribeiro, 144, Alta Tensão 2ª Seção, 58962-763 Silva de Rocha / PB	Philippines
camposfernando	melina67@example.net	1920-09-15	+1-866-325-3918	702 Brandi Junction, Sarahstad, NJ 49750	Eritrea
marianegomes	ravi-luccasiqueira@example.org	1983-03-29	667.532.9740x951	Parque Fogaça, 65, Europa, 37019-726 Costa da Mata / AM	Haiti
tylerglenn	melissa96@example.com	1918-07-13	(061) 3033-2412	655 Cory Courts, New Amy, MI 07884	Japan
bryan07	paul97@example.org	1954-02-02	+55 84 1614 0721	Largo de Nunes, 4, Urca, 45483846 Machado do Campo / AP	Poland
uribeiro	theresamckinney@example.org	1945-02-18	+1-480-974-3203x600	8165 Marc Inlet Suite 650, Burkehaven, CA 40884	Albania
cavalcantiana-luiza	joliveira@example.net	1942-03-30	+1-807-379-2352x24045	78321 Tran Highway Apt. 058, West Danielle, NH 27153	South Africa
salesana-julia	vianaana-julia@example.com	1988-01-09	604-315-3648	Travessa Cavalcante, 98, Mantiqueira, 62174-328 Montenegro / SE	Tajikistan
santosotavio	katherineenglish@example.net	1969-01-09	+1-492-547-0066x670	25887 Kathy Ports, Conwaystad, MT 19552	Cuba
vitor-gabriel29	carvalhoantonella@example.org	1943-09-15	737-362-1130x604	Parque Davi Miguel Pires, 49, Pousada Santo Antonio, 28910-580 Jesus / MA	Myanmar
lvieira	rafaelvargas@example.com	1980-11-24	344-667-8395	Alameda Monteiro, 483, Carlos Prates, 45983502 Rezende das Flores / CE	Moldova
igeorge	maysa02@example.net	1932-12-08	+55 (041) 2749-3118	Viaduto Lucas Gabriel Guerra, 17, Vila Trinta E Um De Março, 90895-873 Ribeiro / PA	Namibia
benjamimduarte	danielcassiano@example.net	1945-12-13	+1-455-452-1353x6757	948 Phillip Haven, Lake Mitchellport, OK 12473	Colombia
poliveira	kavila@example.net	1993-07-26	+55 71 8586-4903	8902 Wells Mission, Aaronland, VA 61914	Djibouti
richard62	angelaknapp@example.org	1969-12-09	(071) 5124 7600	Distrito de Costa, 22, Vila São Gabriel, 13463-847 Oliveira / MT	Tonga
gcooper	rcunha@example.net	1974-05-23	(084) 0603-7727	Área Benjamin Rodrigues, 319, Nova America, 86721841 Martins / RN	South Korea
lorenzovargas	miguelbarros@example.net	1983-11-22	802.937.5150	73813 Holder Alley, Armstrongville, VT 09331	Hungary
natalia43	camaraisabela@example.com	1998-07-09	485-826-6300x382	Chácara Brayan da Costa, 21, Vila Suzana Primeira Seção, 50945-182 Fonseca Grande / GO	Brazil
adamsdesiree	icurtis@example.net	1976-05-10	+55 81 1831 6097	92528 Smith Island, Courtneyfurt, GA 30135	Comoros
alexissmith	hoganchristopher@example.org	2000-10-23	(021) 7583-9793	Conjunto Lavínia Souza, 8, Lagoinha Leblon, 14525575 Camargo / AM	Georgia
hfarias	ramospietra@example.net	1997-02-18	204-806-4981	Unit 2148 Box 7183, DPO AA 26052	Cuba
tallison	acostadaniel@example.net	1933-03-01	970.335.0370x697	5715 Steven Parkway, Joefurt, VA 64491	Papua New Guinea
henrythomas	gregory17@example.com	1959-12-16	51 5374 8934	940 Elliott Greens, New Sarah, MI 31460	Kazakhstan
davidwilliams	vwilliamson@example.org	1972-06-14	+55 (051) 3890 5486	Sítio Anthony Gabriel Sousa, 99, Conjunto Floramar, 73666778 Dias de Macedo / PA	Sweden
simsalan	lorenzoda-mota@example.net	2009-10-22	408.631.4101x7037	Trevo Ágatha Brito, 8, Vila Nossa Senhora Do Rosário, 66975-940 Silveira / PI	Belize
danielsfrank	linbrittany@example.org	1977-07-26	+55 81 2301-9333	Sítio Sales, 3, Vila Da Paz, 27337907 Cavalcante / MS	Niue
barbosaaurora	aurorada-mota@example.org	1955-01-23	+55 (031) 1909 3093	Jardim Nogueira, 85, Ventosa, 07241-804 Ramos / MG	Japan
moraeseduarda	francisco87@example.net	1993-03-28	+55 41 2206 5171	26844 Gomez Cape Suite 179, North Robert, NJ 44269	Macau
judy99	ana-carolinamarques@example.org	1930-11-30	681-464-4965x830	14752 Gray Walk, South Belinda, VT 41695	Cape Verde
tda-costa	gustavo-henriqueborges@example.com	1920-12-09	+1-947-308-0098x785	Distrito Fernando Fernandes, 9, Vila Atila De Paiva, 03343-562 Andrade / ES	Malawi
lunnaalves	barbosapedro-henrique@example.com	1983-10-21	+55 81 1418 7425	4027 Todd Crossroad, Whitetown, NC 07142	Liberia
jacqueline07	novaeslucca@example.org	1930-08-07	+55 (041) 5199-9355	950 Amber Wells, Tylerchester, AS 71983	Trinidad and Tobago
barroshelena	jamiealexander@example.com	2012-11-30	0500-984-2174	Fazenda de Farias, 5, Trevo, 94375102 Castro / PI	Puerto Rico
sheltonjames	robertsdonald@example.org	1967-05-11	575.976.3053	Quadra Diogo Macedo, São Bento, 36212038 Nascimento / AP	Iceland
dom48	otavioborges@example.net	1919-03-29	71 6963-3409	Aeroporto Moura, 3, Serra Verde, 11944-072 Montenegro / BA	Turkey
luiz-otavionovais	peixotothiago@example.net	1923-02-23	+55 41 1766-0854	42724 Rachael Burg, Youngfurt, ID 24156	Tunisia
emanuellysilveira	aragaomelissa@example.com	2012-11-19	001-930-739-3302x401	140 Johnson Lakes Apt. 257, Kristinaburgh, LA 92563	Eswatini
hadassafernandes	greenphyllis@example.net	1934-05-01	846.427.6233	96675 Amy Rapid, Port Kenneth, IA 37289	South Korea
guerrasofia	awilliams@example.net	1912-11-03	(061) 2630 5164	67755 Heather Crest, South Rodney, ND 62692	Lesotho
sophiepimenta	ibarbosa@example.org	1973-08-25	84 1451 0636	151 Laura Inlet, Port Joannland, PR 53466	Belize
carolineda-rocha	fariaskamilly@example.net	2008-08-19	(973)585-1711x57852	21337 Connie Crossroad Apt. 037, East Michaelside, AS 32041	Gambia
laurarios	sreynolds@example.net	1946-09-04	(628)413-1604x4995	628 Michelle Mews, Port Aimeetown, PW 33724	Belize
hopkinsanthony	caua99@example.net	1918-01-30	713.679.4962x70662	Área Zoe Nogueira, 34, Santa Branca, 33158-376 Ribeiro Grande / RO	Saint Lucia
ravyribeiro	diogo24@example.com	1980-10-21	(785)407-7502	Vereda de Nascimento, 3, Vila Sesc, 01314324 Sá do Oeste / BA	Trinidad and Tobago
rodriguesfernando	zmoreira@example.com	1972-11-01	001-450-762-1593x92881	Esplanada de Pereira, 998, Corumbiara, 16780896 Cavalcanti do Oeste / ES	Papua New Guinea
mfogaca	ribeiroliz@example.org	1919-07-08	(742)476-8247x6709	Avenida Garcia, 12, Beira Linha, 28599728 Lopes / PE	Mongolia
apacheco	murraydaryl@example.com	2002-10-13	(061) 7097 7038	565 Mark Grove, West James, PA 48068	Romania
stephanie54	katiegutierrez@example.net	1929-01-07	+1-222-683-6399	8701 Allen River Suite 467, Jessehaven, ND 55515	Brunei
erinhernandez	briancabrera@example.org	1932-09-11	+55 81 0789-3680	191 Robertson Throughway, Harrismouth, NV 46228	Kenya
christopher29	eda-mota@example.com	2004-01-21	486.608.8062x2315	Vale Barbosa, Ernesto Nascimento, 10393-206 Dias / AP	Haiti
julia16	amanda95@example.com	1984-01-09	+55 (051) 3810 3543	Rua Davi Lucca da Cunha, 6, Mala E Cuia, 95462-030 Casa Grande Grande / SP	Nicaragua
da-rochapietra	reyesjasmine@example.com	2007-03-31	(081) 4311-9528	20100 Duran Ferry, Lake Danielle, ND 52909	Ivory Coast
carldonovan	iluna@example.com	1953-08-07	31 0079-7542	Vila Camargo, 17, Gutierrez, 51399-512 Nogueira de Brito / MT	Saudi Arabia
moreiraarthur-gabriel	kirsten29@example.org	1947-03-31	+1-349-574-6131x7399	5072 Ashley Ferry, Williamsborough, GA 80865	Morocco
manuella08	aprilmarshall@example.net	1985-07-28	61 4535-7001	9904 Bishop Orchard, Collinsbury, AK 58885	Liechtenstein
julia68	zteixeira@example.net	1965-03-01	+1-801-724-1740	Praia Ana Julia Araújo, São Luiz, 80757-258 Andrade / GO	Ghana
ralves	diasmaria-helena@example.com	1986-06-18	975.818.2777x172	Loteamento de Barbosa, 57, Ipe, 59088765 Santos de Cavalcanti / RO	Sweden
pereiradavi-lucca	sarah51@example.com	1968-06-23	+55 (051) 3387-3835	780 Kristina Path, Snyderfort, MH 14634	Bulgaria
khernandez	kvargas@example.net	1975-05-04	5275053892	7526 Paula Falls, Browningland, NH 98405	Seychelles
davi00	smithloretta@example.net	1926-08-23	+1-702-885-8292x063	Passarela Moraes, 7, Nova Suíça, 84684-509 Rezende / AM	Georgia
thomas21	troyanderson@example.net	2003-10-22	+55 (051) 9235-7906	738 Michelle Summit Suite 712, East Joseph, UT 05959	Curaçao
caroline88	kaiquesiqueira@example.com	1918-04-14	001-247-309-7707	3927 Rodriguez Village, Burnettmouth, AK 12988	Sudan
websterstephanie	williamweaver@example.net	1990-12-09	216-691-4929	Vereda Yuri da Cunha, Sion, 23466-276 Casa Grande de Fernandes / RN	Bolivia
sean43	smiththeodore@example.com	2007-05-01	960-334-4685	Estrada de Cavalcante, 43, Vila Jardim Leblon, 02863-870 Novaes do Amparo / RN	Maldives
lauranovais	emilly77@example.org	1956-05-22	(041) 7364 1731	Travessa Rael Costela, 79, Granja Werneck, 44645799 Garcia da Serra / AC	Wallis and Futuna
aylaferreira	andrea90@example.net	1957-05-08	2128356405	64973 Turner Square Suite 134, Martinezview, MP 84012	Sweden
john13	smithanthony@example.com	1995-12-15	001-741-884-9395x8383	Aeroporto Raul Brito, 48, Candelaria, 69842341 Correia / MS	Brazil
dhoffman	barbara42@example.org	1976-01-29	+55 51 2769 9973	16165 Jacqueline Stream, East Jennifer, PR 83845	Iceland
bradfordstephen	ana-laura22@example.net	1920-12-16	0800-116-6082	8030 Melissa Circle Suite 116, Natalieville, RI 23755	Kiribati
william28	ramosmatheus@example.com	1935-04-16	11 2313-6519	Favela Leonardo Sá, Mirtes, 22509470 Moraes / PE	India
paulo68	davidramsey@example.net	1955-12-24	619.309.8079	8329 Kathy Avenue, Port Amanda, GA 11226	Saint Lucia
heloisa08	keithtorres@example.net	1988-06-09	812-696-9706	Passarela Dias, 826, Vila Piratininga Venda Nova, 46045-453 Aragão do Amparo / AL	Tanzania
robertmoran	mwhite@example.org	1968-10-13	7989970592	200 Cook Trace, Perezburgh, MP 83811	Macau
zvieira	dom64@example.net	1920-08-15	+55 71 7322-9127	1478 Alexander Center, Smithland, DC 83329	Mexico
eduardosousa	lopeztricia@example.net	2004-03-23	0500-117-6257	16749 James Street, Craighaven, NV 22934	Belize
da-pazluiz-henrique	leonardocostela@example.com	1927-10-05	(842)475-7987	253 Klein Camp Apt. 904, Tiffanytown, WI 14947	Argentina
gaelda-luz	tamarachapman@example.net	1989-08-16	+55 41 8019 0876	Passarela João Pedro Teixeira, 14, Serrano, 71223-520 Camargo / PA	Hungary
leaolucas-gabriel	deaton@example.org	1921-10-03	(614)909-5071x588	9438 Carla Ridges, Alanland, OH 05726	Georgia
zazevedo	lindseycallahan@example.com	1976-09-28	41 3649 7100	7028 Curtis Union Suite 837, Brownview, AR 80897	Saint Lucia
saantony	dcassiano@example.org	1985-03-04	(084) 8036 2156	Loteamento Fogaça, 4, Tres Marias, 36086161 Gonçalves do Oeste / CE	Tunisia
fleao	kmartinez@example.org	1994-06-02	+1-469-622-3425x839	Loteamento Souza, 95, Guarani, 08495-382 Guerra das Pedras / CE	North Korea
mouraarthur-gabriel	tsousa@example.org	1941-11-10	(552)495-8089	Núcleo Cirino, Vila Barragem Santa Lúcia, 41642-364 Nascimento / PE	Turkmenistan
cirinomaya	cynthia68@example.org	1973-09-21	31 0405 7207	339 Mason Camp Apt. 450, West Brianna, KY 54709	Bulgaria
novaisalice	julia69@example.org	2000-12-14	+55 61 7927 9784	Favela Duarte, 9, Ipiranga, 40347052 Jesus / RR	Lesotho
rhavinovaes	justin38@example.com	1980-10-08	+55 11 1107-9513	57445 Turner Squares Apt. 192, Ellisonview, CO 52193	Cape Verde
michaelcox	otto19@example.com	1963-11-14	(051) 2986 2931	51666 Cook Roads Suite 047, Nolanside, NE 93390	South Africa
abigail94	kristafernandez@example.org	1991-02-25	(021) 3462-2900	67197 Benjamin Springs, Ryanstad, UT 30002	Honduras
duarteheitor	dante17@example.com	1961-10-27	21 4990 8097	70187 Anderson Streets Suite 819, Richardmouth, RI 99030	Western Sahara
pwilson	dompimenta@example.net	1955-04-04	51 4969 8611	Área de Barros, 5, Concórdia, 17963-171 Costela / PI	Ukraine
agatha37	nicolemarshall@example.net	1914-04-12	723.243.4796x8364	615 Atkinson Cliff, New Beckymouth, TX 49378	Jamaica
ryan72	milena71@example.com	1976-07-23	81 9645-7302	54386 Theresa Inlet, Harrisberg, VI 10740	Pakistan
stewartcourtney	calebe92@example.net	2010-03-21	0800-383-0740	Favela de Cardoso, 10, Barro Preto, 92032-603 Sá / DF	Tonga
luarajesus	johnwilcox@example.net	1948-12-13	+1-575-546-5323	8070 Reed Viaduct, Lake Hannah, AR 24276	Kenya
albuquerquelucca	dom89@example.net	1990-11-04	644.674.8502x8814	Núcleo de Correia, 74, Dona Clara, 21131262 Cunha / ES	Armenia
dawn99	levi75@example.com	1934-06-28	+55 41 4375 4846	5619 John Alley, South Juliashire, MO 96193	Suriname
davi-luccaazevedo	wpeixoto@example.net	2000-02-25	834.374.5445x64612	Lagoa Aragão, Vila Tirol, 62779117 Almeida / PR	Eswatini
ann34	melissa49@example.net	1931-07-30	+55 21 1795 5542	820 Johnson Plaza, Austinport, AK 95750	Uruguay
murilo83	cirinoleticia@example.com	1929-08-31	+1-209-629-4104x849	645 Conrad Key, Jacquelineland, TN 85587	Thailand
maria-eduarda23	ecasa-grande@example.com	1946-05-27	352-789-8599x3764	Vila da Conceição, 29, Bonfim, 10711246 Guerra / SE	China
marywilliams	nmarquez@example.org	1913-10-05	984-798-2146x6707	87075 Emily Passage, Gonzalesfort, MP 07185	Argentina
ana-beatriz19	ocavalcante@example.com	1960-09-12	706.477.4303x32922	Vereda de da Mota, 80, Castanheira, 95336-931 Lima dos Dourados / AP	Gambia
isaac15	vpinto@example.org	1921-03-29	001-788-518-8586x273	967 Anna Squares, Michelleburgh, PA 43211	Hong Kong
amybaker	nicole26@example.net	1936-04-05	+55 71 0967-1912	5012 Rogers Fork, Cookemouth, CO 70672	South Africa
obarbosa	vieiraevelyn@example.net	1958-04-27	+55 (081) 3496-9164	2034 Moore Street Apt. 862, Joannestad, IN 90424	Armenia
davi-lucasda-cunha	valentinaporto@example.com	1953-07-24	+55 21 7007-0471	Colônia Isabella Sá, 75, Vila Independencia 3ª Seção, 83274-173 Rocha / SC	Sri Lanka
cmorrison	dantecardoso@example.org	1950-01-01	001-428-655-0220x66483	Lago de Peixoto, 759, Monte São José, 23721683 da Cruz / DF	North Korea
ncosta	agatha24@example.org	1936-03-11	+55 84 1348-2260	Parque Amanda Vargas, 34, Universitário, 33826-288 Moura / TO	Brazil
qcarvalho	meganzuniga@example.org	2000-04-10	+1-932-247-0769	Praia Rezende, 47, São Geraldo, 20154-323 Cardoso Paulista / SC	Ivory Coast
kmoraes	lindaclark@example.net	1950-08-04	(084) 5542 5581	PSC 7397, Box 1627, APO AE 73072	Vietnam
hwilson	casey03@example.com	1930-01-03	+1-898-701-3380x138	Alameda Gomes, 9, Vila Olhos D'água, 84230-364 Gonçalves de Moraes / SE	Western Sahara
bcardoso	eporto@example.org	1963-05-01	(061) 0008-0748	925 Kimberly Cliff Apt. 376, South Marthaton, OK 16635	Sudan
jessicahenson	mmccall@example.net	1955-12-31	0900 452 5754	26021 Macdonald Squares Suite 455, Romeroport, VA 37333	Malaysia
williamsondennis	cardosomaysa@example.net	2011-02-18	313-769-1051x752	680 Roy Prairie Apt. 163, New Brian, VA 03412	Albania
joshua72	chelseyhayes@example.org	1992-08-10	(665)830-9395x549	138 Tucker Cape Apt. 091, Patrickhaven, IL 93410	Cambodia
spastor	williamfox@example.com	1944-08-29	+55 (071) 7234-8454	Jardim Giovanna Garcia, 58, João Pinheiro, 30147-042 Farias de Ribeiro / RN	Ivory Coast
alice85	leo30@example.com	1943-10-28	966.781.1038x39594	161 Fleming Oval, Lake Ariel, ME 54257	Fiji
maria-eduarda18	josephhampton@example.com	1990-09-19	(302)713-1344x150	191 Wells Wells, Karinaland, AS 48581	Suriname
robertstrickland	johnhampton@example.net	1950-06-21	(726)404-5525x5540	PSC 4580, Box 9480, APO AP 64577	Madagascar
aprilgiles	iazevedo@example.net	1913-07-11	(294)981-4404x9610	32608 Margaret Spring Apt. 132, Burkeside, ID 95991	Guinea
phillipsmark	fjimenez@example.com	1930-04-27	+1-739-893-4396	Favela João Lucas da Cruz, 12, Novo Glória, 37770123 da Conceição do Campo / MS	Samoa
ntapia	oliveiracaua@example.org	1992-08-29	+55 (011) 7408-3638	Trevo de Câmara, 18, Distrito Industrial Do Jatoba, 45312895 da Luz / RN	Ukraine
goncalvesmilena	arthur06@example.com	1989-01-30	(061) 8029 6023	Parque Camargo, 20, Vila Rica, 15102976 Casa Grande / RS	Zambia
bradleysmith	vianalaura@example.com	1915-01-28	660-624-1699	Unit 6319 Box 3654, DPO AA 37455	South Korea
scamara	brian47@example.com	1978-08-24	31 0958-2967	Ladeira Rafaela Pinto, 8, João Pinheiro, 73786030 Novais / AM	Guatemala
cunhamateus	kaparecida@example.org	1992-08-03	+55 11 1181-8360	8144 Dorsey Island, South Mary, WY 74467	Sweden
kwells	vianayago@example.com	1968-08-25	+55 (084) 5728 1519	750 Ward Trafficway, West Brittney, MD 09883	Tunisia
oliviaaparecida	derricksmith@example.net	1973-03-16	(031) 8406 2076	425 Boone Union, Basschester, IN 54923	Jordan
maria-cecilianovaes	benjamim56@example.com	1945-02-12	0900 225 6597	52259 Kristine Orchard Suite 512, Ortizborough, AL 55733	Saudi Arabia
theresacabrera	agathanunes@example.org	1933-04-21	+55 51 0591 1357	Setor de Silveira, 569, Suzana, 18660381 Duarte / PE	Eritrea
alexandre86	taylorcheyenne@example.com	1955-03-10	11 3160 2779	Distrito Giovanna Fogaça, 66, Madre Gertrudes, 99534686 Câmara do Galho / MT	Indonesia
pamela23	isis29@example.org	1966-09-04	0300 689 1509	Vila Pedro Miguel Rodrigues, 10, Esperança, 54939-798 Casa Grande / AL	Vietnam
amandahernandez	newmantracy@example.com	1910-09-01	+1-307-785-7781x5919	922 Jade Corners, West Grantmouth, HI 61057	Ivory Coast
thompsonadam	crezende@example.net	1970-08-04	+55 (081) 9600 6352	7021 Whitney Ports, West Dennis, AK 96425	Lesotho
isabella37	henry-gabrielvasconcelos@example.org	1964-02-25	(200)254-8916	Travessa Sales, 18, Conjunto São Francisco De Assis, 43161334 Siqueira / AL	Wallis and Futuna
scott56	pcirino@example.org	1994-12-10	001-462-924-9175	Área de Peixoto, 339, Barreiro, 52352932 Rezende da Mata / SP	Dominican Republic
fabreu	wburns@example.org	1981-10-15	0900 032 9070	Favela de Albuquerque, Rio Branco, 20066604 Leão / GO	Bahamas
marierogers	fchase@example.org	1989-12-20	001-709-598-2462x2034	Distrito Jade Jesus, 96, Lagoinha Leblon, 60585344 Mendonça / DF	Serbia
ucastaneda	amurphy@example.org	1939-05-07	(081) 2984-0259	Unit 6124 Box 3399, DPO AE 66809	Tunisia
jamiemorris	alanabarros@example.net	1970-12-25	0800-974-7271	58295 Karen Ports Suite 668, Orrshire, DC 25154	Curaçao
scottpayne	alvarezcody@example.net	1932-06-20	+55 (041) 0631-2116	4483 Bartlett Prairie Apt. 476, Maryton, KS 08176	Saint Lucia
lopesguilherme	catherine47@example.com	1997-10-11	+1-925-638-8456x659	69314 Duffy Flats Apt. 698, South Sarafort, VI 81937	Vanuatu
sabreno	grodgers@example.net	1977-10-20	001-740-529-9646x7451	Residencial Nunes, 963, Estoril, 15209309 Garcia das Flores / SE	Iran
daviskristin	jenniferdiaz@example.net	1946-11-23	84 6702 9410	Morro Theo Novaes, 74, Trevo, 47148760 Santos da Praia / MS	Gambia
laurenramirez	barrosmathias@example.com	1951-10-18	71 7076-4810	Unit 7984 Box 1102, DPO AE 77253	Burundi
nunesgabrielly	cassianomirella@example.com	2001-08-04	+55 61 9025-8349	5604 Harrison Station Apt. 925, Gallowayberg, ME 47235	Kazakhstan
carolinacastro	sampaiomaria-cecilia@example.net	1918-12-21	+55 (031) 9139-4375	Feira Ana Ramos, 81, Nova Vista, 41857-258 Duarte de da Luz / PA	Japan
joaquim10	bethmills@example.org	1945-05-08	001-217-773-6794x88775	Fazenda de Correia, 91, Parque São Pedro, 30821004 Garcia / GO	Philippines
zlima	coxelizabeth@example.com	1948-07-20	0300-806-7126	8054 Jones Brook Apt. 427, Karentown, CA 43141	South Africa
juanda-costa	breyes@example.com	2009-11-05	(061) 0648 7222	7129 Robert Lane Apt. 143, North Kelly, PW 79020	Niue
antoniothompson	peixotolavinia@example.com	1951-04-19	0300-762-7366	Praça Rezende, 19, Embaúbas, 35639292 Sampaio da Serra / PR	Cambodia
hannah47	larissa09@example.net	1936-11-11	0900 384 1915	Condomínio Leonardo Santos, 47, Marmiteiros, 56307026 Siqueira do Amparo / MT	Panama
alyssadorsey	qlopes@example.net	1941-05-09	+55 (081) 1980 2924	2478 Victoria Pike, Baldwinfurt, AS 17212	Tanzania
imoore	maria-luisasa@example.net	1955-05-26	31 9367 6317	Sítio Dias, 27, São Paulo, 74365917 Sales / AL	Tonga
calebecirino	mateusvargas@example.com	1980-04-20	(210)678-4678	Rodovia Correia, 143, Jardim Vitoria, 46822487 Fonseca do Galho / TO	Morocco
rhavi32	yuri30@example.net	1950-03-02	+55 71 8403-3305	9824 Nelson Squares Apt. 218, Courtneyton, IL 00944	Albania
rebecada-mota	mary41@example.net	1982-04-26	6334666513	484 Mccarthy Stream Suite 368, West Bonnie, MP 89581	Uzbekistan
jason06	evelyn29@example.net	1909-11-25	(084) 5570 7816	Setor Pereira, 93, Conjunto Lagoa, 10325219 Gomes / AM	Ukraine
leticia04	kenneth54@example.net	1943-04-10	+55 71 6596-8863	4122 Curtis Road Apt. 596, Port Kennethhaven, MS 10492	Uganda
melina07	da-rosaantonio@example.org	1980-03-23	983-614-3182	7185 Buck Place, Fosterborough, UT 05492	Eswatini
laurenchan	martinsluiz-henrique@example.net	1931-09-24	3788907091	Esplanada de Brito, 736, Vila São Geraldo, 40384-395 Novais / RN	Moldova
sousacalebe	dhogan@example.com	1977-03-03	(431)621-4049x48524	88635 Derrick Groves Apt. 614, Port Joshuashire, CO 70534	Peru
ksiqueira	joshua18@example.org	1958-10-18	+1-432-801-2894x510	154 Moore Skyway, South Jeffreyport, NC 60459	Georgia
benjamin34	cassianojuliana@example.org	1938-12-09	+55 (081) 7293-6280	Recanto Olívia Duarte, Vila Vista Alegre, 40748749 Mendes das Pedras / DF	Iran
mendoncaana-carolina	annette15@example.net	1921-12-02	(691)453-1870x6686	30364 Martin Manors Apt. 479, New David, DC 95329	Taiwan
maryyoung	aragaosabrina@example.net	1949-03-31	9854230950	Estação Caldeira, 653, Cruzeiro, 22891-971 Machado de Minas / RN	Bahamas
kylehuang	schmidtariel@example.org	1969-11-11	+55 31 3262-6551	Recanto Barbosa, 7, Vila Havaí, 09029-892 Mendes / AC	Ivory Coast
jking	benjamim39@example.net	1910-03-01	+55 (041) 4534-6866	589 Jennifer Extensions, West Kellyborough, NC 11616	Uganda
catherineallen	meghan21@example.com	1918-04-06	+1-232-841-0445x92270	252 Mitchell Courts, West Dana, AL 61948	Bulgaria
michaelhoward	restes@example.org	2007-07-23	+55 21 7791-8431	60570 Lindsey Crossroad, Lake David, WI 78163	Djibouti
sara13	ana-sophiabarros@example.net	1984-05-27	001-905-336-1454x5241	Travessa Carolina Santos, 86, Vila Independencia 1ª Seção, 94982-955 Caldeira / MG	Tonga
isabella15	connieashley@example.com	1947-10-02	11 9421 1433	445 Diana Estate Suite 409, West Gabrielle, AZ 95165	Seychelles
breno23	henrique60@example.net	1937-11-20	+1-302-457-2984	0559 Juan Station Suite 789, Williamsborough, TN 19755	Ukraine
tracywalls	beatriz30@example.org	1993-01-31	908-882-4145x40309	32909 Patricia Port, North Royton, CA 98587	Vietnam
joanna34	aoliveira@example.org	1978-10-09	+55 11 2548 7060	Núcleo Barbosa, Campo Alegre, 19391-559 Cassiano / PE	Panama
davi-luiz05	ndorsey@example.com	1951-04-07	001-567-310-4773	Viaduto de Andrade, São Jorge 1ª Seção, 98631147 Azevedo do Sul / AC	Iceland
ida-luz	mmitchell@example.net	1924-11-28	2174782473	Unit 7392 Box 9334, DPO AP 85757	Nicaragua
kari51	yduarte@example.com	1998-11-01	441.376.0671	2394 Bonilla Motorway Suite 687, East Tammy, HI 05725	Jamaica
linda57	mccarthyjames@example.net	1914-09-25	(778)465-2577	9655 Charles Bridge, East Michelletown, OK 06683	Moldova
ewalters	rebeccajohnston@example.com	1972-09-12	+55 84 0452-0916	8065 Tapia Curve Suite 270, North Gary, CO 15218	Trinidad and Tobago
nclayton	jacob62@example.org	2000-12-03	0300-253-4093	85702 Davidson Station, Connormouth, TN 96880	Belize
lcavalcanti	nicholas45@example.com	1962-08-07	655.698.7150	Rodovia Bryan Albuquerque, 9, Conjunto Serra Verde, 51249-786 Castro de Jesus / AM	Romania
williamdean	holly47@example.org	1952-03-14	(715)364-6403x735	771 Lisa Courts, Brownview, CO 85369	Seychelles
thomasgeorge	mmarques@example.net	2004-10-30	446-628-1486x84787	6989 Williams Hill Suite 840, Christinamouth, WI 21705	Guatemala
onogueira	pedro-henrique12@example.com	1985-12-06	0300 410 6035	Alameda Câmara, Túnel De Ibirité, 94028-387 Melo de Silva / BA	Djibouti
vcunha	asa@example.org	2008-04-08	001-361-531-6717x820	Passarela da Costa, 40, Urca, 13855-367 Cavalcanti Paulista / SE	Bermuda
heitorda-mota	xwilliams@example.com	1936-01-24	(715)398-9337x602	0311 Jessica Camp Suite 155, Port Raymond, DC 95639	Iceland
rborges	igorcassiano@example.org	1953-08-20	001-410-383-5181x41937	92870 Kara Spur Suite 847, Ruthmouth, RI 36206	Falkland Islands
fwilliams	ipires@example.com	1948-09-11	21 0568-9860	36399 Floyd Villages, West Jonathanshire, MP 17889	Panama
sarah14	maria-luizapimenta@example.org	1918-06-11	6633999863	5104 Michael Pike Apt. 629, Nataliemouth, LA 02419	Oman
troy86	tward@example.com	1962-05-13	287-934-1396x1125	Loteamento Lorena Monteiro, 51, Vila Fumec, 54340236 Pimenta da Serra / RJ	Colombia
elizabeth17	leonardryan@example.org	2007-07-04	21 7063 4055	Pátio Lucas Moreira, 14, Jardim Guanabara, 64674065 Cavalcanti da Praia / MS	Niue
rodriguesisis	cynthia47@example.net	1956-08-18	+55 11 6938 3139	Praça de Fernandes, 4, Nossa Senhora Aparecida, 17657185 Cavalcanti de da Paz / RS	Puerto Rico
zmalone	melanie63@example.net	1953-12-16	001-235-747-6923	Trevo de Moreira, 84, Solimoes, 01980-444 Brito / AC	Curaçao
xmartins	camposeloah@example.com	1916-04-17	0500 659 5141	2917 Janet Hollow Suite 068, Rebeccaside, WY 17646	Namibia
maysaaraujo	james17@example.org	1955-03-05	(081) 7324 3836	Viaduto Maria Luísa Sales, 42, Vila Nova Cachoeirinha 3ª Seção, 06619-747 Correia de Almeida / GO	Eswatini
brendabolton	mcorreia@example.net	1917-08-08	7075906172	431 Selena Key, Jacksonmouth, AS 43223	Uruguay
kristie75	dpires@example.org	1951-04-22	+55 (081) 4521 5671	11808 Davila Light, Bethanyberg, KY 21899	Taiwan
laura90	henryvieira@example.net	1946-09-03	+55 (041) 1663 0480	Unit 1315 Box 8093, DPO AA 22668	Sudan
maria-isis09	iannascimento@example.net	1910-07-21	+55 61 8805-5988	Viela Gustavo Henrique da Mata, 81, Frei Leopoldo, 98883750 Cavalcanti / ES	Ukraine
eda-rocha	pedro-henriqueborges@example.org	1952-11-21	+55 21 0651 4146	Esplanada de Sá, Castanheira, 10517-215 Vargas da Praia / AL	Ethiopia
henryaragao	fernando20@example.com	1996-06-02	31 8338 4113	Rodovia de Abreu, Vila Nova Dos Milionarios, 49145-592 Vieira / PA	Central African Republic
bethanymoore	jessica52@example.org	1992-10-04	565.958.7736x104	Viela Carvalho, 25, Primeiro De Maio, 43889-416 Cardoso das Flores / PB	Brazil
robertjones	maria-lauracaldeira@example.org	1934-01-12	+55 (081) 7656 5730	Chácara Stella Siqueira, Vila Minaslandia, 12065-984 Marques de Rios / RJ	Kyrgyzstan
martinsmathias	santosvicente@example.com	1980-08-25	+55 71 4018 2722	Aeroporto de Andrade, 96, Marçola, 80084407 Viana da Mata / TO	Costa Rica
santosgustavo	nmelo@example.com	1967-03-02	513-571-3937x20152	97416 Adrian Ridge Apt. 526, East Austinport, VI 74631	Niue
serranoleslie	christopher91@example.com	1985-04-16	(975)438-4802	58501 Adam Burgs, Paynebury, DC 46806	Gibraltar
otto82	aaron45@example.org	1971-09-29	+55 (041) 2457-5166	Conjunto de Casa Grande, 8, Vila Minaslandia, 16036-017 Alves de Teixeira / RN	Turkey
antoniobarbosa	david66@example.org	1989-03-02	+55 81 4344-6733	Parque de Duarte, 96, Vila Maloca, 94427-732 Leão / RN	Singapore
ppereira	da-rosalorenzo@example.org	1911-02-24	001-327-285-7792x32205	05370 Ryan Circles Apt. 492, South Charlesbury, AR 85714	Saudi Arabia
gainesbrandy	kayla16@example.net	1924-11-29	(021) 9200-2360	40825 Morris Expressway Apt. 121, Johnborough, GU 20951	China
jose-pedro32	vianaantonella@example.com	1913-04-21	548-516-5207	4497 Tim Loaf Suite 833, Nicholechester, IL 89690	Palestine
vmartin	maria-eduardamarques@example.net	1952-09-17	001-842-597-8826x263	Recanto Fernando Sampaio, Vila São Geraldo, 52380412 Freitas do Amparo / AC	Canada
kevin57	michaelglover@example.net	1945-11-21	0500-358-8791	Núcleo de Moraes, 9, Prado, 66952776 Cunha de Goiás / PR	Hungary
ashleysmith	brayan80@example.net	2000-02-29	31 8723-2654	53306 Mary Way Suite 177, West Jason, PR 34733	Vietnam
qguerra	ana-cecilia98@example.com	2003-06-24	(470)544-9313	Rodovia Moura, 4, Tirol, 09434421 Sousa / MS	Botswana
ashley53	warderika@example.org	1983-03-19	506-963-8736	26379 Vargas Wall Apt. 644, Christinaland, UT 71549	Norway
ysilva	luccarocha@example.org	1990-04-14	+55 31 0146 8094	Vereda Heloísa Camargo, 566, Nossa Senhora Da Conceição, 72010772 Sampaio da Mata / SC	Syria
vitoria36	davi-miguelcampos@example.org	1949-02-26	+55 81 2416 7343	Trecho Dias, 832, Conjunto Paulo Vi, 33011556 Gonçalves das Flores / MT	Israel
zhall	danny03@example.org	1913-02-27	5786443855	Campo Enrico Andrade, 70, Vila Rica, 03221455 Cardoso do Campo / PA	Aruba
markcross	castrovincent@example.com	1915-07-02	001-743-626-0915	9497 Ralph Turnpike, North Nathanborough, HI 50891	Haiti
zoe06	davi61@example.com	1994-12-20	84 1103-6490	167 Matthew Lights Apt. 734, Angelchester, SC 68288	Vanuatu
camaramaria-helena	davischristine@example.org	1996-10-10	0300 357 2837	Fazenda de Sá, Tres Marias, 53306-639 Fernandes / MA	South Korea
limatheodoro	eshelton@example.net	1941-04-07	228-848-9463	18406 Michael Tunnel Suite 812, Andreaville, NH 29604	Botswana
hnogueira	yrodrigues@example.com	1979-06-02	+55 (011) 6709-9811	47565 David Mills, West Annborough, ME 35613	Burundi
mcopeland	tdas-neves@example.org	1924-04-15	283-928-3444	Lago de Cardoso, 855, Conjunto Celso Machado, 98836445 Casa Grande da Prata / MG	Namibia
danilo62	novaesvalentim@example.org	2007-02-10	(380)381-8765x1690	Unit 5193 Box 8894, DPO AA 81068	Bangladesh
derrickbooker	matthewwalsh@example.org	1972-11-26	(770)426-0756x61676	5595 Alexis Trace, Frostmouth, SD 68671	Moldova
cda-cruz	jamieduran@example.com	1976-07-04	+55 11 0471 9335	8333 Cheryl Divide Suite 549, Johnmouth, AL 35100	Norway
bellagarcia	dwilson@example.net	1949-09-03	+55 41 6986 1606	Esplanada de Cunha, 83, Aeroporto, 05803-818 Caldeira do Campo / PI	Tanzania
benjamin72	ceciliada-rocha@example.org	1965-06-08	+55 71 8264 0846	195 Nunez Port Apt. 581, Parkertown, NY 67132	Gambia
sandrarice	camargolevi@example.net	1953-02-07	997-249-6853x6164	849 David Key, East Jennifer, MN 46886	Madagascar
pvasquez	amy26@example.com	1916-09-19	541.505.3079	PSC 9501, Box 7827, APO AA 48348	Nigeria
oliverrocha	sousalarissa@example.org	1912-03-10	+55 (081) 7710-7228	Setor de Caldeira, 1, Mariano De Abreu, 88076-508 da Rosa do Campo / AC	Czechia
lrocha	almeidaraquel@example.net	1972-04-25	+1-730-216-8930x1743	Distrito da Paz, 55, Penha, 90608-879 Rodrigues / SE	Mongolia
nicolemartins	bwilliams@example.org	1987-11-10	(081) 7551 4090	8692 Dean Extensions, South Brittney, NJ 23712	Hong Kong
fgarcia	bmoraes@example.org	1953-05-30	621-210-2626x99814	36214 Walker Mills, New Alexander, AZ 30937	Suriname
juan10	allison31@example.com	1988-10-21	0900 847 7406	Campo Eduardo Rodrigues, Aparecida, 07335-625 Cirino / MA	Turkmenistan
bgonzalez	anthonypoole@example.org	1989-08-21	213.218.0964x4146	Jardim de Rodrigues, 537, Juliana, 44763376 Leão / SP	Canada
daniel27	ogomes@example.com	1910-07-05	980.291.4740	34363 April Village Apt. 004, Amyton, WY 63504	North Korea
ana-lizfernandes	xscott@example.com	1928-08-02	+55 21 6710 9017	3562 Smith Harbors, Joshuabury, GU 83882	Saudi Arabia
luiz-otavioda-costa	yasminda-mota@example.net	1953-10-28	+55 (051) 9946 0275	73225 Scott Isle Suite 192, Mollyview, GU 23031	Turkmenistan
catarina87	davidfarmer@example.com	1925-04-02	563.954.3904	Estrada Mariah Campos, 5, Leonina, 99953394 Brito da Serra / PB	Malawi
josue04	cole50@example.org	1960-02-01	+1-649-275-9984	14124 Sherri Squares, Chandlerton, OH 84583	Djibouti
joao-pedrosouza	williamsjoy@example.com	1943-08-24	84 3819 1592	5902 Allen Valleys Apt. 757, East Tracy, NE 60224	China
ayla27	luiza79@example.net	1997-06-19	001-990-240-1701	Sítio Guerra, 37, Santa Maria, 42052-336 Nascimento / ES	Western Sahara
brookstina	hlopes@example.com	1989-02-04	+1-626-284-6721x873	Estação João Pedro Mendes, 986, Vila Antena Montanhês, 13378-848 Ferreira / SP	Nicaragua
sgarcia	smurphy@example.org	1917-12-10	637.273.6521	Rua Davi Lucca Almeida, 372, Conjunto Capitão Eduardo, 39977808 Cassiano / PE	Gambia
tranjonathan	lrodgers@example.com	1919-12-20	+1-233-357-3911x104	871 Paul Underpass Apt. 752, Jamesfort, GU 87668	Suriname
drocha	mathiasda-costa@example.com	2011-10-17	(286)450-1043	Estação Cardoso, 449, Lagoa, 45179-971 Ferreira / SC	Djibouti
rodriguezjohn	yrodriguez@example.net	1917-04-14	71 3764-2874	9140 Williams Tunnel, Port Melissafurt, LA 08049	Kazakhstan
uwalker	rmorales@example.org	1958-02-21	768.486.0616	Vale Paulo Pimenta, 35, Vila Havaí, 48682720 Fogaça Paulista / ES	Jamaica
chelseyjackson	joao-vitor10@example.net	1926-10-04	51 3607 6566	3544 Bradford Turnpike, Tammieside, NE 35290	Romania
enzo-gabriel07	elliottjulie@example.org	1973-04-11	2093781182	Loteamento José Miguel Farias, 56, Conjunto Capitão Eduardo, 81344-326 Barros / PA	Somalia
vitoria15	vkane@example.net	1983-08-21	7482277737	8578 Lynch Mills, Langhaven, VI 47481	Israel
pattersonemma	barrosjose-pedro@example.net	1972-06-07	+55 51 8415 0663	3040 Gloria Landing Apt. 103, Monicahaven, MH 68608	Botswana
luiz-felipe82	alice23@example.org	1963-10-29	001-561-513-7619x472	5567 Luna Motorway, Port Cynthia, HI 40631	Haiti
raul65	marquesasafe@example.com	1986-02-12	859.427.6372x84856	Estação Nascimento, Saudade, 95635-011 Vieira / SE	Norway
cshort	uteixeira@example.net	1928-12-04	6706531695	51024 Dudley Rue Suite 829, Gomezmouth, DC 09456	Palestine
lparker	uhoover@example.com	1922-07-30	+55 41 9297-1851	153 Shawn Flat, Port Lori, VI 07371	Albania
zcardoso	jasonjoseph@example.com	1934-01-23	+55 31 7330 9803	664 Smith Pass Suite 275, Johnsonfort, DC 48279	Saint Helena, Ascension and Tristan da Cunha
antoniosalinas	michaelwhite@example.net	1998-08-31	+1-707-677-2498x418	185 King Plaza, North Josephville, MT 64422	Poland
aliceda-cruz	emanuella99@example.org	1943-11-07	(402)722-7514x440	Condomínio de da Rocha, 12, Trevo, 28897-561 Fogaça de Garcia / PI	Bahamas
qfarias	williamrodriguez@example.com	2002-02-13	924-851-6072x60308	Unit 8519 Box 5301, DPO AE 51871	Russia
rodriguesbento	kescobar@example.org	2007-12-30	21 3892-3346	972 Benson Parks Apt. 480, Johnstad, MP 33730	Bulgaria
elizabethjohnson	hannahduncan@example.org	1996-08-10	(071) 9355 0241	8016 Melissa Meadows Apt. 339, Vincentshire, AR 49969	Iceland
fthomas	ogray@example.net	1951-05-27	(021) 3890 9595	082 Jennifer Trafficway Suite 829, Nicoleview, PA 95139	Nicaragua
stella10	kellerrodney@example.com	1941-05-17	+55 (041) 1101-6498	077 Samantha Vista, Lambertborough, FM 57241	South Korea
mcdonalddawn	leoteixeira@example.com	1961-02-10	550.502.2406x544	934 Rogers Roads, New Stephen, WY 26637	Saint Lucia
rhavi72	marc50@example.net	1989-09-18	627.428.8011	Largo Alice da Conceição, 965, Vista Do Sol, 67690-948 Cirino / AM	Namibia
joao91	kevin70@example.net	1995-01-15	(021) 1367-9258	Avenida de Montenegro, 788, Conjunto Jatoba, 74811-080 Moraes / PB	Niue
albuquerquefernando	waltersgloria@example.net	2002-02-12	(021) 4557-6759	660 Pamela Crossing, Randyburgh, WA 02943	Bermuda
sperry	cirinoigor@example.com	1930-07-24	41 6859 4810	031 Virginia Union Suite 269, West Kellyberg, UT 42984	Ethiopia
millermichael	xvasconcelos@example.org	1977-07-28	+55 21 1729-4468	Chácara de Nunes, 22, Santa Isabel, 60008535 Câmara Alegre / PE	Costa Rica
cohencarmen	robertsdaniel@example.net	1911-06-30	+55 (021) 1785-9702	Área de da Rocha, 889, Vila Copacabana, 42887-623 Pires / PI	Samoa
zrodriguez	cirinomaria-cecilia@example.com	1949-10-15	(071) 9264-3895	Distrito de Pires, Vila Real 1ª Seção, 02384-356 Silva de Sousa / RJ	Guinea
marianapimenta	fordevan@example.com	2005-03-25	+55 (084) 8859 8893	164 Todd Lakes Apt. 296, Martinchester, MI 96494	Aruba
andrademaria-luisa	gallaghercarla@example.org	1982-09-17	696.313.7907x446	Rua de Ferreira, 99, Conjunto Minas Caixa, 15845845 da Luz / RR	Bosnia and Herzegovina
antonella54	scrawford@example.com	1998-10-28	+55 (021) 1708-4916	Estação Guerra, 62, Providencia, 71837-629 Lopes da Serra / PE	Fiji
levisampaio	bestes@example.com	2005-02-02	71 4095-6547	Unit 5624 Box 8315, DPO AP 97921	Kenya
taylordiana	reedstacy@example.org	1909-12-26	+55 11 0431 6136	Colônia de Sá, 36, Pompéia, 13988-217 Nunes do Oeste / AM	Japan
karen45	freitasraul@example.org	1925-08-02	287.914.7457x0195	Fazenda de Martins, Glória, 88264-629 Fonseca / MS	Vietnam
stella93	nancy65@example.net	1962-03-20	+55 61 8182 6898	94850 Tammy Lane, North Tylerview, MO 86993	Botswana
nascimentovitor	jared40@example.com	1969-04-25	+55 71 0974-2667	9052 David Crest, Kylestad, NY 26643	Mongolia
chernandez	xperez@example.com	1963-07-02	(051) 0432-1214	9861 Bowman Plaza, North James, AS 26600	Uruguay
thomas16	delacruzronald@example.org	1955-05-17	81 3917-7855	Esplanada Novaes, 71, Leonina, 43812-010 da Costa / GO	Macau
qpastor	cunhamiguel@example.net	1953-08-18	542.544.9355	USS Jones, FPO AE 51440	Syria
lopeshenry	aguilarlauren@example.org	1998-02-24	(081) 7386 6674	Trevo Vitor Hugo Azevedo, 57, Boa Vista, 89790-400 Rodrigues do Norte / RR	Bolivia
fmendes	bwillis@example.org	1966-09-18	777-418-9797	Ladeira de Castro, 408, Conjunto Jardim Filadélfia, 31002-020 Oliveira / PR	Morocco
christinevazquez	david73@example.org	1976-12-04	398-790-4536x61760	159 Stevenson Island, West David, NV 10960	North Korea
michaeldavis	limajulia@example.org	1952-07-31	+55 51 5990 5341	Lagoa Josué Gomes, 73, Jardim Do Vale, 69777431 Leão de Barros / TO	Liberia
alecmurray	adas-neves@example.org	1946-11-24	(590)604-3628	3977 Thompson Garden, Danieltown, MA 43967	Saint Helena, Ascension and Tristan da Cunha
andre99	portofernando@example.net	2010-01-07	+55 (071) 0441 6306	Condomínio de Novais, 2, Vila Ipiranga, 15953811 Monteiro de Rocha / MG	Saint Lucia
angela41	hendrixjennifer@example.com	1968-06-02	001-360-303-3629x11992	67601 Sims Ford, Torresport, KS 53836	Jordan
vargasester	charlescurry@example.net	1994-02-15	+55 (051) 2028-9284	Trecho Henry Novais, 274, Vila Aeroporto Jaraguá, 96401-375 Aragão Paulista / ES	Japan
amystanley	nascimentovitor@example.com	1961-07-17	5634623065	7206 Mooney Springs, Lake Daniel, TX 70442	Maldives
lporto	fariaspietra@example.com	1984-06-17	+55 21 1761 7918	Estrada Cauê Vieira, 33, Marieta 3ª Seção, 86291951 Barros / AP	Bangladesh
sofia93	michael49@example.net	1936-05-06	51 6139 3389	Largo Farias, 97, São Bento, 27432827 Borges / DF	Syria
rebeccaperez	camarayuri@example.net	1955-05-09	+1-215-934-4184	719 Gill Junction, Lake Leonardberg, OK 16577	Paraguay
machadodavi	moreiraluana@example.org	1958-01-24	220-935-0510	4173 Stanley Valleys Apt. 575, New Taylor, IA 99024	Albania
muellertracey	bmoore@example.com	1919-07-22	(410)455-5420x77570	Quadra de Câmara, 291, Senhor Dos Passos, 96523-506 Marques / RR	Nicaragua
antonio97	pastormaria-flor@example.com	1932-11-20	309.668.1923x8022	049 Jesus Extensions, Joeburgh, CO 99140	Sudan
davi-miguelporto	stephenhoward@example.com	1932-08-30	(720)944-0464x2701	9700 April Walks, Colemanstad, GA 39205	Falkland Islands
christopher27	wvieira@example.org	1933-01-28	(081) 5116 6472	Trecho de Fonseca, 875, Teixeira Dias, 39416-427 Silva do Oeste / PI	Macau
aylada-rocha	emanuel59@example.net	1929-10-22	239.769.2330x56934	409 Robert Haven, North Jacobborough, AR 60837	Hong Kong
syates	tcavalcante@example.org	1927-11-10	5183716191	Campo de Monteiro, 93, Esperança, 30609-777 Duarte Verde / RO	South Korea
asilveira	stephanie63@example.net	1956-11-19	71 7516-1938	57631 Thomas Lane Apt. 962, West Jacquelinebury, WI 90065	Belize
qsolis	camposvalentim@example.net	1934-04-03	001-689-434-0744x1717	6477 Jacobson Coves, Lisaport, TX 90879	Kyrgyzstan
nchambers	ana-liz01@example.net	1913-12-20	+55 31 8178 3280	Loteamento de Montenegro, 17, Apolonia, 40293799 Carvalho / AP	Somalia
bfreitas	ferreiradavi-lucas@example.com	1912-01-01	+55 51 6243 7222	Quadra Almeida, Bonfim, 12847-733 Silva / DF	Burundi
meyermelanie	woodjohn@example.com	1976-10-01	+55 11 7655-2839	Morro Cassiano, 995, Cruzeiro, 13635587 Cirino / AC	Liechtenstein
megan15	ashleyfisher@example.com	1979-02-16	0500-646-5412	Viaduto de Vasconcelos, 63, Heliopolis, 01093-929 Marques do Amparo / PA	Uruguay
luanabreu	eloa13@example.org	1973-06-21	+55 (041) 1691-8358	Vereda de da Cunha, 91, Novo Glória, 66252306 Pereira de Santos / SP	Hungary
hmiller	danielkevin@example.com	1977-08-13	599-304-7843x50262	USNV Valencia, FPO AA 82918	Chile
sousatheodoro	arthur43@example.net	1964-08-25	71 2499 9222	Estrada Mathias Pacheco, 76, Candelaria, 32102-156 Gomes / DF	Eswatini
sullivanhannah	yorkjanice@example.com	1911-07-11	(779)235-0156x993	9093 Strickland Centers, New Harryland, DC 03471	Paraguay
allenmaria	ida-cunha@example.net	1960-12-14	31 2743 1787	Vila Dias, 347, Acaiaca, 41098-970 Sousa / ES	Western Sahara
ahill	katiekelly@example.org	1988-06-11	+55 (081) 8286-3548	9171 Robert Common Suite 042, Larryfurt, AK 09598	Colombia
hcline	xcavalcanti@example.org	1925-07-03	001-799-829-2606	Campo Asafe Montenegro, 50, Mangabeiras, 37447639 Aparecida das Pedras / MG	Papua New Guinea
zpimenta	zoe34@example.net	1921-10-11	858-404-5115	9262 Smith Underpass Suite 708, Medinafort, VA 29757	Oman
youngmelinda	uyoung@example.com	2013-05-17	+55 (071) 6603 9738	Rodovia da Mata, 78, Santa Inês, 36615466 Abreu / RS	Morocco
jane40	harrischeryl@example.org	2008-07-18	+1-876-571-1379x2898	353 Cindy Mission Apt. 146, Lanestad, NE 95965	Thailand
luiz-felipe33	elisa40@example.net	1928-04-10	509.335.1209x1757	Favela Fonseca, 62, Vila Calafate, 70547986 Gonçalves / AL	Panama
hicksseth	aaron96@example.com	1990-10-09	+55 (051) 6557 5841	Travessa Sousa, Horto Florestal, 65986-493 Sá do Sul / SC	Oman
wmendonca	piresluna@example.com	1918-05-12	001-744-520-4958x944	14947 Holly Lodge Apt. 417, Mcphersonmouth, OK 78753	Georgia
ana-luiza74	heloisa43@example.net	1935-04-22	+1-980-319-8012x583	Núcleo Ana Costa, Goiania, 79272-072 Azevedo de da Rocha / RR	Liechtenstein
donaldmiller	courtneyhernandez@example.net	1967-07-30	434.725.7757x004	Praia da Mata, 86, Camponesa 2ª Seção, 39240462 Andrade das Pedras / SC	Samoa
margaret46	arthurgarcia@example.net	1952-01-04	+55 41 8960 1187	Recanto da Luz, 8, São Benedito, 90936-828 Fernandes / RR	Albania
isaac51	howardalice@example.net	1954-10-02	21 3792-5818	6044 Alison Via Suite 584, New Carrie, MH 18417	Tonga
whiteandrew	contrerasvicki@example.net	1918-09-04	932.771.6634x713	Distrito Melissa Moreira, 1, Pedreira Padro Lopes, 27370887 Novais da Mata / RO	Andorra
duanehatfield	henry72@example.net	1922-06-21	948-708-5669x1411	USS Walker, FPO AP 14983	Mexico
amanda40	codynavarro@example.net	1949-06-12	0900-428-7700	Setor Barbosa, 40, Conjunto Serra Verde, 44487418 Azevedo de Minas / MG	Saudi Arabia
timothy01	cooperkiara@example.org	2003-05-09	895-705-3080	Vila Davi Siqueira, 31, Embaúbas, 24212-542 Macedo do Sul / AC	Belize
rwilson	lschroeder@example.org	1962-12-26	202.216.5555	9166 Joseph Brook Suite 046, Millerchester, ID 80943	Papua New Guinea
matthew55	stella25@example.net	1926-04-07	405.491.3937x57190	Travessa da Luz, 97, Vila Madre Gertrudes 3ª Seção, 16910185 Casa Grande / DF	Panama
butlerelizabeth	isampaio@example.net	1920-08-26	274-936-4835	Via Ribeiro, Santa Terezinha, 83686304 Lopes / PI	Chile
maitearaujo	estherda-rosa@example.com	1928-08-22	(011) 2133-6588	9420 Sabrina Extensions Suite 673, Toddberg, WI 77130	Hong Kong
josephmartinez	nsa@example.com	1993-09-15	+55 (081) 9260 6195	Lago de Sales, Jardim Atlântico, 79511-845 Vasconcelos de Vargas / PA	Aruba
meloyan	breno31@example.net	1924-08-15	(354)528-7602x3989	869 Mcintosh Canyon Apt. 635, Terrellbury, MN 05431	Central African Republic
rcassiano	costelaerick@example.net	2000-01-20	(564)553-3526x375	309 Richard Divide Apt. 744, Cassandramouth, ID 69531	Laos
lizsales	cookjoseph@example.net	1970-08-06	+55 (071) 0602 3501	Feira de Brito, 301, Cabana Do Pai Tomás, 57726148 Pimenta de Santos / SE	Madagascar
olivia68	robertlloyd@example.org	1910-05-04	+55 71 3360 7020	66850 Shaw Port, Davidbury, CT 46073	Somalia
borgesheitor	vargasnicolas@example.net	1953-01-09	+55 71 1340-4392	2036 Riley Hill, Griffinfort, HI 20346	Tanzania
felipepastor	barbosamaria-liz@example.com	1921-03-29	(031) 3459-9636	Avenida Pedro Lucas Brito, 4, Dom Cabral, 24939981 Sousa / BA	Tunisia
john71	earnold@example.net	2008-09-12	(793)537-0781	Vila Ryan Câmara, 82, Flavio De Oliveira, 00691-014 Garcia do Galho / RR	Jamaica
viniciusmarques	carrie49@example.net	1955-05-29	41 1426 3919	09432 Joseph Fort, Blakeshire, SD 49762	Sweden
kevin19	psmith@example.org	1954-03-03	(081) 4657 0842	Via Maria Liz Rodrigues, São Paulo, 18765-444 Oliveira / SE	Morocco
jermainejohnson	justindalton@example.net	1948-08-19	001-441-269-3993	Distrito Lavínia da Mata, 56, Vila São João Batista, 52729-372 Melo / PE	DR Congo
palmeida	kevin69@example.net	1974-04-18	(071) 1373-4344	USNV Kelly, FPO AE 58730	Singapore
scott09	emanuellyaragao@example.com	1924-12-30	(915)485-5610x3587	PSC 9294, Box 0647, APO AE 69079	Oman
fcruz	drezende@example.com	1988-06-15	468-756-3531	Unit 0433 Box 8029, DPO AE 71518	Honduras
cerickson	rnascimento@example.com	1951-01-30	685-452-4925x445	20395 John Valleys, Robinsonview, NE 68558	Bolivia
joao98	kpeixoto@example.net	1920-06-05	578-542-3939x1087	43573 Christine Track Suite 600, Gabrielleborough, NC 47465	Armenia
amberhernandez	ashley21@example.org	1979-01-06	221.862.7207	Feira da Mota, 26, Primeiro De Maio, 69106-883 Abreu da Serra / SC	Vietnam
xturner	pbarbosa@example.net	1988-11-11	618.794.3779	Condomínio de Albuquerque, 45, João Paulo Ii, 02920-815 Sampaio / MT	Oman
mcardoso	maria-sophiaalbuquerque@example.com	2008-09-22	898.311.7282	Jardim Ferreira, 92, Monsenhor Messias, 49034-777 da Costa das Flores / GO	Maldives
crystal01	fogacadavi-miguel@example.net	1987-06-10	+55 (041) 0345-9813	251 Murphy Green Apt. 225, North Christina, VI 93716	Comoros
chris52	rwilliams@example.org	1914-07-13	+55 51 0403 7133	6107 Sparks Islands, Matthewberg, NE 54149	Sweden
xhancock	brenda94@example.com	1933-04-12	+55 (031) 5888-6813	Aeroporto da Paz, Vila Dos Anjos, 22950752 Moraes de Minas / MT	Liechtenstein
bowmansylvia	scavalcanti@example.org	1975-08-26	364.634.2206x00336	Viaduto de da Mata, 15, Pousada Santo Antonio, 30805-130 Sousa / RR	Cambodia
kellyhampton	michael05@example.org	2001-02-04	51 8177 6769	45652 Miller Forge, Robertside, VT 21793	Bermuda
rcamargo	vgomes@example.net	1946-09-12	+1-939-933-0239x5645	PSC 3738, Box 8628, APO AA 27250	Bulgaria
larissa57	alvesrael@example.org	1987-05-31	238-297-1117	Sítio Heitor Sá, 63, Ademar Maldonado, 08656900 Novais / PR	Iceland
davismarcus	foleydavid@example.com	1943-10-16	810-279-8640	Quadra Cardoso, Vila Vista Alegre, 47932619 Sousa / PA	Namibia
alexiaferreira	freitasisaac@example.org	1940-03-18	001-343-485-2476	Rodovia Castro, 143, Planalto, 87965-093 Camargo do Amparo / AM	Djibouti
fbullock	rachel83@example.com	1930-07-07	(290)689-3354x93526	460 Steele Park, Richardshire, AS 44570	South Korea
raraujo	frios@example.net	2010-06-07	478-459-9801x08034	Travessa de Castro, 42, Custodinha, 80125580 Sales da Serra / SE	Burundi
jroberts	isis01@example.com	2007-12-21	(316)809-2074x89726	09402 Michael Burg Suite 801, Royside, VI 28372	Uzbekistan
zferreira	cavalcantestella@example.com	1925-04-08	0900 793 9564	Vereda Nogueira, 595, Vila Nova Gameleira 2ª Seção, 82976-945 Silveira do Campo / RJ	Samoa
jsiqueira	qhill@example.net	1949-05-12	0900 681 1538	01866 James Terrace Suite 565, New Nicholemouth, VI 70819	Poland
upacheco	yasmin27@example.org	1957-01-08	+55 21 2021-2598	79422 Diane Mews, New Bethany, RI 68850	Guatemala
davidramirez	rdowns@example.net	1989-10-31	448-535-0117x1981	Via de Fernandes, Morro Dos Macacos, 05772304 Porto Alegre / MS	Saint Lucia
yago18	madisonmayo@example.com	1915-07-03	81 4095 3672	Feira Luigi Brito, 3, Jardim Guanabara, 12879416 Casa Grande Paulista / ES	Brazil
caseyscott	brayansilva@example.com	1943-03-08	850-645-2196	Núcleo Barbosa, 5, Taquaril, 17840-535 Ribeiro de Barbosa / AM	Bahrain
vieiramarcela	xalmeida@example.net	1989-09-14	+55 (011) 5618 0590	PSC 7930, Box 9958, APO AE 83594	Indonesia
laisda-mata	luiz-henriquemarques@example.org	1968-05-05	0300 366 6812	Condomínio Brito, 68, Buritis, 96195-288 Marques / RR	Vietnam
sheribryant	tanya87@example.org	1920-07-05	+1-477-709-3617	425 Mcfarland Brook Apt. 810, Henryberg, NH 59208	Morocco
pedro-lucas22	milena52@example.net	1927-04-04	(731)622-5516x23166	Setor de Cunha, 1, Apolonia, 45340902 Lopes / PI	Guatemala
miguel11	mnascimento@example.net	1972-12-16	+55 (061) 8595 6156	53931 Karen Turnpike Suite 103, East Amybury, NE 35619	Iceland
zachary05	laura22@example.net	1995-02-06	+55 11 1991 5664	Núcleo Clara Carvalho, 5, Vila São Gabriel Jacui, 30085260 Alves / AL	Myanmar
liamribeiro	pedro-lucas84@example.net	1958-09-19	+55 84 9656 9778	Fazenda de Barros, 113, Vila Pinho, 36293-734 da Mata da Prata / BA	Nigeria
maria-vitoriada-conceicao	ellenbrooks@example.net	1984-03-18	81 5193-1080	Via de Guerra, Novo Ouro Preto, 07869975 Melo / PR	Madagascar
amanda12	willisrichard@example.com	1969-09-21	585-780-0000	Rua da Mata, 56, Vila Santa Monica 1ª Seção, 58066324 Farias do Oeste / RO	Liechtenstein
theo52	rafaelapacheco@example.org	1962-07-22	31 1381-4655	2893 Murray Roads Suite 729, West Richardburgh, WY 30890	Jordan
gonzalezamanda	unovais@example.net	1991-05-17	+55 (061) 2670 9506	Jardim de Mendes, 89, Camargos, 47091-924 Nascimento / PI	Uganda
toddburton	jade82@example.com	1963-03-10	(081) 4707-5665	8106 Tina Island, Hillview, WV 15493	Lesotho
lunna98	ana-juliarocha@example.net	1985-04-15	+55 84 7359-3623	Morro Ana Clara Vargas, 5, Corumbiara, 32569-407 Lima / GO	Brunei
oliveiraandre	xjennings@example.net	1982-10-12	(615)519-1868x64461	Fazenda de Souza, 64, Serra Do Curral, 89099449 Mendonça de Santos / TO	Costa Rica
cauecamargo	vargasdavi-miguel@example.net	1943-04-20	+55 71 2292 0042	42755 Johnson Flat Suite 894, West Andrew, RI 96795	Cayman Islands
melindagallegos	timothyarnold@example.org	1974-04-04	001-312-946-4628x94363	Travessa Moura, 5, Novo Aarão Reis, 47276293 da Paz / SC	Samoa
maria-helenaribeiro	raelfreitas@example.org	1968-01-21	001-572-254-8443x48322	81138 Craig Crest Suite 674, Williamsport, AL 27956	Guinea
courtney73	sousaester@example.net	1959-09-17	220-264-8728	65261 Kelley Summit Apt. 891, South Teresa, OH 10543	Belize
tammydelacruz	patriciasmith@example.net	2000-04-15	001-793-637-7142x94585	36718 Jarvis Prairie Apt. 502, West Michael, MA 91528	Kazakhstan
da-rochagael-henrique	stephany12@example.org	1999-12-28	(084) 6998 4430	176 Roberts Pine Apt. 515, Jasonside, MD 04985	Fiji
zcastaneda	jonesgregory@example.com	2012-08-12	+55 21 1175 7264	Via Martins, 16, Garças, 33266881 Souza / GO	Czechia
nfernandes	tina83@example.com	1936-10-29	001-610-701-6688x91881	Rodovia de Costela, 1, Minas Brasil, 01972192 Cavalcante do Norte / MT	Pakistan
jcamacho	catarina96@example.net	1911-04-20	001-716-919-9187	Núcleo Macedo, 43, Serra Verde, 42783400 Mendes Grande / PE	Laos
cavalcantigiovanna	davi-lucca69@example.org	1988-07-01	84 5011 4377	Vale Antonella Sousa, 60, Mala E Cuia, 24310-459 Borges de Rodrigues / SC	Eritrea
carteralexander	kcampos@example.net	1954-05-19	(527)879-6803x888	PSC 8021, Box 6809, APO AP 36394	Taiwan
mooneyamber	portoyuri@example.org	1930-11-25	753-581-3071x1163	60759 Rogers Run, Lauriestad, AK 44863	Gambia
martinezchristopher	leonardmitchell@example.net	1952-01-25	(031) 3360-6672	Avenida Moreira, 395, Marieta 3ª Seção, 50099-596 Freitas / PE	Moldova
nashedward	donaldmeadows@example.com	1962-04-12	71 2595-7578	Rodovia de Sales, 23, Independência, 72394965 Montenegro / RS	Sri Lanka
enogueira	hwalter@example.org	1930-11-16	(362)337-9825x8781	Chácara Pereira, Céu Azul, 71507502 Sá / AP	Zambia
paul07	vanessagonzales@example.org	1992-10-28	0800-421-5585	0782 Greer Vista, Pamelaview, CT 61329	Tonga
matteo40	tiffany14@example.com	2008-07-06	450.264.2312x865	Esplanada de Lopes, São Jorge 2ª Seção, 02322388 Montenegro / BA	Suriname
fpeixoto	zjesus@example.net	1948-09-16	908.338.7650x7649	USCGC Murphy, FPO AP 58195	Central African Republic
paulo26	da-mataenzo-gabriel@example.net	2011-09-13	+55 31 2845 0868	893 Hendricks Motorway, Lake Ginahaven, WA 98280	Djibouti
lisahernandez	dsantiago@example.com	1928-10-14	41 0365-2181	898 Hall Flats Suite 070, New Jessica, IL 14243	Kyrgyzstan
diasana	blane@example.net	2000-02-10	61 6057 4078	57696 Wendy Common, South Tiffanychester, ME 68745	Lesotho
vargaselisa	jeffersonjermaine@example.net	1970-01-01	+55 (081) 2302-6915	Alameda Anthony Nogueira, 2, Conjunto Bonsucesso, 40035-675 Cavalcanti do Sul / PR	Uganda
clopes	danielle45@example.net	1960-10-14	+55 71 0837-7479	2634 Amber Port Suite 796, East Ashley, WA 67377	Bangladesh
peter38	vdias@example.com	1957-11-14	+55 51 7143 2573	54262 Thomas Shores, Stefanieland, WY 99236	Bolivia
edwardstravis	gsales@example.net	1990-09-07	854-293-0492x60721	Chácara Moura, 629, Boa Esperança, 22250527 Barbosa / AL	Liberia
nliu	sally62@example.com	1958-06-25	258.718.1747x1881	182 John Forks, New Tonyabury, TN 28722	Panama
donaldwalker	da-rochaluiz-felipe@example.com	1951-03-20	21 3688 0574	626 Thomas Hills, Emilyland, NH 08889	Yemen
ipastor	bellbrandy@example.net	1983-01-11	9454529888	Passarela Araújo, 20, Conjunto Paulo Vi, 47072-848 Alves Alegre / AP	Ghana
asilva	aparecidamaria-eduarda@example.com	1965-04-16	31 2884 4459	Vereda Joaquim da Luz, 5, Vila Havaí, 58603-224 Barbosa de Silva / PE	Jamaica
kcunha	manuellaborges@example.net	1920-11-11	+1-492-259-2134x1737	552 Malone Shore Apt. 550, Lisachester, WI 96224	Bermuda
sullivanandrew	carla67@example.org	1974-07-13	(071) 6391 5665	523 Torres Summit Apt. 158, Newtonchester, VT 81200	Sudan
djackson	silveiranicolas@example.com	1956-04-26	+55 84 4233-5873	5369 Mary Village, Jonesport, CO 33842	India
mooremichael	abyrd@example.com	1920-09-30	+55 (071) 8325 8501	Residencial Dias, 31, Serra, 05617-793 Gomes de Marques / TO	Central African Republic
carrie95	asafepires@example.com	1976-06-22	21 4877 0771	33055 Katrina Ramp, Hahnmouth, MH 23589	Sudan
christina80	davi-luccaramos@example.com	1948-12-11	(713)772-4373	Estação Lunna Dias, 92, Mantiqueira, 69673689 da Paz de Caldeira / DF	Somalia
philip04	wallacelori@example.net	1918-02-16	0900 666 7070	Distrito Emanuella Viana, Cachoeirinha, 61026624 Guerra da Prata / AP	Indonesia
flima	andrew28@example.com	1985-11-23	(071) 7988-2863	Estrada Farias, 10, Chácara Leonina, 49529678 Novaes / SE	Gibraltar
ruiztammy	isis72@example.net	1975-06-03	0300 258 2402	802 Martinez Wells Apt. 950, Juanfort, PW 23540	Fiji
lynnsamuel	noah62@example.net	1937-09-04	(516)390-5049	Vila de Lima, 694, Vila Antena Montanhês, 37006-137 Cunha / AL	Bahrain
chadhutchinson	carolinesilveira@example.com	1922-07-27	001-518-860-0198x031	21557 Steven Flats Suite 934, Lake Kim, VI 56357	Jamaica
moraesdavi-luiz	luigi98@example.org	1990-04-08	6022165863	Feira Gomes, 58, Vila Madre Gertrudes 4ª Seção, 29742-927 Oliveira / PE	Kiribati
brownsydney	ceciliada-rocha@example.com	1996-12-06	259.976.2886	46703 Mccullough Forge, Fosterfurt, NH 40809	Mexico
lesterpaul	tlamb@example.net	1931-10-21	+55 (061) 1422-2257	Estrada Clarice Campos, 481, Cachoeirinha, 26905620 Alves de Minas / ES	Brunei
brownlisa	rmendes@example.com	1952-07-19	698-694-3810	2973 Weber Causeway Apt. 796, Adamborough, VT 99669	Ukraine
maitepimenta	eduardojesus@example.com	1990-02-09	0800 811 7858	874 Flores Springs Apt. 867, Smithside, IL 25724	Pakistan
samaria-flor	isaque35@example.org	1999-09-16	001-505-613-2031x01744	Praia Lima, Beira Linha, 74821219 Mendonça do Galho / SE	Colombia
andrewarmstrong	jeffmullins@example.org	2009-12-16	(374)352-6938x5242	Vereda Theodoro Ribeiro, 79, Comiteco, 72547-259 Nunes do Norte / RO	Western Sahara
teixeiragabriela	da-cruzvitor-hugo@example.org	1997-02-08	(833)852-7485x82662	Alameda Moura, 57, Vila Paquetá, 95737-881 Lima / DF	Yemen
ana-lauranovais	luiz-fernandocamara@example.net	1975-06-06	+55 71 0580 2981	03789 Kenneth Locks, Lake Nathantown, MO 37313	Belize
mharrison	monteiroenrico@example.net	1944-09-25	3418163051	Núcleo de Martins, 37, Vila Puc, 58088387 Aparecida / PI	Poland
jesusana-sophia	brettpalmer@example.net	1910-02-08	001-483-274-5346x81230	Residencial de Peixoto, Jardim Do Vale, 81935287 Campos Alegre / MA	Myanmar
camaravicente	ualvarez@example.com	1993-03-02	001-838-607-3935x405	552 Garrett Grove Apt. 790, East Tamara, WY 66573	Haiti
leo22	gabriellopes@example.com	1918-02-19	+1-836-761-9982	8280 Pruitt Ranch Suite 040, Smithtown, MS 61028	Kazakhstan
johnsonmichele	eloacostela@example.net	2007-08-23	(061) 3879-9575	18251 Dean Rapids, Port Sean, RI 93339	Chile
rferguson	darryl53@example.org	2008-05-31	001-903-585-3706x4108	Travessa Maya Camargo, 66, Paquetá, 07930005 Albuquerque de da Paz / RR	Bangladesh
luana98	vitor-gabriel79@example.com	1989-12-19	31 0752-8753	Unit 8477 Box 7822, DPO AA 92288	Bolivia
carrie86	lmorris@example.org	1995-01-30	001-847-429-5832x95300	Largo Porto, 3, Bela Vitoria, 54839661 Campos da Praia / AM	DR Congo
sarahmanning	emanuellamartins@example.com	1992-08-20	594-649-3776x519	Conjunto Yago da Rosa, 79, Xangri-Lá, 44672084 Lima do Campo / AC	Kyrgyzstan
shannontaylor	nicolasmarques@example.com	2001-01-28	81 4117-2369	40113 Maureen Village Apt. 593, Lyonsberg, FM 32621	Kiribati
hellena59	hellenasiqueira@example.net	1928-01-01	+55 51 7688 0353	Estação Cavalcanti, 69, Calafate, 75226030 Moura das Flores / RN	Russia
gabrielcastro	joseferreira@example.com	1967-06-26	0300 177 2202	Passarela Teixeira, 41, Vila Madre Gertrudes 3ª Seção, 63741846 Ramos de Mendes / RN	Rwanda
mirella55	christopher33@example.org	1969-09-11	001-774-561-0756x547	Travessa das Neves, 42, Ribeiro De Abreu, 62830-167 Gonçalves / BA	Myanmar
timothyhuang	machadoantony@example.net	1957-01-11	761.312.5580	Jardim Bárbara Nunes, 4, João Pinheiro, 51872-733 Jesus / RJ	Kazakhstan
jmccormick	theresa69@example.net	1919-03-28	(081) 2612-0009	86882 Andrew Forge, Stephaniestad, TN 97927	Sudan
lunnasilva	moonandrew@example.org	1912-11-22	84 8718 3483	Recanto Ana Cecília Guerra, 10, Jardim Do Vale, 01883610 da Cruz de Cirino / AL	Burundi
katherine43	ugates@example.net	1933-04-08	223-755-2802	070 Mark Keys, North Kristinaside, NM 18619	Albania
tuckergregory	pereiraisabelly@example.org	1916-03-26	+1-836-908-5131x09676	90507 Pamela Stream Apt. 067, Port Katherine, PA 92824	Papua New Guinea
melinaoliveira	jade85@example.net	1973-04-10	867-983-3066	Praça Rezende, 2, Rio Branco, 74469335 Lopes / PR	Argentina
george29	omoreno@example.org	1968-01-31	001-893-966-0007x554	45157 Lori Dam, Port Donald, MP 23181	Turkey
caitlinhiggins	heatherwalters@example.net	1959-06-25	001-916-522-1752x04209	Área de Caldeira, 57, Conjunto Califórnia I, 41273-061 Mendonça / PR	DR Congo
ynash	enelson@example.org	1980-01-15	(031) 0584-8950	Unit 2146 Box 9120, DPO AP 82089	Ivory Coast
guerrajoao-gabriel	reneerodriguez@example.net	1931-09-21	(329)317-6050x6220	9275 John Islands Apt. 739, South John, VA 51157	Cayman Islands
mary78	eferreira@example.org	1991-03-27	301.420.9010x4459	2348 Christina Extension Suite 193, New Carlaton, DC 47090	Kyrgyzstan
joao-lucasda-mata	bruno70@example.com	1945-02-16	(329)689-8736	Unit 4056 Box 3477, DPO AA 56679	Hungary
wcunningham	amanda27@example.net	1995-07-05	801-577-9471	2505 Kristin Neck, Port Melanie, AZ 38076	Serbia
maria-isis12	rvaldez@example.net	1962-02-17	+55 84 0463 1602	Conjunto Alves, 667, Nossa Senhora Aparecida, 93071-381 Cunha de Goiás / TO	Romania
qmoreira	vhaynes@example.net	1980-09-14	+55 (051) 6071 2422	Praça Casa Grande, 833, Inconfidência, 54367-382 Marques / AP	Nicaragua
xhernandez	sarah79@example.net	1978-10-25	+1-348-334-2040x1294	02918 Butler Lights Apt. 399, Karenshire, WA 13311	Bosnia and Herzegovina
larissagarcia	mariane10@example.net	1918-03-04	(736)623-5261x31942	Vale Stephany Sá, 9, Boa Esperança, 26013-487 Barbosa / AL	Papua New Guinea
ksales	machadomarcelo@example.org	1942-08-07	84 8972-2470	Estrada João Miguel Rocha, 75, Paulo Vi, 86126-083 Leão / AM	Wallis and Futuna
gcorreia	bscott@example.com	1915-06-28	(041) 4322-8812	Largo Câmara, 4, Brasil Industrial, 27546547 Leão de Minas / PB	Pakistan
josedavis	xalvarado@example.com	1915-07-19	001-622-321-9869x6976	Estrada de da Rocha, 53, Vila Santa Monica 2ª Seção, 72567053 Cassiano / RJ	Cuba
xharper	thalesfogaca@example.net	1946-12-10	848-776-9266x9441	672 Sean Locks, Williamsmouth, MT 28888	Uruguay
pgreen	maria-juliamartins@example.com	2000-12-24	81 1728 9950	9617 Linda Common, Phillipsville, ND 05535	Bosnia and Herzegovina
patrick70	jamesrice@example.com	1966-12-22	+55 (071) 9857 0746	Área Mariane Teixeira, 9, Boa Esperança, 32004960 Guerra / AP	Papua New Guinea
devin93	thalesaragao@example.net	1946-11-20	+55 (031) 0375 1928	Passarela Melo, 10, Santa Amelia, 91672-842 Rodrigues Grande / PR	Western Sahara
anada-cunha	gabrielspencer@example.net	1918-10-01	652-215-9177	Via João Ramos, 57, Maravilha, 65310-749 da Cunha de Minas / BA	Andorra
portolivia	leaoana-cecilia@example.com	1928-03-11	689.499.6785	9104 Schwartz Trafficway, New Kellybury, PW 65257	Palestine
dda-rosa	laurabeltran@example.org	1940-09-29	5019269606	Condomínio de Dias, 83, Santa Branca, 49232632 Ribeiro / MS	Honduras
peixotojosue	andersondavid@example.com	1929-08-26	+1-512-858-3381	737 Young Dale Suite 466, East Douglasborough, TN 68842	Paraguay
gcosta	dantevargas@example.com	1915-09-20	+55 (011) 7338-6964	7173 Jason Estates, Grahammouth, SD 07136	Botswana
olivia23	dwatson@example.net	1942-11-13	+55 71 7839-9641	04320 Robert Mall, Morrisfurt, MD 23090	Jordan
brush	ppeixoto@example.net	1955-12-21	41 7657 0366	60106 Harold Flats Apt. 488, Elizabethburgh, OK 26301	Japan
fdiaz	novaesian@example.org	1933-12-04	+55 41 3095 4998	Lago Lucas Pimenta, Liberdade, 02269-460 Gonçalves / RS	Aruba
wjones	ramosisadora@example.net	2011-10-30	807-758-7812	Feira Campos, 37, Novo São Lucas, 18644-051 Caldeira Paulista / RJ	Canada
agatha07	masseyvalerie@example.org	1933-07-27	6522611164	Rodovia Pereira, 7, Vila Esplanada, 99945520 Andrade da Mata / TO	Somalia
davisjennifer	stephenmorris@example.com	1949-11-11	0500-417-8061	192 Nicholas Road Apt. 626, Port Susan, NM 57141	South Korea
rhernandez	terri80@example.net	1910-09-18	(061) 9102-2315	0034 Martin Unions Apt. 801, South Laura, AR 72346	Chile
christine94	dcastro@example.org	1959-08-20	609.715.6466x967	Campo de Azevedo, 2, Barreiro, 32201-595 Sá / CE	Macau
cainjames	sampaioleticia@example.org	1969-07-23	001-726-567-4808x5120	11409 Jackson Alley Apt. 125, Wangport, NY 13117	Kyrgyzstan
johnathan94	wattsmichael@example.net	1952-08-20	+55 31 4780 4432	Largo Lorena da Paz, 776, Belmonte, 10836-338 Pimenta Alegre / MA	Indonesia
evansanna	cecilia18@example.net	1987-12-30	71 8702-5941	745 Bill Prairie, Lake Brittany, KS 49712	Ghana
michaelblack	mrios@example.org	1962-03-15	(081) 1414-2610	Chácara de Montenegro, 687, Vila Cloris, 33880478 Monteiro / PE	Saint Helena, Ascension and Tristan da Cunha
renanrodrigues	susansimmons@example.net	1960-02-29	21 2354 5559	71694 Abbott Isle, Lutzmouth, UT 95181	Mauritius
jbrewer	uramos@example.net	1980-04-14	(031) 4559-3994	Passarela Moraes, 95, Vila Califórnia, 51342551 Mendonça / PB	Liberia
igor17	soliskendra@example.org	1953-04-24	+1-852-812-4175x6402	245 Johnson Mills Suite 787, Sandraland, MH 31871	South Africa
pedro-henrique65	brianbarton@example.org	1919-11-03	265-866-7032	4513 Jessica Cove, North Patrickchester, NC 16650	Georgia
diassofia	patricia25@example.org	1963-12-29	+55 (071) 4295-8683	5092 Lisa Square, East David, GA 82121	Liberia
mary15	ribeiroarthur@example.org	1948-07-22	001-992-613-7921x7133	9885 Anna Track Apt. 235, Ayalaview, RI 49970	Ukraine
benjamin35	alicia29@example.net	1914-03-29	0500 290 1240	7700 Rogers Trace Apt. 338, North David, IL 44244	Tunisia
diaskaique	carlos-eduardo78@example.net	1948-06-05	+1-253-352-1429x697	9179 Baker Well Suite 805, North Kelly, MS 41876	Curaçao
michelle74	jessica97@example.net	1958-12-21	+55 (061) 5190-7503	Rua Sousa, 92, São Francisco, 66744-335 Pastor / RS	Zambia
carrie24	gbarnett@example.net	1989-12-02	+55 (031) 8917-3944	Favela de Abreu, 92, São Francisco, 03536037 Barros / RJ	Cuba
borgesmilena	adamsjeremy@example.org	1987-04-18	51 2840 5427	Viaduto Pimenta, 99, Miramar, 44924-925 Caldeira de Minas / TO	Fiji
ryan31	kelseywoodard@example.net	2005-09-03	(270)470-0606x51090	Residencial de Lima, 78, Vila Canto Do Sabiá, 17709960 Mendes / RN	Botswana
marcelo49	lopezbrandy@example.org	1982-10-22	+55 (061) 2034-9779	6336 Theresa Brooks Apt. 026, New Justin, ID 71911	Lesotho
gael17	caldeirajose@example.net	1984-01-21	+1-663-477-9529x0450	Morro de Cassiano, 85, São Tomaz, 83073397 Pereira da Prata / MG	Philippines
costelabrenda	eharrison@example.org	1923-03-10	427-228-3422	93904 Jacob Circle, North Savannahmouth, FM 68722	Peru
zfreitas	christina34@example.com	1957-09-29	(084) 4256 9454	113 Nicholas Stravenue, East Brandon, SD 41941	Saint Lucia
beatrizfarias	nunesbreno@example.net	1999-06-13	989.696.0661	Conjunto Montenegro, Vila Atila De Paiva, 11360-961 da Luz / PI	Israel
steven81	brayancamara@example.org	1923-09-28	(463)484-6444x2032	0553 Walton Trafficway Suite 565, West Adam, IA 38670	Rwanda
zda-mota	duartegabriela@example.net	1963-02-15	+1-584-651-7385x9968	322 Petty Plaza Apt. 262, South Kathleen, KY 31302	North Korea
rodrigueslorenzo	vargasenzo-gabriel@example.net	1928-12-06	(031) 3645 9456	48418 James Courts, West Michael, AK 62909	Rwanda
aschneider	lindashepherd@example.org	2013-06-26	001-539-291-4848x4919	2707 Madison Mount Apt. 408, West Wendy, RI 59570	Mexico
da-pazrebeca	ana-carolina92@example.com	2006-06-20	+55 (031) 7579-3977	Ladeira José Miguel Alves, 15, Alta Tensão 1ª Seção, 17633-492 Moura de Pereira / SC	Iran
foleymargaret	paul27@example.com	1911-10-09	9036297962	Setor Rebeca da Rosa, 99, Antonio Ribeiro De Abreu 1ª Seção, 20590482 Casa Grande da Praia / PI	Trinidad and Tobago
machadovalentina	brownjulian@example.net	1999-09-30	(081) 4314-1374	Quadra Nina Marques, 7, Santa Margarida, 36515-413 Ribeiro das Pedras / PR	Laos
reginaldhines	ana-clarasiqueira@example.com	1923-11-21	+55 31 1980 9803	Parque Lopes, 77, Estoril, 35612-871 Guerra de Jesus / AM	Bahamas
mistymartinez	moraesarthur@example.net	1932-04-27	752-481-0181	24471 Brooks Manors Suite 430, Loweborough, MH 96606	Georgia
dmurillo	luisa41@example.org	1962-01-06	+55 11 6113 5824	28669 Romero Road, North Robertburgh, SC 14872	India
janebrown	danielaramos@example.net	1965-12-26	(031) 9306 5790	46814 York Meadow, Stephaniechester, WA 98502	Maldives
ipacheco	hansenjoshua@example.com	1926-05-24	859.371.8194	8464 Jeffrey Grove, Port Bruceborough, WA 57593	Tonga
vaparecida	pgrant@example.org	1973-08-29	(234)923-3392	Jardim Maria Eduarda Oliveira, 2, Conjunto Jatoba, 05696-004 Leão de Rezende / CE	Sri Lanka
bradshawkristy	allanada-rocha@example.net	2005-04-09	(051) 1272 2089	65656 Cassandra Estates Suite 056, Port Pamelaborough, LA 23975	Sudan
amygarza	jameschen@example.com	1935-04-23	31 5297-0879	Viaduto Pereira, 28, São Sebastião, 20737-143 Correia / AP	Djibouti
traci49	gustavo43@example.com	1945-01-08	+1-318-606-4895x5633	Praia Brito, 77, Sagrada Família, 64920-228 Novais de Cavalcanti / DF	Fiji
tpotter	davissydney@example.net	1998-06-21	+55 (071) 2229 2983	Colônia Stephany da Rocha, 23, Vila Tirol, 07684737 Freitas / SC	Pakistan
richard44	davi84@example.net	1923-10-08	+55 71 5168 0658	Esplanada de Porto, Acaba Mundo, 52888476 Andrade do Campo / MT	Uruguay
eileenritter	daniel97@example.com	1937-03-04	(408)223-8094x148	Travessa Pimenta, Salgado Filho, 85679-720 da Rosa / RR	Tonga
alexanderwalsh	chris43@example.org	1918-08-31	871.618.6069x1839	Morro Albuquerque, 93, Vila Ecológica, 45938-898 Freitas / MG	Laos
tsanchez	michellestrong@example.com	1987-01-10	+55 (021) 4697-2195	80591 Hines Spur, Douglasfurt, AZ 38087	Mongolia
ana-vitoriafernandes	ugeorge@example.net	1947-06-06	0300-382-5801	Condomínio Costela, 7, Lajedo, 43664792 Mendonça / AC	United Arab Emirates
camaramariane	angel27@example.com	1962-01-21	+55 (031) 6832 1238	Ladeira Vicente Sampaio, 2, Etelvina Carneiro, 54390-820 Pires / AP	Uzbekistan
gardnerwendy	kaiquefarias@example.net	1923-11-25	+55 (011) 5025 3746	Rodovia Mendes, 46, Nova Suíça, 59751756 Campos da Serra / TO	Taiwan
gutierrezeric	kda-cunha@example.org	1968-07-10	651.531.6918x83252	19814 Maria Course, Port Michelle, UT 90499	Norway
sampaiomaria-cecilia	mcasa-grande@example.org	1968-09-24	81 5993 5968	9988 Baker Viaduct Suite 937, Riveramouth, NH 05233	Jordan
alantrujillo	hrodrigues@example.net	1992-09-04	0900-573-9206	Lagoa Augusto Nascimento, 392, Maravilha, 36271551 Vasconcelos do Oeste / SP	Taiwan
caua91	albuquerqueluna@example.net	1989-11-05	(084) 7621 9512	Avenida Vargas, 15, Califórnia, 51484438 Cunha / ES	Fiji
gmendonca	oliver76@example.net	1927-02-27	+55 (084) 4261-9927	USCGC Wheeler, FPO AE 74448	Macau
mcavalcanti	gjohnson@example.org	1909-11-08	222-262-8046	Rua de Ribeiro, 512, Planalto, 60844-104 Mendes / PR	Singapore
vitor-hugomachado	zachary61@example.com	2002-08-17	+1-836-884-7621x60533	Jardim de Jesus, 909, Cinquentenário, 13287-846 da Rocha / AM	Gambia
amandajackson	cruzbonnie@example.net	1982-06-26	(081) 0560 2481	Esplanada Sá, 4, Jardim América, 07618-146 Correia das Pedras / MA	Liechtenstein
matthewacosta	kamilly98@example.org	2009-12-02	227-794-3260x9762	08139 Thomas Ridge, Stephanieshire, IN 67163	Zambia
brunamendonca	wsanford@example.org	1942-10-03	(061) 6822-2475	03772 Sullivan Circle Apt. 794, Lake Eric, PR 27583	Sweden
hnunes	terri68@example.com	1969-11-24	(011) 8544-7319	Trevo de Brito, 14, São João Batista, 84173-338 Souza / SC	Kenya
mmontenegro	maria-clara20@example.com	1912-07-19	+1-748-699-8876x8028	Estrada Natália Macedo, 26, São Cristóvão, 96681-036 Rios / RO	Saint Lucia
lrowe	cunhacamila@example.org	1935-04-21	+55 (051) 7375-6566	Quadra de Teixeira, 54, Alto Dos Pinheiros, 44272064 Mendes / TO	Canada
maria-luiza19	joliveira@example.com	1996-02-28	+55 (081) 5006 3131	02217 Erica Canyon Apt. 668, Deniseberg, MT 45487	Vanuatu
hmarques	sweeks@example.net	1914-06-23	+1-424-380-1222	6224 Eric Circles Suite 160, Lake Mollychester, IN 42600	Tanzania
fernanda14	michelle68@example.org	1942-01-23	517-740-7810x266	588 Peter Green, East Stacy, IN 06242	Somalia
qmendes	cauepacheco@example.net	1997-04-05	001-645-921-1028x90330	342 Scott Place, Tashaton, SC 47885	Uzbekistan
novaessophia	murilo04@example.org	1978-04-08	799.661.7556x0461	Quadra Kaique Mendes, 46, Paquetá, 89984-284 Cassiano / MT	Djibouti
erichard	zda-conceicao@example.net	1980-05-02	+55 (031) 3410 1365	USNS Bruce, FPO AA 16181	Tunisia
luanaaragao	nicole08@example.org	1985-08-23	+55 (041) 5936-1660	Vila Pimenta, 269, Vila Madre Gertrudes 1ª Seção, 74693-749 Sampaio / ES	Macau
fda-paz	kevinpacheco@example.net	1929-09-27	+1-634-954-5725	9197 Cox Crossroad Apt. 363, West Scottton, LA 59443	Kyrgyzstan
josephcunningham	yasmin90@example.org	1983-06-04	+55 (041) 5270-0448	Alameda de Vieira, 540, Vila Maria, 27450174 Farias / PE	Oman
xmack	emanuellacaldeira@example.org	1953-08-28	+55 11 4388-7652	055 Snyder Avenue, Melodyland, MA 28779	Myanmar
santoscamila	warnerjoel@example.org	1936-06-22	(499)367-0416	41879 Romero Meadows Suite 202, Lake Davidport, FM 88842	Saint Helena, Ascension and Tristan da Cunha
ana-luizateixeira	wheelerjeffrey@example.com	1995-01-14	81 2241 3776	Campo Sabrina Peixoto, Custodinha, 49720017 Montenegro / RO	Peru
michaelramos	amandabrito@example.org	1966-09-09	(084) 8955 6613	USS Welch, FPO AP 45857	Jamaica
timothybecker	yphillips@example.org	1997-03-16	0800-507-9235	Travessa de Abreu, 95, Ribeiro De Abreu, 59776987 Rocha / ES	Honduras
stephanie20	steixeira@example.org	1916-07-12	+1-676-820-0605x098	USCGC Bennett, FPO AA 62310	Eswatini
elisa35	cpatterson@example.org	1960-07-23	(228)650-1212	58997 Cole Port Suite 843, South Julia, VA 14322	Burundi
cody07	arthur11@example.net	1942-06-24	770.258.9317x01477	Largo de Montenegro, 299, Universo, 89444-022 Azevedo / PB	Bosnia and Herzegovina
theodoroda-costa	araujoalexandre@example.com	1911-01-02	51 5827 5896	068 Bethany Crossroad Apt. 029, Patrickview, VA 13504	Burundi
da-luzluiz-gustavo	xlima@example.org	1955-07-31	+1-750-604-5327	Trecho de Rios, Alto Caiçaras, 77090346 Souza / ES	Singapore
kellygonzalez	nicole73@example.org	1996-05-11	(031) 6815 3553	1667 Edwards Forge Apt. 847, Emilyburgh, AR 68063	Vietnam
sampaiohellena	michaelmedina@example.org	1991-03-12	(626)493-5673x1712	9808 Walls Mission, Andreaport, NM 77848	Puerto Rico
gustavo-henriquemartins	alexia88@example.net	1997-12-12	+55 31 7262-6308	Pátio Pastor, 72, Conjunto São Francisco De Assis, 75669403 Novais / ES	Sweden
cassianothomas	caueda-mata@example.com	1940-07-16	0800-545-3648	2765 Moore Spur, Lake Nathantown, AK 82481	Turkmenistan
allenashley	craig74@example.org	1969-01-22	0800 411 5251	Morro Montenegro, 16, Cidade Jardim Taquaril, 22491-185 Fonseca de Vargas / ES	Wallis and Futuna
augustomoraes	randall93@example.org	1911-02-14	+55 11 7758-7609	904 Alexandra Lake, Gonzalezside, NJ 28234	Sweden
luanpacheco	cirinotheo@example.net	1941-04-16	+55 61 3662 5737	Unit 5404 Box 4412, DPO AP 27654	Canada
ramoslara	joao-guilhermefonseca@example.org	1972-07-14	001-220-558-6778x3994	907 Christopher Common Apt. 934, Danielside, KS 07708	Papua New Guinea
rodriguesana-vitoria	sarahnichols@example.net	1953-11-28	+55 (071) 0338 6883	Residencial de Leão, 55, Vila Puc, 41052-721 Lopes / AM	Liechtenstein
emily37	josue44@example.net	2003-09-08	(889)285-4554	3923 Michael Center, Port Josephmouth, NV 77435	Bolivia
maria-florpinto	karenhartman@example.net	1948-02-17	(061) 2702-1404	Lago Costa, Coqueiros, 82515-756 Pastor / DF	Falkland Islands
mbryant	anamonteiro@example.org	1945-04-15	(061) 6067 9737	Viela Joaquim Cirino, 42, Vila Antena, 99757-719 Cavalcante da Serra / SP	Ghana
bda-costa	ceciliateixeira@example.net	2005-09-09	(051) 6810-8644	Sítio da Luz, 97, Lagoa, 70817-844 Farias / MA	Thailand
johnsonrhonda	irowland@example.org	1960-03-17	41 3822-1671	Lago de Monteiro, 46, Ademar Maldonado, 20087366 Peixoto / RN	North Korea
ana-vitoriaaraujo	christinascott@example.net	1935-07-15	001-747-773-4602	6912 Fisher Flat, Port Michaelbury, RI 92591	Ivory Coast
leemiguel	mendesbrenda@example.org	1924-02-07	(051) 7992-5455	1504 Kirk Lakes, Rebeccabury, VA 25775	Ethiopia
davidgilbert	isis16@example.org	1951-02-05	7722361201	Rodovia Maria Laura Barros, 789, Belvedere, 15468-221 Rezende / AL	Eritrea
alexiapastor	alana83@example.org	1939-04-01	+55 (011) 7996 8446	Unit 0344 Box 5340, DPO AA 06429	Norway
juanvargas	kennedydamon@example.net	1985-12-05	6883827507	Sítio de Pires, 6, Alto Dos Pinheiros, 72301-301 Porto / BA	China
ymejia	michael64@example.org	1943-12-08	0300 726 5992	Unit 1299 Box 0135, DPO AE 33423	Falkland Islands
dclark	aparecidajosue@example.org	1923-10-03	71 5852-4181	Loteamento de Aparecida, 58, Cônego Pinheiro 1ª Seção, 42497-656 Porto / MS	Iceland
vargasanthony-gabriel	rbrown@example.net	2003-04-13	(288)388-3438	2518 Yang Wells Suite 370, Powellborough, IA 91252	Cuba
bianca33	pietragoncalves@example.com	1935-06-30	496-597-4175x82522	01502 Natalie Harbors, Rodneyfurt, ND 61441	Saint Lucia
sara35	nthompson@example.org	1960-09-23	0500-875-0754	Fazenda de Vasconcelos, 39, Santa Margarida, 50345450 Cavalcante do Norte / RN	Bulgaria
daniellesalas	paulgiles@example.org	1969-04-18	(081) 7123 8156	Lagoa Sabrina Nogueira, 26, Carmo, 82109-111 da Rocha do Norte / ES	Haiti
craig05	monteirojoao-pedro@example.com	1923-11-16	892.299.9300	Via de Cavalcante, 51, Castanheira, 20050-712 Cirino Alegre / AC	Indonesia
jacobmcconnell	morganrebecca@example.org	1942-07-19	(071) 4445 3227	86486 Patricia Light, Kellyborough, MP 56950	Seychelles
duncanjacob	jborges@example.org	1932-11-29	(084) 3454-0416	Pátio Aragão, 615, Laranjeiras, 54883-298 Macedo dos Dourados / RO	Bulgaria
lorena64	sharon50@example.com	1997-03-10	+55 (084) 6893-4745	Conjunto Vieira, 8, Barão Homem De Melo 2ª Seção, 64561005 Monteiro / MS	Andorra
jmichael	obrown@example.org	1964-08-12	0300-917-1218	Distrito Fonseca, 39, Conjunto Jardim Filadélfia, 77845-075 Cirino / PA	Somalia
kirbyjoseph	williammcneil@example.net	1942-06-01	+1-267-848-3304x213	237 Richard Pine Suite 515, Brittanyside, IN 36890	Turkmenistan
kristisanchez	umarks@example.org	1986-12-20	+55 71 1698-7405	Setor Luiz Fernando Rodrigues, 89, Cabana Do Pai Tomás, 60889-173 Jesus do Amparo / PI	Bosnia and Herzegovina
daniloazevedo	hcastro@example.net	1963-11-27	+55 (011) 7137 4976	395 Jennifer Viaduct, Simsmouth, DC 80982	Uzbekistan
maria-cecilia07	susan53@example.com	1966-09-21	001-385-924-2192x326	4718 Teresa Summit, Port William, TN 50003	Singapore
gda-rocha	gustavo-henrique63@example.com	2008-01-03	+55 11 0739-2630	722 Johnson Circle Apt. 160, North Jamesfurt, SC 44064	Turkey
da-pazana-cecilia	angela43@example.com	1998-03-13	0900 352 7682	USS Patterson, FPO AE 63794	Kazakhstan
ysilveira	maria-lauragarcia@example.net	1990-05-06	515-634-2688	Alameda de da Mata, 132, Jardim Felicidade, 47534-982 da Rocha / TO	Saint Helena, Ascension and Tristan da Cunha
maria-eduarda01	maria-lauranogueira@example.net	1950-06-29	61 4639 4654	Trecho Nunes, 322, Satelite, 71514058 Garcia de da Cunha / SC	Sweden
joanturner	diasjoao-pedro@example.org	1958-07-29	+55 11 4424 3217	Viaduto Barbosa, 9, São Gonçalo, 21076647 Pimenta / DF	Taiwan
lopezpatrick	urios@example.org	1936-01-28	3298179311	7104 Kane Bridge Suite 113, Kimberlyton, NH 22428	Ukraine
murilo15	lhenry@example.org	1985-12-13	61 6989 5434	Vale Ribeiro, 87, Ventosa, 28781-652 Aragão das Pedras / GO	Burundi
lais30	lblankenship@example.net	1955-04-08	+1-331-350-3214	Chácara Rezende, 9, Ermelinda, 54603642 Albuquerque Verde / CE	Falkland Islands
henry03	xwilliams@example.net	2013-03-31	(084) 1378 1493	Avenida Pedro Lucas Carvalho, 88, Conjunto Califórnia Ii, 36302174 Barros / MG	Cape Verde
nduarte	joanajesus@example.org	1962-09-11	(457)798-1212	Condomínio de Farias, 87, Miramar, 79742143 Aparecida / TO	Paraguay
labreu	mathiasaparecida@example.com	1943-06-25	+1-923-931-6859	2925 Foley River, Wrightmouth, CO 68001	Guinea
ewilliams	fonsecaesther@example.net	1987-02-15	+55 (031) 9046-3420	309 Khan Plaza Apt. 757, Kennethfort, MT 45868	India
jasonevans	albuquerquejoao-lucas@example.net	1960-07-31	+1-456-786-6879x6433	31427 Angela Junctions, Emilyhaven, OH 94856	Ukraine
josue67	maria-sophiapimenta@example.org	1967-05-18	001-891-271-8510x11372	5215 Luis Hills, West Danielle, WV 10999	Vietnam
bellaribeiro	iribeiro@example.com	2000-03-27	(081) 7763-5052	Aeroporto Moreira, 86, Xangri-Lá, 52070717 Fogaça das Flores / MA	Taiwan
mayasousa	andreleao@example.net	1962-10-18	0800 034 5194	6573 Rebecca Rapids, New Debbiemouth, MO 18913	Singapore
maria-fernanda05	hortonalexa@example.net	1979-07-28	(011) 5315 1914	Viela de da Cunha, 8, Vila Novo São Lucas, 04185790 Melo do Norte / RR	Gambia
jsales	tshah@example.net	1944-06-07	+1-596-448-1004	0227 Joshua Wells, West Frederickton, VI 99214	India
iteixeira	isabel44@example.org	2002-11-24	245-211-4819x32058	Trevo Sá, Tirol, 05084181 Rezende de Silveira / PB	Chile
zimmermankevin	aviladawn@example.org	1936-05-08	001-817-962-2481	Viaduto de Dias, 60, Vila São Dimas, 24512901 Cavalcanti / AP	South Korea
nmoraes	carvalhodavi@example.com	1986-05-20	953.834.4252	Passarela de Casa Grande, 63, Vila Pilar, 28545354 Sousa Paulista / AM	Burundi
smithsarah	ifreitas@example.com	1967-09-06	(563)663-7424x398	73062 Nicole Key, Cassandrafort, AS 88716	Singapore
lopezcrystal	dda-costa@example.com	1954-09-27	319-836-0500	Parque Nascimento, 93, Vila São Paulo, 99882842 Jesus / MT	Tanzania
xellison	oaparecida@example.org	1911-01-06	001-218-919-6260x32848	000 Harrington Heights Suite 771, New Mariechester, SD 37434	Tanzania
pedro-lucasmachado	wusuzanne@example.org	1994-05-17	+55 31 4942 6313	Vereda Cavalcante, 18, Carlos Prates, 77452-234 Sá / SC	Japan
tracy86	jacobpearson@example.com	2013-04-08	+55 84 4202 9085	29026 Ortiz Ways, Dixonbury, IA 68127	Comoros
cda-rocha	lunnasilveira@example.net	1937-08-11	369.965.7188x76972	Unit 9138 Box 1605, DPO AA 22032	Brunei
richardclark	lynn15@example.org	1949-12-26	(402)668-9963	Passarela de Borges, 78, Minaslandia, 25821-082 da Paz / RS	Sri Lanka
xmendes	melissa47@example.org	1951-11-13	502-986-7966x09970	7251 Diana Forest, New Williamstad, AS 77573	Jamaica
ottoribeiro	mooredanielle@example.org	1924-01-07	001-290-347-1609	Alameda Caleb Vasconcelos, 99, Nova Floresta, 19231-486 Fonseca do Campo / AL	Palestine
atkinstyler	schmidtgreg@example.org	1982-03-22	381-821-2661	Quadra de Costela, Laranjeiras, 72515808 Guerra de Goiás / AL	Turkmenistan
ocavalcante	isismacedo@example.org	1995-03-25	+55 (031) 0559 7744	Sítio Ana Júlia Gomes, Inconfidência, 28329873 Leão / SP	Vanuatu
ana-liviabarros	frenchsusan@example.org	1970-04-02	785-444-0296x8145	224 Tim Turnpike Suite 689, Smithhaven, MT 61683	Thailand
goldenlauren	da-pazantonio@example.org	2000-11-13	7865572030	Passarela de Pinto, 7, Vila Esplanada, 16412-388 da Mata de da Rocha / TO	Western Sahara
esa	juliehensley@example.net	1941-01-13	794-339-8420	PSC 4557, Box 3598, APO AA 36000	Jamaica
gfogaca	yan74@example.com	1993-09-10	(084) 8288-1756	Vale Correia, 91, Chácara Leonina, 79956218 Fogaça Alegre / AC	Gambia
novaescarlos-eduardo	robertsryan@example.com	2002-12-12	+1-391-300-9211x2739	61176 Tracy Spurs, Rodriguezland, FL 49176	Thailand
pclark	xmay@example.org	1910-11-01	4506746415	1975 Young Estates, Piercehaven, GA 50919	Brunei
smendez	ubrown@example.org	2006-09-10	+1-334-704-4139x6126	29461 Elliott Prairie, West Alexandraview, CT 64021	Macau
brownmark	cavalcantileticia@example.org	2005-06-28	+55 84 2013-1892	Vale Enzo Monteiro, 69, Maria Goretti, 27158067 Jesus / RN	Palestine
rodriguesisaac	gael-henrique84@example.org	2000-02-29	+1-869-393-2346x361	Condomínio Mathias da Costa, 84, Marieta 2ª Seção, 92231-331 Sá / PE	Ukraine
felipe12	padilladaniel@example.org	1964-06-22	+55 21 3029 7890	2589 Elaine Lights Suite 601, Port Adam, NE 14904	Mauritius
aylamacedo	sabrina38@example.com	1990-03-25	370-337-2660	1502 Ellison Lane Suite 524, Amberville, GU 83823	Botswana
albertjones	kpires@example.com	1958-04-06	(601)582-8149x174	Loteamento Luna Fernandes, 644, Castelo, 62648-412 Azevedo / PR	Zambia
julie29	wbarnett@example.org	1985-10-21	8039211801	443 Phillip Expressway, Lewisbury, MN 09552	Cape Verde
bellaborges	xmartins@example.org	1922-05-17	+1-612-589-6355x02913	6503 White Mews, Murrayport, IN 19415	Ivory Coast
jonathonhernandez	amanda96@example.org	2008-09-08	+55 71 2208-8882	5812 Devin Springs Apt. 860, Hallbury, VT 95944	Kazakhstan
eric07	maria-helena99@example.net	1999-11-12	(584)295-4483	Residencial de Pinto, 37, Nossa Senhora Da Conceição, 30385183 Silva Verde / CE	Iceland
\.


--
-- TOC entry 5282 (class 0 OID 16636)
-- Dependencies: 267
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.video (nro_plataforma, nome_canal, titulo, datah, tema, duracao_segs, visu_simul, visu_total) FROM stdin;
\.


--
-- TOC entry 5330 (class 0 OID 0)
-- Dependencies: 220
-- Name: bitcoin_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_nro_plataforma_seq', 1, false);


--
-- TOC entry 5331 (class 0 OID 0)
-- Dependencies: 221
-- Name: bitcoin_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_seq_comentario_seq', 1, false);


--
-- TOC entry 5332 (class 0 OID 0)
-- Dependencies: 222
-- Name: bitcoin_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitcoin_seq_doacao_seq', 1, false);


--
-- TOC entry 5333 (class 0 OID 0)
-- Dependencies: 224
-- Name: canal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.canal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5334 (class 0 OID 0)
-- Dependencies: 226
-- Name: cartao_credito_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_nro_plataforma_seq', 1, false);


--
-- TOC entry 5335 (class 0 OID 0)
-- Dependencies: 227
-- Name: cartao_credito_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_seq_comentario_seq', 1, false);


--
-- TOC entry 5336 (class 0 OID 0)
-- Dependencies: 228
-- Name: cartao_credito_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartao_credito_seq_doacao_seq', 1, false);


--
-- TOC entry 5337 (class 0 OID 0)
-- Dependencies: 230
-- Name: comentario_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_nro_plataforma_seq', 1, false);


--
-- TOC entry 5338 (class 0 OID 0)
-- Dependencies: 231
-- Name: comentario_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentario_seq_seq', 1, false);


--
-- TOC entry 5339 (class 0 OID 0)
-- Dependencies: 234
-- Name: doacao_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_nro_plataforma_seq', 1, false);


--
-- TOC entry 5340 (class 0 OID 0)
-- Dependencies: 235
-- Name: doacao_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_seq_comentario_seq', 1, false);


--
-- TOC entry 5341 (class 0 OID 0)
-- Dependencies: 236
-- Name: doacao_seq_pg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doacao_seq_pg_seq', 1, false);


--
-- TOC entry 5342 (class 0 OID 0)
-- Dependencies: 270
-- Name: empresa_nro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_nro_seq', 1, false);


--
-- TOC entry 5343 (class 0 OID 0)
-- Dependencies: 238
-- Name: empresa_pais_nro_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_pais_nro_empresa_seq', 1, false);


--
-- TOC entry 5344 (class 0 OID 0)
-- Dependencies: 240
-- Name: inscricao_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inscricao_nro_plataforma_seq', 1, false);


--
-- TOC entry 5345 (class 0 OID 0)
-- Dependencies: 242
-- Name: mecanismo_plat_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_nro_plataforma_seq', 1, false);


--
-- TOC entry 5346 (class 0 OID 0)
-- Dependencies: 243
-- Name: mecanismo_plat_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_comentario_seq', 1, false);


--
-- TOC entry 5347 (class 0 OID 0)
-- Dependencies: 244
-- Name: mecanismo_plat_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_doacao_seq', 1, false);


--
-- TOC entry 5348 (class 0 OID 0)
-- Dependencies: 245
-- Name: mecanismo_plat_seq_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mecanismo_plat_seq_seq', 1, false);


--
-- TOC entry 5349 (class 0 OID 0)
-- Dependencies: 247
-- Name: nivel_canal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nivel_canal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5350 (class 0 OID 0)
-- Dependencies: 250
-- Name: participa_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participa_nro_plataforma_seq', 1, false);


--
-- TOC entry 5351 (class 0 OID 0)
-- Dependencies: 252
-- Name: patrocinio_nro_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patrocinio_nro_empresa_seq', 1, false);


--
-- TOC entry 5352 (class 0 OID 0)
-- Dependencies: 253
-- Name: patrocinio_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patrocinio_nro_plataforma_seq', 1, false);


--
-- TOC entry 5353 (class 0 OID 0)
-- Dependencies: 255
-- Name: paypal_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_nro_plataforma_seq', 1, false);


--
-- TOC entry 5354 (class 0 OID 0)
-- Dependencies: 256
-- Name: paypal_seq_comentario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_seq_comentario_seq', 1, false);


--
-- TOC entry 5355 (class 0 OID 0)
-- Dependencies: 257
-- Name: paypal_seq_doacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paypal_seq_doacao_seq', 1, false);


--
-- TOC entry 5356 (class 0 OID 0)
-- Dependencies: 259
-- Name: plataforma_empresa_fund_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_empresa_fund_seq', 1, false);


--
-- TOC entry 5357 (class 0 OID 0)
-- Dependencies: 260
-- Name: plataforma_empresa_respo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_empresa_respo_seq', 1, false);


--
-- TOC entry 5358 (class 0 OID 0)
-- Dependencies: 261
-- Name: plataforma_nro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_nro_seq', 1, false);


--
-- TOC entry 5359 (class 0 OID 0)
-- Dependencies: 263
-- Name: plataforma_usuario_nro_plataforma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_usuario_nro_plataforma_seq', 1, false);


--
-- TOC entry 5360 (class 0 OID 0)
-- Dependencies: 264
-- Name: plataforma_usuario_nro_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.plataforma_usuario_nro_usuario_seq', 1, false);


--
-- TOC entry 5361 (class 0 OID 0)
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
    ADD CONSTRAINT streamer_pais_pkey PRIMARY KEY (nick_streamer, pais_passaporte);


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
    ADD CONSTRAINT fk_streamerpais_pais FOREIGN KEY (pais_passaporte) REFERENCES public.pais(nome) ON UPDATE CASCADE ON DELETE CASCADE;


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


-- Completed on 2025-10-30 04:26:03

--
-- PostgreSQL database dump complete
--

\unrestrict 5FVC26ZkiKeIWrA2Ff5V5oqfpFmQnr4TxhEq5nqFkepIB36CK9gDboCWlKHGcT8

