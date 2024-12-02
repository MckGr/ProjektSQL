-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-06-04 11:36:46.08

-- tables
-- Table: Coach
CREATE TABLE Coach (
    ID integer  NOT NULL,
    Person integer  NOT NULL,
    CONSTRAINT Coach_pk PRIMARY KEY (ID)
) ;

-- Table: Competition
CREATE TABLE Competition (
    ID integer  NOT NULL,
    OdKiedy date  NOT NULL,
    DoKiedy date  NOT NULL,
    Hill integer  NOT NULL,
    CONSTRAINT Competition_pk PRIMARY KEY (ID)
) ;

-- Table: Eq
CREATE TABLE Eq (
    ID integer  NOT NULL,
    FirmaProdukujaca varchar2(20)  NOT NULL,
    Jumper_ID integer  NOT NULL,
    CONSTRAINT Eq_pk PRIMARY KEY (ID)
) ;

-- Table: Hill
CREATE TABLE Hill (
    ID integer  NOT NULL,
    NazwaSkoczni varchar2(20)  NOT NULL,
    Kraj varchar2(20)  NOT NULL,
    Rozmiar integer  NOT NULL,
    RekordSkoczni integer  NOT NULL,
    CONSTRAINT Hill_pk PRIMARY KEY (ID)
) ;

-- Table: Judge
CREATE TABLE Judge (
    ID integer  NOT NULL,
    Person integer  NOT NULL,
    CONSTRAINT Judge_pk PRIMARY KEY (ID)
) ;

-- Table: Jumper
CREATE TABLE Jumper (
    ID integer  NOT NULL,
    Person integer  NOT NULL,
    CONSTRAINT Jumper_pk PRIMARY KEY (ID)
) ;

-- Table: Jumper_Coach
CREATE TABLE Jumper_Coach (
    Coach integer  NOT NULL,
    Jumper integer  NOT NULL,
    CONSTRAINT Jumper_Coach_pk PRIMARY KEY (Coach,Jumper)
) ;

-- Table: Jumper_Competition
CREATE TABLE Jumper_Competition (
    Jumper integer  NOT NULL,
    Competition integer  NOT NULL,
    CONSTRAINT Jumper_Competition_pk PRIMARY KEY (Jumper,Competition)
) ;

-- Table: Note
CREATE TABLE Note (
    ID integer  NOT NULL,
    Nota integer  NOT NULL,
    Judge integer  NOT NULL,
    CONSTRAINT Note_pk PRIMARY KEY (ID)
) ;

-- Table: Person
CREATE TABLE Person (
    ID integer  NOT NULL,
    Pesel char(11)  NOT NULL,
    Imie varchar2(20)  NOT NULL,
    Nazwisko varchar2(20)  NOT NULL,
    DataUrodzenia date  NOT NULL,
    KrajPochodenia varchar2(20)  NOT NULL,
    CONSTRAINT Person_pk PRIMARY KEY (ID)
) ;

-- Table: Result
CREATE TABLE Result (
    ID integer  NOT NULL,
    CzyRekord char(1)  NOT NULL,
    CzyWygral char(1)  NOT NULL,
    Competition integer  NOT NULL,
    Series1 integer  NOT NULL,
    Series2 integer  NOT NULL,
    Jumper integer NOT NULL,
    CONSTRAINT Result_pk PRIMARY KEY (ID)
) ;

-- Table: Series
CREATE TABLE Series (
    ID integer  NOT NULL,
    Odleglosc integer  NOT NULL,
    Note integer  NOT NULL,
    CONSTRAINT Series_pk PRIMARY KEY (ID)
) ;

-- Table: Test
CREATE TABLE Test (
    ID integer  NOT NULL,
    Czy_Przeszedl char(1)  NOT NULL,
    Judge integer  NOT NULL,
    Eq integer  NOT NULL,
    CONSTRAINT Test_pk PRIMARY KEY (ID)
) ;

-- foreign keys
-- Reference: Coach_Person (table: Coach)
ALTER TABLE Coach ADD CONSTRAINT Coach_Person
    FOREIGN KEY (Person)
    REFERENCES Person (ID);

