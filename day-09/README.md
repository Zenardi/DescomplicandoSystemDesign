# System Design - Backend for Frontend (BFF)

- [System Design - Backend for Frontend (BFF)](#system-design---backend-for-frontend-bff)
- [Definindo Backend for Frontends](#definindo-backend-for-frontends)
- [Responsabilidades Arquiteturais](#responsabilidades-arquiteturais)
  - [API Composition Pattern nos BFF’s](#api-composition-pattern-nos-bffs)
  - [Segregação de Canais com BFF’s](#segregação-de-canais-com-bffs)
  - [Segregação de Microfrontends e BFF’s](#segregação-de-microfrontends-e-bffs)
  - [Versionamento de Interfaces e BFF’s](#versionamento-de-interfaces-e-bffs)
  - [Resiliência e Blast Radius em BFF’s](#resiliência-e-blast-radius-em-bffs)
  - [Desacoplamento de Métricas e Experiência de Uso](#desacoplamento-de-métricas-e-experiência-de-uso)
    - [Referências](#referências)

> **Nota:** Este documento é um material de estudo baseado no artigo original
> **"System Design - Backend for Frontend (BFF)"**, de **Matheus Fidelis**,
> publicado em [fidelissauro.dev/bffs](https://fidelissauro.dev/bffs).
> As ilustrações pertencem ao autor original. Recomenda-se a leitura do artigo
> completo na fonte.

---

![System Design - Backend for Frontend (BFF)](images/capa-bff.png)

Este capítulo retoma o tema das estratégias de exposição de serviços, já visto em outros cenários, agora sob a ótica de um padrão que simplifica a conversa entre frontends e múltiplos backends de forma performática. O foco recai sobre os BFFs (Backend for Frontends). Diferente de outras abordagens de exposição que buscam um ponto único de contato visando performance e governança, os BFFs trazem características mais simples e moldadas sob medida para o par cliente-serviço que de fato consome cada interface.

# Definindo Backend for Frontends

O BFF é um padrão arquitetural que cria backends especializados para cada tipo de frontend. A ideia parte da constatação de que um cliente mobile carrega requisitos de negócio, segurança e escalabilidade distintos dos de um cliente web ou de uma API pública. Em vez de um backend único atendendo a todos os clientes, separamos aplicações dedicadas que intermediam e tratam de forma específica cada modo de consumo.

Vale destacar a distinção em relação à infraestrutura. Componentes como [API Gateways](https://fidelissauro.dev/api-gateway/) e [balanceadores de carga e proxies reversos](https://fidelissauro.dev/load-balancing/) são peças de infraestrutura cuja função é desacoplar backends e expor uma interface unificada para vários microsserviços. Já o BFF é uma aplicação completa, com suas próprias preocupações de capacidade, escalabilidade e segurança — e pode inclusive operar como backend por trás desses componentes de infraestrutura.

# Responsabilidades Arquiteturais

O BFF introduz um serviço intermediário cuja missão é simplificar a integração entre o frontend e os microsserviços necessários para concluir uma operação solicitada pelo cliente. A esse serviço podem ser delegadas diversas responsabilidades: autenticação, autorização, acesso a cache, chamadas a múltiplos serviços, composição de payloads, aplicação de filtros, adaptação de contratos (renomear campos, formatar dados), ordenação de listas e disparo de fallbacks quando preciso.

Ao mover essas tarefas e complexidades — antes concentradas no cliente — para o BFF, ganhamos código mais limpo, responsabilidades bem delimitadas, performance otimizada e isolamento entre os canais de frontend, sejam eles IoT, mobile, páginas web ou dispositivos domésticos inteligentes.

## API Composition Pattern nos BFF’s

O API Composition Pattern consiste em consolidar várias chamadas a serviços backend distintos em um único ponto de entrada. Trazendo essa lógica para dentro do BFF, o canal de consumo precisa fazer apenas uma requisição. Internamente, o BFF dispara os demais requests, agrega e formata os payloads e devolve ao cliente a resposta já no formato esperado.

![API Composition](images/api-composition.drawio.png)

O ganho é duplo: reduzimos a latência de rede entre cliente e múltiplos servidores e enxugamos o código do frontend. Além disso, abrimos espaço para transformações como remoção de campos sensíveis, enriquecimento de dados ou ordenação específica, tudo sem expor ao usuário a complexidade do ecossistema de microsserviços.

## Segregação de Canais com BFF’s

Na adoção de BFFs, partimos do princípio de que cada canal — desktop, web, mobile (iOS, Android) ou dispositivos de IoT e domésticos — pode ter exigências próprias de formato de dados, volume de transações, comportamento e cache. Segregar canais em BFFs distintos significa manter instâncias e versões independentes por perfil de cliente, de modo que cada BFF conheça a jornada e os fluxos específicos do seu público.

![BFF Canais](images/bff-canais.drawio.png)

Com isso evitamos condicionais complicadas no código e atendemos cada canal pelo que ele realmente precisa. Um canal Web pode servir conteúdo via SSR (Server-Side Rendering), gerir sessão em cache centralizado (por exemplo, Memcached) e autenticar via tokens JWT, oferecendo mais funcionalidades. Um canal Mobile tende a exigir respostas enxutas, compressão mais agressiva e sincronização offline. Um canal de IoT ou de eletrodomésticos precisa lidar com conexões intermitentes, usar protocolos como [MQTT e WebSockets](https://fidelissauro.dev/mensageria-eventos-streaming/) e dar atenção criteriosa à segurança e privacidade dos dados. Todos esses casos se beneficiam de interfaces dedicadas, materializadas como seus respectivos Backends for Frontends.

## Segregação de Microfrontends e BFF’s

Em projetos que fragmentam a camada de visualização em microfrontends, cada módulo independente é mantido por um time com responsabilidades próprias. Nesse arranjo faz sentido criar BFFs coesos e exclusivos por microfrontend, dando a cada equipe autonomia sobre sua funcionalidade. O BFF de cada módulo age como um mini-orquestrador independente, responsável por carregar e formatar os dados necessários — de widgets e dashboards a notificações e operações de CRUD — sem vazar a complexidade dos microsserviços "core" para o resto da aplicação.

![Microfrontends](images/bff-microfrontends.drawio.png)

Essa estratégia, mais indicada para projetos de grande porte que reforçam a [Lei de Conway](https://fidelissauro.dev/monolitos-microservicos/), fortalece o conceito de times "end-to-end", em que cada equipe domina toda a jornada da feature — do microfrontend ao seu backend dedicado — garantindo alinhamento entre UI e APIs. Como bônus, frontend e backend podem ser isolados em uma mesma unidade de deployment, permitindo subir os dois ao mesmo tempo e fazer rollback da mesma forma.

## Versionamento de Interfaces e BFF’s

![Flag](images/flag.drawio.png)

Quando bem aplicado e desacoplado, o BFF facilita testar novas versões de produtos e até descontinuar versões legadas. Com [feature toggles e deployments inteligentes](https://fidelissauro.dev/deployment-strategies/), é possível manter várias versões do BFF em produção e alternar quais estão ativas ou inativas. Ao lançar uma nova versão de feature, produto ou frontend, podemos criar um BFF dedicado àquela versão, viabilizando experimentações controladas com públicos específicos sem recorrer a toggles extras ou condicionais complexas.

## Resiliência e Blast Radius em BFF’s

Embora os BFFs sejam segregados por canal, eles ainda costumam compartilhar muitos serviços de backend, sobretudo em sistemas distribuídos. Por isso, cada implementação deve garantir por padrão os [patterns de resiliência](https://fidelissauro.dev/resiliencia/) em relação às suas dependências: Circuit Breakers, acionamento inteligente de fallbacks e camadas de controle de timeouts e retries.

![BFF Error](images/bff-error.drawio.png)

O conceito de blast radius em BFFs trata do alcance de uma falha: mesmo com BFFs separados por canal, todos podem ser afetados se dependerem do mesmo serviço crítico. Para limitar esse raio de impacto, trabalhamos com [unidades de deployment independentes](https://fidelissauro.dev/deployment-strategies/) e bulkheads lógicos, isolando grupos de chamadas e restringindo a falha a um subconjunto de funcionalidades. Deployments canary ou blue-green ajudam a validar novas versões em fatias pequenas de tráfego antes de afetar toda a base. Combinando essas estratégias, entregamos uma camada de canal próxima do altamente disponível e tolerante a falhas, preservando a experiência do usuário mesmo diante de instabilidades no backend.

## Desacoplamento de Métricas e Experiência de Uso

![BFF Metricas](images/bff-metricas.drawio.png)

Adotar o padrão BFF permite separar a coleta e o tratamento de métricas da experiência direta do usuário. Como a camada de contato com os serviços de downstream fica segregada por canal, podemos desacoplar as métricas e analisar a experiência de cada segmento de uso de forma independente, definindo Service Levels próprios para cada um. Isso ajuda a identificar, por exemplo, se a experiência do canal mobile está sendo impactada pelo volume de outras interfaces como a Web. Ainda que a maior parte dos serviços de downstream seja compartilhada, conseguimos capturar volume, error rate e tempo de resposta por tipo de canal.

### Referências

[Backend For Frontend: Uma estratégia sob medida para a entrega de microsserviços](https://medium.com/jeitosanar/backend-for-frontend-uma-estrat%C3%A9gia-sob-demanda-para-a-entrega-de-microsservi%C3%A7os-2f12d4cb9e3f)

[Arquitetura BFF — Back-end for Front-end](https://medium.com/digitalproductsdev/arquitetura-bff-back-end-for-front-end-13e2cbfbcda2)

[Pattern: Backends For Frontends](https://samnewman.io/patterns/architectural/bff/)

[Backend for Frontend Pattern](https://www.geeksforgeeks.org/backend-for-frontend-pattern/)
