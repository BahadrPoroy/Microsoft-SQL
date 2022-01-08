USE VT_ALISVERIS

CREATE TABLE TblMusteriler(
id INT PRIMARY KEY IDENTITY(1,1),
isim VARCHAR(30) NOT NULL,
soyisim VARCHAR(30) NOT NULL,
ceptel VARCHAR(11) NOT NULL,
mail VARCHAR(30) NOT NULL
);

--CREATE TABLE TblUrunKategori(
--id INT PRIMARY KEY IDENTITY(1,1),
--kategori VARCHAR(50) NOT NULL,
--);

--CREATE TABLE TblUrunler(
--id INT PRIMARY KEY IDENTITY(1,1),
--ad VARCHAR(50) NOT NULL,
--fiyat FLOAT NOT NULL,
--barkod VARCHAR(30) NOT NULL,
--urun_kategori_id INT FOREIGN KEY REFERENCES TblUrunKategori(id)
--);

CREATE TABLE TblAlýsverisKayit(
alisveris_id INT PRIMARY KEY IDENTITY(1,1),
musteri_id INT FOREIGN KEY REFERENCES TblMusteriler(id),
adet INT NOT NULL,
tarih datetime DEFAULT CURRENT_TIMESTAMP
);
alter table TblAlýsverisKayit add urun_id int
alter table TblAlýsverisKayit add constraint fk_urunid foreign key (urun_id) references TblUrunler(id)

INSERT INTO TblMusteriler VALUES
('Ali', 'KAYA', '05555555555','alikaya@gmail.com'),
('Veli', 'DAÐLI', '05555555444', 'velidagli@gmail.com'),
('Ayþe', 'BÝLÝR', '05555555333', 'aysebilir@gmail.com')

INSERT INTO TblUrunKategori VALUES
('GIDA'), ('ÞARKÜTERÝ'), ('ÇÝKOLATA'), ('BÝSKÜVÝ'), ('UNLU MAMÜLLER'), ('TEMÝZLÝK ÜRÜNLERÝ')

select * from TblAlýsverisKayit

select * from TblUrunler

INSERT INTO TblUrunler VALUES
('Çay', 29.75, '113', 1),
('Ekmek', 1.4, '114', 5),
('Halley', 1.5, '115', 4),
('Negro', 2.5, '116', 4),
('Deterjan', 35.55, '117', 6),
('Ayçiçek Yaðý', 98.55, '118', 1),
('Gevrek', 15.25, '119', 5)
INSERT INTO TblUrunler VALUES
('Ayçiçek Yaðý', 98.55, '118', 1),
('Gevrek', 15.25, '119', 5)


INSERT INTO TblAlýsverisKayit (musteri_id, urun_id, adet) VALUES
(1, 3, 5),
(2, 5, 3),
(3, 7, 10),
(1, 1, 4)

Select * from TblAlýsverisKayit

SELECT TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat, TblAlýsverisKayit.tarih from((TblAlýsverisKayit
INNER JOIN TblMusteriler ON TblAlýsverisKayit.musteri_id = TblMusteriler.id)
INNER JOIN TblUrunler ON TblAlýsverisKayit.urun_id = TblUrunler.id)
