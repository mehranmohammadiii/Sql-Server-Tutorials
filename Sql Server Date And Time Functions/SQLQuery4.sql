--Sql Server Date And Time Functions

--CURRENT_TIMESTAMP		GETUTCDATE			GETDATE	
--SYSDATETIME			SYSUTCDATETIME		DATENAME	
--DATEPART				DAY					MONTH			YEAR		
--DATEADD				EOMONTH
--SWITCHOFFSET اختلاف تاریخ دو کشور			DATEDIFF			ISDATE

select CURRENT_TIMESTAMP -- ساعت سیستم
select GETDATE() -- ساعت سیستم
select GETUTCDATE() -- ساعت جهانی
select SYSDATETIME() -- میکرو ثانیه/برای تراکنش های بانکی مثلا
select SYSUTCDATETIME() -- میکرو ثانیه جهانی

select DATENAME(YEAR,'2022-01-02')
select DATENAME(MONTH,'2022-01-02')
select DATENAME(WEEK,'2022-01-02') -- هفته چندم از ماه
select DATENAME(WEEKDAY,'2022-01-02') -- چه روزی از هفته			-- همه این ها رشته ای
select DATENAME(DAY,'2022-01-02')
select DATENAME(DAYOFYEAR,'2022-08-02') --چندمین روز از سال
select DATENAME(HOUR,GETDATE())
select DATENAME(MINUTE,GETDATE())
select DATENAME(SECOND,GETDATE())

select DATEPART(YEAR,'2022-01-02')
select DATEPART(MONTH,'2022-01-02')
select DATEPART(WEEK,'2022-01-02') 
select DATEPART(WEEKDAY,'2022-01-02') 								-- همه این ها عددی 
select DATEPART(DAY,'2022-01-02')
select DATEPART(DAYOFYEAR,'2022-08-02') 
select DATEPART(HOUR,GETDATE())
select DATEPART(MINUTE,GETDATE())
select DATEPART(SECOND,GETDATE())

select DAY('2022-05-12')
select month('2022-05-12')
select year('2022-05-12')

select DATEADD(YEAR,1,'2019-02-08')
select DATEADD(YEAR,-1,'2019-02-08')
select DATEADD(MONTH,5,'2019-02-08')
select DATEADD(DAY,20,'2019-02-08')

select DATEDIFF(YEAR,'2023-05-13','2019-05-4')
select DATEDIFF(MONTH,'2023-05-13','2019-05-4')

select ISDATE('2020-01-02')
select ISDATE('mehran')
select ISDATE('2020-40-02')
select ISDATE('2020')
select ISDATE(2020)

select EOMONTH('2022-05-01') -- اخرین روز ماه/یا این ماه چند روزه هست
select day(EOMONTH('2022-05-01'))