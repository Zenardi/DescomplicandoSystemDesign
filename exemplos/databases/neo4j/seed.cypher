MATCH (n) DETACH DELETE n;

CREATE (e:Categoria {nome:'Eletrônicos'});
CREATE (a:Categoria {nome:'Alimentos'});
CREATE (v:Categoria {nome:'Vestuário'});

CREATE (p1:Produto {id:1,nome:'Fone de Ouvido',preco_cents:19900})-[:PERTENCE]->(e);
CREATE (p2:Produto {id:2,nome:'Mouse Gamer',preco_cents:15900})-[:PERTENCE]->(e);
CREATE (p3:Produto {id:3,nome:'Camiseta Preta',preco_cents:7900})-[:PERTENCE]->(v);
CREATE (p4:Produto {id:4,nome:'Café 500g',preco_cents:2990})-[:PERTENCE]->(a);
CREATE (p5:Produto {id:5,nome:'Chocolate 90g',preco_cents:1290})-[:PERTENCE]->(a);

CREATE (:Cliente {email:'ana@example.com',nome:'Ana Souza'});
CREATE (:Cliente {email:'bruno@example.com',nome:'Bruno Lima'});

CREATE (:Pedido {id:1,criado_em:date() - duration('P3D')});
CREATE (:Pedido {id:2,criado_em:date() - duration('P1D')});
CREATE (:Pedido {id:3,criado_em:date() - duration('P2D')});

MATCH (ana:Cliente {email:'ana@example.com'}), (o1:Pedido {id:1})
MERGE (ana)-[:FEZ]->(o1);

MATCH (ana:Cliente {email:'ana@example.com'}), (o2:Pedido {id:2})
MERGE (ana)-[:FEZ]->(o2);

MATCH (bru:Cliente {email:'bruno@example.com'}), (o3:Pedido {id:3})
MERGE (bru)-[:FEZ]->(o3);

MATCH (o1:Pedido {id:1}), (p1:Produto {id:1})
MERGE (o1)-[:CONTEM {qtd:1,preco_cents:19900}]->(p1);

MATCH (o1:Pedido {id:1}), (p4:Produto {id:4})
MERGE (o1)-[:CONTEM {qtd:2,preco_cents:2990}]->(p4);

MATCH (o2:Pedido {id:2}), (p2:Produto {id:2})
MERGE (o2)-[:CONTEM {qtd:1,preco_cents:15900}]->(p2);

MATCH (o3:Pedido {id:3}), (p3:Produto {id:3})
MERGE (o3)-[:CONTEM {qtd:2,preco_cents:7900}]->(p3);

MATCH (o3:Pedido {id:3}), (p5:Produto {id:5})
MERGE (o3)-[:CONTEM {qtd:3,preco_cents:1290}]->(p5);
