
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

