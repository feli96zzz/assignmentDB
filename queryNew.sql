---------------------------------tongHop
USE TIKI;

GO
create TRIGGER max_storages ON storage FOR INSERT
AS
BEGIN
	DECLARE @id int, @name varchar(40), @a int, @producerID varchar(255); 
	SELECT @id = id, @name=name, @producerID=producerID
	FROM inserted 

	SELECT @a = COUNT(*)
	FROM storage
    WHERE @producerID =storage.producerID
	if (5 < @a)
		BEGIN 
			print N'Lỗi nhiều hơn 5 kho hàng cho 1 nhà bán';
			rollback tran;
		END;		
END;

GO


create TRIGGER max_department ON current_working_department FOR INSERT 
AS
BEGIN
    DECLARE @id_staff int, @count int , @i int,@start date,@end date ;
    SELECT @id_staff=id_staff,@start=start_date,@end=end_date
    FROM inserted

    SELECT @i =COUNT(*)
    FROM current_working_department
    WHERE current_working_department.id_staff=@id_staff 
        AND current_working_department.start_date < @start
        AND current_working_department.end_date >= @end
    if (2 < @i)
    BEGIN 
			print N'Nhân viên đã thuộc 2 phòng ban không thể làm thêm ở phòng ban khác';
			rollback tran;
	END;		
END;
GO

create TRIGGER max_receipts ON receipt FOR INSERT 
AS
BEGIN
    DECLARE @i int,@id_order int
    SELECT @id_order = id_order
    FROM inserted

    SELECT @i =COUNT(*)
    FROM receipt
    WHERE receipt.id_order=@id_order
    IF (4 < @i)
    BEGIN 
			print N'Tối đa 4 hóa đơn cho 1 đơn hàng';
			rollback tran;
	END;
END;
GO


create TRIGGER averge_price ON price FOR INSERT 
AS
BEGIN
    DECLARE @i int, @max int =0, @min int =0, @idProd int;

    SELECT @idProd=id_productModel
    FROM inserted
    SELECT @min=MIN(price)
    FROM price
    WHERE price.id_productModel= @idProd
    SELECT  @max=MAX(price) 
    FROM price
    WHERE price.id_productModel= @idProd
    IF (@idProd > @max)
        Set @max=@idProd;        
    IF (@idProd <@min)         
        Set @min=@idProd;        
    IF (@max<1.5*@min)
    BEGIN 
			print N'Giá cả quá trên lệch so với giá thị trường';
			rollback tran;
	END;    
END;
GO 

create TRIGGER max_delivery ON cargo FOR INSERT 
AS
BEGIN 
	DECLARE @pack date, @rec date;
	SELECT @pack=date_packed
	FROM inserted
	SELECT @pack=date_receive
	FROM inserted
    IF (DATEDIFF(DAY,@pack,@rec)>30)
    ROLLBACK TRAN;
END;
GO

-----------------1.2.1-----------------------------

create FUNCTION dbo.IsInt
(
@number VARCHAR(20)
)
RETURNS BIT
AS
BEGIN

   RETURN ISNUMERIC(Replace(Replace(@number,'+','A'),'-','A') + '.0e0')

END
GO

create proc productmodel_Add(
   @name         varchar(40),
   @description  varchar(1000),
   @detailedInfo varchar(1000),
   @brand	      varchar(10),
   @type         varchar(40)
)
As 
Begin
	if not exists (Select typeProd.type From typeProd Where typeProd.type=@type)
	Begin
		Print N'Ngành hàng của mẫu sản phẩm chưa có trong ngành hàng !!'
		Insert into typeprod(type) values(@type)
		Print N'Đã tạo mới ngành hàng ' + @type
		Insert into productmodel(name, description,detailedInfo,brand,type) values(@name, @description, @detailedInfo,@brand,@type)
		Print N'Đã thêm mới mẫu sản phẩm ' + @name
	End
	Else 
		Insert into productmodel(name, description,detailedInfo,brand,type) values(@name, @description, @detailedInfo,@brand, @type)
