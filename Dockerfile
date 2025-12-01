FROM python:3.12-slim

WORKDIR /app

# Instala o uv
RUN pip install uv

# Copia apenas os arquivos de dependência primeiro
COPY pyproject.toml uv.lock .python-version ./

# Cria o ambiente e instala dependências
RUN uv sync --frozen

# Copia o restante do projeto
COPY . .

# Mantém o container ativo (para rodar comandos manualmente depois)
CMD ["tail", "-f", "/dev/null"]