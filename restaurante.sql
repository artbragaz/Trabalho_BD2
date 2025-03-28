-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema restaurante
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema restaurante
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `restaurante` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `cpf` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NULL,
  `total` VARCHAR(45) NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Atendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Atendente` (
  `matricula` CHAR NOT NULL,
  `nome` VARCHAR(45) NULL,
  `salario` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `Atendente_matricula` CHAR NOT NULL,
  PRIMARY KEY (`matricula`),
  INDEX `fk_Atendente_Atendente1_idx` (`Atendente_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Atendente_Atendente1`
    FOREIGN KEY (`Atendente_matricula`)
    REFERENCES `mydb`.`Atendente` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mesa` (
  `numeroMesa` CHAR NOT NULL,
  `Cliente_cpf` INT NOT NULL,
  PRIMARY KEY (`numeroMesa`, `Cliente_cpf`),
  INDEX `fk_Mesa_Cliente1_idx` (`Cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_Mesa_Cliente1`
    FOREIGN KEY (`Cliente_cpf`)
    REFERENCES `mydb`.`Cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `numPedido` INT NOT NULL AUTO_INCREMENT,
  `horaInicio` VARCHAR(45) NULL,
  `horaFim` VARCHAR(45) NULL,
  `tempo` TIME NULL,
  `Atendente_matricula` CHAR NOT NULL,
  `Mesa_numeroMesa` CHAR NOT NULL,
  `Mesa_Cliente_cpf` INT NOT NULL,
  PRIMARY KEY (`numPedido`),
  INDEX `fk_Pedido_Atendente1_idx` (`Atendente_matricula` ASC) VISIBLE,
  INDEX `fk_Pedido_Mesa1_idx` (`Mesa_numeroMesa` ASC, `Mesa_Cliente_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Atendente1`
    FOREIGN KEY (`Atendente_matricula`)
    REFERENCES `mydb`.`Atendente` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Mesa1`
    FOREIGN KEY (`Mesa_numeroMesa` , `Mesa_Cliente_cpf`)
    REFERENCES `mydb`.`Mesa` (`numeroMesa` , `Cliente_cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prato` (
  `codPrato` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NULL,
  `preco` INT NULL,
  `Pedido_numPedido` INT NOT NULL,
  INDEX `fk_Prato_Pedido_idx` (`Pedido_numPedido` ASC) VISIBLE,
  PRIMARY KEY (`codPrato`),
  CONSTRAINT `fk_Prato_Pedido`
    FOREIGN KEY (`Pedido_numPedido`)
    REFERENCES `mydb`.`Pedido` (`numPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bebida` (
  `codBebida` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NULL,
  `preco` INT NULL,
  `Pedido_numPedido` INT NOT NULL,
  INDEX `fk_Bebida_Pedido1_idx` (`Pedido_numPedido` ASC) VISIBLE,
  PRIMARY KEY (`codBebida`),
  CONSTRAINT `fk_Bebida_Pedido1`
    FOREIGN KEY (`Pedido_numPedido`)
    REFERENCES `mydb`.`Pedido` (`numPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `restaurante` ;

-- -----------------------------------------------------
-- Table `restaurante`.`atendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurante`.`atendente` (
  `matricula` SMALLINT(3) UNSIGNED ZEROFILL NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `salario` DECIMAL(10,2) NOT NULL,
  `matricula_senior` SMALLINT(3) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  PRIMARY KEY (`matricula`),
  INDEX `FK_Atend_Senior` (`matricula_senior` ASC) VISIBLE,
  CONSTRAINT `FK_Atend_Senior`
    FOREIGN KEY (`matricula_senior`)
    REFERENCES `restaurante`.`atendente` (`matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurante`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurante`.`cliente` (
  `cpf` CHAR(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurante`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurante`.`item` (
  `cod_item` SMALLINT UNSIGNED NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  `tipo` ENUM('prato', 'bebida') NOT NULL,
  PRIMARY KEY (`cod_item`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurante`.`mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurante`.`mesa` (
  `numero` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`numero`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurante`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurante`.`pedido` (
  `num_pedido` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cpf_cliente` CHAR(11) NOT NULL,
  `matricula_atendente` SMALLINT(3) UNSIGNED ZEROFILL NOT NULL,
  `numero_mesa` SMALLINT UNSIGNED NOT NULL,
  `hora_inicio` DATETIME NOT NULL,
  `hora_fim` DATETIME NOT NULL,
  `duracao` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`num_pedido`),
  INDEX `FK_Pedido_Cliente` (`cpf_cliente` ASC) VISIBLE,
  INDEX `FK_Pedido_Atendente` (`matricula_atendente` ASC) VISIBLE,
  INDEX `FK_Pedido_Mesa` (`numero_mesa` ASC) VISIBLE,
  CONSTRAINT `FK_Pedido_Atendente`
    FOREIGN KEY (`matricula_atendente`)
    REFERENCES `restaurante`.`atendente` (`matricula`),
  CONSTRAINT `FK_Pedido_Cliente`
    FOREIGN KEY (`cpf_cliente`)
    REFERENCES `restaurante`.`cliente` (`cpf`),
  CONSTRAINT `FK_Pedido_Mesa`
    FOREIGN KEY (`numero_mesa`)
    REFERENCES `restaurante`.`mesa` (`numero`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurante`.`pedido_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurante`.`pedido_item` (
  `num_pedido` INT UNSIGNED NOT NULL,
  `cod_item` SMALLINT UNSIGNED NOT NULL,
  `quantidade` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`num_pedido`, `cod_item`),
  INDEX `FK_Item_Pedido` (`cod_item` ASC) VISIBLE,
  CONSTRAINT `FK_Item_Pedido`
    FOREIGN KEY (`cod_item`)
    REFERENCES `restaurante`.`item` (`cod_item`),
  CONSTRAINT `FK_Pedido_Item`
    FOREIGN KEY (`num_pedido`)
    REFERENCES `restaurante`.`pedido` (`num_pedido`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurante`.`telefone_atendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurante`.`telefone_atendente` (
  `matricula_atendente` SMALLINT(3) UNSIGNED ZEROFILL NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`matricula_atendente`, `telefone`),
  CONSTRAINT `FK_Telefone_Atendente`
    FOREIGN KEY (`matricula_atendente`)
    REFERENCES `restaurante`.`atendente` (`matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
