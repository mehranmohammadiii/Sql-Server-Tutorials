--Search Operators 
--in  exists  any  all

use master
go 
create database dbshop__DjiKala
go 
use dbshop__DjiKala
go

create table Roles(														--جدول نقش ها
			 RoleId tinyint primary key not null,						-- کد نقش
			 RoleTitel nvarchar(20) not null							-- عنوان نقش
)
----------------
go

insert into Roles
			values(1,N'مدیر'),
				  (2,N'کارمند')
----------------
go

create table Users(														--جدول کاربران							
			 UserId int primary key identity(1,1) not null,				-- کد کاربر
			 [Name] nvarchar(20) not null,								--نام 
			 Family nvarchar(20) not null,								-- نام خانوداگی 
			 MobileNumber char(11) not null,							-- شماره موبایل
			 [Password] nchar(15) not null,								--پسورد
			 RegisterDate datetime null,								--تاریخ ثبت
			 RoleId tinyint not null,									--کد نقش
			 IsActive bit null default(1),							    --فعال/غیرفعال
			 foreign key(RoleId) references Roles (RoleId)
)
----------------
go

insert into Users([Name], [Family], [MobileNumber], [Password], [RegisterDate], [RoleId])
			values(N'مهران',N'محمدی','09208199895','32201513m',getdate(),1),
			(N'مرتضی',N'قیاسی','09158199856','123456',getdate(),2),
			(N'علی',N'مرکی','09108199547','257846',getdate(),2),
			(N'امیر رضا',N'حسینی','09218199620','amir12345',getdate(),2),
			(N'سجاد',N'لیلایی','09208199980','sj4545',getdate(),2)
---------------
go

create table ProductGroups(													--جدول گروه محصولات
			 ProductGroupId	int primary key not null,						-- کد گروه
			 ProductGropTitel nvarchar(30) not null,						--عنوان گروه
			 ParentgGroupID int null,										--کلید فرزند
			 foreign key (ParentgGroupID) references ProductGroups(ProductGroupId)
)
----------------
go

insert into ProductGroups values (1,N'مواد غذایی',null),
								 (2,N'مواد شوینده',null),
								 (3,N' پوشاک',null),
								 (4,N'لوازم خانگی',null),
								 (5,N'کالای دیجیتال',null),
								 (6,N'لوازم ورزشی',null),
								 (7,N' لبنیات',1),
								 (8,N'لباس مردانه',3),
								 (9,N'تلوزیون ',4),
								 (10,N'دوربین ',5),
								 (11,N'موبایل ',5),
								 (12,N'تنقلات ',1),
								 (13,N'پروتئین ',1),
								 (14,N'نوشیدنی ',1),
								 (15,N'یخچال ',4),
								 (16,N'اجاق گاز',4)
---------------	
go

create table Products(															--جدول محصولات
			 ProductID int identity(1,1) primary key not null,					--کدمحصول
			 ProductTitel nvarchar(30) not null,								--عنوان محصول
			 ProductGroupId	int null,											--کد گروه محصول
			 Price int null,													--قیمت محصول
			 RegisterDate datetime default(getdate()) null,						--تاریخ ثبت
			 RegisterUserID int null,								        --کد کاربر ثبت کننده محصول
			 foreign key(ProductGroupId) references ProductGroups(ProductGroupId),
			 foreign key(RegisterUserID) references Users(UserId)
)
--------------
go

insert into Products([ProductTitel], [ProductGroupId], [Price],[RegisterUserID]) 
			values(N'چیپس',12,5000,2),
				  (N'پفک',12,7000,3),
				  (N'پفک',13,7000,3),
				  (N'نوشابه',14,8000,3),
				  (N'سفید کننده',2,25000,4),
				  (N'جرمگیر',2,12000,2),
				  (N'مایع ظرفشویی',2,16000,4),
				  (N'جوراب',8,5000,3),
				  (N'تیشرت',8,50000,3),
				  (N'توپ فوتبال',6,100000,2),
				  (N'یخچال سامسونگ',15,50000000,3),
				  (N'کلاه',8,45000,4),
				  (N'دوربین کانون',10,1000000,4),
				  (N'شال',8,60000,4),
				  (N'موبایل سامسونگ',11,1500000,4),
				  (N'تلوزیون سونی',9,2200000,4),
				  (N'اجاق گاز سینجر',16,500000,3),
				  (N'ماکرو فر ال جی',16,500000,2),
				  (N'تخمه آفتابگردان',null,6000,3)

select *
from ProductGroups

select *
from Products

select *
from Users

select [Price]
from Products
where price>any(														--حداقل از یکی از این مجموعه بیشتر باشد
			select price
			from products
)

select [Price]
from Products
where price<any(														--حداقل از یکی از این مجموعه کمتر باشد
			select price
			from products
)

select [ProductID],[ProductTitel],[Price]
from Products
where price=any(													--حداقل با یکی  از این مجموعه مساوی باشد
			select price
			from products
			where price>100000
)

select [ProductID],[ProductTitel],[Price]
from Products
where price>all(														--همشون از این مجموعه بیشتر باشد
			select price
			from products
)

select [ProductID],[ProductTitel],[Price]
from Products
where price>=all(														--همشون از این مجموعه بیشتر باشد
			select price								             	-- اونی که معدلش از همه بیشتره			
			from products												--اونی که همه محصولات منو خریده
)																		--اونی که توی همه روز ها خرید داشته

select * 
from products
where exists(												--اگر حداقل یک رکورد وجود داشته باشد اجرا میشود
	  select *
	  from ProductGroups
	  where ProductGropTitel=N'مواد شوینده'
)

select * 
from products
where exists(
	  select *
	  from ProductGroups
	  where ProductGropTitel=N'لوازم ساختمانی'
)

select * 
from products
where not exists(
	  select *
	  from ProductGroups
	  where ProductGropTitel=N'لوازم ساختمانی'
)

select *
from products
where exists(
	  select *
	  from ProductGroups
	  where ProductGroups.ProductGroupId=products.ProductGroupId 
)

select *
from products as T1
where exists(
	  select *
	  from ProductGroups as T2
	  where T2.ProductGroupId=T1.ProductGroupId 
)
use master
go
create database dbtest2
go
use dbtest2
go

create table customer(
			 customerid int identity(1,1) primary key not null,
			 fname nvarchar(20) not null
)
go
insert into customer(fname) values(N'مهران'),(N'سارا'),(N'اکبر'),(N'حسین'),(N'لیلا')
go
create table [order](
			 orderid int identity(1,1) primary key not null,
			 customerid int null,
			 price int not null,
			 foreign key(customerid) references customer(customerid)
)
go
insert into [order](customerid,price) values (2,5000),(1,2000),(5,3500),(null,6000),(2,1500)

select *
from customer

select *
from [order]

																	--هدف مشتری هایی که از من خرید نکردند
																	--مشتری 3 و 4 از من خرید نکردند
select *
from customer as t1
where not exists (
	  select *
	  from [order] as t2
	  where t1.customerid=t2.customerid
)

select *
from customer
where customerid not in(										--چون فیلد نال یا هیچی دارد جواب نمیدهد
	  select customerid											--اگر نال نمیداشت اوکی بود
	  from [order]
)