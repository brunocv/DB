USE pizzaria;

DELIMITER $$
 
CREATE PROCEDURE nomes_Clientes(INOUT listaNomes varchar(4000))
BEGIN
 
 DECLARE v_finished INTEGER DEFAULT 0;
        DECLARE verNome varchar(50) DEFAULT "";
 
 DEClARE nome_cursor CURSOR FOR 
 SELECT Nome FROM Cliente;
 
 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = 1;
 
 OPEN nome_Cursor;
 
 obter_nomes: LOOP
 
 FETCH nome_Cursor INTO verNome;
 
 IF v_finished = 1 THEN 
 LEAVE obter_nomes;
 END IF;
 
 SET listaNomes = verNome;
 
 END LOOP obter_nomes;
 
 CLOSE nome_cursor;
 
END$$
 
DELIMITER ;
DROP PROCEDURE nomes_Clientes;
SET @listaNomes = "";
CALL nomes_Clientes(@listaNomes);
SELECT @listaNomes;