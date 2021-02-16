
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

-- -----------------------------------------------------
-- -----------------------------------------------------

USE `IT-TERMS` ;

-- STORED PROCEDURE: Add new term --
DELIMITER $$
CREATE PROCEDURE AddNewTerm (
	IN termName NVARCHAR(50),
    IN termDescription NVARCHAR(800),
    IN groupID INT
)
BEGIN
	INSERT INTO `terms` (`Name`, `Description`, `GroupID`)
	VALUES (termName, termDescription, groupID);
END $$
DELIMITER ;


-- STORED PROCEDURE: Add new log entry --
DELIMITER $$
CREATE PROCEDURE AddNewLogEntry (
	IN tableName NVARCHAR(20),
    IN eventAction NVARCHAR(20)
)
BEGIN
	INSERT INTO `log` (`Table`, `Event`, `User`)
	VALUES (tableName, eventAction, CURRENT_USER());
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE AddNewLogEntry_specific (
	IN tableName NVARCHAR(20),
    IN eventAction NVARCHAR(20),
    IN affectedRow INT
)
BEGIN
	INSERT INTO `log` (`Table`, `Event`, `AffectedRow`, `User`)
	VALUES (tableName, eventAction, affectedRow, CURRENT_USER());
END $$
DELIMITER ;


-- TRIGGER: Log @INSERT --
DELIMITER $$
CREATE TRIGGER `terms_log_@insert`
AFTER INSERT
ON `terms`
FOR EACH ROW
BEGIN
	CALL AddNewLogEntry_specific('Terms', 'INSERT', NEW.ID);
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `groups_log_@insert`
AFTER INSERT
ON `groups`
FOR EACH ROW
BEGIN
	CALL AddNewLogEntry_specific('Groups', 'INSERT', NEW.ID);
END $$
DELIMITER ;


-- TRIGGER: Log @UPDATE --
DELIMITER $$
CREATE TRIGGER `terms_log_@update`
AFTER UPDATE
ON `terms`
FOR EACH ROW
BEGIN
	CALL AddNewLogEntry_specific('Terms', 'UPDATE', NEW.ID);
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `groups_log_@update`
AFTER UPDATE
ON `groups`
FOR EACH ROW
BEGIN
	CALL AddNewLogEntry_specific('Groups', 'UPDATE', NEW.ID);
END $$
DELIMITER ;


-- TRIGGER: Log @DELETE --
DELIMITER $$
CREATE TRIGGER `terms_log_@delete`
AFTER DELETE
ON `terms`
FOR EACH ROW
BEGIN
	CALL AddNewLogEntry('Terms', 'DELETE');
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `groups_log_@delete`
AFTER DELETE
ON `groups`
FOR EACH ROW
BEGIN
	CALL AddNewLogEntry('Groups', 'DELETE');
END $$
DELIMITER ;

-- -----------------------------------------------------
-- -----------------------------------------------------

USE `IT-TERMS` ;

-- FILL: GROUPS --
INSERT INTO `groups` (`Name`)
VALUES ('Netzwerktechnik'), ('Datenbank'), ('Kryptographie'), ('Programmiertechnik');


