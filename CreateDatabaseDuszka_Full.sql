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

INSERT INTO `bazadanychduszka`.`grupy` (`Nazwa Grupy`) VALUES ('L01');
INSERT INTO `bazadanychduszka`.`grupy` (`Nazwa Grupy`) VALUES ('L02');
INSERT INTO `bazadanychduszka`.`grupy` (`Nazwa Grupy`) VALUES ('L03');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('architektura');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('automatyka i robotyka');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('bezpieczeństwo wewnętrzne');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('biotechnologia');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('budownictwo');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('elektronika i telekomunikacja');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('elektrotechnika');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('energetyka');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('europeistyka');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('finanse i rachunkowość');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('fizyka techniczna');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('informatyka');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('inżynieria materiałowa');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('inżynieria środowiska');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('logistyka');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('lotnictwo i kosmonautyka');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('matematyka');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('mechanika i budowa maszyn');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('mechatronika');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('ochrona środowiska');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('stosunki międzynarodowe');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('technologia chemiczna');
INSERT INTO `bazadanychduszka`.`kierunki` (`Nazwa kierunku`) VALUES ('zarządzanie i marketing');
INSERT INTO `bazadanychduszka`.`stopnie` (`Nazwa stopnia`) VALUES ('Adiunkt');
INSERT INTO `bazadanychduszka`.`stopnie` (`Nazwa stopnia`) VALUES ('Asystent');
INSERT INTO `bazadanychduszka`.`stopnie` (`Nazwa stopnia`) VALUES ('Doktorant');
INSERT INTO `bazadanychduszka`.`tryby` (`Nazwa trybu`) VALUES ('Stacjonarny');
INSERT INTO `bazadanychduszka`.`tryby` (`Nazwa trybu`) VALUES ('Niestacjonarny');
INSERT INTO `bazadanychduszka`.`semestry` (`Numer Semestru`) VALUES ('1');
INSERT INTO `bazadanychduszka`.`semestry` (`Numer Semestru`) VALUES ('2');
INSERT INTO `bazadanychduszka`.`semestry` (`Numer Semestru`) VALUES ('3');
INSERT INTO `bazadanychduszka`.`semestry` (`Numer Semestru`) VALUES ('4');
INSERT INTO `bazadanychduszka`.`semestry` (`Numer Semestru`) VALUES ('5');
INSERT INTO `bazadanychduszka`.`semestry` (`Numer Semestru`) VALUES ('6');
INSERT INTO `bazadanychduszka`.`semestry` (`Numer Semestru`) VALUES ('7');
INSERT INTO `bazadanychduszka`.`semestry` (`Numer Semestru`) VALUES ('8');
INSERT INTO `bazadanychduszka`.`ocenydef` (`Wartosc`) VALUES ('2.0');
INSERT INTO `bazadanychduszka`.`ocenydef` (`Wartosc`) VALUES ('2.5');
INSERT INTO `bazadanychduszka`.`ocenydef` (`Wartosc`) VALUES ('3.0');
INSERT INTO `bazadanychduszka`.`ocenydef` (`Wartosc`) VALUES ('3.5');
INSERT INTO `bazadanychduszka`.`ocenydef` (`Wartosc`) VALUES ('4.0');
INSERT INTO `bazadanychduszka`.`ocenydef` (`Wartosc`) VALUES ('4.5');
INSERT INTO `bazadanychduszka`.`ocenydef` (`Wartosc`) VALUES ('5.0');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Administracja systemów bazodanowych');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Administracja systemów rozproszonych');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Aerodynamika');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Agroekologia');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Algebra liniowa');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Algebra ogólna i teoria liczb');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Algorytmy i struktury danych');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Analiza danych pomiarowych');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Analiza matematyczna');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Aplikacje internetowe');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Architektura systemów komputerowych');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Arkusze kalkulacyjne w finansach i rachunkowości');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Aspekty organizacyjno prawne rynku OZE');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Audyt bezpieczeństwa');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Audyt energetyczny budynków');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Automatyka');

