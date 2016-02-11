DELIMITER $$

USE innodb$$

DROP PROCEDURE IF EXISTS sp_add_user_cc $$

CREATE PROCEDURE sp_add_user_cc
	(IN p_username VARCHAR(30),
     IN p_ccid int)
BEGIN
	declare ERR_NO_USERNAME_PROVIDED CONDITION FOR SQLSTATE '45000';
    declare ERR_NO_CCID_PROVIDED CONDITION FOR SQLSTATE '45000';
    declare ERR_INVALID_USERNAME CONDITION FOR SQLSTATE '45000';
	declare ERR_INVALID_CCID CONDITION FOR SQLSTATE '45000';
    declare ERROR_MESSAGE VARCHAR(100);
    declare UID INT;
    declare CCID int;
    declare EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
            SELECT ERROR_MESSAGE;
        END;
        
	IF (p_username IS NULL) THEN 
		SET ERROR_MESSAGE = 'No username provided.';
        SIGNAL ERR_NO_USERNAME_PROVIDED;
	END IF;
    
	IF (p_ccid IS NULL) THEN 
		SET ERROR_MESSAGE = 'No credit card ID provided.';
        SIGNAL ERR_NO_CCID_PROVIDED;
	END IF;
    
    SELECT userID INTO UID 
    FROM Users WHERE p_username = Users.username;
    IF (UID IS NULL) THEN
		SET ERROR_MESSAGE = 'Invalid user';
        SIGNAL ERR_INVALID_USERNAME;
	END IF;
    
    SELECT CreditCardID INTO CCID
    FROM CreditCard WHERE p_ccid = CreditCard.CCID;
    IF (CCID IS NOT NULL) THEN
		SET ERROR_MESSAGE = 'Invalid credit card';
        SIGNAL ERR_INVALID_CCID;
	END IF;    
    
    INSERT INTO UserIngredientList(CCID, UserID)
    VALUES(CCID, UID);
    

END$$


DELIMITER ;