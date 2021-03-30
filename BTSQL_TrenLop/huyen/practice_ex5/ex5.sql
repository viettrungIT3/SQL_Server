USE H_QLBanHang
GO

/*
Cho CSDL QLBanHang:
Sanpham(masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
Hangsx(mahangsx, tenhang, diachi, sodt, email)
Nhanvien(manv, tennv, gioitinh, diachi, sodt, email, phong)
Nhap(sohdn, masp, manv, ngaynhap, soluongN, dongiaN)
Xuat(sohdx, masp, manv, ngayxuat, soluongX)
*/

-- 1.Xây dựng hàm đưa ra tên HangSX khi nhập vào MaSP từ bàn phím

CREATE FUNCTION fn_Timhang( @masp NVARCHAR(10))
RETURNS 