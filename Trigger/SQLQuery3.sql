--Trigger   After Trigger / Insted Of Trigger / DDL Trigger

--After Trigger       بعد از عمل های اینزرت ،دیلیت و آپدیت / برای جداول   
--Insted Of Trigger   جایگزین عمل های اصلی مثل اینزرت ،دیلیت و آپدیت / برای جداول
--DDL Trigger         برای تمام دیتابیس / تغییر در ساختار
--Log Table           رفتار های روی جداول مختلف / اتفاق هایی که روی جداول میفتد   
use master
go
Create database dbTest10
Go
Use dbTest10
Go

CREATE TABLE States(
	StateCode tinyint PRIMARY KEY Identity  NOT NULL,
	StateName nvarchar(100) NOT NULL,
)
GO

CREATE TABLE Cities(
	CityCode int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	CityName nvarchar(100) NOT NULL,
	StateCode tinyint NOT NULL,
	Foreign key(StateCode) References States(StateCode)
)
GO

INSERT dbo.States (StateName) VALUES (N'آذربایجان شرقی'),(N'آذربایجان غربی'),(N'اردبیل')
,(N'اصفهان'),(N'ایلام'),(N'بوشهر'),(N'تهران'),(N'چهار محال بختیاری'),(N'خراسان جنوبی'),(N'خراسان رضوی')
,(N'خراسان شمالی'),(N'خوزستان'),(N'زنجان'),(N'سمنان'),(N'سیستان و بلوچستان'),(N'فارس'),(N'قزوین'),(N'قم')
,(N'کردستان'),(N'کرمان'),(N'کرمانشاه'),(N'کهکیلویه و بویر احمد'),(N'گلستان'),(N'گیلان'),(N'لرستان')
,(N'مازندران'),(N'مرکزی'),(N'هرمزگان'),(N'همدان'),(N'یزد')
GO

INSERT Cities (CityName, StateCode) VALUES (N'تبریز', 1),
										   (N'ارومیه', 2),
										   (N'اردبیل', 3),
										   (N'همدان', 29),
										   (N'تویسرکان', 29),
										   (N'نهاوند', 29),
										   (N'تهران', 7)


Select *
From States

Select *
From Cities

Create Table LogTable(
	LogId int primary key identity(1,1),
	TableName varchar(100),
	CmdType nvarchar(100),            --Insert , Delete, Update(Insert,Delete)
	KeyId int,						  -- شماره رکورد تغییر شده
	RegisterDate datetime2,
	Hostname Nvarchar(100),
	FieldValue nvarchar(100)          -- نام ستون تغییر شده
)
-----------------------
--After Trigger

create trigger	InsertCityTrigger
on Cities
after insert 
as
begin
	print(N'درج با موفقیت انجام شد')
end;

INSERT Cities (CityName, StateCode) VALUES (N'ملایر', 29);

alter trigger InsertCityTrigger
on Cities
after insert 
as
begin
	print(N'درج با موفقیت انجام شد')
	declare @id int
	select @id=inserted.CityCode
	from inserted
	
	insert into LogTable(TableName ,CmdType,KeyId,RegisterDate,Hostname,FieldValue)
		   values('Cities','Insert',@id,getdate(),HOST_NAME(),null)
end
INSERT Cities (CityName, StateCode) VALUES (N'ملایر', 29);
select *
from LogTable
-----------------------------------
alter trigger DeleteCityTrigger
on Cities
after delete
as
begin
	declare @CitName nvarchar(20)
	declare @Id int 
	select @CitName=deleted.CityName, @Id=deleted.StateCode
	from deleted
	if @CitName=N'ملایر'
	begin
		print(N'امکان پذیر نیست')
		rollback
	end
	else
	begin
	insert into LogTable(TableName ,CmdType,KeyId,RegisterDate,Hostname,FieldValue)
		   values('Cities','Delete',@Id,getdate(),HOST_NAME(),null)		
		print(N'حذف شد')
	end

end;
Select *
From Cities

delete
from Cities
where CityCode=11
delete
from Cities
where CityCode=3
Select *
From Cities

select *
from LogTable
--------------------------------------
create trigger UpdateCityTrigger
on Cities
after update
as
begin
	declare @OldId int
	declare @OldName nvarchar(20)
	declare @NewdId int 
	declare @NewName nvarchar(20)

	select @OldId=deleted.CityCode , @OldName=deleted.CityName
	from deleted

	select @NewdId=inserted.CityCode , @NewName=inserted.CityName
	from inserted

	insert into LogTable(TableName ,CmdType,KeyId,RegisterDate,Hostname,FieldValue)
		   values('Cities','Delete',@OldId,getdate(),HOST_NAME(),@OldName)

		insert into LogTable(TableName ,CmdType,KeyId,RegisterDate,Hostname,FieldValue)
		   values('Cities','Insert',@NewdId,getdate(),HOST_NAME(),@NewName)

	print(N'ویرایش با موفقیت انجام شد')
end

update Cities
set CityName=N'Malayer'
where CityCode=11

update Cities
set CityName=N'Malayer'
where StateCode=29

select *
from LogTable
Select *
From Cities
-----------------------
--instead of trigger

Drop Database If Exists dbTest10

create Trigger Ins_InsertCities
On Cities
Instead Of Insert
As
begin
	Print(N'امکان درج وجود ندارد') 
end
insert into Cities (CityName,StateCode) values (N'بیرجند',40)
Select *
From Cities

CREATE TABLE Cities2(
	CityCode int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	CityName nvarchar(100) NOT NULL,
	StateCode tinyint NOT NULL,
	Foreign key(StateCode) References States(StateCode)
)

drop trigger Ins_InsertCities

create trigger Ins_InsertCities
on Cities
Instead Of Insert
as
begin
	declare @CountCity int
	select @CountCity=count(CityCode)
	from Cities

	declare @CityName nvarchar(20)
	declare @StateCode int		
	select @CityName=inserted.CityName,@StateCode=inserted.StateCode
	from inserted

	if @CountCity>=10
		begin
			insert into Cities2(CityName,StateCode) values (@CityName,@StateCode)			
		end
	else
		begin
		insert into Cities(CityName,StateCode) values (@CityName,@StateCode)
		end
end
Select *
From Cities
Select *
From Cities2
insert into Cities(CityName,StateCode) values (N'ملایر',29)

--instead of delete
--instead of update
-----------------------------------
--DDL Trigger

create Trigger DDL_Trigger1
ON Database
For Create_Table,Drop_Table,Alter_Table
As
Begin
	Print(N'تست')
	Rollback
End


Drop table Cities