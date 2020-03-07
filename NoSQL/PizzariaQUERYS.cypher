//----------------------------- QUERYS ----------------------------------

//-- Principal Fornecedor da Pizzaria
// feita
MATCH (i: Ingrediente)-[:FORNECIDO_POR]->(f: Fornecedor)
RETURN f.Nome, COUNT(i.Id_fornecedor)
ORDER BY COUNT(i.Id_fornecedor) DESC
LIMIT 1;

//-- 5 ingredientes mais pedidos(com respetivo fornecedor)
// feita
MATCH (p:Pedido)-[r:CONTEM]->(i: Ingrediente)-[:FORNECIDO_POR]->(f:Fornecedor)
RETURN i.nome AS Designacao, f.Nome,COUNT(i.Id)
ORDER BY COUNT(i.Id) DESC
LIMIT 5;

//-- Cliente que mais gastou
// feita
MATCH (c: Cliente)-[:PEDE]->(p: Pedido)
RETURN c.Nome, SUM(p.Preco)
ORDER BY SUM(p.Preco) DESC
LIMIT 1;

//-- Cliente com mais pedidos
// feita
MATCH (c: Cliente)-[:PEDE]->(p: Pedido)
RETURN c.Nome, COUNT(p.Id_cliente)
ORDER BY COUNT(p.Id_cliente) DESC
LIMIT 1;

//-- Empregado mais trabalhador
// feita
MATCH (e: Empregado)-[:REALIZA]->(p: Pedido)
RETURN e.Nome, COUNT(p.Id_empregado)
ORDER BY COUNT(p.Id_empregado) DESC
LIMIT 1;

//-- pedidos feitos por um dado cliente num dado intervalo de tempo
// feita
MATCH (c: Cliente)-[:PEDE]->(p: Pedido)<-[:REALIZA]-(e: Empregado)
WHERE (c.Nr_contribuinte = 81826) AND (toInteger(p.Data[0]) = 2018) AND (toInteger(p.Data[1]) >= 6) AND (toInteger(p.Data[1]) <= 12)
RETURN c.Nome, e.Nome, p.Data, p.Preco
ORDER BY p.Preco DESC

//-- vezes que um cliente pediu um ingrediente x fornecido por y
// feita
MATCH (c: Cliente)-[:PEDE]->(p: Pedido)-[:CONTEM]->(i:Ingrediente)-[:FORNECIDO_POR]->(f:Fornecedor)
WHERE c.Nr_contribuinte = 54321 AND i.nome = "Vinho" AND f.Nome = "Refrigerantes do Norte"
RETURN i.nome AS Designacao,COUNT(i.Id) AS Vezes_que_pediu, f.Nome AS Fornecedor;

//-- lucro da pizzaria num dado mês
// feita
MATCH (p: Pedido)-[r:CONTEM]->(i: Ingrediente)
WHERE p.Data[0] = "2018" AND p.Data[1] = "11"
RETURN SUM((i.PrecoVenda - i.PrecoCompra) * r.Quantidade) AS LUCRO