End
GO

create PROC update_productModel --use id to change other attributes of the tuple
@id nvarchar(20), @name nvarchar(20), @description nvarchar(1000), @detailedInfo nvarchar(1000), @brand nvarchar(10), @type nvarchar(40)
AS
	BEGIN
		if (ISNUMERIC(@id)=0)
		BEGIN
			print N'ID không phải là một số, vui lòng thử lại';
			RETURN;
		END;
	else
		BEGIN
			if (NOT EXISTS (SELECT * FROM productModel where productModel.id = @id)) 
					BEGIN
						print N'Không có tập dữ liệu nào mang id như trên';
						RETURN;
					END;
			else
				BEGIN
					if (ISNUMERIC(@name) = 1) 
						BEGIN
							print N'Sai kiểu dữ liệu cho trường tên'
							RETURN;
						END;
					if (ISNUMERIC(@description) = 1) 
						BEGIN
							print N'Sai kiểu dữ liệu cho trường mô tả'
							RETURN;
						END;
					if (ISNUMERIC(@detailedInfo) = 1)
						BEGIN
							print N'Sai kiểu dữ liệu cho trường thông tin chi tiết'
							RETURN;
						END;
					if (ISNUMERIC(@brand) = 1)
						BEGIN
							print N'Sai kiểu dữ liệu cho trường hãng'
							RETURN;
						END;
					if (ISNUMERIC(@type) = 1)
						BEGIN
							print N'Sai kiểu dữ liệu cho trường kiểu sản phẩm'
							RETURN;
						END;
					if (NOT EXISTS (SELECT * FROM typeProd WHERE @type = typeProd.type))
						BEGIN
							print N'Không tồn tại kiểu sản phẩm này trong csdl';
							RETURN;
						END;
					UPDATE productModel
					SET "name" = @name, "description" = @description, "detailedInfo" = @detailedInfo,"brand" = @brand, "type" = @type
					WHERE productModel.id = @id;
				END;	
		END;	
	END;
GO



create PROCEDURE delProcMod (@str varchar(20))
AS
BEGIN
	IF (dbo.IsInt(@str)=0)
	BEGIN
		PRINT 'Input doesnt a positive integer'
		RETURN
	END
	declare @id INT = cast(@str as int)
	DECLARE @countRecordByID INT
	select @countRecordByID = COUNT(*) from productModel where id = @id
	if (@countRecordByID = 0)
	begin
		print 'id '+cast(@id as varchar)+' doesnt exist'
		return
	end
	select @countRecordByID = COUNT(*) from colorProd where id_Prod = @id
	if (@countRecordByID > 0)
	begin
		print 'co mau san pham trong bang mau sac'
		return
	end
	select @countRecordByID = COUNT(*) from colorProd where id_Prod = @id
	if (@countRecordByID > 0)
	begin
		print 'khong xoa dc, con san pham trong bang mau sac'
		return
	end
	select @countRecordByID = COUNT(*) from product where id_product = @id
	if (@countRecordByID > 0)
	begin
		print 'khong xoa dc, con san pham trong bang san pham'
		return
	end
	select @countRecordByID = COUNT(*) from Co_Don_hang_nha_ban_mau_sp where id_productModel = @id
	if (@countRecordByID > 0)
	begin
		print 'khong xoa dc, co san pham trong don hang'
		return
	end
	select @countRecordByID = COUNT(*) from provider  where id_productModel = @id
	if (@countRecordByID > 0)
	begin
		print 'khong xoa dc, con nha cung cap san pham'
		return
	end
	select @countRecordByID = COUNT(*) from review  where id_product = @id
	if (@countRecordByID > 0)
	begin
		print 'khong xoa dc, con danh gia san pham'
		return
	end
		DELETE FROM productModel WHERE id = @id
END
GO
---------------------------------1.2.1
---------------------------------1.2.2
---- trigger kiểm tra tình trạng hàng hóa

