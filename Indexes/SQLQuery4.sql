--index   برای داده های بالای 10 هزار تا/سرعت در جستجو ها و بازیابی اطلاعات
--sql server clustered indexes (primary key)		ترتیب منطقی=ترتیب فیزکی/توی هارد هم به همون ترتیب ذخیره میشه
--sql server nonclustered indexes  (Covering,Include,Filtered,Unique)

--sql server Covering index
--sql server Include index
--sql server Filtered index
--sql server Unique index


Use master
GO
Drop Database IF exists dbUniversity
GO
Create Database dbUniversity
GO
Use dbUniversity
GO

Create Table Employee(
	EmployeeId int Primary key identity Not NULL	,
	FirstName NvarChar(20) Not NULL,
	LastName NvarChar(20) Not NULL,
	RegisterDate Datetime Not NULL,
	UserName Nvarchar(100) Not NULL,
	Constraint unique_user_name Unique(UserName)
)
GO

Insert Into Employee(FirstName,LastName,RegisterDate,UserName) 
					Values(N'علی',N'توکلی',GETDATE(),'Ali'),
						  (N'محمد',N'رضایی',GETDATE(),'Mohammad'),
						  (N'سارا',N'قاسمی',GETDATE(),'Sara'),
						  (N'رضا',N'جوادی',GETDATE(),'Reza')

GO 1




Create Table Students(
	StudentId int Primary key identity Not NULL	,
	FirstName NvarChar(20) Not NULL,
	LastName NvarChar(20) Not NULL,
	RegisterDate Datetime Not NULL,
	EnteringYear int Not NULL
)
GO 1

declare @fNameRand int=FLOOR(Rand()*5+1)
declare @fName nvarchar(20)=CHOOSE(@fNameRand,N'مهدی',N'محمد',N'رضا',N'علی',N'احمد')
declare @lNameRand int=FLOOR(Rand()*5+1)
declare @lName nvarchar(20)=CHOOSE(@lNameRand,N'جوادی',N'قاسمی',N'سعیدی',N'توکلی',N'جعفری')
declare @offset int=Floor(Rand()*52560)
declare @date datetime=DateAdd(hour,@offset,'2015-01-01')
declare @enteringYear int =Floor(Rand()*14+1385)
Insert Into Students Values(@fName,@lName,@date,@enteringYear)
GO 1000



--Heap Table(جدول انبوه)
Create Table Teachers(
	TeacherId int Not NULL Identity,
	FirstName NvarChar(20) Not NULL,
	LastName NvarChar(20) Not NULL,
	RegisterDate Datetime Not NULL,
	IsActive bit Not NULL,
	Email Varchar(100) Not NULL
)

GO 1
declare @fNameRand int=FLOOR(Rand()*5+1)
declare @fName nvarchar(20)=CHOOSE(@fNameRand,N'مهدی',N'محمد',N'رضا',N'علی',N'احمد')
declare @lNameRand int=FLOOR(Rand()*5+1)
declare @lName nvarchar(20)=CHOOSE(@lNameRand,N'جوادی',N'قاسمی',N'سعیدی',N'توکلی',N'جعفری')
declare @offset int=Floor(Rand()*52560)
declare @date datetime=DateAdd(hour,@offset,'2015-01-01')
declare @active int=Floor(Rand()*2)
Insert Into Teachers Values(@fName,@lName,@date,@active,'test@yahoo.com')
GO 10

select *
from Employee
GO

select *
from Students

select *
from Students
where [EnteringYear]=1388 and [LastName]=N'جعفری'
GO

select *
from Teachers

--clustered indexes
create clustered index ci_TeacherId      --CIX
on Teachers(TeacherId)

--nonclustered indexes
 --مثلا خیلی وقت ها ممکنه یک دانشجو رو با نام و نام خانوداگی سرچ میکنیم،چون زیاد سرچ میشه پس  :  
--Covering
create nonclustered index IX_Teacher_Name_Family  
on Teachers(FirstName Asc,LastName Desc)

--اگر نیاز باشه در لحظه میاد اضاف میکنه/اگر در جستجو تاریخ نیاز باشه بهش کمک میکنه وگرنه کمک نمیکنه همیشه
--Include
create nonclustered index IX_Family
on Teachers(LastName)  include(RegisterDate)

 --اطلاعات اضافه که هیچ وقت روش سرچ نمیشه/اساتیدی که مثلا 10 سال پیش توی دانشگاه ما بودن ولی الان نیستن/اینها زمان سرچ خودشو نشون میده و سرعت رو بالا میبره
--Filtered
create nonclustered index IX_Teacher_Name_Family_ByIsActive
on Teachers(FirstName,LastName) where IsActive=1

--Unique
create unique index unique_Email
on Teachers(Email)

exec sp_rename N'dbo.Teachers.ci_TeacherId',
			  'CIX_TeacherId',
			  'index'

alter index IX_Teacher_Name_Family_ByIsActive
on Teachers
disable

alter index IX_Teacher_Name_Family_ByIsActive
on Teachers
rebuild

alter index all
on Teachers
disable

alter index all
on Teachers
rebuild

DROP INDEX index_name ON table_name;