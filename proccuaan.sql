
--Tìm mặt hàng theo tên hàng
create procedure [dbo].[sp_timMatHang](@tenMH nvarchar(20)) 
as
begin
	select mh.TENMATHANG, mh.MASHOP, mh.MOTASANPHAM, mh.KHOILUONGDONGGOI, mh.CHIEUCAO, mh.CHIEUDAI, mh.CHIEURONG, min(lc.GIACA) 'Gia tu', max(lc.GIACA) 'Den'
	from MATHANG mh, LUACHON lc
	where @tenMH like mh.TENMATHANG and mh.MAMATHANG = lc.MAMATHANG
	group by mh.TENMATHANG, mh.MASHOP, mh.MOTASANPHAM, mh.KHOILUONGDONGGOI, mh.CHIEUCAO, mh.CHIEUDAI, mh.CHIEURONG
end
GO
select LUACHON.* from LUACHON
select * from MATHANG
where MATHANG.TENMATHANG like '%Avalon'
exec sp_timMatHang 'Avalon'
GO

--Tìm các mặt hàng của 1 shop
create procedure [dbo].[sp_timsHOP](@mashop nvarchar(10)) 
as
begin
	select mh.TENMATHANG, mh.MASHOP, mh.MOTASANPHAM, mh.CHIEUCAO, mh.CHIEUDAI, mh.CHIEURONG, min(lc.GIACA) 'Gia tu', max(lc.GIACA) 'Den'
	from MATHANG mh, LUACHON lc
	where @mashop like mh.MASHOP and mh.MAMATHANG = lc.MAMATHANG
	group by mh.TENMATHANG, mh.MASHOP, mh.MOTASANPHAM, mh.CHIEUCAO, mh.CHIEUDAI, mh.CHIEURONG
end
GO

exec sp_timsHOP 'AVGO'
GO

--Xem chi tiết hàng
create procedure sp_xemHang @maHang nvarchar(10)
as
begin
	select *
	from LUACHON LC
	where LC.MAMATHANG = @maHang
end
GO

exec sp_xemHang '#3f7ecc'
GO

--Thêm vào giỏ hàng
create procedure sp_themVaoGioHang @maTaiKhoan nvarchar(10), @maMatHang nvarchar(10), @maLuaChon nvarchar(10), @maPhieu nvarchar(3), @soLuong int, @mavoucher nvarchar(10), @dvvc nvarchar(10)
as
begin
	if (not exists (select * from LUACHON LC where LC.MAMATHANG = @maMatHang and LC.MALUACHON = @maLuaChon))
		begin
		print(N'Không tìm thấy sản phẩm')
		return
		end

	if ((select LUACHON.SOLUONGTONKHO from LUACHON
		where LUACHON.MAMATHANG = @maMatHang and 
		LUACHON.MALUACHON = @maLuaChon) < @soLuong)
	begin
		print(N'Không đủ số lượng')
		return
	end

	declare @stt int, @giagoc float
	set @giagoc = (select LUACHON.GIACA from LUACHON where MAMATHANG = @maMatHang
				and MALUACHON = @maLuaChon)
	set @stt = (select max(spc.STT) from SANPHAMCHON spc
				where spc.MATAIKHOAN = @maTaiKhoan)
	if (@stt is NULL) set @stt = 0
	set @stt = @stt + 1;

	if (not exists (select * from MATHANG mh, VOUCHERSHOP vcs
			where mh.MAMATHANG = @maMatHang and mh.MASHOP = vcs.MASHOP and vcs.MAVOUCHER = @mavoucher))
		begin
			print (N'Voucher không hợp lệ')
			return
		end

	declare @sotiengiam float, @phantramgiam float, @sotienyeucau float, @gtrithanhtoan float

	set @sotienyeucau = (select vcs.SOTIENTOITHIEUYEUCAU from VOUCHERSHOP vcs where vcs.MAVOUCHER = @mavoucher)
	set @sotiengiam = (select vcs.SOTIENGIAM from VOUCHERSHOP vcs where vcs.MAVOUCHER = @mavoucher)
	if (@sotiengiam is null) set @sotiengiam = 0
	set @phantramgiam = (select vcs.PHANTRAMGIAM from VOUCHERSHOP vcs where vcs.MAVOUCHER = @mavoucher)
	if (@phantramgiam is null) set @phantramgiam = 0
	if (@giagoc < @sotienyeucau)
	begin
			print (N'Voucher không hợp lệ')
			return
	end

	set @gtrithanhtoan = @giagoc - @sotiengiam - @giagoc * @phantramgiam /100

	if (not exists (Select * from VAN_CHUYEN_MAT_HANG vcmh where vcmh.MADONVI = @dvvc and vcmh.MAMATHANG = @maMatHang))
		begin
			print N'Đơn vị vận chuyển không hợp lệ'
			return
		end

	declare @giavc float = (select dvvc.GIATHANHMOTDONVI from DONVIVANCHUYEN dvvc where dvvc.MADONVI = @dvvc)

	set @gtrithanhtoan = @gtrithanhtoan + @giavc;


	insert into SANPHAMCHON values (@maTaiKhoan, @stt, @maMatHang, @maLuaChon, @maPhieu, @soLuong, @giagoc, @gtrithanhtoan, 1, @mavoucher, @dvvc);
