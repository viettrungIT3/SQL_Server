--CREATE DATABASE QLKHACHHANG 

USE QLKHACHHANG 
GO

CREATE TABLE KHACHHANG
(
	MAKH CHAR(4) NOT NULL PRIMARY KEY,
	HOTEN VARCHAR(40) NOT NULL,
	DCHI VARCHAR(50) NOT NULL,
	SODT VARCHAR(20) NOT NULL,
	NGSINH SMALLDATETIME NOT NULL,
	NGDK SMALLDATETIME NOT NULL,
	DOANHSO MONEY NOT NULL
)
GO

CREATE TABLE NHANVIEN
(
	MANV CHAR(4) NOT NULL PRIMARY KEY,
	HOTEN VARCHAR(40) NOT NULL,
	SODT VARCHAR(20) NOT NULL,
	NGVL SMALLDATETIME
)
GO

CREATE TABLE SANPHAM 
(
	MASP CHAR(4) NOT NULL PRIMARY KEY,
	TENSP VARCHAR(40) NOT NULL,
	DVT VARCHAR(20) NOT NULL,
	NUOCXS VARCHAR(40) NOT NULL,
	GIA MONEY	
)
GO

CREATE TABLE HOADON
(
	SOHD INT NOT NULL PRIMARY KEY,
	NGHD SMALLDATETIME NOT NULL,
	MAKH CHAR(4) NOT NULL,
	MANV CHAR(4) NOT NULL,
	FOREIGN KEY (MAKH) REFERENCES dbo.KHACHHANG,
	FOREIGN KEY (MANV) REFERENCES dbo.NHANVIEN
)
GO

INSERT INTO dbo.NHANVIEN
(
    MANV,
    HOTEN,
    SODT,
    NGVL
)
VALUES
(   'NV01',                   -- MANV - char(4)
    ' Nguyen Nhu Nhut',                   -- HOTEN - varchar(40)
    '0927345678',                   -- SODT - varchar(20)
    '2006-04-13' -- NGVL - smalldatetime
    )

INSERT INTO dbo.NHANVIEN
(
    MANV,
    HOTEN,
    SODT,
    NGVL
)
VALUES
(   'NV02',                   -- MANV - char(4)
    'Le Thi Phi Yen',                   -- HOTEN - varchar(40)
    '0987567390',                   -- SODT - varchar(20)
    '2006-04-21' -- NGVL - smalldatetime
    )

INSERT INTO dbo.NHANVIEN
(
    MANV,
    HOTEN,
    SODT,
    NGVL
)
VALUES
(   'NV03',                   -- MANV - char(4)
    'Nguyen Van B',                   -- HOTEN - varchar(40)
    '0997047382',                   -- SODT - varchar(20)
    '2006-04-27' -- NGVL - smalldatetime
    )

INSERT INTO dbo.NHANVIEN
(
    MANV,
    HOTEN,
    SODT,
    NGVL
)
VALUES
(   'NV04',                   -- MANV - char(4)
    'Ngo Thanh Tuan',                   -- HOTEN - varchar(40)
    '0913758498',                   -- SODT - varchar(20)
    '2006-06-24' -- NGVL - smalldatetime
    )

INSERT INTO dbo.NHANVIEN
(
    MANV,
    HOTEN,
    SODT,
    NGVL
)
VALUES
(   'NV05',                   -- MANV - char(4)
    'Nguyen Thi Truc Thanh',                   -- HOTEN - varchar(40)
    '0918590387',                   -- SODT - varchar(20)
    '2006-07-20' -- NGVL - smalldatetime
    )
GO

INSERT INTO dbo.KHACHHANG
( MAKH, HOTEN, DCHI, SODT, NGSINH, NGDK, DOANHSO)
VALUES
(   N'KH01',                   -- MAKH - nchar(4)
    'Nguyen Van A',                    -- HOTEN - varchar(40)
    '731 Tran Hung Dao, Q5, TpHCM',                    -- DCHI - varchar(50)
    '08823451',                    -- SODT - varchar(20)
    '1960-10-22', -- NGSINH - smalldatetime
    '2006-07-22', -- NGDK - smalldatetime
    13060000                   -- DOANHSO - money
)
GO


INSERT dbo.KHACHHANG
(
    MAKH,
    HOTEN,
    DCHI,
    SODT,
    NGSINH,
    NGDK,
    DOANHSO
)
VALUES
(   'KH02',                   -- MAKH - nchar(4)
    'Tran Ngoc Han',                    -- HOTEN - varchar(40)
    '23/5 Nguyen Trai, Q5, TpHCM',                    -- DCHI - varchar(50)
    '09082345678',                    -- SODT - varchar(20)
    '1974-04-03', -- NGSINH - smalldatetime
    '2006-07-30', -- NGDK - smalldatetime
    280000                   -- DOANHSO - money
    )

INSERT INTO dbo.KHACHHANG
(
    MAKH,
    HOTEN,
    DCHI,
    SODT,
    NGSINH,
    NGDK,
    DOANHSO
)
VALUES
(   'KH03',                   -- MAKH - nchar(4)
    'Tran Ngoc Linh',                    -- HOTEN - varchar(40)
    '',                    -- DCHI - varchar(50)
    '',                    -- SODT - varchar(20)
    '2020-12-22 04:41:36', -- NGSINH - smalldatetime
    '2020-12-22 04:41:36', -- NGDK - smalldatetime
    NULL                   -- DOANHSO - money
    )