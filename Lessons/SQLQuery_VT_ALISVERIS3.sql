------------------------------------------------------
-- Alisveris sitesi iç,n 3 ayrý tablo oluþturuldu. Müþteri ve ürün arasýnda çoka-çok bir iliþki vardýr. 
-- 3 ayrý tablo ile bu iliþkileri 1-N ilþkilere indirgeyelim.

CREATE DATABASE VT_ALISVERIS3
USE VT_ALISVERIS3 -- VT_ALISVERIS isimli vt yi kullan  

CREATE TABLE TblMusteriler
(  
id INT PRIMARY KEY IDENTITY(1,1),  
isim VARCHAR(30) NOT NULL,  
soyisim VARCHAR(30) NOT NULL,
mail VARCHAR(30) NOT NULL   
); 


CREATE TABLE TblUrunKategori(
id INT PRIMARY KEY IDENTITY(1,1),
kategori VARCHAR(50) NOT NULL
);

CREATE TABLE TblUrunler
(  
id INT PRIMARY KEY IDENTITY(1,1),  
ad VARCHAR(50) NOT NULL,  
fiyat FLOAT NOT NULL,
barkod VARCHAR(30) NOT NULL,
urun_kategori_id INT FOREIGN KEY REFERENCES TblUrunKategori(id)   
); 

CREATE TABLE TblMusteriAlisverisTarihi(
id INT PRIMARY KEY IDENTITY(1,1), 
tarih datetime DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE TblAlisverisKayit
(  
alisveris_id INT FOREIGN KEY REFERENCES  TblMusteriAlisverisTarihi(id), 
musteri_id INT FOREIGN KEY REFERENCES TblMusteriler(id),
urun_id INT FOREIGN KEY REFERENCES TblUrunler(id),
urun_fiyat FLOAT NOT NULL,  
adet INT NOT NULL
); 


--------------------------------------------------------Tablolara veri ekleme------------------------------------------------------
 INSERT INTO TblMusteriler VALUES ('Ali','KAYA', 'ak@com.tr'),
								  ('Hasan','ALAN', 'ha@com.tr'),
								  ('Ayþe','Bilir', 'ab@com.tr')		

					
INSERT INTO TblUrunKategori VALUES 
('GIDA'), ('ÞARKÜTERÝ'),('ÇÝKOLATA'),('BÝSKÜVÝ'),('UNLU MAMÜLLER'),('TEMÝZLÝK ÜRÜNLERÝ')
 

INSERT INTO TblUrunler VALUES ('Peynir',15.00, '100', 2),
							  ('Yumurta',23.50, '101', 1),
							  ('Çay', 19.50, '102', 1),
							  ('Halley', 1.5, '103', 4),
							  ('Negro', 2.5, '104', 4),
							  ('Deterjan', 35.55, '105', 6)

------------------------------------------------------------------------
---BÝRÝNCÝ MÜÞTERÝ PEYNÝR, YUMURTA, ÇAY ve Negroyu TEK BÝR ALIÞVERÝÞTE ALIRSA---
------------------------------------------------------------------------
-- Öncelikle tüm müþteri ve ürünleri görelim
select * from TblUrunler 
select * from TblMusteriler

INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);
--tarih alaný varsayýlan olarak CURRENT_TIMESTAMP özelliðine sahip olsa hem id, hem tarih otomatik deðer aldýðýnda VALUES kýsmý boþ kalýr ve kayda izin verilmez. 
-- VALUES (CURRENT_TIMESTAMP); þeklinde kayýt gerçekleþtirildi.


--Aþaðýda @Fiyat deðiþkenine veritabanýndan çekilen ürün fiyatý deðer olarak atanacaktýr. @Fiyat ile ilgili kodlarýn BÝRLÝKTE çalýþtýrýlmasý gerekmektedir.
--1. PEYNÝR SATIN ALMA
DECLARE @Fiyat Float   -- fiyat adýnda bir deðiþken tanýmlandý. Deðiþken isimleri kesinlikle @ ile baþlamalýdýr.
set  @Fiyat = (select fiyat from TblUrunler where id = 1);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 1, @Fiyat ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 2);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 2, @Fiyat ,5) 

--3. Çay SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 3);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 3, @Fiyat ,4) 

--4. Negro SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 5);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 5, @Fiyat ,7) 													

------------------------------------------------------------------------
---BÝRÝNCÝ MÜÞTERÝ PEYNÝR, YUMURTA ve ÇAYI TEK BÝR ALIÞVERÝÞTE ALIRSA---
------------------------------------------------------------------------


