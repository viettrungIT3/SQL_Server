CREATE DATABASE BANHANG
USE BANHANG
GO

CREATE TABLE HangSX
(
	MaHangSX CHAR(5) PRIMARY KEY,
	TenHang NCHAR(10) NOT NULL,
	DiaChi NCHAR(30),
	SoDT CHAR(11),
	Email CHAR(30)
)
GO

CREATE TABLE SANPHAM
(
	MASP CHAR(5) PRIMARY KEY,
	MAHANGSX CHAR(5) NOT NULL,
	TenSP NCHAR(10) NOT NULL,
	SoLuong TINYINT,
	MauSac NCHAR(5),
	GiaBan MONEY,
	DonViTinh TINYINT,
	MoTa NCHAR(30)
	FOREIGN KEY (MAHANGSX) REFERENCES dbo.HangSX,
)
GO

CREATE TABLE NhanVien
(
	MaNV CHAR(5) PRIMARY KEY,
	TenNV NCHAR(10),
	GioiTinh BIT,
	DiaChi NCHAR(30),
	SoDT CHAR(11),
	Email CHAR(30),
	TenPhong CHAR(5)
)
GO

CREATE TABLE PNhap(
	SoHDN CHAR(5) PRIMARY KEY,
	NgayNhap DATETIME,
	MaNV CHAR(5) NOT NULL,
	FOREIGN KEY (MaNV) REFERENCES dbo.NhanVien(MaNV)
)
GO
CREATE TABLE Nhap(
	SoHDN CHAR(5) NOT NULL,
	MaSP CHAR(5) NOT NULL,
	SoLuongN TINYINT,
	DonGiaN MONEY,
	PRIMARY KEY (SoHDN,MaSP),
	FOREIGN KEY (SoHDN) REFERENCES dbo.PNhap(SoHDN),
	FOREIGN KEY (MaSP) REFERENCES dbo.SANPHAM(MASP)
)
GO
CREATE TABLE PXuat(
	SoHDX CHAR(5) PRIMARY KEY,
	NgayXuat DATETIME,
	MaNV CHAR(5) NOT NULL,
	FOREIGN KEY (MaNV) REFERENCES dbo.NhanVien(MaNV)
)
GO
CREATE TABLE Xuat(
	SoHDX CHAR(5) NOT NULL, 
	MaSP CHAR(5) NOT NULL,
	SoLuongX TINYINT,
	PRIMARY KEY (SoHDX,MaSP),
	FOREIGN KEY (SoHDX) REFERENCES dbo.PXuat(SoHDX),
	FOREIGN KEY (MaSP) REFERENCES dbo.SANPHAM(MASP)
)

INSERT INTO dbo.HangSX VALUES( 'H001',   N'Hàng 1', N'abc', '123456789', 'ahihi@gmail.com'  )
INSERT INTO dbo.HangSX VALUES( 'H002',   N'Hàng 2', N'abc', '123456789', 'ahihi@gmail.com'  )
INSERT INTO dbo.HangSX VALUES( 'H003',   N'Hàng 3', N'abc', '123456789', 'ahihi@gmail.com'  )
INSERT INTO dbo.HangSX VALUES( 'H004',   N'Hang 4', N'abc', '123456789', 'ahihi@gmail.com'  )
SELECT * FROM dbo.HangSX

INSERT INTO dbo.SANPHAM VALUES( 'S001', 'H001', N'Sản Phẩm 1', 10,  N'đỏ',  10.0, 1, N'abc abc acb'  )
INSERT INTO dbo.SANPHAM VALUES( 'S002', 'H002', N'Sản Phẩm 2', 10,  N'đỏ',  10.0, 1, N'abc abc acb'  )
INSERT INTO dbo.SANPHAM VALUES( 'S003', 'H003', N'Sản Phẩm 3', 10,  N'đỏ',  10.0, 1, N'abc abc acb'  )

SELECT * FROM dbo.SANPHAM

INSERT INTO dbo.NhanVien VALUES( 'NV01', N'NV 1',  1, N'abc abc abc', '123456789', 'abc@gmail.com', 'P1' )
INSERT INTO dbo.NhanVien VALUES( 'NV02', N'NV 2',  1, N'abc abc abc', '123456789', 'abc@gmail.com', 'P1' )
INSERT INTO dbo.NhanVien VALUES( 'NV03', N'NV 3',  1, N'abc abc abc', '123456789', 'abc@gmail.com', 'P1' )
INSERT INTO dbo.NhanVien VALUES( 'NV04', N'NV 4',  1, N'abc abc abc', '123456789', 'abc@gmail.com', 'P1' )

SELECT * FROM dbo.NhanVien

