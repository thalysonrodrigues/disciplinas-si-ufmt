-- MySQL Script generated by MySQL Workbench
-- Tue Aug 29 14:50:35 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Cidades
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Cidades
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Cidades` DEFAULT CHARACTER SET utf8 ;
USE `Cidades` ;

-- -----------------------------------------------------
-- Table `Cidades`.`Paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cidades`.`Paises` (
  `idPais` INT NOT NULL AUTO_INCREMENT,
  `NomePais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cidades`.`Estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cidades`.`Estados` (
  `idEstado` INT NOT NULL AUTO_INCREMENT,
  `NomeEstado` VARCHAR(45) NOT NULL,
  `Sigla` VARCHAR(2) NOT NULL,
  `idPais` INT NOT NULL,
  PRIMARY KEY (`idEstado`, `idPais`),
  INDEX `fk_Estados_Paises1_idx` (`idPais` ASC),
  CONSTRAINT `fk_Estados_Paises1`
    FOREIGN KEY (`idPais`)
    REFERENCES `Cidades`.`Paises` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cidades`.`Cidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cidades`.`Cidades` (
  `idCidade` INT NOT NULL AUTO_INCREMENT,
  `NomeCidade` VARCHAR(45) NOT NULL,
  `idEstado` INT NOT NULL,
  PRIMARY KEY (`idCidade`, `idEstado`),
  INDEX `fk_Cidades_Estados_idx` (`idEstado` ASC),
  CONSTRAINT `fk_Cidades_Estados`
    FOREIGN KEY (`idEstado`)
    REFERENCES `Cidades`.`Estados` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;