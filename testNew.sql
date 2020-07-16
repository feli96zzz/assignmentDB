---------------------------------tongHop
-----------------1.2.1-----------------------------
select * from dbo.typeProd
insert into dbo.typeProd values('laptop');
select * from dbo.productModel
INSERT INTO productModel(name, description, detailedInfo, brand, type)
VALUES ('asus nitro 5', 'Laptop Asus Vivobook', 'CPU AMD Ryzen 5 3500U', 'asus', 'laptop');
INSERT INTO productModel(name, description, detailedInfo, brand, type)
VALUES ('Dell G7', 'Dell G7 Inspiron 7591 KJ2G41', 'CPU Intel Core i7 9750H', 'Dell', 'laptop');
EXEC productmodel_Add 'Lenovo Ideapad L340', 'Laptop Lenovo Ideapad L340 15IRH 81LK00XLVN', 'CPU Intel Core i5 9300H', 'Lenovo', 'laptop'
EXEC productmodel_Add 'iPhone XS', 'iPhone XS 64GB', 'Màn hình OLED: 5.8 inch Super Retina', 'Apple', 'smartphone'
EXEC productmodel_Add 'iPad Pro 11', 'iPad Pro 11 inch 2018 64GB Wifi', 'CPU A12X Bionic 64bit Neural Engine M12 7 nhân GPU', 'Apple', 'tablet'

EXEC update_productModel '4', 'iPhone 12', 'iPhone 12 64GB', 'Màn hình OLED: 5.8 inch Super Retina','Apple', 'smartphone'


