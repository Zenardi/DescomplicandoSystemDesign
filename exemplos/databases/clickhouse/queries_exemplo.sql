USE loja;

-- total gasto por cliente (varredura colunar eficiente)
SELECT c.email, round(sum(ip.qtd*ip.preco_cents)/100,2) AS total_reais
FROM cliente c
JOIN pedido p ON p.cliente_id=c.id
JOIN item_pedido ip ON ip.pedido_id=p.id
GROUP BY c.email
ORDER BY total_reais DESC;

-- itens por categoria
SELECT cat.nome AS categoria, sum(ip.qtd) AS itens
FROM categoria cat
JOIN produto pr ON pr.categoria_id=cat.id
JOIN item_pedido ip ON ip.produto_id=pr.id
GROUP BY cat.nome
ORDER BY itens DESC;

-- pedidos últimos 2 dias
SELECT p.id, c.email, p.criado_em
FROM pedido p JOIN cliente c ON c.id=p.cliente_id
WHERE p.criado_em >= now()-INTERVAL 2 DAY
ORDER BY p.criado_em DESC;