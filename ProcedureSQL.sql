USE AdventureWorksDW2022  
GO

-- Vérifie si la procédure existe déjà et la supprime si c'est le cas
IF OBJECT_ID('dbo.UpdateFrenchProductCategoryName', 'P') IS NOT NULL
    DROP PROCEDURE dbo.UpdateFrenchProductCategoryName;
GO

-- Crée la nouvelle procédure stockée
CREATE PROCEDURE dbo.UpdateFrenchProductCategoryName
    @NewName NVARCHAR(50),
    @OldName NVARCHAR(50)
AS
BEGIN
    -- Met à jour le nom de la catégorie de produit en français
    UPDATE dbo.DimProductSubcategory
    SET dbo.DimProductSubcategory.FrenchProductSubcategoryName = @NewName
    WHERE dbo.DimProductSubcategory.FrenchProductSubcategoryName = @OldName
	AND dbo.DimProductSubcategory.ProductCategoryKey = 1
END;
GO


-- Liste toutes les procédures stockées dans la base de données
SELECT * FROM sys.procedures WHERE name = 'UpdateFrenchProductCategoryName';

USE AdventureWorksDW2022;
GO

-- Appelle la procédure
EXEC dbo.UpdateFrenchProductCategoryName @NewName = 'VTT', @OldName = 'test';

-- Affiche le texte de la procédure existante
EXEC sp_helptext 'dbo.UpdateFrenchProductCategoryName';



USE AdventureWorksDW2022
GO

ALTER PROCEDURE dbo.UpdateFrenchProductCategoryName
    @NewName NVARCHAR(50),
    @OldName NVARCHAR(50),
    @NewEnglishName NVARCHAR(50) = NULL  -- Nouveau paramètre avec valeur par défaut
AS
BEGIN
    -- Met à jour le nom de la catégorie de produit en français
	UPDATE dbo.DimProductSubcategory
    SET 
	dbo.DimProductSubcategory.FrenchProductSubcategoryName = @NewName,
	dbo.DimProductSubcategory.EnglishProductSubcategoryName = COALESCE(@NewEnglishName, dbo.DimProductSubcategory.EnglishProductSubcategoryName)  -- Met à jour l'anglais si fourni
    WHERE dbo.DimProductSubcategory.FrenchProductSubcategoryName = @OldName
	AND dbo.DimProductSubcategory.ProductCategoryKey = 1
END;
GO

-- Appel avec le nouveau paramètre
EXEC dbo.UpdateFrenchProductCategoryName @NewName = 'test', @OldName = 'VTT', @NewEnglishName = 'Mountain Bike';

-- Appel sans le nouveau paramètre
EXEC dbo.UpdateFrenchProductCategoryName @NewName = 'VTT', @OldName = 'test';



