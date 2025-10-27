-- DDL PostgreSQL para o modelo relacional

-- Observações: atributos derivados estão marcados como comentários; use processos externos para atualizar qtd_users e qtd_visualizacoes.

CREATE TABLE empresa (
  nro          SERIAL PRIMARY KEY,
  nome         TEXT NOT NULL,
  nome_fantasia TEXT
);

CREATE TABLE plataforma (
  nro             SERIAL PRIMARY KEY,
  nome            TEXT NOT NULL,
  qtd_users       INTEGER NOT NULL, -- derivado: atualizar periodicamente
  empresa_fund    SERIAL NOT NULL,
  empresa_respo   SERIAL NOT NULL,
  data_fund       DATE NOT NULL,
  CONSTRAINT fk_plataforma_empresa_fund FOREIGN KEY (empresa_fund) REFERENCES empresa(nro),
  CONSTRAINT fk_plataforma_empresa_respo FOREIGN KEY (empresa_respo) REFERENCES empresa(nro)
);

CREATE TABLE conversao (
  moeda       TEXT PRIMARY KEY,
  nome        TEXT NOT NULL,
  fator_conver NUMERIC(18,8) NOT NULL CHECK (fator_conver > 0) -- fator_conver é o fator de conversão para dólar
);

CREATE TABLE pais (
  ddi   SMALLINT PRIMARY KEY,
  nome  TEXT NOT NULL,
  moeda TEXT NOT NULL,
  CONSTRAINT fk_pais_moeda FOREIGN KEY (moeda) REFERENCES conversao(moeda)
);

CREATE TABLE usuario (
  nick            TEXT PRIMARY KEY,
  email           TEXT UNIQUE NOT NULL,
  data_nasc       DATE NOT NULL,
  telefone        TEXT NOT NULL,
  end_postal      TEXT NOT NULL,
  pais_residencia SMALLINT NOT NULL,
  CONSTRAINT fk_usuario_pais FOREIGN KEY (pais_residencia) REFERENCES pais(ddi)
);

CREATE TABLE plataforma_usuario (
  nro_plataforma  SERIAL NOT NULL,
  nick_usuario    TEXT NOT NULL,
  nro_usuario     SERIAL, -- campo do modelo original; mantido conforme enunciado (pode ser id local se desejar)
  PRIMARY KEY (nro_plataforma, nick_usuario),
  CONSTRAINT fk_plataforma_usuario_plataforma FOREIGN KEY (nro_plataforma) REFERENCES plataforma(nro),
  CONSTRAINT fk_plataforma_usuario_usuario FOREIGN KEY (nick_usuario) REFERENCES usuario(nick)
);

CREATE TABLE streamer_pais (
  nick_streamer   TEXT NOT NULL,
  ddi_pais        SMALLINT NOT NULL,
  nro_passaporte  VARCHAR(9) NOT NULL UNIQUE, -- padrão da OACI (ICAO) que define o número do passaporte como uma sequência de até 9 caracteres, que podem ser letras e/ou números.
  PRIMARY KEY (nick_streamer, ddi_pais),
  CONSTRAINT fk_streamerpais_usuario FOREIGN KEY (nick_streamer) REFERENCES usuario(nick),
  CONSTRAINT fk_streamerpais_pais FOREIGN KEY (ddi_pais) REFERENCES pais(ddi)
);

CREATE TABLE empresa_pais (
  nro_empresa SERIAL NOT NULL,
  ddi_pais    SMALLINT NOT NULL,
  id_nacional TEXT, -- EXEMPLO: CNPJ no Brasil, NIF em Portugal, etc.
  PRIMARY KEY (nro_empresa, ddi_pais),
  CONSTRAINT fk_empresapais_empresa FOREIGN KEY (nro_empresa) REFERENCES empresa(nro),
  CONSTRAINT fk_empresapais_pais FOREIGN KEY (ddi_pais) REFERENCES pais(ddi)
);

