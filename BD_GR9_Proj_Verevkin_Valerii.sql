
-------------------------------------------TWORZENIE TABEL

create table Przedszkola
(
    id_przedszkola number(3) constraint Przedszkola_pk primary key,
    nazwa varchar2(50) default ' ',
    cena_za_miesiac number(5,2) constraint przedszkola_cena_nn not null,
    cena_pozywienia number(4,2) default 0,
    adres varchar2(200) constraint Przedszkola_adres_nn not null,
    nr_akt_dyrektora number(4)
);

create table pracownicy
(
    nr_akt number(4),
    nr_pesel number(11),
    id_przedszkola number(3) constraint Pracownicy_przedszkole_nn not null,
    imie varchar2(50) constraint Pracownicy_imie_nn not null,
    nazwisko varchar2(50) constraint Pracownicy_nazwisko_nn not null,
    stanowisko varchar2(15) constraint Pracownicy_stanowisko_ch check(stanowisko in
                                                                    ('dyrektor','sprzatacz','kucharz','opiekun')),
    data_zatr date default to_date('01.01.2000', 'dd.mm.yyyy'),
    data_zwol date,
    placa number(6,2) default null,
    nip varchar2(12),
    constraints Pracownicy_id_przed_fk foreign key (id_przedszkola) references przedszkola(id_przedszkola) on delete set null
);

create table rodzice
(
    nr_pesel number(11) constraint Rodzice_pk primary key,
    imie varchar2(50) constraint Rodzice_imie_nn not null,
    nazwisko varchar2(50) constraint Rodzice_nazwisko_nn not null,
    data_ur date constraint Rodzice_urodzenie_nn not null
);

create table dzieci
(
    nr_pesel number(11) constraint Dzieci_pk primary key,
    id_przedszkola number(3),
    personalia varchar2(100) constraint Dzieci_pers_nn not null,
    nr_pesel_ojca number(11) default null,
    nr_pesel_matki number(11) default null,
    grupa number(1) constraints dzieci_gr_ch check(grupa between 1 and 4),
    nr_pesel_opiekuna number(11) constraint dzieci_opiekun_nn not null,
    constraint Dzieci_id_przed_fk foreign key (id_przedszkola) references przedszkola(id_przedszkola) on delete set null,
    constraint dzieci_nr_pesel_ojca_fk foreign key(nr_pesel_ojca) references rodzice(nr_pesel) on delete cascade,
    constraint dzieci_nr_pesel_matki_fk foreign key(nr_pesel_matki) references rodzice(nr_pesel) on delete cascade
);

-------------------------------------------MODYFIKACJA TABEL
--PRACOWNICY
alter table pracownicy add constraint Pracownicy_pk primary key (nr_akt, nr_pesel);

alter table pracownicy add constraint Pracownicy_data_zwol_ch check(data_zwol>data_zatr);

alter table pracownicy drop constraint Pracownicy_stanowisko_ch;

alter table pracownicy drop column nip;

alter table pracownicy modify(placa default 2000);

--RODZICE

alter table rodzice drop constraint Rodzice_urodzenie_nn;

alter table rodzice modify data_ur default to_date('01.01.1960','dd.mm.yyyy');

-------------------------------------------TWORZENIE SEKWENCJI DLA WARTOSCI UNIKATOWYCH

create sequence seq_id_przedszkola
start with 100
minvalue 100
maxvalue 999
increment by 1;

create sequence seq_nr_akt
start with 1000
minvalue 1000
maxvalue 9999
increment by 1
cycle;

-------------------------------------------INSERT