create function dbo.checkStatus(@id int)
Returns bit as
Begin
	Declare @bitRetVal as Bit 
	Set @bitRetVal=0
	Declare @Count int
	Set @Count=(Select	Count(Product.STT)--,Dept_locations.dnumber
				From	Productmodel inner join product on Productmodel.id=product.id_product
				Where	product.id_product=@id
				Group by product.id_product)
	If (@Count>0) Set @bitRetVal=1
	Return @bitRetval
End
GO

create TRIGGER themSanPham ON product AFTER INSERT AS 
BEGIN
	UPDATE productModel
	SET status = 'Available'
	FROM productModel
	JOIN inserted ON productModel.id = inserted.id_product
END
GO

create trigger product_delete
on dbo.product
After Delete
as
Begin
	Declare @id_product	int
	Select @id_product=id_product from deleted
	if(dbo.checkStatus(@id_product)=0) 
	Begin
		Update dbo.productmodel
		Set	status='Not available'
		Where productmodel.id=@id_product
	End
End
GO

/*
create proc product_Delete( @id_product int,@stt int)
AS
	Begin
		if (dbo.checkStatus(@id_product)=0)
			Print N'Khong co san pham de xoa'
		Else
		Begin
			Delete from product 
			Where product.id_product=@id_product And product.STT=@stt
		End
	End
GO*/
---------------^^^^^ kiểm tra tình trạng hàng hóa

--------------------------------------vvvvvvvvv trigger kiểm trong kho còn đủ sản phẩm đề thêm vào đơn hàng ko

--------------------INSERT--------------------

create TRIGGER ins_prod_2_cart ON Co_Don_hang_nha_ban_mau_sp FOR INSERT
AS
BEGIN
	DECLARE @a int, @b int, @c int, @d nvarchar(255), @e int; 
	SELECT @a = buy_amount, @b = id_productModel, @d = id_seller, @e = id_order
	FROM inserted 
	WHERE id_order NOT IN (SELECT id_order FROM deleted);

	SELECT @c = COUNT(*)
	FROM product
	WHERE @b = product.id_product AND stock_out_date IS NULL AND idStorage IN (SELECT id
																			  FROM storage
																			  WHERE @d = producerID) ;
	if (@c < @a)
		BEGIN 
			print N'Lỗi: Hủy giao dịch do mua số lượng quá lớn ('+ cast(@a as nvarchar(2)) + N' nhưng chỉ có ' + cast(@c as nvarchar(2)) + ')';
			rollback tran;
		END;
	else
		WHILE(@a > 0)
			BEGIN --update purchased 
				print N'đã thêm 1 món vào giỏ hàng';
				UPDATE product
				SET stock_out_date = (select dbo.orders.date from dbo.orders where dbo.orders.id = @e)
				WHERE STT = (SELECT MAX(STT) --find available product with the highest ID
							 FROM product
							 WHERE @b = id_product AND stock_out_date IS NULL AND idStorage IN (SELECT id
																								FROM storage
																								 WHERE @d = producerID));
				SELECT @a = @a - 1;
			END;
END;
GO




