--New indices for the fourth task
CREATE INDEX NewCoolIndex1 ON Marketing.Product (ProductID)
INCLUDE (ProductModelID, SubcategoryID);

CREATE INDEX NewCoolIndex2 ON Marketing.ProductModel (ProductModelID)
INCLUDE (ProductModel);

CREATE INDEX NewCoolIndex3 ON Marketing.Subcategory (CategoryID)
INCLUDE (SubcategoryName);