insert into przedszkola(id_przedszkola, nazwa, adres, cena_za_miesiac) values(seq_id_przedszkola.nextval, 'Przedszkole sw. Jana Pawla', 'Czestochowa 42-202 al. Jana Pawla II 26/30', 100.00);
insert into przedszkola values(seq_id_przedszkola.nextval, 'Teczowe', 125.50, 0,'Czestochowa 42-218 ul. Dekabrystow 15', null);
insert into przedszkola values(seq_id_przedszkola.nextval, 'Przedszkole prywatne "Katarzyna Pogodna"',95.20, 0, 'Radomsko 97-504 ul. Rolna 48', null);
insert into przedszkola values(seq_id_przedszkola.nextval, 'Przedszkole samorzadowe nr.15', 0, 0, 'Kielce 25-018 ul. Leszczynska 40b', null);
insert into przedszkola values(seq_id_przedszkola.nextval, 'Przedszkole specjalne Jas i Malgosia', 155.80, 0, 'Wroclaw 50-015 ul. Sudecka 2a', null);
insert into przedszkola values(seq_id_przedszkola.nextval, 'Przedszkole Puchatkowa Zaloga', 115.50, 0, 'Czestochowa 42-222 ul. Lwowska 1', null);
insert into przedszkola values(seq_id_przedszkola.nextval, 'Przedszkole publiczne nr.18', 0, 0, 'Czestochowa 42-205 ul. Wreczycka 68', null);
insert into przedszkola values(seq_id_przedszkola.nextval, 'Male skarby', 120.00, 0, 'Jelenia Gora 58-507 ul. Krasickiego 15/28', null);
insert into przedszkola values(seq_id_przedszkola.nextval, 'Przedszkole miejskie nr.1 im. Misia Uszatka', 0, 0, 'Czestochowa 42-211 ul. Szymanowskiego 9', null);
insert into przedszkola values(seq_id_przedszkola.nextval, 'Przedszkole nr.108', 0, 0, 'Wroclaw 53-312 ul. Drukarska 8a', null);

insert into pracownicy values(seq_nr_akt.nextval, 68012412345, 100, 'Justyna', 'Bawor', 'Dyrektor', to_date('02.05.1988', 'dd.mm.yyyy'), null, 4500);
insert into pracownicy values(seq_nr_akt.nextval, 72120308054, 101, 'Kazimierz', 'Stala', 'Dyrektor', to_date('12.03.1995', 'dd.mm.yyyy'), null, 3800.50);
insert into pracownicy values(seq_nr_akt.nextval, 69091587654, 102, 'Mateusz', 'Praski', 'Dyrektor', to_date('08.03.1989', 'dd.mm.yyyy'), null, 4300);
insert into pracownicy values(seq_nr_akt.nextval, 65082365473, 103, 'Jozefa', 'Witkowska', 'Dyrektor', to_date('01.01.1987', 'dd.mm.yyyy'), null, 4700);
insert into pracownicy values(seq_nr_akt.nextval, 71121311325, 104, 'Otylia', 'Wojciechowska', 'Dyrektor', to_date('02.10.1992', 'dd.mm.yyyy'), null, 3750);
insert into pracownicy values(seq_nr_akt.nextval, 68122690876, 105, 'Stefania', 'Gajewska', 'Dyrektor', to_date('18.11.1990', 'dd.mm.yyyy'), null, 3980);
insert into pracownicy values(seq_nr_akt.nextval, 57091584857, 106, 'Daniel', 'Rajewski', 'Dyrektor', to_date('13.09.1978', 'dd.mm.yyyy'), null, 4500);
insert into pracownicy values(seq_nr_akt.nextval, 61121237645, 107, 'Amalia', 'Lis', 'Dyrektor', to_date('03.12.1991', 'dd.mm.yyyy'), null, 3900);
insert into pracownicy values(seq_nr_akt.nextval, 70011788223, 108, 'Mateusz', 'Wypych', 'Dyrektor', to_date('19.05.1995', 'dd.mm.yyyy'), null, 3600);
insert into pracownicy values(seq_nr_akt.nextval, 79031584756, 109, 'Krzysztof', 'Maj', 'Dyrektor', to_date('19.03.2002', 'dd.mm.yyyy'), null, 3400);