-- SELECT-WHERE ÝLE 4tablodan kayýt çekme  (TblMusteriler, TblUrunler, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENÝFÝYAT, TblAlisverisKayit.urun_fiyat ESKÝFÝYAT,
TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM TblAlisverisKayit, TblMusteriler, TblUrunler, TblMusteriAlisverisTarihi
WHERE ((TblMusteriler.id = TblAlisverisKayit.musteri_id) and (TblUrunler.id = TblAlisverisKayit.urun_id)) and (TblAlisverisKayit.alisveris_id=TblMusteriAlisverisTarihi.id)


-- SELECT-INNER JOIN ÝLE 4tablodan kayýt çekme  (TblMusteriler, TblUrunler, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENÝFÝYAT, TblAlisverisKayit.urun_fiyat ESKÝFÝYAT,
TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id);





------------------------------------------------------------------------
---ÝKÝNCÝ MÜÞTERÝ PEYNÝR, YUMURTA ve Deterjaný TEK BÝR ALIÞVERÝÞTE ALIRSA---
------------------------------------------------------------------------
INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);
--tarih alaný varsayýlan olarak CURRENT_TIMESTAMP özelliðine sahip olsa hem id, hem tarih otomatik deðer aldýðýnda VALUES kýsmý boþ kalýr ve kayda izin verilmez. 
-- VALUES (CURRENT_TIMESTAMP); þeklinde kayýt gerçekleþtirildi.


--Aþaðýda @Fiyat deðiþkenine veritabanýndan çekilen ürün fiyatý deðer olarak atanacaktýr. @Fiyat ile ilgili kodlarýn BÝRLÝKTE çalýþtýrýlmasý gerekmektedir.
--1. PEYNÝR SATIN ALMA
DECLARE @Fiyat Float   -- fiyat adýnda bir deðiþken tanýmlandý. Deðiþken isimleri kesinlikle @ ile baþlamalýdýr.
set  @Fiyat = (select fiyat from TblUrunler where id = 1);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (2, 2, 1, @Fiyat ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 2);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (2, 2, 2, @Fiyat ,5) 
													
--3. Deterjan SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 6);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (2, 2, 6, @Fiyat ,5)
------------------------------------------------------------------------
---ÝKÝNCÝ MÜÞTERÝ PEYNÝR, YUMURTA ve ÇAYI TEK BÝR ALIÞVERÝÞTE ALIRSA---
------------------------------------------------------------------------




------------------------------------------------------------------------
---ÜÇÜNCÜ MÜÞTERÝ Halley, Yumurta ve Negroyu TEK BÝR ALIÞVERÝÞTE ALIRSA---
------------------------------------------------------------------------
INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);

--Aþaðýda @Fiyat deðiþkenine veritabanýndan çekilen ürün fiyatý deðer olarak atanacaktýr. @Fiyat ile ilgili kodlarýn BÝRLÝKTE çalýþtýrýlmasý gerekmektedir.
--1. Halley SATIN ALMA
DECLARE @Fiyat Float   -- fiyat adýnda bir deðiþken tanýmlandý. Deðiþken isimleri kesinlikle @ ile baþlamalýdýr.
set  @Fiyat = (select fiyat from TblUrunler where id = 4);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (3, 3, 4, @Fiyat ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 2);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (3, 3, 2, @Fiyat ,10) 
													
--3. Negro SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 5);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (3, 3, 5, @Fiyat ,8)
------------------------------------------------------------------------
---ÜÇÜNCÜ MÜÞTERÝ PEYNÝR, YUMURTA ve ÇAYI TEK BÝR ALIÞVERÝÞTE ALIRSA---
------------------------------------------------------------------------





------------------------------------------------------------------------
---BÝRÝNCÝ MÜÞTERÝ Deterjan, Yumurta ve Çayý TEK BÝR ALIÞVERÝÞTE ALIRSA---
------------------------------------------------------------------------
-- Öncelikle tüm müþteri ve ürünleri görelim
select * from TblUrunler 
select * from TblMusteriler

INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);

--Aþaðýda @Fiyat deðiþkenine veritabanýndan çekilen ürün fiyatý deðer olarak atanacaktýr. @Fiyat ile ilgili kodlarýn BÝRLÝKTE çalýþtýrýlmasý gerekmektedir.
--1. Deterjan SATIN ALMA
DECLARE @Fiyat Float   -- fiyat adýnda bir deðiþken tanýmlandý. Deðiþken isimleri kesinlikle @ ile baþlamalýdýr.
set  @Fiyat = (select fiyat from TblUrunler where id = 6);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (4, 1, 6, @Fiyat ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 2); 
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (4, 1, 2, @Fiyat ,7) 

