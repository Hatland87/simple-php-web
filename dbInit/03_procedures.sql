USE recipes;


DELIMITER $$
CREATE PROCEDURE sp_InsertRecipe (IN recipeName VARCHAR(150), userID INT, OUT recipeID INT)
BEGIN
SET @currentDatetime = CURRENT_TIMESTAMP();
INSERT INTO recipe (recipeName, owner, createdBy, created, alteredBy, altered)
VALUES (recipeName, userID, userID, @currentDatetime, userID, @currentDatetime);
SET recipeID = LAST_INSERT_ID();
END
$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE sp_InsertRecipeSeqence (recipeID INT, recipeSequenceNumber INT, userID INT, OUT recipeSequenceID INT)
BEGIN

SET @currentDatetime = CURRENT_TIMESTAMP();

INSERT INTO recipeSequence (recipeID, recipeSequenceNumber, owner, createdBy, created, alteredBy, altered)
VALUES (recipeID, recipeSequenceNumber, userID, userID, @currentDatetime, userID, @currentDatetime);
SET recipeSequenceID = LAST_INSERT_ID();
END
$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_InsertRecipeImage (IN recipeID INT, sequenceNumber INT, userID INT, imagePath VARCHAR(200), imageTitle VARCHAR(150))
BEGIN
CALL sp_InsertRecipeSeqence(recipeID, sequenceNumber, userID, @recipeSequenceID);
SET @currentDatetime = CURRENT_TIMESTAMP();
INSERT INTO recipeImage (recipeID, recipeSequenceID, imagePath, imageTitle, owner, createdBy, created, alteredBy, altered)
VALUES (recipeID, @recipeSequenceID, imagePath, imageTitle, userID, userID, @currentDatetime, userID, @currentDatetime);
END
$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_InsertRecipeIngredient (IN recipeID INT, sequenceNumber INT, userID INT, ingredientName VARCHAR(150), ammount VARCHAR(200))
BEGIN
CALL sp_InsertRecipeSeqence(recipeID, sequenceNumber, userID, @recipeSequenceID);
SET @currentDatetime = CURRENT_TIMESTAMP();
INSERT INTO recipeIngredient (recipeID, recipeSequenceID, ingredientName, ammount, owner, createdBy, created, alteredBy, altered)
VALUES (recipeID, @recipeSequenceID, ingredientName, ammount, userID, userID, @currentDatetime, userID, @currentDatetime);
END
$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_InsertRecipeText (IN recipeID INT, sequenceNumber INT, userID INT, recipeText VARCHAR(10000))
BEGIN
CALL sp_InsertRecipeSeqence(recipeID, sequenceNumber, userID, @recipeSequenceID);
SET @currentDatetime = CURRENT_TIMESTAMP();
INSERT INTO recipeText (recipeID, recipeSequenceID, recipeText, owner, createdBy, created, alteredBy, altered)
VALUES (recipeID, @recipeSequenceID, recipeText, userID, userID, @currentDatetime, userID, @currentDatetime);
END
$$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_InsertRecipeStep (IN recipeID INT, sequenceNumber INT, userID INT, stepText VARCHAR(4000))
BEGIN
CALL sp_InsertRecipeSeqence(recipeID, sequenceNumber, userID, @recipeSequenceID);
SET @currentDatetime = CURRENT_TIMESTAMP();
INSERT INTO recipeStep (recipeID, recipeSequenceID, stepText, owner, createdBy, created, alteredBy, altered)
VALUES (recipeID, @recipeSequenceID, stepText, userID, userID, @currentDatetime, userID, @currentDatetime);
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

SELECT recipeName, owner, ID FROM recipe
ORDER BY recipeName;

END
$$
DELIMITER ;


CALL sp_InsertRecipe("Brownies", 1, @recipeID);
CALL sp_InsertRecipeIngredient(@recipeID, 1, 1, "Mel", "300 gram");
CALL sp_InsertRecipeIngredient(@recipeID, 2, 1, "Sukker", "200 gram");
CALL sp_InsertRecipeIngredient(@recipeID, 3, 1, "Kanel", "10 gram");
CALL sp_InsertRecipeIngredient(@recipeID, 4, 1, "Lime Jucie", "2 SS");
CALL sp_InsertRecipeStep(@recipeID,5,1, "Steg 1");
CALL sp_InsertRecipeStep(@recipeID,6,1, "Steg 2");
CALL sp_InsertRecipeStep(@recipeID,7,1, "Steg 3");
CALL sp_InsertRecipeText(@recipeID,8,1, "Beskrivelse av oppskrift");
CALL sp_InsertRecipeImage(@recipeID,9,1, "./img/saft.png", "Deilig saft bilde");

CALL sp_InsertRecipe("Kake", 1, @recipeID);
CALL sp_InsertRecipeIngredient(@recipeID, 1, 1, "Mel", "300 gram");
CALL sp_InsertRecipeIngredient(@recipeID, 2, 1, "Sukker", "200 gram");
CALL sp_InsertRecipeIngredient(@recipeID, 3, 1, "Kanel", "10 gram");
CALL sp_InsertRecipeIngredient(@recipeID, 4, 1, "Lime Jucie", "2 SS");
CALL sp_InsertRecipeStep(@recipeID,5,1, "Steg 1");
CALL sp_InsertRecipeStep(@recipeID,6,1, "Steg 2");
CALL sp_InsertRecipeStep(@recipeID,7,1, "Steg 3");
CALL sp_InsertRecipeText(@recipeID,8,1, "Beskrivelse av oppskrift");
CALL sp_InsertRecipeImage(@recipeID,9,1, "./img/saft.png", "Deilig saft bilde");

CALL sp_InsertRecipe("Saft", 1, @recipeID);
CALL sp_InsertRecipeIngredient(@recipeID, 1, 1, "Vann", "3 liter");
CALL sp_InsertRecipeIngredient(@recipeID, 2, 1, "Sukker", "200 gram");
CALL sp_InsertRecipeIngredient(@recipeID, 3, 1, "Appelsin Jucie", "5 dl");
CALL sp_InsertRecipeIngredient(@recipeID, 4, 1, "Lime Jucie", "2 SS");
CALL sp_InsertRecipeStep(@recipeID,5,1, "Steg 1");
CALL sp_InsertRecipeStep(@recipeID,6,1, "Steg 2");
CALL sp_InsertRecipeStep(@recipeID,7,1, "Steg 3");
CALL sp_InsertRecipeText(@recipeID,8,1, "Beskrivelse av oppskrift");
CALL sp_InsertRecipeImage(@recipeID,9,1, "./img/saft.png", "Deilig saft bilde");

