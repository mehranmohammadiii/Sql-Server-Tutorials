--تعریف دادهها		2	--data definition

-- Rename a Table, Drop Table, Alter Table(تغییرات در سایز و نوع داده ستون ها),Truncate Table(ریست کردن جدول)
--sequence, Select Into, Temporary Tables

Use master
GO
Drop database if Exists dbTest5
GO
Create Database dbTest5
GO
Use dbTest5
GO
Create Table Roles(
	RoleId int Primary key ,
	RoleTitle Nvarchar(30) Not Null
)
GO

Create Table People(
	PersonId int Primary key Identity,
	FName Nvarchar(20) Not Null,
	LName Nvarchar(20) Not Null,
	MobileNumber varchar(15) Null,
	RoleId int Null,
	Foreign Key(RoleId) References Roles(RoleId)
)
GO
Insert INTO Roles Values(1,N'مدیر'),
						(2,N'کاربر ویژه'),
						(3,N'کاربر عادی'),
						(4,N'مشتری'),
						(5,N'فروشنده')



Insert INTO People(FName,LName,MobileNumber,RoleId) 
            Values  (N'علی',N'اکبری','091111',1),
				 	(N'محمد',N'برزگر','092222',2),
				 	(N'رضا',N'یوسفی',null,2),
				 	(N'سعید',N'سلیمانی','098122333',NUll),
				 	(N'مهران',N'صادقی',NULL,2)
drop table if exists People
drop table Roles,people--eror
drop table People,Roles

select *
from people
select *
from Roles

delete 
from people
--دوباره درج میکنم
select *
from people		-- حالا این دفعه آیدنتیتی از شماره 6 شروع شد و از اول و شماره یک شروع نشد

truncate table people --ریست و تنظیمات کارخانه
-- دوباره درج میکنیم
select *
from people	-- درست شد این بار از یک شروع شد
-- وقتی 1000 رکورددیلیت میشوند 1000 بار کلمه دیلیت در لاگ فایل نوشته میشه ولی با ریست کردن کمتر نوشته میشه
exec sp_rename 'people','people2'

alter table people alter column MobileNumber int --از روش دیگه هم میشه،روش دستی از دیزاین
alter table people alter column MobileNumber char(11)
alter table people alter column MobileNumber char(11) not null --خطا
update people
set MobileNumber=''
where MobileNumber is null
alter table people alter column MobileNumber char(11) not null
---------------------------------------------
 --ادامه تعریف داده ها
--sequence(توالی شمار)
--فرقش با آیدنتیتی اینه که آیدنتیتی قابلیت ریست کردن ندارن اگه بخان ریست بشن امکان داره داده ها از بین بره 
 --یا آیدنتیتی ها فقط برای یک جدول خوبن یعنی نمیتونیم یه آیدنتیتی داشته باشیم برای جدول 1 و2و به هم ربط بدیمشون
Use master
GO
Drop database if Exists dbTest7
GO
Create Database dbTest7
GO
Use dbTest7
GO


CREATE TABLE SpecialCustomerOrders(                      --جدول سفارش مشتریان ویژه
    OrderId INT PRIMARY KEY Identity,                    --شماره سفارش
	ReceiptId int NOT NULL,                              --شماره رسید
    SpecialCustomerId int NOT NULL,                      --شماره مشتری ویژه
	RegisterDate date NOT NULL						     --تاریخ درج سفارش
);

GO
CREATE TABLE NewCustomerOrders(                          --جدول سفارش مشتریان جدید
    OrderId INT PRIMARY KEY Identity,                    --شماره سفارش
	ReceiptId int NOT NULL,                              --شماره رسید
    NewCustomerId int NOT NULL,                           --شماره مشتری جدید
	RegisterDate date NOT NULL						     --تاریخ درج سفارش
);

create sequence iteme_counter as int
start with 100 increment by 5

select next value for iteme_counter

create sequence iteme_Orders as int
start with 1 increment by 1

insert into SpecialCustomerOrders([ReceiptId], [SpecialCustomerId], [RegisterDate])
								  values(next value for iteme_Orders,1000,getdate()),
										(next value for iteme_Orders,1050,getdate()),
										(next value for iteme_Orders,1075,getdate())
insert into NewCustomerOrders([ReceiptId], [NewCustomerId], [RegisterDate])
								  values(next value for iteme_Orders,2000,getdate()),
										(next value for iteme_Orders,2050,getdate()),
										(next value for iteme_Orders,2075,getdate())
select *
from SpecialCustomerOrders
select *
from NewCustomerOrders
--------------------------------
 --ادامه تعریف داده ها
 --Select Into, Temporary Tables

Use master
GO
Drop database if Exists dbTest5
GO
Create Database dbTest5
GO
Use dbTest5
GO
Create Table Roles(
	RoleId int Primary key ,
	RoleTitle Nvarchar(30) Not Null
)
GO

Create Table People(
	PersonId int Primary key Identity,
	FName Nvarchar(20) Not Null,
	LName Nvarchar(20) Not Null,
	MobileNumber varchar(15) Null,
	RoleId int Null,
	Foreign Key(RoleId) References Roles(RoleId)
)
GO
Insert INTO Roles Values(1,N'مدیر'),
						(2,N'کاربر ویژه'),
						(3,N'کاربر عادی'),
						(4,N'مشتری'),
						(5,N'فروشنده')

Insert INTO People(FName,LName,MobileNumber,RoleId) 
            Values  (N'علی',N'اکبری','091111',1),
				 	(N'محمد',N'برزگر','092222',2),
				 	(N'رضا',N'یوسفی',null,2),
				 	(N'سعید',N'سلیمانی','098122333',NUll),
				 	(N'مهران',N'صادقی',NULL,2)

select *
from people
select *
from Roles

select *
into PeopleBackUp			--یک جدول با همین نام درست میشه و اطلاعات درونش ریخته میشه
from people

select *
from PeopleBackUp

select FName,LName,MobileNumber
into TableTest
from people
where MobileNumber is null

select *
from TableTest
--بهتره بک آپ داخل یک دیتابیس دیگه باشه
create database dbTest5BackUp
select *
into dbTest5BackUp.dbo.TableBackUp
from people
--الان ارتباط ها بک آپ گیری نشدند فقط یک بک آپ گیری خیلی نرمال و ساده بود
------------Temporary Tables
--کار با دیتابیس های خود سیستم
--tempdb ذخیره موقت اطلاعات، با بستن برنامه یا بستن کوعری اطلاعات پاک میشوند
create table #test_table(
		id int primary key not null,
		fname nvarchar(20) not null,
		lname nvarchar(20) not null,
)