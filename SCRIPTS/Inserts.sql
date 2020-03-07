-- Procedure para criar um novo pedido

DROP PROCEDURE criaNovoPedido;

DELIMITER $$ 
CREATE PROCEDURE criaNovoPedido (IN clienteID INT, IN empregadoID INT) 
BEGIN
	DECLARE novoID INT;
    SET novoID = (SELECT (MAX(Id)+1) FROM Pedido);
	INSERT INTO Pedido (Id, Id_cliente, Id_empregado, Preco, Data) 
		VALUES(novoID, clienteID, empregadoID, 0.00, DATE(NOW()));
END;
$$
DELIMITER ;


CALL criaNovoPedido(81826,2);
SELECT * FROM Pedido;

-- Inserir um novo Ingrediente 

DROP PROCEDURE novoIngrediente;

DELIMITER $$
CREATE PROCEDURE novoIngrediente (IN nomeI VARCHAR(45), IN qt INT, IN PrecoC DECIMAL(8,2), PrecoV DECIMAL(8,2), IN fornecedorID INT) 
BEGIN
	DECLARE novoID INT;
    SET novoID = (SELECT (MAX(Id)+1) FROM Ingrediente);
	INSERT INTO Ingrediente (Id, Nome, Stock, PrecoCompra, PrecoVenda, Id_fornecedor) 
		VALUES(novoID, nomeI, qt, PrecoC, PrecoV, fornecedorID);
END;
$$
DELIMITER ;

CALL novoIngrediente('Pepperoni',50,0.10,0.20,2);
DELETE FROM Ingrediente WHERE Id = 5 AND Nome = 'Fiambre';
SELECT * FROM Ingrediente;

-- Inserir novo Fornecedor 

DROP PROCEDURE novoFornecedor;

DELIMITER $$
CREATE PROCEDURE novoFornecedor (IN Nfornecedor VARCHAR(45)) 
BEGIN
	DECLARE novoID INT;
    SET novoID = (SELECT (MAX(Id)+1) FROM Fornecedor);
	INSERT INTO Fornecedor (Id, Nome) 
		VALUES(novoID, Nfornecedor);
END;
$$
DELIMITER ;

CALL novoFornecedor('frescos');
SELECT * FROM Fornecedor;

DROP PROCEDURE novoCliente; 

DELIMITER $$
CREATE PROCEDURE novoCliente (IN nContribuinte INT, IN n VARCHAR(45), dNascimento DATE, IN localid VARCHAR(45), IN eEmail VARCHAR(50)) 
BEGIN 
	INSERT INTO cliente (Nr_contribuinte,Nome,DataNascimento,Localidade,Email)
		VALUES(nContribuinte,n,dNascimento,localid,eEmail);
END; 
$$
DELIMITER ;

CALL novoCliente(81112 , "antonio" , '1986-12-25' , "Braga" , "a81111@alunos.uminho.pt");
SELECT * FROM Cliente;

DROP PROCEDURE insereContactoCliente;

DELIMITER $$
CREATE PROCEDURE insereContactoCliente (IN nContribuinte INT, IN Tlf VARCHAR(9))  
BEGIN
	INSERT INTO clientecontacto (Id_cliente, Telefone)
		VALUES(nContribuinte,Tlf);
END;
$$ 
DELIMITER ;

CALL insereContactoCliente(81826 , "911111112");
SELECT * FROM ClienteContacto;

DELIMITER $$
CREATE PROCEDURE novoEmpregado (IN n VARCHAR(45), IN eEmail VARCHAR(45), IN Tlf VARCHAR(9), IN nC INT, IN Locald VARCHAR(20)) 
BEGIN 
	DECLARE novoID INT;
    SET novoID = (SELECT (MAX(Id)+1) FROM empregado);
	INSERT INTO empregado (Id, Nome, Email, Telefone, NIF, Localidade) 
		VALUES(novoID, n, eEmail, Tlf, nC, Locald);
END;
$$
DELIMITER ;

CALL novoEmpregado('Ricardo' , null , '912391919' , 13579 , 'Porto');
SELECT * FROM Empregado;