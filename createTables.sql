CREATE TABLE Users(
	userID INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) UNIQUE NOT NULL,
    password VARCHAR(30) NOT NULL
);

CREATE TABLE Recipe(
	RecipeID INT AUTO_INCREMENT PRIMARY KEY,
    RecipeName VARCHAR(100) UNIQUE NOT NULL,
    TimeToMake VARCHAR(30)
);

CREATE TABLE CreditCard(
	CCID INT AUTO_INCREMENT PRIMARY KEY,
	CCNumber VARCHAR(30) UNIQUE NOT NULL,
    CCCode VARCHAR(30) NOT NULL,
    CCType VARCHAR(30) NOT NULL,
    ExpDate VARCHAR(30) NOT NULL
);

ALTER TABLE CreditCard
ADD CONSTRAINT Card_type_constraint
CHECK(CCType = 'VISA' OR CCType = 'AMEX' OR CCType = 'MC' OR CCType = 'D');

CREATE TABLE UserCreditCard(
	UserCreditCardID INT AUTO_INCREMENT PRIMARY KEY,
    CCID INT,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (CCID) REFERENCES CreditCard(CCID)
);

CREATE TABLE UserRecipe(
	UserRecipeID INT AUTO_INCREMENT PRIMARY KEY,
	RecipeID INT,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users(userID),
	FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID)
);

CREATE TABLE UserIngredientList(
	UserIngredientListID INT AUTO_INCREMENT PRIMARY KEY,
    IngredientID INT,
    UserID INT,
    Quantity INT,
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE UserCreditCard(
	UserCreditCardID INT AUTO_INCREMENT PRIMARY KEY,
    CCID INT,
    UserID INT,
    FOREIGN KEY (CCID) REFERENCES CreditCard(CCID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE RecipeIngredients(
	RecipeIngredientsID INT AUTO_INCREMENT PRIMARY KEY,
    RecipeID INT,
    IngredientID INT,
    FOREIGN KEY (RecipeID) REFERENCES Recipe(RecipeID),
    FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID)
);





