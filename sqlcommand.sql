USE cookchain;
CREATE TABLE Users(
	userID INT auto_increment PRIMARY KEY,
    username VARCHAR(30) UNIQUE NOT NULL,
    password VARCHAR(30) NOT NULL
);
SELECT * FROM Users

DELETE FROM Users WHERE userID >0