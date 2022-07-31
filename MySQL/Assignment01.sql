

DROP DATABASE IF EXISTS SA1;
CREATE DATABASE SA1;
USE SA1;

CREATE TABLE Department(
	DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
	DepartmentName CHAR(50)
);

CREATE TABLE Position (
	PositionID INT PRIMARY KEY AUTO_INCREMENT,
    PositionName VARCHAR(20),
    CONSTRAINT FOREIGN KEY (PositionID) REFERENCES Account(PositionID)
);

CREATE TABLE Account (
	AccountID INT PRIMARY KEY AUTO_INCREMENT,
	Email VARCHAR(20),
	Username VARCHAR(20),
	FullName VARCHAR(20),
	DepartmentID INT,
	PositionID INT,
	CreateDate DATETIME,
    CONSTRAINT FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    CONSTRAINT FOREIGN KEY (PositionID) REFERENCES Position (PositionID)
);

CREATE TABLE "Group" (
	GroupID INT PRIMARY KEY AUTO_INCREMENT,
	GroupName VARCHAR(20),
	CreatorID INT,
	CreateDate DATETIME,
);

CREATE TABLE GroupAccount(
	GroupID INT,
	AccountID INT,
	JoinDate DATETIME,
	CONSTRAINT FOREIGN KEY (GroupID) REFERENCES "Group" (GroupID)
);

CREATE TABLE TypeQuestion(
	TypeID INT PRIMARY KEY AUTO_INCREMENT,
	TypeName VARCHAR(20),
    CONSTRAINT FOREIGN KEY (TypeID) REFERENCES Question8(TypeID)
);

CREATE TABLE CategoryQuestion(
	CategoryID INT PRIMARY KEY AUTO_INCREMENT,
	CategoryName VARCHAR(20)
);

CREATE TABLE Question(
	QuestionID INT PRIMARY KEY AUTO_INCREMENT,
	Content varchar(10),
	CategoryID INT,
	TypeID INT,
	CreatorID INT,
	CreateDate date,
	CONSTRAINT FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
    CONSTRAINT FOREIGN KEY (QuestionID) REFERENCES Answer(QuestionID)
);

CREATE TABLE Answer(
	AnswerID INT PRIMARY KEY AUTO_INCREMENT,
	Content varchar(30),
	QuestionID INT,
	isCorrect enum('D','S'),
	CONSTRAINT FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

CREATE TABLE Exam(
	ExamID INT PRIMARY KEY AUTO_INCREMENT,
	Code varchar(10),
	Title varchar(10),
	CategoryID INT,
	Duration datetime,
	CreatorID INT,
	CreateDate date,
	CONSTRAINT FOREIGN KEY (ExamID) REFERENCES ExamQuestion(ExamID)
);


CREATE TABLE ExamQuestion(
	ExamID INT,
	QuestionID INT
);











