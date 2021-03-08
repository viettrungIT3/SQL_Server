CREATE DATABASE BANHANG
ON PRIMARY (
	NAME = 'BanHang__DAT',
	FILENAME ='E:\SQL Server Management Studio\FORM\BANHANG.mdf',
	SIZE = 2MB,
	MAXSIZE = 10MB,
	FILEGROWTH = 20%
)
LOG ON(
	NAME = 'BanHang__LOG',
	FILENAME ='E:\SQL Server Management Studio\FORM\BANHANG.ldf',
	SIZE = 1MB,
	MAXSIZE = 5MB,
	FILEGROWTH = 1MB
)

USE BANHANG
GO

CREATE TABLE HangSX
(
	MaHangSX NCHAR(10) PRIMARY KEY,
	TenHang NCHAR(20) NOT NULL,
	DiaChi NVARCHAR(30),
	SoDT CHAR(20),
	Email CHAR(30)
)
GO

CREATE TABLE SANPHAM
(
	MASP NCHAR(10) PRIMARY KEY,
	MAHANGSX NCHAR(10) NOT NULL,
	TenSP NVARCHAR(20) NOT NULL,
	SoLuong INT,
	MauSac NVARCHAR(20),
	GiaBan MONEY,
	DonViTinh NCHAR(10),
	MoTa NVARCHAR(MAX)
	FOREIGN KEY (MAHANGSX) REFERENCES dbo.HangSX,
)
GO

CREATE TABLE NhanVien
(
	MaNV NCHAR(10) PRIMARY KEY,
	TenNV NVARCHAR(20),
	GioiTinh NCHAR(10),
	DiaChi NVARCHAR(30),
	SoDT CHAR(20),
	Email CHAR(30),
	TenPhong NVARCHAR(30)
)
GO
CREATE TABLE PNhap(
	SoHDN NCHAR(10) PRIMARY KEY,
	NgayNhap DATETIME,
	MaNV NCHAR(10) NOT NULL,
	FOREIGN KEY (MaNV) REFERENCES dbo.NhanVien(MaNV)
)
GO
CREATE TABLE Nhap(
	SoHDN NCHAR(10) NOT NULL,
	MaSP NCHAR(10) NOT NULL,
	SoLuongN INT,
	DonGiaN MONEY,
	PRIMARY KEY (SoHDN,MaSP),
	FOREIGN KEY (SoHDN) REFERENCES dbo.PNhap(SoHDN),
	FOREIGN KEY (MaSP) REFERENCES dbo.SANPHAM(MASP)
)
GO
CREATE TABLE PXuat(
	SoHDX NCHAR(10) PRIMARY KEY,
	NgayXuat DATETIME,
	MaNV NCHAR(10) NOT NULL,
	FOREIGN KEY (MaNV) REFERENCES dbo.NhanVien(MaNV)
)
GO
CREATE TABLE Xuat(
	SoHDX NCHAR(10) NOT NULL, 
	MaSP NCHAR(10) NOT NULL,
	SoLuongX INT,
	PRIMARY KEY (SoHDX,MaSP),
	FOREIGN KEY (SoHDX) REFERENCES dbo.PXuat(SoHDX),
	FOREIGN KEY (MaSP) REFERENCES dbo.SANPHAM(MASP)
)

GO

--Data
INSERT INTO dbo.HangSX VALUES
(   N'H01', N'SamSung', N'Korea', '01108271717',  'ss@gmail.com.kr'   ),
(   N'H02', N'OPPO', N'China', '08108626262',  'oppo@gmail.com.cn'   ),
(   N'H03', N'Vinfone', N'Việt nam', '084098262626',  ' vf@gmail.com.vn'   )

