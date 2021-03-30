CREATE DATABASE H_QLBanHang

USE H_QLBanHang
GO

CREATE TABLE NhanVien (
	maNV NCHAR(10) PRIMARY KEY NOT NULL,
	tenNV NVARCHAR(20) NOT NULL,
	gioiTinh NCHAR(10),
	diaChi NVARCHAR(30),
	soDT NVARCHAR(20),
	email NVARCHAR(30),
	phong NVARCHAR(30)

)
go
CREATE TABLE HangSX (
	maHangSX NCHAR(10) PRIMARY KEY NOT NULL,
	tenHang NVARCHAR(20) NOT NULL,
	diaChi NVARCHAR(30) NOT NULL,
	soDT NVARCHAR(20) NOT NULL,
	email NVARCHAR(30) NOT NULL
)
go
CREATE TABLE SanPham(
	maSP NCHAR(10) PRIMARY KEY, 
	maHangSX NCHAR(10) NOT NULL,
	tenSP NVARCHAR(20) NOT NULL,
	soLuong INT,
	mauSac NVARCHAR(20),
	giaBan MONEY,
	donViTinh NCHAR(10),
	moTa NVARCHAR(MAX)
	FOREIGN KEY (maHangSX) REFERENCES dbo.HangSX(maHangSX)
)
go
CREATE TABLE Nhap (
	soHDN NCHAR(10) NOT NULL,
	maSP NCHAR(10) NOT NULL,
	maNV NCHAR(10) NOT NULL,
	ngayNhap DATE,
	soLuongN INT,
	donGiaN MONEY,
	PRIMARY KEY (soHDN,maSP),
	FOREIGN KEY (maSP) REFERENCES dbo.Sanpham(maSP),
	FOREIGN KEY (maNV) REFERENCES dbo.NhanVien(maNV)
)
GO 
CREATE TABLE Xuat (
	soHDX NCHAR(10) NOT NULL,
	maSP NCHAR(10) NOT NULL,
	maNV NCHAR(10) NOT NULL,
	ngayXuat DATE,
	soLuongX INT,
	PRIMARY KEY (soHDX,maSP),
	FOREIGN KEY (maSP) REFERENCES dbo.Sanpham(maSP),
	FOREIGN KEY (maNV) REFERENCES dbo.NhanVien(maNV)
)
GO 
INSERT INTO dbo.NhanVien VALUES
(   N'NV001', N'Nguyễn Thị Thu', N'Nữ', N'Hà Nội', N'0982626521', N'thu@gmail.com', N'Kế toán'  ),
(   N'NV002', N'Lê Văn Nam', N'Nam', N'Bắc Ninh', N'0972525252', N'nam@gmail.com', N'Vật tư'  ),
(   N'NV003', N'Trần Hoà Bình', N'Nữ', N'Hà Nội', N'0328388388', N'hb@gmail.com', N'Kế toán'  )

SELECT * FROM dbo.NhanVien
GO 

INSERT INTO dbo.HangSX VALUES
(   N'H01', N'Samsung', N'Korea', N'01108271717', N'ss@gmail.com.kr'  ),
(   N'H02', N'OPPO', N'Chine', N'08108626262 ', N'oppo@gmail.com.kr'  ),
(   N'H03', N'Vinfone', N'Việt Nam', N'084098262626', N'vf@gmail.com.kr'  )
GO 
SELECT * FROM dbo.HangSX
GO 
INSERT INTO dbo.SanPham VALUES
(   N'SP01',  N'H02',   N'F1 Plus',  100,    N'Xám',  7000000, N'Chiếc',  N'Hàng cận cao cấp'   ),
(   N'SP02',  N'H01',   N'Galaxy Note 11',  50,    N'Đỏ',  19000000, N'Chiếc',  N'Hàng cao cấp'   ),
(   N'SP03',  N'H02',   N'F3 lite',  200,    N'Nâu',  3000000, N'Chiếc',  N'Hàng phổ thông'   ),
(   N'SP04',  N'H03',   N'Vjoy3',  200,    N'Xám',  1500000, N'Chiếc',  N'Hàng phổ thông'   ),
(   N'SP05',  N'H01',   N'Galaxy V21',  500,    N'Nâu',  8000000, N'Chiếc',  N'Hàng cận cao cấp'   )

SELECT * FROM dbo.SanPham

GO 
INSERT  INTO dbo.Nhap VALUES
(   N'N01',  N'SP02',  N'NV001',  '20190205', 10,  17000000       ),
(   N'N02',  N'SP01',  N'NV002',  '20200407', 30,  17000000       ),
(   N'N03',  N'SP04',  N'NV002',  '20200517', 20,  17000000       ),
(   N'N04',  N'SP01',  N'NV003',  '20200322', 10,  17000000       ),
(   N'N05',  N'SP05',  N'NV001',  '20200707', 20,  17000000       )

SELECT * FROM dbo.Nhap

GO 
INSERT INTO Xuat VALUES
(	N'X01',	N'SP03',	N'NV002',	'20200614', 5	),
(	N'X02',	N'SP01',	N'NV003',	'20190305', 3	),
(	N'X03',	N'SP02',	N'NV001',	'20201212', 1	),
(	N'X04',	N'SP03',	N'NV002',	'20200602', 2	),
(	N'X05',	N'SP05',	N'NV001',	'20200518', 1	)

SELECT * FROM dbo.Xuat

-- practice ex 2

-- 1. Hiển thị thông tin các bảng dữ liệu trên.
SELECT * FROM dbo.SanPham
SELECT * FROM dbo.HangSX
SELECT * FROM dbo.NhanVien
SELECT * FROM dbo.Nhap
SELECT * FROM dbo.Xuat

--2. Đưa ra thông tin masp, tensp, tenhang,soluong, mausac, giaban, donvitinh, mota của
--   các sản phẩm sắp xếp theo chiều giảm dần giá bán.
SELECT maSP, tenSP, tenHang, soLuong, mauSac, giaBan, donViTinh, moTa
FROM dbo.SanPham INNER JOIN dbo.HangSX ON HangSX.maHangSX = SanPham.maHangSX
ORDER BY giaBan DESC

--3. Đưa ra thông tin các sản phẩm có trong cữa hàng do công ty có tên hãng là samsung sản xuất
SELECT maSP, tenSP, soLuong, mauSac, giaBan, donViTinh, moTa
FROM dbo.SanPham INNER JOIN dbo.HangSX ON HangSX.maHangSX = SanPham.maHangSX
WHERE tenHang = N'samsung'

--4. Đưa ra thông tin các nhân viên Nữ ở phòng ‘Kế toán’.

--5. Đưa ra thông tin phiếu nhập gồm: sohdn, masp, tensp, tenhang, soluongN, dongiaN,
--   tiennhap=soluongN*dongiaN, mausac, donvitinh, ngaynhap, tennv, phong. Sắp xếp
--   theo chiều tăng dần của hóa đơn nhập.

            