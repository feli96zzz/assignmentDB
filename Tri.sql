Alter trigger checkStatusProductModel
on Co_Don_hang_nha_ban_mau_sp
After Insert
as
Begin
	Declare @Conhang int
	Declare @id int
	Select @id= id_productModel from inserted
	Select @Conhang = count(*) from product where product.id_product=@id and product.stock_out_date is NULL
	print @id 
	print @Conhang
	if(@Conhang>0) 
	Begin
		Update dbo.productModel
		Set productModel.status='Not available'
		Where productModel.id=@id
	End
End
drop function insertSLSP 
create proc SLSP(
	@id_product      int ,
    @idStorage       int ,
    @stock_in_date   DATE
)
AS
Begin
	insert into product(id_product,idStorage,stock_in_date) values (@id_product, @idStorage, @stock_in_date) 
End

create function insertSLSP(
	@SL int,
	@id_product      int ,
    @idStorage       int ,
    @stock_in_date   DATE
)
Returns int as
Begin
	Declare @count int=0
	while(@count<@SL)
	Begin
		SLSP @id_product, @idStorage, @stock_in_date
		set @count +=1
	end
	Return 0
End
GO