end
go


exec sp_themVaoGioHang 'gcoggen1', '#3f7ecc', '#0eb', null, 10, 'myt1234', '123'
go
--Xem giỏ hàng
create proc sp_xemGio @maTaiKhoan nvarchar(10)
as
begin
	select * from SANPHAMCHON
	where MATAIKHOAN = @maTaiKhoan and  CONTRONGGIOHANG = 1;
end
go

exec sp_xemGio 'gcoggen1'

--Tự động sinh ra mã phiếu
create function fn_genMaPhieu (@maTaiKhoan nvarchar(10))
returns nvarchar(10)
as
begin
	declare @mpStr nvarchar(10), @mpInt int
	set @mpStr = 	(select spc.MAPHIEU 
	from PHIEUTHANHTOAN ptt, SANPHAMCHON spc
	where ptt.MAPHIEU = spc.MAPHIEU and @maTaiKhoan = spc.MATAIKHOAN and ptt.TRANGTHAI = 1)

	set @mpInt = cast(@mpStr as int)
	if (@mpStr is null)
		begin
			set @mpStr = dbo.sp_AutoMaPhieu()
			exec sp_addPhieu @mpStr, null, 0.0, 0.0, 0.0, 1;
		end
	else
		return @mpStr
	return @mpStr
end
go
select * from TAIKHOAN where MATAIKHOAN = 'dpulhoster'

select dbo.fn_genMaPhieu('dpulhoster');
go

CREATE function sp_AutoMaPhieu ()
returns nvarchar(3)
AS
begin
	DECLARE @num int
	DECLARE @temp nvarchar(3)
	SET @num = 1
	
	WHILE (1=1)
	BEGIN
		IF (@num < 10)
			BEGIN
				SET @temp = '00' + CAST(@num as nvarchar(1))
			END
		ELSE IF (@num < 100)
			BEGIN
				SET @temp = '0' + CAST(@num as nvarchar(2))
			END
		ELSE
			BEGIN
				SET @temp = CAST(@num as nvarchar(3))
			END
		
		IF (NOT EXISTS(SELECT * FROM PHIEUTHANHTOAN WHERE MAPHIEU = @temp))
			BEGIN
				return @temp;
			END
		
		SET @num = @num + 1
	END
	return @temp;
end
go

select dbo.sp_AutoMaPhieu()
go

--Tạo phiếu thanh toán
create proc sp_addPhieu @maPhieu nvarchar(10), @mavoucher nvarchar(10), @tonggiatrigoc float, @giavanchuyen float, @tonggiatrithanhtoan float, @trangthai bit
as
begin
	insert into PHIEUTHANHTOAN values(@maPhieu, @mavoucher,
			@tonggiatrigoc, @giavanchuyen, @tonggiatrithanhtoan,
			@trangthai)
end