INSERT INTO studenci(Imie, Nazwisko, trybID, semestrID) VALUES ("Edyta", "Pawlik", "1", "1"),("Edward", "Pietrzak", "2", "8"),("Jerzy", "Olejnik", "2", "6"),("Anita", "Sobczak", "1", "1"),("Feliks", "Włodarczyk", "2", "3"),("Piotr", "Olszewski", "1", "7"),("Ireneusz", "Górecki", "1", "1"),("Kinga", "Dąbrowski", "2", "5"),("Bożena", "Kosiński", "1", "4"),("Malwina", "Czajkowski", "2", "3"),("Dorota", "Sikorski", "1", "3"),("Aldona", "Pawlik", "1", "7"),("Irena", "Dębski", "2", "7"),("Marian", "Szydłowski", "1", "5"),("Beniamin", "Śliwiński", "2", "8"),("Dionizy", "Chmiel", "1", "1"),("Anastazja", "Mucha", "2", "3"),("Przemysław", "Kurowski", "1", "5"),("Marlena", "Adamski", "2", "4"),("Norbert", "Osiński", "1", "8"),("Lena", "Jóźwiak", "1", "3"),("Władysław", "Kania", "1", "3"),("Wiesława", "Żak", "2", "5"),("Antoni", "Stępień", "1", "8"),("Róża", "Rybak", "1", "6"),("Rafał", "Nawrocki", "2", "1"),("Fryderyk", "Śliwa", "1", "2"),("Stanisława", "Sowa", "1", "2"),("Henryk", "Szewczyk", "1", "2"),("Karol", "Skowroński", "1", "2"),("Władysław", "Domagała", "2", "1"),("Arnold", "Świderski", "1", "6"),("Mieczysław", "Bielecki", "1", "1"),("Barbara", "Sadowski", "1", "2"),("Halina", "Duda", "1", "2"),("Ilona", "Jędrzejewski", "1", "5"),("Jakub", "Majchrzak", "1", "3"),("Melania", "Kuczyński", "2", "1"),("Ryszard", "Wiśniewski", "1", "8"),("Aleksander", "Zieliński", "1", "1"),("Oliwia", "Janik", "2", "4"),("Alina", "Kulesza", "2", "8"),("Justyna", "Skowroński", "1", "6"),("Cezary", "Sawicki", "2", "8"),("Jacek", "Chojnacki", "2", "8"),("Sławomir", "Markiewicz", "1", "7"),("Stefania", "Świątek", "2", "8"),("Żaneta", "Duda", "1", "3"),("Mariola", "Dębski", "1", "1"),("Jan", "Majewski", "1", "5"),("Celina", "Czarnecki", "1", "4"),("Martyna", "Górecki", "1", "1"),("Adolf", "Barański", "2", "7"),("Krystian", "Wesołowski", "1", "1"),("Teodor", "Małek", "1", "3"),("Janina", "Nawrocki", "1", "3"),("Aldona", "Marzec", "2", "5"),("Nikola", "Morawski", "1", "1"),("Bronisław", "Skiba", "1", "2"),("Włodzimierz", "Janik", "2", "7"),("Aleksander", "Witek", "2", "5"),("Marta", "Lipiński", "1", "2"),("Alfred", "Kołodziejczyk", "1", "3"),("Norbert", "Jaworski", "2", "6"),("Roksana", "Zalewski", "1", "1"),("Bronisław", "Żak", "1", "4"),("Nadia", "Maciejewski", "1", "6"),("Aleksandra", "Kwiecień", "2", "2"),("Sara", "Kruk", "2", "8"),("Marta", "Domagała", "1", "8"),("Przemysław", "Ratajczak", "1", "6"),("Bogumił", "Woźniak", "2", "3"),("Norbert", "Leśniak", "1", "5"),("Irena", "Pawlik", "1", "6"),("Sebastian", "Maciejewski", "2", "2"),("Bartosz", "Matusiak", "1", "6"),("Nikodem", "Rutkowski", "2", "8"),("Bożena", "Żukowski", "2", "5"),("Radosław", "Walczak", "2", "3"),("Aleksy", "Śliwa", "2", "2"),("Kazimierz", "Szewczyk", "2", "3"),("Alfred", "Kot", "1", "8"),("Arnold", "Baran", "1", "8"),("Krzysztof", "Stasiak", "1", "6"),("Gustaw", "Romanowski", "1", "2"),("Adrian", "Dudek", "2", "3"),("Teresa", "Marzec", "2", "1"),("Wiktoria", "Pawłowski", "1", "8"),("Sebastian", "Mazur", "1", "5"),("Bernard", "Lipiński", "2", "5"); 
INSERT INTO grupastudenci(grupaid) VALUES ("1"),("2"),("2"),("2"),("3"),("3"),("3"),("3"),("3"),("2"),("3"),("3"),("2"),("3"),("1"),("2"),("1"),("1"),("1"),("2"),("3"),("2"),("1"),("1"),("3"),("2"),("1"),("3"),("2"),("1"),("2"),("2"),("2"),("1"),("2"),("2"),("1"),("3"),("2"),("3"),("1"),("3"),("2"),("2"),("2"),("3"),("1"),("2"),("2"),("1"),("2"),("3"),("1"),("2"),("2"),("2"),("1"),("2"),("3"),("2"),("3"),("1"),("2"),("3"),("3"),("2"),("2"),("2"),("1"),("3"),("1"),("3"),("1"),("2"),("3"),("3"),("1"),("1"),("3"),("3"),("2"),("3"),("2"),("2"),("2"),("3"),("2"),("3"),("3"),("1");
INSERT INTO kierunekstudenci(kierunekid) VALUES ("22"),("22"),("8"),("2"),("3"),("6"),("5"),("8"),("13"),("13"),("13"),("11"),("6"),("6"),("18"),("3"),("23"),("17"),("12"),("3"),("11"),("19"),("10"),("20"),("6"),("18"),("17"),("21"),("23"),("1"),("19"),("18"),("6"),("21"),("22"),("2"),("17"),("6"),("21"),("23"),("12"),("10"),("9"),("5"),("17"),("20"),("10"),("18"),("9"),("10"),("17"),("15"),("13"),("12"),("10"),("21"),("22"),("21"),("18"),("4"),("12"),("5"),("16"),("22"),("20"),("13"),("20"),("11"),("10"),("3"),("20"),("8"),("18"),("4"),("6"),("20"),("16"),("19"),("9"),("20"),("18"),("14"),("14"),("22"),("23"),("14"),("18"),("8"),("1"),("1");
INSERT INTO `bazadanychduszka`.`wykladowcy` (`Imie`, `Nazwisko`, `stopienid`) VALUES ('Krzysztof', 'Aksiński', '1');
INSERT INTO `bazadanychduszka`.`wykladowcy` (`Imie`, `Nazwisko`, `stopienid`) VALUES ('Piotr', 'Beksiński', '3');
INSERT INTO `bazadanychduszka`.`wykladowcy` (`Imie`, `Nazwisko`, `stopienid`) VALUES ('Władysław', 'Ceksiński', '2');
INSERT INTO `bazadanychduszka`.`wykladowcy` (`Imie`, `Nazwisko`, `stopienid`) VALUES ('Mikołaj', 'Deksiński', '1');
INSERT INTO `bazadanychduszka`.`wykladowcy` (`Imie`, `Nazwisko`, `stopienid`) VALUES ('Paweł', 'Eksiński', '2');
INSERT INTO `bazadanychduszka`.`wykladowcy` (`Imie`, `Nazwisko`, `stopienid`) VALUES ('Grzegorz', 'Feksiński', '1');
INSERT INTO `bazadanychduszka`.`wykladowcy` (`Imie`, `Nazwisko`, `stopienid`) VALUES ('Ignacy', 'Geksiński', '1');
INSERT INTO `bazadanychduszka`.`wykladowcy` (`Imie`, `Nazwisko`, `stopienid`) VALUES ('Mieczysław', 'Hiksiński', '3');
INSERT INTO `bazadanychduszka`.`wykladowcy` (`Imie`, `Nazwisko`, `stopienid`) VALUES ('Mariusz', 'Juksiński', '2');
INSERT INTO `bazadanychduszka`.`wykladowcy` (`Imie`, `Nazwisko`, `stopienid`) VALUES ('Jerzy', 'Iksiński', '2');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Administracja systemów bazodanowych');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Administracja systemów rozproszonych');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Aerodynamika');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Agroekologia');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Algebra liniowa');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Algebra ogólna i teoria liczb');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Algorytmy i struktury danych');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Analiza danych pomiarowych');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Analiza matematyczna');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Aplikacje internetowe');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Architektura systemów komputerowych');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Arkusze kalkulacyjne w finansach i rachunkowości');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Aspekty organizacyjno prawne rynku OZE');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Audyt bezpieczeństwa');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Audyt energetyczny budynków');
INSERT INTO `bazadanychduszka`.`przedmioty` (`Nazwa przedmiotu`) VALUES ('Automatyka');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '12', `wykladowcyid` = '1' WHERE (`przedmiotID` = '1');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '12', `wykladowcyid` = '1' WHERE (`przedmiotID` = '2');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '16', `wykladowcyid` = '2' WHERE (`przedmiotID` = '3');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '20', `wykladowcyid` = '3' WHERE (`przedmiotID` = '4');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '11', `wykladowcyid` = '4' WHERE (`przedmiotID` = '5');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '17', `wykladowcyid` = '4' WHERE (`przedmiotID` = '6');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '6', `wykladowcyid` = '5' WHERE (`przedmiotID` = '8');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '12', `wykladowcyid` = '4' WHERE (`przedmiotID` = '9');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '12', `wykladowcyid` = '6' WHERE (`przedmiotID` = '10');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '10', `wykladowcyid` = '7' WHERE (`przedmiotID` = '12');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '23', `wykladowcyid` = '7' WHERE (`przedmiotID` = '13');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '3', `wykladowcyid` = '8' WHERE (`przedmiotID` = '14');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '3', `wykladowcyid` = '8' WHERE (`przedmiotID` = '15');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '2', `wykladowcyid` = '9' WHERE (`przedmiotID` = '16');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '12', `wykladowcyid` = '1' WHERE (`przedmiotID` = '7');
UPDATE `bazadanychduszka`.`przedmioty` SET `kierunekid` = '12', `wykladowcyid` = '10' WHERE (`przedmiotID` = '11');
/* Utworzenie konta studenta */
USE `bazadanychduszka`;
DROP procedure IF EXISTS `NowyStudent`;