create TRIGGER update_cart ON Co_Don_hang_nha_ban_mau_sp AFTER UPDATE
AS
BEGIN
	DECLARE @newA int, @oldA int, @b int, @c int, @d nvarchar(255), @e int
	SELECT @newA = A.buy_amount, @oldA = B.buy_amount, @b = A.id_productModel, @d = A.id_seller, @e = A.id_order
	FROM inserted as A, deleted as B
	WHERE (A.buy_amount != B.buy_amount);
	if (@newA < 1) or (@oldA < 1)
		BEGIN
			print N'Số lượng nhập vào bé hơn 1, hủy cập nhật';
			ROLLBACK TRAN;
		END;
	--print N'Số cũ là ' + cast(@oldA as char(2)) + N' số mới là ' + cast(@newA as char(2));
	SELECT @c = COUNT(*)
	FROM product
	WHERE @b = product.id_product AND stock_out_date IS NULL AND idStorage IN (SELECT id
																			  FROM storage
																			  WHERE @d = producerID) ;
	--print cast(@oldA as char(10)) + ' ' + cast(@newA as char(10)) + ' ' + cast(@c as char(1));
	if (@newA - @oldA < 0) -- remove some items out of the cart 
		BEGIN
			DECLARE @temp int = @oldA - @newA;
			WHILE (@temp > 0)
				BEGIN
					UPDATE product
					SET stock_out_date = NULL
					WHERE STT = (SELECT MAX(STT)
					FROM product
					WHERE @b = id_product AND stock_out_date IS NOT NULL AND idStorage IN (SELECT id
																						   FROM storage
																						   WHERE @d = producerID));
					SELECT @temp = @temp -1;
					print N'Đã cập nhật xóa 1 sản phẩm khỏi giỏ';
				END;
		END;
	if (@newA - @oldA > 0) -- add some items to the cart
		BEGIN
			DECLARE @temp1 int = @newA - @oldA;
			if (@c < @temp1)
				BEGIN
					print N'Lỗi: Hủy cập nhật do mua số lượng quá lớn ('+ cast(@temp1 as nvarchar(2)) + N' nhưng chỉ có ' + cast(@c as nvarchar(2)) + ')';
					ROLLBACK TRAN;
				END;
			else
				WHILE (@temp1 > 0)
					BEGIN
						UPDATE product
						SET stock_out_date = (select dbo.orders.date from dbo.orders where dbo.orders.id = @e)
						WHERE STT = (SELECT MAX(STT) --find available product with the highest ID
									FROM product
									WHERE @b = id_product AND stock_out_date IS NULL AND idStorage IN (SELECT id
																									   FROM storage
																									   WHERE @d = producerID));
						SELECT @temp1 = @temp1 - 1;
						print N'Đã cập nhật thêm 1 sản phẩm vào giỏ'
					END;
		END;
	if (@newA = @oldA)
		BEGIN
			print N'Không có gì xảy ra vì bạn không cập nhật gì';
			RETURN;
		END;
END;
GO


-------------------DELETE-------------------
create TRIGGER del_from_cart ON Co_Don_hang_nha_ban_mau_sp FOR DELETE
AS
BEGIN
	DECLARE @a int, @b int, @c nvarchar(255);
	SELECT @a = buy_amount, @b = id_productModel, @c = id_seller
	FROM deleted 
	WHERE id_order NOT IN (SELECT id_order FROM inserted);
	WHILE( @a != 0)
		BEGIN
			UPDATE product
			SET stock_out_date = NULL
			WHERE STT = (SELECT MAX(STT)
						 FROM product
						 WHERE @b = id_product AND stock_out_date IS NOT NULL AND IdStorage IN (SELECT id
																							   FROM storage
																							   WHERE @c = producerID));
			SELECT @a = @a -1;
			print N'Đã xóa 1 sản phẩm khỏi giỏ';
		END;
END;
GO



------------------------ ^^^^^^^^^^^^^trigger kiểm trong kho còn đủ sản phẩm đề thêm vào đơn hàng ko

--------------------------------------vvvvvvv trigger tính thuộc tính dẫn xuất giá đơn hàng trong đơn hàng

create TRIGGER insert_CO ON Co_Don_hang_nha_ban_mau_sp AFTER INSERT AS 
BEGIN
	UPDATE orders
	SET giaDonHang = giaDonHang + 
	(SELECT buy_amount FROM inserted WHERE id_order = orders.id) * 
	dbo.giaSanPham(inserted.id_seller, inserted.id_productModel, orders.date)
	FROM orders JOIN inserted ON orders.id = inserted.id_order
END
GO


create TRIGGER delete_CO ON Co_Don_hang_nha_ban_mau_sp FOR DELETE AS 
BEGIN
	UPDATE orders
	SET giaDonHang = giaDonHang - (SELECT buy_amount FROM deleted WHERE id_order = orders.id) *
	dbo.giaSanPham(deleted.id_seller, deleted.id_productModel, orders.date)
	FROM orders
	JOIN deleted ON orders.id = deleted.id_order