-- Reference: Competition_Hill (table: Competition)
ALTER TABLE Competition ADD CONSTRAINT Competition_Hill
    FOREIGN KEY (Hill)
    REFERENCES Hill (ID);

-- Reference: Eq_Jumper (table: Eq)
ALTER TABLE Eq ADD CONSTRAINT Eq_Jumper
    FOREIGN KEY (Jumper_ID)
    REFERENCES Jumper (ID);

-- Reference: Judge_Person (table: Judge)
ALTER TABLE Judge ADD CONSTRAINT Judge_Person
    FOREIGN KEY (Person)
    REFERENCES Person (ID);

-- Reference: Jumper_Coach_Coach (table: Jumper_Coach)
ALTER TABLE Jumper_Coach ADD CONSTRAINT Jumper_Coach_Coach
    FOREIGN KEY (Coach)
    REFERENCES Coach (ID);

-- Reference: Jumper_Coach_Jumper (table: Jumper_Coach)
ALTER TABLE Jumper_Coach ADD CONSTRAINT Jumper_Coach_Jumper
    FOREIGN KEY (Jumper)
    REFERENCES Jumper (ID);

-- Reference: Jumper_Competition_Competition (table: Jumper_Competition)
ALTER TABLE Jumper_Competition ADD CONSTRAINT Jumper_Competition_Competition
    FOREIGN KEY (Competition)
    REFERENCES Competition (ID);

-- Reference: Jumper_Competition_Jumper (table: Jumper_Competition)
ALTER TABLE Jumper_Competition ADD CONSTRAINT Jumper_Competition_Jumper
    FOREIGN KEY (Jumper)
    REFERENCES Jumper (ID);

-- Reference: Jumper_Person (table: Jumper)
ALTER TABLE Jumper ADD CONSTRAINT Jumper_Person
    FOREIGN KEY (Person)
    REFERENCES Person (ID);

-- Reference: Note_Judge (table: Note)
ALTER TABLE Note ADD CONSTRAINT Note_Judge
    FOREIGN KEY (Judge)
    REFERENCES Judge (ID);

-- Reference: Result_Competition (table: Result)
ALTER TABLE Result ADD CONSTRAINT Result_Competition
    FOREIGN KEY (Competition)
    REFERENCES Competition (ID);

-- Reference: Result_Series1 (table: Result)
ALTER TABLE Result ADD CONSTRAINT Result_Series1
    FOREIGN KEY (Series2)
    REFERENCES Series (ID);

-- Reference: Result_Series2 (table: Result)
ALTER TABLE Result ADD CONSTRAINT Result_Series2
    FOREIGN KEY (Series1)
    REFERENCES Series (ID);

ALTER TABLE RESULT add constraint Result_Jumper
    FOREIGN KEY (JUMPER)
    references JUMPER (ID);

-- Reference: Series_Note (table: Series)
ALTER TABLE Series ADD CONSTRAINT Series_Note
    FOREIGN KEY (Note)
    REFERENCES Note (ID);

-- Reference: Test_Eq (table: Test)
ALTER TABLE Test ADD CONSTRAINT Test_Eq
    FOREIGN KEY (Eq)
    REFERENCES Eq (ID);

-- Reference: Test_Judge (table: Test)
ALTER TABLE Test ADD CONSTRAINT Test_Judge
    FOREIGN KEY (Judge)
    REFERENCES Judge (ID);


