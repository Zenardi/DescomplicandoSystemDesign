# Build stage
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Instalar dependências do sistema
RUN apk add --no-cache git

# Copiar arquivos go mod e sum
COPY go.mod go.sum ./

# Download das dependências
RUN go mod download

# Copiar código fonte
COPY . .

# Build da aplicação
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Runtime stage
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copiar binário do stage de build
COPY --from=builder /app/main .

# Expor porta
EXPOSE 3000

# Comando para executar a aplicação
CMD ["./main"]