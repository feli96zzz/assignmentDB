DROP DATABASE IF EXISTS TIKI;
CREATE DATABASE TIKI;
GO
USE TIKI;
go
/*PRODUCT TABLES*/

CREATE TABLE typeProd(
	type      nvarchar(40),
	PRIMARY KEY (type)
);

CREATE TABLE productModel (
   id           int  NOT NULL IDENTITY(1,1),
   name         nvarchar(40),
   description  nvarchar(1000),
   status	    nvarchar(50) default 'Not available',
   detailedInfo nvarchar(1000),
   brand	      nvarchar(10),
   type         nvarchar(40),
   FOREIGN KEY (type) REFERENCES typeProd(type),   
   PRIMARY KEY(id)   
);
CREATE TABLE colorProd(
      color     nvarchar(40),
      id_Prod   int ,
      FOREIGN KEY(id_Prod) REFERENCES productModel(id)
);

/*member account*/


CREATE TABLE member(
      email     nvarchar (255),
      phone_num nvarchar(255),
      name      nvarchar (255),
      password  nvarchar (511) NOT NULL,
      PRIMARY KEY (email)
);

CREATE TABLE address(
      email     nvarchar(255),
      address   nvarchar(255),
      FOREIGN KEY (email) REFERENCES member(email)
);

CREATE TABLE customer(
      id        nvarchar(255)  NOT  NULL ,
      gender    nvarchar(6),
      birthday  DATE ,
      PRIMARY KEY (id)
);

ALTER TABLE customer
ADD CONSTRAINT fk_id FOREIGN KEY (id)
                        REFERENCES member(email)
                        ON DELETE CASCADE;

CREATE TABLE review(
      id_customer     nvarchar (255)  ,
      id_product      int  ,
      comment         nvarchar (200),
      date            DATE ,
      star            int, /* From 1 to 5*/
      PRIMARY KEY (id_customer,id_product)
);
ALTER TABLE review
ADD CONSTRAINT fk_id_customer	FOREIGN KEY (id_customer) 
				REFERENCES customer(id) 
				ON DELETE CASCADE	;
ALTER TABLE review
ADD CONSTRAINT fk_id_product	FOREIGN KEY (id_product)
				REFERENCES productModel(id) 
				ON DELETE CASCADE	;

/*Nhà bán*/
CREATE TABLE seller(
      join_date       DATE ,
      business_reg_num nvarchar (30),
      store_name      nvarchar (40),
      type_prod       nvarchar(40),
      id_seller       nvarchar(255)  NOT NULL ,
      PRIMARY KEY (id_seller)
);
ALTER TABLE seller
ADD CONSTRAINT fk_id_seller FOREIGN KEY (id_seller)
                              REFERENCES member(email)
                              ON DELETE CASCADE;

CREATE TABLE price(
      id_seller       nvarchar(255)  NOT NULL ,
      id_productModel int  NOT NULL ,
      price           int NOT NULL ,
      start_date      DATE ,
      end_date        DATE ,
      PRIMARY KEY (id_seller,id_productModel,price,start_date,end_date)
);
ALTER TABLE price
ADD CONSTRAINT fk_id_seller_from_price	FOREIGN KEY (id_seller)
				REFERENCES seller(id_seller) 
				ON DELETE CASCADE	;

ALTER TABLE price
ADD CONSTRAINT fk_id_productModel	FOREIGN KEY (id_productModel)
				REFERENCES productModel(id) 
				ON DELETE CASCADE	;
CREATE TABLE provider(
      id_seller       nvarchar(255)   NOT  NULL ,
      id_productModel int  NOT NULL ,
      infoGuarantee   nvarchar(255),
      PRIMARY KEY (id_seller,id_productModel) ,
      FOREIGN KEY (id_seller)	REFERENCES seller(id_seller)  ,
      FOREIGN KEY (id_productModel) REFERENCES  productModel(id)
);
/*ALTER TABLE provider
ADD CONSTRAINT fk_id_seller	FOREIGN KEY (id_seller)
				REFERENCES seller(id_seller) 
				;ON DELETE CASCADE	;
ALTER TABLE provider
ADD CONSTRAINT fk_id_productModel	FOREIGN KEY (id_productModel)
				REFERENCES productModel(id) 
				;ON DELETE CASCADE	;*/

/*RECEIPT*/
CREATE TABLE orders( /*đơn hàng*/
      id              INT  NOT NULL IDENTITY(1,1) ,
      payment_method  nvarchar (255),
      destination     nvarchar (255),
      date            DATE ,
      status          nvarchar(255) default 'No payment',
      id_customer     nvarchar(255),
	giaDonHang	Int default 0 CHECK(giaDonHang <= 200000000),
      PRIMARY KEY (id),
      FOREIGN KEY (id_customer) REFERENCES customer(id)
);

CREATE TABLE Co_Don_hang_nha_ban_mau_sp(
      buy_amount      int CHECK (buy_amount > 0),
      id_order        int ,
      id_productModel int ,
      id_seller       nvarchar(255)  ,
      PRIMARY KEY (id_order,id_productModel,id_seller)
);

ALTER TABLE seller
ADD CONSTRAINT fk_type_prod FOREIGN KEY (type_prod)
            REFERENCES typeProd(type);

ALTER TABLE co_don_hang_nha_ban_mau_sp
ADD CONSTRAINT fk_dep_id_order FOREIGN KEY (id_order)
                        REFERENCES orders(id);

ALTER TABLE co_don_hang_nha_ban_mau_sp
ADD CONSTRAINT fk_dep_id_productModel FOREIGN KEY (id_productModel)
                        REFERENCES productModel(id);

