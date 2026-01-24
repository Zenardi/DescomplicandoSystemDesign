CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
DROP TABLE IF EXISTS item_pedido CASCADE;
DROP TABLE IF EXISTS pedido CASCADE;
DROP TABLE IF EXISTS produto CASCADE;
DROP TABLE IF EXISTS categoria CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;

CREATE TABLE cliente (id BIGSERIAL PRIMARY KEY, nome TEXT NOT NULL, email TEXT NOT NULL UNIQUE, criado_em timestamptz DEFAULT now());
CREATE TABLE categoria (id BIGSERIAL PRIMARY KEY, nome TEXT NOT NULL UNIQUE);
CREATE TABLE produto (id BIGSERIAL PRIMARY KEY, nome TEXT NOT NULL, preco_cents INT NOT NULL CHECK (preco_cents>0), categoria_id BIGINT NOT NULL REFERENCES categoria(id));
CREATE TABLE pedido (id BIGSERIAL PRIMARY KEY, cliente_id BIGINT NOT NULL REFERENCES cliente(id), criado_em timestamptz DEFAULT now());
CREATE TABLE item_pedido (pedido_id BIGINT REFERENCES pedido(id) ON DELETE CASCADE, produto_id BIGINT REFERENCES produto(id), qtd INT CHECK (qtd>0), preco_cents INT CHECK (preco_cents>0), PRIMARY KEY (pedido_id, produto_id));

INSERT INTO cliente (nome,email) VALUES
('Ana Souza','ana@example.com'),('Bruno Lima','bruno@example.com'),('Carla Dias','carla@example.com');
INSERT INTO categoria (nome) VALUES ('Eletrônicos'),('Alimentos'),('Vestuário');
INSERT INTO produto (nome,preco_cents,categoria_id) VALUES
('Fone de Ouvido',19900,1),('Mouse Gamer',15900,1),('Camiseta Preta',7900,3),('Café 500g',2990,2),('Chocolate 90g',1290,2);
INSERT INTO pedido (cliente_id,criado_em) VALUES (1, now()-interval '3 days'),(1, now()-interval '1 day'),(2, now()-interval '2 days');
INSERT INTO item_pedido VALUES
(1,1,1,19900),(1,4,2,2990),(2,2,1,15900),(3,3,2,7900),(3,5,3,1290);

-- índices opcionais para comparar planos
CREATE INDEX idx_pedido_cliente_data ON pedido (cliente_id, criado_em DESC);
CREATE INDEX idx_produto_categoria ON produto (categoria_id);