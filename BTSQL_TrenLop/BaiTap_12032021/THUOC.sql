CREATE DATABASE QLTHUOC
GO
USE QLTHUOC
GO

--INSERT TABLE
CREATE TABLE NSX (
	MaNSX NVARCHAR(10) PRIMARY KEY NOT NULL,
	TenNSX NVARCHAR(30) NOT NULL,
	DC NVARCHAR(50),
	DT NVARCHAR(15)
)
GO
CREATE TABLE THUOC (
	MaThuoc NVARCHAR(10) PRIMARY KEY NOT NULL,
	TenThuoc NVARCHAR(20) NOT NULL,
	SLco INT,
	Solo INTEGER, 
	Ngaysx DATETIME,
	HanSD INT,
	MaNSX NVARCHAR(10),
	FOREIGN KEY (MaNSX) REFERENCES dbo.NSX(MaNSX)
)
GO 
CREATE TABLE PN (
	SoPN NVARCHAR(10) NOT NULL,
	MaThuoc NVARCHAR(10) NOT NULL,
	NgayNhap DATETIME,
	SoLuong INT,
	DonGia MONEY
	PRIMARY KEY (SoPN,MaThuoc),
	FOREIGN KEY (MaThuoc) REFERENCES dbo.THUOC(MaThuoc) ON UPDATE CASCADE ON DELETE cascade
)

GO 
--INSERT DATA
INSERT INTO NSX VALUES
(	N'SX01',	N'Nhà SX 1',	N'Hà Nội',	'123456789'	),
(	N'SX02',	N'Nhà SX 2',	N'Hà Nội',	'123456789'	),
(	N'SX03',	N'Nhà SX 3',	N'Thái Nguyên',	'123456789'	)
GO 
INSERT INTO THUOC VALUES
(	'T01',	N'Thuốc 1',	100,	123,	'20200202',	36,	'SX03'	),
(	'T02',	N'Thuốc 2',	50,		321,	'20200202',	24,	'SX01'	),
(	'T03',	N'Thuốc 3',	20,		222,	'20200202',	12,	'SX02'	),
(	'T04',	N'Thuốc 4',	200,	1234,	'20200202',	24,	'SX02'	)
GO
INSERT INTO PN VALUES
(	'PN01',	'T02',	GETDATE(),	10,	100000	),
(	'PN02',	'T01',	GETDATE(),	10,	50000	),
(	'PN03',	'T03',	GETDATE(),	10,	500000	),
(	'PN04',	'T04',	GETDATE(),	10,	10000	),
(	'PN05',	'T01',	GETDATE(),	10,	50000	),
(	'PN06',	'T02',	GETDATE(),	10,	100000	)

/*Display
SELECT * FROM dbo.NSX
SELECT * FROM dbo.THUOC 
SELECT * FROM dbo.PN
*/

--câu 2: tạo hàm đưa ra tổng số lượng nhập của từng mặt hàng nhập từ bàn phím
GO
CREATE FUNCTION fn_TongSLNhap( @MaThuoc NVARCHAR(10))
RETURNS @bang TABLE (
	SoPN NVARCHAR(10),
	MaThuoc NVARCHAR(10),
	SLNhap int
)
AS 
	BEGIN
	    INSERT INTO @bang 
		SELECT SoPN,  MaThuoc, SUM(SoLuong)
		FROM dbo.PN
		WHERE MaThuoc = @MaThuoc
		RETURN
	END
GO
DROP FUNCTION dbo.fn_TongSLNhap
SELECT * FROM dbo.PN
SELECT * FROM dbo.fn_TongSLNhap(N'T01')

--Tạo một hàm thống kê các loại thuốc quá hạn
GO 
CREATE FUNCTION fn_ThongKeThuocQuaHan()
RETURNS @bang TABLE (
			MaThuoc NVARCHAR(10) ,
			TenThuoc NVARCHAR(20) ,
			SLco INT,
			Solo INTEGER, 
			Ngaysx DATETIME,
			HanSD INT,
			MaNSX NVARCHAR(10)
)
AS
	BEGIN
	INSERT INTO @bang 
	    SELECT MaThuoc, TenThuoc, SLco, Solo, Ngaysx, HanSD, MaNSX
		FROM dbo.THUOC 
		WHERE DATEDIFF(dd, Ngaysx, GETDATE()) / 30 >= HanSD
		RETURN
	END
GO
SELECT * FROM dbo.fn_ThongKeThuocQuaHan()

--Câu 3: Tạo thủ tục thêm 1 NSX với mã NSX nhập từ bàn phím. Nếu đã có thì thông báo.
GO
CREATE PROC sp_ThemNSX( @maNSX NVARCHAR(10), 
						@TenNSX NVARCHAR(30),
						@DC NVARCHAR(50),
						@DT NVARCHAR(15) )
AS
	BEGIN
	    IF ( EXISTS ( SELECT * FROM dbo.NSX WHERE MaNSX = @maNSX ))
			PRINT N'Mã NSX ' + @maNSX + N' đã tồn tại.'
		ELSE 
			    INSERT INTO NSX VALUES ( @maNSX, @TenNSX, @DC, @DT)
	END
GO 
SELECT * FROM dbo.NSX
EXEC dbo.sp_ThemNSX	N'SX04',	N'Nhà SX 4',	N'Hà Nội',	'123456789'	
SELECT * FROM dbo.NSX

GO 
--Tạo thủ tục tìm thuốc với mã thuốc nhập từ bàn phím. Nếu mã chưa có thì thông báo
CREATE PROC sp_TimThuoc( @maThuoc NVARCHAR(10))
AS
	BEGIN
	    IF ( NOT EXISTS ( SELECT * FROM dbo.THUOC WHERE MaThuoc = @maThuoc ))
			PRINT N'Ma thuoc ' + @maThuoc + 'khong ton tai'
		ELSE 
			SELECT MaThuoc, TenThuoc, SLco, Solo, Ngaysx, HanSD, MaNSX
			FROM dbo.THUOC 
			WHERE MaThuoc = @maThuoc
	END
GO 
EXEC dbo.sp_TimThuoc N'T01'
