USE Pizzaria;

-- VIEWS

-- Vista da Lista de Pedidos ordenada por Preco, Data 
CREATE VIEW viewListaPedidos AS 
 	SELECT P.Id AS Identificador, E.Nome AS Empregado, C.Nome AS Cliente, P.Preco AS Preco, P.Data AS Data 
		FROM Pedido AS P 
        INNER JOIN Empregado AS E 
			ON P.Id_empregado = E.Id 
		INNER JOIN Cliente AS C 
			ON P.Id_cliente = C.Nr_contribuinte
		ORDER BY P.Preco DESC, P.Data DESC;
        
-- SELECT * FROM viewListaPedidos;        
-- DROP VIEW viewListaPedidos;

GRANT SELECT ON pizzaria.viewListaPedidos TO 'func1'@'localhost';

-- Vista dos Ingredientes ordenada por Preco com o respectivo fornecedor 
CREATE VIEW catalogo AS 
	SELECT I.Id AS ID, I.Nome AS Ingrediente, I.PrecoVenda AS Preco, F.Nome AS Fornecedor, F.Id AS Id_Fornecedor
		FROM Ingrediente AS I 
        INNER JOIN Fornecedor AS F 
			ON I.Id_fornecedor = F.Id
		ORDER BY I.PrecoVenda DESC;
        
-- SELECT * FROM catalogo;
-- DROP VIEW catalogo;
GRANT SELECT ON pizzaria.catalogo TO 'emp1'@'localhost';

-- QUERYS

-- Query Média Idades dos clientes
-- SELECT AVG(Cliente.Idade) AS MediaIdades
-- FROM Cliente;

-- Query Principal Fornecedor 
SELECT F.Nome, COUNT(F.Id) AS NrFornecimentos
	FROM Ingrediente AS I 
    INNER JOIN Fornecedor AS F 
		ON I.Id_fornecedor = F.Id 
	GROUP BY I.Id_fornecedor
    ORDER BY COUNT(I.Id_fornecedor) DESC
    LIMIT 1;

-- Query TOP 5 Ingredientes mais pedidos
SELECT Ingrediente.Nome, SUM(PedidoIngrediente.Quantidade)
	FROM Ingrediente
    INNER JOIN PedidoIngrediente On Ingrediente.Id=PedidoIngrediente.Id_ingrediente
    GROUP BY Ingrediente.Nome
    ORDER BY SUM(PedidoIngrediente.Quantidade) DESC 
    LIMIT 5;

-- PROCEDURES

-- Procedure número total de pedidos de um cliente num dado intervalo de tempo
DELIMITER $$
CREATE PROCEDURE pedidosCliente(IN nomeCliente VARCHAR(45), IN dataInicio DATE ,IN dataFim DATE)
BEGIN 
		SELECT C.Nome, P.data, P.Preco
			FROM Pedido AS P
            INNER JOIN Cliente AS C
				ON P.Id_Cliente = C.Nr_Contribuinte
            WHERE (C.nome = nomeCliente && P.data >= dataInicio && P.data <= dataFim);
END; $$
DELIMITER ;

-- CALL pedidosCliente ('Jaime','2018-11-1','2018-11-15');
-- DROP PROCEDURE pedidosCliente;

-- Procedure Atualizar stock de um ingrediente
DELIMITER $$
CREATE PROCEDURE atualizaStock(IN id INT, IN qtaIntroduzir INT)
BEGIN 
    UPDATE Ingrediente
		SET Ingrediente.stock =  Ingrediente.stock + qtaIntroduzir
		WHERE Ingrediente.id = id;
END; $$
DELIMITER ;

-- CALL atualizaStock(1,-30);
-- DROP PROCEDURE atualizaStock;

-- PROCEDURE Ingredientes contidos num determinado Pedido
DELIMITER $$ 
CREATE PROCEDURE ingredientesDoPedido (IN pedido INT) 
BEGIN
	SELECT I.Nome AS Ingrediente, PI.Quantidade AS Quantidade
		FROM PedidoIngrediente AS PI 
        INNER JOIN Ingrediente AS I 
			ON PI.Id_Ingrediente = I.Id 
		WHERE PI.Id_pedido = pedido
        ORDER BY PI.Quantidade DESC;
END; $$
DELIMITER ;

-- CALL ingredientesDoPedido(1);
-- CALL ingredientesDoPedido(7);
-- DROP PROCEDURE ingredientesDoPedido;

-- PROCEDURE Numeros de Telefone de um Cliente 
DELIMITER $$
CREATE PROCEDURE contactosDoCliente (IN cliente INT) 
BEGIN
	SELECT CC.Telefone AS Telefone
		FROM CLienteContacto AS CC 
		WHERE CC.Id_cliente = cliente;
END; $$
DELIMITER ;

-- CALL contactosDoCliente(81826);
-- CALL contactosDoCliente(80757);
-- CALL contactosDoCliente(78352);
-- DROP PROCEDURE contactosDoCliente;

-- Procedure Para um dado cliente, ver o empregado que mais vezes o serviu
DELIMITER $$
CREATE PROCEDURE clienteEmpregado (IN Nr_Contribuinte VARCHAR(45)) 
BEGIN
	SELECT E.Nome, E.Id 
		FROM Pedido AS P 
        INNER JOIN Empregado AS E 
			ON P.Id_Empregado = E.Id 
		WHERE P.Id_cliente = Nr_contribuinte
        GROUP BY P.Id_Empregado 
        ORDER BY COUNT(P.Id_Empregado) DESC 
        LIMIT 1;
END; $$
DELIMITER ;

-- CALL clienteEmpregado('81826');
-- DROP PROCEDURE clienteEmpregado;
		
-- Procedure Ingredientes que um fornecedor fornece
DELIMITER $$
CREATE PROCEDURE OqueFornece (IN id INT) 
BEGIN
	SELECT C.Ingrediente AS Ingrediente
		FROM catalogo AS C
		WHERE C.Id_Fornecedor = id;
END; $$
DELIMITER ;

-- CALL OqueFornece(1);
-- CALL OqueFornece(4);
-- DROP PROCEDURE OqueFornece;

-- FUNCTIONS

-- Function verificar o stock de um determinado ingrediente

-- SELECT temStock(17);
-- SELECT temStock(7);
-- DROP FUNCTION temStock;


DELIMITER $$
CREATE FUNCTION temStock (ing INT)
    RETURNS CHAR(3)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE res CHAR(3);
    SET res = (SELECT IF (I.Stock != 0, I.Stock, 0)
                    FROM Ingrediente AS I
                    WHERE I.Id = ing);
    RETURN res;
END; $$
DELIMITER ;


-- Function Total ja gasto por um cliente na pizzaria
DELIMITER $$
CREATE FUNCTION getTotGasto (c INT) 
	RETURNS DECIMAL(8,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE res DECIMAL(8,2);
    SET res = (SELECT SUM(P.Preco)
					FROM Pedido AS P 
					WHERE P.Id_cliente = c);
	RETURN res;
END; $$
DELIMITER ;

-- SELECT getTotGasto(81826);
-- DROP FUNCTION getTotGasto;


-- INDICE PARA Emails do Cliente 

ALTER TABLE Cliente
	ADD INDEX Email(Email);
    
SELECT * FROM Cliente WHERE Email = "a81826@alunos.uminho.pt";
    
-- DROP INDEX Email ON Cliente;