use VT_ALISVERIS

CREATE TABLE TblMusteriler(
id INT PRIMARY KEY IDENTITY(1,1),
isim VARCHAR(30) NOT NULL,
soyisim VARCHAR(30) NOT NULL,
ceptel VARCHAR(11) NOT NfiyatULL,
mail VARCHAR(30) NOT NULL
);

CREATE TABLE TblUrunKategori(
id INT PRIMARY KEY IDENTITY(1,1),
kategori VARCHAR(50) NOT NULL,
);

CREATE TABLE TblUrunler(
id INT PRIMARY KEY IDENTITY(1,1),
ad VARCHAR(50) NOT NULL,
 FLOAT NOT NULL,
barkod VARCHAR(30) NOT NULL,
urun_kategori_id INT FOREIGN KEY REFERENCES TblUrunKategori(id)
);

CREATE TABLE TblMusteriAlisverisTarihi(
id INT PRIMARY KEY IDENTITY(1,1),
tarih datetime DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE TblAlýsverisKayit(
alisveris_id INT FOREIGN KEY REFERENCES TblMusteriAlisverisTarihi(id),
musteri_id INT FOREIGN KEY REFERENCES TblMusteriler(id),
urun_id INT FOREIGN KEY REFERENCES TblUrunler(id),
adet INT NOT NULL,
);

INSERT INTO TblUrunKategori VALUES
('GIDA'), ('ÞARKÜTERÝ'), ('ÇÝKOLATA'), ('BÝSKÜVÝ'), ('UNLU MAMÜLLER'), ('TEMÝZLÝK ÜRÜNLERÝ')

INSERT INTO TblMusteriler VALUES
('Ali', 'KAYA', '05555555555','alikaya@gmail.com'),
('Veli', 'DAÐLI', '05555555444', 'velidagli@gmail.com'),
('Ayþe', 'BÝLÝR', '05555555333', 'aysebilir@gmail.com')

INSERT INTO TblUrunler VALUES
('Çay', 29.75, '113', 1),
('Ekmek', 1.4, '114', 5),
('Halley', 1.5, '115', 4),
('Negro', 2.5, '116', 4),
('Deterjan', 35.55, '117', 6)

select * from TblAlýsverisKayit