/*Oppretter databasen og tar den i bruk*/

DROP SCHEMA IF EXISTS IlMusicante;
CREATE SCHEMA IlMusicante;
USE IlMusicante;

/*Sletter tabeller om disse eksisterer (hensyn til rekkefølge)*/

DROP TABLE IF EXISTS Ordrelinje;
DROP TABLE IF EXISTS TidReparasjon;
DROP TABLE IF EXISTS Ordre;
DROP TABLE IF EXISTS Reparasjon;
DROP TABLE IF EXISTS Kunde;
DROP TABLE IF EXISTS Ansatt;
DROP TABLE IF EXISTS Poststed;
DROP TABLE IF EXISTS Vare;

/*Oppretter tabeller i riktig rekkefølge*/

CREATE TABLE Vare (
   VareNr INT(6) UNIQUE NOT NULL,
   Modell VARCHAR(30) NOT NULL,
   Produsent VARCHAR(20) NOT NULL,
   Kategori VARCHAR(50) NOT NULL,
   Pris VARCHAR(10) NOT NULL,
   AntallButikk INT NOT NULL,
   PRIMARY KEY (VareNr)
);


CREATE TABLE Poststed (
   PostNr CHAR(4) NOT NULL,
   Poststed VARCHAR(30) NOT NULL,
   PRIMARY KEY (PostNr)
);

CREATE TABLE Ansatt (
   AnsattNr INT(2) UNIQUE NOT NULL AUTO_INCREMENT,
   Navn VARCHAR(30) NOT NULL,
   Adresse VARCHAR(50) NOT NULL,
   Loenn INT(6) NOT NULL,
   PostNr CHAR(4) NOT NULL,
   PRIMARY KEY (AnsattNr),
   FOREIGN KEY (PostNr) REFERENCES Poststed(PostNr)
);

CREATE TABLE Kunde (
   KundeNr INT(6) NOT NULL AUTO_INCREMENT,
   Navn VARCHAR(30) NOT NULL,
   Adresse VARCHAR(50) NOT NULL,
   PostNr CHAR(4) NOT NULL,
   Telefon INT(8) NOT NULL,
   Email VARCHAR(30) NOT NULL,
   PRIMARY KEY (KundeNr),
   FOREIGN KEY (PostNr) REFERENCES Poststed(PostNr)
);


CREATE TABLE Reparasjon (
   RepID INT(5) NOT NULL AUTO_INCREMENT,
   KundeNr INT(6) NOT NULL,
   RepBestilltDato DATE NOT NULL,
   RepType VARCHAR(20) NOT NULL,
   PRIMARY KEY (RepID),
   FOREIGN KEY (KundeNr) REFERENCES Kunde(KundeNr)

);


CREATE TABLE Ordre (
   OrdreNr INT(5) NOT NULL,
   KundeNr INT(6) NOT NULL,
   OrdreDato DATE NOT NULL,
   BetaltDato DATE NOT NULL,
   PRIMARY KEY (OrdreNr),
   FOREIGN KEY (KundeNr) REFERENCES Kunde(KundeNr)
);


CREATE TABLE TidReparasjon (
   AnsattNr INT(2) NOT NULL,
   RepID INT(5) NOT NULL,
   Timer INT(3),
   PRIMARY KEY (AnsattNr, RepID),
   FOREIGN KEY (AnsattNr) REFERENCES Ansatt(AnsattNr),
   FOREIGN KEY (RepID) REFERENCES Reparasjon(RepID)
);


CREATE TABLE Ordrelinje (
   VareNr INT(6) NOT NULL,
   OrdreNr INT(5) NOT NULL,
   PrisPerEnhet INT(6) NOT NULL,
   Antall INT(3) NOT NULL,
   PRIMARY KEY (VareNr, OrdreNr),
   FOREIGN KEY (VareNr) REFERENCES Vare(VareNr),
   FOREIGN KEY (OrdreNr) REFERENCES Ordre(OrdreNr)
);


/*Setter inn data i hver tabell*/

INSERT INTO Vare (VareNr, Modell, Produsent, Kategori, Pris, AntallButikk)
VALUES

