--insert																	--تغییر داده ها و ساختار جدول
--												1	--modifying data		--تغییر در داده های جدول
--کد ساخت دیتابیس dbshop__DjiKala در کوِئری های قبلی هست
select ProductID
from Products

set IDENTITY_INSERT products on
insert into products(ProductID,ProductTitel)
					values(60,N'گروه تست')
set IDENTITY_INSERT products off

use dbshop__DjiKala
select [Name],[Family]
from dbshop.dbo.Users

insert into dbshop.dbo.Users ([Name],[Family])			--اینزرت از یک جدول دیگه توی یک جدول با دیتابیس دیگه
							 (select [Name],[Family]
							  from Users 
							 )

insert top(2) into dbshop.dbo.Users ([Name],[Family])
							 (select [Name],[Family]
							  from Users 
							 )
---------------------------------------------
--update

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

GO					
Select *
From Roles
Select *
From People

update People
set MobileNumber='091500000'
where MobileNumber is null

update People
set FName=N'علی'+FName
where PersonId=3

Select *
From Roles
Select *
From People
select *
from Roles R inner join People P
on R.RoleId=P.RoleId
where RoleTitle=N'کاربر ویژه'

update People
set MobileNumber='0912'
from Roles R inner join People P
on R.RoleId=P.RoleId
where RoleTitle=N'کاربر ویژه'
-----------------------------------------------
--delete

select *
from Roles

select *
from People

delete 
from People
where FName=N'مهران'

delete top(3)
from People
-----------------------------------------

--merge

Use master
GO
Drop Database If Exists dbTest6
GO
Create database dbTest6
Go 
Use dbTest6
Go

CREATE TABLE Person1 (
    PersonId INT PRIMARY KEY NOT NULL,
    FName VARCHAR(50) NOT NULL,
    Age tinyint
);

INSERT INTO Person1 Values(1,'Ali',24),
						  (2,'Reza',35),
						  (3,'Sara',18),
						  (4,'Mehdi',27)

CREATE TABLE Person2 (
    PersonId INT PRIMARY KEY NOT NULL,
    FName VARCHAR(50) NOT NULL,
    Age tinyint
);

INSERT INTO Person2 Values(1,'Mohammad',24),
						  (2,'Reza',35),
						  (4,'Sadegh',40),
						  (5,'Kamran',24),
						  (7,'Mehdi',27)
GO
Select *
From Person1

GO
Select *
From Person2
									--target=جدول هدف
									--source=جدول منبع_سمت سرور
									--اگر رکورد ها برابر باشن آپدیت میکنیم از سورس به تارگت
									--اگر توی هدف مثلا 100 رکورد داریم و توی سرور 200 رکورد باید اینزرت کنیم
									--اگر یه تعداد رکورد توی هدف وجود دارد که توی منبع نیست باید دیلیت کنیم 
Select *
From Person1
Select *
From Person2

merge person1 P1 using person2 P2	--هدف برای ما پرسن 1 هست و منبع پرسن 2
on P1.PersonId=P2.PersonId
when matched then update set p1.FName=p2.FName, p1.age=p2.age
when not matched by target then insert([PersonId], [FName], [Age]) values(p2.PersonId,p2.FName,p2.age)
when not matched by source then delete;

Select *
From Person1
Select *
From Person2