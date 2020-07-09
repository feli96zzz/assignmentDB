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


------------------Bang so luong hang da ban theo id---------------------------------------------------------------
Create function SoLuongSP(@fromDate Date,@toDate Date)
Returns table as
Return
	Select  product.id_product, count(*)as SL, product.stock_out_date
	From	product
	Where	@fromDate<=product.stock_out_date and product.stock_out_date <= @toDate and stock_out_date is not NULL 
	Group by product.id_product, stock_out_date