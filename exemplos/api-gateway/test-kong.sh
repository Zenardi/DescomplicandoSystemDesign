#!/bin/bash

# Script para testar Kong Gateway

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

KONG_PROXY_URL="http://localhost:8000"
KONG_ADMIN_URL="http://localhost:8001"

echo -e "${BLUE}🦍 Testando Kong Gateway${NC}"
echo "=================================="

# Função para testar endpoint
test_endpoint() {
    local url=$1
    local service_name=$2
    
    echo -e "\n${BLUE}📡 Testando $service_name${NC}"
    echo "URL: $url"
    
    response=$(curl -s -w "%{http_code}" "$url")
    http_code="${response: -3}"
    content="${response%???}"
    
    if [ "$http_code" -eq 200 ]; then
        echo -e "${GREEN}✅ Status: $http_code${NC}"
        echo "$content" | jq .
    else
        echo -e "${RED}❌ Erro: HTTP $http_code${NC}"
        echo "$content"
    fi
}

# Verificar se Kong está rodando
echo -e "\n${YELLOW}🔍 Verificando se Kong está acessível...${NC}"

if curl -s "$KONG_ADMIN_URL" > /dev/null; then
    echo -e "${GREEN}✅ Kong Admin API está acessível${NC}"
else
    echo -e "${RED}❌ Kong Admin API não está acessível${NC}"
    echo "Execute: docker-compose -f docker-compose-kong.yml up -d"
    exit 1
fi

# Mostrar configuração atual (carregada de kong.yml)
echo -e "\n${YELLOW}📋 Configuração atual do Kong (carregada de kong.yml):${NC}"
echo -e "\n${BLUE}Serviços registrados:${NC}"
services=$(curl -s "$KONG_ADMIN_URL/services" | jq -r '.data[] | .name')
if [ -z "$services" ]; then
    echo -e "${RED}❌ Nenhum serviço registrado no Kong${NC}"
    echo "Verifique se o arquivo kong.yml está correto e reinicie Kong"
    exit 1
else
    echo "$services" | while read -r service; do
        echo "- $service"
    done
fi

echo -e "\n${BLUE}Rotas registradas:${NC}"
curl -s "$KONG_ADMIN_URL/routes" | jq -r '.data[] | "- \(.paths[0]) -> \(.service.name)"'

# Testar endpoints através do Kong
echo -e "\n${YELLOW}🧪 Testando endpoints através do Kong Gateway...${NC}"
echo -e "${BLUE}Nota: Kong está configurado com strip_path=true${NC}"
echo -e "${BLUE}/api/users → /users, /api/products → /products, etc.${NC}"

test_endpoint "$KONG_PROXY_URL/api/users" "Users Service (via Kong)"
test_endpoint "$KONG_PROXY_URL/api/products" "Products Service (via Kong)"
test_endpoint "$KONG_PROXY_URL/api/orders" "Orders Service (via Kong)"

# Testar health checks
echo -e "\n${YELLOW}❤️ Testando health checks através do Kong...${NC}"

test_endpoint "$KONG_PROXY_URL/api/users/health" "Users Health (via Kong)"
test_endpoint "$KONG_PROXY_URL/api/products/health" "Products Health (via Kong)"
test_endpoint "$KONG_PROXY_URL/api/orders/health" "Orders Health (via Kong)"

# Mostrar estatísticas do Kong
echo -e "\n${YELLOW}📊 Estatísticas do Kong:${NC}"
echo -e "\n${BLUE}Status dos serviços:${NC}"
curl -s "$KONG_ADMIN_URL/status" | jq .

echo -e "\n${GREEN}🎉 Teste do Kong Gateway completo!${NC}"
echo -e "\n${YELLOW}💡 Dica: Acesse http://localhost:8002 para o Kong Manager (GUI)${NC}"
echo -e "\n${BLUE}📖 Para entender o path rewriting, veja: PATH-REWRITING.md${NC}"