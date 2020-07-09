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
