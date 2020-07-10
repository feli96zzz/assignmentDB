------------------1.2.3----------------
DROP PROCEDURE IF EXISTS list_products_ofSeller ;
GO
create PROCEDURE list_products_ofSeller(@seller varchar(255),@idModel int,@name varchar(40)) 
AS
SELECT id_seller,id_productModel,name,status
FROM price INNER JOIN productModel ON price.id_productModel= productModel.id	
WHERE ( @seller=id_seller  OR @idModel=id_productModel)
GROUP BY status,price.id_seller,price.id_productModel,productModel.name
HAVING @name=name
ORDER BY id_seller;

GO
EXEC list_products_ofSeller @seller='dientuhung@gmail.com',@idModel=NULL,@name='asus nitro 5';
SElect * from productModel
SELECT * from price



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
create PROC incompetent_products
@months int, @date date
AS
BEGIN
	SELECT DISTINCT id, name, description, status, detailedInfo, brand, type
	FROM productModel, product
	WHERE
	productModel.id = product.id_product AND product.stock_out_date IS NOT NULL AND DATEDIFF(month, product.stock_out_date , @date) <= @months
END;


