CREATE TABLE School (
    ID INT NOT NULL ,
    Name VARCHAR(20) NOT NULL,
    Location VARCHAR(20) NOT NULL,
    No_Students INT NOT NULL
);
GO

CREATE TABLE Subject (
    ID INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Prof_PPS INT NOT NULL,
    Room_No INT NOT NULL
);
GO