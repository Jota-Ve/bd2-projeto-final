# Guia de Execução do Projeto

Este guia descreve como configurar o ambiente, iniciar o banco de dados e executar os scripts do projeto.
Você pode rodar o projeto de duas formas:

- **Com Docker** (isolamento total, sem precisar instalar Python/Postgres localmente)
- **Sem Docker** (usando Python e Postgres instalados na sua máquina/WSL)

## 🚀 Opção 1: Executando com Docker

O projeto utiliza PostgreSQL e Python rodando em containers Docker.

### 1. 🔨 Build - Construir a imagem do app e do ambiente

- Esse script roda docker compose build e recompila a imagem.
- Só precisa rodar 1x (ou quando você altera o Dockerfile, pyproject.toml ou uv.lock).

```bash
bash ./scripts/build.sh
```

### 2. 🚀 Run - Iniciar o banco de dados e o Python com Docker

Inicia o banco e app em segundo plano e cria o schema, tabelas, views...

```bash
bash scripts/run.sh
```

## 💻 Opção 2: Executando Localmente (sem Docker)

Se preferir rodar sem Docker, você precisa ter Python 3 e PostgreSQL 15 instalados.

### 1. Configuração do Ambiente Virtual Python

```bash
# Cria o ambiente virtual (se ainda não existir)
python3 -m venv .venv

# Ativa o ambiente virtual
# No Linux/Mac:
source .venv/bin/activate
# No Windows:
.venv\Scripts\activate

# Instala as dependências
pip install -r requirements.txt
```

### 2. Cria o Schema, Tabelas, Views e Funções

```bash
psql "postgresql://postgres:sofisticada@localhost:5432/streamers" \
  -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

psql "postgresql://postgres:sofisticada@localhost:5432/streamers" \
  -f sql/DDL-streamers.sql
```

### 3. Gerar e Inserir Dados Fictícios

```bash
# Certifique-se de que o venv está ativo
python -m src.main
```

### 4. Criar Views e Funções Otimizadas

```bash
psql "postgresql://postgres:sofisticada@localhost:5432/streamers" \
  -f sql/queries_otimizadas.sql
```

---

## ℹ️ Observação

- No modo **Docker**, não é necessário criar ambiente virtual Python.
- No modo **Local**, recomendamos usar venv para isolar dependências.
- O banco estará acessível em `localhost:5432` com:
  - Usuário: postgres
  - Senha: sofisticada
  - Banco: streamers

---

## Modelo Relacional

- **Empresa**(<u>nro</u>, nome, nome_fantasia)

<br>

- **Plataforma**(<u>nro</u>, nome, qtd_users, empresa_fund, empresa_respo, data_fund)
  - _-- Quantidade de usuários **qtd_users** é atributo derivado e **requer atualização periódica**._
  - _empresa_fund **referencia Empresa**(nro)_
  - _empresa_respo **referencia Empresa**(nro)_

<br>

- **Conversao**(<u>moeda</u>, nome, fator_conver)
  - _-- fator_conver é o fator de conversão para dólar_

<br>

- **Pais**(<u>nome</u>, DDI, moeda)
  - _moeda **referencia Conversao**(moeda)_

<br>

- **Usuario**(<u>nick</u>, email, data_nasc, telefone, end_postal, pais_residencia)
  - _pais_residencia **referencia Pais**(nome)_

<br>

- **PlataformaUsuario**(<u>nro_plataforma, nick_usuario</u>, nro_usuario)
  - _nro_plataforma **referencia Plataforma**(nro)_
  - _nick_usuario **referencia Usuario**(nick)_

<br>

- **StreamerPais**(<u>nick_streamer, nome_pais</u>, nro_passaporte)
  - _nick_streamer **referencia Usuario**(nick)_
  - _nome_pais **referencia Pais**(nome)_

<br>

- **EmpresaPais**(<u>nro_empresa, nome_pais</u>, id_nacional)
  - _nro_empresa **referencia Empresa**(nro)_
  - _nome_pais **referencia Pais**(nome)_

<br>

- **Canal**(<u>nome</u>, tipo, data, desc, qtd_visualizacoes, nick_streamer, nro_plataforma)
  - -- Quantidade de visualizações **qtd_visualizações** é atributo derivado e **requer atualização**
  - _nro_plataforma **referencia Plataforma**(nro)_
  - _nick_streamer **referencia Usuario**(nick)_

<br>

- **Patrocionio**(<u>nro_empresa, nome_canal, nro_plataforma</u>, valor)
  - _nro_empresa **referencia Empresa**(nro)_
  - _nome_canal, nro_plataforma **referencia Canal**(nome, nro_plataforma)_

<br>

- **NivelCanal**(<u>nome_canal, nro_plataforma, nivel</u>, valor, gif)
  - _nome_canal, nro_plataforma **referencia Canal**(nome, nro_plataforma)_

<br>

- **Inscrição**(<u>nome_canal, nro_plataforma, nick_membro</u>, nivel)
  - _nick_membro refrencia **Usuario**(nick)_
  - _(nome_canal, nro_plataforma, nivel) referencia NivelCanal(nome_canal, nro_plataforma, nivel)_

<br>

- **Video**(<u>nome_canal, nro_plataforma, titulo, dataH</u>, tema, duracao, visu_simul, visu_total)
  - _-- Verificar a **possibilidade do uso de identificador artificial** (toda ou parte da chave)_
  - _(nome_canal, nro_plataforma) **referencia Canal**(nome, nro_plataforma)_

<br>

- **Participa**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_streamer</u>)
  - _(nome_canal, nro_plataforma, titulo_video, dataH_video) referencia Video(nome_canal, nro_plataforma, titulo_video, dataH_video)_
  - _nick_streamer **referencia Usuario**(nick)_

<br>

- **Comentario**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq</u>, texto, dataH, coment_on)
  - _(nome_canal, nro_plataforma, titulo_video, dataH_video) **referencia Video**(nome_canal, nro_plataforma, titulo, dataH)_
  - _nick_usuario **referencia Usuario**(nick)_

<br>

- **Doacao**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg, valor</u>, status)
  - _(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario)_
    - **referencia Comentario**(nome_canal, nro_plataforma, titulo_vide dataH_video, nick_usuario, seq)\*

<br>

- **BitCoin**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao</u>, TxID)
  - _(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao)_
    - **referencia Doacao**(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)\*

<br>

- **PayPal**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao</u>, IdPayPal)
  - _(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao)_
    - **referencia Doacao**(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)\*

<br>

- **CartaoCredito**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao</u>, nro, bandeira)
  - _(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao)_
    - **referencia Doacao**(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)\*

<br>

- **MecanismoPlat**(<u>nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao</u>, seq_plataforma)
  - _(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_doacao)_
    - **referencia Doacao**(nome_canal, nro_plataforma, titulo_video, dataH_video, nick_usuario, seq_comentario, seq_pg)\*
