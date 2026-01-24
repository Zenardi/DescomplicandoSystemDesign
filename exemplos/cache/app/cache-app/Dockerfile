# Dockerfile
FROM golang:1.23-alpine

# Instala dependências úteis
RUN apk add --no-cache bash git gcc musl-dev

WORKDIR /app

# Copia go.mod para pré-aquecer cache de dependências
COPY go.mod go.sum ./
RUN go mod download

# Instala o Air para hot reload
RUN go install github.com/air-verse/air@latest

# Copia todo o código (vai ser sobrescrito pelo volume no docker-compose)
COPY . .

# Expõe a porta padrão
EXPOSE 8080

# Comando padrão (Air vai rodar e ficar monitorando alterações)
CMD ["air", "-c", ".air.toml"]