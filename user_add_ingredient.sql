DELIMITER $$

USE innodb$$

#adding a new ingredient to user ingredient list
DROP PROCEDURE IF EXISTS sp_add_user_ingredient $$

CREATE PROCEDURE sp_add_user_ingredient
	(IN p_username VARCHAR(30),
     IN p_ingredient VARCHAR(30),
	 IN p_quantity int)
BEGIN
	declare ERR_NO_USERNAME_PROVIDED CONDITION FOR SQLSTATE '45000';
    declare ERR_NO_INGREDNAME_PROVIDED CONDITION FOR SQLSTATE '45000';
    declare ERR_NO_QUANTITY_PROVIDED CONDITION FOR SQLSTATE '45000';
    declare ERR_INVALID_USERNAME CONDITION FOR SQLSTATE '45000';
    declare ERR_INVALID_INGREDIENT CONDITION FOR SQLSTATE '45000';
    declare ERR_INVALID_QUANTITY CONDITION FOR SQLSTATE '45000';
    declare ERROR_MESSAGE VARCHAR(100);
    declare UID INT;
    declare IID int;
    declare EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
            SELECT ERROR_MESSAGE;
        END;
        
	IF (p_username IS NULL) THEN 
		SET ERROR_MESSAGE = 'No username provided.';
        SIGNAL ERR_NO_USERNAME_PROVIDED;
	END IF;
    
	IF (p_ingredient IS NULL) THEN 
		SET ERROR_MESSAGE = 'No ingredient provided.';
        SIGNAL ERR_NO_INGREDNAME_PROVIDED;
	END IF;
		
	IF (p_quantity IS NULL) THEN 
		SET ERROR_MESSAGE = 'No quantity provided.';
        SIGNAL ERR_NO_QUANTITY_PROVIDED;
	END IF;
    
    SELECT userID INTO UID 
    FROM Users WHERE p_username = Users.username;
    IF (UID IS NULL) THEN
		SET ERROR_MESSAGE = 'Invalid user';
        SIGNAL ERR_INVALID_USERNAME;
	END IF;
    
    SELECT IngredientID INTO IID
    FROM Ingredients WHERE p_ingredient = Ingredients.IngredientID;
    IF (IID IS NULL) THEN
		SET ERROR_MESSAGE = 'Invalid ingredient';
        SIGNAL ERR_INVALID_INGREDIENT;
	END IF;    
    
    IF (p_quantity >= 0) THEN
		SET ERROR_MESSAGE = 'Invalid quantity';
        SIGNAL ERR_INVALID_QUANTITY;
	END IF;
    
    INSERT INTO UserIngredientList(IngredientID, UserID, Quantity)
    VALUES(IID, UID, p_quantity);
    

END$$


DELIMITER ;