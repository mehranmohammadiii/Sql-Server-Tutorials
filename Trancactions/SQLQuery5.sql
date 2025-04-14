--Trancactions
--یا همه باید انجام شوند یا هیچ کدوم در نهایت اجرا نشوند
--Comit      همه انجام میشن/تایید نهایی   
--RollBack    برگشت/برگست به اطلاعات قبلی 
--SevePoint
-- تراکنشی را موفق میگوییم که 4 ویژگی داشته باشند
--ACID
-----
--Atomic		 یا همه انجام بشن یا هیچی انجام نشه		
--Consistent	 بعد از انجام تراکنش، دیتابیس باید در وضعیت پایدار باقی بماند
--Isolation      تراکنش های همزمان نباید بر هم اثر بگذارند
--Durability     ماندگاری/نتایج تراکنش بعد از پایان باید باقی بمانند
--اگر یک سری از عملیات به صورت سلسله مراتبی بود به شکل تراکنش انجام میدهیم از این به بعد

select *
from ProductGroups

begin tran
	insert into ProductGroups values (42,N'محصولات چوبی',null)

	update ProductGroups
	set ProductGropTitel=N'ملزومات چوبی'
	where ProductGroupId=50
commit tran									

Begin Tran
	Insert INTO ProductGroups Values(30,N'محصولات پارچه ای',NULL)

	Select *
	From ProductGroups

	Rollback Tran

	Select *
	From ProductGroups
----------------------
Begin Tran
	Insert INTO ProductGroups Values(31,N'محصولات پارچه ای',NULL)

	Declare @c int 
	Select @c=Count(*)
	From ProductGroups

	If(@c<=20)
		begin
			Print(N'درج با موفقیت انجام شد')
			Commit Tran
		end
	Else
		begin
			Print(N'ظرفیت گروه محصولات تکمیل می باشد و امکان درج گروه جدید نیست')
			Rollback Tran
		end
-----------------------
--SavePoint

Begin Tran
	Save Tran AddProductGroup
	Insert INTO ProductGroups Values(27,N'TestGroup',NULL)

	Begin Tran 
		Save Tran AddProduct
		Insert Into Products(ProductName,Price,ProductGroupId,RegisteredUserId) 
			          Values(N'چپس',5000,27,3)

		Declare @count int
		Select @count=Count(*)
		From Products

		If(@count<=21)
			begin
				Print(N'درج کالا با موفقیت انجام شد')
				Commit Tran AddProductGroup
				Commit Tran AddProduct
			end
		Else
			begin
				Print(N'به علت عدم ظرفیت در جدول محصولات ، محصول جدید درج نشد')
				Rollback Tran AddProduct
			end
-------------------------
Begin Try
	Begin Tran
			Insert INTO ProductGroups Values(50,N'TestGroup5',NULL)

			Insert Into Products(ProductName,Price) 
						Values(N'چپیس',10000)
	Commit Tran
End Try
Begin Catch
	Print(N'در فرایند درج مشکلی رخ داده که امکان درج وجو ندارد')
	Rollback Tran
End Catch

Select *
From ProductGroups