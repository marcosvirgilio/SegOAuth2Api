-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema seg
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema seg
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `seg` DEFAULT CHARACTER SET utf8 ;
USE `seg` ;

-- -----------------------------------------------------
-- Table `seg`.`segUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seg`.`segUsuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nmUsuario` VARCHAR(150) NOT NULL,
  `deSenha` VARCHAR(150) NOT NULL,
  `deEmail` VARCHAR(150) NOT NULL,
  `dtCadastro` DATE NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seg`.`segGrantType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seg`.`segGrantType` (
  `idGrantType` INT NOT NULL AUTO_INCREMENT,
  `deGrantType` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`idGrantType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seg`.`segAutenticacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seg`.`segAutenticacao` (
  `idAutenticacao` INT NOT NULL AUTO_INCREMENT,
  `deTokenEndpoint` VARCHAR(250) NOT NULL,
  `deClientSecret` VARCHAR(250) NOT NULL,
  `deToken` VARCHAR(250) NULL,
  `idUsuario` INT NOT NULL,
  `idGrantType` INT NOT NULL,
  PRIMARY KEY (`idAutenticacao`),
  INDEX `fk_segAutenticacao_segUsuario1_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `fk_segAutenticacao_segGrantType1_idx` (`idGrantType` ASC) VISIBLE,
  CONSTRAINT `fk_segAutenticacao_segUsuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `seg`.`segUsuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_segAutenticacao_segGrantType1`
    FOREIGN KEY (`idGrantType`)
    REFERENCES `seg`.`segGrantType` (`idGrantType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seg`.`segTela`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seg`.`segTela` (
  `idTela` INT NOT NULL AUTO_INCREMENT,
  `nmTela` VARCHAR(150) NOT NULL,
  `deURL` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idTela`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seg`.`segAcesso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seg`.`segAcesso` (
  `idUsuario` INT NOT NULL,
  `idTela` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `idTela`),
  INDEX `fk_segUsuario_has_segTela_segTela1_idx` (`idTela` ASC) VISIBLE,
  INDEX `fk_segUsuario_has_segTela_segUsuario_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_segUsuario_has_segTela_segUsuario`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `seg`.`segUsuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_segUsuario_has_segTela_segTela1`
    FOREIGN KEY (`idTela`)
    REFERENCES `seg`.`segTela` (`idTela`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO segusuario (idUsuario,nmUsuario,deSenha,deEmail,dtCadastro)
VALUES (1,'Um','um','um@mail.com','2025-05-19');

INSERT INTO seggranttype (idGrantType,deGrantType)
VALUES (1,' Authorization Code');
