--Chọn sản phẩm để cập nhật
create proc sp_ChonSanPhamCapNhat(@tensp nvarchar(20))
as
begin
	select MAMATHANG from MATHANG where TENMATHANG=@tensp
end

--Cap nhat san pham
--create
alter proc sp_CapNhatSanPham(@masp nvarchar(20), @mota nvarchar(20), 
@cd float, @cr float, @cc float, @giavanchuyen float, @dathang bit,
@tinhtrang nvarchar(50), @ngaychuanbi int, @khoiluong float, @tensp nvarchar(20))
as
begin
	update MATHANG set MOTASANPHAM=@mota, CHIEUCAO=@cc, CHIEUDAI=@cd, CHIEURONG=@cr, 
	GIAVANCHUYENDUKIEN=@giavanchuyen, DATHANGTRUOC =@dathang, TINHTRANG=@tinhtrang, 
	SONGAYCANCHUANBI=@ngaychuanbi, KHOILUONGDONGGOI=@khoiluong, TENMATHANG=@tensp
	where MAMATHANG=@masp
end
