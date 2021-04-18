CREATE DATABASE DE1_16042021

GO
USE DE1_16042021
GO

CREATE TABLE Sach 
(
	MaSach NVARCHAR(10) PRIMARY KEY NOT NULL,
	TenSach NVARCHAR(30) NOT NULL,
	slCo INT,
	NgayXB DATETIME
)
GO
CREATE TABLE NXB 
(
	MaNXB NVARCHAR(10) PRIMARY KEY NOT NULL,
	TenNXB NVARCHAR(30) NOT NULL
)
GO
CREATE TABLE XUATSACH
(
	MaNXB NVARCHAR(10) NOT NULL,
	MaSach NVARCHAR(10) NOT NULL,
	soluong INT,
	gia MONEY,
	PRIMARY KEY (MaSach,MaNXB),
	FOREIGN KEY (MaNXB) REFERENCES dbo.NXB(MaNXB),
	FOREIGN KEY (MaSach) REFERENCES dbo.Sach(MaSach)
)

--Insert data
INSERT INTO Sach VALUES 
(	N'S01', N'Sách 1',	100, GETDATE()),
(	N'S02', N'Sách 2',	200, '20190303'),
(	N'S03', N'Sách 3',	500, '20190404')

GO
INSERT INTO NXB VALUES
(	N'NXB01', N'NSB 1'),
(	N'NXB02', N'NSB 2')
GO
INSERT INTO XUATSACH VALUES 
(	N'NXB01', N'S01',	10, 10000),
(	N'NXB02', N'S02',	10, 10000),
(	N'NXB02', N'S03',	10, 10000),
(	N'NXB01', N'S02',	10, 10000),
(	N'NXB01', N'S03',	10, 10000)

--display data
SELECT * FROM dbo.Sach
SELECT * FROM dbo.NXB
SELECT * FROM dbo.XUATSACH

--Cau 2: Tạo một thủ tục sủa ngày xuất bản một quyển sách với mã sách được nhập từ bàn phím. Kiểm tra
--không có sách trong bảng thì đưa ra thông báo, nếu mã sachs tồn tại thì kiểm tra ngày xuất bản, nếu ngày 
--xuất bản trùng hoặc sau ngày hiện tại thì đưa ra thông báo: không thể sửa, ngược lại cho phép sửa.
GO
CREATE PROC sp_Cau2 (@maSach NVARCHAR(10), @ngayXuat DATETIME)
AS
	BEGIN
	    IF ( NOT EXISTS(SELECT * FROM dbo.Sach WHERE MaSach = @maSach))
			PRINT 'Ma sach ' + @maSach + ' khong ton tai'
		ELSE 
			BEGIN
			    IF ( @ngayXuat >= GETDATE() - 1)
					PRINT 'KHONG THE SUA!'
				ELSE 
					UPDATE dbo.Sach SET NgayXB = @ngayXuat
					WHERE MaSach = @maSach
			END
	END
GO
--TEST
SELECT * FROM dbo.Sach
EXEC dbo.sp_Cau2 @maSach = N'S05',                    -- nvarchar(10)
                 @ngayXuat = '2021-04-15 15:15:28' -- datetime
SELECT * FROM dbo.Sach

CREATE

--Cau 3
GO
CREATE TRIGGER c3 ON dbo.Sach
FOR INSERT 
AS
	BEGIN
		DECLARE @ngayXB DATETIME
		SELECT @ngayXB = NgayXB FROM Inserted
		IF (YEAR(GETDATE()) > YEAR(@ngayXB))
			BEGIN
				RAISERROR(N'Nam khong hop le', 16,1)
				ROLLBACK TRANSACTION
			END
	END
--test
SELECT * FROM dbo.Sach
INSERT INTO Sach VALUES ('S052', N'Sách 1',	100, GETDATE())
SELECT * FROM dbo.Sach