DELIMITER $$
USE `bazadanychduszka`$$
CREATE PROCEDURE `NowyStudent` (
Imie varchar(20),
Nazwisko varchar(30), 
Tryb int, 
Kierunek int,
Grupa int,
Semestr int
)
BEGIN
		INSERT INTO `studenci`(Imie, Nazwisko, trybID, semestrID)
		VALUES (Imie, Nazwisko, Tryb, Semestr);
        INSERT INTO `kierunekstudenci`(kierunekid)
		VALUES (Kierunek);
        INSERT INTO `grupastudenci`(grupaid)
		VALUES (Grupa);
END$$
DELIMITER ;
call NowyStudent('Adam', 'Kowalski', '1', '2', '3', '4');


/* Edycja konta studenta */
USE `bazadanychduszka`;
DROP procedure IF EXISTS `EdycjaStudent`;

DELIMITER $$
USE `bazadanychduszka`$$
CREATE PROCEDURE `EdycjaStudent` (
ID_Studenta int,
n_Imie varchar(20),
n_Nazwisko varchar(30), 
n_Tryb int, 
n_Kierunek int,
n_Grupa int,
n_Semestr int
)
BEGIN
		UPDATE `bazadanychduszka`.`studenci` SET `Imie` = n_Imie, `Nazwisko` = n_Nazwisko, `semestrID` = n_Semestr 
        WHERE (`studentID` = ID_Studenta);
        UPDATE `bazadanychduszka`.`kierunekstudenci` SET `kierunekid` = n_Kierunek 
        WHERE (`studentid` = ID_Studenta);
        UPDATE `bazadanychduszka`.`grupastudenci` SET `grupaid` = n_Grupa 
        WHERE (`studentid` = ID_Studenta);
