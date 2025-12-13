# Case DDD (Nível Básico) — Banco da Federação Galática

## 1) Historinha (bem curtinha)
O Banco da Federação Galática nasceu com um **monolito** em que “Cliente” é um único registro ligado a tudo (contas, pagamentos, cartões). Com a chegada do **PIX** e novos produtos, **qualquer mudança quebra outra parte** e entregar novidades ficou lento e arriscado. A missão agora é **aplicar DDD** para separar o negócio em partes claras, independentes e fáceis de evoluir.

---

## 2) Features do Sistema (recorte básico)
- **Abertura de conta digital** (captura de dados e aprovação simples).
- **Consulta de saldo e extrato** por conta.
- **Transferência PIX** entre contas internas (MVP).
- **Pagamento de boleto** (fluxo básico).
- **Atualização cadastral** (e-mail, telefone, endereço).

> Observação: mantenha tudo **o mais simples possível** — é um exercício de **modelagem de domínio**.

---

## 3) Tarefa 1 — Identificar os **Domains**
Com base nas features, liste os **domínios de negócio** necessários. Ex.:  
*(só exemplos, confirme/ajuste você mesmo)*  
- **Contas/Core Banking** (saldos, lançamentos, extrato)  
- **Pagamentos** (PIX, boleto)  
- **Clientes/Cadastro** (dados cadastrais)  
- **Onboarding** (abertura/aprovação de conta)

> **Entregável:** uma lista curta de domains com 1 frase de responsabilidade para cada.

---

## 4) Tarefa 2 — Escolher o **Core Domain**
Entre os domains identificados, qual é o **Core Domain** (o coração do negócio para este MVP) e **por quê**?

> **Dica:** pense em **fonte de verdade do dinheiro** vs. domínios de suporte (que dependem do core).

> **Entregável:** 1 parágrafo nomeando o core e justificando.

---

## 5) Tarefa 3 — Mapear as **Entidades** (mínimo viável)
Para **três** domains (inclua o Core), modele as principais **Entidades/Agregados** e **2–3 regras** de cada.

### Exemplo de formato (preencha você):
- **Domínio:** Contas/Core Banking  
  - **Entidade/Agregado:** `ContaBancaria`  
    - **Atributos (ex.):** `contaId`, `numero`, `status`, `clienteRef`  
    - **Regras (ex.):** bloquear/desbloquear; não permitir saldo negativo em operações comuns.
  - **Entidade:** `Lancamento`  
    - **Atributos (ex.):** `lancamentoId`, `contaId`, `tipo` (crédito/débito), `valor`, `dataHora`  
    - **Regras (ex.):** imutável; dupla entrada garante balanço.
- **Domínio:** Pagamentos  
  - **Entidade:** `Pagamento` (PIX/Boleto)  
    - **Atributos (ex.):** `pagamentoId`, `contaPagadoraId`, `valor`, `tipo`, `status`  
    - **Regras (ex.):** não altera saldo diretamente; **solicita** débito/crédito ao Core.
- **Domínio:** Clientes/Cadastro  
  - **Entidade:** `Cliente`  
    - **Atributos (ex.):** `clienteId`, `cpfCnpj`, `nome`, `email`, `telefone`, `enderecos[]`  
    - **Regras (ex.):** validação de dados; **não** armazena saldo.

> **Objetos de Valor sugeridos:** `Dinheiro` (moeda/precisão), `Documento` (CPF/CNPJ), `Endereco`.

---

## 6) Extra (opcional) — Desenhe a **Arquitetura de Microserviços**
Crie um rascunho de arquitetura **coerente com os domínios** (1 serviço por domínio já é suficiente para o MVP):

- **Serviços sugeridos:**  
  - `core-banking-service` (API de **Debitar/Creditar**, **Extrato**)  
  - `payments-service` (orquestra **PIX/Boleto**, chama o Core)  
  - `customers-service` (cadastro/atualizações)  
  - `onboarding-service` (abertura/aprovação de conta)
- **Contratos mínimos:**  
  - **Comandos para o Core:** `Debitar`, `Creditar`  
  - **Eventos do Core:** `TransacaoEfetuada`, `SaldoAtualizado`  
  - **Eventos do Onboarding:** `ContaAprovada`
- **Regras simples de integração:**  
  - **Pagamentos** nunca mexe no saldo direto — **pede** ao Core.  
  - **Cadastro** não tem saldo — só referência à conta/titular.  
  - **Onboarding** cria conta via evento/comando, Core responde com confirmação.

> **Entregável:** um diagrama simples (pode ser caixa e setas) mostrando serviços, quem chama quem e 3–5 mensagens principais (comando/evento).

---

## Checklist de encerramento
- [ ] Domains listados e descritos.  
- [ ] **Core Domain** escolhido e justificado.  
- [ ] Entidades/Agregados com 2–3 regras cada em 3 domains.  
- [ ] (Extra) Diagrama de microserviços com comandos/eventos essenciais.

Boa! Mantenha o **escopo pequeno** e o **vocabulário do domínio** claro. O objetivo é **entender os domains**, **marcar o core** e **nomear entidades** sem cair em detalhes de implementação.
