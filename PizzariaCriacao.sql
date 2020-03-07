-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzaria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Pizzaria` ;

-- -----------------------------------------------------
-- Schema Pizzaria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzaria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzaria` ;

-- -----------------------------------------------------
-- Table `Pizzaria`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzaria`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `Pizzaria`.`Cliente` (
  `Nr_contribuinte` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `DataNascimento` DATE NOT NULL,
  `Localidade` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(50) NULL,
  PRIMARY KEY (`Nr_contribuinte`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzaria`.`Empregado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzaria`.`Empregado` ;

CREATE TABLE IF NOT EXISTS `Pizzaria`.`Empregado` (
  `Id` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzaria`.`Fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzaria`.`Fornecedor` ;

CREATE TABLE IF NOT EXISTS `Pizzaria`.`Fornecedor` (
  `Id` INT NOT NULL,
  `Nome` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzaria`.`Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzaria`.`Pedido` ;

CREATE TABLE IF NOT EXISTS `Pizzaria`.`Pedido` (
  `Id` INT NOT NULL,
  `Id_cliente` INT NOT NULL,
  `Id_empregado` INT NOT NULL,
  `Preco` DECIMAL(8,2) NOT NULL,
  `Data` DATE NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Pedido_Cliente1_idx` (`Id_cliente` ASC) VISIBLE,
  INDEX `fk_Pedido_Empregado1_idx` (`Id_empregado` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Id_cliente`)
    REFERENCES `Pizzaria`.`Cliente` (`Nr_contribuinte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Empregado1`
    FOREIGN KEY (`Id_empregado`)
    REFERENCES `Pizzaria`.`Empregado` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzaria`.`Ingrediente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzaria`.`Ingrediente` ;

CREATE TABLE IF NOT EXISTS `Pizzaria`.`Ingrediente` (
  `Id` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Stock` INT NOT NULL,
  `Preco` DECIMAL(8,2) NOT NULL,
  `Id_fornecedor` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Ingrediente_Fornecedor1_idx` (`Id_fornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Ingrediente_Fornecedor1`
    FOREIGN KEY (`Id_fornecedor`)
    REFERENCES `Pizzaria`.`Fornecedor` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzaria`.`PedidoIngrediente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzaria`.`PedidoIngrediente` ;

CREATE TABLE IF NOT EXISTS `Pizzaria`.`PedidoIngrediente` (
  `Id_pedido` INT NOT NULL,
  `Id_ingrediente` INT NOT NULL,
  `Preco` DECIMAL(8,2) NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Id_pedido`, `Id_ingrediente`),
  INDEX `fk_PedidoIngrediente_Ingrediente1_idx` (`Id_ingrediente` ASC) VISIBLE,
  CONSTRAINT `fk_PedidoIngrediente_Ingrediente1`
    FOREIGN KEY (`Id_ingrediente`)
    REFERENCES `Pizzaria`.`Ingrediente` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PedidoIngrediente_Pedido1`
    FOREIGN KEY (`Id_pedido`)
    REFERENCES `Pizzaria`.`Pedido` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzaria`.`CLienteContacto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzaria`.`CLienteContacto` ;

CREATE TABLE IF NOT EXISTS `Pizzaria`.`CLienteContacto` (
  `Id_cliente` INT NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_cliente`, `Telefone`),
  CONSTRAINT `fk_CLienteContacto_Cliente1`
    FOREIGN KEY (`Id_cliente`)
    REFERENCES `Pizzaria`.`Cliente` (`Nr_contribuinte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
