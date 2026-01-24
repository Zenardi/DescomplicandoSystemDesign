# Load Balancer vs Reverse Proxy Patterns com Envoy

Este exemplo demonstra como uma mesma tecnologia (Envoy) pode implementar tanto o pattern de **Load Balancer** quanto o pattern de **Reverse Proxy**, mostrando claramente a diferença conceitual entre eles.

## Objetivo Educacional

Demonstrar que tecnologias como Envoy, NGINX, HAProxy, etc. são **ferramentas** que podem implementar diferentes **patterns arquiteturais**:

- **Reverse Proxy Pattern**: Atua como intermediário entre cliente e um único serviço backend
- **Load Balancer Pattern**: Distribui requisições entre múltiplos backends para balanceamento de carga

## 🏗️ Arquitetura do Exemplo

```
[Cliente] 
    ↓
[Load Balancer - Envoy] (Pattern: Load Balancer)
    ↓ (Round Robin)
┌─────────────────────────────────────────────┐
│ [Reverse Proxy 1] ← [Reverse Proxy 2] ← [Reverse Proxy 3] │ (Pattern: Reverse Proxy)
└─────────────────────────────────────────────┘
    ↓ ↓ ↓ (todos apontam para o mesmo backend)
[Backend Application - Node.js]
```

### Componentes

1. **1x Backend Application (Node.js)**: A aplicação final que serve as requisições
2. **3x Reverse Proxies (Envoy)**: Cada um atua como proxy reverso para a mesma aplicação
3. **1x Load Balancer (Envoy)**: Distribui o tráfego entre os 3 reverse proxies

## 📊 Diferenças Conceituais

### Reverse Proxy Pattern
- **Função**: Intermediário transparente entre cliente e servidor
- **Objetivo**: 
  - Terminar SSL/TLS
  - Cache de respostas
  - Compressão
  - Autenticação/Autorização
  - Mascarar a infraestrutura interna
- **Relação**: 1 proxy → 1 (ou poucos) backend(s)
- **No exemplo**: Cada Envoy proxy reverso aponta para o mesmo backend

### Load Balancer Pattern
- **Função**: Distribuidor de carga entre múltiplos backends
- **Objetivo**:
  - Distribuir requisições
  - Alta disponibilidade
  - Escalabilidade horizontal
  - Health checking
- **Relação**: 1 load balancer → N backends
- **No exemplo**: O Envoy load balancer distribui entre os 3 proxies reversos

## 🚀 Como Executar

### Pré-requisitos
- Docker e Docker Compose instalados
- Portas disponíveis: 80, 8081-8083, 9900-9903

### Executar o exemplo

```bash
# Clonar/navegar para o diretório
cd envoy-patterns

# Construir e iniciar todos os serviços
docker-compose up --build

# Ou em background
docker-compose up --build -d
```

### Acessar os serviços

```bash
# Através do Load Balancer (porta 80)
curl http://localhost/

# Acessar diretamente cada Reverse Proxy
curl http://localhost:8081/  # Reverse Proxy 1
curl http://localhost:8082/  # Reverse Proxy 2
curl http://localhost:8083/  # Reverse Proxy 3

# Endpoints da aplicação
curl http://localhost/api/data
curl http://localhost/health
```

## 🔍 Observando os Patterns

### 1. Testando o Load Balancer Pattern

```bash
# Faça várias requisições para ver o balanceamento
for i in {1..900}; do
  echo "Requisição $i:"
  curl -sI 0.0.0.0:80/api/data | grep x-proxy-server
  sleep 1;
done
```

**Resultado esperado**: Você verá que as requisições são distribuídas entre `reverse-proxy-1`, `reverse-proxy-2`, e `reverse-proxy-3` em round-robin.

### 2. Verificando os Headers de Identificação

```bash
curl -v http://localhost/
```

**Headers importantes**:
- `X-Load-Balancer: envoy-lb` - Identifica que passou pelo load balancer
- `X-Proxy-Server: reverse-proxy-X` - Identifica qual proxy reverso atendeu
- `X-Pattern: Load-Balancer` - Pattern implementado pelo ponto de entrada
- `X-Proxy-Type: Reverse-Proxy` - Pattern implementado pelos proxies internos


## Simulando Carga

```bash
# Script para simular carga e observar distribuição
for i in {1..20}; do
  response=$(curl -s http://localhost:80/api/data)
  proxy=$(echo $response | jq -r '.service')
  echo "Requisição $i: Atendida por $proxy"
  sleep 0.5
done
```

## Configurações Importantes

### Load Balancer (load-balancer.yaml)
```yaml
# Tipo de cluster para múltiplos endpoints
type: STRICT_DNS  # Permite múltiplos endpoints

# Algoritmo de balanceamento
lb_policy: ROUND_ROBIN

# Configuração de Weighted Round Robin (Quantum)
endpoints:
  - reverse-proxy-1:8080
    load_balancing_weight: 3  # Recebe 3 requisições por ciclo
  - reverse-proxy-2:8080
    load_balancing_weight: 2  # Recebe 2 requisições por ciclo  
  - reverse-proxy-3:8080
    load_balancing_weight: 1  # Recebe 1 requisição por ciclo

# Configuração de Slow Start (ramp-up gradual)
slow_start_config:
  slow_start_window: 60s
```

### 🎛️ Configuração de Quantum/Weighted Round Robin

O Envoy permite configurar o "quantum" do Round Robin através de diferentes mecanismos:

#### 1. **Load Balancing Weight** (Peso por endpoint)
```yaml
load_balancing_weight: 3  # Este endpoint receberá 3x mais tráfego
```

#### 2. **Slow Start Configuration** (Ramp-up gradual)
```yaml
slow_start_config:
  slow_start_window: 60s  # Janela de 60s para entrada gradual
```

#### 3. **Exemplo de Distribuição Weighted**
Com pesos `[5, 3, 2]`, o padrão de distribuição será:
- **Proxy 1**: 5 requisições (50% do tráfego)
- **Proxy 2**: 3 requisições (30% do tráfego)  
- **Proxy 3**: 2 requisições (20% do tráfego)

**Padrão de distribuição**: 1-1-1-1-1-2-2-2-3-3 (em um ciclo de 10 requisições)

#### 4. **Testando Weighted Round Robin**
```bash
# Use a configuração weighted
docker-compose -f docker-compose-weighted.yml up

# Observe a distribuição desproporcional
for i in {1..15}; do
  echo "Requisição $i:"
  curl -sI localhost/api/data | grep x-proxy-server
  sleep 0.5
done
```

### Reverse Proxy (reverse-proxy-*.yaml)
```yaml
# Tipo de cluster para endpoint único
type: LOGICAL_DNS  # Ideal para um único endpoint

# Um único endpoint (o backend)
endpoints:
  - backend-app:3000
```


### Exercícios Propostos

1. Altere o algoritmo de load balancing para `LEAST_REQUEST`
2. Adicione mais instâncias de backend e observe o comportamento
3. Simule falha em um dos reverse proxies e observe o health checking
4. Implemente rate limiting no load balancer
5. Configure cache no reverse proxy
