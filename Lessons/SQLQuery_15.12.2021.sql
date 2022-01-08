--create view VIEW_AD_SOYAD
--as
--select PERSONEL.ISIM, PERSONEL.SOYISIM from PERSONEL

--select * from VIEW_AD_SOYAD

--create view GIZLI_VIEW_AD_SOYAD with encryption
--as
--select PERSONEL.ISIM, PERSONEL.SOYISIM from PERSONEL

--select * from GIZLI_VIEW_AD_SOYAD

--create view VIEW_MAAS_RAPOR
--as
--select min(MAAS) as Min_Maas, max(MAAS) as Max_Maas, AVG(MAAS) as Ort_Maas, sum(MAAS) as Toplam_Maas from PERSONEL;

--select * from VIEW_MAAS_RAPOR

--alter view VIEW_MAAS_RAPOR
--as
--select count(*) as Kisi_sayisi, min(MAAS) as Min_Maas, max(MAAS) as Max_Maas, AVG(MAAS) as Ort_Maas, sum(MAAS) as Toplam_Maas from PERSONEL;

--create view VIEW_KITAP_YAZAR
--as
--select YAZARLAR.ISIM, YAZARLAR.SOYISIM, KITAPLAR.ISIM as kitap_isim from KITAPLAR, YAZARLAR, KITAPYAZAR where KITAPLAR.NO = KITAPYAZAR.KNO and YAZARLAR.YAZAR_NO = KITAPYAZAR.YNO

--select * from VIEW_KITAP_YAZAR where VIEW_KITAP_YAZAR.kitap_isim like('%Q%')

--create view VIEW_GENEL_MAAS
--as
--select avg(maas) as Ort_Maas from PERSONEL;

--select top 1 * from PERSONEL p, VIEW_GENEL_MAAS v where p.MAAS>v.Ort_Maas order by p.MAAS asc;

--create view VIEW_ULKE_MAAS
--as
--select ulke, avg(maas) as Ort_Maas from PERSONEL group by ULKE

--select * from PERSONEL p, VIEW_ULKE_MAAS v where p.ULKE = v.ULKE and p.MAAS < v.Ort_Maas
