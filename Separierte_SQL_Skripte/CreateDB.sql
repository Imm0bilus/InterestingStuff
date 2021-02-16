-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema IT-TERMS
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `IT-TERMS` ;

-- -----------------------------------------------------
-- Schema IT-TERMS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `IT-TERMS` DEFAULT CHARACTER SET utf8 ;
USE `IT-TERMS` ;

-- -----------------------------------------------------
-- Table `IT-TERMS`.`Groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IT-TERMS`.`Groups` ;

CREATE TABLE IF NOT EXISTS `IT-TERMS`.`Groups` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IT-TERMS`.`Terms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IT-TERMS`.`Terms` ;

CREATE TABLE IF NOT EXISTS `IT-TERMS`.`Terms` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Description` NVARCHAR(800) NULL,
  `GroupID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC),
  INDEX `fk_Terms_Groups_idx` (`GroupID` ASC),
  CONSTRAINT `fk_Terms_Groups`
    FOREIGN KEY (`GroupID`)
    REFERENCES `IT-TERMS`.`Groups` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IT-TERMS`.`Log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `IT-TERMS`.`Log` ;

CREATE TABLE IF NOT EXISTS `IT-TERMS`.`Log` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Table` NVARCHAR(20) NOT NULL,
  `Datetime` DATETIME NOT NULL DEFAULT NOW(),
  `Event` NVARCHAR(20) NOT NULL,
  `User` NVARCHAR(50) NOT NULL,
  `AffectedRow` INT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
