# Etapa 1: Escolher a imagem base
# Usamos uma imagem oficial do Python. A versão 'slim' é mais leve,
# o que resulta em uma imagem final menor.
FROM python:3.10-slim

# Etapa 2: Definir o diretório de trabalho
# Isso garante que os comandos subsequentes sejam executados neste diretório.
WORKDIR /app

# Etapa 3: Copiar e instalar as dependências
# Copiamos o requirements.txt primeiro para aproveitar o cache de camadas do Docker.
# Se este arquivo não mudar, o Docker não precisará reinstalar as dependências
# em builds futuros.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação
COPY . .

# Etapa 5: Expor a porta
# Informa ao Docker que o contêiner escutará na porta 8000 em tempo de execução.
EXPOSE 8000

# Etapa 6: Comando para iniciar a aplicação
# Executa o Uvicorn. O host 0.0.0.0 é necessário para que a aplicação
# seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]