delProcMod '-1'
delProcMod '6'
delProcMod 'adsafdsafdsaf'
delProcMod '7'


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
insert into storage (name, address, producerID) values (N'HV 1', N'hùng vương', 'dientuhung@gmail.com')
insert into dbo.product (id_product, idStorage, stock_in_date) values (1, 1, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (1, 1, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (1, 2, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (1, 2, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (1, 2, '20180101')
insert into dbo.price values ('dientuhung@gmail.com', 1, 15000000, '20180101', '20181231')
insert into dbo.price values ('dientuhung@gmail.com', 1, 20000000, '20190101', '20191231')


productModel_Add 'iPad Pro 11', 'iPad Pro 11 inch 2018 64GB Wifi', 'CPU A12X Bionic 64bit Neural Engine M12 7 nhân GPU', 'Apple', 'tablet'
insert into dbo.product (id_product, idStorage, stock_in_date) values (6, 2, '20180101')
delete from dbo.product where id_product = 6

--- insert smartphone
insert into member values ('dienthoaihieu@gmail.com', '09882211234', N'Điện thoại Hiếu', '12236')
insert into seller values ('20100101', '1234', N'Điện thoại Hiếu', 'smartphone', 'dienthoaihieu@gmail.com')
insert into storage (name, address, producerID) values (N'THĐ 1', N'Trần Hưng Đạo', 'dienthoaihieu@gmail.com')
insert into storage (name, address, producerID) values (N'HB 1', N'Hồng Bàng', 'dienthoaihieu@gmail.com')
insert into dbo.product (id_product, idStorage, stock_in_date) values (4, 3, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (4, 3, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (4, 3, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (4, 4, '20180101')
insert into dbo.product (id_product, idStorage, stock_in_date) values (4, 4, '20180101')
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
update dbo.Co_Don_hang_nha_ban_mau_sp set buy_amount = 5 where id_order = 1 and id_productModel = 1
update dbo.Co_Don_hang_nha_ban_mau_sp set buy_amount = 5 where id_order = 1 and id_productModel = 4
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
select * from seller
select * from storage
select * from product
select * from price
incompetent_products '6', '20180606'
update dbo.Co_Don_hang_nha_ban_mau_sp set buy_amount = 1 where id_order = 1 and id_productModel = 1
update dbo.Co_Don_hang_nha_ban_mau_sp set buy_amount = 1 where id_order = 1 and id_productModel = 4

prod_sold_by_seller 1
select * from product
list_productModel '6', '20180808', '4'
list_productModel '6', '20180808', '3'
list_productModel '6', '20180808', '2'
----------------^ Tu test tính doanh thu của một cửa hàng trong một khoảng thời gian

select * from SLmauSanPhamLonHonN (2, '20180101' , '20181231')

GO
USE Tiki;

INSERT INTO typeProd VALUES
(N'Giày văn phòng'),
(N'Thời trang'),
(N'Đồ gia dụng'),
(N'Đồ gia dụng và thời trang'),
(N'Ấm điện');

SET IDENTITY_INSERT productModel OFF
GO


INSERT INTO productModel (name,description,detailedInfo,brand,type)VALUES
(N'Giày Mọi Nam Da Bò Sunpolo SUMU1732DN
',N'Được may từ chất liệu da bò\n
',N'
Thương hiệu:	SUNPOLO\n
Xuất xứ:	Việt Nam\n
SKU:	6936588933581\n
Model:	SUMU1732DN\n
Chất liệu:	Da bò, đế cao su
', 'SUNPOLO',N'Giày văn phòng'),
(N'Giày da nam lười
',N'Phong cách lịch lãm ,thời trang\n
Kiểu dáng ôm chân\n
Độ bền cao',N'
Xuất xứ thương hiệu:Trung Quốc\n
', 'OEM',N'Giày văn phòng'),

(N'Ấm siêu tốc Nagakawa NAG0304 (1.7 Lít) ',N'Ngoài ra, ấm siêu tốc còn có vỏ nhựa nguyên sinh cao cấp bảo đảm an toàn sức khỏe cho bạn và những người thân yêu.\n
Thiết kế ấm rất tiện lợi, nút công tắc và mở nắp ngay phía trên rất tiện lợi để thao tác sử dụng.',N'Thương hiệu :Nagakawa
SKU:2618427263618\n
Xuất xứ:Trung Quốc\n
Model:NAG0304', 'Nagakawa',N'Ấm điện');

SET IDENTITY_INSERT productModel OFF;

INSERT INTO colorProd VALUES
(N'Nâu',1),
(N'Đen',1),
(N'Không màu',3);


INSERT INTO member VALUES
(N'brucelee@gmail.com',N'5557778651',N'brucelee',N'tiuelong'),
(N'bact@outlook.com',N'5657132',N'Hà Thanh Biên',N'Norway317'),
(N'jackychan@gmail.com',N'016523661',N'Jack',N'jackie'),
(N'SUNPOLO@online.vn',N'090992152',N'Tấn Trung',N'baroibeo'),
(N'OEM@gmail.com',N'09132160',N'Công ty OEM',N'oiankzdjk'),
(N'Nagakawa@nage.com',N'094123123',N'Công ty Nagakawa',N'adfaf');

INSERT INTO address VALUES
(N'jackychan@gmail.com',N'Obere Str. 57'),
(N'jackychan@gmail.com',N'Avda. de la Constitución 2222	'),
(N'bact@outlook.com',NULL),
(N'brucelee@gmail.com',N'Berkeley Gardens 12 Brewery')
;

INSERT INTO customer VALUES
(N'jackychan@gmail.com',N'male',N'1989-04-13'),
(N'bact@outlook.com',N'female',N'1999-06-20'),
(N'brucelee@gmail.com',N'female',N'1996-08-31');

INSERT INTO seller VALUES
(N'2000-06-09',N'01NA75SU',N'Giày dép',N'Thời trang',N'SUNPOLO@online.vn'),
(N'2010-12-09',N'41GA6116',N'Đồ gia dụng OEM',N'Đồ gia dụng và thời trang',N'OEM@gmail.com'),
(N'2012-12-09',N'41GA6116',N'Nagakawa',N'Đồ gia dụng',N'Nagakawa@nage.com');

INSERT INTO storage (name,address,producerID)VALUES
(N'SUNPOLO1',N'340 Hoảng Văn Thụ P9 Tân Bình, HCM',N'SUNPOLO@online.vn'),
(N'SUNPOLO2',N'340 Tân Kỳ Tân Quý ,Bình Tân, HCM',N'SUNPOLO@online.vn'),
(N'OEM01',N'400 Hoảng Văn Thụ P9 Tân Bình HCM',N'OEM@gmail.com');

INSERT INTO product (id_product,idStorage,stock_in_date)VALUES
(1,1,N'2020-01-31'),
(2,3,N'2020-02-28'),
(1,2,N'2020-01-31');

INSERT INTO staff (phone_num,name,gender,birthday,address,id_citizen)VALUES
(N'09106113',N'Nguyen An',N'male',N'2000-06-06',N'Av. dos Lusíadas, 23',N'613306161'),
(N'09906113',N'Nguyen Lam',N'female',N'1996-04-06',N'Av. dos Lusíadas, 23',N'613406161'),
(N'08606113',N'Nguyen Binh',N'male',N'1998-06-06',N'Hauptstr. 29',N'613306121');

INSERT INTO delivery_staff VALUES
(1,N''),(2,N'');

INSERT INTO order_staff VALUES
(1);

INSERT INTO staff_manager VALUES
(1,1,N'2020-07-07',N'2021-07-07');

INSERT INTO cargo (note,date_packed,date_receive,delivery_staff,status)VALUES
(N'không',N'2020-07-01',N'2020-07-07',1,N'chưa'),
(N'không',N'2020-07-15',N'2020-07-27',2,N'chưa');

INSERT INTO orders(payment_method,destination,date,status,id_customer) VALUES
(N'online banking',N'ul. Filtrowa 68',N'2020-07-07',N'Chưa giao',N'jackychan@gmail.com');

INSERT INTO receipt(total_products,date,id_order,id_cargo,id_staff_incharge) VALUES
(2,N'2020-07-07',1,1,1);


INSERT INTO product_in_receipt VALUES
(1,1,N'100000',1);



INSERT INTO provider VALUES
(N'SUNPOLO@online.vn',1,N'Bảo hành 6 tháng đổi trả');

----------------------
INSERT INTO department(name,description) VALUES
(N'phòng giao hàng',N'giao hàng'),
(N'phòng xử lý đơn hàng',N'xử lý đơn hàng');

INSERT INTO department_manager VALUES
(2,2,N'2020-07-07',N'2021-07-07');

INSERT INTO department_place VALUES
(1,N'Phường ĐaKao'),
(2,N'Phú Thọ'),
(2,N'Lý Thường Kiệt');

INSERT INTO current_working_department VALUES
(1,1,N'2020-01-25',N'2020-07-25'),
(2,1,N'2019-01-25',N'2020-08-25'),
(3,2,N'2020-01-25',N'2020-09-25');
