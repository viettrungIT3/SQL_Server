CREATE DATABASE MarkManagement

ON PRIMARY (
	NAME = 'MarkManagement_DATA',
	FILENAME ='E:\SQL Server Management Studio\BTSQL_TrenLop\Bai1_Phieu1\Phieu1.MDF',
	SIZE = 50MB,	MAXSIZE = 200MB,
	FILEGROWTH = 10%
)
LOG ON (
	NAME = 'MarkManagement_LOG',
	FILENAME ='E:\SQL Server Management Studio\BTSQL_TrenLop\Bai1_Phieu1\Phieu1.LDF',
	SIZE = 10MB, MAXSIZE = UNLIMITED,
	FILEGROWTH = 5MB
)

use MarkManagement
go
CREATE TABLE Students (
	StudentID NVARCHAR(12) PRIMARY KEY,
	StudentName NVARCHAR(25) NOT NULL,
	DateofBirth Datetime NOT NULL,
	Email NVARCHAR(40),
	Phone NVARCHAR(12),
	Class NVARCHAR(10)
)

go
CREATE TABLE Subjects (
	SubjectID NVARCHAR(10) PRIMARY KEY,
	SubjectName NVARCHAR(25) NOT NULL
)

go
CREATE TABLE Mark (
	StudentID NVARCHAR(12) NOT NULL,
	SubjectID NVARCHAR(10) NOT NULL,
	DateM Datetime,
	Theory Tinyint,
	Practical Tinyint,
	CONSTRAINT pk_Mark PRIMARY KEY ( StudentID, SubjectID),
	CONSTRAINT fk_Mark_student FOREIGN KEY (StudentID) REFERENCES dbo.Students(StudentID),-- ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Mark_subject FOREIGN KEY (SubjectID) REFERENCES dbo.Subjects(SubjectID) -- ON DELETE CASCADE ON UPDATE CASCADE
)

INSERT INTO dbo.Students
(
    StudentID,
    StudentName,
    DateofBirth,
    Email,
    Phone,
    Class
)
VALUES
(   N'AV0807005',       -- StudentID - nvarchar(12)
    N'Mail Trung Hiếu',       -- StudentName - nvarchar(25)
    '19891011', -- DateofBirth - datetime
    N'trunghieu@yahoo.com',       -- Email - nvarchar(40)
    N'0904115116',       -- Phone - nvarchar(12)
    N'AV1'        -- Class - nvarchar(10)
)

INSERT INTO dbo.Students
(
    StudentID,
    StudentName,
    DateofBirth,
    Email,
    Phone,
    Class
)
VALUES
(   N'AV0807006',       -- StudentID - nvarchar(12)
    N'Nguyễn Quý Hùng',       -- StudentName - nvarchar(25)
    '19881202', -- DateofBirth - datetime
    N'quyhung@yahoo.com',       -- Email - nvarchar(40)
    N'0955667787',       -- Phone - nvarchar(12)
    N'AV2'        -- Class - nvarchar(10)
)

INSERT INTO dbo.Students
(
    StudentID,
    StudentName,
    DateofBirth,
    Email,
    Phone,
    Class
)
VALUES
(   N'AV0807007',       -- StudentID - nvarchar(12)
    N'Đỗ Đắc Huỳnh',       -- StudentName - nvarchar(25)
    '19900102', -- DateofBirth - datetime
    N'dachuynh@yahoo.com',       -- Email - nvarchar(40)
    N'0988574747',       -- Phone - nvarchar(12)
    N'AV2'        -- Class - nvarchar(10)
)

INSERT INTO dbo.Students
(
    StudentID,
    StudentName,
    DateofBirth,
    Email,
    Phone,
    Class
)
VALUES
(   N'AV0807009',       -- StudentID - nvarchar(12)
    N'An Đăng Khuê',       -- StudentName - nvarchar(25)
    '19860306', -- DateofBirth - datetime
    N'dangkhue@yahoo.com',       -- Email - nvarchar(40)
    N'0986757463',       -- Phone - nvarchar(12)
    N'AV!'        -- Class - nvarchar(10)
)

INSERT INTO dbo.Students
(
    StudentID,
    StudentName,
    DateofBirth,
    Email,
    Phone,
    Class
)
VALUES
(   N'AV0807010',       -- StudentID - nvarchar(12)
    N'Nguyễn T. Tuyết Lan',       -- StudentName - nvarchar(25)
    '19890712', -- DateofBirth - datetime
    N'tuyetlan@gmail.com',       -- Email - nvarchar(40)
    N'0983310342',       -- Phone - nvarchar(12)
    N'AV2'        -- Class - nvarchar(10)
)

INSERT INTO dbo.Students
(
    StudentID,
    StudentName,
    DateofBirth,
    Email,
    Phone,
    Class
)
VALUES
(   N'AV0807011',       -- StudentID - nvarchar(12)
    N'Đinh Phụng Long',       -- StudentName - nvarchar(25)
    '19901202', -- DateofBirth - datetime
    N'phunglong@yahoo.com',       -- Email - nvarchar(40)
    N'',       -- Phone - nvarchar(12)
    N'AV1'        -- Class - nvarchar(10)
)

