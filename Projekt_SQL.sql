-- 1. Stwórz Bazę „Sklep odzieżowy”
create database Sklep_odziezowy;
use Sklep_odziezowy;
 
/* 2. Utwórz tabelę „Producenci” z kolumnami:


id producenta
nazwa producenta
adres producenta
nip producenta
data podpisania umowy z producentem
Do każdej kolumny ustaw odpowiedni „constraint” */

create table Producenci(
ID_producenta integer primary key auto_increment,
Nazwa_producenta varchar(100) not null unique,
Adres_producenta varchar(100) not null, 
NIP_producenta varchar(10) not null unique,
Data_podpisania_umowy_z_producentem date not null,
CHECK (NIP_producenta REGEXP '^[0-9]{10}$')
);


/* 3. Utwórz tabelę „Produkty” z kolumnami:

id produktu
id producenta
nazwa produktu
opis produktu
cena netto zakupu
cena brutto zakupu
cena netto sprzedaży
cena brutto sprzedaży
procent VAT sprzedaży
Do każdej kolumny ustaw odpowiedni „constraint” */


create table Produkty (
ID_produktu integer primary key auto_increment,
ID_producenta integer not null,
Nazwa_produktu varchar(50) not null unique,
Opis_produktu text,
Cena_netto_zakupu decimal(10,2) not null,
Cena_brutto_zakupu decimal(10, 2)  as (Cena_netto_zakupu * (1 + Procent_VAT_sprzedaży/100)) stored,
Cena_netto_sprzedaży decimal(10, 2) not null,
Cena_brutto_sprzedaży decimal(10, 2) as (Cena_netto_sprzedaży * (1 + Procent_VAT_sprzedaży/100)) stored,
Procent_VAT_sprzedaży decimal(5, 2) not null
);

/* 4. Utwórz tabelę „Zamówienia” z kolumnami:

id zamówienia
id klienta
id produktu
Data zamówienia
Do każdej kolumny ustaw odpowiedni „constraint” */

create table Zamowienia (
ID_zamowienia integer primary key auto_increment,
ID_klienta integer not null,
ID_produktu integer not null,
Data_zamowienia date not null
);

/* 5. Utwórz tabelę „Klienci” z kolumnami:
id klienta
imię
nazwisko
adres
Do każdej kolumny ustaw odpowiedni „constraint” */

create table Klienci (
ID_klienta integer primary key auto_increment,
Imie varchar(12) not null,
Nazwisko varchar(20) not null,
adres varchar(100) not null
);


/* 6. Połącz tabele ze sobą za pomocą kluczy obcych:

Produkty – Producenci
Zamówienia – Produkty
Zamówienia - Klienci */

Alter table Produkty
add constraint fk_producenta
foreign key (ID_producenta) references Producenci(ID_producenta);

Alter table Zamowienia
add constraint fk_produktu
foreign key (ID_produktu) references Produkty(ID_produktu),
add constraint fk_klienta
foreign key (ID_klienta) references Klienci(ID_klienta);



/* 7. Każdą tabelę uzupełnij danymi wg:

Tabela „Producenci” – 4 pozycje
Tabela „Produkty” – 20 pozycji
Tabela „Zamówienia” – 10 pozycji
Tabela „Klienci” – 10 pozycji*/


insert into Producenci (Nazwa_producenta, Adres_producenta, NIP_producenta, Data_podpisania_umowy_z_producentem)
values
('Piękna zawsze', 'ul. Nowa 1, Kraków', 6956985891, '2023-12-05'),
('Sporttowy', 'ul. Oleandry 15, Kraków', 8956918547, '2023-12-07'),
('Stara szafa', 'ul. Nowa 22, Wrocław', 3651145874, '2023-12-08'),
('4Fason', 'ul. Polna, Poznań', 5819547841, '2023-12-10');
 select * from Producenci;

