# Descomplicando System Design


<details>
<summary>DAY-01 - Protocolos de Rede</summary>

* [System Design - Protocolos e Comunicação de Rede](day-01/README.md#system-design---protocolos-e-comunicação-de-rede)
* [Modelo OSI](day-01/README.mdday-01/README.md#modelo-osi)
   * [Camada 1: Física](day-01/README.mdday-01/README.md#camada-1-física)
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

# Materiais
| Aula | Slides | 
| --- | --- |
| Protocolos de Rede | [Slides](./day-01/01%20-%20System%20Design%20-%20Protocolos%20de%20Rede.pdf) |
| Raid e Storage     | [Slides](./day-02/02%20-%20System%20Design%20-%20Raid%20e%20Storage.pdf) |


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