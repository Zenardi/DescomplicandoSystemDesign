const db = new Mongo().getDB("loja");

db.clientes.drop(); db.produtos.drop(); db.categorias.drop(); db.pedidos.drop();

db.clientes.insertMany([
  {_id: 1, nome: "Ana Souza", email: "ana@example.com", criado_em: new Date()},
  {_id: 2, nome: "Bruno Lima", email: "bruno@example.com", criado_em: new Date()},
  {_id: 3, nome: "Carla Dias", email: "carla@example.com", criado_em: new Date()}
]);

db.categorias.insertMany([{_id:1,nome:"Eletrônicos"},{_id:2,nome:"Alimentos"},{_id:3,nome:"Vestuário"}]);

db.produtos.insertMany([
  {_id:1,nome:"Fone de Ouvido",preco_cents:19900,categoria_id:1},
  {_id:2,nome:"Mouse Gamer",preco_cents:15900,categoria_id:1},
  {_id:3,nome:"Camiseta Preta",preco_cents:7900,categoria_id:3},
  {_id:4,nome:"Café 500g",preco_cents:2990,categoria_id:2},
  {_id:5,nome:"Chocolate 90g",preco_cents:1290,categoria_id:2},
]);

db.pedidos.insertMany([
  {_id:1, cliente_id:1, email:"ana@example.com", criado_em: new Date(Date.now()-3*864e5),
    itens:[{produto_id:1, nome:"Fone de Ouvido", qtd:1, preco_cents:19900},
           {produto_id:4, nome:"Café 500g", qtd:2, preco_cents:2990}]},
  {_id:2, cliente_id:1, email:"ana@example.com", criado_em: new Date(Date.now()-1*864e5),
    itens:[{produto_id:2, nome:"Mouse Gamer", qtd:1, preco_cents:15900}]},
  {_id:3, cliente_id:2, email:"bruno@example.com", criado_em: new Date(Date.now()-2*864e5),
    itens:[{produto_id:3, nome:"Camiseta Preta", qtd:2, preco_cents:7900},
           {produto_id:5, nome:"Chocolate 90g", qtd:3, preco_cents:1290}]}
]);

db.pedidos.createIndex({ email: 1, criado_em: -1 });
db.produtos.createIndex({ categoria_id: 1 });


// Exemplo de um Documento Completo 

db.produtos_estruturado.insertMany([
  {
    _id: 1,
    sku: "FONE-001",
    nome: "Fone de Ouvido",
    descricao: "Headset leve com microfone e cabo P2.",
    categoria: { _id: 1, nome: "Eletrônicos", caminho: ["Loja", "Eletrônicos", "Áudio"] },
    preco: { cents: 19900, currency: "BRL" },
    estoque: [
      { deposito: "sp-01", quantidade: 120 },
      { deposito: "rj-02", quantidade: 45 }
    ],
    atributos: {
      marca: "Acme",
      cor: "preto",
      peso_kg: 0.2,
      dimensoes_cm: { largura: 15, altura: 18, profundidade: 7 }
    },
    tags: ["audio", "eletronicos", "headset"],
    imagens: [{ url: "https://exemplo.local/img/fone.jpg", principal: true }],
    status: "ativo",
    criado_em: new Date(),
    atualizado_em: new Date()
  },
  {
    _id: 2,
    sku: "CAFE-500",
    nome: "Café 500g",
    descricao: "Café torrado e moído, pacote de 500 gramas.",
    categoria: { _id: 2, nome: "Alimentos", caminho: ["Loja", "Alimentos", "Bebidas"] },
    preco: { cents: 2990, currency: "BRL" },
    estoque: [
      { deposito: "sp-01", quantidade: 300 },
      { deposito: "mg-01", quantidade: 180 }
    ],
    atributos: {
      marca: "Fazenda do Vale",
      tipo: "moído",
      torra: "média",
      peso_kg: 0.5
    },
    tags: ["cafe", "alimentos", "bebidas"],
    imagens: [{ url: "https://exemplo.local/img/cafe.jpg", principal: true }],
    status: "ativo",
    criado_em: new Date(),
    atualizado_em: new Date()
  },
  {
    _id: 3,
    sku: "CAMI-PRETA",
    nome: "Camiseta Preta",
    descricao: "Camiseta 100% algodão, modelagem unissex.",
    categoria: { _id: 3, nome: "Vestuário", caminho: ["Loja", "Vestuário", "Camisetas"] },
    preco: { cents: 7900, currency: "BRL" },
    estoque: [
      { deposito: "sp-01", quantidade: 80 },
      { deposito: "pr-01", quantidade: 60 }
    ],
    atributos: {
      marca: "Urban Wear",
      material: "algodão",
      genero: "unissex",
      variantes: [
        { tamanho: "P", cor: "preto" },
        { tamanho: "M", cor: "preto" },
        { tamanho: "G", cor: "preto" }
      ]
    },
    tags: ["roupas", "camiseta", "preto"],
    imagens: [{ url: "https://exemplo.local/img/camiseta-preta.jpg", principal: true }],
    status: "ativo",
    criado_em: new Date(),
    atualizado_em: new Date()
  }
])