--Sql Server Mathematical Functions
--Floor قسمت صحیح عدد رو بر میگردونه
--Power  محاسبه توان
--Sqrt   محاسبه رادیکال
--Round  رند کردن عدد
--Rand   تولید عدد تصادفی
select Floor(12.455121)
select Power(2,3)
select Sqrt(64)
select Round(12.454248454,3)
select rand() -- بین صفر تا یک
select rand()*20  -- بین 0 تا 20 
select floor(rand()*20)
select floor(rand()*6)+20   --بین 20 تا 26
select floor(rand()*20)+6