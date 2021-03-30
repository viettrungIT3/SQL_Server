CREATE DATABASE QLKHO
USE QLKHO
GO
CREATE TABLE TON
(
	MaVT CHAR(5) PRIMARY KEY,
	TenVT NCHAR(30) NOT NULL,
	SoLuongT TINYINT
)
GO
CREATE TABLE NHAP
(
	SoHDN CHAR(5) NOT NULL,
	MaVT CHAR(5) NOT NULL,
	SoLuongN TINYINT,
	DonGiaN FLOAT,
	NgayN DATETIME,
	PRIMARY KEY (SoHDN,MaVT),
	FOREIGN KEY (MaVT) REFERENCES dbo.TON
)
GO
CREATE TABLE XUAT
(
	SoHDX CHAR(5) NOT NULL,
	MaVT CHAR(5) NOT NULL,
	SoLuongX TINYINT NOT NULL,
	DonGiaX FLOAT NOT NULL,
	NgayX DATETIME,
	PRIMARY KEY (SoHDX,MaVT),
	FOREIGN KEY (MaVT) REFERENCES dbo.TON
)
GO


INSERT INTO dbo.TON VALUES ( '001',  N'aaa', 10 )
INSERT INTO dbo.TON VALUES ( '002',  N'bbb', 20 )
INSERT INTO dbo.TON VALUES ( '003',  N'ccc', 5 )
INSERT INTO dbo.TON VALUES ( '004',  N'ddd', 50 )
INSERT INTO dbo.TON VALUES ( '005',  N'eee', 100 )

SELECT * FROM dbo.TON

INSERT INTO dbo.NHAP VALUES( 'N001', '001', 5, 10.0, GETDATE())
INSERT INTO dbo.NHAP VALUES( 'N002', '002', 10, 20.0, GETDATE())
INSERT INTO dbo.NHAP VALUES( 'N003', '003', 5, 500.0, GETDATE())
INSERT INTO dbo.NHAP VALUES( 'N004', '004', 45, 10.0, GETDATE())
INSERT INTO dbo.NHAP VALUES( 'N005', '005', 50, 100.0, GETDATE())

SELECT * FROM dbo.NHAP

INSERT INTO dbo.XUAT VALUES ( 'X001', '001', 1, 10.0, GETDATE())
INSERT INTO dbo.XUAT VALUES ( 'X002', '002', 1, 10.0, GETDATE())
INSERT INTO dbo.XUAT VALUES ( 'X003', '003', 1, 10.0, GETDATE())
INSERT INTO dbo.XUAT VALUES ( 'X004', '004', 1, 10.0, GETDATE())
INSERT INTO dbo.XUAT VALUES ( 'X005', '005', 1, 10.0, GETDATE())

SELECT * FROM dbo.XUAT
GO

CREATE VIEW CAU2
AS
select dbo.TON.MaVT,TenVT,sum(SoLuongX*DonGiaX) as 'tien ban'
from xuat inner join ton on dbo.XUAT.MaVT=dbo.TON.MaVT
group by dbo.TON.MaVT,TenVT

SELECT * FROM CAU2

CREATE VIEW CAU3
AS
select ton.tenvt, sum(soluongx) as 'tong sl'
from xuat inner join ton on xuat.mavt=ton.mavt
group by ton.tenvt

SELECT * FROM CAU3

CREATE VIEW CAU4
AS
SELECT dbo.Ton.TenVT, SUM(SoLuongN) AS 'Tong SL'
FROM dbo.Nhap INNER JOIN dbo.Ton ON Ton.MaVT = Nhap.MaVT
GROUP BY Ton.TenVT

SELECT * FROM CAU4

go
CREATE VIEW CAU5
AS
select dbo.TON.MaVT,ton.tenvt,sum(soluongN)-sum(soluongX) + sum(soluongT) as
tongton
from nhap inner join ton on nhap.mavt=ton.mavt
inner join xuat on ton.mavt=xuat.mavt
group by ton.mavt,ton.tenvt

SELECT * FROM CAU5