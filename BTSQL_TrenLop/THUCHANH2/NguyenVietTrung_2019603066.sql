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

-- Câu a Hãy thống kê xem mỗi hãng sản xuất có bao nhiêu loại sản phẩm
Select dbo.HangSX.MaHangSX, TenHang, Count(*) As N'Số lượng sp'
From SanPham Inner join HangSX on SanPham.MaHangSX = HangSX.MaHangSX
Group by HangSX.MaHangSX, TenHang

-- Câu b Hãy thống kê xem tổng tiền nhập của mỗi sản phẩm trong năm 2020.
Select dbo.SANPHAM.MaSP,TenSP, sum(SoLuongN*DonGiaN) As N'Tổng tiền nhập'
From Nhap Inner join dbo.SANPHAM on dbo.Nhap.MaSP = dbo.SANPHAM.MaSP
Inner join dbo.PNhap on dbo.PNhap.SoHDN=dbo.Nhap.SoHDN
Where Year(NgayNhap)=2020
Group by dbo.SANPHAM.MaSP,TenSP

-- Câu c Hãy thống kê các sản phẩm có tổng số lượng xuất năm 2020 là lớn hơn 10.000 sản phẩm của hãng Samsung.
Select SanPham.MaSP,TenSP,sum(SoLuongX) As N'Tổng xuất'
From Xuat Inner join SanPham	ON Xuat.MaSP = SanPham.MaSP
		  INNER join HangSX		ON HangSX.MaHangSX = SanPham.MaHangSX
		  INNER join PXuat		ON Xuat.SoHDX=PXuat.SoHDX
Where Year(NgayXuat)=2020 And TenHang = 'Samsung'
Group by SanPham.MaSP,TenSP
Having sum(SoLuongX) >=10000

-- Câu d Thống kê số lượng nhân viên Nam của mỗi phòng ban.
SELECT dbo.NhanVien.TenPhong AS 'Phong', COUNT(dbo.NhanVien.MaNV) AS 'So nhan vien nam'
FROM dbo.NhanVien
WHERE GioiTinh = 1
GROUP BY dbo.NhanVien.TenPhong

-- Câu e. Thống kê tổng số lượng nhập của mỗi hãng sản xuất trong năm 2018.
SELECT YEAR(dbo.PNhap.NgayNhap) AS 'Năm', SUM(dbo.Nhap.SoLuongN) AS 'TONG'
FROM dbo.PNhap INNER JOIN dbo.Nhap ON dbo.Nhap.SoHDN = dbo.PNhap.SoHDN
WHERE YEAR(dbo.PNhap.NgayNhap) = 2018
GROUP BY YEAR(dbo.PNhap.NgayNhap)

-- f. Hãy thống kê xem tổng lượng tiền xuất của mỗi nhân viên trong năm 2018 là bao nhiêu.
SELECT dbo.NhanVien.MaNV, TenNV, SUM(SoLuongX*GiaBan) AS 'Tong tien'
FROM dbo.PXUAT INNER JOIN dbo.XUAT ON XUAT.SoHDX = PXUAT.SoHDX
				INNER JOIN dbo.NhanVien ON NhanVien.MaNV = PXUAT.MaNV
				INNER JOIN dbo.SanPham ON SanPham.MaSP = XUAT.MaSP
WHERE YEAR(NgayXuat) = 2018
GROUP BY dbo.NhanVien.MaNV, TenNV

-- g. Hãy Đưa ra tổng tiền nhập của mỗi nhân viên trong tháng 8 – năm 2018 có tổng giá trị lớn hơn 100.000
SELECT dbo.NhanVien.MaNV, TenNV, SUM(SoLuongN*GiaBan) AS 'Tong tien'
FROM dbo.PNHAP INNER JOIN dbo.NHAP ON NHAP.SoHDN = PNHAP.SoHDN
				INNER JOIN dbo.NhanVien ON NhanVien.MaNV = PNHAP.MaNV
				INNER JOIN dbo.SanPham ON SanPham.MaSP = NHAP.MaSP
