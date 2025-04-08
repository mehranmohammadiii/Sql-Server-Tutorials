--Case , NullIF , Coalesce

--Case >> Select Where Having Update(Set)
 --دو مدل تعریف کیس داریم

select *
from Users

update Users
set IsActive=0
where Family in (N'محمدی',N'حسینی',N'لیلایی')

select [Name] [نام],
	   Family [نام خانوادگی],
	   case IsActive
	   when 1 then N'فعال'
	   when 0 then N'غیرفعال'
	   end 
	   [وضعیت کاربر]
from Users

--تعداد کاربران فعال و غیر فعال
select sum(
			case when IsActive=1
			then 1
			else 0
			end
			) [تعداد کاربران فعال],
	   sum(
			case when IsActive=0
			then 1
			else 0
			end
			) [تعداد کاربران غیر فعال],
	   count(UserId) [ تعداد کل کاربران]
from Users
--------------
select pg.ProductGroupId [کد گروه کالا],
	   sum(price) [مجموع قیمت هر گروه],
	   count(ProductID),
	   case when sum(price)>0 and sum(price)<10000
	   then N'ارزان'
	   when sum(price)>10000 and sum(price)<100000
	   then N'متوسط'
	   when sum(price)>100000 and sum(price)<1000000
	   then N'گران'
	   when sum(price)>1000000
	   then N'خیلی گران'
	   else N'در بازه قیمتی وجود ندارد'
	   end 
	   [ارزیابی قیمت گروه ها]
from ProductGroups pg inner join Products p
on pg.ProductGroupId=p.ProductGroupId
where pg.ProductGroupId>2
group by pg.ProductGroupId

select pg.ProductGroupId [کد گروه کالا],
	   sum(price) [مجموع قیمت هر گروه],
	    case sum(price)
		when 10000 then N'گران'
	    when 53000 then N'متوسط'						--این روش کارایی ندارد
		when 100000 then N'گران'
		end
from ProductGroups pg inner join Products p
on pg.ProductGroupId=p.ProductGroupId
group by pg.ProductGroupId

update Users
set [Name]= case [Name]
			  when N'مهران' then 'mehran'
			  when N'علی' then 'ali'
			  when N'سجاد' then 'sajad'
			  end
where [Name] in (N'مهران',N'علی',N'سجاد')
select *
from Users

select *
from products
where Price= case when ProductID=1 then 5000 end

select ProductGroupid,max(price)
from Products
group by ProductGroupid
having max(Price)= case 
						when ProductGroupId=6 then 100000
						when ProductGroupId=2 then 25000
						when ProductGroupId=16 then 500000
					end
-------------------------
--coalesce   >>>		تشخیص اولین مقدار غیر نال بودن

select coalesce(12,45,12,7,95,16)
select coalesce('ali','mehran','amir','armin')
select coalesce(null,null,null,null,12,45,12,7,95,16)
select ProductGroupid,ProductGropTitel,coalesce(ParentgGroupID,100)
from ProductGroups
----------------------------------------
use master 
Create Database dbTest8
GO
Use dbTest8
GO
CREATE TABLE SalaryRate (
    SalaryId INT PRIMARY KEY,
    HourlyRate decimal,
    WeeklyRate decimal,
    MonthlyRate decimal
);
GO
INSERT INTO SalaryRate(SalaryId,HourlyRate,WeeklyRate,MonthlyRate)
			  VALUES(1,2000, NULL,NULL),
					(2,3000, NULL,NULL),
					(3,NULL, 40000,NULL),
					(4,NULL, NULL,600000),
					(5,NULL, NULL,700000)

Select *
From SalaryRate

Select SalaryId,coalesce(HourlyRate,WeeklyRate,MonthlyRate)
From SalaryRate

Select SalaryId,coalesce(HourlyRate*60,WeeklyRate*4,MonthlyRate)
From SalaryRate
-------------------------------
--nullif >>     برابری و نابرابری

select nullif(23,23)
select nullif(23,67)   --در صورت نابرابری سمت چپی رو برمیگردونه

use dbshop__DjiKala
select *
from Users

update Users
set Password=null
where UserId=1
update Users
set Password=''
where UserId=4

select *
from Users
where nullif(Password,'') is null


declare @a int,@b int
set @a=300
set @b=200
select case 
			when @a=@b 
			then null
			else @a
		end