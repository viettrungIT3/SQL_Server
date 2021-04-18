--ex9

 USE H_QLBanHang
 GO

 SELECT  * FROM dbo.SanPham
 SELECT * FROM dbo.HangSX
 SELECT * FROM dbo.NhanVien
 SELECT * FROM dbo.Nhap
 SELECT * FROM dbo.Xuat

 --1. Tạo trigger kiểm soát việc nhập dữ liệu cho bảng nhập, hãy kiểm tra các ràng buộc
--toàn vẹn: masp có trong bảng sản phẩm chưa? manv có trong bảng nhân viên chưa?
--kiểm tra các ràng buộc dữ liệu: soluongN và dongiaN>0? Sau khi nhập thì soluong ở
--bảng Sanpham sẽ được cập nhật theo.

ALTER TABLE dbo.Nhap NOCHECK CONSTRAINT 
GO

CREATE TRIGGER tg_Nhap ON Nhap
FOR INSERT 
AS 
	BEGIN
	    DECLARE @maSP NVARCHAR(10), @maNV NVARCHAR(10)
		DECLARE @slNhap INT, @dgNhap FLOAT
		SELECT @maSP = Inserted.maSP, @maNV = Inserted.maNV, @slNhap = Inserted.soLuongN, @dgNhap = Inserted.donGiaN
		FROM Inserted
		IF ( NOT EXISTS (SELECT * FROM dbo.SanPham WHERE maSP = @maSP))
			BEGIN 
			    RAISERROR (N'Khong ton tai san pham trong danh muc san pham', 16, 1)
				ROLLBACK TRANSACTION
			END
		ELSE 
		IF ( NOT EXISTS( SELECT * FROM dbo.NhanVien WHERE maNV = @maNV))
			BEGIN
			    RAISERROR(N'Không tồn tại mã nhân viên này', 16,1)
				ROLLBACK TRANSACTION
			END
		ELSE
			UPDATE dbo.SanPham SET soLuong = soLuong + @slNhap
			FROM dbo.SanPham WHERE maSP = @maSP
	END
GO
-- Gọi dữ liệu 3 bảng liên quan
SELECT * FROM dbo.SanPham
SELECT * FROM dbo.NhanVien
SELECT * FROM dbo.Nhap

--Nhập sai
INSERT INTO NHAP VALUES('N01', 'SP01', 'NV001', '3/7/2018', 0, 1500000)
INSERT INTO NHAP VALUES('N01','SP03','NV01','3/7/2018',300,1500000)

create trigger trg_Nhap
on Nhap
for insert
as
begin
declare @masp nvachar(10),@manv nvarchar(10)
declare @sln int, @dgn float
select @masp=masp, @manv=manv, @sln=soluongN, @dgn = dongiaN
from inserted
if(not exists(select * from sanpham where masp = @masp))
begin
raiserror(N'Không tồn tại sản phẩm trong danh mục sản
phẩm',16,1)
rollback transaction
end
else
if(not exists(select * from nhanvien where manv= @manv))
begin
raiserror(N'Không tồn tại nhân viên có mã này',16,1)
rollback transaction
end
else
if(@sln<=0 or @dgn<=0)
begin
raiserror(N'Nhập sai soluong hoặc dongia', 16, 1)
rollback transaction
end
else
--Bây giờ mới được phép nhập, khi này cần thay đổi soluong
--trong bảng Sanpham
update Sanpham set soluong = soluong + @sln
from sanpham where masp = @masp
end