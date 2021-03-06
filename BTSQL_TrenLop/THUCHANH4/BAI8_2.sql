CREATE DATABASE QLNV


USE QLNV
CREATE TABLE CHUCVU
(
	MACV NVARCHAR(2) NOT NULL PRIMARY KEY,
	TENCV NVARCHAR(30)
)

CREATE TABLE NHANVIEN
(
	MANV NVARCHAR(4) NOT NULL PRIMARY KEY,
	MACV NVARCHAR(2) NOT NULL,
	TENNV NVARCHAR(30),
	NGAYSINH DATETIME,
	LUONGCOBAN FLOAT,
	NGAYCONG INT,
	PHUCAP FLOAT,
	CONSTRAINT FK1 FOREIGN KEY (MACV) REFERENCES CHUCVU(MACV)
)

INSERT INTO CHUCVU VALUES
(N'BV', N'BAO VE'),
(N'GD', N'GIAM DOC'),
(N'HC', N'HANH CHINH'),
(N'KT', N'KE TOAN'),
(N'TQ', N'THU QUY'),
(N'VS', N'VE SINH')
INSERT INTO NHANVIEN VALUES
(N'NV01', N'GD', N'NGUYEN VAN AN', '12/12/1977', 700000, 25, 500000),
(N'NV02', N'BV', N'BUI VAN TY', '10/10/1978', 400000, 24, 100000),
(N'NV03', N'KT', N'TRAN VAN NHAT', '9/9/1977', 600000, 26, 400000),
(N'NV04', N'VS', N'NGUYEN THI UT', '10/10/1980', 300000, 26, 300000),
(N'NV05', N'HC', N'LE THI HA', '12/12/1997', 500000, 27, 200000)

GO 
CREATE PROC SP_THEM_NHAN_VIEN(@MANV NVARCHAR(4),@MACV NVARCHAR(2),
 @TENNV NVARCHAR(30),@NGAYSINH DATETIME, @LUONGCANBAN FLOAT,@NGAYCONG INT, @PHUCAP FLOAT
 )
AS
 BEGIN
 IF(NOT EXISTS(SELECT * FROM CHUCVU WHERE MACV=@MACV))
 PRINT 'KHONG CO CHUC VU NAY'
 ELSE
 INSERT INTO NHANVIEN VALUES(@MANV,@MACV, @TENNV, @NGAYSINH, @LUONGCANBAN, @NGAYCONG, @PHUCAP)
 END

 SELECT*FROM NHANVIEN
 EXEC SP_THEM_NHAN_VIEN '4','2','LE VAN A','2/9/1999','122222','36','1233'
 SELECT*FROM NHANVIEN

  SELECT*FROM NHANVIEN
 EXEC SP_THEM_NHAN_VIEN '4','GD','LE VAN A','2/9/1999','122222','36','1233'
 SELECT*FROM NHANVIEN

 CREATE PROC SP_CAPNHATNHANVIEN