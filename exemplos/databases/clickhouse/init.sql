CREATE DATABASE IF NOT EXISTS loja;
USE loja;

CREATE TABLE cliente   (id UInt32, nome String, email String, criado_em DateTime) ENGINE=MergeTree ORDER BY id;
CREATE TABLE categoria (id UInt32, nome String) ENGINE=MergeTree ORDER BY id;
CREATE TABLE produto   (id UInt32, nome String, preco_cents UInt32, categoria_id UInt32) ENGINE=MergeTree ORDER BY id;
CREATE TABLE pedido    (id UInt32, cliente_id UInt32, criado_em DateTime) ENGINE=MergeTree ORDER BY (cliente_id, criado_em);
CREATE TABLE item_pedido (pedido_id UInt32, produto_id UInt32, qtd UInt32, preco_cents UInt32) ENGINE=MergeTree ORDER BY (pedido_id, produto_id);

INSERT INTO cliente VALUES (1,'Ana Souza','ana@example.com', now()-INTERVAL 5 DAY),(2,'Bruno Lima','bruno@example.com', now()-INTERVAL 4 DAY),(3,'Carla Dias','carla@example.com', now()-INTERVAL 3 DAY);
INSERT INTO categoria VALUES (1,'Eletrônicos'),(2,'Alimentos'),(3,'Vestuário');
INSERT INTO produto VALUES (1,'Fone de Ouvido',19900,1),(2,'Mouse Gamer',15900,1),(3,'Camiseta Preta',7900,3),(4,'Café 500g',2990,2),(5,'Chocolate 90g',1290,2);
INSERT INTO pedido VALUES (1,1, now()-INTERVAL 3 DAY),(2,1, now()-INTERVAL 1 DAY),(3,2, now()-INTERVAL 2 DAY);
INSERT INTO item_pedido VALUES (1,1,1,19900),(1,4,2,2990),(2,2,1,15900),(3,3,2,7900),(3,5,3,1290);
