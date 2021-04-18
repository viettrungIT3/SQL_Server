CREATE DATABASE DE26

GO 
USE DE26
GO

--Create table
CREATE TABLE BenhVien
(
	maBV NVARCHAR(10) PRIMARY KEY,
	tenBV NVARCHAR(50) NOT NULL, 
	diaChi NVARCHAR(80) NOT NULL,
	dienThoai NVARCHAR(15) NOT NULL
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
	dienThoai NVARCHAR(15),
	FOREIGN KEY (maKhoa) REFERENCES KhoaKham(maKhoa)
)

--Insert data
INSERT INTO BenhVien VALUES 
(	N'BV01', N'Benh Vien 1', N'Hà Nội', '1234567890'),
(	N'BV02', N'Benh Vien 2', N'Hà Nội', '0123456789')

GO
INSERT INTO KhoaKham VALUES
(	N'K01',	N'Khoa 01', 100, N'BV01'),
(	N'K02',	N'Khoa 02', 100, N'BV02')
GO
INSERT INTO BenhNhan VALUES
(	N'BN001', N'Benh nhan 1', GETDATE(), 1, 14, N'K01', '0123456789'),
(	N'BN002', N'Benh nhan 2', GETDATE(), 1, 24, N'K01', '0123456789'),
(	N'BN003', N'Benh nhan 3', GETDATE(), 1, 14, N'K01', '0123456789'),
(	N'BN004', N'Benh nhan 4', GETDATE(), 1, 24, N'K01', '0123456789'),
(	N'BN005', N'Benh nhan 5', GETDATE(), 1, 14, N'K01', '0123456789'),
(	N'BN006', N'Benh nhan 6', GETDATE(), 1, 16, N'K01', '0123456789'),
(	N'BN007', N'Benh nhan 7', GETDATE(), 1, 10, N'K01', '0123456789')

--Display data
SELECT * FROM BenhVien
SELECT * FROM KhoaKham
SELECT * FROM BenhNhan

-- Câu 2: Hãy tạo thủ tục đưa ra tổng số tiền thu được của từng khoa khám bệnh là 
--bao nhiêu> ( với tham số nhập từ bản phím là: tenkhoa, Tien = soNgayNV*120000)
GO
CREATE PROC sp_Cau2 (@tenKhoa NVARCHAR(10))
AS
	BEGIN
	    IF ( NOT EXISTS ( SELECT * FROM dbo.KhoaKham WHERE tenKhoa = @tenKhoa))
			PRINT N'Khoa ' + @tenKhoa + N' khong ton tai'
		ELSE 
			SELECT tenKhoa, SUM(soNgayNamVien * 120000) AS 'Tong tien'
			FROM dbo.KhoaKham INNER JOIN dbo.BenhNhan ON BenhNhan.maKhoa = KhoaKham.maKhoa
			WHERE tenKhoa = @tenKhoa
			GROUP BY tenKhoa
	END

GO 
--test
-- TH1: khoa do không tồn tại
EXEC dbo.sp_Cau2 @tenKhoa = N'Khoa 03' -- nvarchar(10)
-- TH2: khoa do ton tai
EXEC dbo.sp_Cau2 @tenKhoa = N'Khoa 01' -- nvarchar(10)



--Cau 3(4đ): hãy tạo trigger để thêm 1 bệnh nhân. nếu số điện thoại không hợp lệ(khác 10 số) 
--thì thông báo lỗi.
go 
ALTER TABLE dbo.BenhNhan NOCHECK CONSTRAINT ALL
go
ALTER TRIGGER tg_Cau3 ON BenhNhan
for Insert 
AS 
	BEGIN
		DECLARE @sdt NVARCHAR(15)
		SELECT @sdt = dienThoai FROM Inserted
		IF ( LEN(@sdt) > 10 OR LEN(@sdt) < 10)
		BEGIN
			RAISERROR (N'Số điện thoại không hợp lệ', 16, 1)
			ROLLBACK TRAN
		END
	END

--TEST
--TH1: sđt không hợp lệ
INSERT INTO BenhNhan VALUES
(	N'BN009', N'Benh nhan 1', GETDATE(), 1, 14, N'K02', '123456789')
--TH2: sđt hợp lệ
SELECT * from dbo.BenhNhan
INSERT INTO BenhNhan VALUES
(	N'BN009', N'Benh nhan 1', GETDATE(), 1, 14, N'K02', '0123456789')
SELECT * FROM dbo.BenhNhan

