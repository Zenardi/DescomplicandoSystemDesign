# API Gateway Lab - Aplicações Exemplo

Este lab contém 3 aplicações exemplo em Go para demonstrar conceitos de API Gateway em sistemas distribuídos.

## Aplicações

### App 1 - Users Service
- **Porto**: 8081
- **Endpoint**: `/users`

### App 2 - Products Service
- **Porto**: 8082
- **Endpoint**: `/products`

### App 3 - Orders Service
- **Porto**: 8083
- **Endpoint**: `/orders`

### App 4 - Orders Service v2
- **Porto**: 8084
- **Endpoint**: `/orders`

## Como Executar

### Usando Docker Compose Diretamente

```bash
# Construir e iniciar
docker-compose up -d --build

# Parar
docker-compose down

# Ver logs
docker-compose logs -f
```

## Testando os Serviços

### Endpoints Principais

```bash
# Users Service
curl http://localhost:8081/users

# Products Service
curl http://localhost:8082/products

# Orders Service
curl http://localhost:8083/orders
```

### Health Checks

```bash
# Users Service Health
curl http://localhost:8081/health

# Products Service Health
curl http://localhost:8082/health

# Orders Service Health
curl http://localhost:8083/health
```

## Kong Gateway (Recomendado)

Para uma experiência completa de API Gateway, use Kong em modo DB-less:

### Início Rápido com Kong

```bash
# Iniciar Kong + todos os serviços
make kong-run

# Testar através do Kong
curl http://localhost:8000/api/v1/users
curl http://localhost:8000/api/v1/products
curl http://localhost:8000/api/v1/orders
curl http://localhost:8000/api/v2/orders
```

### URLs do Kong
- **Proxy**: http://localhost:8000 (entrada principal)
- **Admin API**: http://localhost:8001
- **Manager (GUI)**: http://localhost:8002


## Logs

Para acompanhar os logs em tempo real:

```bash
# Todos os serviços
docker-compose logs -f

# Serviço específico
docker-compose logs -f users-service
docker-compose logs -f products-service
docker-compose logs -f orders-service
docker-compose logs -f orders-service-v2
```