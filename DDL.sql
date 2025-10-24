### DDL PostgreSQL para o modelo relacional

-- Observações: atributos derivados estão marcados como comentários; use processos externos para atualizar qtd_users e qtd_visualizacoes.

CREATE TABLE empresa (
  nro          INTEGER PRIMARY KEY,
  nome         TEXT NOT NULL,
  nome_fantasia TEXT
);

CREATE TABLE conversao (
  moeda       TEXT PRIMARY KEY,
  nome        TEXT NOT NULL,
  fator_conver NUMERIC(18,8) NOT NULL
);

CREATE TABLE pais (
  ddi   TEXT PRIMARY KEY,
  nome  TEXT NOT NULL,
  moeda TEXT NOT NULL,
  CONSTRAINT fk_pais_moeda FOREIGN KEY (moeda) REFERENCES conversao(moeda)
);

CREATE TABLE plataforma (
  nro             INTEGER PRIMARY KEY,
  nome            TEXT NOT NULL,
  qtd_users       INTEGER, -- derivado: atualizar periodicamente
  empresa_fund    INTEGER NOT NULL,
  empresa_respo   INTEGER,
  data_fund       DATE,
  CONSTRAINT fk_plataforma_empresa_fund FOREIGN KEY (empresa_fund) REFERENCES empresa(nro),
  CONSTRAINT fk_plataforma_empresa_respo FOREIGN KEY (empresa_respo) REFERENCES empresa(nro)
);

CREATE TABLE usuario (
  nick            TEXT PRIMARY KEY,
  email           TEXT UNIQUE NOT NULL,
  data_nasc       DATE,
  telefone        TEXT,
  end_postal      TEXT,
  pais_residencia TEXT,
  CONSTRAINT fk_usuario_pais FOREIGN KEY (pais_residencia) REFERENCES pais(ddi)
);

CREATE TABLE plataforma_usuario (
  nro_plataforma  INTEGER NOT NULL,
  nick_usuario    TEXT NOT NULL,
  nro_usuario     INTEGER, -- campo do modelo original; mantido conforme enunciado (pode ser id local se desejar)
  PRIMARY KEY (nro_plataforma, nick_usuario),
  CONSTRAINT fk_plataforma_usuario_plataforma FOREIGN KEY (nro_plataforma) REFERENCES plataforma(nro),
  CONSTRAINT fk_plataforma_usuario_usuario FOREIGN KEY (nick_usuario) REFERENCES usuario(nick)
);

CREATE TABLE streamer_pais (
  nick_streamer   TEXT NOT NULL,
  ddi_pais        TEXT NOT NULL,
  nro_passaporte  TEXT,
  PRIMARY KEY (nick_streamer, ddi_pais),
  CONSTRAINT fk_streamerpais_usuario FOREIGN KEY (nick_streamer) REFERENCES usuario(nick),
  CONSTRAINT fk_streamerpais_pais FOREIGN KEY (ddi_pais) REFERENCES pais(ddi)
);

CREATE TABLE empresa_pais (
  nro_empresa INTEGER NOT NULL,
  ddi_pais    TEXT NOT NULL,
  id_nacional TEXT,
  PRIMARY KEY (nro_empresa, ddi_pais),
  CONSTRAINT fk_empresapais_empresa FOREIGN KEY (nro_empresa) REFERENCES empresa(nro),
  CONSTRAINT fk_empresapais_pais FOREIGN KEY (ddi_pais) REFERENCES pais(ddi)
);

CREATE TABLE canal (
  nome               TEXT NOT NULL,
  tipo               TEXT,
  data               DATE,
  descricao          TEXT,
  qtd_visualizacoes  BIGINT, -- derivado: atualizar periodicamente
  nick_streamer      TEXT NOT NULL,
  nro_plataforma     INTEGER NOT NULL,
  PRIMARY KEY (nome, nro_plataforma),
  CONSTRAINT fk_canal_plataforma FOREIGN KEY (nro_plataforma) REFERENCES plataforma(nro),
  CONSTRAINT fk_canal_streamer FOREIGN KEY (nick_streamer) REFERENCES usuario(nick)
);

