DELIMITER $$

USE innodb$$

#adding a new ingredient to user ingredient list
DROP PROCEDURE IF EXISTS sp_add_user_recipe $$

CREATE PROCEDURE sp_add_user_recipe
	(IN p_username VARCHAR(30),
     IN p_recipeID int)
BEGIN
	declare ERR_NO_USERNAME_PROVIDED CONDITION FOR SQLSTATE '45000';
    declare ERR_NO_RECIPE_PROVIDED CONDITION FOR SQLSTATE '45000';
    declare ERR_INVALID_USERNAME CONDITION FOR SQLSTATE '45000';
    declare ERR_INVALID_RECIPE CONDITION FOR SQLSTATE '45000';
    declare ERROR_MESSAGE VARCHAR(100);
    declare RID INT;
    declare UID int;
    declare EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
            SELECT ERROR_MESSAGE;
        END;
        
	IF (p_username IS NULL) THEN 
		SET ERROR_MESSAGE = 'No username provided.';
        SIGNAL ERR_NO_USERNAME_PROVIDED;
	END IF;
    
	IF (p_recipeID IS NULL) THEN 
		SET ERROR_MESSAGE = 'No recipe ID provided.';
        SIGNAL ERR_NO_RECIPE_PROVIDED;
	END IF;
    
    SELECT userID INTO UID 
    FROM Users WHERE p_username = Users.username;
    IF (UID IS NULL) THEN
		SET ERROR_MESSAGE = 'Invalid user';
        SIGNAL ERR_INVALID_USERNAME;
	END IF;
    
    SELECT RecipeID INTO RID
    FROM Recipes WHERE p_recipeID = Recipe.RecipeID;
    IF (RID IS NULL) THEN
		SET ERROR_MESSAGE = 'Invalid recipe';
        SIGNAL ERR_INVALID_RECIPE;
	END IF;    
    
    INSERT INTO UserRecipe(RecipeID, UserID)
    VALUES(RID, UID);
    

END$$


DELIMITER ;