CREATE DATABASE DeptEmp

USE DeptEmp
GO

CREATE TABLE Department
(
	DepartmentNo INTEGER PRIMARY KEY,
	DepartmentName CHAR(25) NOT NULL,
	Location CHAR(25) NOT NULL
)
GO

CREATE TABLE Employee
(
	EmpNo INTEGER PRIMARY KEY,
	Fname VARCHAR(15) NOT NULL,
	Lname VARCHAR(15) NOT NULL,
	Job VARCHAR(25) NOT NULL,
	HireDate DATETIME NOT NULL,
	Salary NUMERIC NOT NULL,
	Commision NUMERIC,
	DepartmentNo INTEGER NOT NULL,
	FOREIGN KEY (DepartmentNo) REFERENCES dbo.Department
)

INSERT INTO dbo.Department
(
    DepartmentNo,
    DepartmentName,
    Location
)
VALUES
(   10,  -- DepartmentNo - int
    'Accounting', -- DepartmentName - char(25)
    'Melbourne'  -- Location - char(25)
)

INSERT INTO dbo.Department
(
    DepartmentNo,
    DepartmentName,
    Location
)
VALUES
(   20,  -- DepartmentNo - int
    'Research', -- DepartmentName - char(25)
    'Adealide'  -- Location - char(25)
)

INSERT INTO dbo.Department
(
    DepartmentNo,
    DepartmentName,
    Location
)
VALUES
(   30,  -- DepartmentNo - int
    'Sales', -- DepartmentName - char(25)
    'Sydney'  -- Location - char(25)
)

INSERT INTO dbo.Department
(
    DepartmentNo,
    DepartmentName,
    Location
)
VALUES
(   40,  -- DepartmentNo - int
    'Operations', -- DepartmentName - char(25)
    'Perth'  -- Location - char(25)
)

INSERT INTO dbo.Employee
(
    EmpNo,
    Fname,
    Lname,
    Job,
    HireDate,
    Salary,
    Commision,
    DepartmentNo
)
VALUES
(   1,         -- EmpNo - int
    'John',        -- Fname - varchar(15)
    'Smith',        -- Lname - varchar(15)
    'Clerk',        -- Job - varchar(25)
    '19801217', -- HireDate - datetime
    800,      -- Salary - numeric(18, 0)
    NULL,      -- Commision - numeric(18, 0)
    20          -- DepartmentNo - int
)

INSERT INTO dbo.Employee
(
    EmpNo,
    Fname,
    Lname,
    Job,
    HireDate,
    Salary,
    Commision,
    DepartmentNo
)
VALUES
(   2,         -- EmpNo - int
    'Peter',        -- Fname - varchar(15)
    'Allen',        -- Lname - varchar(15)
    'Salesman',        -- Job - varchar(25)
    '19810220', -- HireDate - datetime
    1600,      -- Salary - numeric(18, 0)
    300,      -- Commision - numeric(18, 0)
    30          -- DepartmentNo - int
)

INSERT INTO dbo.Employee
(
    EmpNo,
    Fname,
    Lname,
    Job,
    HireDate,
    Salary,
    Commision,
    DepartmentNo
)
VALUES
(   3,         -- EmpNo - int
    'Kate',        -- Fname - varchar(15)
    'Ward',        -- Lname - varchar(15)
    'Salesman',        -- Job - varchar(25)
    '19810222', -- HireDate - datetime
    1250,      -- Salary - numeric(18, 0)
    500,      -- Commision - numeric(18, 0)
    30          -- DepartmentNo - int
)

INSERT INTO dbo.Employee
(
    EmpNo,
    Fname,
    Lname,
    Job,
    HireDate,
    Salary,
    Commision,
    DepartmentNo
)
VALUES
(   4,         -- EmpNo - int
    'Jact',        -- Fname - varchar(15)
    'Jones',        -- Lname - varchar(15)
    'Manager',        -- Job - varchar(25)
    '19810402', -- HireDate - datetime
    2975,      -- Salary - numeric(18, 0)
    NULL,      -- Commision - numeric(18, 0)
    20          -- DepartmentNo - int
)

INSERT INTO dbo.Employee
(
    EmpNo,
    Fname,
    Lname,
    Job,
    HireDate,
    Salary,
    Commision,
    DepartmentNo
)
VALUES
(   5,         -- EmpNo - int
    'Joe',        -- Fname - varchar(15)
    'Martin',        -- Lname - varchar(15)
    'Salesman',        -- Job - varchar(25)
    '19810928', -- HireDate - datetime
    1250,      -- Salary - numeric(18, 0)
    1400,      -- Commision - numeric(18, 0)
    30          -- DepartmentNo - int
)