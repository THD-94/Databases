-- a) Lag en spørring som henter ut info om alle spillere(spilletid, dato og kode) sorter resultatet etter kode.
select *
from spiller
order by kode;
-- b) lag en spørring som henter ut all informasjon om spill som ble lansert 1.jan.2020
select *
from spill
where lansert >= "2020-01-01";
-- c) Lag en spørring som henter ut informasjon om de ulike spill-kategoriene, og hvor mange spill som finnes i databasen innen hver kategori.alter
select Kategori, COUNT(Tittel) as "Antall Spill"
from Spill
group by Kategori
order by COUNT(Tittel);
-- d) Lag en spørring som henter ut informasjon (spillertid, dato og kode) om spilleren som har vunnet flest ganger, og hvor mange ganger spilleren har spilt.
select Spiller.SpillerId, Dato, Kode, count(Tidspunkt) as AntResultater
from spiller
join Resultat on spiller.SpillerId = Resultat.SpillerId
group by spiller.SpillerId
order by count(Tidspunkt) desc
limit 1;
-- e) lag en spørring som henter ut informasjon om alle spill(tittel, kategori), og gjennomsnittlig score som er oppnådd.
select Tittel as Spill, Kategori, avg(Resultat.Score) as "Gjennomsnitt"
from Spill
join Resultat on Resultat.SpillId = Spill.SpillId
group by Tittel, Kategori
order by avg(Resultat.Score) desc;
-- f) Lag en spørring som henter ut informasjon om alle spill (tittel, kategori), hvilke spiller(kode) som har høyest scorei spillet, når høyeste skår ble satt og hv recorden er.alte
select tittel as Spill, Kategori, kode as Spiller, Tidspunkt, max(score) as "Høyest Score"
from Spiller
join Resultat on resultat.spillerid = spiller.spillerid
join Spill on spill.spillid = resultat.spillid
group by Tittel, Kategori, Kode, Tidspunkt
order by max(score) desc;
-- g) Velg deg ett spill og lag ett view for spillet som viser alle resultater for spillet i synkende rekefølge i følge score
CREATE OR REPLACE VIEW Resultattavle_Pakkmeg as
select Kode, Tidspunkt, Score
from Spill
join Resultat on Spill.SpillId = Resultat.SpillId
join Spiller on resultat.spillerid = spiller.spillerid
where tittel like "Pakk meg"
order by score desc;
select*
from Resultattavle_Pakkmeg;
-- h) legg inn informasjon om ett nytt spill
insert into Spill (SpillId, Tittel, Beskrivelse, Lansert, Kategori)
Values (11, "Ping Pong", "Konkuranse, kondisjon og strategisk", "2022-09-08", "Sports");
select *
from Spill;
insert into utvikler (UtvID, Kontaktinfo, Navn)
Values (9, "billy.betong@boeljeband.no", "Billy Betong");
select *
from utvikler;
insert into SpillUtvikling(UtvID, spillID, Rolle)
Values (5, 11, "Programmerer");
insert into SpillUtvikling(UtvID, spillID, Rolle)
Values (8, 11, "Designer");
insert into SpillUtvikling(UtvID, spillID, Rolle)
Values (9, 11, "Manusforfatter");
select *
from SpillUtvikling;
-- i) Lag en spørring som henter ut navn på spillutvikler, antallresultater.
select utvikler.Navn, count(resultat.SpillId) as "Ant_resultater"
from Utvikler
join SpillUtvikling on Utvikler.UtvId = SpillUtvikling.UtvId
join Resultat on SpillUtvikling.SpillId = Resultat.SpillId
group by utvikler.navn
having count(resultat.SpillId) >30
order by count(resultat.SpillId) desc;
-- j) Endre spill-kategoriene til shooter, platformer og fighter.
 alter table spill
modify column Kategori enum ('Adventure', 'Shooter', 'Platformer', 'fighter', 'RPG', 'Simulation', 'Sports', 'Puzzle', 'Annet');