insert into pracownicy values(seq_nr_akt.nextval, 77021586961, 100, 'Anita', 'Szymanska', 'Opiekun', to_date('15.02.2003', 'dd.mm.yyyy'), null, 1800.2);
insert into pracownicy values(seq_nr_akt.nextval, 74061842341, 109, 'Aniela', 'Kowalska', 'Opiekun', sysdate-5894, null, 1900.3);
insert into pracownicy values(seq_nr_akt.nextval, 84080636623, 107, 'Jowita', 'Kucharska', 'Opiekun', sysdate-3801, null, 1750.35);
insert into pracownicy values(seq_nr_akt.nextval, 77010721146, 102, 'Adriana', 'Kamienska', 'Opiekun', sysdate-7826, null, 2100);
insert into pracownicy values(seq_nr_akt.nextval, 82010719534, 108, 'Urszula', 'Urbanska', 'Opiekun', sysdate-15, sysdate+124, 1600.5);
insert into pracownicy values(seq_nr_akt.nextval, 98042169294, 105, 'Alisa', 'Walczak', 'Opiekun', sysdate-1200, sysdate-290, 1500);
insert into pracownicy values(seq_nr_akt.nextval, 81042795767, 102, 'Natalia', 'Mroz', 'Opiekun', sysdate-985, null, 1900.4);
insert into pracownicy values(seq_nr_akt.nextval, 90062011979, 107, 'Aneta', 'Lewandowska', 'Opiekun', sysdate-2400, sysdate-1400, 1950.3);
insert into pracownicy values(seq_nr_akt.nextval, 74062531253, 101, 'Urszula', 'Rajewska', 'Opiekun', sysdate-5376, null, 2090);
insert into pracownicy values(seq_nr_akt.nextval, 96092862594, 105, 'Dominika', 'Dziwinska', 'Opiekun', sysdate-1234, null, 1750);
insert into pracownicy values(seq_nr_akt.nextval, 94021542474, 103, 'Karol', 'Sikora', 'Opiekun', sysdate-265, sysdate+74, 1800.55);
insert into pracownicy values(seq_nr_akt.nextval, 98122518518, 104, 'Justyna', 'Paweloszek', 'Opiekun', sysdate-365, sysdate+100, 1800);
insert into pracownicy values(seq_nr_akt.nextval, 79120822845, 100, 'Katarzyna', 'Kubiak', 'Opiekun',sysdate-6587, null, 2250);
insert into pracownicy values(seq_nr_akt.nextval, 86031721316, 106, 'Karolina', 'Sadowska', 'Opiekun', sysdate-4365, null, 2000.05);
insert into pracownicy values(seq_nr_akt.nextval, 89031741566, 101, 'Patryk', 'Samus', 'Opiekun', sysdate-875, null, 1780.9);
insert into pracownicy values(seq_nr_akt.nextval, 76042837757, 109, 'Aleksandra', 'Piekarska', 'Opiekun', sysdate-9999, null, 2400.4);
insert into pracownicy values(seq_nr_akt.nextval, 92061761824, 106, 'Ida', 'Zurek', 'Opiekun', sysdate-165, sysdate+100, 1800);
insert into pracownicy values(seq_nr_akt.nextval, 71111696954, 104, 'Natalia', 'Balcewicz', 'Opiekun', sysdate-7824, null, 2100);
insert into pracownicy values(seq_nr_akt.nextval, 98021979544, 108, 'Katarzyna', 'Chodkiewicz', 'Opiekun', sysdate-366, null, 1600);
insert into pracownicy values(seq_nr_akt.nextval, 89051562141, 103, 'Urszula', 'Kubiak', 'Opiekun', sysdate-5, null, 1750.2);