END
GO

create TRIGGER update_CO on Co_Don_hang_nha_ban_mau_sp after update AS
BEGIN

	UPDATE orders
	SET giaDonHang = giaDonHang - (SELECT buy_amount FROM deleted WHERE id_order = orders.id) *
	dbo.giaSanPham(deleted.id_seller, deleted.id_productModel, orders.date)
	FROM orders
	JOIN deleted ON orders.id = deleted.id_order

	UPDATE orders
	SET giaDonHang = giaDonHang + 
	(SELECT buy_amount FROM inserted WHERE id_order = orders.id) * 
	dbo.giaSanPham(inserted.id_seller, inserted.id_productModel, orders.date)
	FROM orders JOIN inserted ON orders.id = inserted.id_order

	Declare @Conhang int
	Declare @id int
	Select @id= id_productModel from inserted
	Select @Conhang = count(*) from product where product.id_product=@id and product.stock_out_date is NULL
	Print @id
	Print @Conhang
	if(@Conhang=0) 
	Begin
		Update dbo.productModel
		Set productModel.status='Not available'
		Where productModel.id=@id
	End
	Else
	Begin
		Update dbo.productModel
		Set productModel.status='Available'
		Where productModel.id=@id
	END
END
GO


------------------------------------^^^^^^ trigger tính thuộc tính dẫn xuất giá đơn hàng trong đơn hàng
create trigger checkStatusProductModel
on Co_Don_hang_nha_ban_mau_sp
After Insert
as
Begin
	Declare @Conhang int
	Declare @id int
	Select @id= id_productModel from inserted
	Select @Conhang = count(*) from product where product.id_product=@id and product.stock_out_date is NULL
	if(@Conhang=0) 
	Begin
		Update dbo.productModel
		Set productModel.status='Not available'
		Where productModel.id=@id
	End
End
GO
---------vvvvvvvvvvvvvv function tính doanh thu trong một khoảng thời gian

create function giaSanPham(@maNhaBan varchar(255), @maMauSanPham INT, @stock_out_date date)
returns INT
as
begin
	declare @gia INT
	select @gia = price from price where id_seller = @maNhaBan and id_productModel =  @maMauSanPham and (@stock_out_date >= start_date) and (@stock_out_date <= end_date)
	return @gia
end
GO



create function khoHangCuaNhaBan(@maNhaBan varchar(255))
Returns table
AS 
return select id from storage where producerID = @maNhaBan
GO


create function sanPhamTrongKhoHang(@id_kho_hang INT)
returns table
as return select id_product, STT, stock_out_date from product where idStorage = @id_kho_hang
GO


create function doanhThu(@maNhaBan varchar(255), @fromDate date, @toDate date)
returns INT
as
begin
	declare @doanhThu INT = 0
	-- tạo con trỏ kho hàng
	declare khoHangCursor Cursor for select * from khoHangCuaNhaBan(@maNhaBan)
	open khoHangCursor
		declare @id INT
		fetch next from khoHangCursor into @id
		while @@FETCH_STATUS = 0
		begin
			declare sanPhamCursor Cursor for select * from sanPhamTrongKhoHang(@id)
			open sanPhamCursor
			declare @id_product INT, @STT INT, @stock_out_date date
			fetch next from sanPhamCursor into @id_product, @STT, @stock_out_date
			while @@FETCH_STATUS = 0
			begin
				if ((@stock_out_date IS NOT NULL) and (@stock_out_date >= @fromDate) and (@stock_out_date <= @toDate))
				begin
					set @doanhThu += dbo.giaSanPham(@maNhaBan, @id_product, @stock_out_date)
				end
				fetch next from sanPhamCursor into @id_product, @STT, @stock_out_date
			end
			close sanPhamCursor
			deallocate sanPhamCursor
			fetch next from khoHangCursor into @id
		end
	close khoHangCursor
	deallocate khoHangCursor
	
	return @doanhThu
