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