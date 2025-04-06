--sub query	 <--سلکت درون سلکت
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


select [ProductID], [ProductTitel],  [Price]							 --سلکت جلوی سلکت		
from products
where price > 100000

select avg(price)
from products

select [ProductID],[ProductTitel],[Price],(select avg(price) from products) as [میانگین قیمت همه کالاها]
from products
where price > 100000

select [ProductID],[ProductTitel],[Price],(select avg(price) from products)
from products
where price > 100000

select [ProductID],
	   [ProductTitel],
       [Price],
       (select avg(price) from products)
from products
where price > 100000
--------------------------												--سلکت جلوی فرام
select [name],family
from (
	   select *
	   from Users
	   where RoleId=2
)T1


select [ProductTitel]
from (
		select [ProductTitel],[ProductGroupId],[Price],[RegisterUserID]
		from (
				select [ProductTitel],[ProductGroupId],[Price],[RegisterUserID]
				from products
				where price >50000
		)T2
		where RegisterUserID=3
)T1
where ProductGroupId=15
--------------------															--سلکت جلوی ور

select *
from Products
where ProductGroupId=(
				select ProductGroupId
				from ProductGroups
				where ProductGropTitel=N'مواد شوینده'
)
select *
from Products
where ProductGroupId in (
				select ProductGroupId
				from ProductGroups
				where ProductGropTitel=N'مواد شوینده' or ProductGropTitel=N'تنقلات' or ProductGropTitel=N'یخچال' 
)

select *
from Products
where ProductGroupId not in (
				select ProductGroupId
				from ProductGroups
				where ProductGropTitel=N'مواد شوینده' or ProductGropTitel=N'تنقلات' or ProductGropTitel=N'یخچال' 
)