INSERT ALL
into Person (ID, Pesel, Imie, Nazwisko, DataUrodzenia, KrajPochodenia) values (1,'11111111111','Kamil','Stoch',to_date('10-JAN-1996','dd-mon-yyyy'),'Polska')
into Person (ID, Pesel, Imie, Nazwisko, DataUrodzenia, KrajPochodenia) values (2,'12111111121','Stefan','Kraft',to_date('12-OCT-1992','dd-mon-yyyy'),'Austria')
into Person (ID, Pesel, Imie, Nazwisko, DataUrodzenia, KrajPochodenia) values (3,'11311311111','Robert','Johanson',to_date('15-FEB-1989','dd-mon-yyyy'),'Norwegia')
into Person (ID, Pesel, Imie, Nazwisko, DataUrodzenia, KrajPochodenia) values (4,'41111114111','Peter','Prevc',to_date('22-DEC-1986','dd-mon-yyyy'),'Słowenia')
into Person (ID, Pesel, Imie, Nazwisko, DataUrodzenia, KrajPochodenia) values (5,'11511115111','Anders','Fannemel',to_date('09-JAN-1992','dd-mon-yyyy'),'Norwegia')
into Person (ID, Pesel, Imie, Nazwisko, DataUrodzenia, KrajPochodenia) values (6,'11116111111','Thomas','Thurnbichler',to_date('10-JAN-1971','dd-mon-yyyy'),'Austria')
into Person (ID, Pesel, Imie, Nazwisko, DataUrodzenia, KrajPochodenia) values (7,'11111711111','Marc','Nolke',to_date('14-JAN-1973','dd-mon-yyyy'),'Niemcy')
into Person (ID, Pesel, Imie, Nazwisko, DataUrodzenia, KrajPochodenia) values (8,'11111181111','Marek','Pilch',to_date('10-FEB-1960','dd-mon-yyyy'),'Polska')
into Person (ID, Pesel, Imie, Nazwisko, DataUrodzenia, KrajPochodenia) values (9,'11111119111','Fabian','Malik',to_date('11-FEB-1961','dd-mon-yyyy'),'Polska')
select 1 from dual;

INSERT ALL
into JUMPER (ID, Person) values (1,1)
into JUMPER (ID, Person) values (2,2)
into JUMPER (ID, Person) values (3,3)
into JUMPER (ID, Person) values (4,4)
into JUMPER (ID, Person) values (5,5)
select 1 from dual;

INSERT ALL
into Coach (ID, Person) values (6,6)
into Coach (ID, Person) values (7,7)
select 1 from dual;

INSERT ALL
into Judge (ID, Person) values (8,8)
into Judge (ID, Person) values (9,9)
select 1 from dual;

Insert all
into JUMPER_COACH (Coach, Jumper) values (6,3)
into JUMPER_COACH (Coach, Jumper) values (6,5)
into JUMPER_COACH (Coach, Jumper) values (7,1)
into JUMPER_COACH (Coach, Jumper) values (7,2)
into JUMPER_COACH (Coach, Jumper) values (6,4)
into JUMPER_COACH (Coach, Jumper) values (7,4)
select 1 from dual;

insert all
into hill (ID, NazwaSkoczni, Kraj, Rozmiar, RekordSkoczni) values (1,'Vikersund','Norwegia',240,253)
into hill (ID, NazwaSkoczni, Kraj, Rozmiar, RekordSkoczni) values (2,'Wisla','Polska',134,139)
into hill (ID, NazwaSkoczni, Kraj, Rozmiar, RekordSkoczni) values (3,'Planica','Slowenia',240,252)
select 1 from dual;

insert all
into COMPETITION (ID, OdKiedy, DoKiedy, Hill) values (1,to_date('10-JAN-2016','dd-mon-yyyy'),to_date('11-JAN-2016','dd-mon-yyyy'),1)
into COMPETITION (ID, OdKiedy, DoKiedy, Hill) values (2,to_date('15-JAN-2016','dd-mon-yyyy'),to_date('16-JAN-2016','dd-mon-yyyy'),2)
into COMPETITION (ID, OdKiedy, DoKiedy, Hill) values (3,to_date('01-FEB-2016','dd-mon-yyyy'),to_date('02-FEB-2016','dd-mon-yyyy'),3)
select 1 from dual;

