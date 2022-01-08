--	VİEW CREATE İŞLEMİ
--create view kitap_yazar
--as
--select kitap_id, kitap_ad, yazar.y_ad from kitap inner join yazar on kitap.yazar_id=yazar.y_id;

select * from kitap_yazar;

--Birden fazla tablo ile oluşturulan view'lerde update, delete ve insert işlemi yapılamaz.

--Eğer view tek bir tablodan oluşuyorsa update, delete ve insert işlemleri yapılabilir.

--View üzerinde insert işleminde değerler kaynak tabloya da eklenir (eksik veriler yerine NULL yazılır).

--View'lar herhangi bir değer alamaz.

--	GROUP BY İLE VİEW KULLANIMI
create view kitapyayinevi
as
select yayınevi.yevi_ad, count(*) kitap_sayisi from yayınevi inner join kitap on kitap.yayinevi_id=yayınevi.yevi_id group by yayınevi.yevi_ad

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

--	OUTPUT OLMADAN PROCEDURE OLUŞTURMA
create procedure sayfakitapgetir @kitapfiyat int
as
begin
select * from kitap where fiyat=@kitapfiyat
end
--	OUTPUT OLAN PROCEDURE ÖRNEKLERİ	
--	ÖRNEK 1
create procedure kitapsayisayfa @kitapsayfa int, @sayi int output
as
begin
select @sayi = count(*) from kitap where sayfa_sayisi=@kitapsayfa
end

declare @kitapsayisi int;
exec kitapsayisayfa 300, @kitapsayisi output;
select @kitapsayisi
---------------------------------------------------------------------------
--	ÖRNEK 2
create procedure topla @num1 int, @num2 int, @add int output
as
begin
set @add = @num1+@num2;
end

declare @toplam int
exec topla 1, 2, @toplam output
select @toplam
---------------------------------------------------------------------------
--	ÖRNEK 3
CREATE PROCEDURE sayikitapgetir @sayfasayisi int
as
begin
select * from kitap where sayfa_sayisi >= @sayfasayisi
end

exec sayikitapgetir 200

---------------------------------------------------------------------------
--	ÖRNEK 4
create procedure kitapmaliyet @sayfabasimaliyet int
as
begin
select kitap.kitap_id, kitap.kitap_ad, kitap.sayfa_sayisi, kitap.sayfa_sayisi*@sayfabasimaliyet from kitap
end

exec kitapmaliyet 2
