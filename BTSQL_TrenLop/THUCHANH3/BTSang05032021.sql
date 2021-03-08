--tao csdl khoa
 create database BTCTC
 GO 
 use BTCTC
 -- bang khoa
 create table Khoa(
 makhoa varchar(10) not null primary key,
 tenkhoa char(30),
 dienthoai char(12))
 --bang lop
 create table lop(
 malop varchar(10) not null primary key,
 tenlop char(30),
hedt char(12),
namnhaphoc int,
makhoa varchar(10),
constraint fk1 foreign key (makhoa)references khoa(makhoa) on update cascade on delete cascade) 
 -----chen du lieu
 INSERT INTO dbo.Khoa VALUES
 (   '1', 'CNTT', '123456789'  ),
 (   '2', 'Du Lich', '123456789'  ),
 (   '3', 'Ke Toan', '123456789'  )
 SELECT * FROM dbo.Khoa

 GO 
--Thủ tục thẻ
CREATE PROC SP_NHAPKHOA( @MAKHOA VARCHAR(10), @TENKHOA CHAR(30), @DIENTHOAI CHAR(12))
AS BEGIN
	IF (EXISTS(SELECT * FROM KHOA WHERE TenKhoa = @TENKHOA))
		PRINT 'TEN KHOA ' + @TENKHOA + ' DA TON TAI!'
	ELSE
		INSERT INTO KHOA VALUES ( @MAKHOA, @TENKHOA, @DIENTHOAI)
END
GO 
--Test chương trình
SELECT * FROM KHOA
EXEC dbo.SP_NHAPKHOA 9, 'Dien tu', '1224556'
SELECT *  FROM KHOA
EXEC dbo.SP_NHAPKHOA 6, 'XYZ', '12234556'
SELECT * FROM KHOA
                    
GO 
CREATE PROC SP_SUAKHOA( @MAKHOA VARCHAR(10), @TENKHOA CHAR(30), @DIENTHOAI CHAR(12))
AS 
	BEGIN
		IF ( NOT EXISTS(SELECT * FROM dbo.Khoa WHERE makhoa = @MAKHOA))
			PRINT 'Ma khoa ' + @MAKHOA + ' khong ton tai'
			ELSE 
				UPDATE dbo.Khoa SET tenkhoa = @TENKHOA, dienthoai = @DIENTHOAI
				WHERE makhoa = @MAKHOA
	END
GO
SELECT * FROM dbo.Khoa
EXEC dbo.SP_SUAKHOA 12, 'Khoa hoc co ban', '123456789'
SELECT*FROM dbo.Khoa

GO 
CREATE PROC SP_XOAKHOA( @MAKHOA CHAR(10))
AS
	BEGIN
		IF (NOT EXISTS(SELECT * FROM dbo.Khoa WHERE makhoa = @MAKHOA))
			PRINT 'Ma khoa ' + @MAKHOA + ' khong ton tai'
		ELSE 
			DELETE dbo.Khoa WHERE makhoa = @MAKHOA
	END

GO 
SELECT * FROM dbo.Khoa
EXEC dbo.SP_XOAKHOA 10
SELECT * FROM dbo.Khoa

SELECT * FROM dbo.Khoa
EXEC dbo.SP_XOAKHOA 12
SELECT * FROM dbo.Khoa


--Thủ tục TÌM KIẾM
GO 
CREATE PROC SP_TIMKHOA( @MAKHOA CHAR(10))
AS 
	BEGIN
		IF (NOT EXISTS(SELECT * FROM dbo.Khoa WHERE makhoa = @MAKHOA))
			PRINT 'Ma khoa ' + @MAKHOA + ' khong ton tai'
		ELSE 
			SELECT * FROM dbo.Khoa
			WHERE makhoa = @MAKHOA
	END
GO 

EXEC dbo.SP_TIMKHOA 9
EXEC dbo.SP_TIMKHOA 12

--------------------------------------------------------------------------------------------------------------------------------
--BÀI TAP


CREATE DATABASE QLBanHang2
USE QLBanHang2
GO 
CREATE TABLE SanPham (
	MaSP CHAR(10) PRIMARY KEY,
	MauSac NVARCHAR(10),
	SoLuong INT,
	GiaBan MONEY
)
GO 
CREATE TABLE CongTy (
	MaCT CHAR(10) PRIMARY KEY,
	TenCT NVARCHAR(20) NOT NULL,
	TrangThai NVARCHAR(10),
	ThanhPho NVARCHAR(20)
)
GO
CREATE TABLE CungUng (
	MaCT CHAR(10) NOT NULL,
	MaSP CHAR(10) NOT NULL,
	SoLuongCungUng INT,
	PRIMARY KEY (MaCT,MaSP),
	FOREIGN KEY (MaCT) REFERENCES dbo.CongTy(MaCT) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (MaSP) REFERENCES dbo.SanPham(MaSP) ON UPDATE CASCADE ON DELETE CASCADE
)

