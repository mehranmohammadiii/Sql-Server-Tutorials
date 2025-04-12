--Sql Server Window Functions
--row_number
--کد ساخت دیتابیس dbshop__DjiKala در کوِئری های قبلی هست
select *
from products

select row_number() over(order by productid ) [row number],*
from Products
select row_number() over(order by ProductGroupId) [row number],*
from Products
select row_number() over(partition by ProductGroupId order by ProductGroupId ) [row number],*
from Products
select row_number() over(partition by ProductGroupId order by ProductId ) [row number],*
from Products
select row_number() over(partition by ProductGroupId order by price desc) [row number],*
from Products
--کالاهایی که در هر گروه بیشترین قیمت را دارند؟؟
select *
from (
	select row_number() over(partition by ProductGroupId order by price desc) [row number],*
	from Products
)T1
where T1.[row number]=1

Create database dbTest9
GO
Use dbTest9
GO
CREATE TABLE Students
(
	Id INT IDENTITY PRIMARY KEY,
	Fname NVARCHAR(100),
	LName NVARCHAR(100),
	Age VARCHAR(10),
	ShNumber int,
)
GO
TRUNCATE Table  Students
Insert INTO Students(Fname,LName,Age,ShNumber)
		   Values(N'مهدی',N'عباسی',23,104),				 
				 (N'رضا',N'توکلی',23,100),				 
				 (N'احمد',N'اکبری',23,100),				 
				 (N'مهدی',N'عباسی',23,100),				 
				 (N'رضا',N'توکلی',23,110),			 
				 (N'مهدی',N'عباسی',23,105),				 
				 (N'رضا',N'توکلی',23,90),
				 (N'مهدی',N'عباسی',23,120)	
				 

Select *
From Students

--حذف رکورد های تکراری؟؟؟
select ROW_NUMBER() over(partition by [Fname],[LName],[Age] order by [Id]),*
from Students;

with cte_1 As (
	
	select ROW_NUMBER() over(partition by [Fname],[LName],[Age] order by [Id]) [ROW NUMBER],*
	from Students
)
delete from cte_1 where [ROW NUMBER]!=1

Select *
From Students
------------------------
select rank() over(order by productid) [Rank],*
from products

select rank() over(order by productgroupid) [Rank],*
from products
select row_number() over(order by productgroupid) [Rank],*
from products

select rank() over(partition by productgroupid order by productgroupid) [Rank],*
from products
select rank() over(partition by productgroupid order by productid) [Rank],*
from products

select dense_rank() over(order by productgroupid) [Rank],*
from products

select dense_rank() over(partition by productgroupid order by productid) [Rank],*
from products
----------------------------
--first_value       اولین رکورد یک پارتیشن رو برمیگردونه

Select FIRST_VALUE(ShNumber) over(partition by [Fname],[LName],[Age] order by [ShNumber]) [FIRST_VALUE] ,*
From Students
--حذف رکورد های تکراری

with cte_sel
as 
(
Select FIRST_VALUE(ShNumber) over(partition by [Fname],[LName],[Age] order by [ShNumber]) [FIRST_VALUE] ,*
From Students
)
delete
from cte_sel
where [FIRST_VALUE]!=[ShNumber]

select *
from Students
-----------------------
Select last_VALUE(ShNumber) over(partition by [Fname],[LName],[Age] order by [ShNumber]) [last_VALUE] ,*
From Students

Select *,last_VALUE(ShNumber) over(
								partition by [Fname],[LName],[Age] 
								order by [ShNumber]
								Range between unbounded preceding And unbounded following
								) [ اخرین مقدار]
From Students
-----------------------
--cume_dist   موقعیت داده ها 
--percent_rank
select *, CUME_DIST() over(order by ShNumber) [CUME_DIST]
from Students

select *, percent_rank() over(order by ShNumber) [CUME_DIST]		-- از صفر فقط شروع میشود
from Students

select *, CUME_DIST() over(partition by [Fname],[LName],[Age] order by ShNumber) [CUME_DIST]
from Students

select *, percent_rank() over(partition by [Fname],[LName],[Age] order by ShNumber) [CUME_DIST]
from Students
-------------------------
 --lead  
select *, lead(ShNumber,1) over(order by ShNumber) [shnum]
from Students

select *, lead(ShNumber,3) over(order by ShNumber) [shnum]
from Students

select *, lead(ShNumber,1) over(partition by [Fname],[LName],[Age] order by ShNumber) [shnum]
from Students