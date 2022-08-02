DROP DATABASE IF EXISTS SA1;
CREATE DATABASE SA1;
USE SA1;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	DepartmentID		INT PRIMARY KEY AUTO_INCREMENT,
	DepartmentName		VARCHAR(100) UNIQUE KEY
);

DROP TABLE IF EXISTS Position;
CREATE TABLE Position (
	PositionID			INT PRIMARY KEY AUTO_INCREMENT,
    PositionName		VARCHAR(50) UNIQUE KEY
);

DROP TABLE IF EXISTS Account;
CREATE TABLE `Account` (
	AccountID		INT PRIMARY KEY AUTO_INCREMENT,
	Email			VARCHAR(20) UNIQUE KEY,
	Username		VARCHAR(20),
	FullName		VARCHAR(20),
	DepartmentID	INT NOT NULL,
	PositionID		INT NOT NULL,
	CreateDate		DATE,
    CONSTRAINT FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    CONSTRAINT FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	GroupID			INT PRIMARY KEY AUTO_INCREMENT,
	GroupName		VARCHAR(20) NOT NULL,
	CreatorID		INT NOT NULL,
	CreateDate		DATETIME,
    CONSTRAINT FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	GroupID		INT NOT NULL,
	AccountID 	INT NOT NULL,
	JoinDate	DATETIME,
	CONSTRAINT FOREIGN KEY (GroupID) REFERENCES `Group` (GroupID),
    CONSTRAINT FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion(
	TypeID		INT PRIMARY KEY AUTO_INCREMENT,
	TypeName	ENUM ('Essay','Multiple-Choice')
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
	CategoryID		INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	CategoryName	VARCHAR(100)
);

DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
	QuestionID		INT PRIMARY KEY AUTO_INCREMENT,
	Content			TEXT NOT NULL,
	CategoryID		INT NOT NULL,
	TypeID 			INT NOT NULL,
	CreatorID		INT NOT NULL,
	CreateDate		DATETIME,
	CONSTRAINT FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
    CONSTRAINT FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID),
    CONSTRAINT FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID)
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
	AnswerID		INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	Content			TEXT NOT NULL,
	QuestionID		INT NOT NULL,
	isCorrect 		enum('Đ','S'),
	CONSTRAINT FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
	ExamID		INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	Code		VARCHAR(10) NOT NULL UNIQUE KEY,
	Title		VARCHAR(10),
	CategoryID	INT,
	Duration	DATETIME NOT NULL,
	CreatorID 	INT NOT NULL,
	CreateDate	DATETIME,
    CONSTRAINT FOREIGN KEY (CreatorID ) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
	ExamID		INT NOT NULL,
	QuestionID	INT NOT NULL,
CONSTRAINT FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
CONSTRAINT FOREIGN KEY (QuestionID) REFERENCES Answer(QuestionID)
);



INSERT INTO Department (DepartmentID, DepartmentName)
	VALUES ('001', 'Phòng quản lý chất lượng');
INSERT INTO Department (DepartmentID, DepartmentName)
	VALUES ('002', 'Phòng kinh doanh');
INSERT INTO Department (DepartmentID, DepartmentName)
	VALUES ('003', 'Phòng kế toán');
INSERT INTO Department (DepartmentID, DepartmentName)
	VALUES ('004', 'Phòng hành chính');
INSERT INTO Department (DepartmentID, DepartmentName)
	VALUES ('005', 'Phòng nhân sự');



INSERT INTO `Position` (PositionID, PositionName)
	VALUES ('221', 'Giám đốc');
INSERT INTO `Position` (PositionID, PositionName)
	VALUES ('222', 'Giám đốc điều hành');
INSERT INTO `Position` (PositionID, PositionName)
	VALUES ('223', 'Giám đốc thông tin');
INSERT INTO `Position` (PositionID, PositionName)
	VALUES ('224', 'Giám đốc tài chính');
INSERT INTO `Position` (PositionID, PositionName)
	VALUES ('225', 'Chủ tịch');


INSERT INTO `Account` (AccountID, Email, Username, FullName, DepartmentID, PositionID, CreateDate)
	VALUES ('331', 'nguyenvanA@gmail.com', 'NGUYENVANA', 'Nguyễn Văn A', 001 , 221, '2021-02-03');
INSERT INTO `Account` (AccountID, Email, Username, FullName, DepartmentID, PositionID, CreateDate)
	VALUES ('332', 'nguyenvanB@gmail.com', 'NGUYENVANB', 'Nguyễn Văn B', 002 , 222, '2020-09-03');
INSERT INTO `Account` (AccountID, Email, Username, FullName, DepartmentID, PositionID, CreateDate)
	VALUES ('333', 'nguyenvanC@gmail.com', 'NGUYENVANC', 'Nguyễn Văn C', 003 , 223, '2000-12-03');
INSERT INTO `Account` (AccountID, Email, Username, FullName, DepartmentID, PositionID, CreateDate)
	VALUES ('334', 'nguyenvanD@gmail.com', 'NGUYENVAND', 'Nguyễn Văn D', 004 , 224, '2000-02-08');
INSERT INTO `Account` (AccountID, Email, Username, FullName, DepartmentID, PositionID, CreateDate)
	VALUES ('335', 'nguyenvanE@gmail.com', 'NGUYENVANE', 'Nguyễn Văn E', 005 , 225, '2001-02-10');



































