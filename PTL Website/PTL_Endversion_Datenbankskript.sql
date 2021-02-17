-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema ToiletPaper
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ToiletPaper` DEFAULT CHARACTER SET utf8 ;
USE `ToiletPaper` ;

-- -----------------------------------------------------
-- Table `ToiletPaper`.`Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ToiletPaper`.`Member` ;

CREATE TABLE IF NOT EXISTS `ToiletPaper`.`Member` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `eMail` VARCHAR(80) NOT NULL,
  `Password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `eMail_UNIQUE` (`eMail` ASC),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ToiletPaper`.`PersonalInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ToiletPaper`.`PersonalInfo` ;

CREATE TABLE IF NOT EXISTS `ToiletPaper`.`PersonalInfo` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Salutation` VARCHAR(10) NOT NULL,
  `FirstName` VARCHAR(40) NOT NULL,
  `LastName` VARCHAR(50) NOT NULL,
  `Birthdate` DATE NULL,
  `PhoneNumber` VARCHAR(30) NULL,
  `eMail` VARCHAR(80) NOT NULL,
  INDEX `fk_PersonalInfo_Member_idx` (`eMail` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  CONSTRAINT `fk_PersonalInfo_Member`
    FOREIGN KEY (`eMail`)
    REFERENCES `ToiletPaper`.`Member` (`eMail`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ToiletPaper`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ToiletPaper`.`Address` ;

CREATE TABLE IF NOT EXISTS `ToiletPaper`.`Address` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Street` VARCHAR(50) NOT NULL,
  `PostalCode` INT NOT NULL,
  `City` VARCHAR(40) NOT NULL,
  `State` VARCHAR(30) NOT NULL,
  `Country` VARCHAR(30) NOT NULL,
  `eMail` VARCHAR(80) NOT NULL,
  INDEX `fk_Address_Member1_idx` (`eMail` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  CONSTRAINT `fk_Address_Member1`
    FOREIGN KEY (`eMail`)
    REFERENCES `ToiletPaper`.`Member` (`eMail`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