GO 
--SELECT * FROM dbo.HangSX
GO 
INSERT INTO dbo.NhanVien VALUES
(   N'NV01', N'Nguyễn Thị Thu', N'Nữ', N'Hà Nội', '0982626521',  'thu@gmail.com',  N'Kế toán'  ),
(   N'NV02', N'Lê Văn Nam', N'Nam', N'Bắc Ninh', '0972525252',  'nam@gmail.com',  N'Vật tư'  ),
(   N'NV03', N'Trần Hoà Bình', N'Nữ', N'Hà Nội', '038388388',  'hb@gmail.com',  N'Kế toán'  )
GO 
--SELECT * FROM dbo.NhanVien
GO
INSERT INTO dbo.SANPHAM VALUES
(   N'SP01',  N'H02',  N'F1 Plus',  100,    N'Xám',  7000000, N'Chiếc',  N'Hàng cận cao cấp'   ),
(   N'SP02',  N'H01',  N'Galaxy Note11',  50,    N'Đỏ',  19000000, N'Chiếc',  N'Hàng cao cấp'   ),
(   N'SP03',  N'H02',  N'F3 lite',  200,    N'Nâu',  3000000, N'Chiếc',  N'Hàng phổ thông'   ),
(   N'SP04',  N'H03',  N'Vjoy3',  200,    N'Xám',  1500000, N'Chiếc',  N'Hàng phổ thông'   ),
(   N'SP05',  N'H01',  N'Galaxy V21',  500,    N'Nâu',  8000000, N'Chiếc',  N'Hàng cận cao cấp'   ),
(   N'SP06',  N'H01',  N'Galaxy S2',  0,    N'Nâu',  800000, N'Chiếc',  N'Hàng phổ thông'   )
GO 
--SELECT * FROM dbo.SANPHAM
GO 
INSERT INTO dbo.PNhap VALUES
(   N'N01',   '20190205',  N'NV01'   ),
(   N'N02',   '20200407',  N'NV02'   ),
(   N'N03',   '20200517',  N'NV02'   ),
(   N'N04',   '20200322',  N'NV03'   ),
(   N'N05',   '20200707',  N'NV01'   )
GO
--SELECT * FROM dbo.PNhap
GO 
INSERT INTO dbo.Nhap VALUES
(   N'N01', N'SP02', 10,   17000000 ),
(   N'N02', N'SP01', 30,   6000000 ),
(   N'N03', N'SP04', 20,   1200000 ),
(   N'N04', N'SP01', 10,   6200000 ),
(   N'N05', N'SP05', 20,   7000000 )
GO 
--SELECT * FROM dbo.PNhap INNER JOIN dbo.Nhap ON Nhap.SoHDN = PNhap.SoHDN
GO
INSERT INTO dbo.PXuat VALUES
(   N'X01',  '20200614', N'NV02'  ),
(   N'X02',  '20190305', N'NV03'  ),
(   N'X03',  '20201212', N'NV01'  ),
(   N'X04',  '20200602', N'NV02'  ),
(   N'X05',  '20200518', N'NV01'  )
GO 
--SELECT * FROM dbo.PXuat
GO 
INSERT INTO dbo.Xuat VALUES
(   N'X01', N'SP03', 5    ),
(   N'X02', N'SP01', 3    ),
(   N'X03', N'SP02', 1    ),
(   N'X04', N'SP03', 2    ),
(   N'X05', N'SP05', 1    )
GO 
--SELECT * FROM dbo.Xuat INNER JOIN dbo.PXuat ON PXuat.SoHDX = Xuat.SoHDX

--Delete table
/*
DROP TABLE dbo.Nhap
DROP TABLE dbo.PNhap
DROP TABLE dbo.Xuat
DROP TABLE dbo.PXuat
DROP TABLE dbo.NhanVien
DROP TABLE dbo.SANPHAM
DROP TABLE dbo.HangSX
*/

--Display
/*
SELECT * FROM dbo.SANPHAM
SELECT * FROM dbo.HangSX
SELECT * FROM dbo.NhanVien
SELECT * FROM dbo.Nhap
SELECT * FROM dbo.PNhap
SELECT * FROM dbo.Xuat
SELECT * FROM dbo.PXuat
*/

--Bài tập thêm
--Câu 1 : Hãy tạo hàm in ra tổng tiền hàng bán theo năm là bao nhiêu? (Với tham số vào là: Năm).
CREATE FUNCTION fn_TongTienTheoNam ( @nam INT)
RETURNS MONEY 
AS BEGIN
	DECLARE @tongtien MONEY
	SELECT @tongtien = SUM(SoLuongX*GiaBan)
	FROM dbo.Xuat	INNER JOIN dbo.PXuat ON PXuat.SoHDX = Xuat.SoHDX
					INNER JOIN dbo.SANPHAM ON SANPHAM.MASP = Xuat.MaSP
	WHERE YEAR(NgayXuat) = @nam
	RETURN @tongtien
END
GO 
SELECT dbo.fn_TongTienTheoNam(2020) AS N'Tổng tiền'

--Câu 2: Viết hàm với tham số truyền vào là SoHDX, hàm trả về một bảng gồm các thông tin:
--SoHDX,NgayXuat, MaSP, GiaBan, SLXuat, NgayThu. Trong đó: Cột NgayThu sẽ là: chủ nhật, thứ hai, ..., thứ bảy (dựa vào giá trị của cột NgayXuat)(Dùng Case)
GO

