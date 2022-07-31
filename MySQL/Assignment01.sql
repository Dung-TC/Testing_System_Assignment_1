DROP DATABASE IF EXISTS SA1;
CREATE DATABASE SA1;
USE SA1;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
	DepartmentName CHAR(50)
);

DROP TABLE IF EXISTS Position;
CREATE TABLE Position (
	PositionID INT PRIMARY KEY AUTO_INCREMENT,
    PositionName VARCHAR(20),
    CONSTRAINT FOREIGN KEY (PositionID) REFERENCES Account(PositionID)
);

DROP TABLE IF EXISTS Account;
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

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	GroupID INT PRIMARY KEY AUTO_INCREMENT,
	GroupName VARCHAR(20),
	CreatorID INT,
	CreateDate DATETIME
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	GroupID INT,
	AccountID INT,
	JoinDate DATETIME,
	CONSTRAINT FOREIGN KEY (GroupID) REFERENCES `Group` (GroupID)
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion(
	TypeID INT PRIMARY KEY AUTO_INCREMENT,
	TypeName VARCHAR(20),
    CONSTRAINT FOREIGN KEY (TypeID) REFERENCES Question8(TypeID)
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
	CategoryID INT PRIMARY KEY AUTO_INCREMENT,
	CategoryName VARCHAR(20)
);

DROP TABLE IF EXISTS Question;
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

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
	AnswerID INT PRIMARY KEY AUTO_INCREMENT,
	Content varchar(30),
	QuestionID INT,
	isCorrect enum('D','S'),
	CONSTRAINT FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

DROP TABLE IF EXISTS Exam;
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

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
	ExamID INT,
	QuestionID INT
);