--3. Çay SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 3);
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (4, 1, 3, @Fiyat ,4) 
------------------------------------------------------------------------
---BÝRÝNCÝ MÜÞTERÝ Deterjan, Yumurta ve Çayý TEK BÝR ALIÞVERÝÞTE ALIRSA---
------------------------------------------------------------------------



--PEYNÝR FÝYATI GÜNCELLENDÝ
select * from TblUrunler
UPDATE TblUrunler SET fiyat = 17.25 where id = 1



------------------------------------------------------------------------
---ÝKÝNCÝ MÜÞTERÝ Peynir ve Halleyi TEK BÝR ALIÞVERÝÞTE ALIRSA---
------------------------------------------------------------------------
-- Öncelikle tüm müþteri ve ürünleri görelim
select * from TblUrunler 
select * from TblMusteriler

INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);

--Aþaðýda @Fiyat deðiþkenine veritabanýndan çekilen ürün fiyatý deðer olarak atanacaktýr. @Fiyat ile ilgili kodlarýn BÝRLÝKTE çalýþtýrýlmasý gerekmektedir.
--1. Peynir SATIN ALMA
DECLARE @Fiyat Float   -- fiyat adýnda bir deðiþken tanýmlandý. Deðiþken isimleri kesinlikle @ ile baþlamalýdýr.
set  @Fiyat = (select fiyat from TblUrunler where id = 1);  --"select @Fiyat" veya "Print @Fiyat" ile deðer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (5, 2, 1, @Fiyat ,4) 


--2. Halley SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 4); 
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (5, 2, 4, @Fiyat ,7) 

------------------------------------------------------------------------
---ÝKÝNCÝ MÜÞTERÝ Peynir ve Halleyi TEK BÝR ALIÞVERÝÞTE ALIRSA---
------------------------------------------------------------------------





-- SELECT-INNER JOIN ÝLE 4tablodan kayýt çekme  (TblMusteriler, TblUrunler, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENÝFÝYAT, TblAlisverisKayit.urun_fiyat ESKÝFÝYAT,
TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id);




-- SELECT-WHERE ÝLE 5tablodan kayýt çekme  (TblMusteriler, TblUrunler, TblUrunKategori, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENÝFÝYAT, TblAlisverisKayit.urun_fiyat ESKÝFÝYAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM TblAlisverisKayit, TblMusteriler, TblUrunler, TblMusteriAlisverisTarihi, TblUrunKategori
WHERE (
(TblMusteriler.id = TblAlisverisKayit.musteri_id) and (TblUrunler.id = TblAlisverisKayit.urun_id)) and 
((TblAlisverisKayit.alisveris_id=TblMusteriAlisverisTarihi.id) and (TblUrunler.urun_kategori_id=TblUrunKategori.id))


-- SELECT-INNER JOIN ÝLE 5tablodan kayýt çekme  (TblMusteriler, TblUrunler,  TblUrunKategori, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENÝFÝYAT, TblAlisverisKayit.urun_fiyat ESKÝFÝYAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
);




------------------------------ GEÇMÝÞ ALIÞVERÝÞLERLE ÝLGÝLÝ GENEL SORGULAR ----------------------------------------
-------------------------------------------------------------------------------------------------------------------

-- id si 1 olan müþterinin alýþveriþ geçmiþi
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENÝFÝYAT, TblAlisverisKayit.urun_fiyat ESKÝFÝYAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
) where TblMusteriler.id = 1


-- id si 2 olan alýþveriþin bilgileri
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENÝFÝYAT, TblAlisverisKayit.urun_fiyat ESKÝFÝYAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
) where TblAlisverisKayit.alisveris_id = 2


-- En son yapýlan alýþveriþe ait bilgileri getir
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENÝFÝYAT, TblAlisverisKayit.urun_fiyat ESKÝFÝYAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
) where TblAlisverisKayit.alisveris_id = (Select max(alisveris_id) from TblAlisverisKayit)




select * from TblAlisverisKayit

-- Tüm alýþveriþlerin toplam fiyat tutarý
SELECT sum(TblAlisverisKayit.urun_fiyat*TblAlisverisKayit.adet)
FROM TblAlisverisKayit 

-- Her bir müþterinin þu ana kadar yaptýðý alýþveriþlerin toplam fiyat tutarý
SELECT TblAlisverisKayit.musteri_id, sum(TblAlisverisKayit.urun_fiyat*TblAlisverisKayit.adet)
FROM TblAlisverisKayit,TblMusteriler group by TblAlisverisKayit.musteri_id


select * from TblAlisverisKayit