INSERT INTO dbo.PNhap VALUES( 'PN01', GETDATE(), 'NV01' )
INSERT INTO dbo.PNhap VALUES( 'PN02', GETDATE(), 'NV02' )
INSERT INTO dbo.PNhap VALUES( 'PN03', GETDATE(), 'NV03' )
INSERT INTO dbo.PNhap VALUES( 'PN04', '20200202', 'NV03' )

SELECT * FROM dbo.PNhap

INSERT INTO dbo.Nhap VALUES( 'PN01', 'S001', 10, 100000 )
INSERT INTO dbo.Nhap VALUES( 'PN02', 'S002', 10, 100000 )
INSERT INTO dbo.Nhap VALUES( 'PN03', 'S003', 10, 100000 )

SELECT * FROM dbo.Nhap

INSERT INTO dbo.PXuat VALUES('X001', GETDATE(),'NV01')
INSERT INTO dbo.PXuat VALUES('X002', GETDATE(),'NV02')
INSERT INTO dbo.PXuat VALUES('X003', GETDATE(),'NV03')
INSERT INTO dbo.PXuat VALUES('X004', '20200202','NV03')

SELECT * FROM dbo.PXuat

INSERT INTO dbo.Xuat VALUES('X001', 'S001', 1 )
INSERT INTO dbo.Xuat VALUES('X002', 'S002', 1 )
INSERT INTO dbo.Xuat VALUES('X003', 'S003', 1 )

SELECT * FROM dbo.Xuat

GO
--a. Hãy xây dựng hàm Đưa ra tên HangSX khi nhập vào MaSP từ bàn phím
CREATE FUNCTION FN_TimHang (@MASP NCHAR(10))
RETURNS NCHAR(10)
AS
	BEGIN
		DECLARE @TEN NCHAR(10)
		SET @TEN = (SELECT tenHang FROM dbo.HangSX INNER JOIN dbo.SanPham 
					ON SanPham.maHangSX = HangSX.maHangSX
					WHERE maSP = @MASP)
		RETURN @TEN
	END
GO
--Gọi hàm
SELECT dbo.FN_TimHang('S001')
GO
--b. Hãy xây dựng hàm đưa ra tổng giá trị nhập từ năm nhập x đến năm nhập y, với x, y được
--nhập vào từ bàn phím.
CREATE FUNCTION fn_ThongKeTheoNam ( @x INT, @y INT)
RETURNS INT
AS 
	BEGIN
		DECLARE @tongTien INT
		SELECT @tongTien = SUM( SoLuongN)
		FROM dbo.Nhap INNER JOIN dbo.PNhap ON PNhap.SoHDN = Nhap.SoHDN
		WHERE YEAR(NgayNhap) BETWEEN @x AND @y
		RETURN @tongTien
	END
GO
--Gọi hàm
SELECT dbo.fn_ThongKeTheoNam(2020,2022)
GO
--c. Hãy viết hàm thống kê tổng số lượng thay đổi nhập xuất của tên sản phẩm x trong năm
--y, với x,y nhập từ bàn phím.
CREATE FUNCTION fn_ThongKeNhapXuat( @tenSP NCHAR(20), @nam INT)
RETURNS INT
AS BEGIN
	DECLARE @tongNhap INT
	DECLARE @tongXuat INT
	DECLARE @thayDoi INT
	SELECT @tongNhap = SUM( SoLuongN)
	FROM dbo.Nhap	INNER JOIN dbo.SANPHAM ON SANPHAM.MASP = Nhap.MaSP
					INNER JOIN dbo.PNhap ON PNhap.SoHDN = Nhap.SoHDN
	WHERE TenSP = @tenSP AND YEAR(NgayNhap) = @nam
	SELECT @tongXuat = SUM( SoLuongX)
	FROM dbo.Xuat	INNER JOIN dbo.SANPHAM ON SANPHAM.MASP = Xuat.MaSP
					INNER JOIN dbo.PXuat ON PXuat.SoHDX = Xuat.SoHDX
	WHERE TenSP = @tenSP AND YEAR(NgayXuat) = @nam
	SET @thayDoi = @tongNhap - @tongXuat
	RETURN @thayDoi
END
GO
--Goi ham
SELECT dbo.fn_ThongKeNhapXuat('Sản Phẩm 1', 2021)
GO
--d. Hãy xây dựng hàm Đưa ra tổng giá trị nhập từ ngày nhập x đến ngày nhập y, với x, y
--được nhập vào từ bàn phím.
CREATE FUNCTION fn_TongGiaTriNhap(@x DATETIME, @y DATETIME)
RETURNS INT
AS BEGIN
	DECLARE @tongNhap INT
	SELECT @tongNhap = SUM( SoLuongN)
	FROM dbo.Nhap	INNER JOIN dbo.SANPHAM ON SANPHAM.MASP = Nhap.MaSP
					INNER JOIN dbo.PNhap ON PNhap.SoHDN = Nhap.SoHDN
	WHERE (YEAR(NgayNhap) BETWEEN YEAR(@x) AND YEAR(@y)) 
			AND	(MONTH(NgayNhap) BETWEEN MONTH(@x) AND MONTH(@y))
			AND (DAY(NgayNhap) BETWEEN DAY(@x) AND DAY(@y))
	RETURN @tongNhap
