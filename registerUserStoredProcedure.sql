DELIMITER $$

USE innodb $$

DROP PROCEDURE IF EXISTS sp_register_user $$

#CALL sp_register_user('lamberce','password1','salt','chris','lambert','male','lamberce@rose-hulman.edu','888','visa','Chris','4/5/15')

CREATE PROCEDURE sp_register_user
	(IN p_username VARCHAR(30),
     IN p_password VARCHAR(30))
BEGIN
	DECLARE ERR_NO_USERNAME_PROVIDED CONDITION FOR SQLSTATE '45000';
    DECLARE ERR_USERNAME_ALREADY_TAKEN CONDITION FOR SQLSTATE '45000';
    DECLARE ERR_NO_PASSWORD_PROVIDED CONDITION FOR SQLSTATE '45000';
	DECLARE u VARCHAR(30);
    DECLARE ERROR_MESSAGE VARCHAR(100);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
			SELECT ERROR_MESSAGE;
		END;
    
	IF(p_username IS NULL) THEN
		SET ERROR_MESSAGE = 'No username provided';
		SIGNAL ERR_NO_USERNAME_PROVIDED;
	END IF;
    
    SELECT username INTO u FROM Users WHERE Users.username = p_username;
    IF(u IS NOT NULL) THEN
		SET ERROR_MESSAGE = 'Username already taken';
		SIGNAL ERR_USERNAME_ALREADY_TAKEN;
	END IF;
    
    IF(p_password IS NULL) THEN
		SET ERROR_MESSAGE = 'No password provided';
		SIGNAL ERR_NO_PASSWORD_PROVIDED;
	END IF;
    

	INSERT INTO innodb.Users(username,password)
		VALUES(p_username,p_password);
        
	#INSERT INTO flopCALL sp_register_user('lamberce','password1','salt','chris','lambert','male','lamberce@rose-hulman.edu','888','visa','Chris','4/5/15')ticalDatabase.CreditCards(cc_num,card_type,name_on_card,exp_date)
	#	VALUES(p_cc_num,p_card_type,p_name_on_card,p_exp_date);
END$$

DELIMITER ;