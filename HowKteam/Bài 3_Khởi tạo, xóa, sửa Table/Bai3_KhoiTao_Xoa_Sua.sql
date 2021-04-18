-- CREATE DATABASE SQLDBUI

--Sử dụng Database SQLDBUI
USE SQLDBUI

--Tạo bảng SINHVIEN trong Database SQLDBUI
CREATE TABLE SINHVIEN
(
	MASV NCHAR(10),
	TENSV NVARCHAR(100),
	KHOA NVARCHAR(100)
)

-- Xoá bảng SINHVIEN
DROP TABLE dbo.SINHVIEN

--Khởi tạo Table GiangVien
CREATE TABLE GiangVien
(
            MAGV NCHAR(10),
            TENGV NVARCHAR(100),
            KHOA NVARCHAR(100)
)
GO

--Thêm column NGAYSINH có kiểu dữ liệu DATE vào Table dbo.GiangVien

ALTER TABLE dbo.GiangVien ADD NGAYSINH DATE
GO

--Chỉnh sửa kiểu dữ liệu của column MASV trong Table dbo.GiangVien
ALTER TABLE dbo.GiangVien
            ALTER COLUMN  MAGV NCHAR(5)
GO