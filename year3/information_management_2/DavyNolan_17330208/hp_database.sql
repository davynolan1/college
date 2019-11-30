CREATE DATABASE IF NOT EXISTS harry_potter_db;

USE harry_potter_db;

CREATE TABLE IF NOT EXISTS School (
    ID INT NOT NULL ,
    Name VARCHAR(50) NOT NULL,
    Location VARCHAR(20) NOT NULL,
    No_Students INT NOT NULL,
    PRIMARY KEY(ID)
);

CREATE TABLE IF NOT EXISTS Subject (
    ID INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Prof_PPS INT NOT NULL,
    Room_No INT UNIQUE,
    PRIMARY KEY(ID)
);

CREATE TABLE IF NOT EXISTS Staff (
	PPS INT NOT NULL,
    First_Name VARCHAR(20) NOT NULL,
    Last_Name VARCHAR(20) NOT NULL,
    Mag_Species VARCHAR(20) NOT NULL,
    Subject_ID INT,
    Office_No INT UNIQUE,
    Wand_ID INT,
    School_ID INT NOT NULL,
    Job_Title VARCHAR(20) NOT NULL,
    PRIMARY KEY(PPS)
);

CREATE TABLE IF NOT EXISTS Student (
	ID INT NOT NULL,
    First_Name VARCHAR(20) NOT NULL,
    Last_Name VARCHAR(20) NOT NULL,
    Mag_Species VARCHAR(20) NOT NULL,
    Wand_ID INT NOT NULL,
    Pet_ID INT,
    School_ID INT NOT NULL,
    House VARCHAR(15),
    PRIMARY KEY(ID)
);

CREATE TABLE IF NOT EXISTS Wand (
	ID INT NOT NULL,
    Core VARCHAR(30) NOT NULL,
    Wood_Type VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID)
);

CREATE TABLE IF NOT EXISTS Pet (
	ID INT NOT NULL,
    Name VARCHAR(20),
    Species VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID)
);

INSERT INTO School VALUES ( 5490, 'Hogwarts School of Witchcraft and Wizardry', 'Scotland', 283);
INSERT INTO School VALUES ( 5500, 'Beauxbatons Academy of Magic', 'France', 332);
INSERT INTO School VALUES ( 5510, 'Castelobruxo', 'Central Brazil', 432);
INSERT INTO School VALUES ( 5520, 'Durmstrang Institute', 'Northern Europe', 280);
INSERT INTO School VALUES ( 5530, 'Ilvermorny', 'North America', 414);
INSERT INTO School VALUES ( 5540, 'Mahoutokoro School of Magic', 'Japan', 683);
INSERT INTO School VALUES ( 5550, 'Uagadou School of Magic', 'Uganda', 456);
INSERT INTO School VALUES ( 5560, 'Koldovstoretz', 'Russia', 298);

INSERT INTO Subject VALUES (11123, 'Charms', '12348000', 1); /*Filius Flitwick*/
INSERT INTO Subject VALUES (11135, 'Defence Against the Dark Arts', '12348010', 6 ); /*Alastor Moody*/
INSERT INTO Subject VALUES (11147, 'Flying', '12348020', 4); /*Rolanda Hooch*/
INSERT INTO Subject VALUES (11159, 'Herbology', '12348030', 12); /*Pomona Sprout*/
INSERT INTO Subject VALUES (11171, 'History of Magic', '12348040', 7); /*Cuthbert Binns*/
INSERT INTO Subject VALUES (11183, 'Potions', '12348050', 18); /*Severus Snape*/
INSERT INTO Subject VALUES (11195, 'Transfiguration', '12348060', 21); /*Minerva McGonagall*/
INSERT INTO Subject VALUES (11207, 'Arithmancy', '12348070', 16); /*Septima Vector*/
INSERT INTO Subject VALUES (11219, 'Care of Magical Creatures', '12348080', 41); /*Wilhelmina Grubbly-Plank*/
INSERT INTO Subject VALUES (11231, 'Divination', '12348090', 32); /*Sybill Trelawney*/
INSERT INTO Subject VALUES (11243, 'Apparition', '12348100', 17); /*Wilkie Twycross*/

