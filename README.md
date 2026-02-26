# Descomplicando System Design
![main-header](./images/main-header.png)

> [!NOTE]
> Todos os artigos aqui mencionados foram escritos pelo [Matheus Fidelis](https://github.com/msfidelis), instrutor do curso [Descomplicando o System Design](https://linuxtips.io/treinamento/descomplicando-o-system-design-2026/) e autor dos mesmos.

- [Descomplicando System Design](#descomplicando-system-design)
- [Conteúdo](#conteúdo)
- [Materiais](#materiais)
- [Book de Cases e Exercícios Livres](#book-de-cases-e-exercícios-livres)
  - [Cases Resolvidos](#cases-resolvidos)


# Conteúdo

<details>
<summary>DAY-01 - Protocolos de Rede</summary>

* [System Design - Protocolos e Comunicação de Rede](day-01/README.md#system-design---protocolos-e-comunicação-de-rede)
* [Modelo OSI](day-01/README.md#modelo-osi)
   * [Camada 1: Física](day-01/README.md#camada-1-física)
   * [Camada 2: Enlace](day-01/README.md#camada-2-enlace)
   * [Camada 3: Rede](day-01/README.md#camada-3-rede)
   * [Camada 4: Transporte](day-01/README.md#camada-4-transporte)
   * [Camada 5: Sessão](day-01/README.md#camada-5-sessão)
   * [Camada 6: Apresentação](day-01/README.md#camada-6-apresentação)
   * [Camada 7: Aplicação](day-01/README.md#camada-7-aplicação)
* [Os Protocolos de Comunicação](day-01/README.md#os-protocolos-de-comunicação)
   * [Definindo um Protocolo](day-01/README.md#definindo-um-protocolo)
   * [Protocolos Base](day-01/README.md#protocolos-base)
   * [Protocolo IP, IPv4 e IPv6](day-01/README.md#protocolo-ip-ipv4-e-ipv6)
   * [IPv4](day-01/README.md#ipv4)
   * [IPv6](day-01/README.md#ipv6)
   * [Dual Stack](day-01/README.md#dual-stack)
* [UDP - User Datagram Protocol](day-01/README.md#udp---user-datagram-protocol)
* [TCP - Transmission Control Protocol](day-01/README.md#tcp---transmission-control-protocol)
   * [Escolhendo Entre TCP e UDP para Construção e Uso de Protocolos](day-01/README.md#escolhendo-entre-tcp-e-udp-para-construção-e-uso-de-protocolos)
* [SSL/TLS - Transport Layer Security](day-01/README.md#ssltls---transport-layer-security)
* [Demais Protocolos e Aplicações de Rede](day-01/README.md#demais-protocolos-e-aplicações-de-rede)
* [DNS - Domain Name Service](day-01/README.md#dns---domain-name-service)
   * [Funcionamento Lógico do DNS](day-01/README.md#funcionamento-lógico-do-dns)
   * [Resolução do DNS na Prática](day-01/README.md#resolução-do-dns-na-prática)
* [DHCP - Dynamic Host Configuration Protocol](day-01/README.md#dhcp---dynamic-host-configuration-protocol)
* [NTP - Network Time Protocol](day-01/README.md#ntp---network-time-protocol)
* [SSH - Secure Shell](day-01/README.md#ssh---secure-shell)
* [Telnet](day-01/README.md#telnet)
* [Protocolos HTTP/1, HTTP/2 e HTTP/3](day-01/README.md#protocolos-http1-http2-e-http3)
   * [Estruturas de Requisições e Respostas HTTP](day-01/README.md#estruturas-de-requisições-e-respostas-http)
      * [Body](day-01/README.md#body)
      * [Headers](day-01/README.md#headers)
      * [Cookies](day-01/README.md#cookies)
      * [Status Codes](day-01/README.md#status-codes)
* [HTTP/1.x](day-01/README.md#http1x)
* [HTTP/2](day-01/README.md#http2)
* [HTTP/3 (QUIC)](day-01/README.md#http3-quic)
</details>

&nbsp;

<details>
<summary>DAY-02 - Storage, RAID e Sistemas de Arquivos</summary>

- [System Design - Storage, RAID e Sistemas de Arquivos](day-02/README.md#system-design---storage-raid-e-sistemas-de-arquivos)
- [Definindo Storage e Armazenamento](day-02/README.md#definindo-storage-e-armazenamento)
- [Dimensões em Storage](day-02/README.md#dimensões-em-storage)
  - [Throughput em Storage](day-02/README.md#throughput-em-storage)
  - [Bandwidth em Storage](day-02/README.md#bandwidth-em-storage)
  - [I/O e IOPS em Storage](day-02/README.md#io-e-iops-em-storage)
- [Tipos e Modelos de Storage](day-02/README.md#tipos-e-modelos-de-storage)
  - [DAS - Direct-Attached Storage](day-02/README.md#das---direct-attached-storage)
  - [NAS - Network Attached Storage](day-02/README.md#nas---network-attached-storage)
  - [Block Storage](day-02/README.md#block-storage)
  - [File Storage](day-02/README.md#file-storage)
  - [Object Storage](day-02/README.md#object-storage)
- [RAID - Redundant Array of Independent Disks](day-02/README.md#raid---redundant-array-of-independent-disks)
  - [RAID 0 (Striping)](day-02/README.md#raid-0-striping)
  - [RAID 1 (Mirroring)](day-02/README.md#raid-1-mirroring)
  - [RAID 5 (Striping com Paridade Distribuída)](day-02/README.md#raid-5-striping-com-paridade-distribuída)
  - [RAID 6 (Striping com Dupla Paridade)](day-02/README.md#raid-6-striping-com-dupla-paridade)
  - [RAID 10 (Combinação de RAID 1 com RAID 0)](day-02/README.md#raid-10-combinação-de-raid-1-com-raid-0)
</details>

&nbsp;

<details>
<summary>DAY-03 - Teorema CAP, ACID, BASE e Bancos de Dados Distribuídos</summary>

- [System Design - Teorema CAP, ACID, BASE e Bancos de Dados Distribuídos](day-03/README.md#system-design---teorema-cap-acid-base-e-bancos-de-dados-distribuídos)
- [O Teorema CAP](day-03/README.md#o-teorema-cap)
- [ACID e BASE, os trade-offs entre SQL e NoSQL](day-03/README.md#acid-e-base-os-trade-offs-entre-sql-e-nosql)
- [Modelo ACID - Atomicity, Consistency, Isolation, Durability](day-03/README.md#modelo-acid---atomicity-consistency-isolation-durability)
  - [Atomicidade](day-03/README.md#atomicidade)
  - [Consistência](day-03/README.md#consistência)
  - [Isolamento](day-03/README.md#isolamento)
  - [Durabilidade](day-03/README.md#durabilidade)
- [Modelo BASE - Basically Available, Soft State, Eventual Consistency](day-03/README.md#modelo-base---basically-available-soft-state-eventual-consistency)
  - [Basicamente Disponível](day-03/README.md#basicamente-disponível)
  - [Soft State](day-03/README.md#soft-state)
  - [Eventualmente Consistente](day-03/README.md#eventualmente-consistente)
- [Explicação dos Componentes do CAP](day-03/README.md#explicação-dos-componentes-do-cap)
  - [Consistency / Consistência (C)](day-03/README.md#consistency--consistência-c)
  - [Availability / Disponibilidade (A)](day-03/README.md#availability--disponibilidade-a)
  - [Partition Tolerance / Tolerância a Partições (P)](day-03/README.md#partition-tolerance--tolerância-a-partições-p)
  - [O que é uma Partição de Rede?](day-03/README.md#o-que-é-uma-partição-de-rede)
- [As combinações do Teorema: “Escolha 2”](day-03/README.md#as-combinações-do-teorema-escolha-2)
  - [CP (Consistência e Tolerância a Partições)](day-03/README.md#cp-consistência-e-tolerância-a-partições)
  - [AP (Disponibilidade e Tolerância a Partições)](day-03/README.md#ap-disponibilidade-e-tolerância-a-partições)
  - [CA (Consistência e Disponibilidade)](day-03/README.md#ca-consistência-e-disponibilidade)
- [Tabela de Flavors (CAP)](day-03/README.md#tabela-de-flavors-cap)
- [O que mudou depois da concepção do CAP?](day-03/README.md#o-que-mudou-depois-da-concepção-do-cap)
- [Teorema PACELC](day-03/README.md#teorema-pacelc)
- [O Teorema PACELC](day-03/README.md#o-teorema-pacelc)
  - [Teorema PACELC vs Teorema CAP](day-03/README.md#teorema-pacelc-vs-teorema-cap)
- [Aplicações do PACELC](day-03/README.md#aplicações-do-pacelc)
  - [PA/EL (On Partition, Availability; Else, Latency)](day-03/README.md#pael-on-partition-availability-else-latency)
  - [PC/EL (On Partition, Consistency; Else, Latency)](day-03/README.md#pcel-on-partition-consistency-else-latency)
  - [PA/EC (On Partition, Availability; Else, Consistency)](day-03/README.md#paec-on-partition-availability-else-consistency)
  - [PC/EC (On Partition, Consistency; Else, Consistency)](day-03/README.md#pcec-on-partition-consistency-else-consistency)
  - [Comparações do PACELC](day-03/README.md#comparações-do-pacelc)
- [Referências](day-03/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-04 - Databases, Modelos de Dados e Indexação</summary>

- [Databases, Modelos de Dados e Indexação](day-04/README.md#databases-modelos-de-dados-e-indexação)
- [Definindo um Banco de Dados](day-04/README.md#definindo-um-banco-de-dados)
- [Tipos de Bancos de Dados](day-04/README.md#tipos-de-bancos-de-dados)
  - [Bancos de Dados Relacionais SQL](day-04/README.md#bancos-de-dados-relacionais-sql)
  - [Banco de Dados Não-Relacionais NoSQL](day-04/README.md#banco-de-dados-não-relacionais-nosql)
  - [Bancos de Dados NewSQL](day-04/README.md#bancos-de-dados-newsql)
  - [Bancos de Dados em Memória](day-04/README.md#bancos-de-dados-em-memória)
  - [Time-Series Databases](day-04/README.md#time-series-databases)
- [Níveis de Consistência](day-04/README.md#níveis-de-consistência)
  - [Consistência Forte](day-04/README.md#consistência-forte)
  - [Consistência Eventual](day-04/README.md#consistência-eventual)
- [Modelos de Dados](day-04/README.md#modelos-de-dados)
  - [Modelos de Tuplas (Row‑Oriented)](day-04/README.md#modelos-de-tuplas-roworiented)
  - [Modelos de Documentos](day-04/README.md#modelos-de-documentos)
  - [Modelos Colunares (Column-Oriented)](day-04/README.md#modelos-colunares-column-oriented)
  - [Modelos de Coluna Larga (Wide-Column)](day-04/README.md#modelos-de-coluna-larga-wide-column)
  - [Modelos Key‑Value (Chave‑Valor)](day-04/README.md#modelos-keyvalue-chavevalor)
  - [Modelos Baseados em Grafos](day-04/README.md#modelos-baseados-em-grafos)
- [Armazenamento e Indexação](day-04/README.md#armazenamento-e-indexação)
  - [Page Size (Tamanho da Página)](day-04/README.md#page-size-tamanho-da-página)
  - [Indexação Colunar](day-04/README.md#indexação-colunar)
  - [LSM-Trees (Log-Structured Merge-Tree)](day-04/README.md#lsm-trees-log-structured-merge-tree)
  - [Indexação B‑Tree (Árvores B)](day-04/README.md#indexação-btree-árvores-b)
  - [Indexação por Hashing](day-04/README.md#indexação-por-hashing)
  - [Índices Invertidos](day-04/README.md#índices-invertidos)
- [Arquitetura](day-04/README.md#arquitetura)
  - [Cenários Transacionais](day-04/README.md#cenários-transacionais)
  - [Cenários de Write‑Intensive](day-04/README.md#cenários-de-writeintensive)
  - [Cenários de Read‑Intensive](day-04/README.md#cenários-de-readintensive)
- [Referências](day-04/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-05 - Estratégias de Cache</summary>

- [Estratégias de Cache](day-05/README.md#estratégias-de-cache)
- [Definindo Cache](day-05/README.md#definindo-cache)
- [Princípios Básicos de Cache](day-05/README.md#princípios-básicos-de-cache)
  - [Consistência de Dados](day-05/README.md#consistência-de-dados)
  - [Time to Live (TTL)](day-05/README.md#time-to-live-ttl)
  - [Políticas de Evicção e Substituição](day-05/README.md#políticas-de-evicção-e-substituição)
  - [Invalidação de Itens em Cache](day-05/README.md#invalidação-de-itens-em-cache)
  - [Eventos de Hit Rate, Cache Hit e Cache Miss](day-05/README.md#eventos-de-hit-rate-cache-hit-e-cache-miss)
    - [Cache Hit](day-05/README.md#cache-hit)
    - [Cache Miss](day-05/README.md#cache-miss)
    - [Hit Rate - Taxa de Acertos](day-05/README.md#hit-rate---taxa-de-acertos)
- [Implementações de Cache](day-05/README.md#implementações-de-cache)
  - [Cache em Memória (Hashmap)](day-05/README.md#cache-em-memória-hashmap)
  - [Caching em Sistemas Distribuídos](day-05/README.md#caching-em-sistemas-distribuídos)
  - [Cache em Bancos de Dados e Camadas de Dados](day-05/README.md#cache-em-bancos-de-dados-e-camadas-de-dados)
  - [Cache-Aside (Lazy Loading)](day-05/README.md#cache-aside-lazy-loading)
  - [Write-Through (Escrita Dupla)](day-05/README.md#write-through-escrita-dupla)
  - [Write-Behind (Lazy Writing)](day-05/README.md#write-behind-lazy-writing)
  - [Cache de Conteúdo Distribuído (CDN Cache)](day-05/README.md#cache-de-conteúdo-distribuído-cdn-cache)
    - [Primeiro Acesso](day-05/README.md#primeiro-acesso)
    - [Segundo Acesso](day-05/README.md#segundo-acesso)
- [Referencias](day-05/README.md#referencias)

</details>

&nbsp;

<details>
<summary>DAY-06 - Monolitos, Microserviços e Domínios</summary>

- [System Design - Microsserviços, Monolitos e Domínios](day-06/README.md#system-design---microsserviços-monolitos-e-domínios)
- [Arquitetura Monolítica](day-06/README.md#arquitetura-monolítica)
  - [Vantagens de uma Arquitetura Monolítica](day-06/README.md#vantagens-de-uma-arquitetura-monolítica)
  - [Desvantagens de uma Arquitetura Monolítica](day-06/README.md#desvantagens-de-uma-arquitetura-monolítica)
- [Arquitetura de Microsserviços](day-06/README.md#arquitetura-de-microsserviços)
  - [Vantagens de uma Arquitetura de Microsserviços](day-06/README.md#vantagens-de-uma-arquitetura-de-microsserviços)
  - [Desvantagens de uma Arquitetura de Microsserviços](day-06/README.md#desvantagens-de-uma-arquitetura-de-microsserviços)
- [Domínios e Design](day-06/README.md#domínios-e-design)
- [Lei de Conway na arquitetura de sistemas](day-06/README.md#lei-de-conway-na-arquitetura-de-sistemas)
- [Referências](day-06/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-07 - Load Balancers e Proxies Reversos</summary>

- [System Design - Load Balancers e Proxies Reversos](day-07/README.md#system-design---load-balancers-e-proxies-reversos)
    - [O Problema da Falta de Balanceamento de Carga](day-07/README.md#o-problema-da-falta-de-balanceamento-de-carga)
    - [Resolvendo problemas com balanceamento de carga](day-07/README.md#resolvendo-problemas-com-balanceamento-de-carga)
- [Fundamentos de Balanceadores de Carga](day-07/README.md#fundamentos-de-balanceadores-de-carga)
  - [Proxy Reverso vs Load Balancer](day-07/README.md#proxy-reverso-vs-load-balancer)
  - [O Papel do Load Balancer](day-07/README.md#o-papel-do-load-balancer)
- [Algoritmos de Balanceamento de Carga](day-07/README.md#algoritmos-de-balanceamento-de-carga)
  - [Round Robin](day-07/README.md#round-robin)
    - [Limitações do Round Robin](day-07/README.md#limitações-do-round-robin)
    - [Exemplo de um Algoritmo de Round Robin](day-07/README.md#exemplo-de-um-algoritmo-de-round-robin)
  - [Least Request](day-07/README.md#least-request)
    - [Limitações do Least Request](day-07/README.md#limitações-do-least-request)
    - [Exemplo de Implementação](day-07/README.md#exemplo-de-implementação)
  - [Least Connection](day-07/README.md#least-connection)
    - [Limitações do Least Connection](day-07/README.md#limitações-do-least-connection)
  - [Least Outstanding Requests (LOR)](day-07/README.md#least-outstanding-requests-lor)
    - [Limitações do Least Outstanding Requests](day-07/README.md#limitações-do-least-outstanding-requests)
  - [IP Hash Balancing](day-07/README.md#ip-hash-balancing)
    - [Limitações ao Implementar a Técnica de IP Hashing](day-07/README.md#limitações-ao-implementar-a-técnica-de-ip-hashing)
    - [Exemplo de Implementação](day-07/README.md#exemplo-de-implementação-1)
  - [Maglev](day-07/README.md#maglev)
    - [Limitações do Maglev](day-07/README.md#limitações-do-maglev)
  - [Random Load Balancing](day-07/README.md#random-load-balancing)
    - [Limitações do Random](day-07/README.md#limitações-do-random)
- [Load Balancing e Camada OSI](day-07/README.md#load-balancing-e-camada-osi)
  - [Load Balancers em Layer 4 (Transporte)](day-07/README.md#load-balancers-em-layer-4-transporte)
  - [Load Balancers em Layer 7 (Aplicação)](day-07/README.md#load-balancers-em-layer-7-aplicação)
- [Implementações e Tecnologias](day-07/README.md#implementações-e-tecnologias)
    - [Envoy Proxy](day-07/README.md#envoy-proxy)
    - [Nginx](day-07/README.md#nginx)
    - [HAProxy](day-07/README.md#haproxy)
    - [Traefik](day-07/README.md#traefik)
    - [Kubernetes Ingress Controllers](day-07/README.md#kubernetes-ingress-controllers)
      - [Cloud Load Balancers](day-07/README.md#cloud-load-balancers)
- [Referencias](day-07/README.md#referencias)

</details>

&nbsp;

<details>
<summary>DAY-08 - API Gateways</summary>

- [System Design - API Gateways](day-08/README.md#system-design---api-gateways)
- [Definindo API Gateways](day-08/README.md#definindo-api-gateways)
  - [O problema que os API Gateways resolvem?](day-08/README.md#o-problema-que-os-api-gateways-resolvem)
- [API Gateways em Arquiteturas de Microserviços](day-08/README.md#api-gateways-em-arquiteturas-de-microserviços)
- [API Gateways e Load Balancers](day-08/README.md#api-gateways-e-load-balancers)
- [Componentes e Arquitetura de um API Gateway](day-08/README.md#componentes-e-arquitetura-de-um-api-gateway)
  - [Roteamento de Requisições](day-08/README.md#roteamento-de-requisições)
  - [Autenticação e Autorização](day-08/README.md#autenticação-e-autorização)
  - [Limitação de Taxa (Rate Limiting) e Throttling](day-08/README.md#limitação-de-taxa-rate-limiting-e-throttling)
    - [Rate Limit](day-08/README.md#rate-limit)
    - [Throttling](day-08/README.md#throttling)
    - [Token Bucket](day-08/README.md#token-bucket)
    - [Leaky Buckets](day-08/README.md#leaky-buckets)
  - [Gerenciamento de APIs e Versionamento](day-08/README.md#gerenciamento-de-apis-e-versionamento)
    - [Referências](day-08/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-09 - Backend for Frontend (BFF)</summary>

- [System Design - Backend for Frontend (BFF)](day-09/README.md#system-design---backend-for-frontend-bff)
- [Definindo Backend for Frontends](day-09/README.md#definindo-backend-for-frontends)
- [Responsabilidades Arquiteturais](day-09/README.md#responsabilidades-arquiteturais)
  - [API Composition Pattern nos BFF’s](day-09/README.md#api-composition-pattern-nos-bffs)
  - [Segregação de Canais com BFF’s](day-09/README.md#segregação-de-canais-com-bffs)
  - [Segregação de Microfrontends e BFF’s](day-09/README.md#segregação-de-microfrontends-e-bffs)
  - [Versionamento de Interfaces e BFF’s](day-09/README.md#versionamento-de-interfaces-e-bffs)
  - [Resiliência e Blast Radius em BFF’s](day-09/README.md#resiliência-e-blast-radius-em-bffs)
  - [Desacoplamento de Métricas e Experiência de Uso](day-09/README.md#desacoplamento-de-métricas-e-experiência-de-uso)
    - [Referências](day-09/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-10 - Service Mesh</summary>

- [System Design - Service Mesh](day-10/README.md#system-design---service-mesh)
- [Definindo Service Mesh](day-10/README.md#definindo-service-mesh)
- [Componentes de um Service Mesh](day-10/README.md#componentes-de-um-service-mesh)
  - [Control Plane (Camada de Controle)](day-10/README.md#control-plane-camada-de-controle)
  - [Data Plane (Camada de Execução)](day-10/README.md#data-plane-camada-de-execução)
- [Modelos de Service Mesh](day-10/README.md#modelos-de-service-mesh)
  - [Modelo Client e Server](day-10/README.md#modelo-client-e-server)
  - [Sidecars](day-10/README.md#sidecars)
  - [Sidecarless / Proxyless](day-10/README.md#sidecarless--proxyless)
- [Funcionalidades Comuns dos Service Meshes](day-10/README.md#funcionalidades-comuns-dos-service-meshes)
  - [Roteamento de Tráfego Inteligente](day-10/README.md#roteamento-de-tráfego-inteligente)
  - [Balanceamento de Carga Dinâmico](day-10/README.md#balanceamento-de-carga-dinâmico)
  - [Observabilidade e Telemetria Transparente](day-10/README.md#observabilidade-e-telemetria-transparente)
  - [Segurança, Autenticação e Autorização](day-10/README.md#segurança-autenticação-e-autorização)
  - [Criptografia de Tráfego e mTLS](day-10/README.md#criptografia-de-tráfego-e-mtls)
  - [Resiliência na Camada de Comunicação](day-10/README.md#resiliência-na-camada-de-comunicação)
- [Referências](day-10/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-11 - Conceitos de Concorrência e Paralelismo</summary>

- [System Design - Paralelismo, Concorrência e Multithreading](day-11/README.md#system-design---paralelismo-concorrência-e-multithreading)
  - [O que é um Processo?](day-11/README.md#o-que-é-um-processo)
  - [O que é uma Thread?](day-11/README.md#o-que-é-uma-thread)
  - [O que é Multithreading?](day-11/README.md#o-que-é-multithreading)
- [Concorrência](day-11/README.md#concorrência)
    - [Exemplo de Implementação](day-11/README.md#exemplo-de-implementação)
- [Paralelismo](day-11/README.md#paralelismo)
    - [Implementando um algoritmo de paralelismo](day-11/README.md#implementando-um-algoritmo-de-paralelismo)
  - [Paralelismo Externo vs Paralelismo Interno](day-11/README.md#paralelismo-externo-vs-paralelismo-interno)
    - [Paralelismo Interno](day-11/README.md#paralelismo-interno)
    - [Paralelismo Externo](day-11/README.md#paralelismo-externo)
- [Paralelismo vs Concorrência](day-11/README.md#paralelismo-vs-concorrência)
- [Lidando com Paralelismo e Concorrência](day-11/README.md#lidando-com-paralelismo-e-concorrência)
    - [Deadlocks e Starvation](day-11/README.md#deadlocks-e-starvation)
  - [Race Conditions - Condições de Corrida](day-11/README.md#race-conditions---condições-de-corrida)
    - [Race Conditions e Last-Write-Wins](day-11/README.md#race-conditions-e-last-write-wins)
  - [Mutex](day-11/README.md#mutex)
  - [Mutex Distribuído](day-11/README.md#mutex-distribuído)
    - [Exemplo de Implementação](day-11/README.md#exemplo-de-implementação-1)
  - [Mutex Distribuído - Zookeeper](day-11/README.md#mutex-distribuído---zookeeper)
    - [Exemplo de Implementação](day-11/README.md#exemplo-de-implementação-2)
  - [Spinlock](day-11/README.md#spinlock)
    - [Exemplo de Implementação](day-11/README.md#exemplo-de-implementação-3)
  - [Semáforos e Worker Pools](day-11/README.md#semáforos-e-worker-pools)
    - [Exemplo de Implementação:](day-11/README.md#exemplo-de-implementação-4)
- [Referências](day-11/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-12 - Padrões de Comunicação Síncronos</summary>

- [System Design - Padrões de Comunicação Síncronos](day-12/README.md#system-design---padrões-de-comunicação-síncronos)
- [Definindo Comunicações Sincronas](day-12/README.md#definindo-comunicações-sincronas)
- [API’s REST - Representational State Transfer](day-12/README.md#apis-rest---representational-state-transfer)
  - [Componentes de uma requisição REST](day-12/README.md#componentes-de-uma-requisição-rest)
    - [URI’s e URL’s](day-12/README.md#uris-e-urls)
      - [URI - Uniform Resource Identifier](day-12/README.md#uri---uniform-resource-identifier)
      - [URL - Uniform Resource Locator](day-12/README.md#url---uniform-resource-locator)
    - [Recursos e Paths](day-12/README.md#recursos-e-paths)
    - [Headers](day-12/README.md#headers)
    - [Query Strings](day-12/README.md#query-strings)
    - [Body e Formatos](day-12/README.md#body-e-formatos)
    - [Utilização de Métodos HTTP para Representar Ações nos Paths](day-12/README.md#utilização-de-métodos-http-para-representar-ações-nos-paths)
      - [Idempotência nas Requisições REST](day-12/README.md#idempotência-nas-requisições-rest)
    - [Métodos HTTP nas URI’s e Recursos](day-12/README.md#métodos-http-nas-uris-e-recursos)
      - [Status Codes de Resposta e Padrões do REST](day-12/README.md#status-codes-de-resposta-e-padrões-do-rest)
  - [Principios do REST](day-12/README.md#principios-do-rest)
    - [Interface Uniforme](day-12/README.md#interface-uniforme)
    - [Comunicação Stateless](day-12/README.md#comunicação-stateless)
    - [Camadas](day-12/README.md#camadas)
    - [Cache](day-12/README.md#cache)
- [Webhooks](day-12/README.md#webhooks)
    - [Pooling e a Diferença entre Webhooks e API’s](day-12/README.md#pooling-e-a-diferença-entre-webhooks-e-apis)
- [RPC - Remote Procedure Call](day-12/README.md#rpc---remote-procedure-call)
    - [Exemplo de um Servidor RPC](day-12/README.md#exemplo-de-um-servidor-rpc)
    - [Exemplo de um Client RPC](day-12/README.md#exemplo-de-um-client-rpc)
- [gRPC - Google Remote Procedure Call](day-12/README.md#grpc---google-remote-procedure-call)
  - [ProtoBufs](day-12/README.md#protobufs)
    - [Exemplo de Protobuf](day-12/README.md#exemplo-de-protobuf)
    - [Exemplo de Server gRPC](day-12/README.md#exemplo-de-server-grpc)
    - [Exemplo de Client gRPC](day-12/README.md#exemplo-de-client-grpc)
- [Websockets](day-12/README.md#websockets)
- [GraphQL](day-12/README.md#graphql)
  - [Componentes do GraphQL](day-12/README.md#componentes-do-graphql)
    - [Schema](day-12/README.md#schema)
    - [Query](day-12/README.md#query)
    - [Mutations](day-12/README.md#mutations)
    - [Resolvers e Data Sources](day-12/README.md#resolvers-e-data-sources)
  - [Convergência de Arquiteturas gRPC \& REST \& GraphQL](day-12/README.md#convergência-de-arquiteturas-grpc--rest--graphql)
- [Referências](day-12/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-13 - Protocolos de Comunicação Assincronos</summary>

- [System Design - Mensageria, Eventos, Streaming e Arquitetura Assincrona](day-13/README.md#system-design---mensageria-eventos-streaming-e-arquitetura-assincrona)
  - [Mensagens e Eventos](day-13/README.md#mensagens-e-eventos)
    - [Definindo Mensageria](day-13/README.md#definindo-mensageria)
    - [Definindo Eventos](day-13/README.md#definindo-eventos)
  - [Eventos vs Mensagens](day-13/README.md#eventos-vs-mensagens)
    - [Eventos São Mensagens](day-13/README.md#eventos-são-mensagens)
  - [Conceitos e Padrões](day-13/README.md#conceitos-e-padrões)
    - [FIFO e Queues - First In First Out](day-13/README.md#fifo-e-queues---first-in-first-out)
        - [Output:](day-13/README.md#output)
    - [LIFO e Stacks - Last In First Out](day-13/README.md#lifo-e-stacks---last-in-first-out)
        - [Output:](day-13/README.md#output-1)
    - [Fanout](day-13/README.md#fanout)
    - [DLQ - Dead Letter Queues](day-13/README.md#dlq---dead-letter-queues)
    - [Processamento em Batch](day-13/README.md#processamento-em-batch)
  - [Protocolos e Arquiteturas Event-Driven](day-13/README.md#protocolos-e-arquiteturas-event-driven)
    - [Streaming e Reatividade](day-13/README.md#streaming-e-reatividade)
    - [Reatividade e Arquiteturas Event-Driven](day-13/README.md#reatividade-e-arquiteturas-event-driven)
  - [Kafka e Event Streaming](day-13/README.md#kafka-e-event-streaming)
    - [Clusters e Brokers](day-13/README.md#clusters-e-brokers)
    - [Tópicos](day-13/README.md#tópicos)
    - [Partições](day-13/README.md#partições)
    - [Fatores de Replicação](day-13/README.md#fatores-de-replicação)
    - [Producers](day-13/README.md#producers)
        - [Exemplo de Produtor](day-13/README.md#exemplo-de-produtor)
    - [Consumers e Consumer Groups](day-13/README.md#consumers-e-consumer-groups)
        - [Exemplo de um consumidor](day-13/README.md#exemplo-de-um-consumidor)
        - [Output](day-13/README.md#output-2)
  - [Protocolos e Arquiteturas de Message-Driven](day-13/README.md#protocolos-e-arquiteturas-de-message-driven)
    - [MQTT (Message Queuing Telemetry Transport)](day-13/README.md#mqtt-message-queuing-telemetry-transport)
    - [MQTT Default Subscription](day-13/README.md#mqtt-default-subscription)
    - [MQTT Shared Subscription](day-13/README.md#mqtt-shared-subscription)
  - [AMQP (Advanced Message Queuing Protocol)](day-13/README.md#amqp-advanced-message-queuing-protocol)
    - [Brokers](day-13/README.md#brokers)
    - [Channels](day-13/README.md#channels)
    - [Queues](day-13/README.md#queues)
    - [Producers](day-13/README.md#producers-1)
    - [Consumers](day-13/README.md#consumers)
    - [Exchanges e Binding Keys](day-13/README.md#exchanges-e-binding-keys)
    - [Tipos de Exchanges](day-13/README.md#tipos-de-exchanges)
      - [Direct Exchange](day-13/README.md#direct-exchange)
        - [Setup e Binding no Modo Direct](day-13/README.md#setup-e-binding-no-modo-direct)
        - [Producer no Modo Direct](day-13/README.md#producer-no-modo-direct)
        - [Output](day-13/README.md#output-3)
        - [Consumer no Modo Direct](day-13/README.md#consumer-no-modo-direct)
        - [Output](day-13/README.md#output-4)
      - [Topic Exchange](day-13/README.md#topic-exchange)
        - [Setup e Binding no Topic](day-13/README.md#setup-e-binding-no-topic)
        - [Producer no Modo Topic](day-13/README.md#producer-no-modo-topic)
        - [Output - Produtor](day-13/README.md#output---produtor)
        - [Output - Consumidor Default](day-13/README.md#output---consumidor-default)
        - [Output - Consumidor Prioritario](day-13/README.md#output---consumidor-prioritario)
        - [Output - Consumidor Lake](day-13/README.md#output---consumidor-lake)
      - [Fanout Exchange](day-13/README.md#fanout-exchange)
        - [Setup no Fanout](day-13/README.md#setup-no-fanout)
        - [Producer no Fanout](day-13/README.md#producer-no-fanout)
        - [Output - Produtor](day-13/README.md#output---produtor-1)
        - [Output - Consumidor Cobranca](day-13/README.md#output---consumidor-cobranca)
        - [Output - Consumidor Logistica](day-13/README.md#output---consumidor-logistica)
        - [Output - Consumidor Estoque](day-13/README.md#output---consumidor-estoque)
- [Referências](day-13/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-14 -Performance, Capacidade e Escalabilidade</summary>

- [System Design - Performance, Capacidade e Escalabilidade](day-14/README.md#system-design---performance-capacidade-e-escalabilidade)
- [Definindo Performance](day-14/README.md#definindo-performance)
  - [Métricas de Performance](day-14/README.md#métricas-de-performance)
    - [Utilização e Saturação de Recursos](day-14/README.md#utilização-e-saturação-de-recursos)
    - [Throughput, ou Tráfego](day-14/README.md#throughput-ou-tráfego)
    - [Tempo de Resposta](day-14/README.md#tempo-de-resposta)
    - [Taxa de Erros](day-14/README.md#taxa-de-erros)
    - [Utilizando Percentis em Métricas de Performance](day-14/README.md#utilizando-percentis-em-métricas-de-performance)
- [Definindo Capacidade](day-14/README.md#definindo-capacidade)
  - [Gargalos de Capacidade](day-14/README.md#gargalos-de-capacidade)
  - [Backpressure de Capacidade](day-14/README.md#backpressure-de-capacidade)
  - [Custo de Transação por Capacidade](day-14/README.md#custo-de-transação-por-capacidade)
- [Definindo Escalabilidade](day-14/README.md#definindo-escalabilidade)
  - [Importância da Escalabilidade em Sistemas Modernos](day-14/README.md#importância-da-escalabilidade-em-sistemas-modernos)
  - [Escalabilidade Vertical e Escalabilidade Horizontal](day-14/README.md#escalabilidade-vertical-e-escalabilidade-horizontal)
    - [Escalabilidade Vertical](day-14/README.md#escalabilidade-vertical)
      - [Scale Up e Scale Down](day-14/README.md#scale-up-e-scale-down)
    - [Escalabilidade Horizontal](day-14/README.md#escalabilidade-horizontal)
      - [Scale Out e Scale In](day-14/README.md#scale-out-e-scale-in)
- [Planejamento de Capacidade e Escalabilidade](day-14/README.md#planejamento-de-capacidade-e-escalabilidade)
  - [Fórmula Básica para Capacidade](day-14/README.md#fórmula-básica-para-capacidade)
  - [Utilização de Recursos Computacionais](day-14/README.md#utilização-de-recursos-computacionais)
  - [Requisições e Transações por Períodos de Tempo (Throughput)](day-14/README.md#requisições-e-transações-por-períodos-de-tempo-throughput)
  - [Escalabilidade de Software](day-14/README.md#escalabilidade-de-software)
- [Referências](day-14/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-15 -Scale Cube</summary>

- [System Design - Scale Cube](day-15/README.md#system-design---scale-cube)
  - [Eixo X - Escalabilidade Horizontal](day-15/README.md#eixo-x---escalabilidade-horizontal)
  - [Eixo Y - Quebra de Funcionalidades](day-15/README.md#eixo-y---quebra-de-funcionalidades)
  - [Eixo Z - Sharding de Dados](day-15/README.md#eixo-z---sharding-de-dados)
    - [Uso do Scale Cube](day-15/README.md#uso-do-scale-cube)
    - [Referências](day-15/README.md#referências)

</details>


&nbsp;


<details>
<summary>DAY-16 - Sharding e Particionamento de Dados</summary>

- [System Design - Sharding e Particionamento de Dados](day-16/README.md#system-design---sharding-e-particionamento-de-dados)
- [Definindo Sharding](day-16/README.md#definindo-sharding)
  - [Topologia de Sharding](day-16/README.md#topologia-de-sharding)
    - [Sharding para Segregação de Dados](day-16/README.md#sharding-para-segregação-de-dados)
    - [Sharding para Segregação Computacional](day-16/README.md#sharding-para-segregação-computacional)
- [Escalabilidade e Performance](day-16/README.md#escalabilidade-e-performance)
- [Sharding Keys e Hot Partitions](day-16/README.md#sharding-keys-e-hot-partitions)
  - [Sharding Keys](day-16/README.md#sharding-keys)
  - [Hot Partitions](day-16/README.md#hot-partitions)
- [Estratégias e Aplicações de Sharding](day-16/README.md#estratégias-e-aplicações-de-sharding)
  - [Sharding por ranges de iniciais](day-16/README.md#sharding-por-ranges-de-iniciais)
  - [Sharding por Ranges de Identificadores](day-16/README.md#sharding-por-ranges-de-identificadores)
  - [Sharding por Ranges de Datas e Tiers de Storage](day-16/README.md#sharding-por-ranges-de-datas-e-tiers-de-storage)
  - [Sharding por Hashing](day-16/README.md#sharding-por-hashing)
      - [Exemplo de Balanceamento por Hash Functions](day-16/README.md#exemplo-de-balanceamento-por-hash-functions)
      - [Output](day-16/README.md#output)
    - [Distribuição e os Algoritmos de Hashing](day-16/README.md#distribuição-e-os-algoritmos-de-hashing)
      - [Output](day-16/README.md#output-1)
  - [Sharding e Distribuição por MurmurHash](day-16/README.md#sharding-e-distribuição-por-murmurhash)
      - [Output](day-16/README.md#output-2)
  - [Sharding por Hashing Consistente](day-16/README.md#sharding-por-hashing-consistente)
  - [Sharding por Hashing e Gestão de Chaves](day-16/README.md#sharding-por-hashing-e-gestão-de-chaves)
  - [Segregação Avançada com Suffle Sharding](day-16/README.md#segregação-avançada-com-suffle-sharding)
      - [Referencias](day-16/README.md#referencias)

</details>

&nbsp;

<details>
<summary>DAY-17 - Replicação de Dados</summary>

- [System Design - Replicação de Dados](day-17/README.md#system-design---replicação-de-dados)
- [Definindo Replicação na Engenharia de Software](day-17/README.md#definindo-replicação-na-engenharia-de-software)
- [Modelos de Replicação](day-17/README.md#modelos-de-replicação)
  - [Replicação Primary-Replica](day-17/README.md#replicação-primary-replica)
  - [Replicação Primary-Primary - Multi-Master](day-17/README.md#replicação-primary-primary---multi-master)
- [Estratégias de Replicação](day-17/README.md#estratégias-de-replicação)
  - [Replicação Total e Parcial](day-17/README.md#replicação-total-e-parcial)
  - [Replicação Síncrona](day-17/README.md#replicação-síncrona)
  - [Replicação Assíncrona](day-17/README.md#replicação-assíncrona)
  - [Replicação Semi-Síncrona](day-17/README.md#replicação-semi-síncrona)
  - [Replicação por Logs](day-17/README.md#replicação-por-logs)
- [Arquitetura](day-17/README.md#arquitetura)
  - [Event-Carried State Transfer - Replicação de Estados e Objetos de Domínios](day-17/README.md#event-carried-state-transfer---replicação-de-estados-e-objetos-de-domínios)
  - [Replicação por Change Data Capture - Captura de Alterações em Dados](day-17/README.md#replicação-por-change-data-capture---captura-de-alterações-em-dados)
  - [CRDT’s - Conflict Free Replicated Data Types](day-17/README.md#crdts---conflict-free-replicated-data-types)
- [Referências](day-17/README.md#referências)

</details>

&nbsp;


<details>
<summary>DAY-18 - CQRS (Command Query Responsability Segregation)</summary>

- [System Design - CQRS (Command Query Responsability Segregation)](day-18/README.md#system-design---cqrs-command-query-responsability-segregation)
- [Definindo CQRS](day-18/README.md#definindo-cqrs)
  - [Separação de Responsabilidades](day-18/README.md#separação-de-responsabilidades)
    - [Perspectiva sobre Modelos de Domínio](day-18/README.md#perspectiva-sobre-modelos-de-domínio)
- [Modelos de Implementação](day-18/README.md#modelos-de-implementação)
  - [CQRS em bancos SQL e Views Materializadas](day-18/README.md#cqrs-em-bancos-sql-e-views-materializadas)
      - [Output](day-18/README.md#output)
    - [Consistência Eventual no CQRS](day-18/README.md#consistência-eventual-no-cqrs)
  - [CQRS e Réplicas de Leitura](day-18/README.md#cqrs-e-réplicas-de-leitura)
  - [CQRS e Bancos de Dados NoSQL](day-18/README.md#cqrs-e-bancos-de-dados-nosql)
  - [CQRS em Sistemas Distribuídos](day-18/README.md#cqrs-em-sistemas-distribuídos)
    - [Pattern de Dual-Write no Contexto de CQRS](day-18/README.md#pattern-de-dual-write-no-contexto-de-cqrs)
    - [Outbox Pattern no Contexto de CQRS](day-18/README.md#outbox-pattern-no-contexto-de-cqrs)
- [Referencias](day-18/README.md#referencias)

</details>



&nbsp;


<details>
<summary>DAY-19 - Saga Pattern</summary>

- [System Design - Saga Pattern](day-19/README.md#system-design---saga-pattern)
- [O que é o modelo SAGA?](day-19/README.md#o-que-é-o-modelo-saga)
  - [A Origem Histórica do Saga Pattern](day-19/README.md#a-origem-histórica-do-saga-pattern)
- [O problema de lidar com transações distribuídas](day-19/README.md#o-problema-de-lidar-com-transações-distribuídas)
- [O problema de lidar com transações longas](day-19/README.md#o-problema-de-lidar-com-transações-longas)
- [A Proposta de Transações Saga](day-19/README.md#a-proposta-de-transações-saga)
  - [Modelo Orquestrado](day-19/README.md#modelo-orquestrado)
    - [Modelo de Comando / Resposta em Transações Saga](day-19/README.md#modelo-de-comando--resposta-em-transações-saga)
  - [Modelo Coreografado](day-19/README.md#modelo-coreografado)
- [Adoções Arquiteturais](day-19/README.md#adoções-arquiteturais)
  - [Maquinas de Estado no Modelo Saga](day-19/README.md#maquinas-de-estado-no-modelo-saga)
    - [Transições de Estados da Saga](day-19/README.md#transições-de-estados-da-saga)
    - [Ciclo de Vida da Saga](day-19/README.md#ciclo-de-vida-da-saga)
  - [Logs de Saga e Rastreabilidade da Transação](day-19/README.md#logs-de-saga-e-rastreabilidade-da-transação)
  - [Modelos de Ação e Compensação no Saga Pattern](day-19/README.md#modelos-de-ação-e-compensação-no-saga-pattern)
  - [Problemas de Dual Write em Transações Saga](day-19/README.md#problemas-de-dual-write-em-transações-saga)
    - [Outbox Pattern e Change Data Capture em Transações Saga](day-19/README.md#outbox-pattern-e-change-data-capture-em-transações-saga)
    - [Two-Phase Commit em Transações Saga](day-19/README.md#two-phase-commit-em-transações-saga)
  - [Mecanismos de Reinicialização de Saga](day-19/README.md#mecanismos-de-reinicialização-de-saga)
- [Referências](day-19/README.md#referências)

</details>


&nbsp;

<details>
<summary>DAY-20 - Event Sourcing</summary>

- [System Design - Event Sourcing](day-20/README.md#system-design---event-sourcing)
- [Definindo Event Sourcing](day-20/README.md#definindo-event-sourcing)
- [Persistência Tradicional e Event Sourcing](day-20/README.md#persistência-tradicional-e-event-sourcing)
- [Arquitetura Event-Sourcing](day-20/README.md#arquitetura-event-sourcing)
  - [Agregados](day-20/README.md#agregados)
  - [Event Store](day-20/README.md#event-store)
  - [Event-Bus e Publishers](day-20/README.md#event-bus-e-publishers)
  - [Projections e Modelos de Leitura](day-20/README.md#projections-e-modelos-de-leitura)
    - [Projections e Read Models Transacionais](day-20/README.md#projections-e-read-models-transacionais)
    - [Projections e Read Models Semi-Síncronos](day-20/README.md#projections-e-read-models-semi-síncronos)
    - [Projections e Read Models Assíncronos](day-20/README.md#projections-e-read-models-assíncronos)
- [Reconstituição de Estados e Rehydration](day-20/README.md#reconstituição-de-estados-e-rehydration)
  - [Snapshotting](day-20/README.md#snapshotting)
- [Versionamento e Garantias de Ordem em Consistência Eventual (Last-Write-Wins)](day-20/README.md#versionamento-e-garantias-de-ordem-em-consistência-eventual-last-write-wins)
- [Idempotência em Domínios Complexos](day-20/README.md#idempotência-em-domínios-complexos)
- [Referências](day-20/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-21 - Padrões de Resiliência</summary>

- [System Design - Padrões de Resiliência](day-21/README.md#system-design---padrões-de-resiliência)
- [Definindo Resiliência](day-21/README.md#definindo-resiliência)
  - [Resiliência e Disponibilidade](day-21/README.md#resiliência-e-disponibilidade)
  - [Métricas de Resiliência e Disponibilidade](day-21/README.md#métricas-de-resiliência-e-disponibilidade)
    - [Métrica de Disponibilidade de Uso](day-21/README.md#métrica-de-disponibilidade-de-uso)
    - [Métrica de Disponibilidade de Uptime](day-21/README.md#métrica-de-disponibilidade-de-uptime)
  - [Blast Radius](day-21/README.md#blast-radius)
  - [Estratégias e Patterns de Resiliência](day-21/README.md#estratégias-e-patterns-de-resiliência)
  - [Replicação de Serviços, Balanceamento de Carga e Healthchecks](day-21/README.md#replicação-de-serviços-balanceamento-de-carga-e-healthchecks)
  - [Idempotência](day-21/README.md#idempotência)
    - [Chaves de Idempotência](day-21/README.md#chaves-de-idempotência)
  - [Timeouts](day-21/README.md#timeouts)
  - [Estratégias de Retry (Retentativas)](day-21/README.md#estratégias-de-retry-retentativas)
    - [Retries Imediatos em Memória](day-21/README.md#retries-imediatos-em-memória)
    - [Retries Assíncronos](day-21/README.md#retries-assíncronos)
    - [Retries com Backoff Exponencial](day-21/README.md#retries-com-backoff-exponencial)
    - [Retries com Estratégias de Jitter](day-21/README.md#retries-com-estratégias-de-jitter)
  - [Circuit Breakers](day-21/README.md#circuit-breakers)
  - [Throttling e Rate Limiting](day-21/README.md#throttling-e-rate-limiting)
  - [Padrões de Fallback](day-21/README.md#padrões-de-fallback)
    - [Exemplo: Fallback Sistêmico por Redundância](day-21/README.md#exemplo-fallback-sistêmico-por-redundância)
    - [Exemplo: Fallback com Snapshot de Dados](day-21/README.md#exemplo-fallback-com-snapshot-de-dados)
    - [Exemplo: Fallback com Fluxos Assíncronos](day-21/README.md#exemplo-fallback-com-fluxos-assíncronos)
    - [Exemplo: Fallback Contratual](day-21/README.md#exemplo-fallback-contratual)
    - [Acionamento de Fallback Proativo](day-21/README.md#acionamento-de-fallback-proativo)
  - [Graceful Degradation](day-21/README.md#graceful-degradation)
  - [Backpressure como Resiliência](day-21/README.md#backpressure-como-resiliência)
  - [Resiliência na Camada de Dados](day-21/README.md#resiliência-na-camada-de-dados)
    - [Read-Write Splitting](day-21/README.md#read-write-splitting)
    - [Caching de Dados como Resiliência](day-21/README.md#caching-de-dados-como-resiliência)
  - [Sharding e Particionamento de Clientes em Resiliência](day-21/README.md#sharding-e-particionamento-de-clientes-em-resiliência)
  - [Bulkhead Pattern](day-21/README.md#bulkhead-pattern)
  - [Lease Pattern](day-21/README.md#lease-pattern)
- [Referências](day-21/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-22 - Estratégias de Deployment</summary>

- [System Design -  Estratégias de Deployment](day-22/README.md#system-design----estratégias-de-deployment)
- [Definindo um Deployment](day-22/README.md#definindo-um-deployment)
- [Rollbacks de Versões](day-22/README.md#rollbacks-de-versões)
- [Estratégias de Deployments](day-22/README.md#estratégias-de-deployments)
  - [Big Bang Deployments](day-22/README.md#big-bang-deployments)
  - [Rolling Updates](day-22/README.md#rolling-updates)
  - [Blue-Green Deployments](day-22/README.md#blue-green-deployments)
  - [Canary Releases](day-22/README.md#canary-releases)
  - [Migrations e Versionamento de Schemas](day-22/README.md#migrations-e-versionamento-de-schemas)
  - [Shadow Deployment e Mirror Traffic](day-22/README.md#shadow-deployment-e-mirror-traffic)
  - [Feature Flags](day-22/README.md#feature-flags)
    - [Clustering e Segregação de Segmentos](day-22/README.md#clustering-e-segregação-de-segmentos)
  - [Sharding deployment](day-22/README.md#sharding-deployment)
    - [Referências](day-22/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-23 - Capacity Planning e a Teoria das Filas</summary>

- [System Design - Capacity Planning e a Teoria das Filas](day-23/README.md#system-design---capacity-planning-e-a-teoria-das-filas)
- [Teoria das Filas](day-23/README.md#teoria-das-filas)
  - [A Lei de Little na Teoria das Filas](day-23/README.md#a-lei-de-little-na-teoria-das-filas)
    - [Lei de Little e o “Ponto Saudável”](day-23/README.md#lei-de-little-e-o-ponto-saudável)
    - [Knee Curve (Curva do Joelho)](day-23/README.md#knee-curve-curva-do-joelho)
    - [Margens Seguras de Saturação](day-23/README.md#margens-seguras-de-saturação)
  - [Modelagem de Carga](day-23/README.md#modelagem-de-carga)
    - [Transações por Segundo](day-23/README.md#transações-por-segundo)
    - [Processos Concorrentes](day-23/README.md#processos-concorrentes)
    - [Tamanho de Payload](day-23/README.md#tamanho-de-payload)
    - [Cálculos de Estimativa de Carga](day-23/README.md#cálculos-de-estimativa-de-carga)
      - [Estimativa de Transações por Segundo](day-23/README.md#estimativa-de-transações-por-segundo)
      - [TPS Sistêmico](day-23/README.md#tps-sistêmico)
      - [Estimativa de Tamanho de Payload](day-23/README.md#estimativa-de-tamanho-de-payload)
      - [Estimativa de Bytes de Uma Transação](day-23/README.md#estimativa-de-bytes-de-uma-transação)
      - [Estimativa de Banda pelo Payload e Transações por Segundo](day-23/README.md#estimativa-de-banda-pelo-payload-e-transações-por-segundo)
    - [Perfis de Tráfego](day-23/README.md#perfis-de-tráfego)
      - [Perfil Diário](day-23/README.md#perfil-diário)
      - [Perfil Semanal](day-23/README.md#perfil-semanal)
      - [Perfil Sazonal](day-23/README.md#perfil-sazonal)
    - [Projeção de Crescimento](day-23/README.md#projeção-de-crescimento)
      - [Crescimento Linear](day-23/README.md#crescimento-linear)
      - [Crescimento Não Linear](day-23/README.md#crescimento-não-linear)
      - [Crescimento Mediante Novas Features e Eventos de Negócio](day-23/README.md#crescimento-mediante-novas-features-e-eventos-de-negócio)
    - [Capacidade End to End (E2E)](day-23/README.md#capacidade-end-to-end-e2e)
      - [Throughput individual](day-23/README.md#throughput-individual)
      - [Throughput sistêmico](day-23/README.md#throughput-sistêmico)
      - [Dependência do Gargalo](day-23/README.md#dependência-do-gargalo)
- [Planejamento de Capacidade](day-23/README.md#planejamento-de-capacidade)
  - [Delimitar o Fluxo, Funcionalidades e Componentes](day-23/README.md#delimitar-o-fluxo-funcionalidades-e-componentes)
  - [Levantar as Estimativas de Carga](day-23/README.md#levantar-as-estimativas-de-carga)
  - [Identificação do Throughput Individual dos Componentes e Serviços](day-23/README.md#identificação-do-throughput-individual-dos-componentes-e-serviços)
  - [Derivação do Throughput Sistêmico](day-23/README.md#derivação-do-throughput-sistêmico)
  - [Levantamento da Projeção de Crescimento](day-23/README.md#levantamento-da-projeção-de-crescimento)
  - [Avaliar o Custo e as Margens Operacionais](day-23/README.md#avaliar-o-custo-e-as-margens-operacionais)
  - [Definição dos Limites Operacionais](day-23/README.md#definição-dos-limites-operacionais)
  - [Testes de Carga e Estresse](day-23/README.md#testes-de-carga-e-estresse)
- [Referências](day-23/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-24 - Testes de Carga e Estresse</summary>

- [System Design - Testes de Carga e Estresse](day-24/README.md#system-design---testes-de-carga-e-estresse)
- [Introdução](day-24/README.md#introdução)
  - [A importância dos testes de performance](day-24/README.md#a-importância-dos-testes-de-performance)
  - [A importância de conhecer comportamentos do sistema](day-24/README.md#a-importância-de-conhecer-comportamentos-do-sistema)
  - [Testes de Performance em Build e Run](day-24/README.md#testes-de-performance-em-build-e-run)
- [Testes de Carga e Estresse](day-24/README.md#testes-de-carga-e-estresse)
- [Tipos de Teste](day-24/README.md#tipos-de-teste)
  - [Teste de Fumaça, Smoke Tests](day-24/README.md#teste-de-fumaça-smoke-tests)
  - [Teste de Average Load](day-24/README.md#teste-de-average-load)
  - [Testes de Estresse](day-24/README.md#testes-de-estresse)
  - [Testes de Spike](day-24/README.md#testes-de-spike)
  - [Testes de Breakpoint](day-24/README.md#testes-de-breakpoint)
- [Respondendo a Perguntas Chave](day-24/README.md#respondendo-a-perguntas-chave)
    - [Qual é o trafego esperado do meu sistema hoje?](day-24/README.md#qual-é-o-trafego-esperado-do-meu-sistema-hoje)
    - [Quais são meus objetivos de tempo de resposta, taxa de erros e saturação?](day-24/README.md#quais-são-meus-objetivos-de-tempo-de-resposta-taxa-de-erros-e-saturação)
    - [Qual é o trafego esperado do meu sistema em períodos de pico?](day-24/README.md#qual-é-o-trafego-esperado-do-meu-sistema-em-períodos-de-pico)
    - [Quais os protocolos e estímulos que minha aplicação é exposta?](day-24/README.md#quais-os-protocolos-e-estímulos-que-minha-aplicação-é-exposta)
    - [Qual é a expectativa de crescimento do meu sistema?](day-24/README.md#qual-é-a-expectativa-de-crescimento-do-meu-sistema)
    - [Qual é o cenário mais extremo que o sistema enfrentará?](day-24/README.md#qual-é-o-cenário-mais-extremo-que-o-sistema-enfrentará)
  - [Quais são as funcionalidades principais que precisam ser testadas?](day-24/README.md#quais-são-as-funcionalidades-principais-que-precisam-ser-testadas)
  - [Quais são as jornadas comuns do usuário?](day-24/README.md#quais-são-as-jornadas-comuns-do-usuário)
  - [Quais os endpoints mais utilizados? E quais os mais caros?](day-24/README.md#quais-os-endpoints-mais-utilizados-e-quais-os-mais-caros)
  - [Métricas em Testes de Performance](day-24/README.md#métricas-em-testes-de-performance)
    - [Service Levels como objetivos esperados](day-24/README.md#service-levels-como-objetivos-esperados)
- [Estratégias de pré-teste](day-24/README.md#estratégias-de-pré-teste)
  - [Avaliando a capacidade individual de cada réplica](day-24/README.md#avaliando-a-capacidade-individual-de-cada-réplica)
  - [Validação de unidade assíncrona](day-24/README.md#validação-de-unidade-assíncrona)
- [Ferramental para Testes](day-24/README.md#ferramental-para-testes)
  - [Grafana K6](day-24/README.md#grafana-k6)
  - [Locust](day-24/README.md#locust)
  - [Apache JMeter](day-24/README.md#apache-jmeter)
  - [Gatling](day-24/README.md#gatling)
  - [Oha / Ohayou](day-24/README.md#oha--ohayou)
- [Modelo de Roteiro de Teste](day-24/README.md#modelo-de-roteiro-de-teste)
  - [Relatório de Teste de Performance - Produto de Cobrança de Vendas - Time de Engenharia](day-24/README.md#relatório-de-teste-de-performance---produto-de-cobrança-de-vendas---time-de-engenharia)
  - [1. Visão Geral](day-24/README.md#1-visão-geral)
  - [2. Objetivos do Teste](day-24/README.md#2-objetivos-do-teste)
    - [Metas:](day-24/README.md#metas)
  - [3. Cenários de Teste](day-24/README.md#3-cenários-de-teste)
    - [3.0. Pré-teste](day-24/README.md#30-pré-teste)
    - [3.1. Cenário 1: Carga Média (Average Load)](day-24/README.md#31-cenário-1-carga-média-average-load)
    - [3.2. Cenário 2: Carga de Pico (Spike Test)](day-24/README.md#32-cenário-2-carga-de-pico-spike-test)
    - [3.3. Cenário 3: Stress Test](day-24/README.md#33-cenário-3-stress-test)
    - [3.4. Cenário 4: Breakpoint](day-24/README.md#34-cenário-4-breakpoint)
- [Referências](day-24/README.md#referências)

</details>


&nbsp;

<details>
<summary>DAY-25 - Bulkhead Pattern</summary>

- [System Design - Bulkhead Pattern](day-25/README.md#system-design---bulkhead-pattern)
- [Definindo Bulkheads](day-25/README.md#definindo-bulkheads)
  - [Bulkheads e a Engenharia Naval](day-25/README.md#bulkheads-e-a-engenharia-naval)
  - [Bulkheads e a Arquitetura de Software](day-25/README.md#bulkheads-e-a-arquitetura-de-software)
- [Implementações e Contenção de Falhas](day-25/README.md#implementações-e-contenção-de-falhas)
  - [Recursos Lógicos](day-25/README.md#recursos-lógicos)
  - [Recursos Físicos](day-25/README.md#recursos-físicos)
- [Distribuição de Bulkheads e Blast Radius](day-25/README.md#distribuição-de-bulkheads-e-blast-radius)
- [Bulkheads e Shardings](day-25/README.md#bulkheads-e-shardings)
  - [Bulkheads de Sharding Funcional](day-25/README.md#bulkheads-de-sharding-funcional)
  - [Bulkheads de Sharding Operacional](day-25/README.md#bulkheads-de-sharding-operacional)
- [Arquiteturas de Bulkheads](day-25/README.md#arquiteturas-de-bulkheads)
  - [Bulkheads por Priorização](day-25/README.md#bulkheads-por-priorização)
  - [Bulkheads por Criticidade](day-25/README.md#bulkheads-por-criticidade)
  - [Bulkheads por Tipo de Uso](day-25/README.md#bulkheads-por-tipo-de-uso)
  - [Bulkheads por Segmento](day-25/README.md#bulkheads-por-segmento)
  - [Bulkheads por Hashing Consistente](day-25/README.md#bulkheads-por-hashing-consistente)
  - [Bulkheads por Tenants](day-25/README.md#bulkheads-por-tenants)
    - [Noisy Neighbor e Bulkheads Tenants](day-25/README.md#noisy-neighbor-e-bulkheads-tenants)
- [Referências](day-25/README.md#referências)

</details>

&nbsp;

<details>
<summary>DAY-26 - Cell Based Pattern</summary>

-

</details>

&nbsp;

# Materiais
| Aula | Slides | Artigo Original |
| --- | --- | --- |
| Protocolos de Rede | [Slides](./day-01/01%20-%20System%20Design%20-%20Protocolos%20de%20Rede.pdf) | [Artigo](https://fidelissauro.dev/protocolos-de-rede/) |
| Raid e Storage     | [Slides](./day-02/02%20-%20System%20Design%20-%20Raid%20e%20Storage.pdf) | [Artigo](https://fidelissauro.dev/storage/) |
| Teorema CAP, Database ACID, BASE e Teorema PACELC | [Slides](./day-03/03%20-%20System%20Design%20-%20Teorema%20CAP.pdf) | [Artigo](https://fidelissauro.dev/teorema-cap/) |
| Databases, Modelos de Dados e Indexação | [Slides](./day-04/04%20-%20System%20Design%20-%20Databases.pdf) | [Artigo](https://fidelissauro.dev/databases/) |
| Estratégias de Cache | [Slides](./day-05/05%20-%20System%20Design%20-%20Cache.pdf) | [Artigo](https://fidelissauro.dev/caching/) |
| Monolitos, Microserviços e Domínios | [Slides](./day-06/06%20-%20System%20Design%20-%20Microserviços%20e%20Monolitos.pdf) | [Artigo](https://fidelissauro.dev/monolitos-microservicos/) |
| Load Balancers e Proxies Reversos | [Slides](./day-07/07%20-%20System%20Design%20-%20Load%20Balancers%20e%20Proxies%20Reversos.pdf) | [Artigo](https://fidelissauro.dev/load-balancing/) |
| API Gateways | [Slides](./day-08/08%20-%20System%20Design%20-%20API%20Gateways.pdf) | [Artigo](https://fidelissauro.dev/api-gateways) |
| Backend for Frontend (BFF) | [Slides](./day-09/09%20-%20System%20Design%20-%20BFF's.pdf) | [Artigo](https://fidelissauro.dev/bffs) |
| Service Mesh | [Slides](./day-10/10%20-%20System%20Design%20-%20Service%20Mesh.pdf) | [Artigo](https://fidelissauro.dev/service-mesh) |
| Conceitos de Concorrência e Paralelismo | [Slides](./day-11/11%20-%20System%20Design%20-%20Concorrencia%20a%20Paralelismo.pdf) | [Artigo](https://fidelissauro.dev/concorrencia-paralelismo/) |
| Padrões de Comunicação Síncronos | [Slides](./day-12/12%20-%20System%20Design%20-%20Comunicação%20Sincrona.pdf) | [Artigo](https://fidelissauro.dev/padroes-de-comunicacao-sincronos/) |
| Protocolos de Comunicação Assincronos | [Slides](./day-13/13%20-%20System%20Design%20-%20Comunicação%20Assincrona.pdf) | [Artigo](https://fidelissauro.dev/mensageria-eventos-streaming/) |
| Performance, Capacidade e Escalabilidade | [Slides](./day-14/14%20-%20System%20Design%20-%20Escalabilidade,%20Performance%20e%20Capacity.pdf) | [Artigo](https://fidelissauro.dev/performance-capacidade-escalabilidade/) |
| The Scale Cube | [Slides](./day-15/15%20-%20System%20Design%20-%20Scale%20Cube.pdf) | [Artigo](https://fidelissauro.dev/cubo-escalabilidade/) |
| Conceitos de Sharding e Particionamento | [Slides](./day-16/16%20-%20System%20Design%20-%20Sharding.pdf) | [Artigo](https://fidelissauro.dev/sharding/) |
| Conceitos de Replicação de Dados | [Slides](./day-17/17%20-%20System%20Design%20-%20Replicação.pdf) | [Artigo](https://fidelissauro.dev/replicacao/) |
| CQRS | [Slides](./day-18/18%20-%20System%20Design%20-%20CQRS.pdf) | [Artigo](https://fidelissauro.dev/cqrs/) |
| Saga Pattern | [Slides](./day-19/19%20-%20System%20Design%20-%20Saga%20Pattern.pdf) | [Artigo](https://fidelissauro.dev/saga-pattern/) |
| Event Sourcing | [Slides](./day-20/20%20-%20System%20Design%20-%20Event%20Sourcing.pdf) | [Artigo](https://fidelissauro.dev/event-sourcing/) |
| Patterns de Resiliência | [Slides](./day-21/21%20-%20System%20Design%20-%20Patterns%20de%20Resiliência.pdf) | [Artigo](https://fidelissauro.dev/resiliencia/) |
| Estratégias de Deploy | [Slides](./day-22/22%20-%20System%20Design%20-%20Estratégias%20de%20Deploy.pdf) | [Artigo](https://fidelissauro.dev/deployment-strategies/) |
| Capacity Planning e Teoria das Filas | - | [Artigo](https://fidelissauro.dev/capacity-planning/) |
| Testes de Carga e Estresse | [Slides](./day-24/24%20-%20System%20Design%20-%20Load%20Tests%20.pdf) | [Artigo](https://fidelissauro.dev/load-testing/) |
| Bulkhead Pattern | [Slides](./day-25/25%20-%20System%20Design%20-%20Bulkhead.pdf) | [Artigo](https://fidelissauro.dev/bulkheads/) |
| Cell Based Pattern | [Slides](./day-26/26%20-%20System%20Design%20-%20Cell%20Based%20Pattern.pdf) | - |



# Book de Cases e Exercícios Livres 


| Case | Nível | Link |
|------|-------|------|
| DDD - Core Banking | Basico | [Link](/cases/BASICO_DDD_CORE_BANKING.md) |
| DDD - Banco da Federação Galática | Avançado | [Link](/cases/AVANCADO_DDD_BANCO_FEDERACAO_GALATICA.md) |
| DDD - FoodTech | Basico / Intermediário | [Link](/cases/BASICO_DDD_FOODTECH.md) |
| Case e Catálogo de Marketplace | Basico | [Link](/cases/BASICO_CATALOGO.md) | 
| Checkout de Livraria | Basico | [Link](/cases/BASICO_CHECKOUT_LIVRARIA.md) |
| Encurtador de Links | Basico | [Link](/cases/BASICO_ENCURTADOR_DE_LINKS.md) |
| FoodTech | Intermediário | [Link](/cases/INTERMEDIARIO_DELIVERY.md) |
| Orquestrador de Notificações Omnichannel para E-commerce | Intermediário | [Link](/cases/INTERMEDIARIO_OMNI_CHANNEL.md) |
| Case de Consistência com SAGA Pattern | Intermediário | [Link](/cases/INTERMEDIARIO_SAGA.md) |
| Case de Ledger REST | Avançado | [Link](/cases/AVANCADO_LEDGER_REST.md) |
| Gestão de Pacotes e Beneficios | Avançado | [Link](/cases/AVANCADO_PACOTES_BENEFICIOS.md) |
| Adaptação de Apostilas | Avançado | [Link](/cases/AVANCADO_RENDERIZACAO_APOSTILAS.md) |
| Sistema de Contestação de Compras | Intermediário | [Link](/cases/INTERMEDIARIO_CONTESTACAO_COMPRAS.md) |
| Sistema de Gestão de Pontos | Intermediário | [Link](/cases/INTERMEDIARIO_SISTEMA_DE_PONTOS.md) | 
| Sistema de Votação de Reality Shows | Intermediário | [Link](/cases/INTERMEDIARIO_VOTACAO.md) |
| Sistema Distribuído de Gestão de Estoque para Varejo | Intermediário | [Link](/cases/INTERMEDIARIO_ESTOQUE.md)   |
| Ingestão e Telemetria | Avançado | [Link](/cases/AVANCADO_TELEMETRIA_LOGISTICA.md) |
| Gestão de Vagas   | Avançado  | [Link](/cases/AVANCADO_CADASTRO_VAGAS.md) |
| Controle de Ponto | Intermediário  | [Link](/cases/INTERMEDIARIO_GESTAO_DE_PONTO.md) | 


## Cases Resolvidos 

| Case                  | Link                                                                  |
|-----------------------|-----------------------------------------------------------------------|
| Encurtador de Links   | [Draw.io](/cases/resolucao/T1-Case-encurtador-de-links-basico.drawio)   |
| Busca e Catalogo      | [Draw.io](/cases/resolucao/T1-Case-Busca-Ecommerce.drawio)               |
| Notificação Omnichannel | [Draw.io](/cases/resolucao/T1-Case-Omnichannel.drawio)                 |
| Sistema de Votação    | [Draw.io](/cases/resolucao/T1-Case-Vota-AI.drawio.xml)                  |
| Sistema de Votação    | [Draw.io](/cases/resolucao/T1-Case-Vota-AI.drawio.xml)                  |
| Orquestrador de Notificações Omnichannel para E-commerce | [Draw.io](/cases/resolucao/T2-Case-Busca-Ecommerce.drawio.xml) |
