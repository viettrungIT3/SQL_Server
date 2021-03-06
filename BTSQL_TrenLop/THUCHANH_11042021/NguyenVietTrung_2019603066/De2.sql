CREATE DATABASE QLbanhang2
GO
USE QLbanhang2
GO

CREATE TABLE VatTu(
	MaVT NVARCHAR(10) PRIMARY KEY NOT NULL, 
	TenVT NVARCHAR(30) NOT NULL, 
	DVTinh NVARCHAR(10),
	SLCon INT
)
GO
CREATE TABLE HoaDon(
	MaHD NVARCHAR(10) PRIMARY KEY NOT NULL, 
	NgayLap DATETIME, 
	HoTenKhach NVARCHAR(30)
)
GO
CREATE TABLE CTHoaDon(
	MaHD NVARCHAR(10) NOT NULL,
	MaVT NVARCHAR(10) NOT NULL,
	DonGiaBan FLOAT,
	SLBan INT,
	PRIMARY KEY ( MaHD, MaVT),
	FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT),
	FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD)
)

GO
INSERT INTO VatTu VALUES
(	N'VT01', N'Vat tu 1',	N'Bao', 1000),
(	N'VT02', N'Vat tu 2',	N'Vien', 10000),
(	N'VT03', N'Vat tu 3',	N'Vien', 15000)
go
INSERT INTO HoaDon VALUES 
(	N'HD01', GETDATE(), N'Hoa don 1'),
(	N'HD02', GETDATE(), N'Hoa don 2'),
(	N'HD03', GETDATE(), N'Hoa don 3')
GO
INSERT INTO CTHoaDon VALUES 
(	N'HD01', N'VT02', 10000, 5000),
(	N'HD01', N'VT01', 50000, 50),
(	N'HD02', N'VT03', 20000, 10000),
(	N'HD03', N'VT02', 15000, 3000),
(	N'HD03', N'VT03', 20000, 2000)


GO
SELECT * FROM VatTu
SELECT * FROM HoaDon
SELECT * FROM CTHoaDon

/*
Câu 2: (2.5. điểm)
Tạo Hàm đưa ra tổng tiền bán hàng của vật tư có tên vật tư và ngày tháng năm
bán được nhập vào từ bàn phím. Tiền bán hàng = đơn giá bán * số lượng bán
*/
GO
CREATE FUNCTION fn_Cau2( @TenVT NVARCHAR(30), @ngay DATETIME)
RETURN  FLOAT
AS
	BEGIN 
		DECLARE @TienBan float
		SELECT @TienBan = SUM(DonGiaBan*SLBan)
		FROM CTHoaDon INNER JOIN HoaDon ON CTHoaDon.MaHD = HoaDon.MaHD
		WHERE ( YEAR(NgayLap) = YEAR(@ngay))
		RETURN @TienBan
	END