
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