insert into pracownicy values(seq_nr_akt.nextval, 83110183568, 104, 'Natalia', 'Lis', 'Kucharz', sysdate-5486, null, 1700);
insert into pracownicy values(seq_nr_akt.nextval, 72052588793, 109, 'Katarzyna', 'Mroz', 'Kucharz', sysdate-7654, null, 1840);
insert into pracownicy values(seq_nr_akt.nextval, 64031597812, 101, 'Ida', 'Kubiak', 'Kucharz', sysdate-3547, sysdate-376, 1700);
insert into pracownicy values(seq_nr_akt.nextval, 83040252312, 107, 'Dominika', 'Pawlak', 'Kucharz', sysdate-300, null, 1680);
insert into pracownicy values(seq_nr_akt.nextval, 63030587929, 100, 'Marzanna', 'Czarnecka', 'Kucharz', sysdate-7387, sysdate-90, 1900);
insert into pracownicy values(seq_nr_akt.nextval, 69020441345, 102, 'Idalia', 'Kowalska', 'Kucharz', sysdate-5876, null, 2000.2);
insert into pracownicy values(seq_nr_akt.nextval, 60032563438, 103, 'Matylda', 'Wysocka', 'Kucharz', sysdate-6987, sysdate-1000, 1900);
insert into pracownicy values(seq_nr_akt.nextval, 84112943963, 106, 'Karolina', 'Kowalska', 'Kucharz', sysdate-3000, null, 1800.5);
insert into pracownicy values(seq_nr_akt.nextval, 96102837471, 108, 'Kamila', 'Krzyzanowska', 'Kucharz', sysdate-340, null, 1600);
insert into pracownicy values(seq_nr_akt.nextval, 90082072871, 105, 'Joanna', 'Laskowska', 'Kucharz', sysdate-1500, sysdate-34, 1790.6);

insert into rodzice values(96060937688, 'Angelika', 'Adamska', to_date('09.06.1996', 'dd.mm.yyyy'));
insert into rodzice values(80071698494, 'Jola', 'Rutkowska', to_date('16.07.1980', 'dd.mm.yyyy'));
insert into rodzice values(98021979544, 'Katarzyna', 'Chodkiewicz', to_date('19.02.1998', 'dd.mm.yyyy'));--BEZ PARY
insert into rodzice values(94070821216, 'Pawel', 'Adamski', to_date('08.07.1994', 'dd.mm.yyyy'));
insert into rodzice values(81021513693, 'Adam', 'Rutkowski', to_date('15.02.1981', 'dd.mm.yyyy'));
insert into rodzice values(94092718211, 'Aisha', 'Malinowska', to_date('27.09.1994', 'dd.mm.yyyy'));
insert into rodzice values(90052089196, 'Daniel', 'Malinowski', to_date('20.05.1990', 'dd.mm.yyyy'));
insert into rodzice values(93010267392, 'Amanda', 'Chmielewska', to_date('02.01.1993', 'dd.mm.yyyy'));
insert into rodzice values(93032844289, 'Mateusz', 'Chmielewski', to_date('28.03.1993', 'dd.mm.yyyy'));
insert into rodzice values(98042169294, 'Alisa', 'Walczak', to_date('21.04.1998', 'dd.mm.yyyy'));
insert into rodzice values(92113061579, 'Damian', 'Walczak', to_date('30.11.1992', 'dd.mm.yyyy'));
insert into rodzice values(89031741566, 'Patryk', 'Samus', to_date('17.03.1989', 'dd.mm.yyyy'));
insert into rodzice values(86032235232, 'Magda', 'Samus', to_date('22.03.1986', 'dd.mm.yyyy'));
insert into rodzice values(96062078969, 'Marysia', 'Wojcik', to_date('20.06.1996', 'dd.mm.yyyy'));
insert into rodzice values(94040948426, 'Kamil', 'Wojcik', to_date('09.04.1994', 'dd.mm.yyyy'));
insert into rodzice values(77042814397, 'Alicja', 'Rutkowska', to_date('28.04.1977', 'dd.mm.yyyy'));
insert into rodzice values(76081159645, 'Pawel', 'Rutkowski', to_date('11.08.1976', 'dd.mm.yyyy'));
insert into rodzice values(93032253197, 'Michal', 'Grabowski', to_date('22.03.1993', 'dd.mm.yyyy'));

