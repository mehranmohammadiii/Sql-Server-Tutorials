--T_SQL
--3	--Pivot ,OnPivot

--تعداد محصولات هر گروه
--کد ساخت دیتابس dbshop__DjiKala در کوعری های قبلی هست
select *
from (
	select pg.ProductGropTitel,p.ProductID
	from ProductGroups pg inner join Products p
	on pg.ProductGroupId=p.ProductGroupId

)T1
pivot(
	count(productid)
	for ProductGropTitel in (
		[مواد غذایی],
		[مواد شوینده],
		[پوشاک],
		[تنقلات]
	)

) as pv
-------------
--تعریف متغییر
declare @x int
set @x=200
print(@x)

declare @y int =100
print(@y)

declare @fname nvarchar(20)
set @fname=N'مهران'
print(@fname)

declare @SqlQuery nvarchar(max)
set @SqlQuery='select * from products'
--exec or execute
exec sp_executesql @SqlQuery
-----------------------------
declare @col nvarchar(max)=''
select @col=QUOTENAME(ProductGropTitel)+','+@col     --[]
from ProductGroups
print(@col)
set @col=left(@col,len(@col)-1)
print(@col)
declare @sql1 nvarchar(max)=	'
				
				select *
				from (
					select pg.ProductGropTitel,p.ProductID
					from ProductGroups pg inner join Products p
					on pg.ProductGroupId=p.ProductGroupId
				)T1
				pivot(
					count(productid)
					for ProductGropTitel in ('+@col+')
				) as pv
							'
exec sp_executesql @sql1
--حالا اگر بعدا توی دیتابیس ستون دیگری اضافه کنیم بصورت پویا این کد رو که اجرا کنیم اون ستون رو هم میاره
-------
--OnPivot        تبدیل ستون ها به سطر
use master
go
Create Database dbUni
GO
Use dbUni
GO
Create Table Students(
	StudentId int Primary key identity(1,1),
	Fname NvarChar(20),
	Lname NvarChar(20),
	Riyazi Decimal(4,2),
	Fizik Decimal(4,2),
	Shimi Decimal(4,2),
	Arabi Decimal(4,2),
	Farsi Decimal(4,2)
)

Insert Into Students([Fname], [Lname], [Riyazi], [Fizik], [Shimi], [Arabi], [Farsi])
			Values(N'مهدی',N'اکبری',12.34,16.50,17,9,14.75),
				  (N'احمد',N'توکلی',15.34,16.50,14,9,18.75),
				  (N'محمد',N'قاسمی',17.34,16.50,17,9,11.75),
				  (N'رضا',N'معصومی',8.34,19.50,13,9,14.75)


Select *
From Students
--تبدیل به کارنامه
select [Fname],[Lname],coursec,nomre
from Students
unpivot(
		nomre for coursec in (
			  [Riyazi],[Fizik],[Shimi],[Arabi],[Farsi]
						)
)as unp