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
	TenHang NCHAR(10) NOT NULL,
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
--DEMO
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

--Data
INSERT INTO dbo.HangSX VALUES
(   N'H01', N'SamSung', N'Korea', '01108271717',  'ss@gmail.com.kr'   ),
(   N'H02', N'OPPO', N'China', '08108626262',  'oppo@gmail.com.cn'   ),
(   N'H03', N'Vinfone', N'Việt nam', '084098262626',  ' vf@gmail.com.vn'   )

GO 
SELECT * FROM dbo.HangSX
GO 
INSERT INTO dbo.NhanVien VALUES
(   N'NV01', N'Nguyễn Thị Thu', N'Nữ', N'Hà Nội', '0982626521',  'thu@gmail.com',  N'Kế toán'  ),
(   N'NV02', N'Lê Văn Nam', N'Nam', N'Bắc Ninh', '0972525252',  'nam@gmail.com',  N'Vật tư'  ),
(   N'NV03', N'Trần Hoà Bình', N'Nữ', N'Hà Nội', '038388388',  'hb@gmail.com',  N'Kế toán'  )
GO 
SELECT * FROM dbo.NhanVien
GO
INSERT INTO dbo.SANPHAM VALUES
(   N'SP01',  N'H02',  N'F1 Plus',  100,    N'Xám',  7000000, N'Chiếc',  N'Hàng cận cao cấp'   ),
(   N'SP02',  N'H01',  N'Galaxy Note11',  50,    N'Đỏ',  19000000, N'Chiếc',  N'Hàng cao cấp'   ),
(   N'SP03',  N'H02',  N'F3 lite',  200,    N'Nâu',  3000000, N'Chiếc',  N'Hàng phổ thông'   ),
(   N'SP04',  N'H03',  N'Vjoy3',  200,    N'Xám',  1500000, N'Chiếc',  N'Hàng phổ thông'   ),
(   N'SP05',  N'H01',  N'Galaxy V21',  500,    N'Nâu',  8000000, N'Chiếc',  N'Hàng cận cao cấp'   )
GO 
SELECT * FROM dbo.SANPHAM
GO 
INSERT INTO dbo.PNhap VALUES
(   N'N01',   '20190205',  N'NV01'   ),
(   N'N02',   '20200407',  N'NV02'   ),
(   N'N03',   '20200517',  N'NV02'   ),
(   N'N04',   '20200322',  N'NV03'   ),
(   N'N05',   '20200707',  N'NV01'   )
GO
SELECT * FROM dbo.PNhap
GO 
INSERT INTO dbo.Nhap VALUES
(   N'N01', N'SP02', 10,   17000000 ),
(   N'N02', N'SP01', 30,   6000000 ),
(   N'N03', N'SP04', 20,   1200000 ),
(   N'N04', N'SP01', 10,   6200000 ),
(   N'N05', N'SP05', 20,   7000000 )
GO 
SELECT * FROM dbo.PNhap INNER JOIN dbo.Nhap ON Nhap.SoHDN = PNhap.SoHDN
GO
INSERT INTO dbo.PXuat VALUES
(   N'X01',  '20200614', N'NV02'  ),
(   N'X02',  '20190305', N'NV03'  ),
(   N'X03',  '20201212', N'NV01'  ),
(   N'X04',  '20200602', N'NV02'  ),
(   N'X05',  '20200518', N'NV01'  )
GO 
SELECT * FROM dbo.PXuat
GO 
INSERT INTO dbo.Xuat VALUES
(   N'X01', N'SP03', 5    ),
(   N'X02', N'SP01', 3    ),
(   N'X03', N'SP02', 1    ),
(   N'X04', N'SP03', 2    ),
(   N'X05', N'SP05', 1    )
GO 
SELECT * FROM dbo.Xuat INNER JOIN dbo.PXuat ON PXuat.SoHDX = Xuat.SoHDX

--Display
SELECT * FROM dbo.SANPHAM
SELECT * FROM dbo.HangSX
SELECT * FROM dbo.NhanVien
SELECT * FROM dbo.Nhap
SELECT * FROM dbo.PNhap
SELECT * FROM dbo.Xuat
SELECT * FROM dbo.PXuat