CREATE TYPE TIPOCANAL AS ENUM ('privado', 'público', 'misto');
CREATE TABLE canal (
  nro_plataforma     SERIAL NOT NULL,
  nome               TEXT NOT NULL,
  tipo               TIPOCANAL NOT NULL,
  data               DATE NOT NULL, -- data de criação do canal
  descricao          TEXT,
  qtd_visualizacoes  BIGINT, -- derivado: atualizar periodicamente
  nick_streamer      TEXT NOT NULL,
  PRIMARY KEY (nro_plataforma, nome),
  CONSTRAINT fk_canal_plataforma FOREIGN KEY (nro_plataforma) REFERENCES plataforma(nro),
  CONSTRAINT fk_canal_streamer FOREIGN KEY (nick_streamer) REFERENCES usuario(nick)
);

CREATE TABLE patrocinio (
  nro_empresa     SERIAL NOT NULL,
  nro_plataforma  SERIAL NOT NULL,
  nome_canal      TEXT NOT NULL,
  valor           NUMERIC(18,2) NOT NULL CHECK (valor > 0),
  PRIMARY KEY (nro_empresa, nro_plataforma, nome_canal),
  CONSTRAINT fk_patrocinio_empresa FOREIGN KEY (nro_empresa) REFERENCES empresa(nro),
  CONSTRAINT fk_patrocinio_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES canal(nro_plataforma, nome)
);

CREATE TABLE nivel_canal (
  nro_plataforma  SERIAL NOT NULL,
  nome_canal      TEXT NOT NULL,
  nivel           SMALLINT NOT NULL CHECK(nivel BETWEEN 1 AND 5),
  nome_nivel      TEXT NOT NULL,
  valor           NUMERIC(18,2) NOT NULL CHECK (valor > 0),
  gif             BYTEA ,
  PRIMARY KEY (nro_plataforma, nome_canal, nivel),
  CONSTRAINT fk_nivel_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES canal(nro_plataforma, nome)
);

CREATE TABLE inscricao (
  nro_plataforma  SERIAL NOT NULL,
  nome_canal      TEXT NOT NULL,
  nick_membro     TEXT NOT NULL,
  nivel           SMALLINT NOT NULL,
  PRIMARY KEY (nro_plataforma, nome_canal, nick_membro, nivel),
  CONSTRAINT fk_inscricao_membro FOREIGN KEY (nick_membro) REFERENCES usuario(nick),
  CONSTRAINT fk_inscricao_nivel FOREIGN KEY (nro_plataforma, nome_canal, nivel) REFERENCES nivel_canal(nro_plataforma, nome_canal, nivel)
);

-- Verificar a possibilidade do uso de identificador artificial (toda ou parte da chave) para vídeo
CREATE TABLE video (
  nro_plataforma  SERIAL NOT NULL,
  nome_canal      TEXT NOT NULL,
  titulo          TEXT NOT NULL,
  datah           TIMESTAMP NOT NULL,
  tema            TEXT NOT NULL,
  duracao_segs    INTEGER NOT NULL CHECK(duracao_segs > 0),
  visu_simul      INTEGER NOT NULL CHECK(visu_simul >= 0),
  visu_total      BIGINT NOT NULL CHECK(visu_total >= 0),
  PRIMARY KEY (nro_plataforma, nome_canal, titulo, datah),
  CONSTRAINT fk_video_canal FOREIGN KEY (nro_plataforma, nome_canal) REFERENCES canal(nro_plataforma, nome)
);

CREATE TABLE participa (
  nome_canal      TEXT NOT NULL,
  nro_plataforma  SERIAL NOT NULL,
  titulo_video    TEXT NOT NULL,
  datah_video     TIMESTAMP NOT NULL,
  nick_streamer   TEXT NOT NULL,
  PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_streamer),
  CONSTRAINT fk_participa_video FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video)
    REFERENCES video(nro_plataforma, nome_canal, titulo, datah),
  CONSTRAINT fk_participa_streamer FOREIGN KEY (nick_streamer) REFERENCES usuario(nick)
);