END$$
DELIMITER ;
call EdycjaStudent('1','Patryk', 'Kowalski', '1', '5', '3', '7');


/* Utworzenie konta wykladowcy */
USE `bazadanychduszka`;
DROP procedure IF EXISTS `NowyWykladowca`;

DELIMITER $$
USE `bazadanychduszka`$$
CREATE PROCEDURE `NowyWykladowca` (
Imie varchar(20),
Nazwisko varchar(30), 
Stopien int 
)
BEGIN
		INSERT INTO `wykladowcy`(Imie, Nazwisko, stopienid)
		VALUES (Imie, Nazwisko, Stopien);
END$$
DELIMITER ;
call NowyWykladowca('Bogdan', 'Nowak', '1');


/* Dodaje nowa ocene */
USE `bazadanychduszka`;
DROP procedure IF EXISTS `NowaOcena`;

DELIMITER $$
USE `bazadanychduszka`$$
CREATE PROCEDURE `NowaOcena` ( 
ID_Studenta int, 
ID_Przedmiotu int,
ID_DEFOceny int
)
BEGIN
		INSERT INTO `bazadanychduszka`.`oceny` (`studentID`, `przedmiotID`, `ocenaDEFID`) 
        VALUES (ID_Studenta, ID_Przedmiotu, ID_DEFOceny);
END$$
DELIMITER ;
call NowaOcena('1', '2', '3');


/* Edytuje istniejaca ocene */
USE `bazadanychduszka`;
DROP procedure IF EXISTS `EdycjaOcena`;

DELIMITER $$
USE `bazadanychduszka`$$
CREATE PROCEDURE `EdycjaOcena` ( 
ID_Oceny int,
n_ID_Studenta int, 
n_ID_Przedmiotu int,
n_ID_DEFOceny int
)
BEGIN
		UPDATE `bazadanychduszka`.`oceny` SET `studentID` = n_ID_Studenta, `przedmiotID` = n_ID_Przedmiotu, `ocenaDEFID` = n_ID_DEFOceny 
        WHERE (`ocenaID` = ID_Oceny);
END$$
DELIMITER ;
call EdycjaOcena('1', '2', '3', '4');