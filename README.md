# Pré-requisito

- Devido a limitação do envio pelo Gmail, é **necessário executar o seguinte script** na raiz do projeto

```bash
python trocar_extensao_executavel.py
````

---
---

# Guia de Execução do Projeto

Este guia descreve como configurar o ambiente, iniciar o banco de dados e executar os scripts do projeto.
Você pode rodar o projeto de duas formas:

- 🐧 **Com Docker no Linux** (Linux/WSL/Git Bash)
- 🪟 **Com Docker no Windows** (Precisa ter Git instalado)


Ou renomear manualmente os arquivos dentro da pasta scripts/
de 01-easy-run-sh para 01-easy-run.sh ou 01-easy-run-bat para 01-easy-run.bat

## 🐧 Opção 1: Executando com Docker no Linux

O projeto utiliza PostgreSQL e Python rodando em containers Docker.

### 1.0 🙂 Easy Run - Prepara o ambiente com 1 comando

Forma mais fácil e direta de executar.

- Limpa containers e dados de execuções prévias (se existirem).
- Sobe containers.
- Carrega os dados.
- Deixa o ambiente pronto para execução das queries.

```Bash
bash ./scripts/linux/0-easy-run.sh
```

⏭️ **Pule para a etapa de executar queries.**

---

### 1.1 🚀 Run - Inicia os containers do Postgres e Python com Docker

- Baixa as imagens do banco PostgresSQL e Python.
- Sobe os containers em segundo plano.

```bash
bash scripts/linux/1-run-containers.sh
```

### 1.2 🐍🏦🎲 Load Data - Executa o Python e insere no Banco de Dados

- Executa o script Python com Faker para gerar dados fictícios.
- Cria o schema, tabelas, views, functions, triggers e índices.
- As tabelas serão deletadas do schema antes da inserção de novos dados.

```bash
bash scripts/linux/2-load-data.sh --scale 0.1
```

- O argumento `--scale` é *opcional* e controla a proporção de dados gerados para o banco.
- *Recomendamos* testar inicialmente com `--scale 0.1`
- **Para avaliação do trabalho**, não passe este argumento ou utilize `--scale 1.0`.

### 1.3 📊 Run Queries - Executa pequena amostragem das queries

- Executa as 8 queries no Banco de Dados.
- Quantidade de linhas reduzidas para não poluir o terminal.

```bash
bash scripts/linux/3-run-queries.sh
```

### 1.4 🗑️🚮 Clean Containers - Deleta todos os artefatos da execução no docker

- Para containers e deleta containers.
- Deleta imagens.
- Deleta volumes de dados.

```bash
bash scripts/linux/4-clean-containers.sh
```

---
---

## 🪟 Opção 2: Executando com Docker no Windows

- **Necessário ter Git Bash instalado.**
- Possui as mesmas regras da execução em Linux.
- Execute no `Prompt` ou `Powershell`.

### 2.0 🙂 Easy Run

```Cmd
.\scripts\windows\0-easy-run.bat
```

### 2.1 🚀 Run

```Cmd
.\scripts\windows\1-run-containers.bat
```

### 1.2 🐍🏦🎲 Load Data

```Cmd
.\scripts\windows\2-load-data.bat --scale 0.1
```

### 2.3 📊 Run Queries

```Cmd
.\scripts\windows\3-run-queries
```

### 1.4 🗑️🚮 Clean Containers

```Cmd
.\scripts\windows\4-clean-containers
```

---
---

## ℹ️ Observação

- O banco estará acessível em `localhost` com:
  - Usuário: `postgres`
  - Senha  : `sofisticada`
  - Banco  : `streamers`
  - Porta  : `54320`

### Repositório: [https://github.com/Jota-Ve/bd2-projeto-final](https://github.com/Jota-Ve/bd2-projeto-final)

---
