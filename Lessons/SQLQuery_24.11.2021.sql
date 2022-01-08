create table kitap(
kitap_id int primary key identity(100,1),
kitap_ad varchar(30),
yazar_id int,
yayinevi_id int,
sayfa_sayisi int
);


create table yazar(
y_id int primary key identity(10,10),
y_ad varchar(50),
y_yas int
);

create table yayınevi(
yevi_id int primary key identity(1,1),
yevi_ad varchar(30),
yevi_adres varchar(50)
);

alter table kitap add constraint fk_yazar_kitap foreign key(yazar_id) references yazar(y_id);
alter table kitap add constraint fk_yayinevi_kitap foreign key(yayınevi_id) references yayınevi(yevi_id);

insert into yazar values('Tolstoy', 60);
insert into yazar values('Dostoyevski', 55);
insert into yazar values('Ahmet Hamdi Tanpınar', 40);
insert into yazar values('Necip Fazıl', 70);

insert into yayınevi values('İş Bankası', 'İstanbul');
insert into yayınevi values('Epsilon', 'Ankara');
insert into yayınevi values('Can','İstanbul');
insert into yayınevi values('Kültür','Konya');

insert into kitap values('İnsan Ne İle Yaşar', 10,1,120,45);
insert into kitap values('Suç ve Ceza',20,2,1000,120);
insert into kitap values('Çile',40,4,300,50);
insert into kitap values('Savaş ve Barış',10,1,1200,200);
insert into kitap values('Ölüm Manifestosu',10,1,40,20);

select yazar_id,sum(fiyat) toplam_fiyat, count(*) kitap_sayisi from kitap group by yazar_id

-- inner join
select kitap.kitap_ad, yazar.y_ad from kitap inner join yazar on kitap.yazar_id=yazar.y_id

--outer join
--right join ile sağ tablonun tamamı, left join ile ise sol tablonun tamamı gelir
select kitap.kitap_ad, yazar.y_ad from kitap right join yazar on kitap.yazar_id=yazar.y_id
select kitap.kitap_ad, yazar.y_ad from kitap left join yazar on kitap.yazar_id=yazar.y_id

select kitap_id,kitap_ad,yevi_ad from kitap inner join yayınevi on kitap.yayinevi_id=yayınevi.yevi_id

select yevi_ad, count(kitap_id) from kitap inner join yayınevi on kitap.yayinevi_id=yayınevi.yevi_id group by yevi_ad

select yevi_ad, kitap_ad from kitap right join yayınevi on kitap.yayinevi_id=yayınevi.yevi_id

select * from kitap inner join yazar on kitap.yazar_id=yazar.y_id inner join yayınevi on kitap.yayinevi_id=yayınevi.yevi_id