insert into dzieci values(16232598567, 100, 'Marcin Grabowski', 93032253197, null, 1,79120822845);
insert into dzieci values(16311576452, 108, 'Kamila Chodkiewicz', null, 98021979544, 1, 98021979544);
insert into dzieci values(14240641774, 101, 'Iga Adamska', 94070821216, 96060937688, 3, 74062531253);
insert into dzieci values(15231418551, 101, 'Amelia Adamska', 94070821216, 96060937688, 2, 89031741566);
insert into dzieci values(14231488661, 100, 'Mateusz Rutkowski', 81021513693, 80071698494, 3, 77021586961);
insert into dzieci values(16322689814, 100, 'Jolanta Rutkowska', 81021513693, 80071698494, 1, 79120822845);
insert into dzieci values(14231456286, 100, 'Pawel Rutkowski', 81021513693, 80071698494, 3, 77021586961);
insert into dzieci values(14310138162, 102, 'Bartosz Malinowski', 90052089196, 94092718211, 3, 81042795767);
insert into dzieci values(16220848319, 103, 'Klaudia Malinowska', 90052089196, 94092718211, 1, 89051562141);
insert into dzieci values(15310949862, 104, 'Martyna Chmielewska', 93032844289, 93010267392, 2, 98122518518);
insert into dzieci values(13312764795, 106, 'Krzysztof Chmielewski', 93032844289, 93010267392, 4, 86031721316);
insert into dzieci values(16291398339, 105, 'Pawel Walczak', 92113061579, 98042169294, 1, 96092862594);
insert into dzieci values(14242817278, 101, 'Dawid Samus', 89031741566, 86032235232, 3, 74062531253);
insert into dzieci values(15310592374, 101, 'Gabriel Samus', 89031741566, 86032235232, 2, 89031741566);
insert into dzieci values(16302967624, 101, 'Justyna Samus', 89031741566, 86032235232, 1, 89031741566);
insert into dzieci values(14221699965, 107, 'Mariusz Wojcik', 94040948426, 96062078969, 3, 84080636623);
insert into dzieci values(16251076947, 108, 'Katarzyna Wojcik', 94040948426, 96062078969, 1, 98021979544);
insert into dzieci values(13282644888, 109, 'Damian Rutkowski', 76081159645, 77042814397, 4, 76042837757);
insert into dzieci values(15322749614, 100, 'Matylda Rutkowska', 76081159645, 77042814397, 2, 79120822845);

-------------------------------------------MODYFIKACJA DANYCH

update przedszkola pr1 set nr_akt_dyrektora=
(
    select nr_akt from pracownicy where lower(stanowisko) like 'dyrektor' and id_przedszkola=pr1.id_przedszkola
);

update pracownicy set placa=2250 
where (data_zwol is null or data_zwol>sysdate) and placa<2250;

update przedszkola set cena_pozywienia=10 where id_przedszkola=100;
update przedszkola set cena_pozywienia=10.5 where id_przedszkola=101;
update przedszkola set cena_pozywienia=11.2 where id_przedszkola=102;
update przedszkola set cena_pozywienia=9.5 where id_przedszkola=103;
update przedszkola set cena_pozywienia=12 where id_przedszkola=104;
update przedszkola set cena_pozywienia=11.5 where id_przedszkola=105;
update przedszkola set cena_pozywienia=9 where id_przedszkola=106;
update przedszkola set cena_pozywienia=10.2 where id_przedszkola=107;
update przedszkola set cena_pozywienia=10 where id_przedszkola=108;
update przedszkola set cena_pozywienia=11 where id_przedszkola=109;

commit;

------------------------------------------DODANIE TABELI DZIENNIK
 
create table dziennik as 
(
    select cast(czas as date) dzien, personalia
    from ds.rejestry cross join
    (
        select personalia from dzieci
    )
);

alter table dziennik add obecnosc varchar2(1) constraint Dziennik_obecnosc_ch check(obecnosc in ('X', '-'));
delete from dziennik where extract(year from dzien)<2018;

update dziennik set obecnosc='X';

--DLA ZMIANY OBECNOSCI WPISUJEMY LOSOWE PARAMETRY

