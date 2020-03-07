USE pizzaria;

/*
Criação de um administrador (dono)
*/
CREATE USER 'admin'@'localhost';
	SET PASSWORD FOR 'admin'@'localhost' = 'admin';

-- DROP USER admin@localhost;
-- DROP USER 'emp1'@'localhost';
    
/*
Criação funcionário
(Criamos 1 funcionario porque neste momento apenas temos um, se for adicionado um novo são lhe dadas as respetivas permissões)
*/
CREATE USER 'emp1'@'localhost';
	SET PASSWORD FOR 'emp1'@'localhost' = 'emp1';
    
/*
Permissões para o administrador
*/
GRANT SELECT, INSERT, UPDATE, DELETE ON pizzaria.* TO 'admin'@'localhost';

/*
Permissões para os funcionários
*/
-- Tabela Cliente
GRANT SELECT, INSERT, UPDATE ON pizzaria.Cliente TO 'emp1'@'localhost';
                                                    
REVOKE DELETE ON pizzaria.Cliente FROM 'emp1'@'localhost';

-- Tabela ClienteContacto
GRANT SELECT, INSERT, UPDATE ON pizzaria.ClienteContacto TO 'emp1'@'localhost';
                                                   
REVOKE DELETE ON pizzaria.ClienteContacto FROM 'emp1'@'localhost';
                                                    
-- Tabela Pedido
GRANT SELECT, INSERT, UPDATE ON pizzaria.Pedido TO 'emp1'@'localhost';
                                                   
REVOKE DELETE ON pizzaria.Pedido FROM 'emp1'@'localhost';
                                      
-- Tabela Ingrediente
GRANT SELECT, UPDATE ON pizzaria.Ingrediente TO 'emp1'@'localhost';
                                                   
REVOKE INSERT, DELETE ON pizzaria.Ingrediente FROM 'emp1'@'localhost';
                                                   
-- Tabela Fornecedor
GRANT SELECT ON pizzaria.Fornecedor TO 'emp1'@'localhost';
                                                   
REVOKE INSERT, UPDATE, DELETE ON pizzaria.Fornecedor FROM 'emp1'@'localhost';
                                                          
-- Tabela PedidoIngrediente
GRANT SELECT, INSERT, UPDATE ON pizzaria.PedidoIngrediente TO 'emp1'@'localhost';
                                                   
REVOKE DELETE ON pizzaria.PedidoIngrediente FROM 'emp1'@'localhost';
                                                          
-- Tabela Empregado
GRANT SELECT ON pizzaria.Empregado TO 'emp1'@'localhost';
                                                   
REVOKE INSERT, UPDATE, DELETE ON pizzaria.Empregado FROM 'emp1'@'localhost';