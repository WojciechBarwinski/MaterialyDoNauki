-- tworzenie bazy danych
create database `MojaWlasnaDB`;
-- wybranie konkretnej bazy danych
use MojaWlasnaDB;
-- utworzenie w wybranej bazie danych tabeli o nazwie Heroes i kolumnach id, name, siblings oraz ustawienie id jako primary key
create table Heroes (id int, name varchar(25), siblings int, constraint heroes_pk primary key (id)); 

-- 1, prostrzy sposób na dodanie rekordu do tabeli, dane muszą być w odpowiedniej kolejności. UWAGA! wada: Jeśli w przyszłości postanowimy dodać do tabeli dodatkową kolumnę np. tytuł powieści, to zapytanie przestanie działać.
insert into Heroes values (1, 'Harry Potter', 0);
-- 2 dłuższy sposób na dodatnie rekordu. Zapytanie działa nawet po dodaniu kolumn
insert into Heroes (id, name, siblings) values (2, 'Ron Weasley', 6);
-- Bład do update imie Luke
insert into Heroes (id, name, siblings) values (3, 'Luck Skywalker', 1); 
insert into Heroes values (4, 'Bilbo Baggins', 0);
insert into Heroes values (5, 'Thor', 1);
insert into Heroes values (6, 'Hermiona', 0);
insert into Heroes values (7, 'Lucyfer', 4);
insert into Heroes (id, name, siblings) values (8, 'Fred Weasley', 6);
insert into Heroes values (9, 'Dupek', 0);



-- wyswietlenie wszystkich danych z tabeli Heroes
select * from Heroes;
-- wyświetla tylko name z tabeli heroes
select name from Heroes;
-- wys. name i siblings z tab. heroes
select name, siblings from Heroes;
-- wys. name i siblings z tab. heroes posegregowane po imionach ASC - rosnoca (to jest domyślne)
select name, siblings from Heroes order by name ASC;
-- wys. name i siblings z tab. heroes posegregowane po imionach DESC - malejąco (to jest domyślne)
select name, siblings from Heroes order by name DESC;
-- wys. tab. heroes posegregowane po id DESC - malejąco (to jest domyślne)
select * from Heroes order by id DESC;

-- OPERATORY
-- wys pełne rekordy z Heroes w których siblings = 1
select * from Heroes where siblings = 1; 
-- wys pełne rekordy z Heroes gdzie id jest parzyste
select * from Heroes where (id % 2) = 0;
-- wybiera rekordy które mają wiecej niz 0 siblings I parzyste ID
select * from Heroes where siblings > 0 and (id % 2) = 0;
-- wybiera rekordy które mają wiecej niz 0 siblings LUB parzyste ID
select * from Heroes where siblings > 0 or (id % 2) = 0;
-- wybiera rekordy które mają 1 LUB 2 siblings
select * from Heroes where siblings in (1,2);
-- wybiera rekordy które OD 1 DO 5 siblings
select * from Heroes where siblings between 1 and 5;
-- wybiera rekordy które NIE SA między 1 a 5 siblings
select * from Heroes where siblings not between 1 and 5;
-- wybiera rekordy w których name zaczyna się na h
select * from Heroes where name like 'H%';
-- wybiera rekordy w których name konczy sie na R
select * from Heroes where name like '%r';

-- FUNKCJE
-- zlicza ilosc rekordów
select count(*) from Heroes;
-- zlicza ilosc rekordów w których sibling ma wartosc 1 LUB 2
select count(*) from Heroes where siblings in (1,2);
-- sumuje ilosc siblings
select sum(siblings) from Heroes;
-- podaje średnia siblings
select avg(siblings) from Heroes;

-- ZAGNIEZDZENIA
-- podaje rekord który ma najwięcej siblings
select * from Heroes where siblings = (select max(siblings) from Heroes);
-- podaje osoby które mają wiecej rodzeństwa niz srednia rodzenstwa
select * from Heroes where siblings > (select avg(siblings) from Heroes);
-- podeje rekordy o min sibling posegregowane wg. imion
select * from Heroes where siblings = (select min(siblings) from Heroes) order by name;
-- sume rodzenstwa osób o nazwisku wesley
select sum(siblings) from Heroes where name like '%Weasley';

-- TWORZENIE NOWEJ TABELI BŁAD nie ma FK!!
create table Pets (id int, name varchar(25), species varchar(25), owners_id int, constraint pets_pk primary key (id)); 
insert into Pets (id, name, species, owners_id) value (1, 'lucek', 'dog', 3);
insert into Pets (id, name, species, owners_id) value (2, 'hedwiga', 'owl', 1);
insert into Pets (id, name, species, owners_id) value (3, 'ayo', 'dog', 5);
insert into Pets (id, name, species, owners_id) value (4, 'sniezka', 'rabbit', 5);
insert into Pets (id, name, species, owners_id) value (5, 'pieszczoch', 'cat', 6);
insert into Pets (id, name, species, owners_id) value (6, 'pampuch', 'cat', 7);
insert into Pets (id, name, species, owners_id) value (7, 'parszywek', 'rat', 2);
insert into Pets (id, name, species, owners_id) value (8, 'ori', 'dog', 6);
insert into Pets (id, name, species) value (9, 'binni', 'bunny');

select * from Pets order by owners_id;


