--------------------------------------------------------------------------------------------------------------
-- Procedura 1
CREATE OR REPLACE PROCEDURE ObliczIloscSerii (
    pNazwisko IN VARCHAR2,
    iloscSeriaa1 OUT NUMBER,
    iloscSeriaa2 OUT NUMBER
)
    as
    vJumperID NUMBER;
    iloscSeria1 NUMBER := 0;
    iloscSeria2 NUMBER := 0;
BEGIN
    SELECT J.ID INTO vJumperID
    FROM Jumper J
    INNER JOIN Person P ON J.Person = P.ID
    WHERE P.Nazwisko = pNazwisko;

    IF vJumperID IS NOT NULL THEN
        FOR r IN (SELECT Series1 FROM Result WHERE Jumper = vJumperID)
            LOOP
                iloscSeria1 := iloscSeria1 + r.Series1;
            END LOOP;

        FOR r IN (SELECT Series2 FROM Result WHERE Jumper = vJumperID)
            LOOP
                iloscSeria2 := iloscSeria2 + r.Series2;
            END LOOP;

        IF iloscSeria1 is not null THEN
            iloscSeriaa1 := iloscSeria1;
            DBMS_OUTPUT.PUT_LINE('Ilość 1 serii: ' || iloscSeria1);
        END IF;

        IF iloscSeria2 is not null THEN
            iloscSeriaa2 := iloscSeria2;
            DBMS_OUTPUT.PUT_LINE('Ilość 2 serii: ' || iloscSeria2);
        END IF;
    ELSE
        iloscSeriaa1 := NULL;
        iloscSeriaa2 := NULL;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Skoczek o nazwisku ' || pNazwisko || ' nie istnieje.');
END;
--- Wykonanie procedury 1
DECLARE
    vSredniaSeria1 NUMBER;
    vSredniaSeria2 NUMBER;
BEGIN
    ObliczIloscSerii('Kraft', vSredniaSeria1, vSredniaSeria2);
END;
--------------------------------------------------------------------------------------------------------------
-- Procedura 2
CREATE OR REPLACE PROCEDURE SprawdzZwyciestwo (
    pNazwisko IN VARCHAR2,
    pZwyciestwo OUT BOOLEAN
)
    IS
    vJumperID NUMBER;
    vIloscZwyciestw NUMBER := 0;
BEGIN

    BEGIN
        SELECT J.ID INTO vJumperID
        FROM Jumper J
                 INNER JOIN Person P ON J.Person = P.ID
        WHERE P.Nazwisko = pNazwisko;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            pZwyciestwo := FALSE;
            DBMS_OUTPUT.PUT_LINE('Skoczek o nazwisku ' || pNazwisko || ' nie istnieje.');
            RETURN;
    END;

    SELECT COUNT(*)
    INTO vIloscZwyciestw
    FROM Result R
    WHERE R.Jumper = vJumperID AND R.CzyWygral = 'T';

    IF vIloscZwyciestw > 0 THEN
        pZwyciestwo := TRUE;
        DBMS_OUTPUT.PUT_LINE('Skoczek wygrał zawody.');
    ELSE
        pZwyciestwo := FALSE;
        DBMS_OUTPUT.PUT_LINE('Skoczek nie wygrał zawodów.');
    END IF;
END SprawdzZwyciestwo;
--- Wykonanie procedury 2
DECLARE
    vZwyciestwo BOOLEAN;
BEGIN
    SprawdzZwyciestwo('Kraft', vZwyciestwo);
END;
--------------------------------------------------------------------------------------------------------------
-- Wyzwalacz 1
CREATE OR REPLACE TRIGGER CheckJumperParticipation
    BEFORE DELETE or insert or update ON Jumper
    FOR EACH ROW
DECLARE
    competition_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO competition_count
    FROM Jumper_Competition
    WHERE Jumper = :OLD.ID;

    IF deleting and competition_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nie można usunąć skoczka, który bierze udział w konkursie.');
    END IF;

    IF inserting and :NEW.id > 5 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nie można wstawić skoczka o ID większym niż 5.');
    END IF;

    if updating and :new.person = 8  then
        RAISE_APPLICATION_ERROR(-20002, 'Nie można zaktualizowac Skoczka ktorego Person zrrowne jest 8 jest to sedzia!!');
    END IF;
END;
--- Wykonanie wyzwalacz 1
delete from JUMPER where id = 1;
insert into JUMPER (ID, PERSON) values (10,8);
update jumper set Person = 8 where id = 3;
--------------------------------------------------------------------------------------------------------------
-- Wyzwalacz 2
CREATE OR REPLACE TRIGGER SkoczekSzczegoly
    BEFORE INSERT OR UPDATE ON Person
    FOR EACH ROW
DECLARE
    v_person_count INTEGER;
    v_kraj INTEGER;
    v_birthdate DATE;
BEGIN
    SELECT COUNT(*)
    INTO v_person_count
    FROM Person
    WHERE Pesel = :NEW.PESEL;

    IF INSERTING AND v_person_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Osoba o podanym PESEL już istnieje w systemie.');
    END IF;

    SELECT COUNT(*)
    INTO v_kraj
    FROM person
    WHERE KRAJPOCHODENIA = :new.KrajPochodenia;

    IF INSERTING AND v_kraj > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nie można przypisać więcej niż 3 osoby z polski');
    END IF;

    SELECT DataUrodzenia
    INTO v_birthdate
    FROM Person
    WHERE ID = :NEW.ID;

    IF UPDATING AND v_birthdate IS NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'Data urodzenia skoczka jest wymagana.');
    END IF;
END;
--WYkonanie wyzwalacza 2
INSERT INTO Person (ID, Pesel, Imie, Nazwisko,DATAURODZENIA, KrajPochodenia)
VALUES (11, '11111111111', 'Kamil', 'Stoch',TO_DATE('1996-01-10', 'YYYY-MM-DD'),  'Polska');

INSERT INTO Person (ID, Pesel, Imie, Nazwisko,DATAURODZENIA, KrajPochodenia)
VALUES (15, '11011111100', 'Kamil', 'Stoch',TO_DATE('1996-01-10', 'YYYY-MM-DD'),  'Polska');