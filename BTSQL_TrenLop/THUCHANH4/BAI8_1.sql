CREATE DATABASE QLSV2 

USE QLSV2
GO

--CREATE TABLE
CREATE TABLE KHOA (
	MAKHOA INT PRIMARY KEY,
	TENKHOA NVARCHAR(20) NOT NULL,
	DIENTHOAI NVARCHAR(12)
)
GO 
CREATE TABLE LOP (
	MALOP INT PRIMARY KEY,
	TENLOP NVARCHAR(20) NOT NULL,
	KHOA INT NOT NULL,
	HEDT NVARCHAR(20),
	NAMNHAPHOC INT,
	MAKHOA INT,
	FOREIGN KEY (MAKHOA) REFERENCES DBO.KHOA
)


--INSERT DATA
INSERT INTO KHOA VALUES 
(	1,	N'CNTT',	'123456789'	),
(	2,	N'Du lịch',	'987654321'	),
(	3,	N'Kế toán',	'123456789'	)
GO
INSERT INTO LOP VALUES 
(	1,	N'CNTT3',	14,	N'ĐH', 2019, 1),
(	2,	N'Du lịch 1',	14,	N'ĐH', 2019, 2),
(	3,	N'CNTT1',	21,	N'TC', 2019, 1),
(	4,	N'Du lịch 5',	14,	N'ĐH', 2019, 2),
(	5,	N'Kế toán 5',	14,	N'ĐH', 2019, 3),
(	6,	N'CNTT5',	14,	N'ĐH', 2019, 1)
GO 

--display data
SELECT * FROM dbo.KHOA
SELECT * FROM dbo.LOP

/*
Bài tập 1, Viết thủ tục nhập dữ liệu vào bảng KHOA với các tham biến:
makhoa,tenkhoa, dienthoai, hãy kiểm tra xem tên khoa đã tồn tại trước đó hay chưa,
nếu đã tồn tại đưa ra thông báo, nếu chưa tồn tại thì nhập vào bảng khoa, test với 2
trường hợp.
*/
GO
CREATE PROC SP_NHAPKHOA(@MAKHOA INT, @TENKHOA NVARCHAR(20), @DIENTHOAI NVARCHAR(12))
AS
	BEGIN
		IF(EXISTS(SELECT * FROM dbo.KHOA WHERE TENKHOA = @TENKHOA))
			PRINT 'TEN KHOA ' + @TENKHOA + 'DA TON TAI'
		ELSE
			INSERT INTO KHOA VALUES ( @MAKHOA , @TENKHOA, @DIENTHOAI)
	END
--Gọi thủ tục:
SELECT * FROM khoa
EXEC SP_NHAPKHOA 6,N'Điện tử','1224556'

/*
Bài tập 2. Hãy viết thủ tục nhập dữ liệu cho bảng Lop với các tham biến Malop,
Tenlop, Khoa,Hedt,Namnhaphoc,Makhoa nhập từ bàn phím.
- Kiểm tra xem tên lớp đã có trước đó chưa nếu có thì thông báo
- Kiểm tra xem makhoa này có trong bảng khoa hay không nếu không có thì thông
báo
- Nếu đầy đủ thông tin thì cho nhập
*/
GO
CREATE PROC SP_NHAPLOP ( @MALOP INT, @TENLOP NVARCHAR(20), @KHOA INT,@HEDT NVARCHAR(20), @NAMNHAPHOC INT, @MAKHOA INT)
AS
	BEGIN
		IF(EXISTS(SELECT * FROM LOP WHERE TENLOP = @TENLOP))
			PRINT 'LOP DA TON TAI'
		ELSE IF(NOT EXISTS(SELECT * FROM KHOA WHERE MAKHOA = @MAKHOA))
			PRINT 'KHOA NAY CHUA TON TAI'
		ELSE
			INSERT INTO LOP
		VALUES( @MALOP, @TENLOP, @KHOA, @HEDT, @NAMNHAPHOC, @MAKHOA)
	END

