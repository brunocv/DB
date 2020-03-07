-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 2018/2019
--
-- Caso de Estudo: "Pizzaria Zé do Cartaxo" 
-- Povoamento parcial da base de dados.
-- Grupo 

-- Base de dados de trabalho
USE Pizzaria;

-- Povoamento da tabela "Empregado"
INSERT INTO Empregado
	(Id, Nome)
	VALUES 
		(1, 'Antunes'),
		(2, 'Zé Cartaxo');
        
-- SELECT * FROM Empregado;
        
 -- Povoamento da tabela "Fornecedor"       
INSERT INTO Fornecedor
	(Id, Nome)
	VALUES 
		(1, 'Legumes Frescos'),
		(2, 'Conservas PT'),
		(3, 'Farinhas Portugal'),
		(4, 'Refrigerantes do Norte'),
        (5, 'Águas Fritalis');
        
-- SELECT * FROM Fornecedor;
    
-- Povoamento da tabela "Ingrediente"    
INSERT INTO Ingrediente 
	(Id, Nome, Stock, Preco, Id_fornecedor)
    VALUES
		(1, 'Farinha Trigo' , 20 , 0.30 , 3 ),
        (2, 'Farinha Mista' , 20 , 0.33 , 3 ),
        (3, 'Farinha Integral' , 20 , 0.35 , 3 ),
        (4, 'Azeitonas' , 13 , 0.99 , 2 ),
        (5, 'Fiambre' , 40 , 0.45 , 2),
        (6, 'Queijo' , 50 , 0.39 , 2),
        (7, 'Ananás' , 3 , 0.95 , 1 ),
        (8, 'Tomate' , 10 , 0.40 , 1 ),
        (9, 'Pimento' , 5 , 1.20 , 1 ),
        (10, 'Cebola' , 6 , 0.74 , 1 ),
        (11, 'Cogumelos' , 9 , 0.43 , 2 ),
        (12, 'Coca Cola' , 15 , 1.00 , 4 ),
        (13, 'Água' , 15 , 0.70 , 5 ),
        (14, 'Água Pedras' , 10 , 0.90 , 5 ),
        (15, 'Cerveja' , 8 , 1.20 , 4 ),
        (16, 'Ice Tea' , 12 , 1.00 , 4 );
        
INSERT INTO Ingrediente VALUES (17, 'Vinho' , 0 ,5.00,4);
        
-- SELECT * FROM Ingrediente;
        
-- Povoamento da tabela "Cliente"
INSERT INTO Cliente
	(Nr_contribuinte, Nome, DataNascimento, Localidade, Email)
    VALUES
		(81826 , 'Marques' , '1985-12-25' , 'Braga' , 'a81826@alunos.uminho.pt'),
        (80757 , 'Jaime' , '1956-11-07' , 'Braga' , 'a80757@alunos.uminho.pt'),
        (81918 , 'Rei' , '1989-05-27' , 'Braga' , NULL),
        (78352 , 'Bruno' , '1980-04-20' , 'Braga' , 'a78352@alunos.uminho.pt');
        
-- SELECT * FROM Cliente;
        
-- Povoamento da tabela "Pedido"
INSERT INTO Pedido
	(Id, Id_cliente, Id_empregado, Preco, Data)
    VALUES
		(1 , 81826 , 1 , 9.08 , '2018-11-11'),
        (2 , 81918 , 2 , 12.90 ,'2018-11-11'),
        (3 , 80757 , 1 , 7.20 , '2018-11-13'),
        (4 , 81826 , 2 , 6.36 , '2018-11-14'),
        (5 , 78352 , 2 , 7.54 , '2018-11-15'),
        (6 , 81918 , 2 , 13.38 , '2018-11-15'),
        (7 , 81826 , 1 , 14.82 , '2018-11-15');
        
-- SELECT * FROM Pedido;
        
-- Povoamento da tabela "PedidoIngrediente"
INSERT INTO PedidoIngrediente
	(Id_pedido, Id_ingrediente, Preco, Quantidade)
    VALUES
		(1 , 8 , 0.40 , 1),
        (1 , 12 , 2.00 , 2),
        (1 , 11 , 0.43 , 1),
        (1 , 2 , 0.33 , 1),
        (1 , 4 , 0.99 , 1),
        (1 , 6 , 0.78 , 2),
        (2 , 7 , 0.95 , 1),
        (2 , 8 , 0.40 , 1),
        (2 , 9 , 1.20 , 1),
        (2 , 10 , 0.74 , 1),
        (2 , 11 , 0.43 , 1),
        (2 , 16 , 1.00 , 1),
        (2 , 3 , 0.35 , 1),
        (2 , 4 , 0.99 , 1),
        (2 , 6 , 0.39 , 1),
        (3 , 12 , 2.00 , 2),
        (3 , 13 , 0.70 , 1),
        (3 , 14 , 0.90 , 1),
        (4 , 16 , 1.00 , 1),
        (4 , 3 , 0.35 , 1),
        (4 , 4 , 0.99 , 1),
        (4 , 5 , 0.45 , 1),
        (4 , 6 , 0.39 , 1),
        (5 , 7 , 0.95 , 1),
        (5 , 11 , 0.43 , 1),
        (5 , 15 , 1.20 , 1),
        (5 , 3 , 0.35 , 1),
        (5 , 5 , 0.45 , 1),
        (5 , 6 , 0.39 , 1),
        (6 , 7 , 0.95 , 1),
        (6 , 8 , 0.40 , 1),
        (6 , 11 , 0.43 , 1),
        (6 , 1 , 0.30 , 1),
        (6 , 2 , 0.33 , 1),
        (6 , 4 , 0.99 , 1),
        (6 , 5 , 0.90 , 2),
        (6 , 6 , 0.39 , 1),
        (7 , 9 , 1.20 , 1),
        (7 , 10 , 0.74 , 1),
        (7 , 13 , 0.70 , 1),
        (7 , 14 , 0.90 , 1),
        (7 , 15 , 1.20 , 1),
        (7 , 1 , 0.30 , 1),
        (7 , 4 , 1.98 , 2),
        (7 , 6 , 0.39 , 1);
        
-- SELECT * FROM PedidoIngrediente;
        
-- Povoamento da tabela "ClienteContacto"
INSERT INTO CLienteContacto
	(Id_cliente, Telefone)
    VALUES
		(81826,'912345678'),
        (80757,'987654321'),
        (81826,'911111111'),
        (81918,'123456789');
        
-- SELECT * FROM ClienteContacto;