-- FILL: TERMS --
INSERT INTO `terms` (`Name`, `Description`, `GroupID`)
VALUES ('Routing', 'Routing ist die Wegfindung für ein Datenpaket in einem Netzwerk. Dabei wird der Weg zum Ziel anhand einem oder mehreren Kriterien (metric) ermittelt. Je mehr Kriterien berücksichtigt werden müssen, desto genauer und gezielter ist der Weg zum Ziel. Aber desto (zeit-)aufwendiger ist die Bestimmung oder Berechnung des Wegs. Das maßgebliche Hilfsmittel beim Routing ist die Routing-Tabelle.', '1')
	  ,('sequenzielles Abarbeiten', 'Beschreibt das strukturierte und geordnete Abarbeiten nach einem bestimmten, definierten Muster. Die Datenbanksprache SQL arbeitet sich beispielsweise von "oben" nach "unten" durch.', '2')
      ,('referentielle Integrität', 'Unter referentieller Integrität (RI) versteht man Bedingungen, die zur Sicherung der Datenintegrität bei Nutzung relationaler Datenbanken beitragen können. Nach der RI-Regel dürfen Datensätze (über ihre Fremdschlüssel) nur auf existierende Datensätze verweisen.', '3')
      ,('DNS', 'Das Domain Name System (DNS) ist einer der wichtigsten Dienste in IP-basierten Netzwerken. Seine Hauptaufgabe ist die Beantwortung von Anfragen zur Namensauflösung. Um diese gewährleisten zu können, sind in einer weltweiten Datenbank, verteilt auf vielen DNS-Servern, Name-Adresspaare gespeichert.', '1')
      ,('DHCP', 'Das Dynamic Host Configuration Protocol (DHCP) ist ein Kommunikationsprotokoll in der Computertechnik. Es ermöglicht die Zuweisung der Netzwerkkonfiguration an Clients durch einen Server. Nötige Informationen wie IP-Adresse, Netzmaske, Gateway, Name Server (DNS) und ggf. weitere Einstellungen werden automatisch vergeben, sofern das Betriebssystem des jeweiligen Clients das unterstützt.', '1')
      ,('Verzeichnisdienst', 'Ein Verzeichnisdienst stellt in einem Netzwerk eine zentrale Sammlung von Daten bestimmter Art zur Verfügung. Die in einer hierarchischen Datenbank gespeicherten Daten können nach dem Client-Server-Prinzip verglichen, gesucht, erstellt, modifiziert und gelöscht werden.', '1')
      ,('IPv4-Adresse', 'Die wichtigste Aufgabe von IP (Internet Protocol) ist, dass jeder Host in einem dezentralen TCP/IP-Netzwerk gefunden werden kann. Dazu wird jedem Hardware-Interface (Netzwerkkarte oder -adapter) eine logische IPv4-Adresse zugeteilt. Die IPv4-Adresse ist mit den Angaben zu Straße, Hausnummer und Ort einer Anschrift vergleichbar. IPv4 benutzt 32-Bit-Adressen, daher können in einem Netz maximal 4.294.967.296 Adressen vergeben werden. IPv4-Adressen werden üblicherweise dezimal in vier Blöcken geschrieben, zum Beispiel 207.142.131.235.', '1')
      ,('Subnetzmaske', 'Die Subnetzmaske ist eine Bitmaske, die im Netzwerkprotokoll IPv4 bei der Beschreibung von IP-Netzen angibt, welche Bit-Position innerhalb der IP-Adresse für die Adressierung des Netz- bzw. Host-Anteils genutzt werden soll.', '1')
      ,('IPv6-Adresse', 'Eine IPv6-Adresse ist eine Netzwerk-Adresse, die einen Host eindeutig innerhalb eines IPv6-Netzwerks logisch adressiert. Die Adresse wird auf IP- bzw. Vermittlungsebene (des OSI-Schichtenmodells) benötigt, um Datenpakete verschicken und zustellen zu können. Eine IPv6-Adresse hat eine Länge von 128 Bit.', '1')
      ,('NoSQL', 'NoSQL bezeichnet Datenbanken, die einen nicht-relationalen Ansatz verfolgen und damit mit der langen Geschichte relationaler Datenbanken brechen. Diese Datenspeicher benötigen keine festgelegten Tabellenschemata und versuchen Joins zu vermeiden.', '2')
      ,('symmetrische Verschlüsselung', 'Die symmetrische Verschlüsselung ist ein Kryptosystem, bei welchem im Gegensatz zur asymmetrischen Verschlüsselung beide Teilnehmer denselben Schlüssel verwenden.', '3')
      ,('Private-Public-Key', 'Das „Public-Key-Kryptosystem“ ist ein kryptographisches Verfahren, bei dem im Gegensatz zu einem symmetrischen Kryptosystem die kommunizierenden Parteien keinen gemeinsamen geheimen Schlüssel zu kennen brauchen. Jeder Benutzer erzeugt sein eigenes Schlüsselpaar, das aus einem geheimen Teil (privater Schlüssel) und einem nicht geheimen Teil (öffentlicher Schlüssel) besteht. Der öffentliche Schlüssel ermöglicht es jedem, Daten für den Besitzer des privaten Schlüssels zu verschlüsseln, dessen digitale Signaturen zu prüfen oder ihn zu authentifizieren. Der private Schlüssel ermöglicht es seinem Besitzer, mit dem öffentlichen Schlüssel verschlüsselte Daten zu entschlüsseln, digitale Signaturen zu erzeugen oder sich zu authentisieren.', '3')
      ,('Einfüge-Anomalie', 'Bei einem fehlerhaften oder inkorrekten Datenbankdesign kann es bei der Einfüge-Anomalie passieren, dass Daten gar nicht in die Datenbank übernommen werden, wenn zum Beispiel der Primärschlüssel keinen Wert erhalten hat, oder eine unvollständigen Eingabe von Daten zu Inkonsistenzen führt.', '2')
      ,('DBMS', 'Ein Datenbankmanagementsystem (DBMS) ist eine Systemsoftware zur Erstellung und Verwaltung von Datenbanken. Ein DBMS ermöglicht es Endanwendern, Daten in einer Datenbank zu erstellen, zu lesen, zu aktualisieren und zu löschen.', '2')
      ,('Objektorientierung', 'Unter Objektorientierung versteht man in der Entwicklung von Software eine Sichtweise auf komplexe Systeme, bei der ein System durch das Zusammenspiel kooperierender Objekte beschrieben wird. Objektorientierung wird hauptsächlich im Rahmen der objektorientierten Programmierung verwendet, um die Komplexität der entstehenden Programme zu verringern.', '4')
      ,('Proxy', 'Ein Proxy ist eine Kommunikationsschnittstelle in einem Netzwerk. Er arbeitet als Vermittler, der auf der einen Seite Anfragen entgegennimmt, um dann über seine eigene Adresse eine Verbindung zur anderen Seite herzustellen.', '2')
      ,('(S)FTP', 'Das File Transfer Protocol ist ein zustandsbehaftetes Netzwerkprotokoll zur Übertragung von Dateien über IP-Netzwerke. FTP ist in der Anwendungsschicht (Schicht 7) des OSI-Schichtenmodells angesiedelt. Es wird benutzt, um Dateien vom Client zum Server (Hochladen), vom Server zum Client (Herunterladen) oder clientgesteuert zwischen zwei FTP-Servern zu übertragen (File Exchange Protocol). Außerdem können mit FTP Verzeichnisse angelegt und ausgelesen sowie Verzeichnisse und Dateien umbenannt oder gelöscht werden. Das SSH File Transfer Protocol oder Secure File Transfer Protocol (SFTP) ist eine für die Secure Shell (SSH) entworfene Alternative zum File Transfer Protocol (FTP), die Verschlüsselung ermöglicht. Im Unterschied zum FTP über TLS (FTPS) begnügt sich SFTP mit einer einzigen Verbindung zwischen Client und Server.', '1')
      ,('IP-Adresse', 'Eine IP-Adresse ist eine Adresse in Computernetzen, die – wie das Internet – auf dem Internetprotokoll (IP) basiert. Sie wird Geräten zugewiesen, die an das Netz angebunden sind, und macht die Geräte so adressierbar und damit erreichbar. Die IP-Adresse kann einen einzelnen Empfänger oder eine Gruppe von Empfängern bezeichnen (Multicast, Broadcast). Umgekehrt können einem Computer mehrere IP-Adressen zugeordnet sein.', '1')
      ,('URL', 'Ein Uniform Resource Locator (URL) identifiziert eine Ressource in einem Netzwerk. Der Aufbau der URL ist nach einem festen Schema aufgebaut: [Protokoll]:[Dienst]:[subdomain]:[SLD]:[TLD]:[Verzeichnis] - zB.: http://www.schule.salzburg.at/dokumente', '1')
      ,('TLD', 'TLD (Top-Level-Domain) bezeichnet den hintersten Teil eines Domain-Namens. Hierbei wird zwischen geografischem und generischen TLDs unterschieden. Im Falle einer URL mit der Endung .at, stellt jene TLD den Ländercode Österreichs dar.', '1')
      ,('PTR', 'Ein PTR (Pointer-Record) verweist auf den Domain-Namen, liefert also den Domänennamen, der mit einer IP-Adresse verknüpft ist.', '1')
      ,('CNAME', 'Ein CNAME-Record verknüpft einen Domainnamen mit einem anderen Domainnamen. So kann ermöglicht werden, dass mehrere Domainnamen auf ein und dieselbe IP-Adresse verweisen.', '1')
      ,('Resolver', 'Ist die Schnittstelle zwischen Anwendung und Namensserver. Der Resolver übermittelt die Anfrage an den zugeordneten DNS-Server. Dieser kann rekursiv (Client) oder iterativ (Nameserver) sein.', '1')
      ,('Zeroconf', 'Zeroconf ist ein Verfahren für das einfache Einrichten und den konfigurationsfreien Betrieb bzw. der selbstständigen Konfiguration von Rechnernetzen sowie das einfache Auffinden von Diensten in einem Netz. Die bekannteste Umsetzung von Zeroconf ist Bonjour von Apple.', '1')
      ,('APIPA', 'APIPA (Automatic Private IP Adressing) ist ein Mechanismus, welcher einem Rechner eine Adresse aus dem IP-Adressbereich 169.254.1.0 bis 169.254.254.255 vergibt, wenn dieser keine IP per DHCP erhält.', '1')
      ,('Gateway', 'Ein Gateway ist ein aktiver Netzknoten, der zwei Netze miteinander verbinden kann, die physikalisch zueinander inkompatibel sind und/oder eine unterschiedliche Adressierung verwenden. Gateways verknüpfen die unterschiedlichsten Protokolle und Übertragungsverfahren miteinander.', '1')
      ,('Lease-Dauer', 'Die Lease-Time gibt an, wie lange eine vom DHCP-Server vergebene IP-Adresse gilt, bevor das Netzwerkgerät, welches die Adresse erhalten hat, erneut beim DHCP-Server nachfragt, ob es die Adresse ändern soll. Dies bedeutet allerdings nicht, dass dieser dann zwangsweise eine neue Adresse erhält.', '1')
      ,('MAC-Adresse', 'Die Abkürzung MAC-Adresse steht für Media Access Control Adresse und stellt die eindeutige Kennung einer Netzwerkschnittstelle dar. Diese wird weltweit für jeden Schnittstelle nur einmal vergeben, wie eine Art feste Seriennummer.', '1')
      ,('Datenbank', 'Eine Datenbank, auch Datenbanksystem genannt, ist ein System zur elektronischen Datenverwaltung. Die wesentliche Aufgabe einer Datenbank ist es, große Datenmengen effizient, widerspruchsfrei und dauerhaft zu speichern und benötigte Teilmengen in unterschiedlichen, bedarfsgerechten Darstellungsformen für Benutzer und Anwendungsprogramme bereitzustellen.', '2')
      ,('Konsistenz', 'Als Konsistenz wird in Datenbanken die Korrektheit der dort gespeicherten Daten bezeichnet. Inkonsistente Datenbanken können zu schweren Fehlern führen, falls die darüberliegende Anwendungsschicht nicht damit rechnet.', '2')
      ,('Redundanz', 'Redundanzen sind doppelte Informationen in einer Datenbank bzw. Datenbank-Tabelle. Man spricht von einer redundanzfreien Datenbank, wenn alle doppelte Informationen entfernt werden können, ohne das ein Informationsverlust stattfindet.', '2')
      ,('Kapselung', 'Als Datenkapselung bezeichnet man in der Programmierung das Verbergen von Daten oder Informationen vor dem Zugriff von außen. Der direkte Zugriff auf die interne Datenstruktur wird unterbunden und erfolgt stattdessen über definierte Schnittstellen (Black-Box-Modell).', '4')
      ,('Vererbung', 'Die Vererbung ist eines der grundlegenden Konzepte der Objektorientierung und hat große Bedeutung in der Softwareentwicklung. Die Vererbung dient dazu, aufbauend auf existierenden Klassen neue zu schaffen, wobei die Beziehung zwischen ursprünglicher und neuer Klasse dauerhaft ist. Eine neue Klasse kann dabei eine Erweiterung oder eine Einschränkung der ursprünglichen Klasse sein.', '4')
      ,('Polymorphie', 'Polymorphie oder Polymorphismus ist ein Konzept in der objektorientierten Programmierung, das ermöglicht, dass ein Bezeichner abhängig von seiner Verwendung Objekte unterschiedlichen Datentyps annimmt. In älteren typisierten Programmiersprachen wird dagegen jedem Namen und jedem Wert im Quelltext eines Programms höchstens ein Typ zugeordnet. Dies bezeichnet man als Monomorphie.', '4')
      ,('public', 'Zugreifbar für alle Objekte.', '4')
      ,('private', 'Nur für Objekte der eigenen Klasse zugreifbar.', '4')
      ,('protected', 'Nur für Objekte der eigenen Klasse und von abgeleiteten Klassen dieser Klasse zugreifbar.', '4')
      ,('UML', 'Die Unified Modeling Language, kurz UML, ist eine grafische Modellierungssprache zur Spezifikation, Konstruktion, Dokumentation und Visualisierung von Software-Teilen und anderen Systemen.', '4')
      ,('PHP', 'PHP ist eine Skriptsprache mit einer an C und Perl angelehnten Syntax, die hauptsächlich zur Erstellung dynamischer Webseiten oder Webanwendungen verwendet wird.', '4')
      ,('JIT-Kompilierung', 'Just-in-time-Kompilierung (JIT-Kompilierung) ist ein Verfahren aus der praktischen Informatik, um (Teil-)Programme zur Laufzeit in Maschinencode zu übersetzen. Ziel ist es dabei, die Ausführungsgeschwindigkeit gegenüber einem Interpreter zu steigern. JIT-Compiler kommen meist im Rahmen einer virtuellen Maschine zum Einsatz, wo Plattform-unabhängiger Bytecode ausgeführt werden soll.', '4')
      ,('Tokenizer', 'Ein Tokenizer ist ein Computerprogramm zur Zerlegung von Plain text (zum Beispiel Quellcode) in Folgen von logisch zusammengehörigen Einheiten, so genannte Token. Als solcher ist er oft Teil eines Compilers.', '4')
      ,('Vertraulichkeit', 'Daten dürfen lediglich von autorisierten Benutzern gelesen bzw. modifiziert werden, dies gilt sowohl beim Zugriff auf gespeicherte Daten, wie auch während der Datenübertragung.', '3')
      ,('Integrität', ' Daten dürfen nicht unbemerkt verändert werden. Alle Änderungen müssen nachvollziehbar sein.', '3')
      ,('Verfügbarkeit', 'Verhinderung von Systemausfällen; der Zugriff auf Daten muss innerhalb eines vereinbarten Zeitrahmens gewährleistet sein.', '3');

