SET foreign_key_checks = 0;
DROP TABLE IF EXISTS `bazadanychduszka`.`kierunekstudenci` ;
DROP TABLE IF EXISTS `bazadanychduszka`.`grupastudenci` ;
DROP TABLE IF EXISTS `bazadanychduszka`.`studenci` ;
DROP TABLE IF EXISTS `bazadanychduszka`.`semestry` ;
DROP TABLE IF EXISTS `bazadanychduszka`.`przedmioty` ;
DROP TABLE IF EXISTS `bazadanychduszka`.`kierunki` ;
DROP TABLE IF EXISTS `bazadanychduszka`.`wykladowcy` ;
DROP TABLE IF EXISTS `bazadanychduszka`.`stopnie` ;
DROP TABLE IF EXISTS `bazadanychduszka`.`grupy` ;
DROP TABLE IF EXISTS `bazadanychduszka`.`tryby` ;
DROP TABLE IF EXISTS `bazadanychduszka`.`ocenyDEF` ;
DROP TABLE IF EXISTS `bazadanychduszka`.`oceny` ;
SET foreign_key_checks = 1;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `bazadanychduszka` DEFAULT CHARACTER SET utf8mb4 ;
USE `bazadanychduszka` ;
								   			
CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`grupy` (
  `grupaID` INT NOT NULL AUTO_INCREMENT,
  `Nazwa Grupy` VARCHAR(20) NOT NULL,
   PRIMARY KEY (`grupaID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`semestry` (
  `semestrID` INT NOT NULL AUTO_INCREMENT,
  `Numer Semestru` INT NOT NULL,
  PRIMARY KEY (`semestrID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`tryby` (
  `trybID` INT NOT NULL AUTO_INCREMENT,
  `Nazwa trybu` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`trybID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`ocenyDEF` (
  `ocenaDEFID` INT NOT NULL AUTO_INCREMENT,
  `Wartosc` FLOAT,
  PRIMARY KEY (`ocenaDEFID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;	
		
CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`oceny` (
  `ocenaID` INT NOT NULL AUTO_INCREMENT,
  `studentID` INT,
  `przedmiotID` INT,
  `ocenaDEFID` INT,
  PRIMARY KEY (`ocenaID`),
	FOREIGN KEY (`studentID`)
    REFERENCES `bazadanychduszka`.`studenci` (`studentID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`przedmiotID`)
    REFERENCES `bazadanychduszka`.`przedmioty` (`przedmiotID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`ocenaDEFID`)
    REFERENCES `bazadanychduszka`.`ocenyDEF` (`ocenaDEFID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;								  
CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`studenci` (
  `studentID` INT NOT NULL AUTO_INCREMENT,
  `Imie` VARCHAR(20) NOT NULL,
  `Nazwisko` VARCHAR(30) NOT NULL,
  `trybID` INT NOT NULL,
  `semestrID` INT NOT NULL,
  PRIMARY KEY (`studentID`),
    FOREIGN KEY (`semestrID`)
    REFERENCES `bazadanychduszka`.`semestry` (`semestrID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`trybID`)
    REFERENCES `bazadanychduszka`.`tryby` (`trybID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;						  

CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`grupastudenci` (
  `studentid` INT NOT NULL AUTO_INCREMENT,
  `grupaid` INT NOT NULL,
   PRIMARY KEY (`studentid`),
    FOREIGN KEY (`grupaid`)
    REFERENCES `bazadanychduszka`.`grupy` (`grupaID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`studentid`)
    REFERENCES `bazadanychduszka`.`studenci` (`studentID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`kierunki` (
  `kierunekID` INT NOT NULL AUTO_INCREMENT,
  `Nazwa kierunku` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`kierunekID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`kierunekstudenci` (
  `studentid` INT NOT NULL AUTO_INCREMENT,
  `kierunekid` INT NOT NULL,
    PRIMARY KEY (`studentid`),
    FOREIGN KEY (`kierunekid`)
    REFERENCES `bazadanychduszka`.`kierunki` (`kierunekID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`studentid`)
    REFERENCES `bazadanychduszka`.`studenci` (`studentID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`stopnie` (
  `stopienID` INT NOT NULL AUTO_INCREMENT,
  `Nazwa stopnia` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`stopienID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`wykladowcy` (
  `wykladowcaID` INT NOT NULL AUTO_INCREMENT,
  `Imie` VARCHAR(20) NOT NULL,
  `Nazwisko` VARCHAR(30) NOT NULL,
  `stopienid` INT NOT NULL,
  PRIMARY KEY (`wykladowcaID`),
    FOREIGN KEY (`stopienid`)
    REFERENCES `bazadanychduszka`.`stopnie` (`stopienID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `bazadanychduszka`.`przedmioty` (
  `przedmiotID` INT NOT NULL AUTO_INCREMENT,
  `Nazwa przedmiotu` VARCHAR(60),
  `kierunekid` INT NULL,
  `wykladowcyid` INT NULL,
  `grupyid` INT NULL,
  PRIMARY KEY (`przedmiotID`),
    FOREIGN KEY (`wykladowcyid`)
    REFERENCES `bazadanychduszka`.`wykladowcy` (`wykladowcaID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`grupyid`)
    REFERENCES `bazadanychduszka`.`grupy` (`grupaID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`kierunekid`)
    REFERENCES `bazadanychduszka`.`kierunki` (`kierunekID`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
