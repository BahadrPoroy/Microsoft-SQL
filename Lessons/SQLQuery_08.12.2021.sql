--	V�EW CREATE ��LEM�
--create view kitap_yazar
--as
--select kitap_id, kitap_ad, yazar.y_ad from kitap inner join yazar on kitap.yazar_id=yazar.y_id;

select * from kitap_yazar;

--Birden fazla tablo ile olu�turulan view'lerde update, delete ve insert i�lemi yap�lamaz.

--E�er view tek bir tablodan olu�uyorsa update, delete ve insert i�lemleri yap�labilir.

--View �zerinde insert i�leminde de�erler kaynak tabloya da eklenir (eksik veriler yerine NULL yaz�l�r).

--View'lar herhangi bir de�er alamaz.

--	GROUP BY �LE V�EW KULLANIMI
create view kitapyayinevi
as
select yay�nevi.yevi_ad, count(*) kitap_sayisi from yay�nevi inner join kitap on kitap.yayinevi_id=yay�nevi.yevi_id group by yay�nevi.yevi_ad

select * from kitap; select * from yazar;

--	STORED PROCEDURE
create procedure kitapgetir
as
begin
select * from kitap
end
--	KULLANIMLAR
--1. Kitapgetir
--2. Exec kitapgetir
--3. Execute kitapgetir

--	OUTPUT OLMADAN PROCEDURE OLU�TURMA
create procedure sayfakitapgetir @kitapfiyat int
as
begin
select * from kitap where fiyat=@kitapfiyat
end
--	OUTPUT OLAN PROCEDURE �RNEKLER�	
--	�RNEK 1
create procedure kitapsayisayfa @kitapsayfa int, @sayi int output
as
begin
select @sayi = count(*) from kitap where sayfa_sayisi=@kitapsayfa
end

declare @kitapsayisi int;
exec kitapsayisayfa 300, @kitapsayisi output;
select @kitapsayisi
---------------------------------------------------------------------------
--	�RNEK 2
create procedure topla @num1 int, @num2 int, @add int output
as
begin
set @add = @num1+@num2;
end

declare @toplam int
exec topla 1, 2, @toplam output
select @toplam
---------------------------------------------------------------------------
--	�RNEK 3
CREATE PROCEDURE sayikitapgetir @sayfasayisi int
as
begin
select * from kitap where sayfa_sayisi >= @sayfasayisi
end

exec sayikitapgetir 200

---------------------------------------------------------------------------
--	�RNEK 4
create procedure kitapmaliyet @sayfabasimaliyet int
as
begin
select kitap.kitap_id, kitap.kitap_ad, kitap.sayfa_sayisi, kitap.sayfa_sayisi*@sayfabasimaliyet from kitap
end

exec kitapmaliyet 2