INSERT INTO dbo.Students
(
    StudentID,
    StudentName,
    DateofBirth,
    Email,
    Phone,
    Class
)
VALUES
(   N'AV0807012',       -- StudentID - nvarchar(12)
    N'Nguyễn Tuấn Nam',       -- StudentName - nvarchar(25)
    '19900302', -- DateofBirth - datetime
    N'tuannam@yahoo.com',       -- Email - nvarchar(40)
    N'',       -- Phone - nvarchar(12)
    N'AV1'        -- Class - nvarchar(10)
)

INSERT INTO dbo.Subjects
(
    SubjectID,
    SubjectName
)
VALUES
(   N'S001', -- SubjectID - nvarchar(10)
    N'SQL'  -- SubjectName - nvarchar(25)
)

INSERT INTO dbo.Subjects
(
    SubjectID,
    SubjectName
)
VALUES
(   N'S002', -- SubjectID - nvarchar(10)
    N'Java Simplefield'  -- SubjectName - nvarchar(25)
)

INSERT INTO dbo.Subjects
(
    SubjectID,
    SubjectName
)
VALUES
(   N'S003', -- SubjectID - nvarchar(10)
    N'Active Server Page'  -- SubjectName - nvarchar(25)
)

INSERT INTO dbo.Mark
(
    StudentID,
    SubjectID,
    DateM,
    Theory,
    Practical
)
VALUES
(   N'AV0807005',       -- StudentID - nvarchar(12)
    N'S001',       -- SubjectID - nvarchar(10)
    '20080506', -- DateM - datetime
    8,         -- Theory - tinyint
    25          -- Practical - tinyint
)

INSERT INTO dbo.Mark
(
    StudentID,
    SubjectID,
    DateM,
    Theory,
    Practical
)
VALUES
(   N'AV0807006',       -- StudentID - nvarchar(12)
    N'S002',       -- SubjectID - nvarchar(10)
    '20080506', -- DateM - datetime
    16,         -- Theory - tinyint
    30          -- Practical - tinyint
)

INSERT INTO dbo.Mark
(
    StudentID,
    SubjectID,
    DateM,
    Theory,
    Practical
)
VALUES
(   N'AV0807007',       -- StudentID - nvarchar(12)
    N'S001',       -- SubjectID - nvarchar(10)
    '20080506', -- DateM - datetime
    10,         -- Theory - tinyint
    25          -- Practical - tinyint
)

INSERT INTO dbo.Mark
(
    StudentID,
    SubjectID,
    DateM,
    Theory,
    Practical
)
VALUES
(   N'AV0807009',       -- StudentID - nvarchar(12)
    N'S003',       -- SubjectID - nvarchar(10)
    '20080506', -- DateM - datetime
    7,         -- Theory - tinyint
    13          -- Practical - tinyint
)

INSERT INTO dbo.Mark
(
    StudentID,
    SubjectID,
    DateM,
    Theory,
    Practical
)
VALUES
(   N'AV0807010',       -- StudentID - nvarchar(12)
    N'S003',       -- SubjectID - nvarchar(10)
    '20080506', -- DateM - datetime
    9,         -- Theory - tinyint
    16          -- Practical - tinyint
)

INSERT INTO dbo.Mark
(
    StudentID,
    SubjectID,
    DateM,
    Theory,
    Practical
)
VALUES
(   N'AV0807011',       -- StudentID - nvarchar(12)
    N'S002',       -- SubjectID - nvarchar(10)
    '20080506', -- DateM - datetime
    8,         -- Theory - tinyint
    30          -- Practical - tinyint
)

INSERT INTO dbo.Mark
(
    StudentID,
    SubjectID,
    DateM,
    Theory,
    Practical
)
VALUES
(   N'AV0807012',       -- StudentID - nvarchar(12)
    N'S001',       -- SubjectID - nvarchar(10)
    '20080506', -- DateM - datetime
    7,         -- Theory - tinyint
    31          -- Practical - tinyint
)

INSERT INTO dbo.Mark
(
    StudentID,
    SubjectID,
    DateM,
    Theory,
    Practical
)
VALUES
(   N'AV0807005',       -- StudentID - nvarchar(12)
    N'S002',       -- SubjectID - nvarchar(10)
    '20080206', -- DateM - datetime
    12,         -- Theory - tinyint
    11          -- Practical - tinyint
)

INSERT INTO dbo.Mark
(
    StudentID,
    SubjectID,
    DateM,
    Theory,
    Practical
)
VALUES
(   N'AV0807009',       -- StudentID - nvarchar(12)
    N'S003',       -- SubjectID - nvarchar(10)
    '20080206', -- DateM - datetime
    11,         -- Theory - tinyint
    20          -- Practical - tinyint
)

INSERT INTO dbo.Mark
(
    StudentID,
    SubjectID,
    DateM,
    Theory,
    Practical
)
VALUES
(   N'AV0807010',       -- StudentID - nvarchar(12)
    N'S001',       -- SubjectID - nvarchar(10)
    '20080206', -- DateM - datetime
    7,         -- Theory - tinyint
    6          -- Practical - tinyint
)