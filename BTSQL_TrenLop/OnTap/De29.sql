CREATE DATABASE DE29

GO 
USE DE29
GO

--Create table
CREATE TABLE BenhVien
(
	maBV NVARCHAR(10) PRIMARY KEY,
	tenBV NVARCHAR(50) NOT NULL
)

GO
CREATE TABLE KhoaKham
(
	maKhoa NVARCHAR(10) PRIMARY KEY,
	tenKhoa NVARCHAR(50) NOT NULL,
	soBN INT,
	maBV NVARCHAR(10) not null,
	FOREIGN KEY (maBV) REFERENCES BenhVien(maBV)
)

GO
CREATE TABLE BenhNhan
(
	maBN NVARCHAR(10) PRIMARY KEY,
	hoTen NVARCHAR(50) NOT NULL,
	ngaySinh DATE,
	gioiTinh BIT,
	soNgayNamVien INT,
	maKhoa NVARCHAR(10) not null,
	FOREIGN KEY (maKhoa) REFERENCES KhoaKham(maKhoa)
)

--Insert data
INSERT INTO BenhVien VALUES 
(	N'BV01', N'Benh Vien 1'),
(	N'BV02', N'Benh Vien 2')

GO
INSERT INTO KhoaKham VALUES
(	N'K01',	N'Khoa 01', 100, N'BV01'),
(	N'K02',	N'Khoa 02', 100, N'BV02')
GO
INSERT INTO BenhNhan VALUES
(	N'BN001', N'Benh nhan 1', GETDATE(), 1, 14, N'K01'),
(	N'BN002', N'Benh nhan 2', GETDATE(), 1, 24, N'K01'),
(	N'BN003', N'Benh nhan 3', GETDATE(), 1, 14, N'K01'),
(	N'BN004', N'Benh nhan 4', GETDATE(), 1, 24, N'K01'),
(	N'BN005', N'Benh nhan 5', GETDATE(), 1, 14, N'K01'),
(	N'BN006', N'Benh nhan 6', GETDATE(), 1, 16, N'K01'),
(	N'BN007', N'Benh nhan 7', GETDATE(), 1, 10, N'K01')

--Display data
SELECT * FROM BenhVien
SELECT * FROM KhoaKham
SELECT * FROM BenhNhan

--Cau 4
GO
ALTER TABLE BenhNhan NOCHECK CONSTRAINT ALL
go
CREATE TRIGGER tg_Cau4 ON BenhNhan
for Insert 
AS 
	BEGIN
		DECLARE  @maKhoa NVARCHAR(10)
		SELECT  @maKhoa = maKhoa  FROM inserted
		IF ( NOT EXISTS ( SELECT * FROM dbo.KhoaKham WHERE maKhoa = @maKhoa))
			BEGIN 
				RAISERROR( N'Ma khoa sai', 16, 1)
				ROLLBACK transaction
			END
		ELSE 		
			UPDATE dbo.KhoaKham SET soBN = soBN + 1
			WHERE maKhoa = @maKhoa
	END

--TEST
--TH1: ma khoa sai
INSERT INTO BenhNhan VALUES
(	N'BN008', N'Benh nhan 1', GETDATE(), 1, 14, N'K03')
--TH2: Ma khoa dung
SELECT * from KhoaKham
INSERT INTO BenhNhan VALUES
(	N'BN008', N'Benh nhan 1', GETDATE(), 1, 14, N'K01')
SELECT * FROM KhoaKham