insert into Produkty (ID_producenta, Nazwa_produktu, Opis_produktu, Cena_netto_zakupu, Cena_netto_sprzedaży, Procent_VAT_sprzedaży)
values
(1, 'Sukienka Wieczorowa', 'Elegancka sukienka wieczorowa z delikatnego jedwabiu, idealna na specjalne okazje.', 150, 200, 23),
(1, 'Kurtka Skórzana', 'Stylowa kurtka skórzana, doskonała na chłodne dni. Wysoka jakość materiałów.', 300, 400, 23),
(1, 'Eleganckie Spodnie', 'Eleganckie spodnie z wysokiej jakości materiału, idealne do biura.', 120, 160, 23),
(1, 'Szal Kaszmirowy', 'Miękki i ciepły szal kaszmirowy w różnych kolorach.', 80, 100, 23),
(1, 'Marynarka Biznesowa', 'Stylowa marynarka biznesowa, idealna na spotkania i do pracy.', 200, 260, 23),
(2, 'Koszulka Sportowa', 'Wygodna koszulka sportowa wykonana z oddychającego materiału.', 50, 65, 23),
(2, 'Spodenki Fitness', 'Elastyczne spodenki fitness, idealne do intensywnych treningów.', 60, 80, 23),
(2, 'Bluza Treningowa', 'Bluza treningowa z materiału odprowadzającego wilgoć, idealna na chłodne dni.', 90, 115, 23),
(2, 'Buty Biegowe', 'Wygodne buty biegowe z amortyzacją, zapewniające komfort podczas długich biegów.', 180, 230, 23),
(2, 'Opaska Sportowa', 'Opaska sportowa na rękę, idealna do przechowywania drobnych rzeczy podczas treningu.', 25, 30, 23),
(3, 'Klasyczna Bluzka', 'Klasyczna bluzka z eleganckiego materiału, idealna do biura lub na spotkania.', 70, 90, 23),
(3, 'Spódnica Ołówkowa', 'Elegancka spódnica ołówkowa z wysokiej jakości tkaniny, idealna do pracy.', 100, 130, 23),
(3, 'Sukienka Letnia', 'Lekka sukienka letnia w różnych kolorach i wzorach.', 120, 150, 23),
(3, 'Kamizelka Moda', 'Modna kamizelka z ozdobnymi guzikami, idealna na różne okazje.', 85, 110, 23),
(3, 'Płaszczyk Na Wiosnę', 'Stylowy płaszczyk na wiosnę, wykonany z ciepłego materiału.', 150, 200, 23),
(4, 'T-shirt Casual', 'Wygodny t-shirt w różnych kolorach, idealny na co dzień.', 40, 500, 23),
(4, 'Spodnie Dżinsowe', 'Stylowe spodnie dżinsowe w różnych rozmiarach.', 110, 140, 23),
(4, 'Sweter Wełniany', 'Ciepły sweter wełniany, idealny na zimowe dni.', 130, 165, 23),
(4, 'Kurtka Przeciwdeszczowa', 'Kurtka przeciwdeszczowa z wodoodpornym materiałem, idealna na deszczowe dni.', 180, 230, 23),
(4, 'Czapka Zimowa', 'Ciepła czapka zimowa z pomponem, idealna na chłodne dni.', 30, 40, 23),
(1, 'Sukienka sportowa', null, 100, 150, 23);

insert into Zamowienia (ID_klienta, ID_produktu, Data_zamowienia)
values
(1, 1, '2024-01-15'),
(2, 5, '2024-01-16'),
(3, 8, '2024-02-03'),
(4, 10, '2024-02-07'),
(5, 4, '2024-02-10'),
(6, 20, '2024-02-14'),
(7, 15, '2024-02-16'),
(8, 9, '2024-02-20'),
(9, 10, '2024-03-03'),
(10, 16, '2024-03-10'),
(2, 5, '2024-03-15'),
(1, 5, '2024-03-15');

insert into  Klienci (Imie, Nazwisko, Adres)
values
('Jan', 'Kowalski', 'Warszawska 14/1, Warszawa'),
('Anna', 'Nowak', 'Krakowska 2/4, Kraków'),
('Piotr', 'Wiśniewski', 'Wrocławska 1, Wrocław'),
('Maria', 'Kowalczyk', 'Poznańska 5, Poznań'),
('Michał', 'Wójcik', 'Gdańska 14, Gdańsk'),
('Katarzyna', 'Mazur', 'Łódzka 5/25, Łódź'),
('Tomasz', 'Jankowski', 'Katowicka 2/7, Katowice'),
('Ewa', 'Szymańska', 'Szczecińska 14/2, Szczecin'),
('Andrzej', 'Woźniak', 'Lublińska 4, Lublin'),
('Agnieszka', 'Kamińska', 'Bydgoska 5, Bydgoszcz');


