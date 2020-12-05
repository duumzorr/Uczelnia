/* Szuka w tabeli studenci studentki o imieniu Dorota i Nazwisko Sikorski */
SELECT Imie, Nazwisko
FROM studenci
WHERE Nazwisko = 'Sikorski' AND Imie = 'Dorota';

/* Wyświetla wszystkich studentów z nazwiskiem Szewczyk */
SELECT Imie, Nazwisko
FROM studenci
WHERE Nazwisko = 'Szewczyk';

/* Wyświetla wszystkich studentów z nazwiskiem Szewczyk studiujących stacjonarnie*/
SELECT Imie, Nazwisko
FROM studenci
WHERE Nazwisko = 'Szewczyk' AND trybID = 1;

/* Wyświetla wszystkich studentów studiujacych na kierunkach: architektura oraz automatyka i robotyka*/
SELECT studentid
FROM kierunekstudenci
WHERE kierunekid = 1 OR kierunekid = 2;

/* Wyświetla do jakiej grupy nalezy student o podanym id*/
SELECT g.* FROM studenci AS s
INNER JOIN grupastudenci AS gs ON s.studentID = gs.studentid
INNER JOIN grupy AS g ON gs.grupaid = g.grupaID
WHERE s.studentID = 1;

/* Wyświetla na jakim kierunku studiuje student o podanym id*/
SELECT k.* FROM studenci AS s
INNER JOIN kierunekstudenci AS ks ON s.studentID = ks.studentid
INNER JOIN kierunki AS k ON ks.kierunekid = k.kierunekID
WHERE s.studentID = 2;
