#!/bin/bash

echo "🎛️ Teste de Weighted Round Robin - Quantum do Envoy"
echo "=================================================="

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para testar distribuição weighted
test_weighted_distribution() {
    echo -e "\n${BLUE}⚖️ Testando Distribuição Weighted Round Robin...${NC}"
    echo "Configuração atual:"
    echo -e "  ${GREEN}Proxy 1: Peso 5 (50% esperado)${NC}"
    echo -e "  ${GREEN}Proxy 2: Peso 3 (30% esperado)${NC}"
    echo -e "  ${GREEN}Proxy 3: Peso 2 (20% esperado)${NC}"
    echo ""
    
    declare -A proxy_count
    declare -A proxy_sequence
    total_requests=20
    
    echo "Fazendo $total_requests requisições..."
    echo ""
    
    for i in $(seq 1 $total_requests); do
        response=$(curl -s http://localhost/)
        if [ $? -eq 0 ]; then
            proxy=$(echo $response | jq -r '.headers["x-proxy-server"]' 2>/dev/null)
            if [ "$proxy" != "null" ] && [ "$proxy" != "" ]; then
                proxy_count[$proxy]=$((${proxy_count[$proxy]} + 1))
                proxy_sequence[$i]=$proxy
                echo -e "Req $i: ${GREEN}$proxy${NC}"
            else
                echo -e "Req $i: ${RED}Erro ao obter proxy${NC}"
            fi
        else
            echo -e "Req $i: ${RED}Falha na requisição${NC}"
        fi
        sleep 0.3
    done
    
    echo -e "\n${YELLOW}📊 Estatísticas da Distribuição:${NC}"
    echo "================================"
    
    total_successful=0
    for proxy in "${!proxy_count[@]}"; do
        count=${proxy_count[$proxy]}
        total_successful=$((total_successful + count))
    done
    
    for proxy in "${!proxy_count[@]}"; do
        count=${proxy_count[$proxy]}
        percentage=$(echo "scale=1; $count * 100 / $total_successful" | bc -l)
        echo -e "  $proxy: ${count}/${total_successful} requisições (${percentage}%)"
    done
    
    echo -e "\n${YELLOW}🔄 Sequência de Distribuição:${NC}"
    echo "============================="
    sequence=""
    for i in $(seq 1 $total_requests); do
        if [ "${proxy_sequence[$i]}" ]; then
            proxy_num=$(echo ${proxy_sequence[$i]} | grep -o '[0-9]')
            sequence="${sequence}${proxy_num}-"
        fi
    done
    echo "Padrão observado: ${sequence%?}"
    
    echo -e "\n${BLUE}💡 Análise do Quantum:${NC}"
    echo "===================="
    echo "• Com pesos [5,3,2], esperamos um padrão aproximado:"
    echo "  1-1-1-1-1-2-2-2-3-3 (em um ciclo de 10)"
    echo "• A distribuição real pode variar devido a:"
    echo "  - Health checks"
    echo "  - Timing das requisições"
    echo "  - Estado interno do Envoy"
}

# Função para mostrar configuração atual
show_weighted_config() {
    echo -e "\n${BLUE}⚙️ Configuração do Weighted Round Robin:${NC}"
    echo "======================================="
    
    echo -e "\n${YELLOW}Load Balancer Config (load-balancer-weighted.yaml):${NC}"
    echo "Proxy 1: load_balancing_weight: 5"
    echo "Proxy 2: load_balancing_weight: 3"
    echo "Proxy 3: load_balancing_weight: 2"
    
    echo -e "\n${YELLOW}Métricas do Load Balancer:${NC}"
    curl -s http://localhost:9900/stats | grep -E "(upstream_rq_total|lb_healthy_panic)" | head -10
}

# Função para comparar com round robin simples
compare_with_simple_rr() {
    echo -e "\n${BLUE}📈 Comparação: Weighted vs Simple Round Robin${NC}"
    echo "=============================================="
    
    echo -e "${YELLOW}Weighted Round Robin (atual):${NC}"
    echo "• Distribuição: 50% / 30% / 20%"
    echo "• Permite priorização de recursos"
    echo "• Ideal para capacidades diferentes"
    
    echo -e "\n${YELLOW}Simple Round Robin (docker-compose.yml):${NC}"
    echo "• Distribuição: 33% / 33% / 33%"
    echo "• Distribuição equitativa"
    echo "• Ideal para recursos homogêneos"
    
    echo -e "\n${GREEN}Para testar Simple RR:${NC}"
    echo "docker-compose down && docker-compose up -d"
    echo -e "\n${GREEN}Para voltar ao Weighted RR:${NC}"
    echo "docker-compose down && docker-compose -f docker-compose-weighted.yml up -d"
}

# Função para testar diferentes cenários
test_scenarios() {
    echo -e "\n${BLUE}🧪 Cenários de Teste Avançados:${NC}"
    echo "==============================="
    
    echo -e "\n${YELLOW}1. Teste de Burst (requisições rápidas):${NC}"
    for i in {1..10}; do
        curl -s http://localhost/ | jq -r '.headers["x-proxy-server"]' 2>/dev/null
    done | sort | uniq -c | sort -nr
    
    echo -e "\n${YELLOW}2. Teste com delay (requisições espaçadas):${NC}"
    for i in {1..6}; do
        proxy=$(curl -s http://localhost/ | jq -r '.headers["x-proxy-server"]' 2>/dev/null)
        echo "Req $i: $proxy"
        sleep 2
    done
}

# Menu principal
show_menu() {
    echo -e "\n${YELLOW}Escolha uma opção:${NC}"
    echo "1. Testar distribuição Weighted Round Robin"
    echo "2. Mostrar configuração atual"
    echo "3. Comparar Weighted vs Simple Round Robin"
    echo "4. Executar cenários avançados"
    echo "5. Executar todos os testes"
    echo "6. Sair"
    echo ""
    read -p "Digite sua escolha (1-6): " choice
}

# Verificar se o serviço está rodando
if ! curl -s http://localhost:9900/ready > /dev/null; then
    echo -e "${RED}❌ Load Balancer não está rodando!${NC}"
    echo -e "${YELLOW}Execute: docker-compose -f docker-compose-weighted.yml up -d${NC}"
    exit 1
fi

# Loop principal
while true; do
    show_menu
    
    case $choice in
        1)
            test_weighted_distribution
            ;;
        2)
            show_weighted_config
            ;;
        3)
            compare_with_simple_rr
            ;;
        4)
            test_scenarios
            ;;
        5)
            test_weighted_distribution
            show_weighted_config
            compare_with_simple_rr
            test_scenarios
            ;;
        6)
            echo -e "\n${GREEN}👋 Teste concluído!${NC}"
            exit 0
            ;;
        *)
            echo -e "\n${RED}❌ Opção inválida. Tente novamente.${NC}"
            ;;
    esac
    
    echo -e "\n${BLUE}Pressione Enter para continuar...${NC}"
    read
done