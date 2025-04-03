--offset,fetch
use master
go
create database dbtest
go
use dbtest
go

create table PeopleGrop(
	PeopleGropId tinyint primary key not null,
	PeopleGropTitel nvarchar(20) not null
)

go
insert into PeopleGrop
			values (1,N'دانشجویان'),
				   (2,N'مهندسان'),
				   (3,N'پزشکان'),
				   (4,N'معماران'),
				   (5,N'وکلا'),
				   (6,N'پرستاران'),
				   (7,N'فرهنگیان')

go
create table people(
	PersonID int  identity(1,1) not null,
	[Name] nvarchar(20) not null,
	Family nvarchar(20) not null,
	Age tinyint null,
	[Avg] decimal(4,2) not null,
	PhoneNumber char(11) not null,
	PeopleGropId tinyint not null,
	constraint PK_People primary key(PersonID),
	constraint Fk_People_PersonID foreign key(PeopleGropId) references PeopleGrop(PeopleGropId)
)
go 
insert into people
			values (N'مهران',N'محمدی',20,17.50,'09156547895',1),
				   (N'علی',N'احمدی',24,18.50,'09167547895',2),
				   (N'امیر',N'محمدی',28,19.50,'0920547895',3),
				   (N'مرتضی',N'اکبری',30,16.00,'09156547895',2),
				   (N'امیر رضا',N'حسینی',35,17.00,'091347895',2),
				   (N'ایمان',N'سلیمی',48,20.00,'09156547895',6),
				   (N'محمد',N'عمرانی',55,19.50,'0921547895',5)
go
select *
from people

select * 
from people
order by [avg]

select [name],family,[avg]
from people
order by [avg]					   --از 4 به بعد
offset 4 rows										 

select [name],family,[avg]
from people
order by [avg]

select * 
from people
order by [avg]

select [name],family,[avg]
from people
order by [avg]
offset 3 rows
fetch next 2 rows only