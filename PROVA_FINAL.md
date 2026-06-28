# Resumo de Questões de Descomplicando System Design

Este documento contém um compilado de questões sobre padrões de arquitetura, resiliência, escalabilidade e redes, acompanhadas de explicações e referências.

---

### 1. Retry com backoff exponencial ajuda a:

**Alternativas:**
- Aumentar performance de integrações
- Aumentar partição
- Criar deadlock
- Reduzir pressão no sistema em cenários de intermitência de integrações

**Resposta Correta:** Reduzir pressão no sistema em cenários de intermitência de integrações

**Explicação:** O padrão de *Retry* com *Exponential Backoff* tenta executar a operação novamente após uma falha, aumentando exponencialmente o tempo de espera a cada tentativa (ex: 1s, 2s, 4s, 8s). Isso evita que um serviço que já está sobrecarregado ou intermitente seja bombardeado com tentativas imediatas, o que poderia agravar a indisponibilidade.

**Referências:**
- [Microsoft Learn - Implement retries with exponential backoff](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/implement-resilient-applications/implement-retries-exponential-backoff)
- [AWS - Timeouts, retries, and backoff with jitter](https://aws.amazon.com/blogs/architecture/exponential-backoff-and-jitter/)

---

### 2. Circuit breaker ajuda a:

**Alternativas:**
- Aumentar consistência
- Criar mutex
- Garantir quorum
- Evitar propagação de falhas

**Resposta Correta:** Evitar propagação de falhas

**Explicação:** O *Circuit Breaker* (Disjuntor) interrompe tentativas de conexão a um serviço que está falhando continuamente. Isso impede que requisições fiquem aguardando indefinidamente (timeouts) ocupando recursos (threads/memória), o que evita que a falha se propague (*cascading failures*) para outros componentes do sistema.

**Referências:**
- [Microsoft Learn - Circuit Breaker Pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker)
- [Martin Fowler - Circuit Breaker](https://martinfowler.com/bliki/CircuitBreaker.html)

---

### 3. Replicação multi-master aumenta:

**Alternativas:**
- Simplicidade
- Complexidade de resolução de conflitos
- Consistência forte automática
- Serialização

**Resposta Correta:** Complexidade de resolução de conflitos

**Explicação:** Na replicação *multi-master*, múltiplos nós podem aceitar operações de escrita simultaneamente. Se dois nós atualizarem o mesmo dado ao mesmo tempo, ocorrerá um conflito no momento de sincronizar os estados. Por isso, a arquitetura ganha em disponibilidade, mas a lógica para detectar e resolver esses conflitos aumenta substancialmente a complexidade.

**Referências:**
- [DigitalOcean - Understanding Database Master-Slave vs Multi-Master](https://www.digitalocean.com/community/tutorials/understanding-database-sharding)  
- [AWS - Amazon Aurora Multi-Master Clusters](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-multi-master.html)

---

### 4. Write-through cache garante:

**Alternativas:**
- Escrita síncrona no storage
- Escrita eventual
- Partição
- Mutex

**Resposta Correta:** Escrita síncrona no storage

**Explicação:** No padrão *Write-Through*, qualquer operação de gravação de dados atualiza o cache e, sincronamente, escreve no banco de dados principal antes de retornar o sucesso da operação para o cliente. Isso garante que o cache e o banco de dados estejam sempre consistentes.

**Referências:**
- [AWS ElastiCache - Caching Strategies](https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/Strategies.html)
- [Hazelcast - Write-Through Cache](https://docs.hazelcast.com/hazelcast/latest/data-structures/map-cache)

---

### 5. Write-behind cache implica:

**Alternativas:**
- Escrita imediata no banco
- Escrita assíncrona posterior
- Serialização
- Consistência forte

**Resposta Correta:** Escrita assíncrona posterior

**Explicação:** Também conhecido como *Write-Back*, neste modelo os dados são escritos primeiro apenas no cache. O retorno de sucesso é imediato para o cliente. Posteriormente, em segundo plano (assincronamente), os dados são descarregados (*flushed*) para o banco de dados definitivo. Isso melhora a latência, mas introduz um risco de perda de dados e foca em consistência eventual.

**Referências:**
- [Redis - Caching Strategies (Write-Back)](https://redis.com/redis-enterprise/data-structures/caching-strategies/)
- [Microsoft Learn - Caching Architecture](https://learn.microsoft.com/en-us/azure/architecture/best-practices/caching)

---

### 6. Em uma arquitetura baseada em Event Sourcing, o estado atual de uma entidade é derivado de:

**Alternativas:**
- Snapshot persistido a cada operação
- Última atualização no banco relacional
- Sequência ordenada de eventos imutáveis
- Cache distribuído

**Resposta Correta:** Sequência ordenada de eventos imutáveis

**Explicação:** O *Event Sourcing* não armazena o estado atual das entidades. Em vez disso, ele armazena todos os eventos (fatos que já ocorreram e não podem ser alterados) que afetaram a entidade ao longo do tempo. O estado atual é reconstruído "re-executando" essa trilha imutável de eventos desde o início.

**Referências:**
- [Martin Fowler - Event Sourcing](https://martinfowler.com/eaaDev/EventSourcing.html)
- [Microsoft Learn - Event Sourcing Pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/event-sourcing)

---

### 7. Snapshots em Event Sourcing são utilizados para:

**Alternativas:**
- Garantir ACID completo
- Reduzir custo de replay de eventos
- Substituir o event log
- Evitar necessidade de idempotência

**Resposta Correta:** Reduzir custo de replay de eventos

**Explicação:** Como reconstruir o estado a partir de milhões de eventos passados consome processamento e tempo, cria-se o *Snapshot* (uma fotografia pontual do estado consolidado). Assim, para obter o estado mais recente, basta carregar o último snapshot e aplicar apenas os eventos que ocorreram depois dele.

**Referências:**
- [EventStoreDB - Snapshots in Event Sourcing](https://developers.eventstore.com/server/v21.10/snapshots.html)
- [Microsoft Learn - CQRS and Event Sourcing](https://learn.microsoft.com/en-us/azure/architecture/patterns/cqrs)

---

### 8. O principal objetivo do padrão Bulkhead é:

**Alternativas:**
- Aumentar throughput máximo do sistema
- Garantir consistência forte global
- Isolar falhas para reduzir blast radius
- Eliminar necessidade de replicação

**Resposta Correta:** Isolar falhas para reduzir blast radius

**Explicação:** Inspirado no casco de navios compartimentados, o padrão *Bulkhead* separa recursos do sistema (threads, conexões, CPU) em *pools* distintos. Se uma parte do sistema entrar em colapso devido a alto tráfego ou erros, a falha fica restrita àquele compartimento (limitando o "raio da explosão"), e o restante da aplicação continua saudável.

**Referências:**
- [Microsoft Learn - Bulkhead Pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/bulkhead)
- [O'Reilly - Resiliency Patterns (Bulkhead)](https://www.oreilly.com/library/view/release-it-2nd/9781491984231/ch11.html)

---

### 9. Em uma arquitetura com 10 shards independentes distribuindo carga uniformemente, a falha de um shard implica aproximadamente:

**Alternativas:**
- 100% de indisponibilidade
- 50% de indisponibilidade
- 25% de indisponibilidade
- 10% de indisponibilidade

**Resposta Correta:** 10% de indisponibilidade

**Explicação:** O *Sharding* distribui dados por diferentes nós independentes. Assumindo que a carga e os dados são distribuídos uniformemente em 10 *shards*, cada um carrega 10% da operação. A falha de um afeta apenas a fração de usuários/dados daquele nó, ou seja, 10%.

**Referências:**
- [DigitalOcean - Understanding Database Sharding](https://www.digitalocean.com/community/tutorials/understanding-database-sharding)
- [AWS - Sharding Data Patterns](https://aws.amazon.com/blogs/database/sharding-with-amazon-relational-database-service/)

---

### 10. Bulkheads por segmentação de clientes (ex: enterprise vs free tier) ajudam principalmente a evitar:

**Alternativas:**
- Deadlocks
- Noisy Neighbor
- Partição de rede
- Eventual consistency

**Resposta Correta:** Noisy Neighbor

**Explicação:** O problema do *Noisy Neighbor* ("vizinho barulhento") ocorre quando um inquilino em uma arquitetura compartilhada (multitenant) consome recursos em excesso, degradando o serviço dos outros. Ao usar *bulkheads* por segmento (ex: separar hardware/recursos do plano grátis dos planos pagos), limita-se esse impacto.

**Referências:**
- [AWS - The Noisy Neighbor Problem](https://docs.aws.amazon.com/wellarchitected/latest/saas-lens/noisy-neighbor.html)
- [Microsoft - Noisy Neighbor anti-pattern](https://learn.microsoft.com/en-us/azure/architecture/antipatterns/noisy-neighbor/)

---

### 11. Ao combinar Bulkheads com hashing consistente, o benefício arquitetural principal é:

**Alternativas:**
- Noisy Neighbor
- Garantir ACID completo
- Eliminar replicação
- Distribuir carga de forma determinística e conter falhas estatisticamente

**Resposta Correta:** Distribuir carga de forma determinística e conter falhas estatisticamente

**Explicação:** O *hashing consistente* mapeia requisições uniformemente e de maneira previsível. Quando associado a *bulkheads*, você pode determinar quais chaves vão para quais isolamentos, garantindo que em caso de pico de tráfego numa chave específica, o problema fique isolado matematicamente em um cluster/sub-pool delimitado.

**Referências:**
- [Discord Engineering - How Discord scales (Consistent Hashing)](https://discord.com/blog/how-discord-scaled-elixir-to-5-000-000-concurrent-users)
- [Cloudflare - Consistent Hashing](https://www.cloudflare.com/learning/performance/what-is-consistent-hashing/)

---

### 12. A principal diferença entre um Proxy Reverso e um Load Balancer é que:

**Alternativas:**
- O proxy reverso não distribui tráfego
- O load balancer opera apenas em Layer 7
- O proxy reverso atua como intermediário para servidores internos, enquanto o load balancer foca na distribuição de carga
- São conceitos totalmente distintos e não se sobrepõem

**Resposta Correta:** O proxy reverso atua como intermediário para servidores internos, enquanto o load balancer foca na distribuição de carga

**Explicação:** Embora muitas ferramentas façam ambas as funções, filosoficamente o *Proxy Reverso* é o escudo/fachada que oculta os servidores de backend e processa fluxos como TLS e cache. O *Load Balancer* existe especificamente para resolver escalabilidade, distribuindo requisições massivas entre instâncias.

**Referências:**
- [NGINX - Proxy vs. Load Balancer](https://www.nginx.com/resources/glossary/reverse-proxy-vs-load-balancer/)
- [Cloudflare - What is a Reverse Proxy](https://www.cloudflare.com/learning/cdn/glossary/reverse-proxy/)

---

### 13. Um Load Balancer de Layer 4 (L4) opera com base em:

**Alternativas:**
- Headers HTTP
- Payload da aplicação
- IP e porta (TCP/UDP)
- Cookies de sessão

**Resposta Correta:** IP e porta (TCP/UDP)

**Explicação:** A camada 4 do modelo OSI trata do transporte. Portanto, os balanceadores operando neste nível encaminham os pacotes examinando puramente o IP de origem, IP de destino, e as portas (via TCP ou UDP), sem analisar o conteúdo (payload) ou os cabeçalhos HTTP.

**Referências:**
- [HAProxy - Layer 4 vs Layer 7 Load Balancing](https://www.haproxy.com/blog/layer-4-and-layer-7-proxy-mode)
- [NGINX - What Is Layer 4 Load Balancing](https://www.nginx.com/resources/glossary/layer-4-load-balancing/)

---

### 14. Um Load Balancer de Layer 7 (L7) pode tomar decisões baseadas em:

**Alternativas:**
- Path da URL e headers HTTP
- Apenas IP de origem
- Clock do servidor
- Endereço MAC

**Resposta Correta:** Path da URL e headers HTTP

**Explicação:** A camada 7 do OSI é a de aplicação. Um balanceador L7 entende o tráfego HTTP/HTTPS, permitindo roteamento inteligente baseado no caminho da URL (ex: `/imagens` vai para um servidor, `/api` para outro), cookies, tipos de arquivo e cabeçalhos (*User-Agent*).

**Referências:**
- [AWS - What is an Application Load Balancer?](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
- [NGINX - What Is Layer 7 Load Balancing](https://www.nginx.com/resources/glossary/layer-7-load-balancing/)

---

### 15. O algoritmo Round-Robin:

**Alternativas:**
- Direciona todas as requisições para o mesmo servidor
- Seleciona o servidor com menor uso de CPU
- Distribui requisições sequencialmente entre os nós ou por tempo
- Usa hashing consistente

**Resposta Correta:** Distribui requisições sequencialmente entre os nós ou por tempo

**Explicação:** *Round-Robin* é um algoritmo onde as requisições são entregues percorrendo uma lista de nós de forma circular, independentemente de monitoramento de carga ou processamento no momento (A, B, C, volta ao A).

**Referências:**
- [Cloudflare - What is round-robin load balancing?](https://www.cloudflare.com/learning/performance/what-is-round-robin-load-balancing/)
- [F5 - Round Robin Load Balancing](https://www.f5.com/services/resources/glossary/round-robin-load-balancing)

---

### 16. O principal papel de um API Gateway em arquitetura de microsserviços é:

**Alternativas:**
- Persistir dados distribuídos
- Substituir completamente os serviços internos
- Balancear carga entre nodes
- Atuar como ponto único de entrada e orquestração de requisições

**Resposta Correta:** Atuar como ponto único de entrada e orquestração de requisições

**Explicação:** O Gateway atua como um *front-door* para todas as requisições. Ele roteia o tráfego do cliente para o microsserviço adequado, simplificando a comunicação e provendo um ponto centralizado de controle.

**Referências:**
- [AWS - What is an API Gateway?](https://aws.amazon.com/api-gateway/)
- [Microsoft Learn - API Gateways in Microservices](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/architect-microservice-container-applications/direct-client-to-microservice-communication-versus-the-api-gateway-pattern)

---

### 17. Um API Gateway normalmente é responsável por:

**Alternativas:**
- Executar lógica de negócio complexa
- Autenticação, roteamento e rate limiting
- Replicação de banco
- Lock distribuído

**Resposta Correta:** Autenticação, roteamento e rate limiting

**Explicação:** Ao usar um API Gateway, você transfere responsabilidades transversais, como autenticar tokens JWT, controlar a taxa de acesso (*rate limit*) e gerenciar conexões, libertando os microsserviços de negócio dessas tarefas não-funcionais comuns.

**Referências:**
- [Kong - API Gateway Patterns](https://konghq.com/learning-center/api-gateway/api-gateway-patterns)
- [RedHat - What is an API Gateway?](https://www.redhat.com/en/topics/api/what-is-an-api-gateway)

---

### 18. Rate limiting no API Gateway serve para:

**Alternativas:**
- Aumentar latência
- Proteger o backend contra abuso ou sobrecarga
- Identificar ataques de negação de serviço
- Permitir controle de acesso a versionamento

**Resposta Correta:** Proteger o backend contra abuso ou sobrecarga

**Explicação:** Limitar a taxa de requisições (ex: 100 reqs/minuto por cliente) é a principal técnica defensiva contra abusos (intencionais ou por *bugs* de integrações clientes), garantindo a estabilidade e a disponibilidade da infraestrutura.

**Referências:**
- [Stripe Engineering - Rate Limiters](https://stripe.com/blog/rate-limiters)
- [Google Cloud - Rate Limiting Strategies](https://cloud.google.com/architecture/rate-limiting-strategies-techniques)

---

### 19. A implementação de autenticação no API Gateway permite:

**Alternativas:**
- Remover autenticação dos serviços downstream
- Centralizar validação de tokens e credenciais
- Eliminar necessidade de autorização
- Garantir consistência eventual

**Resposta Correta:** Centralizar validação de tokens e credenciais

**Explicação:** Validar o JWT ou qualquer token de acesso no Gateway impede que requisições malformadas ou não autorizadas cheguem até as camadas mais profundas de negócio (*downstream*), reduzindo duplicação de código de verificação em cada microsserviço.

**Referências:**
- [Auth0 - Securing APIs with API Gateways](https://auth0.com/blog/securing-microservices-with-api-gateways/)
- [Microsoft Learn - API Gateway Authentication](https://learn.microsoft.com/en-us/azure/architecture/microservices/design/gateway)

---

### 20. O padrão Backend-for-Frontend (BFF) está relacionado ao API Gateway porque:

**Alternativas:**
- Substitui o load balancer
- Cria gateways especializados por tipo de cliente
- Elimina necessidade de autenticação
- Reduzir chamadas repetidas ao backend

**Resposta Correta:** Cria gateways especializados por tipo de cliente

**Explicação:** O padrão BFF orienta a criação de múltiplos *gateways* adaptados para clientes específicos (um BFF para Mobile, um para Web), em vez de ter um API Gateway gigantesco e universal (*one-size-fits-all*).

**Referências:**
- [Martin Fowler - Backends For Frontends](https://samnewman.io/patterns/architectural/bff/)
- [Microsoft Learn - Backends for Frontends pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/backends-for-frontends)
