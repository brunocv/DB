//-------------------- Nodos ---------------------//

//------------------- Cliente --------------------//
LOAD CSV WITH HEADERS FROM 'file:///Cliente.csv' AS row
CREATE (c: Cliente {Nr_contribuinte: toInteger(row.Nr_contribuinte), Nome: toString(row.Nome)})
RETURN c;

//------------------- Empregado --------------------//
LOAD CSV WITH HEADERS FROM 'file:///Empregado.csv' AS row
CREATE (e: Empregado {Id: toInteger(row.Id)})
SET e.Nome = toString(row.Nome),
	e.Telefone = toString(row.Telefone)
RETURN e;

//------------------- Fornecedor --------------------//
LOAD CSV WITH HEADERS FROM 'file:///Fornecedor.csv' AS row
CREATE (f: Fornecedor {Id: toInteger(row.Id), Nome: toString(row.Nome)})
RETURN f;

//------------------- Ingrediente --------------------//
LOAD CSV WITH HEADERS FROM 'file:///Ingrediente.csv' AS row
CREATE (i: Ingrediente {nome: toString(row.Nome)})
SET i.Id = toInteger(row.Id),
	i.Stock = toInteger(row.Stock),
	i.Id_fornecedor = toInteger(row.Id_fornecedor),
	i.PrecoCompra = toFloat(row.PrecoCompra),
	i.PrecoVenda = toFloat(row.PrecoVenda)
RETURN i;

//--------------------- Pedido ----------------------//
LOAD CSV WITH HEADERS FROM 'file:///Pedido.csv' AS row
CREATE (p: Pedido {Id: toInteger(row.Id)})
SET p.Id_cliente = toInteger(row.Id_cliente),
	p.Id_empregado = toInteger(row.Id_empregado),
	p.Preco = toFloat(row.Preco),
	p.Data = split(row.Data, '-')
RETURN p;

//--------------------- Relações -------------------//

//---------- Cliente - [:PEDE] -> Pedido -----------//
MATCH (c: Cliente),(p: Pedido)
WHERE c.Nr_contribuinte = p.Id_cliente
CREATE (c)-[:PEDE]->(p);

//-------- Empregado - [:REALIZA] -> Pedido ---------//
MATCH (e: Empregado),(p: Pedido)
WHERE e.Id = p.Id_empregado
CREATE (e)-[:REALIZA]->(p);

//-------- Ingrediente - [:FORNECIDO_POR] -> Fornecedor ----//
MATCH (i: Ingrediente),(f: Fornecedor)
WHERE i.Id_fornecedor = f.Id
CREATE (i)-[:FORNECIDO_POR]->(f);

//---------- Pedido - [:CONTEM] -> Ingrediente -------//
LOAD CSV WITH HEADERS FROM 'file:///PedidoIngrediente.csv' AS row
MATCH (p: Pedido),(i: Ingrediente)
WHERE p.Id = toInteger(row.Id_pedido) AND toInteger(row.Id_ingrediente) = i.Id  
CREATE (p)-[r:CONTEM {Preco: toFloat(row.Preco), Quantidade: toInt(row.Quantidade)}]->(i);