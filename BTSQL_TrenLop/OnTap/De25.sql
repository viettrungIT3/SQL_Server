CREATE DATABASE DE25

GO
USE DE25
GO 

CREATE TABLE Khoa
(
	MaKhoa NVARCHAR(10) PRIMARY KEY NOT NULL,
	TenKhoa NVARCHAR(20) NOT NULL
)

CREATE TABLE Lop
(
	MaLop NVARCHAR(10) PRIMARY KEY NOT NULL,
	TenLop NVARCHAR(20) NOT NULL,
	SiSo INT NOT NULL,
	MaKhoa NVARCHAR(10) NOT NULL,
	FOREIGN KEY (MaKhoa) REFERENCES dbo.Khoa(MaKhoa)
)

CREATE TABLE SinhVien
(
	MaSV NVARCHAR(10) PRIMARY KEY NOT NULL,
	HoTen NVARCHAR(30) NOT NULL,
	NgaySinh DATE NOT NULL,
	GioiTinh BIT,
	MaLop NVARCHAR(10),
	FOREIGN KEY (MaLop) REFERENCES dbo.Lop(MaLop)
)

GO 
--Insert data
INSERT INTO Khoa VALUES
(	N'K01', N'Khoa 1'),
(	N'K02', N'Khoa 2')

GO 
INSERT INTO Lop VALUES 
(	N'L01', N'Lớp 1', 60, N'K01'),
(	N'L02', N'Lớp 2', 60, N'K02')

GO 
INSERT INTO SinhVien VALUES 
(	N'SV001', N'Nguyễn Văn A', '20010101', 1, N'L01'),
(	N'SV002', N'Nguyễn Văn B', '20010101', 1, N'L01'),
(	N'SV003', N'Nguyễn Thị Tý', '20010101', 0, N'L02'),
(	N'SV004', N'Nguyễn Văn Tèo', '20010101', 1, N'L02'),
(	N'SV005', N'Nguyễn Thị Nở', '20010101', 0, N'L01')


GO
--Display data
SELECT * FROM dbo.Khoa
SELECT * FROM dbo.Lop
SELECT * FROM dbo.SinhVien

-- Câu 2: Hãy tạo thủ tục lưu trữ tìm kiếm sinh viên theo 
--khoảng tuổi ( với 2 tham số truyền vào là tuTuoi và denTuoi). 
--kết quả tìm được sẽ đưa ra một dsanh sách gồm:MSV, HoTen, NgaySinh, TenLop, TenKhoa, Tuoi
GO
ALTER PROC sp_Cau2 (@TuTuoi INT, @DenTuoi INT)
AS 
	BEGIN
	    IF (NOT EXISTS ( SELECT * FROM dbo.SinhVien WHERE YEAR(GETDATE()) - YEAR(NgaySinh) BETWEEN @TuTuoi AND @DenTuoi))
			PRINT N'Không có sinh viên nào thỏa mãn!'
		ELSE 
			SELECT MaSV, HoTen, TenLop, TenKhoa, YEAR(GETDATE()) - YEAR(NgaySinh) AS 'Tuoi'
			FROM dbo.SinhVien	INNER JOIN dbo.Lop ON Lop.MaLop = SinhVien.MaLop
								INNER JOIN dbo.Khoa ON Khoa.MaKhoa = Lop.MaKhoa	
			WHERE YEAR(GETDATE()) - YEAR(NgaySinh) BETWEEN @TuTuoi AND @DenTuoi
	END

GO 
EXEC dbo.sp_Cau2 10, 30
SELECT * FROM dbo.SinhVien

-- Câu 3: Hãy tạo Trigger để thêm mới sinh viên trong bảng sinh viên, mỗi khi thêm mới một dữ liệu
-- cho bảng sinh viên khi đó cập nhật lại sĩ số bảng lớp, Nếu sĩ số trong 1 lớp > 80 thì không cho 
-- thêm và đưa ra cảnh bóa.
GO 
ALTER TABLE dbo.SinhVien NOCHECK CONSTRAINT ALL 
GO 
ALTER TRIGGER tg_Cau3 ON dbo.SinhVien 
FOR INSERT
AS 
	BEGIN
		DECLARE @siSo INT, @maLop NVARCHAR(10)
		SELECT @maLop = MaLop FROM Inserted
		SELECT @siSo = SiSo FROM dbo.Lop WHERE MaLop = @maLop
	    IF ( @siSo > 62 )
			BEGIN
			    RAISERROR (N'Lớp đã đầy!', 16, 1)
				ROLLBACK TRAN
			END
		ELSE 
			BEGIN
			    UPDATE dbo.Lop SET SiSo = SiSo + 1
				WHERE MaLop = @maLop
			END
			
	END
GO 
--TEST
-- TH1: Lớp Full
INSERT INTO SinhVien VALUES (	N'SV011', N'Nguyễn Văn A', '20010101', 1, N'L01')
SELECT * FROM dbo.SinhVien
SELECT * FROM dbo.Lop
-- TH2: Lớp chưa FULL
INSERT INTO SinhVien VALUES (	N'SV011', N'Nguyễn Văn A', '20010101', 1, N'L02')
SELECT * FROM dbo.SinhVien
SELECT * FROM dbo.Lop