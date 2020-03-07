DROP PROCEDURE insereIngredienteNoPedido;

DELIMITER $$ 
CREATE PROCEDURE insereIngredienteNoPedido (IN pedidoID INT, IN ingredienteID INT, IN Qt INT) 
BEGIN
	DECLARE  Erro BOOLEAN DEFAULT 0;
    DECLARE precoV DECIMAL(8,2);
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET Erro = 1;
    
    START TRANSACTION; 
    
    INSERT INTO PedidoIngrediente (Id_pedido,Id_ingrediente,Preco,Quantidade) 
		VALUES (pedidoID, ingredienteID, 0.00, Qt); 
    
    SET precoV = (SELECT PrecoVenda 
					FROM Ingrediente AS I
                    WHERE I.Id = ingredienteID);
    
    UPDATE PedidoIngrediente SET Preco = (PedidoIngrediente.Quantidade*precoV) 
		WHERE Id_pedido = pedidoID AND Id_Ingrediente = ingredienteID;
    
    UPDATE Ingrediente SET Stock = Stock - Qt WHERE Id = ingredienteID;
    
    UPDATE Pedido SET Preco = Preco + (SELECT Preco 
										FROM PedidoIngrediente 
											WHERE Id_pedido = pedidoID AND Id_Ingrediente = ingredienteID)
			WHERE Id = pedidoID;
	
    IF Erro = 1 
	THEN ROLLBACK;
	ELSE COMMIT;
	END IF;
END; 
$$
DELIMITER ;

-- Experimentar inserir Agua das Pedras no pedido 1 

CALL insereIngredienteNoPedido(1,14,11);
CALL insereIngredienteNoPedido(1,15,7);

SELECT * FROM PedidoIngrediente WHERE Id_Pedido = 1;
SELECT * FROM Pedido WHERE Id = 1;
SELECT * FROM Ingrediente WHERE Id = 14;

-- undo
UPDATE PedidoIngrediente SET Quantidade = 7 WHERE Id_Pedido = 1 AND Id_Ingrediente = 14;

DELETE FROM PedidoIngrediente WHERE Id_Pedido = 1 AND Id_Ingrediente = 14;
UPDATE Ingrediente SET Stock = 10 WHERE Id = 14;
UPDATE Pedido SET Preco = 9.86 WHERE Id = 1;

SELECT PrecoVenda 
		FROM Ingrediente AS I
		WHERE I.Id = 14;