CREATE TABLE comentario (
  nome_canal      TEXT NOT NULL,
  nro_plataforma  SERIAL NOT NULL,
  titulo_video    TEXT NOT NULL,
  datah_video     TIMESTAMP NOT NULL,
  nick_usuario    TEXT NOT NULL,
  seq             SERIAL NOT NULL,
  texto           TEXT NOT NULL,
  datah           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  online          BOOLEAN NOT NULL,
  PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq),
  CONSTRAINT fk_comentario_video FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video)
    REFERENCES video(nro_plataforma, nome_canal, titulo, datah),
  CONSTRAINT fk_comentario_usuario FOREIGN KEY (nick_usuario) REFERENCES usuario(nick)
);

CREATE TYPE STATUSDOACAO AS ENUM('recusado', 'recebido', 'lido');
CREATE TABLE doacao (
  nome_canal       TEXT NOT NULL,
  nro_plataforma   SERIAL NOT NULL,
  titulo_video     TEXT NOT NULL,
  datah_video      TIMESTAMP NOT NULL,
  nick_usuario     TEXT NOT NULL,
  seq_comentario   SERIAL NOT NULL,
  seq_pg           SERIAL NOT NULL,
  valor            NUMERIC(18,2) NOT NULL CHECK(valor>0),
  status           STATUSDOACAO NOT NULL,
  PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg),
  CONSTRAINT fk_doacao_comentario FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario)
    REFERENCES comentario(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq),
  CONSTRAINT fk_doacao_usuario FOREIGN KEY (nick_usuario) REFERENCES usuario(nick)
);

CREATE TABLE bitcoin (
  nome_canal       TEXT NOT NULL,
  nro_plataforma   SERIAL NOT NULL,
  titulo_video     TEXT NOT NULL,
  datah_video      TIMESTAMP NOT NULL,
  nick_usuario     TEXT NOT NULL,
  seq_comentario   SERIAL NOT NULL,
  seq_doacao       SERIAL NOT NULL,
  txid             TEXT NOT NULL UNIQUE,
  PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao),
  CONSTRAINT fk_bitcoin_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao)
    REFERENCES doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg)
);

CREATE TABLE paypal (
  nome_canal       TEXT NOT NULL,
  nro_plataforma   SERIAL NOT NULL,
  titulo_video     TEXT NOT NULL,
  datah_video      TIMESTAMP NOT NULL,
  nick_usuario     TEXT NOT NULL,
  seq_comentario   SERIAL NOT NULL,
  seq_doacao       SERIAL NOT NULL,
  idpaypal         TEXT NOT NULL UNIQUE,
  PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao),
  CONSTRAINT fk_paypal_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao)
    REFERENCES doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg)
);

CREATE TABLE cartao_credito (
  nome_canal       TEXT NOT NULL,
  nro_plataforma   SERIAL NOT NULL,
  titulo_video     TEXT NOT NULL,
  datah_video      TIMESTAMP NOT NULL,
  nick_usuario     TEXT NOT NULL,
  seq_comentario   SERIAL NOT NULL,
  seq_doacao       SERIAL NOT NULL,
  nro_cartao       TEXT NOT NULL,
  bandeira         TEXT NOT NULL,
  PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao),
  CONSTRAINT fk_cartao_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao)
    REFERENCES doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg)
);

CREATE TABLE mecanismo_plat (
  nome_canal       TEXT NOT NULL,
  nro_plataforma   SERIAL NOT NULL,
  titulo_video     TEXT NOT NULL,
  datah_video      TIMESTAMP NOT NULL,
  nick_usuario     TEXT NOT NULL,
  seq_comentario   SERIAL NOT NULL,
  seq_doacao       SERIAL NOT NULL,
  seq              SERIAL NOT NULL,
  PRIMARY KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, seq),
  CONSTRAINT fk_mecanismo_doacao FOREIGN KEY (nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao)
    REFERENCES doacao(nro_plataforma, nome_canal, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg)
);

-- Comentários adicionais
COMMENT ON COLUMN plataforma.qtd_users IS 'Derivado: manter via batch/trigger/ETL';
COMMENT ON COLUMN canal.qtd_visualizacoes IS 'Derivado: manter via batch/trigger/ETL';

--- Fim do DDL ---