-- -----------------------------------------------------
-- -----------------------------------------------------

USE `IT-TERMS` ;

-- VIEW: Netzwerktechnik --
CREATE VIEW Group_Netzwerktechnik AS
SELECT t.Name
	  ,t.Description
FROM terms t
	INNER JOIN `groups` g ON g.ID = t.GroupID
WHERE g.Name = 'Netzwerktechnik';


-- VIEW: Datenbank --
CREATE VIEW Group_Datenbank AS
SELECT t.Name
	  ,t.Description
FROM terms t
	INNER JOIN `groups` g ON g.ID = t.GroupID
WHERE g.Name = 'Datenbank';


-- VIEW: Kryptographie --
CREATE VIEW Group_Kryptographie AS
SELECT t.Name
	  ,t.Description
FROM terms t
	INNER JOIN `groups` g ON g.ID = t.GroupID
WHERE g.Name = 'Kryptographie';


-- VIEW: Programmiertechnik --
CREATE VIEW Group_Programmiertechnik AS
SELECT t.Name
	  ,t.Description
FROM terms t
	INNER JOIN `groups` g ON g.ID = t.GroupID
WHERE g.Name = 'Programmiertechnik';

-- -----------------------------------------------------
-- -----------------------------------------------------

-- USER: DELETE --
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'shieeshkröte'@'localhost';
DROP USER 'shieeshkröte'@'localhost';

-- USER: CREATE --
CREATE USER IF NOT EXISTS 'shieeshkröte'@'localhost' IDENTIFIED BY 'spiegelei';
GRANT ALL PRIVILEGES ON `IT-TERMS` . * TO 'shieeshkröte'@'localhost';
FLUSH PRIVILEGES;