CREATE TABLE patrocinio (
  nro_empresa     INTEGER NOT NULL,
  nome_canal      TEXT NOT NULL,
  nro_plataforma  INTEGER NOT NULL,
  valor           NUMERIC(18,2) NOT NULL,
  PRIMARY KEY (nro_empresa, nome_canal, nro_plataforma),
  CONSTRAINT fk_patrocinio_empresa FOREIGN KEY (nro_empresa) REFERENCES empresa(nro),
  CONSTRAINT fk_patrocinio_canal FOREIGN KEY (nome_canal, nro_plataforma) REFERENCES canal(nome, nro_plataforma)
);

CREATE TABLE nivel_canal (
  nome_canal      TEXT NOT NULL,
  nro_plataforma  INTEGER NOT NULL,
  nivel           TEXT NOT NULL,
  valor           NUMERIC(18,2),
  gif             TEXT,
  PRIMARY KEY (nome_canal, nro_plataforma, nivel),
  CONSTRAINT fk_nivel_canal FOREIGN KEY (nome_canal, nro_plataforma) REFERENCES canal(nome, nro_plataforma)
);

CREATE TABLE inscricao (
  nome_canal      TEXT NOT NULL,
  nro_plataforma  INTEGER NOT NULL,
  nick_membro     TEXT NOT NULL,
  nivel           TEXT NOT NULL,
  data_inscricao  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (nome_canal, nro_plataforma, nick_membro, nivel),
  CONSTRAINT fk_inscricao_membro FOREIGN KEY (nick_membro) REFERENCES usuario(nick),
  CONSTRAINT fk_inscricao_nivel FOREIGN KEY (nome_canal, nro_plataforma, nivel) REFERENCES nivel_canal(nome_canal, nro_plataforma, nivel)
);

CREATE TABLE video (
  nome_canal      TEXT NOT NULL,
  nro_plataforma  INTEGER NOT NULL,
  titulo          TEXT NOT NULL,
  datah           TIMESTAMP NOT NULL,
  tema            TEXT,
  duracao         INTERVAL,
  visu_simul      BIGINT,
  visu_total      BIGINT,
  PRIMARY KEY (nome_canal, nro_plataforma, titulo, datah),
  CONSTRAINT fk_video_canal FOREIGN KEY (nome_canal, nro_plataforma) REFERENCES canal(nome, nro_plataforma)
);

CREATE TABLE participa (
  nome_canal      TEXT NOT NULL,
  nro_plataforma  INTEGER NOT NULL,
  titulo_video    TEXT NOT NULL,
  datah_video     TIMESTAMP NOT NULL,
  nick_streamer   TEXT NOT NULL,
  PRIMARY KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_streamer),
  CONSTRAINT fk_participa_video FOREIGN KEY (nome_canal, nro_plataforma, titulo_video, datah_video)
    REFERENCES video(nome_canal, nro_plataforma, titulo, datah),
  CONSTRAINT fk_participa_streamer FOREIGN KEY (nick_streamer) REFERENCES usuario(nick)
);

CREATE TABLE comentario (
  nome_canal      TEXT NOT NULL,
  nro_plataforma  INTEGER NOT NULL,
  titulo_video    TEXT NOT NULL,
  datah_video     TIMESTAMP NOT NULL,
  nick_usuario    TEXT NOT NULL,
  seq             INTEGER NOT NULL,
  texto           TEXT NOT NULL,
  datah           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  coment_on       TEXT, -- pode referenciar seq de outro comentário; manter como texto/JSON conforme necessidade
  PRIMARY KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq),
  CONSTRAINT fk_comentario_video FOREIGN KEY (nome_canal, nro_plataforma, titulo_video, datah_video)
    REFERENCES video(nome_canal, nro_plataforma, titulo, datah),
  CONSTRAINT fk_comentario_usuario FOREIGN KEY (nick_usuario) REFERENCES usuario(nick)
);

