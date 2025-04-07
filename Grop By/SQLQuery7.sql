--grop by >>>	having		grouping sets		rollup		cube		--گروه بندی داده ها
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

select sum(price)
from products
select *
from Products

select ProductGroupId,sum(price) as[جمع قیمت های هر گروه],count(ProductID) as [تعداد کالاهای داخل گروه]
from products
group by ProductGroupId 
--فیلد هایی که جلوی سلکت قرار میگیرن،یا باید اون ها هم جلوی گروپ بای قرار بگیرند یا درون توابع تجمعی باشند

select ProductGroupId,sum(price) as[جمع قیمت های هر گروه],count(price) as [تعداد کالاهای داخل گروه],RegisterUserID
from products
group by ProductGroupId,RegisterUserID
order by ProductGroupId

select ProductGroupId,sum(price) as[جمع قیمت های هر گروه],count(price) as [تعداد کالاهای داخل گروه],RegisterUserID,ProductTitel
from products
group by ProductGroupId,RegisterUserID,ProductTitel
order by ProductGroupId

select ProductGroupId,ProductTitel,RegisterUserID
from products
group by ProductGroupId,RegisterUserID,ProductTitel
order by ProductGroupId

								--کد گروه کالاهایی رو بیار که جمع قیمت هاشون بیشتر از 100000 تومان باشد
select ProductGroupId,sum(price) as[جمع قیمت های هر گروه],count(price) as [تعداد کالاهای داخل گروه]
from products
group by ProductGroupId
having sum(price)>100000

 --کد گروه کالاهایی رو بیارید که تعداد تولیدی انها بیش از 2 باشد
select ProductGroupId,sum(price) as[جمع قیمت های هر گروه],count(price) as [تعداد کالاهای داخل گروه]
from products
group by ProductGroupId
having count(ProductID)>2
 --اگر قرار بود روی توابع تجمعی شرط بزاریم نباید از ور استفاده کنیم باید از هوینگ استفاده کنیم و بعد از گروپ بای

select *
from ProductGroups T1 inner join (
					select ProductGroupId,count(ProductID) as [تعداد کالاهای داخل گروه]
					from products
					group by ProductGroupId
					having count(ProductID)>2
					)T2
ON T1.ProductGroupId=T2.ProductGroupId inner join Products T3
on T2.ProductGroupId=T3.ProductGroupId

--قیمت کالا کمتر از 100000 تومان باشد و تعداد کالای درون گروه بیشتر از 1 باشد

select ProductGroupId, count(ProductID)
from Products
where Price<100000
group by ProductGroupId
having count(ProductID)>1

select *
from Products T1 inner join (
				 select ProductGroupId, count(ProductID) as [تعداد کالا های داخل گروه]
				 from Products
				 where Price<100000
				 group by ProductGroupId
				 having count(ProductID)>1
						)T2
on T1.ProductGroupId=T2.ProductGroupId
order by T1.ProductGroupId

select *
from Products
 --کدام کاربر ها در کدام گروه ها کالا ثبت کردند و تعداد کالاهایی که درج کردند
 
select RegisterUserID,count(ProductID) as [تعداد کالای درج شده توسط کارمند]
from products
group by RegisterUserID

select ProductGroupId, count(ProductID) as [تعداد کالا های هر گروه]
from products
group by ProductGroupId

select RegisterUserID as [کد کاربر ثبت کننده],
	   ProductGroupId as [کد گروه],
	   count(RegisterUserID) as [تعداد کالاهای درج شده توسط کارمند]
from Products
group by RegisterUserID,ProductGroupId
order by RegisterUserID

select *
from Products

select *
from Users
------------------------
select RegisterUserID,count(RegisterUserID) as [تعداد کالای درج شده توسط کارمند]
from products
group by rollup(RegisterUserID)

select ProductGroupid,sum(price) as [جمع قیمت های های گروه],count(ProductGroupid) as [تعداد کالا های داخل گروه]
from Products
group by ProductGroupid

select ProductGroupid,sum(price) as [جمع قیمت های های گروه],count(ProductGroupid) as [تعداد کالا های داخل گروه]
from Products
group by rollup(ProductGroupid)

select RegisterUserID as [کد کاربر ثبت کننده],
	   ProductGroupId as [کد گروه],
	   count(RegisterUserID) as [تعداد کالاهای درج شده توسط کارمند]
from Products
group by grouping sets(
				  (ProductGroupId),
				  (RegisterUserID),
				  (RegisterUserID,ProductGroupId)
)