-- ŁACZENIE TABEL
-- Inner Join wyświetla TYLKO wspólne dane
select * from Heroes join Pets on Heroes.id = Pets.owners_id order by Heroes.id;
-- wyswietla wszystkich horoes i ich zwierzaki. w wypadku braku zwierzaka jest null
select * from Heroes left outer join Pets on Heroes.id = Pets.owners_id order by Heroes.id;
-- wyswietla wszystkie zwierzaki oraz ich włascicieli, w wypadku braku właściciela jest null
select * from Heroes right outer join Pets on Heroes.id = Pets.owners_id order by Heroes.id;
-- wyswietla imiona (tylko raz!)  heroes którzy mają psa lub kot 
select distinct Heroes.name from Heroes join Pets on Heroes.id = Pets.owners_id where Pets.species in ('dog', 'cat');

-- ALIASY
-- wykorzystanie aliasów przez AS
select * from Heroes as h join Pets as p on h.id = p.owners_id order by h.id;
-- wykorzystanie aliasów BEZ AS
select * from Heroes h join Pets p on h.id = p.owners_id order by h.id;

-- DATA UPDATE
-- zmienie imienia luck na luke
update Heroes set name = 'Luke' where id = 3;
-- dodac do binniego herosa o imieniu bilbo
update Pets set owners_id = (select id from Heroes where name like 'Bilbo%') where id = 9;

-- DATE DELETE
-- usuwa dupka z bazy
insert into Heroes values (9, 'Dupek', 0);
delete from Heroes where id = 9;
select * from Heroes;

-- HAVING!! uzywane PO całym zapytaniu

-- GROUP BY
select count(name), siblings from Heroes group by siblings order by siblings;

-- INSERT INTO .. SELECT kopionawie pól z 1 rekordu do drugiego


select *, id * siblings as cokolwiek from Heroes; 


-- Tworzy 3 tabele do symulacji relacji many to many
create table Driver (id int primary key, name varchar(25), lastName varchar(25));
create table Cars (id int primary key, mark varchar(25), color varchar(25));
create table Drivers_Cars(driver_id int, cars_id int,
foreign key(driver_id) references Driver(id),
foreign key(cars_id) references Cars(id)) ;
-- uzupelnianie tabeli dla Cars
insert into Cars(id, mark, color) value (1, 'mazda', 'green');
insert into Cars(id, mark, color) value (2, 'puegeot', 'silver');
insert into Cars(id, mark, color) value (3, 'bmw', 'black');
insert into Cars(id, mark, color) value (4, 'audi', 'blue');
insert into Cars(id, mark, color) value (5, 'honda', 'white');
select * from Cars;
-- usupełnianie tabeli dla drivers
insert into Driver(id, name, lastName) value (1, 'Wojtek', 'Barwinski');
insert into Driver(id, name, lastName) value (2, 'Maja', 'Barwinska');
insert into Driver(id, name, lastName) value (3, 'Jan', 'Kowalski');
select * from Driver;
-- uzupełniania tabeli laczacej
insert into Drivers_Cars(driver_id, cars_id) value (1, 1);
insert into Drivers_Cars(driver_id, cars_id) value (1, 2);
insert into Drivers_Cars(driver_id, cars_id) value (1, 3);
insert into Drivers_Cars(driver_id, cars_id) value (2, 1);
insert into Drivers_Cars(driver_id, cars_id) value (2, 4);
insert into Drivers_Cars(driver_id, cars_id) value (3, 1);
insert into Drivers_Cars(driver_id, cars_id) value (3, 2);
insert into Drivers_Cars(driver_id, cars_id) value (2, 5);
select * from Drivers_Cars;
-- wyswietla WSZYSTKO w ustalonej kolejności
select d.id, d.name, d.lastName, dc.driver_id, dc.cars_id, c.mark, c.color, c.id from Drivers_Cars dc
join Driver d on dc.driver_id = d.id
join Cars c on dc.cars_id = c.id
order by d.name;
-- wyswietla marki aut Mai
select c.mark from Drivers_Cars dc
join Driver d on dc.driver_id = d.id
join Cars c on dc.cars_id = c.id
where d.name = 'Maja';

select count(d.name) from Drivers_Cars dc
join Driver d on dc.driver_id = d.id
join Cars c on dc.cars_id = c.id
where c.mark = 'mazda';

select d.name, d.lastName, count(dc.driver_id) as ilosc_aut from Drivers_Cars dc
join Driver d on dc.driver_id = d.id
join Cars c on dc.cars_id = c.id
group by d.name
having ilosc_aut = (select count(dc.cars_id) from Drivers_Cars dc
group by dc.driver_id
limit 1);

select count(dc.cars_id) from Drivers_Cars dc
group by dc.driver_id
limit 1;

-- Union -> wyświetla wartości distinc z 2 lub wiecej tabel po tej samej wybranej wartości
-- SQL SELECT INTO -> kopiuje wartości całej 1 tablicy do 2 tablicy
-- INSERT INTO SELECT -> kopiuje wybrane pola z 1 tablicy do 2 tablicy
-- CREATE PROCEDURE -> tworzy funkcje którą pożniej mogę wykorzytywać po samej nazwie
-- ALTER TABLE -> pozwala na modyfikacje, dodawanie, usuwanie pół w tabeli
-- Constraints ->
		-- NOT NULL - Ensures that a column cannot have a NULL value
		-- UNIQUE - Ensures that all values in a column are different
		-- PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
		-- FOREIGN KEY - Uniquely identifies a row/record in another table
		-- CHECK - Ensures that all values in a column satisfies a specific condition
		-- DEFAULT - Sets a default value for a column when no value is specified
		-- INDEX - Used to create and retrieve data from the database very quickly
-- DROP TABLE -> usuwa tabele
-- TRUNCATE TABLE -> usuwa wartość tabeli 
