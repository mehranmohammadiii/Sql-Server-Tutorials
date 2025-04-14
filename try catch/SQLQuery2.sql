 --try catch
create proc Usp_Test2
@a int,
@b int
as
begin
	return @a/@b
end
declare @c int
exec @c=Usp_Test2 10,2
print(@c)
---------------------------
alter proc Usp_Test2
@a decimal,
@b decimal,
@c decimal output
as
begin
	set @c=@a/@b
end
declare @res decimal
exec Usp_Test2 10,2,@res output
print(@res)
-------------------
alter proc Usp_Test2
@a int,
@b int
as
begin
	begin try
		return @a/@b
	end try

	begin catch
		print('EROR salam')
	end catch
end
declare @c int
exec @c=Usp_Test2 15,3
print(@c)
--------------------------
alter proc Usp_Test2
@a decimal,
@b decimal,
@c decimal output
as
begin
	begin try
		set @c=@a/@b
	end try

	begin catch
		print('EROR salam')
	end catch
end
declare @res decimal
exec Usp_Test2 10,0,@res output
print(@res)
---------------------------
alter proc Usp_Test2
@a decimal,
@b decimal,
@c decimal output
as
begin
	begin try
		set @c=@a/@b
	end try

	begin catch
		select ERROR_NUMBER(),
			   ERROR_LINE(),
			   ERROR_MESSAGE()
	end catch
end
declare @res decimal
exec Usp_Test2 10,0,@res output
print(@res)