CREATE FUNCTION fn_Cau2 ( @SoHDX NVARCHAR(10))
RETURNS @bang TABLE (
	soHDX NVARCHAR(10),
	ngayXuat DATETIME,
	maSP NVARCHAR(10),
	giaBan MONEY,
	SLXuat INT,
	ngayThu NVARCHAR(20)
)
AS BEGIN
	INSERT INTO @bang 
	SELECT PXuat.SoHDX, NgayXuat, Xuat.MaSP, GiaBan, SoLuongX, ngayThu = 
	(CASE	
		WHEN DATEPART(dw, NgayXuat) = 1 THEN N'Chủ nhật'
		WHEN DATEPART(dw, NgayXuat) = 2 THEN N'Thứ 2'
		WHEN DATEPART(dw, NgayXuat) = 3 THEN N'Thứ 3'
		WHEN DATEPART(dw, NgayXuat) = 4 THEN N'Thứ 4'
		WHEN DATEPART(dw, NgayXuat) = 5 THEN N'Thứ 5'
		WHEN DATEPART(dw, NgayXuat) = 6 THEN N'Thứ 6'
		WHEN DATEPART(dw, NgayXuat) = 7 THEN N'Thứ 7'
	END)
	FROM dbo.Xuat INNER JOIN dbo.PXuat ON PXuat.SoHDX = Xuat.SoHDX
	INNER JOIN dbo.SANPHAM ON SANPHAM.MASP = Xuat.MaSP
	RETURN
END
SELECT * FROM dbo.fn_Cau2('X01')

--WORK

--a. Hãy xây dựng hàm đưa ra thông tin các sản phẩm của hãng có tên nhập từ bàn phím.
GO 
CREATE FUNCTION fn_DsSPTheoHangSX( @TenHang NVARCHAR(20))
RETURNS @bang TABLE (
	MaSP NVARCHAR(10),
	TenSP NVARCHAR(20),
	SoLuong INT,
	MauSac NVARCHAR(20),
	GiaBan MONEY,
	DonViTinh NVARCHAR(10),
	MoTa NVARCHAR(MAX)
)
AS BEGIN
       INSERT INTO @bang
				Select MaSP, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa
				From SanPham Inner join HangSX
				on SanPham.MaHangSX = HangSX.MaHangSX
				WHERE TenHang = @TenHang
		RETURN
   END

-- Gọi hàm
GO
SELECT * FROM dbo.fn_DsSPTheoHangSX('Samsung')

--b. Hãy viết hàm Đưa ra danh sách các sản phẩm và từ ngày x đến ngày y, 
--với x,y nhập từ bàn phím.
GO
CREATE FUNCTION fn_DsSPNhapTheoNgay(@x DATETIME, @y DATETIME)
RETURNS @bang TABLE(
			MaSP NVARCHAR(10),
			TenSP NVARCHAR(20),
			TenHang NVARCHAR(20),
			NgayNhap DATETIME,
			SoLuongN INT,
			DonGiaN FLOAT
)
AS 
BEGIN
	INSERT INTO @bang 
		SELECT dbo.SANPHAM.MASP, TenSP, TenHang, NgayNhap, SoLuongN, DonGiaN
		FROM dbo.Nhap	INNER JOIN dbo.SANPHAM ON SANPHAM.MASP = Nhap.MaSP
						INNER JOIN dbo.HangSX ON HangSX.MaHangSX = SANPHAM.MAHANGSX
						INNER JOIN dbo.PNhap ON PNhap.SoHDN = Nhap.SoHDN
		WHERE NgayNhap BETWEEN @x AND @y
	RETURN
END
--gọi hàm
GO 
SELECT * FROM dbo.fn_DsSPNhapTheoNgay('20190209', '20210309')


/*c. Hãy xây dựng hàm Đưa ra danh sách các sản phẩm theo hãng sản xuất và 1 lựa chọn,
nếu lựa chọn = 0 thì Đưa ra danh sách các sản phẩm có SoLuong = 0, ngược lại lựa chọn
=1 thì Đưa ra danh sách các sản phẩm có SoLuong >0.
*/

