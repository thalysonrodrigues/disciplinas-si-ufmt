-- MySQL Script generated by MySQL Workbench
-- Sun Jul 16 20:43:20 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Gravadora
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Gravadora
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Gravadora` DEFAULT CHARACTER SET utf8 ;
USE `Gravadora` ;

-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Bandas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Bandas` (
  `idBanda` INT NOT NULL AUTO_INCREMENT,
  `ban_nome` VARCHAR(40) NOT NULL,
  `ban_dataCriacao` DATE NOT NULL,
  PRIMARY KEY (`idBanda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Musicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Musicos` (
  `idMusico` INT NOT NULL AUTO_INCREMENT,
  `mus_nome` VARCHAR(100) NOT NULL,
  `mus_nomeArt` VARCHAR(40) NOT NULL,
  `mus_cpf` VARCHAR(11) NOT NULL,
  `mus_dataNasc` DATE NOT NULL,
  `mus_compositor` TINYINT NOT NULL,
  PRIMARY KEY (`idMusico`),
  UNIQUE INDEX `mus_cpf_UNIQUE` (`mus_cpf` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Cancoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Cancoes` (
  `idCancao` INT NOT NULL AUTO_INCREMENT,
  `can_titulo` VARCHAR(40) NOT NULL,
  `can_letra` TEXT(10000) NOT NULL,
  PRIMARY KEY (`idCancao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Cancoes_Compositores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Cancoes_Compositores` (
  `idCancao` INT NOT NULL,
  `idMusicos` INT NOT NULL,
  INDEX `fk_Cancoes_Comp_Cancoes1_idx` (`idCancao` ASC),
  INDEX `fk_Cancoes_Comp_Musicos1_idx` (`idMusicos` ASC),
  PRIMARY KEY (`idCancao`, `idMusicos`),
  CONSTRAINT `fk_Cancoes_Comp_Cancoes1`
    FOREIGN KEY (`idCancao`)
    REFERENCES `Gravadora`.`Gra_Cancoes` (`idCancao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cancoes_Comp_Musicos1`
    FOREIGN KEY (`idMusicos`)
    REFERENCES `Gravadora`.`Gra_Musicos` (`idMusico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Estados` (
  `idEstado` INT NOT NULL AUTO_INCREMENT,
  `est_nome` VARCHAR(32) NOT NULL,
  `est_sigla` CHAR(2) NOT NULL,
  PRIMARY KEY (`idEstado`),
  UNIQUE INDEX `est_nome_UNIQUE` (`est_nome` ASC),
  UNIQUE INDEX `est_sigla_UNIQUE` (`est_sigla` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Cidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Cidades` (
  `idCidade` INT NOT NULL AUTO_INCREMENT,
  `cid_nome` VARCHAR(40) NOT NULL,
  `idEstado` INT NOT NULL,
  PRIMARY KEY (`idCidade`, `idEstado`),
  INDEX `fk_Cidades_Estados1_idx` (`idEstado` ASC),
  CONSTRAINT `fk_Cidades_Estados1`
    FOREIGN KEY (`idEstado`)
    REFERENCES `Gravadora`.`Gra_Estados` (`idEstado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Bairros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Bairros` (
  `idBairro` INT NOT NULL AUTO_INCREMENT,
  `bai_nome` VARCHAR(50) NOT NULL,
  `idCidade` INT NOT NULL,
  PRIMARY KEY (`idBairro`, `idCidade`),
  INDEX `fk_Bairros_Cidades1_idx` (`idCidade` ASC),
  CONSTRAINT `fk_Bairros_Cidades1`
    FOREIGN KEY (`idCidade`)
    REFERENCES `Gravadora`.`Gra_Cidades` (`idCidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Enderecos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Enderecos` (
  `idEndereco` INT NOT NULL AUTO_INCREMENT,
  `end_logradouro` VARCHAR(128) NOT NULL,
  `end_numero` INT NOT NULL,
  `end_complemento` VARCHAR(72) NULL,
  `idBairro` INT NOT NULL,
  PRIMARY KEY (`idEndereco`, `idBairro`),
  INDEX `fk_Enderecos_Bairros1_idx` (`idBairro` ASC),
  CONSTRAINT `fk_Enderecos_Bairros1`
    FOREIGN KEY (`idBairro`)
    REFERENCES `Gravadora`.`Gra_Bairros` (`idBairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Discos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Discos` (
  `idDisco` INT NOT NULL AUTO_INCREMENT,
  `dis_titulo` VARCHAR(30) NOT NULL,
  `dis_produtor` VARCHAR(45) NOT NULL,
  `idEndereco` INT NOT NULL,
  PRIMARY KEY (`idDisco`, `idEndereco`),
  INDEX `fk_Discos_Enderecos1_idx` (`idEndereco` ASC),
  CONSTRAINT `fk_Discos_Enderecos1`
    FOREIGN KEY (`idEndereco`)
    REFERENCES `Gravadora`.`Gra_Enderecos` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Bandas_Discos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Bandas_Discos` (
  `idBanda` INT NOT NULL,
  `idDisco` INT NOT NULL,
  INDEX `fk_Bandas_Discos_Bandas1_idx` (`idBanda` ASC),
  INDEX `fk_Bandas_Discos_Discos1_idx` (`idDisco` ASC),
  PRIMARY KEY (`idBanda`, `idDisco`),
  CONSTRAINT `fk_Bandas_Discos_Bandas1`
    FOREIGN KEY (`idBanda`)
    REFERENCES `Gravadora`.`Gra_Bandas` (`idBanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bandas_Discos_Discos1`
    FOREIGN KEY (`idDisco`)
    REFERENCES `Gravadora`.`Gra_Discos` (`idDisco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Papeis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Papeis` (
  `idPapel` INT NOT NULL AUTO_INCREMENT,
  `pap_descricao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idPapel`),
  UNIQUE INDEX `pap_descricao_UNIQUE` (`pap_descricao` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Bandas_Musicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Bandas_Musicos` (
  `idMusico` INT NOT NULL,
  `idBanda` INT NOT NULL,
  `idPapel` INT NOT NULL,
  INDEX `fk_Bandas_Musicos_Musicos1_idx` (`idMusico` ASC),
  PRIMARY KEY (`idMusico`, `idBanda`, `idPapel`),
  INDEX `fk_Bandas_Musicos_Bandas1_idx` (`idBanda` ASC),
  INDEX `fk_Gra_Bandas_Musicos_Gra_Papeis1_idx` (`idPapel` ASC),
  CONSTRAINT `fk_Bandas_Musicos_Musicos1`
    FOREIGN KEY (`idMusico`)
    REFERENCES `Gravadora`.`Gra_Musicos` (`idMusico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bandas_Musicos_Bandas1`
    FOREIGN KEY (`idBanda`)
    REFERENCES `Gravadora`.`Gra_Bandas` (`idBanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gra_Bandas_Musicos_Gra_Papeis1`
    FOREIGN KEY (`idPapel`)
    REFERENCES `Gravadora`.`Gra_Papeis` (`idPapel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gravadora`.`Gra_Discos_Cancoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`Gra_Discos_Cancoes` (
  `idDisco` INT NOT NULL,
  `idCancao` INT NOT NULL,
  PRIMARY KEY (`idDisco`, `idCancao`),
  INDEX `fk_Discos_Cancoes_Discos1_idx` (`idDisco` ASC),
  INDEX `fk_Discos_Cancoes_Cancoes1_idx` (`idCancao` ASC),
  CONSTRAINT `fk_Discos_Cancoes_Discos1`
    FOREIGN KEY (`idDisco`)
    REFERENCES `Gravadora`.`Gra_Discos` (`idDisco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Discos_Cancoes_Cancoes1`
    FOREIGN KEY (`idCancao`)
    REFERENCES `Gravadora`.`Gra_Cancoes` (`idCancao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `Gravadora` ;

-- -----------------------------------------------------
-- Placeholder table for view `Gravadora`.`vw_DiscoLocalGravacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gravadora`.`vw_DiscoLocalGravacao` (`dis_titulo` INT, `dis_produtor` INT, `end_logradouro` INT, `bai_nome` INT, `cid_nome` INT, `est_nome` INT, `est_sigla` INT);

-- -----------------------------------------------------
-- View `Gravadora`.`vw_DiscoLocalGravacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gravadora`.`vw_DiscoLocalGravacao`;
USE `Gravadora`;
CREATE  OR REPLACE VIEW `vw_DiscoLocalGravacao` AS
SELECT 
gra_discos.dis_titulo,
gra_discos.dis_produtor,
gra_enderecos.end_logradouro,
gra_bairros.bai_nome,
gra_cidades.cid_nome,
gra_estados.est_nome,
gra_estados.est_sigla
FROM gravadora.gra_discos
INNER JOIN gravadora.gra_enderecos
ON gra_enderecos.idEndereco = gra_discos.idEndereco
INNER JOIN gravadora.gra_bairros
ON gra_bairros.idBairro = gra_enderecos.idBairro
INNER JOIN gravadora.gra_cidades
ON gra_cidades.idCidade = gra_bairros.idCidade
INNER JOIN gravadora.gra_estados
ON gra_estados.idEstado = gra_cidades.idEstado;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;