create table ogretmen(id int primary key, adsoyad varchar(40))

create table ders(id int primary key, dersad varchar(40), ogrid int)

alter table ders add constraint fk_ders_ogretmen foreign key (ogrid) references ogretmen (id)

insert into ogretmen values(1,'x')
insert into ogretmen values(2,'y')
insert into ogretmen values(3,'z')
insert into ogretmen values(4,'w')
--cascade
alter table ders drop constraint fk_ders_ogretmen
alter table ders add constraint fk_ders_ogretmen foreign key (ogrid) references ogretmen(id) on delete cascade on update cascade

insert into ders values (11,'a',1)
insert into ders values(12,'b',2)
insert into ders values(13,'c',3)
insert into ders values(14,'d',2)
insert into ders values(15,'e',4)

select * from ders
select * from ogretmen

update ogretmen set id=5 where id=2
delete from ogretmen where id = 4

--set null
alter table ders drop constraint fk_ders_ogretmen
alter table ders add constraint fk_ders_ogretmen foreign key (ogrid) references ogretmen(id) on delete set null on update cascade

delete from ders where id=1

update ders set ogrid = 1 where ogrid is null

alter table ders add constraint df_ders default 10 for ogrid

insert into ders(id,dersad) values(16,'f')

insert into ogretmen values (10,'xyz')
--check
alter table ogretmen add constraint ch_ogretmen check(id>0)
insert into ogretmen values(-1,'xvz')

-------------------------------------------------------------------------------------------------------------

create table musteri(
musteri_id int primary key,
kullanici_adi varchar(20) not null,
eposta varchar(20) unique,
kayit_tarihi date default getdate(),
constraint ch_musteri check(musteri_id>0 and musteri_id<100)
)

create table siparis(
siparis_id int primary key,
miktar int,
musid int,
constraint ch_siparis check(miktar>0)
)

alter table siparis add constraint fk_siparis_musteri foreign key (musid) references musteri(musteri_id) on delete set null on update cascade 

insert into musteri(musteri_id,kullanici_adi,eposta) values(1,'ali','aliali'),(2,'aliveli','aliveli'),(3,'veliali','alialia')

insert into siparis values(1,200,1),(2,100,1),(3,50,2),(4,20,1),(5,500,1)

select * from musteri
select * from siparis
