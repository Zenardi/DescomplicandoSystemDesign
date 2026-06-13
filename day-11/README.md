# System Design - Paralelismo, Concorrência e Multithreading

- [System Design - Paralelismo, Concorrência e Multithreading](#system-design---paralelismo-concorrência-e-multithreading)
  - [O que é um Processo?](#o-que-é-um-processo)
  - [O que é uma Thread?](#o-que-é-uma-thread)
  - [O que é Multithreading?](#o-que-é-multithreading)
- [Concorrência](#concorrência)
    - [Exemplo de Implementação](#exemplo-de-implementação)
- [Paralelismo](#paralelismo)
    - [Implementando um algoritmo de paralelismo](#implementando-um-algoritmo-de-paralelismo)
  - [Paralelismo Externo vs Paralelismo Interno](#paralelismo-externo-vs-paralelismo-interno)
    - [Paralelismo Interno](#paralelismo-interno)
    - [Paralelismo Externo](#paralelismo-externo)
- [Paralelismo vs Concorrência](#paralelismo-vs-concorrência)
- [Lidando com Paralelismo e Concorrência](#lidando-com-paralelismo-e-concorrência)
    - [Deadlocks e Starvation](#deadlocks-e-starvation)
  - [Race Conditions - Condições de Corrida](#race-conditions---condições-de-corrida)
    - [Race Conditions e Last-Write-Wins](#race-conditions-e-last-write-wins)
  - [Mutex](#mutex)
  - [Mutex Distribuído](#mutex-distribuído)
    - [Exemplo de Implementação](#exemplo-de-implementação-1)
  - [Mutex Distribuído - Zookeeper](#mutex-distribuído---zookeeper)
    - [Exemplo de Implementação](#exemplo-de-implementação-2)
  - [Spinlock](#spinlock)
    - [Exemplo de Implementação](#exemplo-de-implementação-3)
  - [Semáforos e Worker Pools](#semáforos-e-worker-pools)
    - [Exemplo de Implementação:](#exemplo-de-implementação-4)
- [Referências](#referências)

> **Nota:** Este documento é um material de estudo baseado no artigo original
> **"System Design - Paralelismo, Concorrência e Multithreading"**, de
> **Matheus Fidelis**, publicado em
> [fidelissauro.dev/concorrencia-paralelismo](https://fidelissauro.dev/concorrencia-paralelismo/).
> As ilustrações pertencem ao autor original. Recomenda-se a leitura do artigo
> completo na fonte.

---

Este é o primeiro texto de uma série dedicada a System Design, escrita com a
proposta de traduzir conceitos densos de computação para uma linguagem direta e
acessível, independentemente da senioridade de quem lê. A intenção é reforçar
fundamentos de ciências da computação e de arquitetura de forma prática.

Ao longo dos textos, analogias com situações do cotidiano são usadas para
aproximar a teoria da intuição. Neste material, o foco recai sobre três pilares:
multithreading, concorrência e paralelismo. O objetivo não é esgotar a
literatura formal, mas garantir que o leitor compreenda, aplique e consiga
explicar esses conceitos a outras pessoas.

Os exemplos de código usam a linguagem `Go`, recorrendo a recursos nativos como
`Goroutines`, `Channels` e `WaitGroups`. Ainda assim, a abordagem é conceitual:
as ideias podem ser transpostas para outros contextos e linguagens.

## O que é um Processo?

Um processo é a instância em execução de um programa. Enquanto o programa é o
conjunto de instruções estático, o processo é essas instruções efetivamente
rodando — é o programa em ação.

Quando abrimos aplicativos como navegador, IDE, bancos de dados ou serviços
diversos, o sistema operacional cria um processo para cada um. Ele provê os
recursos necessários para a execução: espaço de memória isolado, threads,
contextos e o gerenciamento de todo o ciclo de vida daquele processo.

## O que é uma Thread?

A thread é a menor unidade de processamento que o sistema operacional consegue
escalonar. Representa uma sequência de instruções capaz de ser executada de
forma independente em um núcleo de CPU. Dentro de um mesmo processo, várias
threads podem trabalhar de modo concorrente, melhorando a eficiência — enquanto
uma thread aguarda uma operação demorada (como uma requisição HTTP), outras
podem seguir executando.

Threads de um mesmo programa compartilham o espaço de memória e os recursos
alocados. Em máquinas com múltiplas CPUs ou múltiplos núcleos, threads distintas
podem rodar simultaneamente em núcleos diferentes, viabilizando o paralelismo
real. Pense nas threads como pequenas tarefas que precisam ser realizadas em um
churrasco.

## O que é Multithreading?

Multithreading é a técnica de criar múltiplos fluxos de execução independentes
(threads) dentro de um único processo, cada um responsável por uma tarefa ou
parte de uma tarefa maior. A técnica serve tanto a contextos concorrentes quanto
paralelos.

Em CPUs de núcleo único, o multithreading viabiliza a concorrência: a alternância
rápida entre threads cria a ilusão de simultaneidade. Já em sistemas com vários
núcleos, é possível alcançar paralelismo verdadeiro, com threads executando ao
mesmo tempo em núcleos distintos, otimizando recursos e desempenho.

Uma boa analogia é o restaurante no horário de pico: o processo é o restaurante
funcionando, e as threads são os cozinheiros. Cada cozinheiro prepara um prato
diferente ao mesmo tempo, acelerando o atendimento e reduzindo a espera dos
clientes.

# Concorrência

Concorrência diz respeito a lidar com várias tarefas ao mesmo tempo, porém sem
que elas sejam executadas de forma simultânea. É a capacidade de uma aplicação
gerenciar múltiplas tarefas em um mesmo núcleo, mesmo que essas instruções não
estejam, de fato, sendo processadas no mesmo instante.

![Concorrencia](images/concorrencia.drawio.png)

Um sistema concorrente intercala (interleaving) múltiplas unidades de execução —
threads ou processos — permitindo que diferentes partes do programa avancem de
forma independente em um mesmo core. A CPU alterna rapidamente entre tarefas, o
que chamamos de context switching.

![Concorrência Robô](images/concurrency-example.png)

Imagine preparar um churrasco sozinho: organizar a geladeira, cortar a carne,
preparar os vegetais, fazer caipirinhas e gelar a cerveja. Você se reveza entre
todas essas atividades, trabalhando um pouco em cada uma. É concorrência — você
gerencia várias tarefas e cria a impressão de que tudo progride ao mesmo tempo,
mesmo sem atuar em mais de uma simultaneamente.

### Exemplo de Implementação

O exemplo demonstra, em Go, como modelar o churrasco com concorrência: as
atividades são listadas, cada uma é disparada em uma goroutine que aguarda seu
próprio tempo de preparo, e a conclusão de todas é monitorada por meio de um
channel. A saída mostra que as tarefas começam praticamente juntas e terminam em
ordem não determinística, conforme cada tempo de preparo se encerra,
evidenciando o caráter intercalado da concorrência.

[Exemplo de Concorrencia - Go Playground](https://go.dev/play/p/d7HzIKIRnD0)

# Paralelismo

![Paralelismo Robô](images/paralelism-example.png)

Continuando no churrasco, agora você tem amigos ajudando: um corta a carne,
outro acende a churrasqueira, outro gela a cerveja e outro faz a caipirinha.
Todas essas atividades acontecem de fato ao mesmo tempo, cada pessoa cuidando de
uma parte do processo. Isso é paralelismo: múltiplas tarefas ocorrendo
simultaneamente, executadas por vários núcleos de processamento.

Diferentemente da concorrência — em que se gerencia várias tarefas mas só uma
está ativa por vez — o paralelismo significa realmente fazer várias coisas ao
mesmo tempo. Ele é empregado quando desempenho e eficiência são críticos e há
recursos suficientes, como múltiplos núcleos de CPU.

Em ambientes paralelos, processos e threads precisam coordenar ações e se
comunicar. Mecanismos de sincronização como semáforos, mutexes e monitores são
essenciais para evitar race conditions e garantir consistência, ainda que isso
adicione complexidade à programação e ao debugging.

O paralelismo permanece como área ativa de pesquisa, evoluindo junto às novas
arquiteturas de hardware e à crescente demanda por processamento de grandes
volumes de dados e computação de alto desempenho.

### Implementando um algoritmo de paralelismo

O exemplo simula o churrasco sob paralelismo real. O algoritmo identifica
quantos amigos (CPUs) estão disponíveis, monta uma lista de atividades com tempo
de preparo e responsável, calcula uma distribuição equilibrada de tarefas por
CPU e aloca o trabalho entre as threads, monitorando a saída. A saída evidencia
vários amigos iniciando o preparo simultaneamente, cada um em seu próprio núcleo.

[Exemplo de Concorrencia - Go Playground](https://go.dev/play/p/2qEtDrT9p2V)

## Paralelismo Externo vs Paralelismo Interno

![Paralelismo Interno e Externo](images/paralelismo-interno-externo.png)

O paralelismo pode ser classificado em duas categorias complementares: interno e
externo.

### Paralelismo Interno

Também chamado de paralelismo intrínseco, ocorre dentro de um único processo. É o
paralelismo que você implementa diretamente no código da aplicação ao dividir
tarefas ou dados em memória entre subtarefas processadas ao mesmo tempo. Em
resumo, é o paralelismo criado para rodar dentro do seu container ou servidor.

### Paralelismo Externo

O paralelismo externo se refere à execução simultânea de tarefas em hardwares,
máquinas ou containers diferentes. É típico de computação distribuída, como
Hadoop e Spark, do consumo de mensagens de brokers como RabbitMQ e SQS, de
streamings como o Kafka que distribuem grandes volumes de dados entre vários
servidores para tarefas de ETL, Machine Learning e Analytics, e também de Load
Balancers, que dividem requisições entre múltiplas instâncias de uma mesma
aplicação.

![Paralelismo Load Balancer](images/load-balancer.gif)

# Paralelismo vs Concorrência

Após detalhar ambos os conceitos, fica clara a distinção. A concorrência lida
com a gestão de várias tarefas ao mesmo tempo, fazendo um sistema parecer
executar múltiplas operações em paralelo. O paralelismo, por sua vez, envolve a
execução literal de várias operações simultaneamente.

A concorrência também implica não ter controle sobre a ordem de processamento das
tarefas: só é possível saber a ordem real depois que todas terminam. Em CPUs de
núcleo único, a concorrência é obtida via multithreading, com alternância rápida
entre tarefas; o paralelismo exige hardware multinúcleo, em que cada núcleo
executa threads ou processos distintos ao mesmo tempo.

A síntese é direta: paralelismo é, em geral, concorrente, mas nem toda
concorrência é paralela.

![Concorrência vs Paralelismo](images/concorrencia-paralelismo.png)

# Lidando com Paralelismo e Concorrência

Definidos os conceitos de forma lúdica, é hora de olhar para os desafios e as
ferramentas envolvidas nessas estratégias. Apesar de oferecerem ganhos de
performance, escalabilidade e melhor uso de recursos, as abordagens paralelas e
concorrentes trazem complicações importantes: coordenação, condições de corrida,
deadlocks, starvation e balanceamento de carga, entre outras. As próximas seções
definem esses termos para facilitar o entendimento e a capacidade de explicá-los.

### Deadlocks e Starvation

![Deadlock](images/deadlocks.png)

Imagine usar a grelha (um recurso compartilhado) para preparar o pão de alho
enquanto um amigo segura a espátula (outro recurso essencial). Você precisa da
espátula; ele precisa da grelha. Cada um espera o recurso do outro sem liberar o
que possui, criando um impasse em que nenhuma tarefa avança. Isso é um deadlock:
duas ou mais threads ficam em espera permanente, num ciclo de dependências de
recursos que impede qualquer progresso.

Já a starvation (inanição) é diferente. Imagine que cada pessoa precisa preparar
sua própria refeição, e o grupo se divide entre os mais ágeis e oportunistas e os
mais educados e lentos. Os primeiros ocupam as grelhas assim que elas vagam,
deixando os demais sem acesso por muito tempo. Starvation ocorre quando uma ou
mais threads ficam longos períodos sem obter os recursos de que precisam,
geralmente por alocação desigual que prioriza certas threads em detrimento de
outras.

## Race Conditions - Condições de Corrida

![Robô Race Condition](images/race-condition.png)

Imagine um churrasco com apenas uma churrasqueira para todos os alimentos —
picanha, maminha, legumes, abacaxi, linguiça, pão de alho. Ela é pequena e só
assa um item por vez. A churrasqueira é um recurso compartilhado, e uma race
condition surge se todos tentarem preparar os alimentos ao mesmo tempo.

Uma race condition é comum quando um recurso compartilhado é acessado e
modificado por várias threads em paralelo. O estado final passa a depender da
ordem em que as modificações acontecem — e essa ordem pode variar a cada
execução. No exemplo, parte-se de 100 itens a grelhar e de um contador que
deveria terminar em 100; com acesso simultâneo, porém, dois ou mais amigos podem
mexer no contador ao mesmo tempo, produzindo resultados inconsistentes.

O código demonstra exatamente esse problema: uma variável `grelhados` é
incrementada concorrentemente por várias goroutines sem sincronização. As
execuções repetidas mostram contagens finais diferentes (97, 96, 100, 99…),
revelando a não determinação. Embora a analogia física do churrasco imponha um
limite natural ao acesso simultâneo, em sistemas reais, sem a devida
sincronização, a race condition se torna um problema sério e difícil de depurar.

[Exemplo de Race Condition - Go Playground](https://go.dev/play/p/QQQwp9YuikV)

### Race Conditions e Last-Write-Wins

Em sistemas distribuídos, uma race condition aparece quando eventos que deveriam
ser processados em sequência chegam ou são aplicados fora de ordem, levando a um
estado inconsistente. Diferente do contexto de threads disputando memória
compartilhada, aqui a corrida ocorre entre mensagens e eventos que trafegam por
canais assíncronos, onde entrega, ordem e latência não são determinísticas.

![Race Condition](images/race-condition.drawio.png)

Considere um sistema de pagamentos que se comunica com um sistema de pedidos por
um message broker, publicando em sequência os eventos `Pagamento_Pendente` e
depois `Pago`. No fluxo ideal, o consumidor transicionaria o pedido de "aguardando
pagamento" para "pago". Como o barramento não garante entrega ordenada, o evento
`Pago` pode ser consumido instantes antes de `Pagamento_Pendente`, caracterizando
uma race condition interprocessual.

O problema se agrava quando a arquitetura adota cegamente o modelo
last-write-wins, aplicando o último evento recebido como verdade sem checar
coerência temporal. O Last-Write-Wins é uma estratégia de resolução de conflitos
em sistemas distribuídos para decidir qual escrita concorrente deve prevalecer. Para
funcionar corretamente, as requisições precisam ser enriquecidas com timestamps
atômicos da solicitação, permitindo a verificação temporal de forma sistêmica.

## Mutex

![Robô Mutex](images/mutex.png)

Retomando o churrasco: como a grelha só comporta um item por vez, alguém precisa
ficar responsável por assar os alimentos em sequência. Essa pessoa funciona como
uma "trava" sobre o recurso compartilhado — um alimento é assado, depois o
próximo entra. Esse papel é exatamente o de um Mutex.

Mutex é a abreviação de Mutual Exclusion (exclusão mútua), uma estratégia para
controlar o acesso a recursos compartilhados em contextos de multithreading,
paralelismo ou concorrência. Ela garante acesso sequencial e organizado, sendo
uma das ferramentas centrais da programação concorrente e paralela. Seu objetivo
principal é evitar race conditions, assegurando que apenas uma thread acesse o
recurso por vez, por meio das operações "lock" (bloquear) e "unlock" (liberar).

![Mutex Fluxo](images/mutex-fluxo.drawio.png)

As operações de lock/unlock respeitam uma prioridade: apenas a thread que
bloqueou o recurso pode desbloqueá-lo. Sem o mutex, todos tentariam usar a
churrasqueira ao mesmo tempo, gerando confusão e alimentos mal preparados. O uso
de mutexes, porém, não é isento de riscos — o principal é o deadlock, que surge
quando várias threads tentam bloquear múltiplos mutexes em ordens inconsistentes.

No Go, o pacote `sync` oferece o mutex. Para resolver a race condition da grelha,
cria-se um orquestrador `grelhaOcupada` do tipo `sync.Mutex`, inserindo
`Mutex.Lock()` no início da função `grelhar()` e `Mutex.Unlock()` no final. Assim,
o acesso ao contador passa a ser estritamente sequencial. A saída do exemplo
mostra o grelhar e liberar alternados e o contador final correto em 100.

[Exemplo de Mutex - Go Playground](https://go.dev/play/p/sjqz6rD_aYB)

## Mutex Distribuído

![Robô Mutex Distribuído](images/mutex-distribuido.png)

Vimos o mutex no paralelismo interno, controlado por código. A mesma lógica é
igualmente importante no paralelismo externo, em cenários como consumo de
mensagens de filas, eventos de tópicos do Kafka e tratamento de requisições HTTP
— situações que exigem idempotência, atomicidade e exclusividade.

Construir um mutex distribuído traz desafios próprios, como comunicação entre
componentes, latência de rede e falhas de serviço, mas em alguns aspectos é mais
simples do que lidar com memória compartilhada.

![Mutex Centralizado](images/mutex-distribuido-example.drawio.png)

Para operar bem, esses sistemas costumam depender de uma base de dados
centralizada que mantém o estado dos processos compartilhado entre todas as
réplicas dos consumidores — algo crucial para tratar duplicidade de mensagens e
eventos. Estratégias comuns usam bancos otimizados para operações chave/valor,
como Redis, Memcached, Cassandra e DynamoDB, além de tecnologias como o
Zookeeper. O fluxo lógico apresentado usa o Redis: ao receber uma mensagem,
verifica-se se já existe um lock; se existir, descarta-se o processamento; se
não, cria-se o lock, processa-se a mensagem e libera-se o lock ao final.

### Exemplo de Implementação

O exemplo implementa esse fluxo de lock distribuído em Go usando Redis sobre uma
struct `PedidoDeCompra`. A saída ilustra o caminho feliz — criação do mutex por
um tempo definido, processamento e liberação. Caso outro processo tente acessar o
mesmo recurso durante a execução, ele recebe a indicação de que o recurso está
travado. O autor ressalta que se trata de um exemplo didático, que não cobre
todos os cenários de produção, recomendando bibliotecas específicas como o
[RedisLock](https://github.com/bsm/redislock) para uso real.

## Mutex Distribuído - Zookeeper

Uma alternativa elegante ao Redis para locks distribuídos é o Apache Zookeeper.
A lógica fundamental é semelhante, mas o Zookeeper traz particularidades
interessantes, baseando-se na manipulação de znodes (seus nós) para gerenciar as
travas de forma distribuída — uma tarefa mais avançada.

Uma vantagem notável é a possibilidade de definir um timeout de sessão, o que
garante a exclusão automática dos locks ao término da execução do programa. O
fluxo segue os mesmos passos do mutex distribuído: verificar a existência do
lock, devolver a mensagem ao pool caso ele já exista, criar o lock, processar a
solicitação e, por fim, removê-lo para liberar o recurso.

### Exemplo de Implementação

O exemplo conecta-se ao Zookeeper e implementa o ciclo de lock sobre uma struct
`PedidoDeCompra`. A primeira saída mostra a conexão e autenticação no servidor,
seguidas da criação do mutex em um znode, do processamento e da liberação. A
segunda saída demonstra o caso em que o recurso já está travado, encerrando o
processamento concorrente.

## Spinlock

![Spinlock](images/spinlock.png)

No churrasco com uma única grelha, o spinlock se diferencia do mutex: em vez de
esperar pacientemente a liberação, cada pessoa permanece ao lado da grelha,
verificando constantemente se ela ficou livre. Quem estiver checando no instante
em que ela vaga é quem a utiliza.

Um spinlock é um mecanismo de sincronização que protege o acesso a recursos
compartilhados sem colocar a thread em estado de espera (sleep). Em vez disso, a
thread permanece ativa, girando em um loop até que o lock seja liberado. Essa
abordagem é eficiente quando o tempo de espera é curto, pois evita o overhead de
bloquear e desbloquear threads. Por outro lado, se o recurso fica bloqueado por
muito tempo, o spinlock se torna ineficiente, já que a thread continua consumindo
CPU enquanto "gira".

### Exemplo de Implementação

O exemplo define uma struct `SpinLock` com um campo `state` (int32) e usa
operações atômicas (`sync/atomic`) para implementar o lock por busy-waiting: o
método de lock cria um loop ativo que aguarda o `state` mudar de valor antes de
prosseguir. A saída mostra os amigos esperando para usar a grelha e grelhando
conforme o lock é adquirido e liberado, evidenciando o comportamento de espera
ativa.

[Spinlock - Go Playground](https://go.dev/play/p/AsoJtOIUyde)

## Semáforos e Worker Pools

![Semáforos](images/worker-pools.png)

Há dois tipos principais de semáforo: o binário, semelhante ao mutex já
discutido, e o contador, foco desta seção. O semáforo é um mecanismo de
sincronização usado em programação paralela para controlar o acesso a recursos
compartilhados e evitar race conditions. Ele se apoia em duas operações
atômicas: `Wait()`, que ocupa um recurso e decrementa o contador de posições
disponíveis, e `Signal()`, que libera um recurso e incrementa o contador até o
limite definido.

Semáforos são eficientes para implementar Worker Pools — conjuntos de threads
dedicadas que executam tarefas de forma controlada em quantidade. Esse padrão é
útil quando há muitas tarefas, mas é preciso limitar quantas threads rodam ao
mesmo tempo. Na analogia, o Worker Pool é a quantidade de alimentos que a grelha
comporta de uma vez.

![Semaforo Exemplo](images/semaforo-exemplo.drawio.png)

Em um sistema hipotético de consumo de mensagens, cada réplica opera com um
semáforo de 10 posições, processando no máximo 10 mensagens por vez. As mensagens
que chegam são enfileiradas em memória e ocupam posições conforme há espaço.
Quando alguns processos terminam, o semáforo "abre" e admite novas mensagens; ao
atingir o limite, "fecha", retendo as demais até que novas posições sejam
liberadas. A mesma ideia vale para a grelha que comporta, por exemplo, 3 pedaços
de carne por vez: cada item ocupa uma posição do semáforo até zerar e, ao ser
retirado, devolve espaço.

### Exemplo de Implementação:

O exemplo usa um channel em Go com capacidade igual à da grelha (3) para
representar o semáforo, com 10 alimentos no total. Em vez de incrementar e
decrementar um contador, a lógica é invertida: adiciona-se um objeto ao canal
para ocupar uma posição ao iniciar o preparo e remove-se ao concluir. A saída
demonstra três alimentos sendo preparados em paralelo, sua desocupação e a
entrada dos próximos, respeitando sempre a capacidade máxima. O autor sugere, para
produção, a biblioteca [semaphore](https://pkg.go.dev/golang.org/x/sync/semaphore)
do Go, que abstrai boa parte da lógica de Worker Pools.

[Exemplo de Semaphore - Go Playground](https://go.dev/play/p/qZmrpyU_6a9)

# Referências

* [Github - Algoritmos apresentados no texto](https://github.com/msfidelis/system-design-examples/tree/main/concurrency-parallelism)

*  [Martin Kleppmann - How to do distributed locking](https://martin.kleppmann.com/2016/02/08/how-to-do-distributed-locking.html)

*  [Parallelizing Dijkstra’s Algorithm - Department of Computer Science and Information Technology - St. Cloud University](https://repository.stcloudstate.edu/cgi/viewcontent.cgi?article=1044&context=csit_etds)

* [Palestra na GopherCon 2023: O que há por trás de um orquestrador? Go, sistemas distribuídos e lágrimas](https://www.youtube.com/watch?feature=shared&v=DjAF_sLJjZM)

* [Load Balancing 101](https://medium.com/the-kickstarter/load-balancing-101-81710aa7a3d7)

* [Desvendando a Concorrência e Paralelismo em Go](https://medium.com/@rgribeiro/desvendando-a-concorr%C3%AAncia-e-paralelismo-em-go-7a33d33f5510)

* [Concorrência e Paralelismo em Go](https://www.tabnews.com.br/lucchesisp/concorrencia-e-paralelismo-com-golang#)

* [Handling Mutexes in Distributed Systems with Redis and Go](https://dev.to/jdvert/handling-mutexes-in-distributed-systems-with-redis-and-go-5g0d)

* [Github - Redislock](https://github.com/bsm/redislock)

* [Difference Between Mutex and Semaphore in Operating System](https://afteracademy.com/blog/difference-between-mutex-and-semaphore-in-operating-system/)

* [Go - Paralelismo e Concorrência](https://dev.to/yanpiing/go-paralelismo-e-concorrencia-4mlo)

* [Golang - Semaphore Lib](https://pkg.go.dev/golang.org/x/sync/semaphore)

* [Using Spinlocks](https://docs.oracle.com/cd/E37838_01/html/E61057/ggecq.html)

* [O Jantar dos filósofos - Problema de sincronização em Sistemas Operacionais](https://blog.pantuza.com/artigos/o-jantar-dos-filosofos-problema-de-sincronizacao-em-sistemas-operacionais)

* [Comunicação de Processos](https://edisciplinas.usp.br/pluginfile.php/4933938/mod_resource/content/1/Aula%2005%20-%20Comunicacao_so_2019.pdf)

* [Comunicação e Sincronismo entre Processos](https://www.professores.uff.br/mquinet/wp-content/uploads/sites/42/2017/08/7.pdf)
