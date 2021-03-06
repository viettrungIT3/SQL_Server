CREATE DATABASE QLBanHang

GO
USE QLBanHang
GO 

CREATE TABLE CONGTY
(
	MaCongTy NVARCHAR(10) PRIMARY KEY NOT NULL,
	TenCongTy NVARCHAR(30) NOT NULL,
	DiaChi NVARCHAR(50),
)
GO
CREATE TABLE SANPHAM
(
	MaSanPham NVARCHAR(10) PRIMARY KEY NOT NULL,
	TenSanPham NVARCHAR(30) NOT NULL,
	SoLuongCo INT,
	GiaBan FLOAT
)

GO 
CREATE TABLE CUNGUNG
(
	MaCongTy NVARCHAR(10)  NOT NULL,
	MaSanPham NVARCHAR(10) NOT NULL,
	SoLuongCungUng INT,
	PRIMARY KEY (MaCongTy, MaSanPham),
	FOREIGN KEY (MaCongTy) REFERENCES CONGTY(MaCongTy),
	FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham)
)

GO
INSERT INTO CONGTY VALUES 
(	N'C01',	N'Cong Ty 1',	N'Ha Noi'),
(	N'C02',	N'Cong Ty 2',	N'Ha Noi'),
(	N'C03',	N'Cong Ty 3',	N'Ha Noi')

GO 
INSERT INTO SANPHAM VALUES
(	N'SP01', N'San pham 1',	10, 100000),
(	N'SP02', N'San pham 2',	3, 500000),
(	N'SP03', N'San pham 3',	20, 50000)
GO
INSERT INTO CUNGUNG VALUES
(	N'C01',	N'SP02', 2),
(	N'C01',	N'SP03', 15),
(	N'C02',	N'SP01', 5),
(	N'C03',	N'SP01', 5),
(	N'C03',	N'SP03', 5)

GO
SELECT * FROM CONGTY
SELECT * FROM SANPHAM
SELECT * FROM CUNGUNG

GO
--Câu 2: (2.5. điểm)
--Tạo view đưa ra mã sản phẩm, tên sản phẩm, số lượng có và số lượng đã cung ứng của các sản phẩm
CREATE VIEW v_Cau2
AS

	SELECT CUNGUNG.MaSanPham, TenSanPham, SoLuongCo, SoLuongCungUng
	FROM CUNGUNG INNER JOIN SANPHAM ON CUNGUNG.MaSanPham = SANPHAM.MaSanPham


GO 
SELECT * FROM V_CAU2

/*Câu 3: (2.5. điểm)
Viết thủ tục thêm mới 1 công ty với mã công ty, tên công ty, địa chỉ nhập 
từ bàn phím, nếu tên công ty đó tồn tại trước đó hãy hiển thị thông báo và 
trả về 1, ngược lại cho phép thêm mới và trả về 0.
*/
GO
CREATE PROC pr_Cau3 (	@MaCongTy NVARCHAR(10), @TenCongTy NVARCHAR(30), 
						@DiaChi Nvarchar(50), @KQ INT OUTPUT)
AS
	BEGIN
		IF ( EXISTS ( SELECT * FROM CONGTY WHERE MaCongTy = @MaCongTy))
			BEGIN
				PRINT N'Cong ty nay da ton tai'
				SET @KQ = 0
			END
			
		ELSE 
			BEGIN
				INSERT INTO CONGTY VALUES ( @MaCongTy, @TenCongTy, @DiaChi)	
				SET @KQ = 1
			END
		RETURN @KQ
	END
GO
DROP PROC pr_Cau3
GO
DECLARE @KQ INT
EXEC pr_Cau3 	N'C01',	N'Cong Ty 1',	N'Ha Noi', @KQ OUTPUT
SELECT @KQ
SELECT * FROM CONGTY

DECLARE @KQ INT
EXEC pr_Cau3 	N'C04',	N'Cong Ty 4',	N'Ha Noi', @KQ OUTPUT
SELECT @KQ
SELECT * FROM CONGTY
GO


/*
Câu 4: (2.5. điểm)
Tạo Trigger Update trên bảng CUNGUNG cập nhật lại số lượng cung ứng, kiểm tra 
xem nếu số lượng cung ứng mới – số lượng cung ứng cũ <= số lượng có hay không?  
nếu thỏa mãn hãy cập nhật lại số lượng có  trên bảng SANPHAM, ngược lại đưa ra 
thông báo.
*/
GO
CREATE TRIGGER tg_Cau4 ON SANPHAM
FOR UPDATE 
AS
	BEGIN
		DECLARE @slccCu int, @sl
		SELECT @slccMoi=SoLuongCungUng FROM inserted
	END