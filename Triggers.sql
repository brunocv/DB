USE pizzaria;

SELECT * FROM Ingrediente;

SELECT * FROM Pedido;

DROP TABLE IF EXISTS `Pizzaria`.`Ingredient`;

CREATE TABLE ingredient (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    nome VARCHAR(45) NOT NULL,
	preco DECIMAL(8,2) NOT NULL,
    id_fornecedor INT NOT NULL,
    stock INT NOT NULL,
    action VARCHAR(50) DEFAULT NULL
);

DROP TRIGGER

DELIMITER $$
CREATE TRIGGER after_atualizastock_produto 
    AFTER UPDATE ON Ingrediente
    FOR EACH ROW 
BEGIN
    INSERT INTO ingredient
    SET action = 'update',
    Id = OLD.Id,
    Nome = OLD.Nome,
	Preco = OLD.Preco,
    Id_fornecedor = OLD.Id_fornecedor,
    Stock = NOW();
END$$
DELIMITER;


UPDATE Ingrediente
SET Stock = 20
WHERE Id = 5