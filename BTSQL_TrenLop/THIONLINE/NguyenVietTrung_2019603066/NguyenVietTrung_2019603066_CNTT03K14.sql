CREATE DATABASE QLXE

GO 
USE QLXE
GO

--a, Creata table
CREATE TABLE Xe
(
	MaXe NVARCHAR(10) PRIMARY KEY,
	TenXe NVARCHAR(30) NOT NULL,
	SoLuong INT
)
CREATE TABLE KhachHang
(
	MaKH NVARCHAR(10) PRIMARY KEY,
	TenKH NVARCHAR(30) NOT NULL,
	DiaChi NVARCHAR(50),
	SoDT NVARCHAR(15),
	Email NVARCHAR(40)
)
CREATE TABLE ThueXe
(
	SoHD NVARCHAR(10) PRIMARY KEY,
	MaKH NVARCHAR(10) NOT NULL,
	MaXe NVARCHAR(10) NOT NULL,
	SoNgayThue INT,
	SoLuongThue INT,
	FOREIGN KEY (MaKH) REFERENCES dbo.KhachHang(MaKH),
	FOREIGN KEY (MaXe) REFERENCES dbo.Xe(MaXe)
)

GO
--b, Insert data
INSERT INTO Xe VALUES 
(	N'XE01', N'Xe 1', 20),
(	N'XE02', N'Xe 2', 20),
(	N'XE03', N'Xe 3', 20)
INSERT INTO KhachHang VALUES
(	N'KH01', N'Nguyen Van A', N'Ha Noi', '123456789', 'abc@gmail.com'),
(	N'KH02', N'Nguyen Van B', N'Ha Noi', '123456789', 'abc@gmail.com'),
(	N'KH03', N'Nguyen Van C', N'Ha Noi', '123456789', 'abc@gmail.com')
INSERT INTO ThueXe VALUES
(	N'HD01', N'KH01', N'XE01', 1,  1),
(	N'HD02', N'KH02', N'XE03', 1,  1),
(	N'HD03', N'KH03', N'XE02', 1,  1),
(	N'HD04', N'KH03', N'XE01', 1,  1),
(	N'HD05', N'KH01', N'XE02', 1,  1)

GO
--Display data
SELECT * FROM dbo.Xe
SELECT * FROM dbo.KhachHang
SELECT * FROM dbo.ThueXe

GO 
-- Câu 2: 
CREATE FUNCTION fn_Cau2 (@que NVARCHAR(50))
RETURNS INT
AS
	BEGIN
	    DECLARE @tong INT
		SELECT @tong = (SELECT SUM(SoLuongThue)
		FROM dbo.ThueXe INNER JOIN dbo.KhachHang ON KhachHang.MaKH = ThueXe.MaKH
		WHERE DiaChi = @que)
		RETURN @tong
	END
GO 
--TEST
-- TH1: 
SELECT dbo.fn_Cau2('Ha Noi') AS 'Tong'
SELECT * FROM dbo.ThueXe
SELECT * FROM dbo.KhachHang
-- TH2: 
SELECT dbo.fn_Cau2('Thai Nguyen') AS 'Tong'
SELECT * FROM dbo.ThueXe
SELECT * FROM dbo.KhachHang

GO
--Câu 3: 
CREATE PROC tt_Cau3
@SoHD NVARCHAR(10), @songaythue INT, @SoLuongThue INT, @MaKH NVARCHAR(10), @MaXe NVARCHAR(10),
@kq INT OUTPUT
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM dbo.KhachHang WHERE MaKH = @MaKH)
		BEGIN
			PRINT N'Mã KH ko tồn tại'
			SET @kq = 1
			RETURN
		END
	IF NOT EXISTS (SELECT * FROM dbo.Xe WHERE MaXe = @MaXe)
		BEGIN
			PRINT N'Mã xe ko tồn tại'
			SET @kq = 2
			RETURN
		END
	ELSE
		BEGIN 
			INSERT INTO ThueXe VALUES (@SoHD, @MaKH, @MaXe, @songaythue, @songaythue)
			SET @kq = 0
		END
END

--TH1: Mã KH ko tồn tại
DECLARE @kq INT
EXEC tt_Cau3 'HD06', 10, 2, 'KH08', 'X001', @kq OUTPUT
PRINT 'KQ = ' + convert(CHAR(5), @kq)
--TH2: Mã xe ko tồn tại
DECLARE @kq INT
EXEC tt_Cau3 'HD06', 10, 2, 'KH01', 'X008', @kq OUTPUT
PRINT 'KQ = ' + convert(char(5), @kq)
--TH3: Chạy đúng
DECLARE @kq INT
EXEC tt_Cau3 'HD06', 10, 2, 'KH01', 'XE03', @kq OUTPUT
PRINT 'KQ = ' + convert(char(5), @kq)

-- Câu 4: 
ALTER TABLE dbo.ThueXe NOCHECK CONSTRAINT ALL
GO
CREATE TRIGGER tg_Cau4 ON dbo.ThueXe
FOR INSERT 
AS 
	BEGIN
		IF EXISTS (SELECT * FROM Xe INNER JOIN Inserted ON Inserted.MaXe = Xe.MaXe
				WHERE SoLuongThue >= SoLuong)
			begin
				RAISERROR(N'Số lượng không đủ',16,1)
				ROLLBACK TRAN
			END
		ELSE 
			BEGIN
			    UPDATE Xe SET SoLuong = SoLuong - SoLuongThue
				FROM Xe join Inserted ON Inserted.MaXe = Xe.MaXe
			END	
	END

--TEST
-- TH1:  không hợp lệ
SELECT * FROM  dbo.ThueXe
SELECT * FROM dbo.Xe
INSERT INTO ThueXe VALUES(	N'HD013', N'KH01', N'XE01', 1,  21)
SELECT * FROM  dbo.ThueXe
SELECT * FROM dbo.Xe
-- TH2:  hợp lệ
SELECT * FROM  dbo.ThueXe
SELECT * FROM dbo.Xe
INSERT INTO ThueXe VALUES(	N'HD011', N'KH01', N'XE01', 1,  11)
SELECT * FROM  dbo.ThueXe
SELECT * FROM dbo.Xe