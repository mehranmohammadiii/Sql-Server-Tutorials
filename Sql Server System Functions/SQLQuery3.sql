--Sql Server System Functions/Advanced Functions
--cast   تبدیل نوع های داده
--کد ساخت دیتابیس dbshop__DjiKala در کوِئری های قبلی هست
select cast('1' as int)
select 100+cast('1' as int)
select cast(5.512317 as decimal(4,2))
select [Name]+cast(UserId as nvarchar)
from Users
select [ProductID],[ProductTitel],cast([RegisterUserID] as nvarchar)+N'کاربر شماره '
from Products
select try_cast('23' as int)
select try_cast('ali' as int)
select GETDATE()
select TRY_CAST(GETDATE() as date)
select TRY_CAST(GETDATE() as time)
----------------------------
--convert
select convert(varchar(20),230)
select convert(datetime,'2000/01/02')
select convert(nvarchar(20),GETDATE())
select TRY_CONVERT(int,'ali')
select TRY_CONVERT(varchar(2),'ali')

----------------------------
--try_parse  تبدیل رشته به تاریخ و  رشته به عدد
select TRY_PARSE('13' as int)
select TRY_PARSE('2000-01-04' as date)
---------------------------
--is null  اولین مقدار غیر نال
select ISNULL(100,20)
select ISNULL(null,20)
use dbshop__DjiKala
select ProductGroupId,ProductGropTitel,isnull(ParentgGroupID,2000)
from ProductGroups
---------------------------
--isnumeric
select isnumeric(200)
select isnumeric('200')
select isnumeric('ali')
select isnumeric(20.54)
select isnumeric('$10')
----------------------------
--iif
select iif(5>13,1,0)

select ProductGroupId,
	   sum(Price) [ مجموع قیمت هر گروه],
	   iif(sum(Price)<50000,1,0) [ارزان ها],
	   iif(sum(Price)>50000 and sum(Price)<100000,1,0) [متوسط ها],
	   iif(sum(Price)>100000,1,0) [گران ها]
from products
group by ProductGroupId
-----------------------------
--choose
select choose(2,'ali','amir','reza','mehran')

select ProductID,ProductTitel,ProductGroupId,Price,choose(ProductGroupId,N'خوردنی',N'خطرناک',N'پوشیدنی',N'')
from Products

select *
from ProductGroups
-----------------------------
declare @col nvarchar(max)=''
select @col+='N'+''''+ProductGropTitel+''''+','
from ProductGroups
order by ProductGroupId
set @col=LEFT(@col,len(@col)-1)
print(@col)

declare @sql nvarchar(max)='
				select ProductID,ProductTitel,ProductGroupId,Price,choose(ProductGroupId,'+@col+') from Products'
exec sp_executesql @sql