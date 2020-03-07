-- Guardar entrada de Stock em Registo 
 
 USE Pizzaria;

-- DROP TABLE EntradaStock;

-- Guardar entrada e saída de Stock em Registo 
 
 CREATE TABLE EntradaStock (
	id INT AUTO_INCREMENT PRIMARY KEY,
    Ingrediente VARCHAR(45),
    StockAntigo INT NOT NULL,
    StockAtualizado INT NOT NULL,
    Fornecedor INT NOT NULL,
    DataMudanca DATETIME DEFAULT NULL
);

-- DROP TRIGGER after_atualizaStock;
SELECT * FROM EntradaStock;
SELECT * FROM Ingrediente;

DELIMITER &$$ 
CREATE TRIGGER after_atualizaStock
	AFTER UPDATE ON Ingrediente 
    FOR EACH ROW 
BEGIN 
	INSERT INTO EntradaStock 
    SET Ingrediente = OLD.Nome, 
		StockAntigo = OLD.Stock,
        StockAtualizado = NEW.Stock,  
        Fornecedor = OLD.Id_Fornecedor,
        DataMudanca = NOW();
END; &$$
DELIMITER ;

UPDATE Ingrediente
	SET Stock = 27
    WHERE Id = 8