ALTER TABLE co_don_hang_nha_ban_mau_sp
ADD CONSTRAINT fk_dep_id_seller FOREIGN KEY (id_seller)
                        REFERENCES seller(id_seller);
                        
CREATE TABLE receipt( /*hóa đơn*/
      id                    int NOT NULL IDENTITY(1,1),
      total_products        int,
      date                  DATE ,
      id_order              int  ,
      id_cargo              int  ,
      id_staff_incharge     int  ,
      PRIMARY KEY (id),
      FOREIGN KEY (id_order) REFERENCES orders(id) 
);
ALTER TABLE receipt
ADD CONSTRAINT fk_id_order    FOREIGN KEY (id_order) 
				REFERENCES orders(id) 
				ON DELETE CASCADE	;



CREATE TABLE product_in_receipt( /*sản phẩm trong hóa đơn*/
      id_product      int ,
      STT             int,
      price           int,
      id_receipt      int  ,
      FOREIGN KEY (id_receipt) REFERENCES receipt(id),
      PRIMARY KEY (STT, id_product)
);



/* Thùng hàng*/
CREATE TABLE cargo(
      id              int NOT NULL IDENTITY(1,1) ,
      note            nvarchar (255),
      date_packed     DATE ,
      date_receive    DATE,
      delivery_staff  int  ,
      status          nvarchar (255) default 'Not delivered',
      PRIMARY KEY (id)
);

ALTER TABLE receipt
ADD CONSTRAINT fk_id_cargo    FOREIGN KEY (id_cargo) 
				REFERENCES cargo(id) 
				ON DELETE CASCADE;


/*Nhân viên*/
CREATE TABLE staff(
      id              int  NOT NULL IDENTITY(1,1),
      phone_num       nvarchar(10),
      name            nvarchar (40),
      gender          nvarchar(6),
      birthday        DATE CHECK (DATEDIFF(YEAR,birthday,GETDATE())>=18) ,
      address         nvarchar (255),
      id_citizen      nvarchar (30),
      PRIMARY KEY (id)
);

CREATE TABLE order_staff(   /*nhân viên xử lý hóa đơn*/
      id              int  ,
      FOREIGN KEY (id) REFERENCES staff(id),
      PRIMARY KEY (id)
);

ALTER TABLE receipt
ADD CONSTRAINT fk_id_staff_incharge FOREIGN KEY (id_staff_incharge)
                        REFERENCES order_staff(id)
                        ON DELETE CASCADE;

CREATE  TABLE delivery_staff(
      id              int  ,
      vehicle         nvarchar(40),
      FOREIGN KEY (id) REFERENCES staff(id),
      PRIMARY KEY (id)
);

ALTER TABLE cargo
ADD CONSTRAINT fk_delivery_staff	FOREIGN KEY (delivery_staff)
				REFERENCES delivery_staff(id)
				ON DELETE CASCADE	;

CREATE TABLE staff_manager(
      id_staff        int  NOT NULL ,
      id_manager      int  NOT NULL,
      start_date      DATE ,
      end_date        DATE ,
      FOREIGN KEY (id_staff) REFERENCES  staff(id),
      PRIMARY KEY (id_manager)
);


CREATE TABLE storage( 
      id              int  NOT NULL IDENTITY(1,1),
      name            nvarchar(40),
      address         nvarchar(255), 
      producerID nvarchar(255)   NOT NULL,
      PRIMARY KEY (id) 
);
ALTER TABLE storage
ADD CONSTRAINT fk_producerID	FOREIGN KEY (producerID)
				REFERENCES seller(id_seller)
				ON DELETE CASCADE	;

CREATE TABLE product(
      id_product      int   NOT NULL  ,
      STT             int  NOT NULL IDENTITY(1,1),
      idStorage       int  NOT NULL ,
      stock_in_date   DATE not NULL ,
      stock_out_date  DATE default NULL,      
      FOREIGN KEY(idStorage) REFERENCES storage(id),
      FOREIGN KEY(id_product) REFERENCES productModel(id),
      PRIMARY KEY (id_product, STT)
       
);


ALTER TABLE product_in_receipt
ADD CONSTRAINT fk1_id_product_STT FOREIGN KEY (id_product, STT)
				REFERENCES product(id_product, STT) 
				ON DELETE NO ACTION	;

/*DEPARTMENT*/
--DROP TABLE IF EXISTS department
CREATE TABLE  department(
      id              int  NOT NULL IDENTITY(1,1) ,
      name            nvarchar (255),
      description     nvarchar (255), /*mô tả hoạt động*/
      PRIMARY KEY (id)
);

CREATE TABLE department_manager(
      id_staff        int  ,
      id_department   int  ,
      start_date      DATE ,
      end_date  DATE ,
      PRIMARY KEY (id_staff,id_department,start_date,end_date)
);

ALTER TABLE department_manager
ADD CONSTRAINT fk_id_department	FOREIGN KEY (id_department)
				REFERENCES department(id)
				ON DELETE CASCADE	;

ALTER TABLE department_manager
ADD CONSTRAINT fk_id_staff	FOREIGN KEY (id_staff)
				REFERENCES staff(id)
				ON DELETE CASCADE	;

CREATE TABLE department_place(
      id_department   int  ,
      location        nvarchar(255),
      PRIMARY KEY (id_department,location),
      FOREIGN KEY (id_department) REFERENCES department(id)
);

CREATE TABLE current_working_department(
      id_staff        int  ,
      id_department   int  ,
      start_date      DATE ,
      end_date        DATE ,
      PRIMARY KEY (id_staff,id_department),
      FOREIGN KEY (id_staff) REFERENCES staff(id) ,
      FOREIGN KEY (id_department) REFERENCES department(id)
);




