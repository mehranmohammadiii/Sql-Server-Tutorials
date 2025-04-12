--Stored Procedures
--کد ساخت دیتابیس dbshop__DjiKala در کوِئری های قبلی هست

create Procedure Usp_Test1   --proc
as
begin
	select *
	from Products
end
exec Usp_Test1

alter Procedure Usp_Test1   --proc
as
begin						--modify
	select *
	from Products
	where price>100000
end
exec Usp_Test1

create proc Usp_GetProductById
as
begin
	select * 
	from Products
	where ProductID=2
end
exec Usp_GetProductById

alter proc Usp_GetProductById(@Id as int)
as
begin
	select * 
	from Products
	where ProductID=@Id
end
exec Usp_GetProductById 2
exec Usp_GetProductById 11
exec Usp_GetProductById 15

select *
from ProductGroups

insert into ProductGroups values(18,N'قطعات کامپیوتری2',null)

create proc Usp_InsertProductGroups
@Id int,
@ProductGropTitel nvarchar(30),
@ParentgGroupID int
as
begin
	insert into ProductGroups values(@Id,@ProductGropTitel,@ParentgGroupID)
end
exec Usp_InsertProductGroups 30,N'قطعات کامپیوتری8',null

create proc Usp_GetLastnameByUserId
@Id int
as
begin
	select [Family]
	from Users
	where [UserId]=@Id
end
exec Usp_GetLastnameByUserId 5
exec Usp_GetLastnameByUserId 3

alter proc Usp_GetLastnameByUserId
@Id int
as
begin
	select [Family],[Password]
	from Users
	where [UserId]=@Id
end
exec Usp_GetLastnameByUserId 3
exec Usp_GetLastnameByUserId 5

waitfor time '4:19:20'
exec Usp_GetLastnameByUserId 5

waitfor delay '00:00:05'
exec Usp_GetLastnameByUserId 5

select *
from Users

select *
from Users
where [UserId]=1

alter proc Usp_Search
@UserId int,
@Name nvarchar(20),
@Family nvarchar(20),
@MobileNumber char(11)
as
begin
	declare @sql nvarchar(max)
	set @sql='select * from Users where 1=1 '
	if @UserId is not null
		set @sql+='and UserId=@UserId '
	if @Name is not null
		set @sql+='and Name=@Name '
	if @Family is not null
		set @sql+='and Family=@Family '
	if @MobileNumber is not null
		set @sql+='and MobileNumber=@MobileNumber '
	exec sp_executesql @sql ,N'@UserId int,@Name nvarchar(20),@Family nvarchar(20),@MobileNumber char(11)',@UserId,@Name,@Family,@MobileNumber
end
exec Usp_Search 1,null,null,null
exec Usp_Search null,null,N'محمدی',null
exec Usp_Search null,null,null,'09208199895'
exec Usp_Search 2,null,null,null
exec Usp_Search null,N'ممرتضی',null,null
exec Usp_Search null,null,null,null

select *
from Users
where 1=1 

alter proc Usp_InsertProductGroups
@Id int,
@ProductGropTitel nvarchar(30),
@ParentgGroupID int
as
begin
	insert into ProductGroups values(@Id,@ProductGropTitel,@ParentgGroupID)
	print(N'درج با موفقیت انجام شد')
	declare @iden int
	set @iden=SCOPE_IDENTITY()
	return @iden

end
declare @outp int
exec @outp=Usp_InsertProductGroups 33,N'قطعات کامپیوتری5',null
print(@outp)

exec Usp_InsertProductGroups 34,N'قطعات کامپیوتری5',null