(453856, "Les Paul", "Gibson", "Elektrisk", "13900", "2"),
(576489, "Digital", "Gibson", "Elektrisk", "14900", "6"),
(453426, "Dark Fire", "Gibson", "Elektrisk", "15699", "4"),
(485760, "EDS-1275", "Gibson", "Elektrisk", "20990", "2"),
(105836, "Explorer", "Gibson", "Elektrisk", "21000", "7"),
(364583, "Firebird", "Gibson", "Elektrisk", "15000", "8"),
(347593, "Flying V", "Gibson", "Elektrisk", "30000", "4"),
(465836, "Duo-Sonic", "Fender", "Elektrisk", "13900", "3"),
(784936, "Jaguar", "Fender", "Elektrisk", "14900", "7"),
(485672, "Jazzmaster", "Fender", "Elektrisk", "15699", "12"),
(198354, "Mustang", "Fender", "Elektrisk", "20990", "5"),
(296843, "Stratocaster", "Fender", "Elektrisk", "21000", "12"),
(385760, "Telecaster", "Fender", "Elektrisk", "15000", "4"),
(395830, "Rg", "Ibanez", "Elektrisk", "30000", "2"),
(294058, "Jem", "Ibanez", "Elektrisk", "13900", "7"),
(264850, "X", "Ibanez", "Elektrisk", "14900", "8"),
(384950, "DN", "Ibanez", "Elektrisk", "15699", "4"),
(465879, "FR", "Ibanez", "Elektrisk", "20990", "3"),
(142869, "CORE", "PRS", "Elektrisk", "21000", "7"),
(364857, "SE", "PRS", "Elektrisk", "15000", "12"),
(354758, "S2", "PRS", "Elektrisk", "30000", "4");

INSERT INTO Poststed (PostNr, Poststed)
VALUES

("0150", "OSLO"),
("0151", "OSLO"),
("0152", "OSLO"),
("0153", "OSLO"),
("0154", "OSLO"),
("0160", "OSLO"),
("0171", "OSLO"),
("0169", "OSLO"),
("5013", "BERGEN"),
("5032", "BERGEN"),
("5037", "BERGEN"),
("7019", "TRONDHEIM"),
("7020", "TRONDHEIM"),
("7027", "TRONDHEIM"),
("7029", "TRONDHEIM");

INSERT INTO Ansatt (Navn, Adresse, Loenn, PostNr)
VALUES

("Per Gitarmeister", "gitarmakergata 5", 400000, "0169"),
("Olav Bakke Tomter", "bassensgate 7", 999999, "0160"),
("August Gibsonson", "akustiskgate 10", 300000, "0152"),
("Fredrick Fendersen", "trommegate 23", 450000, "7020"),
("Fred Merkurius", "trompetveien 57", 250000, "5032"),
("Erik Klappten", "legendegaten 1", 800000, "0153");

INSERT INTO Kunde (Navn, Adresse, PostNr, Telefon, Email)
VALUES

("Petter Hakkemaker", "Hattegata 6", "0152", 36478555, "petterH@gmail.com"),
("Julius Augustus", "romagata 8", "0151", 38485599, "theJulius@BCmail.com"),
("Max Mekker", "stasjongata 1", "0152", 12345678, "maxern@nsb.no"),
("Erna Solberg", "politikergata 1", "0150", 11111111, "erna@politiko.no"),
("Arne Treholt", "russergata 1", "0160", 00000000, "arne@sovietmail.ru"),
("Bill Clinton", "amerikagata 7", "0171", 55510555, "olpresident@hotmail.com"),
("Jens Augustus", "hotelgaten 22", "0150", 37947665, "jensern@cesarmail.no"),
("Kim Larsen", "gitarveien 1", "7027", 59960004, "kimmy@dkmail.dk"),
("Jimi Hendrix", "legendeveien 10", "0169", 55511111, "legend@rockmail.com"),
("Magnus Karlsen", "brettspillveien 1", "0169", 87654321, "hatertape@spillmail.no");

INSERT INTO Reparasjon (KundeNr, RepBestilltDato, RepType)
VALUES

(4, "2017-04-25", "Garanti"),
(6, "2017-06-02", "Overhaling"),
(6, "2018-07-12", "Garanti"),
(2, "2017-05-07", "Overhaling"),
(9, "2017-05-07", "Oppgradering"),
(8, "2018-12-11", "Overhaling"),
(2, "2018-12-11", "Garanti"),
(2, "2017-11-16", "Oppgradering"),
(7, "2018-12-11", "Garanti"),
(1, "2017-01-13", "Garanti"),
(1, "2017-09-13", "Overhaling"),
(3, "2017-06-06", "Oppgradering"),
(5, "2018-12-11", "Overhaling"),
(7, "2018-12-11", "Garanti"),
(7, "2016-08-23", "Oppgradering");

INSERT INTO Ordre (OrdreNr, KundeNr, OrdreDato, BetaltDato)
VALUES

