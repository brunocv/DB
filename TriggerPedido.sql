 
 CREATE TABLE PIngrediente (
	id INT AUTO_INCREMENT PRIMARY KEY,
    sucesso VARCHAR(3),
    ingrediente VARCHAR(40)
);



DELIMITER $$ 
CREATE 
	TRIGGER tentaPedidoIngrediente BEFORE INSERT 
    ON PedidoIngrediente 
    FOR EACH ROW 
BEGIN 
	SELECT PedidoIngrediente.Id_ingrediente, Ingrediente.Stock AS stock FROM PedidoIngrediente
    INNER JOIN Ingrediente ON NEW.Id_ingrediente = Ingrediente.Id
    
	IF NEW.Quantidade > stock THEN
		INSERT INTO PIngrediente(ingrediente,sucesso)VALUES (Ingrediente.Id, 'Nao');
	ELSEIF NEW.Quantidade<= stock THEN
		INSERT INTO PIngrediente(ingrediente,sucesso)VALUES (Ingrediente.Id, 'Sim');
	END IF;
     
END; $$
DELIMITER ;



DROP TRIGGER tentaPedidoIngrediente;