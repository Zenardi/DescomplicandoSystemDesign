#!/bin/bash

echo "🚀 Script de Teste - Load Balancer vs Reverse Proxy Patterns"
echo "============================================================"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para verificar se os serviços estão rodando
check_services() {
    echo -e "\n${BLUE}🔍 Verificando status dos serviços...${NC}"
    
    # Check Load Balancer
    if curl -s http://localhost:9900/ready > /dev/null; then
        echo -e "${GREEN}✅ Load Balancer: Online${NC}"
    else
        echo -e "${RED}❌ Load Balancer: Offline${NC}"
        return 1
    fi
    
    # Check Reverse Proxies
    for i in {1..3}; do
        port=$((9900 + i))
        if curl -s http://localhost:$port/ready > /dev/null; then
            echo -e "${GREEN}✅ Reverse Proxy $i: Online${NC}"
        else
            echo -e "${RED}❌ Reverse Proxy $i: Offline${NC}"
        fi
    done
    
    # Check Backend
    if curl -s http://localhost:8081/health > /dev/null; then
        echo -e "${GREEN}✅ Backend App: Online${NC}"
    else
        echo -e "${RED}❌ Backend App: Offline${NC}"
    fi
}

# Função para testar distribuição de carga
test_load_balancing() {
    echo -e "\n${BLUE}⚖️  Testando Load Balancing Pattern...${NC}"
    echo "Fazendo 12 requisições para observar a distribuição:"
    echo ""
    
    declare -A proxy_count
    
    for i in {1..12}; do
        response=$(curl -s http://localhost/)
        if [ $? -eq 0 ]; then
            proxy=$(echo $response | jq -r '.headers["x-proxy-server"]' 2>/dev/null)
            if [ "$proxy" != "null" ] && [ "$proxy" != "" ]; then
                proxy_count[$proxy]=$((${proxy_count[$proxy]} + 1))
                echo -e "Requisição $i: ${GREEN}$proxy${NC}"
            else
                echo -e "Requisição $i: ${RED}Erro ao obter proxy${NC}"
            fi
        else
            echo -e "Requisição $i: ${RED}Falha na requisição${NC}"
        fi
        sleep 0.3
    done
    
    echo -e "\n${YELLOW}📊 Distribuição das requisições:${NC}"
    for proxy in "${!proxy_count[@]}"; do
        echo -e "  $proxy: ${proxy_count[$proxy]} requisições"
    done
}

# Função para testar acesso direto aos reverse proxies
test_reverse_proxies() {
    echo -e "\n${BLUE}🔄 Testando Reverse Proxy Pattern...${NC}"
    echo "Acessando cada reverse proxy diretamente:"
    echo ""
    
    for i in {1..3}; do
        port=$((8080 + i))
        echo -e "Testando Reverse Proxy $i (porta $port):"
        
        response=$(curl -s http://localhost:$port/)
        if [ $? -eq 0 ]; then
            proxy_server=$(echo $response | jq -r '.headers["x-proxy-server"]' 2>/dev/null)
            proxy_type=$(echo $response | jq -r '.headers["x-proxy-type"]' 2>/dev/null)
            backend_hostname=$(echo $response | jq -r '.hostname' 2>/dev/null)
            
            echo -e "  ✅ ${GREEN}Proxy Server: $proxy_server${NC}"
            echo -e "  ✅ ${GREEN}Proxy Type: $proxy_type${NC}"
            echo -e "  ✅ ${GREEN}Backend: $backend_hostname${NC}"
        else
            echo -e "  ❌ ${RED}Falha ao acessar proxy $i${NC}"
        fi
        echo ""
    done
}

# Função para mostrar headers completos
show_headers() {
    echo -e "\n${BLUE}📋 Headers de uma requisição completa:${NC}"
    echo "Mostrando como identificar os patterns pelos headers:"
    echo ""
    
    response=$(curl -s -w "%{http_code}" http://localhost/)
    echo -e "${YELLOW}Response:${NC}"
    echo $response | jq '.' 2>/dev/null || echo $response
}

# Função para testar endpoints específicos
test_endpoints() {
    echo -e "\n${BLUE}🎯 Testando diferentes endpoints:${NC}"
    
    endpoints=("/" "/health" "/api/data")
    
    for endpoint in "${endpoints[@]}"; do
        echo -e "\nTesting endpoint: ${YELLOW}$endpoint${NC}"
        response=$(curl -s http://localhost$endpoint)
        if [ $? -eq 0 ]; then
            echo -e "✅ ${GREEN}Success${NC}"
            if [[ $endpoint == "/health" ]]; then
                status=$(echo $response | jq -r '.status' 2>/dev/null)
                echo -e "   Status: $status"
            fi
        else
            echo -e "❌ ${RED}Failed${NC}"
        fi
    done
}

# Função para monitorar métricas
show_metrics() {
    echo -e "\n${BLUE}📈 Métricas dos componentes:${NC}"
    
    echo -e "\n${YELLOW}Load Balancer Stats:${NC}"
    curl -s http://localhost:9900/stats | grep -E "(upstream_rq_total|health)" | head -5
    
    echo -e "\n${YELLOW}Reverse Proxy 1 Stats:${NC}"
    curl -s http://localhost:9901/stats | grep -E "(upstream_rq_total|health)" | head -3
}

# Menu principal
show_menu() {
    echo -e "\n${YELLOW}Escolha uma opção:${NC}"
    echo "1. Verificar status dos serviços"
    echo "2. Testar Load Balancing"
    echo "3. Testar Reverse Proxies diretamente"
    echo "4. Mostrar headers completos"
    echo "5. Testar diferentes endpoints"
    echo "6. Mostrar métricas"
    echo "7. Executar todos os testes"
    echo "8. Sair"
    echo ""
    read -p "Digite sua escolha (1-8): " choice
}

# Função para executar todos os testes
run_all_tests() {
    check_services
    test_load_balancing
    test_reverse_proxies
    show_headers
    test_endpoints
    show_metrics
}

# Loop principal
while true; do
    show_menu
    
    case $choice in
        1)
            check_services
            ;;
        2)
            test_load_balancing
            ;;
        3)
            test_reverse_proxies
            ;;
        4)
            show_headers
            ;;
        5)
            test_endpoints
            ;;
        6)
            show_metrics
            ;;
        7)
            run_all_tests
            ;;
        8)
            echo -e "\n${GREEN}👋 Obrigado por usar o script de teste!${NC}"
            exit 0
            ;;
        *)
            echo -e "\n${RED}❌ Opção inválida. Tente novamente.${NC}"
            ;;
    esac
    
    echo -e "\n${BLUE}Pressione Enter para continuar...${NC}"
    read
done