WHERE MONTH(NgayNhap) = 8 AND YEAR(NgayNhap) = 2018
GROUP BY NhanVien.MaNV, TenNV
HAVING SUM(SoLuongN*GiaBan) > 100.000

SELECT dbo.NhanVien.MaNV, dbo.NhanVien.TenNV SUM( 

-- h. Hãy Đưa ra danh sách các sản phẩm đã nhập nhưng chưa xuất bao giờ.
Select SanPham.MaSP,TenSP
From SanPham Inner join nhap on SanPham.MaSP = nhap.MaSP
Where SanPham.MaSP Not In (Select MaSP From Xuat)
-- i. Hãy Đưa ra danh sách các sản phẩm đã nhập năm 2020 và đã xuất năm 2020.
SELECT dbo.SANPHAM.MASP, TenSP
FROM dbo.SANPHAM	INNER JOIN dbo.Nhap		ON Nhap.MaSP = SANPHAM.MASP
					INNER JOIN dbo.PNhap	ON PNhap.SoHDN = Nhap.SoHDN
					INNER JOIN dbo.Xuat		ON Xuat.MaSP = SANPHAM.MASP
					INNER JOIN dbo.PXuat	ON PXuat.SoHDX = Xuat.SoHDX
WHERE YEAR(NgayNhap) = 2020 AND YEAR(NgayXuat) = 2020;

-- j. Hãy Đưa ra danh sách các nhân viên vừa nhập vừa xuất.
SELECT dbo.NhanVien.MaNV, TenNV
FROM dbo.NhanVien	INNER JOIN dbo.PNhap ON PNhap.MaNV = NhanVien.MaNV
					INNER JOIN dbo.PXuat ON PXuat.MaNV = NhanVien.MaNV
GROUP BY NhanVien.MaNV, TenNV

-- k. Hãy Đưa ra danh sách các nhân viên không tham gia việc nhập và xuất.
SELECT dbo.NhanVien.MaNV, TenNV
FROM dbo.NhanVien
WHERE MaNV NOT IN ( SELECT dbo.NhanVien.MaNV
					FROM dbo.NhanVien	INNER JOIN dbo.PNhap ON PNhap.MaNV = NhanVien.MaNV
					INNER JOIN dbo.PXuat ON PXuat.MaNV = NhanVien.MaNV)
GROUP BY NhanVien.MaNV, TenNV


-- l. Hãy đưa tên sản phẩm có tổng lượng xuất nhiều nhất.
SELECT dbo.SANPHAM.MASP, dbo.SANPHAM.TenSP
FROM dbo.SANPHAM INNER JOIN dbo.Xuat ON Xuat.MaSP = SANPHAM.MASP
WHERE SoLuongX = (  SELECT MAX(SoLuongX) FROM dbo.Xuat)

-- m. Đưa ra tên sản phẩm, tên hãng sản xuất có giá bán thấp nhất.
SELECT dbo.SANPHAM.TenSP, dbo.HangSX.TenHang
FROM dbo.SANPHAM INNER JOIN dbo.HangSX ON HangSX.MaHangSX = SANPHAM.MAHANGSX
WHERE GiaBan = ( SELECT min(GiaBan) FROM dbo.SANPHAM)

-- p. Đưa ra tên sản phẩm xuất hiện trong 10 hóa đơn bán năm 2020
SELECT SanPham.MaSP, TenSP
FROM dbo.SanPham	INNER JOIN dbo.XUAT		ON dbo.XUAT.MaSP = SanPham.MaSP
					INNER JOIN dbo.PXUAT	ON PXUAT.SoHDX = XUAT.SoHDX
WHERE YEAR(NgayXuat) = 2020 
GROUP BY SanPham.MaSP,TenSP
HAVING COUNT(XUAT.SoHDX) = 10 