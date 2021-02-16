USE bikelbs4;

-- ÜBUNG 1 --
CREATE VIEW Übung1 AS
SELECT a.AuftrNr AS Auftragsnummer
	  ,a.Datum
      ,k.Vorname AS Kunde_Vorname
      ,k.Nachname AS Kunde_Nachname
      ,p.Vorname AS Bearbeiter_Vorname
      ,p.Nachname AS Bearbeiter_Nachname
      ,SUM(a.AuftrNr) AS Summe
FROM auftrag a
	INNER JOIN kunde k ON k.Kundnr = a.Kundnr
    INNER JOIN personal p ON p.Persnr = a.Persnr;

-- Diese View kann nicht für ein UPDATE verwendet werden, da auf mehrere Tabellen zugegriffen wird.


-- ÜBUNG 2 --
CREATE VIEW VPersonal AS
SELECT p.Persnr
	  ,p.Vorname
      ,p.Nachname
      ,p.GebDatum
      ,p.Vorgesetzt
      ,p.BerufsBez
      ,a.Strasse
      ,a.Hausnummer
      ,o.PLZ
      ,o.Ort
FROM personal p
	INNER JOIN adresse a ON a.ID = p.adresse_ID
    INNER JOIN ort o ON o.PLZ = a.ort_PLZ
WHERE p.Vorgesetzt IS NOT NULL;


-- ÜBUNG 3 --
CREATE VIEW VAuftragsposten AS
SELECT ap.PosNr, ap.Anzahl, ap.Gesamtpreis, ap.Gesamtpreis/ap.Anzahl AS Einzelpreis
      ,a.Anr, a.Bezeichnung, a.Netto, a.Farbe, a.Mass, a.Einheit, a.Typ
      ,auf.AuftrNr, auf.Datum
      ,k.Kundnr, k.Vorname AS Kunde_Vorname, k.Nachname AS Kunde_Nachname, k.Sperre
      ,ad.Strasse AS Kunde_Straße, ad.Hausnummer AS Kunde_Hausnummer
      ,o.PLZ AS Kunde_PLZ, o.Ort AS Kunde_Ort
      ,l.Land AS Kunde_Land
      ,p.Persnr, p.Vorname AS Personal_Vorname, p.Nachname AS Personal_Nachname, p.GebDatum, p.Vorgesetzt, p.Gehalt, p.Beurteilung, p.BerufsBez
      ,ad2.Strasse AS Personal_Straße, ad2.Hausnummer AS Personal_Hausnummer
      ,o2.PLZ AS Personal_PLZ, o2.Ort AS Personal_Ort
      ,l2.Land AS Personal_Land
FROM auftragsposten ap
	INNER JOIN artikel a ON a.Anr = ap.Artnr
    INNER JOIN auftrag auf ON auf.AuftrNr = ap.AuftrNr
    INNER JOIN kunde k ON k.Kundnr = auf.AuftrNr
		INNER JOIN adresse ad ON ad.ID = k.adresse_ID
		INNER JOIN ort o ON o.PLZ = ad.ort_PLZ
		INNER JOIN land l ON l.Laendercode = o.land_Laendercode
    INNER JOIN personal p ON p.Persnr = auf.Persnr
        INNER JOIN adresse ad2 ON ad2.ID = p.adresse_ID
		INNER JOIN ort o2 ON o2.PLZ = ad2.ort_PLZ
		INNER JOIN land l2 ON l2.Laendercode = o2.land_Laendercode;

-- Diese Sicht ist (sofern man die Berechtigung dazu hat) mit dem Keyword ALTER änderbar.

