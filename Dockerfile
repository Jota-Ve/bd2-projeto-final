FROM python:3.12-slim

# Define diretório de trabalho dentro do container
WORKDIR /app

# Copia todo o projeto para dentro do container
COPY . /app

# Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Mantém o container ativo (para rodar comandos manualmente depois)
CMD ["tail", "-f", "/dev/null"]