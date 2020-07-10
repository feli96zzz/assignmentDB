------------------1.2.3----------------
DROP PROCEDURE IF EXISTS list_products_ofSeller ;
GO
CREATE PROCEDURE list_products_ofSeller2(@seller varchar(255),@idModel int,@name varchar(40)) 
AS
SELECT id_seller,id_productModel,name,status
FROM price INNER JOIN productModel ON price.id_productModel= productModel.id
WHERE ( @seller=id_seller  OR @idModel=id_productModel OR @name=name)
GROUP BY status,price.id_seller,price.id_productModel,productModel.name
ORDER BY id_seller;

GO
EXEC list_products_ofSeller2 @seller='SUNPOLO@online.vn',@idModel=NULL,@name=NULL;


--seller ranking by sold product, both ascending and descending
DROP PROC IF EXISTS prod_sold_by_seller
go
CREATE PROC prod_sold_by_seller
@mode int
AS
BEGIN
	if (@mode = 1)
		BEGIN
			SELECT storage.producerID, COUNT(*) AS 'GIẢM DẦN'
			FROM storage, product 
			WHERE product.idStorage = storage.id AND product.stock_out_date IS NOT NULL
			GROUP BY producerID
			ORDER BY COUNT(*) DESC;
		END;
	else
		BEGIN
			SELECT storage.producerID, COUNT(*) AS 'TĂNG DẦN'
			FROM storage, product 
			WHERE product.idStorage = storage.id AND product.stock_out_date IS NOT NULL
			GROUP BY producerID
			ORDER BY COUNT(*) ASC;
		END;
END;

--product models that has sold for x months 
DROP PROC IF EXISTS incompetent_products
GO
CREATE PROC incompetent_products
@months int
AS
BEGIN
	SELECT DISTINCT id, name, description, status, detailedInfo, brand, type
	FROM productModel, product
	WHERE
	productModel.id = product.id_product AND product.stock_out_date IS NOT NULL AND DATEDIFF(month, product.stock_out_date , GETDATE()) <= @months
END;