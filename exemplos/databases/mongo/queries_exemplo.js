// Agregação - Total por Cliente
printjson(db.pedidos.aggregate([
  {$unwind:"$itens"},
  {$group:{_id:"$email", total_reais:{$sum:{$multiply:["$itens.qtd", {$divide:["$itens.preco_cents",100]}]}}}},
  {$sort:{total_reais:-1}}
]).toArray());

// Agregação - Itens por Categoria 
printjson(db.pedidos.aggregate([
  {$unwind:"$itens"},
  {$lookup:{from:"produtos", localField:"itens.produto_id", foreignField:"_id", as:"p"}},
  {$unwind:"$p"},
  {$lookup:{from:"categorias", localField:"p.categoria_id", foreignField:"_id", as:"c"}},
  {$unwind:"$c"},
  {$group:{_id:"$c.nome", itens:{$sum:"$itens.qtd"}}},
  {$sort:{itens:-1}}
]).toArray());


// Documento Estruturado 
db["produtos_estruturado"].find()