GO
CREATE FUNCTION fn_dsSPTheoSL ( @tenHang NVARCHAR(20), @Flag INT)
RETURNS @bang TABLE (
			MaSP NVARCHAR(10),
			TenSP NVARCHAR(20),
			TenHang NVARCHAR(20),
			SoLuong INT,
			MauSac NVARCHAR(20),
			GiaBan MONEY,
			DonViTinh NVARCHAR(10),
			MoTa NVARCHAR(max)
)
AS BEGIN
       IF ( @Flag = 0 )
			INSERT INTO @bang
			SELECT MaSP, TenHang, TenHang, SoLuong, MauSac,GiaBan, DonViTinh,MoTa
			FROM dbo.SANPHAM INNER JOIN dbo.HangSX ON HangSX.MaHangSX = SANPHAM.MAHANGSX
			WHERE TenHang = @tenHang AND SoLuong = 0
		ELSE 
			IF (@Flag = 1)
			INSERT INTO @bang
			SELECT MaSP, TenHang, TenHang, SoLuong, MauSac,GiaBan, DonViTinh,MoTa
			FROM dbo.SANPHAM INNER JOIN dbo.HangSX ON HangSX.MaHangSX = SANPHAM.MAHANGSX
			WHERE TenHang = @tenHang AND SoLuong > 0
		RETURN
   END
GO 

--gọi hàm
SELECT * FROM dbo.fn_dsSPTheoSL('Samsung', 0)
SELECT * FROM dbo.fn_dsSPTheoSL('Samsung', 1)
GO 
--d. Hãy xây dựng hàm Đưa ra danh sách các nhân viên có tên phòng nhập từ bàn phím.
CREATE FUNCTION fn_dsNV ( @tenPhong NVARCHAR(20))
RETURNS @bang TABLE (
		MaNV NCHAR(10) ,
		TenNV NVARCHAR(20),
		GioiTinh NCHAR(10),
		DiaChi NVARCHAR(30),
		SoDT CHAR(20),
		Email CHAR(30),
		TenPhong NVARCHAR(30)
)
AS 
BEGIN
	INSERT INTO @bang 
	SELECT MaNV, TenNV, GioiTinh, DiaChi, SoDT, Email, TenPhong
	FROM dbo.NhanVien
	WHERE TenPhong = @tenPhong
	RETURN
END
GO 
SELECT * FROM dbo.fn_dsNV(N'Kế toán')

--e. Hãy tạo hàm Đưa ra danh sách các hãng sản xuất có địa chỉ nhập vào từ bàn phím 
GO
CREATE FUNCTION fn_dsHangSX ( @diaChi NVARCHAR(30))
RETURNS @bang TABLE (
		MaHangSX NCHAR(10),
		TenHang NCHAR(10) NOT NULL,
		DiaChi NVARCHAR(30)
)
AS 
BEGIN
	INSERT INTO @bang 
	SELECT MaHangSX, TenHang, DiaChi
	FROM dbo.HangSX
	WHERE DiaChi LIKE @diaChi
	RETURN
END
GO
SELECT * FROM dbo.fn_dsHangSX(N'Việt nam')

--f. Hãy viết hàm Đưa ra danh sách các sản phẩm và hãng sản xuất tương ứng đã được xuất
--từ năm x đến năm y, với x,y nhập từ bàn phím.
GO 
CREATE FUNCTION fn_dsSPvaHangSX ( @x INT, @y INT)
RETURNS @bang TABLE (
	maSP NCHAR(10),
	tenSP NVARCHAR(20),
	maHang NVARCHAR(10),
	tenHang NVARCHAR(20),
	Nam INT
)
AS BEGIN
	INSERT INTO @bang 
	SELECT SANPHAM.MASP, TenSP, HangSX.MaHangSX, TenHang, YEAR(NgayXuat)
	FROM dbo.SANPHAM	INNER JOIN dbo.HangSX ON HangSX.MaHangSX = SANPHAM.MAHANGSX
						INNER JOIN dbo.Xuat ON Xuat.MaSP = SANPHAM.MASP
						INNER JOIN dbo.PXuat ON PXuat.SoHDX = Xuat.SoHDX
	WHERE YEAR(NgayXuat) BETWEEN @x AND @y
	RETURN
END
GO
SELECT * FROM dbo.fn_dsSPvaHangSX( 2018, 2021)