update dziennik set obecnosc='-' where (extract(day from dzien) between 16 and 17 or extract(day from dzien) between 1 and 2)
and personalia like '%i_';
update dziennik set obecnosc='-' where (extract(month from dzien)=12 or extract(month from dzien)=5)
and personalia like '%a_';
update dziennik set obecnosc='-' where (extract(month from dzien)=1 and extract(month from dzien)=1)
and personalia like '%ows%' and personalia not like '_____ %';

--KONIEC ZMIANY

-------------------------------------------------------DODANIE TABELI KOSZTY

create table koszty as
(
    select dz.personalia personalia_dziecka, dz.nr_pesel pesel_dziecka, 
    listagg(ro.imie||' '||ro.nazwisko||' Nr. PESEL: '|| ro.nr_pesel, ' | ') 
        within group(order by ro.imie, ro.nazwisko, ro.nr_pesel) RODZICE,
    ((liczba*prz.cena_pozywienia)+(grupa*12*prz.cena_za_miesiac)) koszty
    from rodzice ro join dzieci dz on(ro.nr_pesel=nr_pesel_ojca or ro.nr_pesel=nr_pesel_matki)
    join
    (
        select count(*) liczba, personalia from dziennik
        where obecnosc='X'
        group by personalia
    )t1 on(dz.personalia=t1.personalia)
    join przedszkola prz on(dz.id_przedszkola=prz.id_przedszkola)
    group by dz.personalia, dz.nr_pesel, ((liczba*prz.cena_pozywienia)+(grupa*12*prz.cena_za_miesiac))
);

alter table koszty add constraint koszty_peselD_fk foreign key (pesel_dziecka) references dzieci(nr_pesel) on delete cascade;

select * from przedszkola;
select * from pracownicy;
select * from rodzice;
select * from dzieci;
select * from dziennik order by 1;
select * from koszty;

-------------------------------------------PERSPEKTYWY

--DZIECI, RODZICE KTORYCH PRACUJA W PRZEDSZKOLACH
create or replace view V_dzieci_pracownikow as
select personalia personalia_dziecka, dz.nr_pesel pesel_dziecka, grupa, dz.id_przedszkola 
from pracownicy pr join rodzice ro on(pr.nr_pesel=ro.nr_pesel)
join dzieci dz on(dz.nr_pesel_ojca=ro.nr_pesel or dz.nr_pesel_matki=ro.nr_pesel)
where pr.data_zwol is null or pr.data_zwol>sysdate;

select * from V_dzieci_pracownikow;

--MAMY BEZ MEZA
create or replace view V_single_mothers as
select ro.nr_pesel pesel, ro.imie||' '||ro.nazwisko personalia_rodzica,
dz.nr_pesel pesel_dziecka, dz.personalia personalia_dziecka
from rodzice ro join dzieci dz on(ro.nr_pesel=dz.nr_pesel_matki)
where dz.nr_pesel_ojca is null
order by 2;

select * from v_single_mothers;

--TATY BEZ ZONY
create or replace view V_single_fathers as
select ro.nr_pesel pesel, ro.imie||' '||ro.nazwisko personalia_rodzica,
dz.nr_pesel pesel_dziecka, dz.personalia personalia_dziecka
from rodzice ro join dzieci dz on(ro.nr_pesel=dz.nr_pesel_ojca)
where dz.nr_pesel_matki is null
order by 2;

select * from V_single_fathers;

--------------------------------------------------MODYFIKACJA DANYCH NA PODSTAWNIE PERSPEKTYW

--PODWYZKA DO PENSJI DLA MAM I TAT BEZ PARY

update pracownicy pr set placa=placa*1.5
where pr.nr_pesel in
(
    select pesel from v_single_mothers
)
or pr.nr_pesel in
(
    select pesel from v_single_fathers
);

commit;

--OBNIZENIE KOSZTOW O 30 PROCENT DLA RODZICOW BEZ PAR

update koszty ko set koszty=0.7*koszty
where ko.pesel_dziecka in
(
    select pesel_dziecka from v_single_mothers
) or ko.pesel_dziecka in
(
    select pesel_dziecka from v_single_fathers
);

--OBNIZENIE KOSZTOW O 10 PROCENT DLA PRACOWNIKOW