GO 
SELECT * FROM LOP
SELECT * FROM dbo.KHOA
EXEC SP_NHAPLOP 7,'TIN22',2,'DH','2011',3
SELECT * FROM LOP
SELECT * FROM dbo.KHOA

/*
Bài tập 3, Viết thủ tục nhập dữ liệu vào bảng KHOA với các tham biến:
makhoa,tenkhoa, dienthoai, hãy kiểm tra xem tên khoa đã tồn tại trước đó hay chưa,
nếu đã tồn tại trả về giá trị 0, nếu chưa tồn tại thì nhập vào bảng khoa, test với 2
trường hợp
*/
GO 
CREATE PROC SP_NHAPKHOA3(@MAKHOA INT, @TENKHOA NVARCHAR(20), @DIENTHOAI NVARCHAR(12), @KQ INT OUTPUT)
AS
	BEGIN
		IF(EXISTS(SELECT * FROM KHOA WHERE TENKHOA = @TENKHOA))
			SET @KQ=0
		ELSE
			INSERT INTO KHOA VALUES(@MAKHOA,@TENKHOA,@DIENTHOAI)
		RETURN @KQ
	END
GO 
DECLARE @LOI INT
EXEC SP_NHAPKHOA3 '8','CNTTASAS','12356', @LOI OUTPUT
SELECT @LOI
SELECT * FROM dbo.KHOA

DECLARE @LOI INT
EXEC SP_NHAPKHOA3 '8','CNTT','12356', @LOI OUTPUT
SELECT @LOI
SELECT * FROM dbo.KHOA

/*
Bài tập 4. Hãy viết thủ tục nhập dữ liệu cho bảng lop với các tham biến
malop,tenlop,khoa,hedt,namnhaphoc,makhoa.
- Kiểm tra xem tên lớp đã có trước đó chưa nếu có thì trả về 0.
- Kiểm tra xem makhoa này có trong bảng khoa hay không nếu không có thì tra ve 1.
- Nếu đầy đủ thông tin thì cho nhập và trả về 2.
*/
GO
CREATE PROC SP_NHAPDLLOP ( @MALOP INT, @TENLOP NVARCHAR(20), @KHOA INT,  
@HEDT NVARCHAR(20), @NAMNHAPHOC INT, @MAKHOA INT, @KQ INT OUTPUT)
AS 
	BEGIN
	    IF ( EXISTS ( SELECT * FROM dbo.LOP WHERE MALOP = @MALOP ))
			SET @KQ = 0;
		ELSE IF ( NOT  EXISTS ( SELECT * FROM dbo.KHOA WHERE MAKHOA = @MAKHOA ))
			SET @KQ = 1;
		ELSE 
			BEGIN
			    INSERT INTO dbo.LOP VALUES (   @MALOP, @TENLOP, @KHOA, @HEDT, @NAMNHAPHOC, @MAKHOA )
				SET @KQ = 2;
			END
		RETURN @KQ
	END

GO 
DROP PROC dbo.SP_NHAPDLLOP

DECLARE @KQ INT;
EXEC dbo.SP_NHAPDLLOP 8, N'ABC', 14,   N'ĐH',  2019,  1,  @KQ OUTPUT 
SELECT @KQ
SELECT * FROM dbo.LOP
SELECT * FROM dbo.KHOA

DECLARE @KQ INT;
EXEC dbo.SP_NHAPDLLOP 8, N'CNTT3', 14,   N'ĐH',  2019,  1,  @KQ OUTPUT 
SELECT @KQ
SELECT * FROM dbo.LOP
SELECT * FROM dbo.KHOA

DECLARE @KQ INT;
EXEC dbo.SP_NHAPDLLOP 8, N'CNTT03', 14,   N'ĐH',  2019,  5,  @KQ OUTPUT 
SELECT @KQ
SELECT * FROM dbo.LOP
SELECT * FROM dbo.KHOA