-- Insert data
GO
INSERT INTO dbo.SanPham VALUES
(   'SP01',  N'Xanh', 10,   100000 ),
(   'SP02',  N'Đỏ', 5,   500000 ),
(   'SP03',  N'Tím', 15,   200000 ),
(   'SP04',  N'Vàng', 20,   50000 ),
(   'SP05',  N'Hồng', 30,   10000 )
GO 
INSERT INTO dbo.CongTy VALUES
(   'CT01',  N'abc', N'tôt', N'Hà Nội'  ),
(   'CT02',  N'xyz', N'tôt', N'Hà Nội'  ),
(   'CT03',  N'asd', N'phá sản', N'Hà Nội'  ),
(   'CT04',  N'aaa', N'tôt', N'Hà Nội'  ),
(   'CT05',  N'Trung', N'tôt', N'Thái Nguyên'  )
GO
INSERT INTO dbo.CungUng VALUES
(   'CT01', 'SP03', 5   ),
(   'CT02', 'SP05', 5   ),
(   'CT05', 'SP02', 5   ),
(   'CT01', 'SP05', 15   ),
(   'CT04', 'SP04', 10   )
GO

--Display
SELECT * FROM dbo.SanPham
SELECT * FROM dbo.CongTy
SELECT * FROM dbo.CungUng

--b Tạo thủ tục lưu trữ đưa ra ds sản phẩm cung ứng của từng công ty

GO 
CREATE PROC sp_LuuTruSP( @tenCT NVARCHAR(20))
AS
	BEGIN 
		IF ( NOT EXISTS ( SELECT * FROM dbo.CongTy WHERE TenCT = @tenCT ))
			PRINT 'Cong ty ' + @tenCT + ' khong ton tai'
		ELSE 
			SELECT SanPham.MaSP, TenCT, TenCT
			FROM dbo.SanPham	INNER JOIN dbo.CungUng ON CungUng.MaSP = SanPham.MaSP
								INNER JOIN dbo.CongTy ON CongTy.MaCT = CungUng.MaCT
			WHERE TenCT = @tenCT
	END
GO 
DROP PROC dbo.sp_LuuTruSP
EXEC dbo.sp_LuuTruSP  N'Trung' 



--c. Tạo thủ tục thêm công ty mới
GO 
CREATE PROC sp_ThemCongTy (@MaCT CHAR(10), @tenCT NVARCHAR(20), @TrangThai NVARCHAR(10), @ThanhPho NVARCHAR(20))
AS
	BEGIN 
		IF ( EXISTS( SELECT * FROM dbo.CongTy WHERE TenCT = @tenCT))
			PRINT 'Cong ty ' + @tenCT + ' da ton tai'
		ELSE
			INSERT INTO dbo.CongTy VALUES (   @MaCT,  @tenCT, @TrangThai, @ThanhPho  )
	END
GO
SELECT * FROM dbo.CongTy
EXEC dbo.sp_ThemCongTy  'CT06',  N'ahihi', N'tôt', N'BangKok'
SELECT * FROM dbo.CongTy


--d tạo thủ tục xoá bỏ các công ty trong 1 thanh phố khi truyền vào một thành phố
GO 
CREATE FUNCTION fn_TimMaCT( @thanhPho NVARCHAR(20))
RETURNS CHAR(10)
AS BEGIN
	DECLARE @maCT CHAR(10)
	SELECT @maCT = (SELECT MaCT FROM dbo.CongTy WHERE ThanhPho = @thanhPho)
	RETURN @maCT
END
GO 
SELECT dbo.fn_TimMaCT(N'Thái Nguyên')

GO 
CREATE PROC sp_XoaCongTy (@thanhPho NVARCHAR(20))
AS
	BEGIN
		IF ( NOT EXISTS ( SELECT * FROM dbo.CongTy WHERE ThanhPho = @thanhPho))
			PRINT 'Thanh pho ' + @thanhPho + ' Khong ton tai'

		ELSE
			DECLARE @maCT CHAR(10)
				SELECT @maCT = (SELECT MaCT FROM dbo.CongTy WHERE ThanhPho = @thanhPho)
			DELETE dbo.CungUng WHERE MaCT = @maCT
			DELETE dbo.CongTy WHERE ThanhPho = @thanhPho
	END
GO 
DROP PROC dbo.sp_XoaCongTy

GO 
SELECT * FROM dbo.CongTy
EXEC dbo.sp_XoaCongTy N'Thái Nguyên' 
SELECT * FROM dbo.CongTy

GO 
SELECT * FROM dbo.CongTy
EXEC dbo.sp_XoaCongTy N'Hà Nội' 
SELECT * FROM dbo.CongTy


