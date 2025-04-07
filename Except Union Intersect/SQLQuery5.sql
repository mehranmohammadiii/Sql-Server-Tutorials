--except union intersect															--دستورات مجموعه ای
																					--اجتماع اشتراک تفاضل
use master
go
Create Database dbTest3
GO
Use dbTest3
GO
Create Table Users(
	UserId	int Primary key,
	Fname NVarChar(50),
	Lname NVarChar(50)
)
GO
Insert INTO Users Values(1,N'علی',N'باقری'),
						(2,N'سجاد',N'اکبری'),
						(3,N'محمد',N'نادری'),
						(4,N'رضا',N'روستایی')
GO
Create Table Students(
	StudentId	int Primary key,
	Firstname NVarChar(40),
	Lastname NVarChar(40),
	MobileNumber VarChar(12)
)
GO
Insert INTO Students Values (1,N'محمد',N'جعفری','0910000000'),
							(2,N'ناصر',N'صادقی','0910000000'),
							(3,N'سعید',N'موسوی','0910000000'),
							(4,N'علی',N'ملکی','0910000000'),
							(5,N'بهرام',N'قاسمی','0910000000')
select *
from Users
union
select *
from Students

select [UserId], [Fname], [Lname]
from Users																					
union														--سطرهای مشابه در همه مجموعه های حذف میشوند
select [StudentId], [Firstname], [Lastname]									
from Students

Insert INTO Students Values (6,N'سجاد',N'اکبری','0910000000')

select [Fname], [Lname]
from Users																					
union														--سطرهای مشابه در همه مجموعه های حذف میشوند
select [Firstname], [Lastname]									
from Students

select [Fname], [Lname]
from Users																					
intersect														
select [Firstname], [Lastname]									
from Students

select [Fname], [Lname]
from Users																					
except													
select [Firstname], [Lastname]									
from Students

select [Firstname], [Lastname]									
from Students
except
select [Fname], [Lname]
from Users	