CREATE TABLE doacao (
  nome_canal       TEXT NOT NULL,
  nro_plataforma   INTEGER NOT NULL,
  titulo_video     TEXT NOT NULL,
  datah_video      TIMESTAMP NOT NULL,
  nick_usuario     TEXT NOT NULL,
  seq_comentario   INTEGER NOT NULL,
  seq_pg           INTEGER NOT NULL,
  valor            NUMERIC(18,2) NOT NULL,
  status           TEXT,
  PRIMARY KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg),
  CONSTRAINT fk_doacao_comentario FOREIGN KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario)
    REFERENCES comentario(nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq),
  CONSTRAINT fk_doacao_usuario FOREIGN KEY (nick_usuario) REFERENCES usuario(nick)
);

CREATE TABLE bitcoin (
  nome_canal       TEXT NOT NULL,
  nro_plataforma   INTEGER NOT NULL,
  titulo_video     TEXT NOT NULL,
  datah_video      TIMESTAMP NOT NULL,
  nick_usuario     TEXT NOT NULL,
  seq_comentario   INTEGER NOT NULL,
  seq_doacao       INTEGER NOT NULL,
  txid             TEXT NOT NULL,
  PRIMARY KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao),
  CONSTRAINT fk_bitcoin_doacao FOREIGN KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao)
    REFERENCES doacao(nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg)
);

CREATE TABLE paypal (
  nome_canal       TEXT NOT NULL,
  nro_plataforma   INTEGER NOT NULL,
  titulo_video     TEXT NOT NULL,
  datah_video      TIMESTAMP NOT NULL,
  nick_usuario     TEXT NOT NULL,
  seq_comentario   INTEGER NOT NULL,
  seq_doacao       INTEGER NOT NULL,
  idpaypal         TEXT NOT NULL,
  PRIMARY KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao),
  CONSTRAINT fk_paypal_doacao FOREIGN KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao)
    REFERENCES doacao(nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg)
);

CREATE TABLE cartao_credito (
  nome_canal       TEXT NOT NULL,
  nro_plataforma   INTEGER NOT NULL,
  titulo_video     TEXT NOT NULL,
  datah_video      TIMESTAMP NOT NULL,
  nick_usuario     TEXT NOT NULL,
  seq_comentario   INTEGER NOT NULL,
  seq_doacao       INTEGER NOT NULL,
  nro_cartao       TEXT NOT NULL,
  bandeira         TEXT,
  PRIMARY KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao),
  CONSTRAINT fk_cartao_doacao FOREIGN KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao)
    REFERENCES doacao(nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg)
);

CREATE TABLE mecanismo_plat (
  nome_canal       TEXT NOT NULL,
  nro_plataforma   INTEGER NOT NULL,
  titulo_video     TEXT NOT NULL,
  datah_video      TIMESTAMP NOT NULL,
  nick_usuario     TEXT NOT NULL,
  seq_comentario   INTEGER NOT NULL,
  seq_doacao       INTEGER NOT NULL,
  seq_plataforma   INTEGER NOT NULL,
  PRIMARY KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao, seq_plataforma),
  CONSTRAINT fk_mecanismo_doacao FOREIGN KEY (nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_doacao)
    REFERENCES doacao(nome_canal, nro_plataforma, titulo_video, datah_video, nick_usuario, seq_comentario, seq_pg)
);

-- Comentários adicionais
COMMENT ON COLUMN plataforma.qtd_users IS 'Derivado: manter via batch/trigger/ETL';
COMMENT ON COLUMN canal.qtd_visualizacoes IS 'Derivado: manter via batch/trigger/ETL';

--- Fim do DDL ---