END
--Goi ham
GO 
SELECT dbo.fn_TongGiaTriNhap('20210225', '20210227')
GO 
--e. Hãy xây dựng hàm Đưa ra tổng giá trị xuất của hãng tên hãng là A, trong năm tài khóa
--x, với A, x được nhập từ bàn phím.
CREATE FUNCTION fn_TongGiaTriXuat(@tenHang NCHAR(10), @ngay INT)
RETURNS INT
AS BEGIN
	DECLARE @tongXuat INT
	SELECT @tongXuat = SUM(SoLuongX)
	FROM dbo.Xuat	INNER JOIN dbo.SANPHAM ON SANPHAM.MASP = Xuat.MaSP
					INNER JOIN dbo.HangSX ON HangSX.MaHangSX = SANPHAM.MAHANGSX
					INNER JOIN dbo.PXuat ON PXuat.SoHDX = Xuat.SoHDX
	WHERE TenHang = @tenHang AND YEAR(NgayXuat) = @ngay
	RETURN @tongXuat
END
GO
SELECT dbo.fn_TongGiaTriXuat('Hàng 1', 2021)

--f. Hãy xây dựng hàm thống kê số lượng nhân viên mỗi phòng với tên phòng nhập từ bàn phím.
GO 
CREATE FUNCTION fn_ThongKeSLNhanVien (@tenPhong NCHAR(10))
RETURNS INT
AS BEGIN
	DECLARE @soLuong INT
	SELECT @soLuong = COUNT(*)
	FROM dbo.NhanVien
	WHERE TenPhong = @tenPhong
	RETURN @soLuong
END
GO
SELECT dbo.fn_ThongKeSLNhanVien('P1') 

--g. Hãy viết hàm thống kê xem tên sản phẩm x đã xuất được bao nhiêu sản phẩm trong ngày
--y, với x,y nhập từ bản phím
GO 
CREATE FUNCTION fn_ThongKeSanPhamTheoTen (@tenSP NCHAR(10), @y DATETIME)
RETURNS INT
AS BEGIN
	DECLARE @soLuong INT
	SELECT @soLuong = SUM( SoLuongX)
	FROM dbo.SANPHAM	INNER JOIN dbo.Xuat ON Xuat.MaSP = SANPHAM.MASP
						INNER JOIN dbo.PXuat ON PXuat.SoHDX = Xuat.SoHDX
	WHERE TenSP = @tenSP AND YEAR(NgayXuat) = YEAR(@y)
			AND MONTH(NgayXuat) = MONTH(@y) AND DAY(NgayXuat) = DAY(@y)
	RETURN @soLuong
END
GO
SELECT dbo.fn_ThongKeSanPhamTheoTen('Sản Phẩm 1', '20210226')

--h. Hãy viết hàm trả về số diện thoại của nhân viên đã xuất số hóa đơn x, với x nhập từ bàn phím.
GO 
CREATE FUNCTION fn_SoDienThoaiNV (@soHDX CHAR(10))
RETURNS CHAR(11)
AS BEGIN
	DECLARE @sdt CHAR(11)
	SELECT @sdt = SoDT
	FROM dbo.NhanVien INNER JOIN dbo.PXuat ON PXuat.MaNV = NhanVien.MaNV
	WHERE SoHDX = @soHDX
	RETURN @sdt
END
GO
SELECT dbo.fn_SoDienThoaiNV('X001')

--i. Hãy viết hàm thống kê tổng số lượng thay đổi nhập xuất của tên sản phẩm x trong năm
--y, với x,y nhập từ bàn phím.
-- giống ý c

GO 
--j. Hãy viết hàm thống kê tổng số lượng sản phầm của hãng x, với tên hãng nhập từ bàn phím.
CREATE FUNCTION fn_TongSPcuaHangX( @tenHang NCHAR(10))
RETURNS INT
AS BEGIN
	DECLARE @soLuong INT
	SELECT @soLuong = SUM(SoLuong)
	FROM dbo.HangSX INNER JOIN dbo.SANPHAM ON SANPHAM.MAHANGSX = HangSX.MaHangSX
	WHERE TenHang = @tenHang
	RETURN @soLuong
END 
GO
SELECT dbo.fn_TongSPcuaHangX('Hàng 1')
SELECT dbo.fn_TongSPcuaHangX('Hang 4')
