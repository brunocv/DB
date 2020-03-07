-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 2018/2019
--
-- Caso de Estudo: "Pizzaria Zé do Cartaxo" 
-- Script de Queries, Procedures, Functions and Triggres
-- Grupo 

-- Queries
-- SELECT something
-- 		FROM Tabel AS T
-- 			JOINS
-- 		WHERE ....
-- 		GROUP BY caso necessario
-- 		ORDER BY caso necessario;

-- Procedures
-- DROP PROCEDURE A;

-- DELIMITER $$
-- CREATE PROCEDURE A(vars)
-- BEGIN
-- 		SELECT ...
-- END $$

-- CALL A(vars);

-- Functions
-- DELIMITER %%
-- CREATE FUNCTION B(vars)
-- 		RETURNS (TYPE)
-- BEGIN
--   DO THINGS;
--   RETURN (TYPE);
-- END %%

-- CALL B(vars);

-- Triggers
-- DROP TRIGGER C;

-- DELIMITER $%
-- CREATE TRIGGER C AFTER INSERT ON Tabel
-- 	FOR EACH ROW
--    BEGIN
-- 		IF (SOMETHING) THEN
-- 			DO THIS;
--      END IF;
-- 	END $%