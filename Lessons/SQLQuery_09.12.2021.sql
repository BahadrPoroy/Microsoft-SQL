select TblMusteriler.isim, TblMusteriler.soyisim, sum(TblAlisverisKayit.urun_fiyat*TblAlisverisKayit.adet) as toplamm
from TblAlisverisKayit inner join TblMusteriler on TblAlisverisKayit.musteri_id = TblMusteriler.id group by TblMusteriler.isim,
TblMusteriler.soyisim