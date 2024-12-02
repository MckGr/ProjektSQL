--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--5 poleceń SELECT z warunkiem WHERE
--Wyswietlenie osob narodowosci Polskiej
SELECT imie, NAZWISKO, KRAJPOCHODENIA
FROM Person
WHERE KRAJPOCHODENIA = 'Polska';
--Wyswietlenie skoczni o rozmiarze wiekszym niz 200
SELECT NAZWASKOCZNI, ROZMIAR, REKORDSKOCZNI
FROM HILL
WHERE ROZMIAR>200;
---Wyswietl osoby urodzone po 1990 roku
SELECT imie, nazwisko, DATAURODZENIA
FROM PERSON
WHERE DATAURODZENIA>to_date('01-JAN-1990','dd-mon-yyyy');
--Wyswietl noty wieksze od 17
SELECT Imie|| ' '||NAZWISKO as sedzia, NOTA
FROM NOTE
join judge on judge.id=note.JUDGE
join person on person.id=judge.PERSON
where nota>17;
--Wyswietlenie osob z 1 z przodu w peselu
SELECT Imie, Nazwisko, PESEL
FROM PERSON
WHERE PESEL LIKE '1%';
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--5 poleceń SELECT ze złączeniem tabel
--Wyswietlenie wszytskich skoczkow
select IMIE|| ' '||NAZWISKO as skoczek, KRAJPOCHODENIA
from PERSON person
join jumper on person.ID=jumper.person;
--Wyswietlenie wszystkich trenerow
select IMIE || ' ' ||NAZWISKO as trener, KRAJPOCHODENIA
from PERSON person
join coach on coach.ID=person.ID;
--Wyswietlenie wszystkich sedziow
select IMIE|| ' '||NAZWISKO as sedzia,KRAJPOCHODENIA
from PERSON person
join judge on person.ID = JUDGE.PERSON;
--Wyswietlenie skoczni jej rozmairu,rekordu a nastepnie sprawdzenie kiedy odbywaja sie zawody na danej skoczni
select NAZWASKOCZNI,ROZMIAR,REKORDSKOCZNI, ODKIEDY,DOKIEDY
from HILL
join COMPETITION on COMPETITION.HILL=hill.ID;
--Wyswietlenie odleglosci a nastepnie  przypisanej do nich noty przez sedziego
select 'Odleglosc to '||odleglosc ||' przypisana do niej nota to '|| nota as NOTADLAODLEGLOSCI
from note
join SERIES on note.ID=series.NOTE;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--5 poleceń SELECT z klauzulą GROUP BY, w tym co najmniej 2 z klauzulą HAVING
--Wyswietlenie skoczkow i lacznej odleglosci we wszystkich konkursach wiekszych od 300
SELECT sum(ODLEGLOSC)as sumaodleglosci, Imie|| ' '|| Nazwisko as skoczek
FROM SERIES
join result on result.ID=series.ID
join JUMPER on jumper.ID=result.JUMPER
join person on person.id=jumper.PERSON
having sum(odleglosc)>300
group by IMIE, NAZWISKO;
--Wypisanie zwyciezow i ile razy wygrali
select count(CZYWYGRAL) as IloscZwyciestw,Imie|| ' '|| Nazwisko as skoczek
FROM SERIES
join result on result.ID=series.ID
join JUMPER on jumper.ID=result.JUMPER
join person on person.id=jumper.PERSON
where CZYWYGRAL = 'T'
GROUP BY IMIE, NAZWISKO;
--Wypisanie sedziego przyznajacego noty ktory przyznal wiecej niz 50 pkt
select imie|| ' ' || nazwisko as sedzia, SUM(nota) as sumaprzyznanychnot
from NOTE
join judge on judge.ID=note.JUDGE
join person on person.id=judge.PERSON
having SUM(nota) > 50
group by imie, nazwisko;
--Wyswietlenie ile razy dany zawodnik pobil rekord skoczni
select count(CZYREKORD) as Ilerazypobilrekordskoczni,Imie|| ' '|| Nazwisko as skoczek
FROM SERIES
join result on result.ID=series.ID
join JUMPER on jumper.ID=result.JUMPER
join person on person.id=jumper.PERSON
where CZYREKORD = 'T'
GROUP BY IMIE, NAZWISKO;
--Wyswietlenie zawodnikow ktorzy przeszli badania sedziowskie
select CZY_PRZESZEDL, imie || ' ' || NAZWISKO as skoczek
from TEST
join EQ on eq.ID=test.EQ
join jumper on jumper.id=eq.JUMPER_ID
join person on person.id=jumper.PERSON
where CZY_PRZESZEDL= 'T'
group by imie,nazwisko, CZY_PRZESZEDL