update koszty ko set koszty=0.9*koszty
where ko.pesel_dziecka in
(
    select pesel_dziecka from v_dzieci_pracownikow
);

-----------------------------------------------------ZAPYTANIA

--ZAPYTANIE, ZWRACAJACE INFORMACJE O OPIEKUNACH(zwykle zapytanie)
select personalia dziecko,' opiekuje si? przez ' komentarz, imie||' '||nazwisko opiekun,
nr_akt, stanowisko, data_zatr, data_zwol
from dzieci dz join pracownicy pr on(dz.nr_pesel_opiekuna=pr.nr_pesel);

--ZAPYTANIE ZWRACA LISTE RODZICOW I ICH DZIECI(zlaczenie)
select imie||' '||nazwisko rodzic, rod.nr_pesel pesel_rodzica, data_ur,
listagg(personalia||' PESEL: '||dz.nr_pesel, ', ') within group(order by personalia) dzieci
from rodzice rod join dzieci dz on(dz.nr_pesel_ojca=rod.nr_pesel or dz.nr_pesel_matki=rod.nr_pesel)
group by imie||' '||nazwisko, rod.nr_pesel, data_ur
order by 3;

--LICZBA IMION ROZPOCZYNAJACYCH SIE NA DANA LITERE W TABELACH DZIECI, RODZICE I PRACOWNICY(podzapytanie)
select litera, sum(l_i) liczba_imion from
(
    select distinct(trim(substr(personalia, 1, 1))) litera, count(personalia) l_i from dzieci
        group by trim(substr(personalia, 1, 1))
    union all
    select distinct(trim(substr(imie, 1, 1))), count(imie) from pracownicy
        group by trim(substr(imie, 1, 1))
    union all
    select distinct(trim(substr(imie, 1, 1))), count(imie) from rodzice
        group by trim(substr(imie, 1, 1))
)
group by litera
order by 2 desc;

--LICZBA NIEOBECNOSCI ZA CALY OKRES DZIENNIKA(operator GROUP BY)
select t1.pers personalia_dziecka, rok, miesiac, liczba liczba_nieobecnosci, 
listagg('NR. PESEL: '||rod.nr_pesel ||',  PERSONALIA: '||rod.imie || ' ' || rod.nazwisko, ' | ') 
    within group(order by rod.nr_pesel, rod.imie, rod.nazwisko) rodzice
from
(
    select personalia pers, extract(year from dzien) rok, to_char(dzien, 'month') miesiac, count(*) liczba from dziennik
    where obecnosc='-'
    group by personalia, extract(year from dzien), to_char(dzien, 'month')
) t1 join dzieci dz on(t1.pers=dz.personalia)
join rodzice rod on(dz.nr_pesel_ojca=rod.nr_pesel or dz.nr_pesel_matki=rod.nr_pesel)
group by t1.pers, rok, miesiac, liczba
order by 2, 4 desc;

--ZAPYTANIE WYPISUJE PRZEDSZKOLA DO KTOREGO CHODZA NIE MNIEJ, NIZ 2 DZIECKA(klauzula HAVING)
select prz.id_przedszkola, nazwa, adres, imie||' '||nazwisko personalia_dyrektora, count(dz.nr_pesel) liczba_dzieci
from przedszkola prz join pracownicy pr on(nr_akt_dyrektora=nr_akt) 
join dzieci dz on(prz.id_przedszkola=dz.id_przedszkola)
group by prz.id_przedszkola, nazwa, adres, imie||' '||nazwisko having count(dz.nr_pesel)>=2;

-------------------------------------------USUWANIE DANYCH


drop table rodzice cascade constraints;
drop table pracownicy cascade constraints;
drop table przedszkola cascade constraints;
drop table dziennik cascade constraints;
drop table dzieci cascade constraints;
drop table koszty cascade constraints;
drop sequence seq_nr_akt;
drop sequence seq_id_przedszkola;
drop view V_dzieci_pracownikow cascade constraints;
drop view v_single_mothers cascade constraints;
drop view v_single_fathers cascade constraints;