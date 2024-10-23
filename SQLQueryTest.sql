USE AdventureWorksDW2022  
GO

Select * from dbo.DimCustomer
where MiddleName is not null 

Select * from dbo.DimProductCategory, dbo.DimProductSubcategory
where dbo.DimProductCategory.ProductCategoryKey = dbo.DimProductSubcategory.ProductCategoryKey

Select dbo.DimProductCategory.ProductCategoryKey, dbo.DimProductCategory.EnglishProductCategoryName, dbo.DimProductSubcategory.FrenchProductSubcategoryName
from dbo.DimProductCategory
LEFT Join dbo.DimProductSubcategory on dbo.DimProductCategory.ProductCategoryKey = dbo.DimProductSubcategory.ProductCategoryKey
ORDER BY dbo.DimProductCategory.EnglishProductCategoryName

Select dbo.DimProductCategory.ProductCategoryKey, dbo.DimProductCategory.EnglishProductCategoryName, dbo.DimProductSubcategory.FrenchProductSubcategoryName
from dbo.DimProductCategory
INNER JOIN dbo.DimProductSubcategory on dbo.DimProductCategory.ProductCategoryKey = dbo.DimProductSubcategory.ProductCategoryKey

UPDATE dbo.DimProductSubcategory 
SET dbo.DimProductSubcategory.FrenchProductSubcategoryName = 'test' 
where dbo.DimProductSubcategory.FrenchProductSubcategoryName = 'VTT'
AND dbo.DimProductSubcategory.ProductCategoryKey = 1

SELECT * from dbo.DimProductSubcategory
where dbo.DimProductSubcategory.FrenchProductSubcategoryName = 'VTT'

