USE bikelbs4;

-- ÜBUNG 1 --
SELECT Vorname
	  ,Nachname
      ,GebDatum
      ,CASE WHEN Gehalt > 3000.00 THEN BerufsBez ELSE NULL END BerufsBez
FROM personal p;

-- ÜBUNG 2 --
SELECT l.Artnr
	  ,a.Bezeichnung
FROM artikel a
	INNER JOIN lager l ON l.Artnr = a.Anr
WHERE l.Bestand - (l.Mindbest + l.Reserviert) < 3;

-- ÜBUNG 3 --
SELECT a.Bezeichnung
	  ,SUM(t.Anzahl) AS 'Anzahl Einzelteile'
FROM artikel a
	INNER JOIN teilestruktur t ON t.Artnr = a.Anr
GROUP BY a.Bezeichnung;

-- ÜBUNG 4 --
SELECT a.Anr
	  ,a.Bezeichnung
      ,r.Anzahl
FROM artikel a
	INNER JOIN auftragsposten ap ON ap.Artnr = a.Anr
    INNER JOIN reservierung r ON r.Posnr = ap.PosNr
WHERE ap.AuftrNr = 2;

SELECT a.Anr
	  ,a.Bezeichnung
      ,r.Anzahl
FROM artikel a, auftragsposten ap, reservierung r
WHERE ap.Artnr = a.Anr
AND r.Posnr = ap.PosNr
AND ap.AuftrNr = 2;

-- ÜBUNG 5 --
INSERT INTO artikel (Anr, Netto, Mass, Einheit, Typ)
VALUES (100003, 560.34, '26 Zoll', 'ST', 'E');

-- ÜBUNG 6 --
SET SQL_SAFE_UPDATES = 0;

UPDATE personal
SET Gehalt = Gehalt + 100, Beurteilung = Beurteilung + 1
WHERE Beurteilung = 1;

-- ÜBUNG 7 --
SELECT p.Persnr
	  ,p.Vorname
      ,p.Nachname
      ,SUM(ap.Gesamtpreis) AS 'Gesamtumsatzsumme'
FROM personal p
	LEFT OUTER JOIN auftrag auf ON auf.Persnr = p.Persnr
    INNER JOIN auftragsposten ap ON ap.AuftrNr = auf.AuftrNr
GROUP BY p.Persnr, p.Vorname, p.Nachname


