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
select * from price
select * from product
select * from storage
select * from seller
select * from member
select * from customer
--
---- insert laptop
insert into member values ('dientuhung@gmail.com', '0988221112', N'Điện tử Hùng', '123456')
insert into seller values ('20100101', '1234', N'Điện tử Hùng', 'laptop', 'dientuhung@gmail.com')
insert into storage (name, address, producerID) values (N'PTH 1', N'phạm thế hiển', 'dientuhung@gmail.com')
--insert into storage (name, address, producerID) values (N'HV 1', N'hùng vương', 'dientuhung@gmail.com')
insert into dbo.product (id_product, idStorage, stock_in_date) values (1, 1, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (1, 1, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (1, 1, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (1, 1, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (1, 1, '20180101')
insert into dbo.price values ('dientuhung@gmail.com', 1, 15000000, '20180101', '20181231')
insert into dbo.price values ('dientuhung@gmail.com', 1, 20000000, '20190101', '20191231')

--- insert smartphone
insert into member values ('dienthoaihieu@gmail.com', '09882211234', N'Điện thoại Hiếu', '12236')
insert into seller values ('20100101', '1234', N'Điện thoại Hiếu', 'smartphone', 'dienthoaihieu@gmail.com')
insert into storage (name, address, producerID) values (N'THĐ 1', N'Trần Hưng Đạo', 'dienthoaihieu@gmail.com')
--insert into storage (name, address, producerID) values (N'HB 1', N'Hồng Bàng', 'dienthoaihieu@gmail.com')
insert into dbo.product (id_product, idStorage, stock_in_date) values (4, 2, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (4, 2, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (4, 2, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (4, 2, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (4, 2, '20180101')
insert into dbo.price values ('dienthoaihieu@gmail.com', 4, 7000000, '20180101', '20181231')
insert into dbo.price values ('dienthoaihieu@gmail.com', 4, 10000000, '20190101', '20191231')

delete from price where price = 7000000 and start_date = '20190101'


-- thêm đơn hàng
insert into member values ('nguyenanhtu@gmail.com', '098822112', N'Nguyễn Anh Tú', '122326')
insert into customer values ('nguyenanhtu@gmail.com','nam', '19961024')
insert into orders (payment_method, destination, date, id_customer) values (N'thanh toán tiền mặt', N'nhà riêng', '20190630', 'nguyenanhtu@gmail.com')
select * from dbo.Co_Don_hang_nha_ban_mau_sp
insert into dbo.Co_Don_hang_nha_ban_mau_sp values (1, 1, 1, 'dientuhung@gmail.com')
insert into dbo.Co_Don_hang_nha_ban_mau_sp values (4, 1, 4, 'dienthoaihieu@gmail.com')
update dbo.Co_Don_hang_nha_ban_mau_sp set buy_amount = 3 where id_order = 1 and id_productModel = 1
update dbo.Co_Don_hang_nha_ban_mau_sp set buy_amount = 2 where id_order = 1 and id_productModel = 4

delete from dbo.Co_Don_hang_nha_ban_mau_sp where id_order = 1 and id_productModel = 4
---------^------ Tu test tính giá đơn hàng



----------------v Tu test tính doanh thu của một cửa hàng trong một khoảng thời gian
insert into member values ('dinhphuchung@gmail.com', '09223422112', N'Đinh Phúc Hưng', '1222123')
insert into customer values ('dinhphuchung@gmail.com','nam', '20000612')
insert into orders (payment_method, destination, date, id_customer) values (N'thanh toán tiền mặt', N'nhà riêng', '20180404', 'dinhphuchung@gmail.com')
select * from dbo.Co_Don_hang_nha_ban_mau_sp
insert into dbo.Co_Don_hang_nha_ban_mau_sp values (2, 2, 1, 'dientuhung@gmail.com')
insert into dbo.Co_Don_hang_nha_ban_mau_sp values (3, 2, 4, 'dienthoaihieu@gmail.com')
select dbo.doanhThu('dienthoaihieu@gmail.com', '20180101', '20181231')
select dbo.doanhThu('dienthoaihieu@gmail.com', '20190101', '20191231')
select dbo.doanhThu('dientuhung@gmail.com', '20180101', '20181231')
select dbo.doanhThu('dientuhung@gmail.com', '20190101', '20191231')
----------------^ Tu test tính doanh thu của một cửa hàng trong một khoảng thời gian