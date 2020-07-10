------------------1.2.3----------------
DROP PROCEDURE IF EXISTS list_products_ofSeller ;
GO
CREATE PROCEDURE list_products_ofSeller(@seller varchar(255),@idModel int,@name varchar(40)) 
AS
SELECT id_seller,id_productModel,name,status
FROM provider INNER JOIN productModel ON provider.id_productModel= productModel.id
WHERE ( @seller=id_seller  OR @idModel=id_productModel OR @name=name)
GROUP BY status,provider.id_seller,provider.id_productModel,productModel.name
ORDER BY id_seller;

GO
EXEC list_products_ofSeller @seller='SUNPOLO@online.vn',@idModel=NULL,@name=NULL;


--DROP PROCEDURE IF EXISTS 
GO

CREATE PROCEDURE calculate_star_of_product (@id_product int)
AS
SELECT id_customer,id_product,star
FROM review
WHERE @id_product=id_product
GROUP BY id_customer,id_product,star



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
