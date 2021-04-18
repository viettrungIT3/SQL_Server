CREATE DATABASE QLSach

GO
USE QLSach
GO

--CREATE TABLE
CREATE TABLE Sach
(
	maSach NVARCHAR(10) PRIMARY KEY NOT NULL,
	tenSach NVARCHAR(30) NOT NULL,
	slco INT,
	maTacGia NVARCHAR(10) NOT NULL,
	ngayXB DATE
)
GO 
CREATE TABLE NXB
(
	maNXB NVARCHAR(10) PRIMARY KEY NOT NULL,
	tenNXB NVARCHAR(50) NOT NULL
)
GO 
CREATE TABLE XUATSACH
(
	maNXB NVARCHAR(10)  NOT NULL,
	maSach NVARCHAR(10)  NOT NULL,
	soLuong INT,
	gia MONEY,
	PRIMARY KEY (MaNXB, MaSach),
	FOREIGN KEY (MaNXB) REFERENCES dbo.NXB(maNXB) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (MaSach) REFERENCES dbo.Sach(MaSach) ON UPDATE CASCADE ON DELETE CASCADE
)

--Insert data
GO
INSERT INTO Sach VALUES
(	N'S01', N'SACH 1', 100, N'Tác giả 1', GETDATE()),
(	N'S02', N'SACH 2', 100, N'Tác giả 2', '20190303'),
(	N'S03', N'SACH 3', 100, N'Tác giả 3', '20190404')

GO 
INSERT INTO NXB VALUES 
(	N'N01', N'NXB 1'),
(	N'N02', N'NXB 2')

GO
INSERT INTO XUATSACH VALUES
(	N'N01', N'S01', 10, 10000),
(	N'N02', N'S02', 10, 20000),
(	N'N01', N'S03', 10, 30000),
(	N'N02', N'S03', 10, 5000),
(	N'N02', N'S01', 10, 15000)

--display data
SELECT * FROM dbo.Sach
SELECT * FROM dbo.NXB
SELECT * FROM dbo.XUATSACH

/*
Câu 2(3đ): Tạo một thủ tục sửa ngày xuất bản một quyển sách với 
mã sách được nhập từ bản phím kiểm tra không có mã sách trong bảng 
thì đưa ra thông báo, nếu mã sách tồn tại thì kiểm tra ngày xuất bản, 
nếu ngày xuất bản trùng hoặc sau ngày hiện tại thì đưa ra thông báo: 
không thể sửa, ngược lại cho phép sửa
*/ 
GO
CREATE PROC sp_Cau2 (@maSach NVARCHAR(10), @ngayXuat DATE)
AS
	BEGIN
	    IF (NOT EXISTS(SELECT * FROM dbo.Sach WHERE maSach = @maSach ))
			PRINT 'Ma sach ' + @maSach + ' khong ton tai'
		ELSE 
			BEGIN
			    IF ( @ngayXuat >= GETDATE() - 1) 
					PRINT 'Khong the sua'
				ELSE
					UPDATE dbo.Sach SET ngayXB = @ngayXuat
					WHERE maSach = @maSach
			END
	END

GO 
-- TH1: ma sach khong ton tai
EXEC dbo.sp_Cau2  N'S001', '2021-04-18' 
-- TH2: ngay trung hom nay hoac sau
EXEC dbo.sp_Cau2  N'S01', '2021-04-17'
-- TH3: OK
SELECT * FROM dbo.Sach 
EXEC dbo.sp_Cau2  N'S01', '2021-04-16'
SELECT * FROM dbo.Sach 

-- Câu 3: 