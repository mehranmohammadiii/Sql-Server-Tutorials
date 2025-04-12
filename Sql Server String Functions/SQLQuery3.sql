--Sql Server String Functions

--UPPER			LOWER		LEN			REPLACE
--TRANSLATE		REVERSE		REPLICATE	CONCAT		CONCAT_WS	
--LTRIM			RTRIM		TRIM	
--SUBSTRING		STUFF		LEFT		RIGHT 		 STR
--CHARINDEX		PATINDEX
--ASCII			UNICODE		CHAR		NCHAR 		(کار با کد های اسکی)
--QUOTENAME		SPACE		STRING_SPLIT

select UPPER('ali ')
select LOWER('ALI')

select LEN('ALI')
select LEN('ali reza')
select LEN('ali reza     ')

select REPLACE('hdgga djkjkasa caa mvkfnvkf scsad kfafdo','a','***')
select REPLACE('hdgga djkjkasa caa mvkfnvkf scsad kfafdo',' ','***')
select REPLACE('hdgga djkjkasa caa mvkfnvkf scsad kfafdo','a','      ')

select TRANSLATE('mehran ali ahmad abbas fardin','a','@')  --ورودی و خروجی باید برابر باشد
select TRANSLATE('mehran ali ahmad abbas fardin','a','@m') --خطا

select REVERSE('mehran')

select REPLICATE('mehran ',4)

select CONCAT(12,34)
select CONCAT('ali','reza')
select CONCAT('ali',' ','reza')
select CONCAT_WS('mehran','ali','amir','armin')
select CONCAT_WS('*','mehran','ali','amir','armin')
select CONCAT_WS('  ','mehran','ali','amir','armin')

select LTRIM('	mehran') --حذف اسپیس از چپ
select RTRIM('mehran	') -- از راست
select TRIM('	mehran	') -- از دو طرف

select SUBSTRING('mehran mohammadi',1,3)
select SUBSTRING('mehran mohammadi',2,3)
select SUBSTRING('mehran mohammadi',2,4)
select SUBSTRING('mehran mohammadi',8,9)

select SUBSTRING('mehran mohammadi',3,2)
select STUFF('mehran mohammadi',3,2,'*')
select STUFF('mehran mohammadi',7,1,'')

select LEFT('mehran mohammadi',6)
select RIGHT('mehran mohammadi',9)
select CONCAT(LEFT('09208199895',4),'***',RIGHT('09208199895',4))

select STR('200')+10

select CHARINDEX('m','mehran mohammadi')
select CHARINDEX('r','mehran mohammadi')
select CHARINDEX(' ','mehran mohammadi')
select CHARINDEX('me','mehran mohammadi')
select CHARINDEX('.','file1.mp3'),LEN('file1.mp3'),LEN('file1.mp3')-CHARINDEX('.','file1.mp3')
select RIGHT('file1.mp3',LEN('file1.mp3')-CHARINDEX('.','file1.mp3'))
--با این هم میشه SUBSTRING

select PATINDEX('%mm%','mehran mohammadi')

select QUOTENAME('ali')

select SPACE(10)+'ali'
select CONCAT_WS(SPACE(10),'ali','mehran','amir')

select value
from STRING_SPLIT('ssf fadadada SFGLRSM ffwfdi djdlfd dfdf fdogq',' ')
select value
from STRING_SPLIT('ali,amir,mehran,morteza',',')