-- 8. Wyświetl wszystkie produkty z wszystkimi danymi od producenta który znajduje się na pozycji 1 w tabeli „Producenci”

select p.*, c.*
from Produkty as p left join Producenci as c
on p.ID_producenta = c.ID_producenta
where c.ID_producenta = 1;

-- 9. Posortuj te produkty alfabetycznie po nazwie

select p.*, c.*
from Produkty as p left join Producenci as c
on p.ID_producenta = c.ID_producenta
where c.ID_producenta = 1
order by p.Nazwa_produktu;

-- 10. Wylicz średnią cenę za produktu od producenta z pozycji 1

select round(avg(cena_brutto_sprzedaży), 2) as 'Średnia cena za produkty od producenta 1'
from Produkty 
where Id_producenta = 1;

-- 11. Wyświetl dwie grupy produktów tego producenta:
-- Połowa najtańszych to grupa: „Tanie”
-- Pozostałe to grupa: „Drogie”

with ilosc_prod_prod_1 as (
    select COUNT(Id_produktu) as Ilosc_prod_prod_1
    from Produkty
    where Id_producenta = 1
),
numerowane_produkty as (
    select Id_produktu, 
        row_number() over (order by Cena_brutto_sprzedaży asc) as numer_wiersza
	from Produkty  
    where Id_producenta = 1
)
select 
    p.Id_produktu, 
    p.Nazwa_produktu, 
    p.Opis_produktu, 
    p.Cena_brutto_sprzedaży,
    case
        when np.numer_wiersza <= (select Ilosc_prod_prod_1 from ilosc_prod_prod_1) / 2  then 'Tanie'
        else 'Drogie'
    end as Kategoria
from 
    Produkty as p join numerowane_produkty as np
    on p.Id_produktu = np.Id_produktu;

-- 12. Wyświetl produkty zamówione, wyświetlając tylko ich nazwę
select p.Nazwa_produktu
from Zamowienia as z join Produkty as p 
on z.Id_produktu = p.Id_produktu;

-- 13. Wyświetl wszystkie produkty zamówione – ograniczając wyświetlanie do 5 pozycji

select p.Id_produktu, p.Nazwa_produktu, p.Opis_produktu, p.Cena_brutto_sprzedaży
from Zamowienia as z join Produkty as p 
on z.Id_produktu = p.Id_produktu
order by p.Cena_brutto_sprzedaży desc
limit 5;


-- 14. Policz łączną wartość wszystkich zamówień

select sum(p.Cena_brutto_sprzedaży) as 'Łączną wartość wszystkich zamówień'
from  Produkty as p join zamowienia as z 
on z.Id_produktu = p.Id_produktu;
 

-- 15. Wyświetl wszystkie zamówienia wraz z nazwą produktu sortując je wg daty od najstarszego do najnowszego

select z.ID_zamowienia, p.Nazwa_produktu, z.Data_zamowienia
from Zamowienia as z join Produkty as p 
on z.Id_produktu = p.Id_produktu
order by z.Data_zamowienia ; 

-- 16. Sprawdź czy w tabeli produkty masz uzupełnione wszystkie dane – wyświetl pozycje dla których brakuje danych


select * from Produkty 
where ID_producenta is null 
or Nazwa_produktu is null 
or Opis_produktu is null 
or Cena_netto_zakupu is null 
or Cena_netto_sprzedaży is null 
or Procent_VAT_sprzedaży is null;

-- 17. Wyświetl produkt najczęściej sprzedawany wraz z jego ceną

select p.Id_produktu, p. Nazwa_produktu,  p.Cena_brutto_sprzedaży, 
	(select count(z.Id_produktu) 
    from zamowienia as z where z.Id_produktu = p.Id_produktu) as Ilość
from produkty  as p
order by Ilość desc
limit 1;


-- 18. Znajdź dzień w którym najwięcej zostało złożonych zamówień

select data_zamowienia, count(Id_zamowienia) as 'Ilość zamówień na dzień'
from Zamowienia
group by data_zamowienia
order by count(Id_zamowienia) desc
limit 1;

