---------------------------------tongHop
-----------------1.2.1-----------------------------
select * from dbo.typeProd
insert into dbo.typeProd values('laptop');
select * from dbo.productModel
INSERT INTO productModel(name, description, detailedInfo, brand, type)
VALUES ('asus nitro 5', 'Laptop Asus Vivobook', 'CPU AMD Ryzen 5 3500U', 'asus', 'laptop');
INSERT INTO productModel(name, description, detailedInfo, brand, type)
VALUES ('Dell G7', 'Dell G7 Inspiron 7591 KJ2G41', 'CPU Intel Core i7 9750H', 'Dell', 'laptop');
productModel_Add 'Lenovo Ideapad L340', 'Laptop Lenovo Ideapad L340 15IRH 81LK00XLVN', 'CPU Intel Core i5 9300H', 'Lenovo', 'laptop'
productModel_Add 'iPhone XS', 'iPhone XS 64GB', 'Màn hình OLED: 5.8 inch Super Retina', 'Apple', 'smartphone'
productModel_Add 'iPad Pro 11', 'iPad Pro 11 inch 2018 64GB Wifi', 'CPU A12X Bionic 64bit Neural Engine M12 7 nhân GPU', 'Apple', 'tablet'

update_productModel '4', 'iPhone 12', 'iPhone 12 64GB', 'Màn hình OLED: 5.8 inch Super Retina','Apple', 'smartphone'

delProcMod '4'

---------v------ Tu test tính giá đơn hàng
select * from dbo.orders
select * from dbo.Co_Don_hang_nha_ban_mau_sp
select * from dbo.productModel
select * from product
select * from price
select * from storage
select * from seller
select * from member
--
insert into member values ('dientuhung@gmail.com', '0988221112', N'Điện tử Hùng', '123456')
insert into seller values ('20100101', '1234', N'Điện tử Hùng', 'laptop', 'dientuhung@gmail.com')
insert into dbo.product (id_product, idStorage, stock_in_date) values (1, 5, '20200505')

--

insert into dbo.Co_Don_hang_nha_ban_mau_sp values (6, 2, 3, 'baba@gmail.com')
update dbo.Co_Don_hang_nha_ban_mau_sp set buy_amount = 5 where id_order = 2 and id_productModel = 3
update dbo.product set stock_out_date = NULL where id_product = 11 and STT = 2
insert into dbo.Co_Don_hang_nha_ban_mau_sp values (1, 2, 11, 'batu@gmail.com')
delete from dbo.Co_Don_hang_nha_ban_mau_sp where id_order = 2 and id_productModel = 3
delete from dbo.Co_Don_hang_nha_ban_mau_sp where id_order = 2 and id_productModel = 11
insert into dbo.Co_Don_hang_nha_ban_mau_sp values (1, 2, 11, 'batu@gmail.com')
update dbo.orders set date = '20200707' where id = 2



---------^------ Tu test tính giá đơn hàng
