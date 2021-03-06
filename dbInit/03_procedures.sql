USE recipes;


DELIMITER $$
CREATE PROCEDURE sp_InsertRecipe (IN recipeName VARCHAR(150), userID INT, OUT recipeID INT)
BEGIN
SET @currentDatetime = CURRENT_TIMESTAMP();
INSERT INTO recipe (recipeName, createdBy, created, alteredBy, altered)
VALUES (recipeName, userID, @currentDatetime, userID, @currentDatetime);
SET recipeID = LAST_INSERT_ID();
END
$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE sp_InsertRecipeSeqence (recipeID INT, recipeSequenceNumber INT, userID INT, OUT recipeSequenceID INT)
BEGIN

SET @currentDatetime = CURRENT_TIMESTAMP();

INSERT INTO recipeSequence (recipeID, recipeSequenceNumber, createdBy, created, alteredBy, altered)
VALUES (recipeID, recipeSequenceNumber, userID, @currentDatetime, userID, @currentDatetime);
SET recipeSequenceID = LAST_INSERT_ID();
END
$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_InsertRecipeImage (IN recipeID INT, sequenceNumber INT, userID INT, imagePath VARCHAR(200), imageTitle VARCHAR(150))
BEGIN
CALL sp_InsertRecipeSeqence(recipeID, sequenceNumber, userID, @recipeSequenceID);
SET @currentDatetime = CURRENT_TIMESTAMP();
INSERT INTO recipeImage (recipeID, recipeSequenceID, imagePath, imageTitle, createdBy, created, alteredBy, altered)
VALUES (recipeID, @recipeSequenceID, imagePath, imageTitle, userID, @currentDatetime, userID, @currentDatetime);
END
$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_InsertRecipeIngredient (IN recipeID INT, sequenceNumber INT, userID INT, ingredientName VARCHAR(150), ammount VARCHAR(200))
BEGIN
CALL sp_InsertRecipeSeqence(recipeID, sequenceNumber, userID, @recipeSequenceID);
SET @currentDatetime = CURRENT_TIMESTAMP();
INSERT INTO recipeIngredient (recipeID, recipeSequenceID, ingredientName, ammount, createdBy, created, alteredBy, altered)
VALUES (recipeID, @recipeSequenceID, ingredientName, ammount, userID, @currentDatetime, userID, @currentDatetime);
END
$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_InsertRecipeText (IN recipeID INT, sequenceNumber INT, userID INT, recipeText VARCHAR(10000))
BEGIN
CALL sp_InsertRecipeSeqence(recipeID, sequenceNumber, userID, @recipeSequenceID);
SET @currentDatetime = CURRENT_TIMESTAMP();
INSERT INTO recipeText (recipeID, recipeSequenceID, recipeText, createdBy, created, alteredBy, altered)
VALUES (recipeID, @recipeSequenceID, recipeText, userID, @currentDatetime, userID, @currentDatetime);
END
$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_InsertRecipeStep (IN recipeID INT, sequenceNumber INT, userID INT, stepText VARCHAR(4000))
BEGIN
CALL sp_InsertRecipeSeqence(recipeID, sequenceNumber, userID, @recipeSequenceID);
SET @currentDatetime = CURRENT_TIMESTAMP();
INSERT INTO recipeStep (recipeID, recipeSequenceID, stepText, createdBy, created, alteredBy, altered)
VALUES (recipeID, @recipeSequenceID, stepText, userID, @currentDatetime, userID, @currentDatetime);
END
$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_SelectRecipe (IN recipe_ID INT)
BEGIN

SELECT * FROM recipeInSequence WHERE recipeID = recipe_ID;

END
$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_SelectAllRecipes ()
BEGIN

SELECT recipeName, createdBy, ID FROM recipe
ORDER BY recipeName;

END
$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_SelectUserRecipes (IN userID INT)
BEGIN

SELECT recipeName, createdBy, ID FROM recipe
WHERE userID = userID
ORDER BY recipeName;

END
$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE sp_InsertUser (IN firstName VARCHAR(200), lastName VARCHAR(200), mail VARCHAR(255), password LONGTEXT)
BEGIN
SET @currentDatetime = CURRENT_TIMESTAMP();
INSERT INTO user (firstName, lastName, mail, userPassword, createdBy, created, alteredBy, altered)
VALUES (firstName, lastName, mail, password, '1', @currentDatetime, '1', @currentDatetime);
END
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_GetUser (IN myMail VARCHAR(255))
BEGIN
SELECT ID, firstName, lastName, mail, userPassword  FROM user 
WHERE mail = myMail;
END
$$
DELIMITER ;