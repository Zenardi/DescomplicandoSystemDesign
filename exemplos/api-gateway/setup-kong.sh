#!/bin/bash

# Script para verificar Kong Gateway em modo DB-less

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

KONG_ADMIN_URL="http://localhost:8001"

echo -e "${BLUE}🦍 Verificando Kong Gateway (DB-less mode)${NC}"
echo "=================================="

# Função para aguardar Kong estar pronto
wait_for_kong() {
    echo -e "${YELLOW}⏳ Aguardando Kong estar pronto...${NC}"
    
    for i in {1..30}; do
        if curl -s "$KONG_ADMIN_URL" > /dev/null 2>&1; then
            echo -e "${GREEN}✅ Kong está pronto!${NC}"
            return 0
        fi
        echo "Tentativa $i/30..."
        sleep 2
    done
    
    echo -e "${RED}❌ Kong não ficou pronto em 60 segundos${NC}"
    exit 1
}

# Aguardar Kong estar pronto
wait_for_kong

# Mostrar configuração atual (carregada do arquivo kong.yml)
echo -e "\n${YELLOW}📋 Configuração atual do Kong (carregada de kong.yml):${NC}"

echo -e "\n${BLUE}Serviços:${NC}"
curl -s "$KONG_ADMIN_URL/services" | jq -r '.data[] | "- \(.name): \(.host):\(.port)"'

echo -e "\n${BLUE}Rotas:${NC}"
curl -s "$KONG_ADMIN_URL/routes" | jq -r '.data[] | "- \(.paths[0]) -> \(.service.name) (strip_path: \(.strip_path))"'

echo -e "\n${GREEN}🎉 Kong Gateway configurado com sucesso via arquivo kong.yml!${NC}"
echo -e "\n${YELLOW}📚 URLs de teste:${NC}"
echo "- Users Service: http://localhost:8000/api/users"
echo "- Products Service: http://localhost:8000/api/products"
echo "- Orders Service: http://localhost:8000/api/orders"
echo ""
echo "- Kong Admin API: http://localhost:8001"
echo "- Kong Manager (GUI): http://localhost:8002"

echo -e "\n${BLUE}💡 Modo DB-less ativo:${NC}"
echo "- Configuração carregada de: kong.yml"
echo "- Sem necessidade de banco de dados"
echo "- Para alterar configuração, edite kong.yml e reinicie Kong"

echo -e "\n${YELLOW}🔄 Path Rewriting configurado:${NC}"
echo "- /api/users → /users (strip_path: true)"
echo "- /api/products → /products (strip_path: true)"
echo "- /api/orders → /orders (strip_path: true)"
echo "- Health checks também são reescritos"