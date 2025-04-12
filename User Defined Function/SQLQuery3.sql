--User Defined Function      توابع تریف شده توسط ما
--فرق بین توابع تعریف شده و پیروسیجر ها :
--تابع ها حتما خروجی دارن ولی پروسیجر ها میتونن خروجی داشته باشن یا نداشته باشن
--تابع فقط یک خورجی ولی پروسیجر ها میتونن چندین خروجی داشته باشن
-- پروسیجر ها اوتپوت دارن
--تابع هارو میشه داخل پروسیجر ها فراخوانی کرد ولی عکس ان نه
-- توابع فقط میتونن کار سلکت رو انجام بدن ولی پروسیجر ها درج حذف سلکت و اپدیت هم دارن
--تراکنش ها فقط داخل پروسیجر ها میتونن استفاده بشن

--کد ساخت دیتابیس dbshop__DjiKala در کوِئری های قبلی هست
--Scaler Valued Function  فانکشن های با داده تکی
create function fun1()
returns int
as
begin
	 declare @ID int

	select @ID=ProductID
	from Products
	where ProductGroupId=12

	return @ID
end

select dbo.fun1()
print(dbo.fun1())

select ProductID
from Products
where ProductGroupId=12
---------------------------
create function fun2(@ProductTitle nvarchar(30))
returns int
as
begin

	return (select ProductGroupId
			from Products
			where ProductTitel=@ProductTitle	)

end

select dbo.fun2(N'سفید کننده')
print(dbo.fun2(N'پفک'))
----------------------------
select *
from Products

alter function fun3(@price int ,@RegisterUserID int)
returns int
as 
begin
	return @price+@RegisterUserID
end

select ProductID,ProductTitel,Price,RegisterUserID,dbo.fun3(Price,RegisterUserID)
from Products