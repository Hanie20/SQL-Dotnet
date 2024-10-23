USE AdventureWorksDW2022  
GO

-- V�rifie si la proc�dure existe d�j� et la supprime si c'est le cas
IF OBJECT_ID('dbo.UpdateFrenchProductCategoryName', 'P') IS NOT NULL
    DROP PROCEDURE dbo.UpdateFrenchProductCategoryName;
GO

-- Cr�e la nouvelle proc�dure stock�e
CREATE PROCEDURE dbo.UpdateFrenchProductCategoryName
    @NewName NVARCHAR(50),
    @OldName NVARCHAR(50)
AS
BEGIN
    -- Met � jour le nom de la cat�gorie de produit en fran�ais
    UPDATE dbo.DimProductSubcategory
    SET dbo.DimProductSubcategory.FrenchProductSubcategoryName = @NewName
    WHERE dbo.DimProductSubcategory.FrenchProductSubcategoryName = @OldName
	AND dbo.DimProductSubcategory.ProductCategoryKey = 1
END;
GO


-- Liste toutes les proc�dures stock�es dans la base de donn�es
SELECT * FROM sys.procedures WHERE name = 'UpdateFrenchProductCategoryName';

USE AdventureWorksDW2022;
GO

-- Appelle la proc�dure
EXEC dbo.UpdateFrenchProductCategoryName @NewName = 'VTT', @OldName = 'test';

-- Affiche le texte de la proc�dure existante
EXEC sp_helptext 'dbo.UpdateFrenchProductCategoryName';



USE AdventureWorksDW2022
GO

ALTER PROCEDURE dbo.UpdateFrenchProductCategoryName
    @NewName NVARCHAR(50),
    @OldName NVARCHAR(50),
    @NewEnglishName NVARCHAR(50) = NULL  -- Nouveau param�tre avec valeur par d�faut
AS
BEGIN
    -- Met � jour le nom de la cat�gorie de produit en fran�ais
	UPDATE dbo.DimProductSubcategory
    SET 
	dbo.DimProductSubcategory.FrenchProductSubcategoryName = @NewName,
	dbo.DimProductSubcategory.EnglishProductSubcategoryName = COALESCE(@NewEnglishName, dbo.DimProductSubcategory.EnglishProductSubcategoryName)  -- Met � jour l'anglais si fourni
    WHERE dbo.DimProductSubcategory.FrenchProductSubcategoryName = @OldName
	AND dbo.DimProductSubcategory.ProductCategoryKey = 1
END;
GO

-- Appel avec le nouveau param�tre
EXEC dbo.UpdateFrenchProductCategoryName @NewName = 'test', @OldName = 'VTT', @NewEnglishName = 'Mountain Bike';

-- Appel sans le nouveau param�tre
EXEC dbo.UpdateFrenchProductCategoryName @NewName = 'VTT', @OldName = 'test';