end
GO


---------^^^^^^^^^^^^^^ function tính doanh thu trong một khoảng thời gian

------------------Bang so luong hang da ban theo id---------------------------------------------------------------
create function SoLuongSP(@fromDate Date,@toDate Date)
Returns table as
Return
	Select  product.id_product, count(*)as SL, product.stock_out_date
	From	product
	Where	@fromDate<=product.stock_out_date and product.stock_out_date <= @toDate and stock_out_date is not NULL 
	Group by product.id_product, stock_out_date
GO
-----------------------vvvvvvvvvvvvvvvvvvv function tính giá hóa đơn
create FUNCTION calPrice (@id_receipt int)
Returns int as 
Begin
	Declare @sum int 
	Set @sum=0
	Declare @price int
	Declare @SL int
	Declare @id_product int
	Declare cursorCal CURSOR FOR
	Select SL,price
	from dbo.countItem(@id_receipt)
	Open cursorCal
	Fetch next from cursorCal
		into @SL,@price
	WHILE @@FETCH_STATUS = 0
	BEGIN
		Set @sum= @sum+ @price * @SL
		Fetch next from cursorCal
		into @SL,@price
	End
	close cursorCal
	Deallocate cursorCal
	Return @sum
End
GO
---------------------Ham countItem----------------------------------------------------------------------

create function countItem(@id_receipt int)
Returns table as
Return
	Select count(product_in_receipt.stt) as SL,product_in_receipt.price,product_in_receipt.id_product
	From product_in_receipt
	Where  product_in_receipt.id_receipt=@id_receipt
	Group by product_in_receipt.id_product,product_in_receipt.price
GO

----------------------^^^^^^^^^^^^^^^^^^^ function tính giá hóa đơn






--------v view của Hưng
create PROC prod_sold_by_seller
@mode int
AS
BEGIN
	if (@mode = 1)
		BEGIN
			SELECT storage.producerID, COUNT(*)
			FROM storage, product 
			WHERE product.idStorage = storage.id AND product.stock_out_date IS NOT NULL
			GROUP BY producerID
			ORDER BY COUNT(*) DESC;
		END;
	else
		BEGIN
			SELECT storage.producerID, COUNT(*)
			FROM storage, product 
			WHERE product.idStorage = storage.id AND product.stock_out_date IS NOT NULL
			GROUP BY producerID
			ORDER BY COUNT(*) ASC;
		END;
END;
GO

--------^ view của Hưng



--product models that has sold for x months 
create PROC incompetent_products

@months int, @date date
AS
BEGIN
	SELECT DISTINCT id, name, description, status, detailedInfo, brand, type
	FROM productModel, product
	WHERE
	productModel.id = product.id_product AND product.stock_out_date IS NOT NULL AND DATEDIFF(month, product.stock_out_date , @date) <= @months
	order by name asc
END;
go

CREATE PROCEDURE list_products_ofSeller(@seller varchar(255),@idModel int,@name varchar(40)) 
AS
SELECT id_seller,id_productModel,name,status
FROM provider INNER JOIN productModel ON provider.id_productModel= productModel.id
WHERE ( @seller=id_seller  OR @idModel=id_productModel OR @name=name)
GROUP BY status,provider.id_seller,provider.id_productModel,productModel.name
ORDER BY id_seller ;
go

create function SoLuongSP2(@sl int, @fromDate Date,@toDate Date)
Returns table as
Return
	Select  product.id_product, count(*)as SL, product.stock_out_date
	From	product
	Where	@fromDate<=product.stock_out_date and product.stock_out_date <= @toDate and stock_out_date is not NULL 
	Group by product.id_product, stock_out_date
	having COUNT(*) > @sl
GO

create proc SLmauSanPhamLonHonN (@sl int, @fromDate Date,@toDate Date)
AS
	Begin
		select * from dbo.productModel where id IN (select id_product from SoLuongSP2 (@sl, @fromDate, @toDate))
	End
=======
END;
--------^ view của Hưng