INSERT INTO Staff VALUES (12347990, 'Albus', 'Dumbledore', 'Wizard', null, 0, 987619, 5490, 'Headmaster');
INSERT INTO Staff VALUES (12348000, 'Filius', 'Flitwick', 'Goblin-Wizard', 11123, 1, 987631, 5490, 'Professor');
INSERT INTO Staff VALUES (12348010, 'Alastor', 'Moody', 'Wizard', 11135, 6, 987643, 5490, 'Professor');
INSERT INTO Staff VALUES (12348020, 'Rolanda', 'Hooch', 'Witch', 11147, 4, 987655, 5490, 'Professor');
INSERT INTO Staff VALUES (12348030, 'Pomona', 'Sprout', 'Witch', 11159, 12, 987667, 5490, 'Professor');
INSERT INTO Staff VALUES (12348040, 'Cuthbert', 'Binns', 'Wizard', 11171, 7, 987679, 5490, 'Professor');
INSERT INTO Staff VALUES (12348050, 'Severus', 'Snape', 'Wizard', 11183, 18, 987691, 5490, 'Professor');
INSERT INTO Staff VALUES (12348060, 'Minerva', 'McGonagall', 'Witch', 11195, 21, 987703, 5490, 'Professor');
INSERT INTO Staff VALUES (12348070, 'Septima', 'Vector', 'Witch', 11207, 16, 987715, 5490, 'Professor');
INSERT INTO Staff VALUES (12348080, 'Wilhelmina', 'Grubbly-Plank', 'Witch', 11219, 41, 987727, 5490, 'Professor');
INSERT INTO Staff VALUES (12348090, 'Sybill', 'Trelawney', 'Witch', 11231, 32, 987739, 5490, 'Professor');
INSERT INTO Staff VALUES (12348100, 'Wilkie', 'Twycross', 'Wizard', 11243, 17, 987751, 5490, 'Professor');
INSERT INTO Staff VALUES (12348110, 'Rubius', 'Hagrid', 'Wizard-Giant', NULL, 34, 987763, 5490, 'Gate-keeper');
INSERT INTO Staff VALUES (12348120, 'Argus', 'Filch', 'Squib', NULL, NULL, NULL, 5490, 'Care-taker');
INSERT INTO Staff VALUES (12348130, 'Olympe', 'Maxime', 'Witch-Giant', NULL, 67, 987907, 5500, 'Headmaster');


INSERT INTO Student VALUES (17339999, 'Harry', 'Potter', 'Wizard', 987775, 1010, 5490, 'Gryffindor'); 
INSERT INTO Student VALUES (17339998, 'Hermione', 'Granger', 'Witch', 987787, 1021, 5490, 'Gryffindor'); 
INSERT INTO Student VALUES (17339997, 'Ronald', 'Weasley', 'Wizard', 987799, 1032, 5490, 'Gryffindor'); 
INSERT INTO Student VALUES (17339996, 'Neville', 'Longbottom', 'Wizard', 987811, 1043, 5490, 'Gryffindor'); 
INSERT INTO Student VALUES (17339995, 'Draco', 'Malfoy', 'Wizard', 987823, 1054, 5490, 'Slytherin'); 
INSERT INTO Student VALUES (17339994, 'Vincent', 'Crabbe', 'Wizard', 987835, 1065, 5490, 'Slytherin');
INSERT INTO Student VALUES (17339993, 'Gregory', 'Goyle', 'Wizard', 987847, 1076, 5490, 'Slytherin'); 
INSERT INTO Student VALUES (17339992, 'Ernie', 'Macmillan', 'Wizard', 987859, 1087, 5490, 'Hufflepuff'); 
INSERT INTO Student VALUES (17339991, 'Cedric', 'Diggory', 'Wizard', 987871, 1098, 5490, 'Hufflepuff');
INSERT INTO Student VALUES (17339990, 'Luna', 'Lovegood', 'Witch', 987883, 1110, 5490, 'Ravenclaw'); 
INSERT INTO Student VALUES (17339989, 'Cho', 'Chang', 'Witch', 987895, 1121, 5490, 'Ravenclaw'); 
INSERT INTO Student VALUES (17339988, 'Viktor', 'Krum', 'Wizard', 987919, null, 5520, null); 