(81229, 2, "2016-02-17", "2018-10-02"),
(91718, 2, "2016-02-24", "2018-10-08"),
(49675, 7, "2016-05-06", "2018-10-10"),
(98973, 6, "2016-10-07", "2018-10-15"),
(89620, 7, "2016-11-01", "2018-10-18"),
(45703, 2, "2016-12-14", "2018-10-26"),
(82974, 7, "2017-03-07", "2018-10-29"),
(59959, 8, "2017-08-10", "2018-10-31"),
(70593, 1, "2017-08-29", "2018-11-13"),
(38075, 9, "2017-10-05", "2018-11-19"),
(29903, 9, "2017-12-05", "2018-11-23"),
(45862, 3, "2018-01-25", "2018-11-26"),
(55982, 4, "2018-05-10", "2018-12-06"),
(34978, 3, "2018-06-11", "2018-12-12"),
(15509, 7, "2018-06-12", "2018-12-13"),
(46273, 6, "2018-07-31", "2018-12-18"),
(26727, 6, "2018-08-30", "2018-12-21"),
(58174, 7, "2018-09-17", "2018-12-24"),
(96443, 9, "2018-09-26", "2018-12-26"),
(68067, 7, "2018-10-16", "2018-12-31"),
(13123, 6, "2016-02-02", "2018-10-01"),
(76243, 1, "2016-04-08", "2018-10-04"),
(90752, 2, "2016-05-11", "2018-10-11"),
(98520, 4, "2016-08-26", "2018-10-12"),
(76769, 2, "2016-09-22", "2018-10-15"),
(27573, 7, "2016-11-18", "2018-10-25"),
(14289, 4, "2017-03-13", "2018-10-26"),
(59850, 4, "2017-04-19", "2018-10-30"),
(66886, 2, "2017-08-08", "2018-10-31"),
(36335, 9, "2017-08-14", "2018-11-01"),
(29332, 2, "2017-09-25", "2018-11-06"),
(52013, 3, "2017-10-17", "2018-11-13"),
(49307, 5, "2018-02-26", "2018-11-14"),
(60488, 6, "2018-03-02", "2018-11-22"),
(65304, 6, "2018-03-06", "2018-12-03"),
(26663, 4, "2018-03-08", "2018-12-05"),
(61411, 7, "2018-06-05", "2018-12-14"),
(53994, 8, "2018-07-02", "2018-12-25"),
(87196, 2, "2018-10-18", "2018-12-27"),
(34570, 6, "2018-12-10", "2018-12-31");

INSERT INTO TidReparasjon (AnsattNr, RepID, Timer)
VALUES

(1, 1, 1),
(2, 2, 4),
(3, 3, 3),
(4, 4, 1),
(5, 5, 2),
(6, 6, 5),
(1, 7, 3),
(2, 8, 4),
(3, 9, 3),
(4, 10, 2),
(5, 11, 2),
(6, 12, 1),
(2, 13, 1),
(4, 14, 3),
(3, 15, 1);

INSERT INTO Ordrelinje (VareNr, OrdreNr, PrisPerEnhet, Antall)
VALUES

(453856, 81229, 13900, 1),
(576489, 91718, 14900, 1),
(453426, 49675, 15699, 1),
(485760, 98973, 20990, 1),
(105836, 89620, 21000, 1),
(364583, 45703, 15000, 1),
(347593, 82974, 30000, 1),
(465836, 59959, 13900, 2),
(784936, 70593, 14900, 1),
(485672, 38075, 15699, 1),
(198354, 29903, 20990, 1),
(296843, 89620, 21000, 1),
(385760, 55982, 15000, 1),
(395830, 34978, 30000, 1),
(294058, 38075, 13900, 1),
(264850, 46273, 14900, 1),
(384950, 26727, 15699, 1),
(465879, 58174, 20990, 1),
(142869, 96443, 21000, 2),
(364857, 68067, 15000, 2),
(354758, 13123, 30000, 1),
(784936, 76243, 14900, 1),
(485672, 90752, 15699, 1),
(198354, 98520, 20990, 1),
(296843, 76769, 21000, 1),
(385760, 27573, 15000, 1),
(294058, 14289, 13900, 3),
(264850, 59850, 14900, 1),
(384950, 66886, 15699, 1),
(465879, 36335, 20990, 1),
(142869, 29332, 21000, 1),
(347593, 52013, 30000, 1),
(465836, 49307, 13900, 2),
(784936, 60488, 14900, 2),
(485672, 65304, 15699, 1),
(198354, 26663, 20990, 1),
(296843, 61411, 21000, 1),
(385760, 53994, 15000, 1),
(264850, 87196, 14900, 3),
(384950, 34570, 15699, 1);




















































