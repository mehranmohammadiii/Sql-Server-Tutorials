--View
--کد ساخت دیتابیس dbshop__DjiKala در کوِئری های قبلی هست
create view V_Test1
as
select *
from Products
where Price>100000;

select *
from V_Test1;

select *
from V_Test1
where ProductGroupId=10;

alter view V_Test1  --تغییر و آپدیت
as
select *
from Products
where Price>25000;

select *
from V_Test1

drop view if exists V_Test1

exec sp_rename 'V_Test1' , 'V_Test'

select *
from sys.tables

select *
from sys.views

exec sp_helptext V_Test