INSERT INTO Wand VALUES (987619, 'Thestral Tail Hair', 'Elder');
INSERT INTO Wand VALUES (987631, 'Unicorn Hair', 'Ash');
INSERT INTO Wand VALUES (987643, 'Dragon Heartstring', 'Oak');
INSERT INTO Wand VALUES (987655, 'Unicorn hair', 'Willow');
INSERT INTO Wand VALUES (987667, 'Dragon Heartstring', 'Yew');
INSERT INTO Wand VALUES (987679, 'Phoenix Feather', 'Mahogany');
INSERT INTO Wand VALUES (987691, 'Dragon Heartstring', 'Bog-wood');
INSERT INTO Wand VALUES (987703, 'Unicorn Hair', 'Sycamore');
INSERT INTO Wand VALUES (987715, 'Unicorn Hair', 'Oak');
INSERT INTO Wand VALUES (987727, 'Unicorn Hair', 'Beech');
INSERT INTO Wand VALUES (987739, 'Unicorn Hair', 'Elm');
INSERT INTO Wand VALUES (987751, 'Unicorn Hair', 'Cherry');
INSERT INTO Wand VALUES (987763, 'Unicorn Hair', 'Ash');
INSERT INTO Wand VALUES (987775, 'Unicorn Hair', 'Willow');
INSERT INTO Wand VALUES (987787, 'Phoenix Feather', 'Holly');
INSERT INTO Wand VALUES (987799, 'Dragon Heartstring', 'Vine');
INSERT INTO Wand VALUES (987811, 'Unicorn Hair', 'Willow');
INSERT INTO Wand VALUES (987823, 'Unicorn Hair', 'Cherry');
INSERT INTO Wand VALUES (987835, 'Unicorn Hair', 'Hawthorn');
INSERT INTO Wand VALUES (987847, 'Dragon Heartstring', 'Ash');
INSERT INTO Wand VALUES (987859, 'Unicorn Hair', 'Oak');
INSERT INTO Wand VALUES (987871, 'Unicorn Hair', 'Mahogany');
INSERT INTO Wand VALUES (987883, 'Unicorn Hair', 'Ash');
INSERT INTO Wand VALUES (987895, 'Unicorn Hair', 'Holly');
INSERT INTO Wand VALUES (987907, 'Unicorn Hair', 'Oak');
INSERT INTO Wand VALUES (987919, 'Dragon Heartstring', 'Mahogany');

INSERT INTO Pet VALUES (1010, 'Hedwig', 'Owl');
INSERT INTO Pet VALUES (1021, 'Crookshanks', 'Cat');
INSERT INTO Pet VALUES (1032, 'Scabbers', 'Rat');
INSERT INTO Pet VALUES (1043, 'Trevor', 'Toad');
INSERT INTO Pet VALUES (1054, null, 'Owl');
INSERT INTO Pet VALUES (1065, null, 'Toad');
INSERT INTO Pet VALUES (1076, null, 'Rat');
INSERT INTO Pet VALUES (1087, null, 'Owl');
INSERT INTO Pet VALUES (1098, null, 'Owl');
INSERT INTO Pet VALUES (1110, null, 'Cat');
INSERT INTO Pet VALUES (1121, null, 'Cat');


ALTER TABLE Subject ADD FOREIGN KEY(Prof_PPS) REFERENCES Staff(PPS);
ALTER TABLE Subject ADD FOREIGN KEY(Room_No) REFERENCES Staff(Office_No);

ALTER TABLE Staff ADD FOREIGN KEY(Wand_ID) REFERENCES Wand(ID);
ALTER TABLE Staff ADD FOREIGN KEY(School_ID) REFERENCES School(ID);
ALTER TABLE Staff ADD FOREIGN KEY(Subject_ID) REFERENCES Subject(ID);

ALTER TABLE Student ADD FOREIGN KEY(Wand_ID) REFERENCES Wand(ID);
ALTER TABLE Student ADD FOREIGN KEY(Pet_ID) REFERENCES Pet(ID);
ALTER TABLE Student ADD FOREIGN KEY(School_ID) REFERENCES School(ID);


ALTER TABLE School ADD CHECK(ID > 4999 AND ID < 10000);
ALTER TABLE Subject ADD CHECK(ID > 10999 AND ID < 12000);
ALTER TABLE Staff ADD CHECK(PPS > 12339999 AND PPS < 12350000);
ALTER TABLE Student ADD CHECK(ID > 16999999 AND ID < 18000000);
ALTER TABLE Student ADD CHECK(House IN ('Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff'));
ALTER TABLE Wand ADD CHECK(ID > 99999 AND ID < 1000000);
ALTER TABLE Pet ADD CHECK(ID > 999 AND ID < 4999);
ALTER TABLE Pet ADD CHECK(Species IN ('Owl', 'Rat', 'Toad', 'Cat'));
 
CREATE VIEW Gryffindor_students (Student_ID, First_Name, Last_Name) 
	AS SELECT Student.ID, Student.First_Name, Student.Last_Name FROM Student WHERE Student.House = 'Gryffindor';
CREATE VIEW Slytherin_students (Student_ID, First_Name, Last_Name) 
	AS SELECT Student.ID, Student.First_Name, Student.Last_Name FROM Student WHERE Student.House = 'Slytherin';
CREATE VIEW Ravenclaw_students (Student_ID, First_Name, Last_Name) 
	AS SELECT Student.ID, Student.First_Name, Student.Last_Name FROM Student WHERE Student.House = 'Ravenclaw';
CREATE VIEW Hufflepuff_students (Student_ID, First_Name, Last_Name) 
	AS SELECT Student.ID, Student.First_Name, Student.Last_Name FROM Student WHERE Student.House = 'Hufflepuf›';
CREATE VIEW hogwarts_students(Student_ID, First_Name, Last_Name) 
	AS SELECT Student.ID, Student.First_Name, Student.Last_Name FROM Student WHERE Student.School_ID = 5490;