
-- ÜBUNG 1 --
CREATE USER 'hechenberger'@'localhost' IDENTIFIED BY 'password';

-- ÜBUNG 2 --
CREATE SCHEMA IF NOT EXISTS hechenberger;

USE hechenberger;

CREATE TABLE IF NOT EXISTS Projektverwaltung (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Projektname` VARCHAR(50) NOT NULL,
  `Mitarbeiter_Name` VARCHAR(50) NOT NULL,
  `Beschreibung` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`ID`));

-- ÜBUNG 3 --
INSERT INTO Projektverwaltung
  VALUES ( '1', 'Großes Projekt', 'Simon Schmimon', 'Ein sehr großes und kompliziertes Projekt.' );

GRANT SELECT ON Projektverwaltung TO 'hechenberger'@'localhost';

-- ÜBUNG 4 --
INSERT INTO Projektverwaltung
  VALUES ( '2', 'Kleines Projekt', 'Martin Schmartin', 'Ein sehr kleines und unnötiges Projekt.' );

GRANT DELETE ON Projektverwaltung TO 'hechenberger'@'localhost';

DELETE FROM Projektverwaltung
  WHERE ID = 2;

-- ÜBUNG 5 --
DROP USER 'hechenberger'@'localhost';

SELECT user FROM mysql.user;