INSERT ALL
into JUMPER_COMPETITION (Jumper, Competition) values (1,1)
into JUMPER_COMPETITION (Jumper, Competition) values (2,1)
into JUMPER_COMPETITION (Jumper, Competition) values (3,1)
into JUMPER_COMPETITION (Jumper, Competition) values (4,1)
into JUMPER_COMPETITION (Jumper, Competition) values (5,1)
into JUMPER_COMPETITION (Jumper, Competition) values (1,2)
into JUMPER_COMPETITION (Jumper, Competition) values (2,2)
into JUMPER_COMPETITION (Jumper, Competition) values (3,2)
into JUMPER_COMPETITION (Jumper, Competition) values (4,2)
into JUMPER_COMPETITION (Jumper, Competition) values (2,3)
into JUMPER_COMPETITION (Jumper, Competition) values (3,3)
into JUMPER_COMPETITION (Jumper, Competition) values (5,3)
select 1 from dual;

insert all
into Eq (ID, FirmaProdukujaca, Jumper_ID) values (1,'Fischer',1)
into Eq (ID, FirmaProdukujaca, Jumper_ID) values (2,'Atomic',2)
into Eq (ID, FirmaProdukujaca, Jumper_ID) values (3,'Head',3)
into Eq (ID, FirmaProdukujaca, Jumper_ID) values (4,'Volkl',4)
into Eq (ID, FirmaProdukujaca, Jumper_ID) values (5,'Blizzard',5)
select 1 from dual;

insert all
into TEST (ID, Czy_Przeszedl, Judge, Eq) VALUES (1,'T',8,1)
into TEST (ID, Czy_Przeszedl, Judge, Eq) VALUES (2,'T',8,2)
into TEST (ID, Czy_Przeszedl, Judge, Eq) VALUES (3,'T',8,3)
into TEST (ID, Czy_Przeszedl, Judge, Eq) VALUES (4,'T',8,4)
into TEST (ID, Czy_Przeszedl, Judge, Eq) VALUES (5,'T',8,5)
select 1 from dual;

insert all
into NOTE (ID, Nota, Judge) values (1,14,9)
into NOTE (ID, Nota, Judge) values (2,15,9)
into NOTE (ID, Nota, Judge) values (3,16,9)
into NOTE (ID, Nota, Judge) values (4,17,9)
into NOTE (ID, Nota, Judge) values (5,18,9)
into NOTE (ID, Nota, Judge) values (6,19,9)
select 1 from dual;

insert all
into series (ID, Odleglosc, Note) values (1,250,1)
into series (ID, Odleglosc, Note) values (2,120,4)
into series (ID, Odleglosc, Note) values (3,230,5)
into series (ID, Odleglosc, Note) values (4,213,6)
into series (ID, Odleglosc, Note) values (5,114,1)
into series (ID, Odleglosc, Note) values (6,97,2)
into series (ID, Odleglosc, Note) values (7,251,3)
into series (ID, Odleglosc, Note) values (8,255,4)
into series (ID, Odleglosc, Note) values (9,158,5)
into series (ID, Odleglosc, Note) values (10,149,6)
select 1 from dual;

INSERT all
into RESULT (ID, CzyRekord, CzyWygral, Competition, Series1, Series2, Jumper) values (1,'T','T',1,8,7,1)
into RESULT (ID, CzyRekord, CzyWygral, Competition, Series1, Series2, Jumper) values (2,'F','F',1,1,2,2)
into RESULT (ID, CzyRekord, CzyWygral, Competition, Series1, Series2, Jumper) values (3,'F','F',1,3,9,3)
into RESULT (ID, CzyRekord, CzyWygral, Competition, Series1, Series2, Jumper) values (4,'F','F',1,10,2,4)
into RESULT (ID, CzyRekord, CzyWygral, Competition, Series1, Series2, Jumper) values (5,'F','F',1,5,6,5)
into RESULT (ID, CzyRekord, CzyWygral, Competition, Series1, Series2, Jumper) values (6,'T','F',2,10,6,1)
into RESULT (ID, CzyRekord, CzyWygral, Competition, Series1, Series2, Jumper) values (7,'F','F',2,5,9,2)
into RESULT (ID, CzyRekord, CzyWygral, Competition, Series1, Series2, Jumper) values (8,'F','F',2,5,6,3)
into RESULT (ID, CzyRekord, CzyWygral, Competition, Series1, Series2, Jumper) values (9,'T','T',2,10,9,4)
select 1 from dual;

commit;
-- End of file.

