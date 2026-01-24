--- exemplo de linha 
SELECT * FROM produto p; 

SELECT * FROM categoria c; 

--- JOIN
SELECT * FROM produto p LEFT JOIN categoria c ON c.id=p.categoria_id;

SELECT * FROM item_pedido ip INNER JOIN pedido p ON ip.pedido_id = p.id LEFT JOIN produto pr ON ip.produto_id = pr.id LEFT JOIN categoria c ON pr.categoria_id = c.id;

-- total gasto por cliente
SELECT c.email, ROUND(SUM(ip.qtd*ip.preco_cents)/100.0,2) AS total_reais
FROM cliente c JOIN pedido p ON p.cliente_id=c.id JOIN item_pedido ip ON ip.pedido_id=p.id
GROUP BY c.email ORDER BY total_reais DESC;

-- itens vendidos por categoria
SELECT cat.nome AS categoria, SUM(ip.qtd) AS itens
FROM categoria cat JOIN produto pr ON pr.categoria_id=cat.id JOIN item_pedido ip ON ip.produto_id=pr.id
GROUP BY cat.nome ORDER BY itens DESC;

-- pedidos dos últimos 2 dias
SELECT p.id, c.email, p.criado_em
FROM pedido p JOIN cliente c ON c.id=p.cliente_id
WHERE p.criado_em >= now()-interval '2 days'
ORDER BY p.criado_em DESC;