--g. Hãy xây dựng hàm Đưa ra danh sách các sản phẩm theo hãng sản xuất và 1 lựa chọn,
--nếu lựa chọn = 0 thì Đưa ra danh sách các sản phẩm đã được nhập, ngược lại lựa chọn =1
--thì Đưa ra danh sách các sản phẩm đã được xuất.
GO
CREATE FUNCTION fn_dsSPTheoHangSXNhapOrXuat ( @tenHang NVARCHAR(20), @Flag INT)
RETURNS @bang TABLE (
	maSP NVARCHAR(10),
	tenSP NVARCHAR(20),
	maHangSX NVARCHAR(10),
	tenHang NVARCHAR(20)
)
AS BEGIN
	IF ( @Flag = 0)
		INSERT INTO @bang 
		SELECT SANPHAM.MASP, TenSP, HangSX.MaHangSX, TenHang
		FROM dbo.SANPHAM	INNER JOIN  dbo.Nhap ON Nhap.MaSP = SANPHAM.MASP
							INNER JOIN dbo.HangSX ON HangSX.MaHangSX = SANPHAM.MAHANGSX
		WHERE TenHang = @tenHang
	ELSE 
		INSERT INTO @bang 
		SELECT SANPHAM.MASP, TenSP, HangSX.MaHangSX, TenHang
		FROM dbo.SANPHAM	INNER JOIN  dbo.Xuat ON Xuat.MaSP = SANPHAM.MASP
							INNER JOIN dbo.HangSX ON HangSX.MaHangSX = SANPHAM.MAHANGSX
		WHERE TenHang = @tenHang
	RETURN
END
GO 
SELECT * FROM dbo.fn_dsSPTheoHangSXNhapOrXuat(N'Sumsung', 0)
SELECT * FROM dbo.fn_dsSPTheoHangSXNhapOrXuat(N'Sumsung', 1)

--h. Hãy xây dựng hàm Đưa ra danh sách các nhân viên đã nhập hàng vào ngày được đưa vào từ bàn phím.
GO 
CREATE FUNCTION fn_dsNVNhapHangVaoNgay ( @ngay DATETIME )
RETURNS @bang TABLE (
		MaNV NCHAR(10) PRIMARY KEY,
		TenNV NVARCHAR(20),
		GioiTinh NCHAR(10),
		DiaChi NVARCHAR(30),
		SoDT CHAR(20),
		Email CHAR(30),
		TenPhong NVARCHAR(30),
		ngay DATETIME
)
AS
	BEGIN 
		INSERT INTO @bang 
		SELECT NhanVien.MaNV, TenNV, GioiTinh, DiaChi, SoDT, Email, TenPhong, NgayNhap
		FROM dbo.NhanVien INNER JOIN dbo.PNhap ON PNhap.MaNV = NhanVien.MaNV
		WHERE NgayNhap = @ngay
		RETURN
	END
GO 
SELECT * FROM dbo.fn_dsNVNhapHangVaoNgay('20190205')

--i. Hãy xây dựng hàm Đưa ra danh sách các sản phẩm có giá bán từ x đến y, do công ty z
--sản xuất, với x,y,z nhập từ bàn phím.
GO 
CREATE FUNCTION fn_dsCacSPdoCongTy ( @congTy NVARCHAR(20), @x MONEY, @y MONEY)
RETURNS @bang TABLE (
		MaSP NVARCHAR(10),
		TenSP NVARCHAR(20),
		TenHang NVARCHAR(20),
		SoLuong INT,
		MauSac NVARCHAR(20),
		GiaBan MONEY,
		DonViTinh NVARCHAR(10),
		MoTa NVARCHAR(MAX)
)
AS 
	BEGIN
		INSERT INTO @bang 
		SELECT MASP, TenSP, TenHang, SoLuong, MauSac, GiaBan, DonViTinh, MoTa
		FROM dbo.SANPHAM INNER JOIN dbo.HangSX ON HangSX.MaHangSX = SANPHAM.MAHANGSX
		WHERE TenHang = @congTy AND ( GiaBan BETWEEN @x AND @y )
		RETURN
	END
GO 
SELECT * FROM dbo.fn_dsCacSPdoCongTy(N'Samsung', 1000000, 10000000)

---j. Hãy xây dựng hàm không tham biến Đưa ra danh sách các sản phẩm và hãng sản xuất tương ứng.
GO 
CREATE FUNCTION fn_dsCacSpvaHangSX ()
RETURNS @bang TABLE (
		MaSP NVARCHAR(10),
		TenSP NVARCHAR(20),
		maHangSX NVARCHAR(10),
		TenHang NVARCHAR(20)
)
AS 
	BEGIN 
		INSERT INTO @bang 
		SELECT MASP, TenSP, HangSX.MaHangSX, TenHang
		FROM dbo.SANPHAM INNER JOIN dbo.HangSX ON HangSX.MaHangSX = SANPHAM.MAHANGSX
		RETURN
	END
GO 
SELECT * FROM dbo.fn_dsCacSpvaHangSX()