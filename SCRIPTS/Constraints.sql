USE pizzaria;

-- UM PEDIDO NAO PODE TER MAIS QUANTIDADE DE UM INGREDIENTE DO QUE O STOCK EXISTENTE DESSE INGREDIENTE 

-- TRIGGER ANTES DE UM UPDATE NA TABELA PEDIDOINGREDIENTE 
  
DROP TRIGGER pedidoIngrediente_before_update;

DELIMITER $$
CREATE TRIGGER pedidoIngrediente_before_update
	BEFORE UPDATE ON PedidoIngrediente
    FOR EACH ROW
BEGIN
	IF (((temStock(NEW.Id_ingrediente)<NEW.Quantidade) OR NEW.Quantidade <= 0)=TRUE) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Quantidade de ingrediente maior que o stock existente';
	END IF;
END; $$
DELIMITER ;

  -- TRIGGER ANTES DE INSERIR INGREDIENTE NUM PEDIDO PARA VERIFICAR A QUANTIDADE A SER INSERIDA VS STOCK

DROP TRIGGER pedidoIngrediente_before_insert;

DELIMITER $$
CREATE TRIGGER pedidoIngrediente_before_insert
	BEFORE INSERT ON PedidoIngrediente
    FOR EACH ROW
BEGIN 
	IF (((temStock(NEW.Id_ingrediente)<NEW.Quantidade) OR NEW.Quantidade <= 0)=TRUE) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Quantidade de ingrediente maior que o stock existente';
	END IF;
END; $$
DELIMITER ;

 -- QUERIES DE TESTE AOS TRIGGERS ACIMA
UPDATE pedidoingrediente 
	SET quantidade = 11
    WHERE Id_pedido = 1 AND Id_Ingrediente = 8; 

SELECT * FROM PedidoIngrediente WHERE Id_Pedido = 1 AND Id_Ingrediente = 8;

DELETE FROM PedidoIngrediente WHERE Id_Ingrediente = 9; 

INSERT INTO PedidoIngrediente (Id_pedido, Id_ingrediente, Preco, Quantidade)
    VALUES (1,9,0.0,6);

SELECT * FROM PedidoIngrediente WHERE Id_Pedido = 1;

-- -------------------------------------------------------------------------
DROP TRIGGER Ingrediente_before_update;

DELIMITER $$
CREATE TRIGGER Ingrediente_before_update 
	BEFORE UPDATE ON Ingrediente
    FOR EACH ROW
BEGIN
	IF (NEW.Stock < 0) THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Quantidade de ingrediente inválida';
	END IF;
END; $$
DELIMITER ;