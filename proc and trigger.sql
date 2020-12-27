--Quy trình thêm hàng: gọi Procedure Them_hang --> Them_thong_tin_van_chuyen --> Them_nhom_nganh_hang --> Them_lua_chon
--Thêm hàng

CREATE PROCEDURE Them_hang
	@p_MATAIKHOAN nvarchar(10),
	@p_MASHOP nvarchar(10),
	@p_TENMATHANG nvarchar(10),
	@p_MOTASANPHAM nvarchar(10),
	@p_KHOILUONGDONGGOI float,
	@p_CHIEUDAI float,
	@p_CHIEURONG float,
	@p_CHIEUCAO float,
	@p_GIAVANCHUYENDUKIEN float,
	@p_DATHANGTRUOC bit,
	@p_TINHTRANG nvarchar(50),
	@p_SONGAYCANCHUANBI int
AS
BEGIN
	DECLARE @v_GenIndentifier NVARCHAR(10)
	--Identifier: Đổi timestamp(ngày - giờ - phút - giây) ra string và nối vào 5 chữ đầu của mã shop;
	SET @v_GenIndentifier = CONVERT(NVARCHAR(MAX), CONVERT(BINARY(8), SUBSTRING(CONVERT(timestamp, GETDATE()),3,20)), 2) + SUBSTRING(@p_MASHOP, 1, 5);
	INSERT INTO MATHANG VALUES (@v_GenIndentifier, @p_MATAIKHOAN, @p_MASHOP, @p_TENMATHANG, @p_MOTASANPHAM, @p_KHOILUONGDONGGOI, @p_CHIEUDAI, @p_CHIEURONG, @p_CHIEUCAO, @p_GIAVANCHUYENDUKIEN
	, @p_DATHANGTRUOC, @p_TINHTRANG, @p_SONGAYCANCHUANBI)
END;
GO


--Thêm thông tin ngành hàng sau khi đã thêm MATHANG
CREATE PROCEDURE Them_thong_tin_nhom_nganh_hang
	@p_MANHOM nvarchar(10),
	@p_MAMATHANG nvarchar(10),
	@p_TENNHOMHANG nvarchar(10)
AS
BEGIN
	INSERT INTO NHOMNGANHHANG VALUES (@p_MANHOM, @p_MAMATHANG, @p_TENNHOMHANG)
END;
GO

--Thêm thông tin vận chuyển của MATHANG
CREATE PROCEDURE Them_thong_tin_van_chuyen
	@p_MAMATHANG nvarchar(10),
	@p_MADONVI nvarchar(10)
AS
BEGIN
	INSERT INTO VAN_CHUYEN_MAT_HANG VALUES (@p_MAMATHANG, @p_MADONVI)
END;
GO

--Thêm lựa chọn của mặt hàng
CREATE PROCEDURE Them_lua_chon
	@p_MAMATHANG nvarchar(10),
	@p_TENCUMPHANLOAI nvarchar(10),
	@p_TENLUACHON nvarchar(10),
	@p_SOLUONGTONKHO int,
	@p_GIACA float,
	@p_SKUPHANLOAI nvarchar(10)
AS
BEGIN
	DECLARE @v_GenMALUACHON nvarchar(10)
	SET @v_GenMALUACHON = CAST(NEWID() as nvarchar(40)) + SUBSTRING(@p_MAMATHANG, 1, 5);
	INSERT INTO LUACHON VALUES (@p_MAMATHANG, @p_TENCUMPHANLOAI, @p_TENLUACHON, @v_GenMALUACHON, @p_SOLUONGTONKHO, @p_GIACA, @p_SKUPHANLOAI)
END;


--test 
SELECT CAST(NEWID() as nvarchar(40)) + 'test';
SELECT CONVERT(NVARCHAR(MAX), CONVERT(BINARY(8), SUBSTRING(CONVERT(timestamp, GETDATE()),3,20)), 2) + substring('testfunc', 1, 5);
--Thêm lựa chọn của mặt hàng
CREATE PROCEDURE Them_lua_chon
	@p_MAMATHANG nvarchar(10),
	@p_TENCUMPHANLOAI nvarchar(10),
	@p_TENLUACHON nvarchar(10),
	@p_SOLUONGTONKHO int,
	@p_GIACA float,
	@p_SKUPHANLOAI nvarchar(10)
AS
BEGIN
	IF (NOT EXISTS(SELECT MAMATHANG
					FROM MATHANG
					WHERE MAMATHANG = @p_MAMATHANG))
		BEGIN
			RAISERROR ('Khong tim thay mat hang.', 16, 1)
			ROLLBACK TRANSACTION
		END
	IF (@p_GIACA < 1000 OR @p_GIACA > 120000000)
		BEGIN
			RAISERROR ('Gia ca khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
	IF (@p_SOLUONGTONKHO < 0 OR @p_SOLUONGTONKHO > 999999)
		BEGIN
			RAISERROR ('Gia ca khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
	DECLARE @v_GenMALUACHON nvarchar(10)
	SET @v_GenMALUACHON = CAST(NEWID() as nvarchar(40)) + SUBSTRING(@p_MAMATHANG, 1, 5);
	INSERT INTO LUACHON VALUES (@p_MAMATHANG, @p_TENCUMPHANLOAI, @p_TENLUACHON, @v_GenMALUACHON, @p_SOLUONGTONKHO, @p_GIACA, @p_SKUPHANLOAI)
END

GO



--test 
SELECT CAST(NEWID() as nvarchar(40)) + 'test';
SELECT CONVERT(NVARCHAR(MAX), CONVERT(BINARY(8), SUBSTRING(CONVERT(timestamp, GETDATE()),3,20)), 2) + substring('testfunc', 1, 5);

GO

create proc sp_ChonSanPhamCapNhat(@masp nvarchar(20))
as
begin
	select TENMATHANG from MATHANG where MAMATHANG=@masp
end

GO 
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
END

GO 

CREATE PROC sp_DangNhap(@tendangnhap NVARCHAR(50), @matkhau NVARCHAR(50))
AS
	BEGIN
		SELECT * FROM dbo.TAIKHOAN WHERE dbo.TAIKHOAN.TENDANGNHAP = @tendangnhap AND dbo.TAIKHOAN.MATKHAU = @matkhau
	END

GO


	--Tìm mặt hàng theo tên hàng
create procedure [dbo].[sp_timMatHang](@tenMH nvarchar(20)) 
as
begin
	select mh.TENMATHANG, mh.MASHOP, mh.MOTASANPHAM, mh.KHOILUONGDONGGOI, mh.CHIEUCAO, mh.CHIEUDAI, mh.CHIEURONG, min(lc.GIACA) 'Gia tu', max(lc.GIACA) 'Den'
	from MATHANG mh, LUACHON lc
	where @tenMH like mh.TENMATHANG and mh.MAMATHANG = lc.MAMATHANG
	group by mh.TENMATHANG, mh.MASHOP, mh.MOTASANPHAM, mh.KHOILUONGDONGGOI, mh.CHIEUCAO, mh.CHIEUDAI, mh.CHIEURONG
END

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
create proc sp_xemGio @maphieu nvarchar(10)
as
begin
	select * from dbo.SANPHAMCHON
	where MAPHIEU = @maphieu and  CONTRONGGIOHANG	 = 1;
end
go


GO 

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
END

GO

select * from TAIKHOAN where MATAIKHOAN = 'dpulhoster'

select dbo.fn_genMaPhieu('dpulhoster');
GO


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
END

GO

create proc sp_UpdatePhieuThanhToan @maphieu NVARCHAR(10)
as
begin

	update PHIEUTHANHTOAN set TRANGTHAI=1 where MAPHIEU=@maphieu
end

GO

--tính tổng giá trị gốc (bảng phiếu thanh toán)
CREATE TRIGGER [dbo].[trg_TongGiaTriGoc]
   ON  [dbo].[SANPHAMCHON] 
   AFTER INSERT, UPDATE
AS 
BEGIN
	DECLARE @maphieu AS NVARCHAR(10) = (SELECT Inserted.MAPHIEU FROM Inserted);
    UPDATE dbo.PHIEUTHANHTOAN SET TONGGIATRIGOC=(SELECT SUM(GIATRITHANHTOAN * SOLUONG) FROM dbo.[SANPHAMCHON] WHERE MAPHIEU = @maphieu AND CONTRONGGIOHANG = 1) WHERE PHIEUTHANHTOAN.MAPHIEU = @maphieu
END


GO

--tính tổng giá trị cần thanh toán (bảng phiếu thanh toán)
CREATE TRIGGER dbo.trg_TongGiaTriCanThanhToan
	ON dbo.SANPHAMCHON
	AFTER INSERT,UPDATE
AS
BEGIN
	DECLARE @maphieu AS NVARCHAR(10) = (SELECT Inserted.MAPHIEU FROM Inserted);
	UPDATE dbo.PHIEUTHANHTOAN SET TONGGIATRICANTHANHTOAN = TONGGIATRIGOC + GIAVANCHUYEN WHERE MAPHIEU = @maphieu
END


GO


--tính giá trị thanh toán (bảng sản phẩm chọn)
CREATE TRIGGER dbo.trg_GiaTriThanhToan
	ON dbo.SANPHAMCHON
	AFTER INSERT,UPDATE
AS
BEGIN
	DECLARE @mavoucher AS NVARCHAR(10) = (SELECT Inserted.MAVOUCHER FROM Inserted);
	IF @mavoucher IS NULL
		BEGIN
        	UPDATE dbo.SANPHAMCHON SET GIATRITHANHTOAN = Inserted.GIAGOC FROM Inserted WHERE Inserted.MATAIKHOAN = dbo.SANPHAMCHON.MATAIKHOAN AND Inserted.STT = dbo.SANPHAMCHON.STT
			RETURN
        END
	DECLARE @min_hang AS INT  = (SELECT SOHANGTOITHIEU FROM dbo.VOUCHERSHOP WHERE dbo.VOUCHERSHOP.MAVOUCHER = @mavoucher)
	DECLARE @min_tien AS FLOAT  = (SELECT SOTIENTOITHIEUYEUCAU FROM dbo.VOUCHERSHOP WHERE dbo.VOUCHERSHOP.MAVOUCHER = @mavoucher)
	IF ((SELECT GIAGOC * SOLUONG FROM Inserted) >= @min_tien AND (SELECT soluong FROM Inserted) >= @min_hang) 
		BEGIN
			IF ((SELECT SOTIENGIAM FROM dbo.VOUCHERSHOP) IS NULL)
				BEGIN
					UPDATE dbo.SANPHAMCHON SET GIATRITHANHTOAN = dbo.SANPHAMCHON.GIAGOC*(1 - PHANTRAMGIAM /100) FROM dbo.VOUCHER, Inserted WHERE dbo.SANPHAMCHON.MATAIKHOAN = Inserted.MATAIKHOAN AND Inserted.STT = dbo.SANPHAMCHON.STT
					RETURN 
				END
			IF ((SELECT PHANTRAMGIAM FROM dbo.VOUCHERSHOP) IS NULL)
				BEGIN
					UPDATE dbo.SANPHAMCHON SET GIATRITHANHTOAN = (dbo.SANPHAMCHON.GIAGOC - SOTIENGIAM) * dbo.SANPHAMCHON.SOLUONG FROM dbo.VOUCHERSHOP, Inserted WHERE dbo.SANPHAMCHON.MATAIKHOAN = Inserted.MATAIKHOAN AND Inserted.STT = dbo.SANPHAMCHON.STT
					RETURN
				END
        END
END


GO

CREATE PROC sp_TimKiemMonHang(@tensp nvarchar(20), @phanloaisp nvarchar(20))
AS
BEGIN
	SELECT * FROM MATHANG MH 
	WHERE MH.TENMATHANG=@tensp
	SELECT * FROM dbo.NHOMNGANHHANG
	WHERE TENNHOMHANG = @phanloaisp
END
DROP PROC dbo.sp_TimKiemMonHang
GO


create proc sp_KiemTraSoHuu(@masp nvarchar(10), @mashop NVARCHAR(10) )
as
begin
	if exists (select TENMATHANG from MATHANG where MAMATHANG=@masp AND MASHOP = @mashop)
	print('Mon hang thuoc so huu cua shop!')
	ELSE
    print('Mon hang khong thuoc so huu cua shop!')
end

go

--tính tổng giá vận chuyển của 1 phiếu (bảng PHIEUTHANHTOAN)
CREATE TRIGGER dbo.trg_GIAVANCHUYEN
	 ON dbo.SANPHAMCHON
	 AFTER INSERT, UPDATE	
AS
BEGIN
	DECLARE @mamathang AS NVARCHAR(10) = (SELECT Inserted.MAMATHANG FROM Inserted)
	DECLARE @maphieu AS NVARCHAR(10) = (SELECT Inserted.MAPHIEU FROM Inserted)
	DECLARE @tienvc AS FLOAT = (SELECT DONVIVANCHUYEN.GIATHANHMOTDONVI
								FROM dbo.DONVIVANCHUYEN, Inserted
								WHERE dbo.DONVIVANCHUYEN.MADONVI = Inserted.DONVIVANCHUYEN
								)
	DECLARE @khoiluong AS FLOAT = (	SELECT dbo.MATHANG.KHOILUONGDONGGOI
									FROM dbo.MATHANG
									WHERE dbo.MATHANG.MAMATHANG = @mamathang
									)
	UPDATE dbo.PHIEUTHANHTOAN SET GIAVANCHUYEN = @tienvc * @khoiluong WHERE dbo.PHIEUTHANHTOAN.MAPHIEU = @maphieu
END

GO

CREATE TRIGGER dbo.trg_DONVIVANCHUYEN
	ON dbo.SANPHAMCHON
	AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @donvivc AS NVARCHAR(10) = (SELECT Inserted.DONVIVANCHUYEN FROM Inserted)
	DECLARE @mamathang AS NVARCHAR(10) = (SELECT Inserted.MAMATHANG FROM Inserted)
	DECLARE q CURSOR FOR
		SELECT dbo.VAN_CHUYEN_MAT_HANG.MADONVI
		FROM dbo.VAN_CHUYEN_MAT_HANG
		WHERE dbo.VAN_CHUYEN_MAT_HANG.MAMATHANG = @mamathang
	DECLARE @dvvc AS NVARCHAR(10)
	OPEN q
	FETCH NEXT FROM q INTO @dvvc
	WHILE @@FETCH_STATUS =0
	BEGIN
		IF(@donvivc = @dvvc)
			RETURN
		FETCH NEXT FROM q INTO @dvvc
	END
	CLOSE q
	DEALLOCATE q
	ROLLBACK
END

GO

--Trigger kiểm tra MATHANG khi INSERT
CREATE TRIGGER Check_Insert_MatHang
ON MATHANG
FOR INSERT
AS
BEGIN
	IF (EXISTS(SELECT *
				FROM inserted
				WHERE inserted.CHIEUCAO <= 0 OR inserted.CHIEUCAO > 1000000))
		BEGIN
			RAISERROR ('Chieu cao khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
	IF (EXISTS(SELECT *
				FROM inserted
				WHERE inserted.CHIEUDAI <= 0 OR inserted.CHIEUDAI > 1000000))
		BEGIN
			RAISERROR ('Chieu dai khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
	IF (EXISTS(SELECT *
				FROM inserted
				WHERE inserted.CHIEURONG <= 0 OR inserted.CHIEURONG > 1000000))
		BEGIN
			RAISERROR ('Chieu rong khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
	IF (EXISTS(SELECT *
				FROM inserted
				WHERE inserted.KHOILUONGDONGGOI <= 0 OR inserted.KHOILUONGDONGGOI > 1000000))
		BEGIN
			RAISERROR ('Khoi luong dong goi vuot qua gioi han hoac khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
END;
GO

--Trigger kiểm tra thông tin lựa chọn
CREATE TRIGGER Check_Insert_LuaChon
ON LUACHON
FOR INSERT
AS
BEGIN
	IF (EXISTS(SELECT *
				FROM inserted
				WHERE inserted.GIACA < 1000 OR inserted.GIACA > 120000000))
		BEGIN
			RAISERROR ('Gia ca khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
	IF (EXISTS(SELECT *
				FROM inserted
				WHERE inserted.SOLUONGTONKHO < 0 OR inserted.SOLUONGTONKHO > 999999))
		BEGIN
			RAISERROR ('So luong ton kho khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
END;
GO

--truy vấn 1
EXEC dbo.sp_DangNhap @tendangnhap = N'thanâsgbach', -- nvarchar(50)
                     @matkhau = N'123456'      -- nvarchar(50)

--test chỉ mục
CREATE NONCLUSTERED INDEX ten_DN ON dbo.TAIKHOAN (TENDANGNHAP)
DROP INDEX dbo.TAIKHOAN.ten_DN

--truy vấn 2
	EXEC dbo.sp_themVaoGioHang @maTaiKhoan = N'uhiskj', -- nvarchar(10)
							   @maMatHang = N'aaaaads',  -- nvarchar(10)
							   @maLuaChon = N'sssawd23',  -- nvarchar(10)
							   @maPhieu = N'ass',    -- nvarchar(3)
							   @soLuong = 1,      -- int
							   @mavoucher = N'9009',  -- nvarchar(10)
							   @dvvc = N'1231'        -- nvarchar(10)
--truy vấn 3
SELECT * FROM dbo.VOUCHER
EXEC dbo.sp_addPhieu @maPhieu = N'oilasdi',             -- nvarchar(10)
                     @mavoucher = N'2XRAC397',           -- nvarchar(10)
                     @tonggiatrigoc = 0.0,       -- float
                     @giavanchuyen = 0.0,        -- float
                     @tonggiatrithanhtoan = 0.0, -- float
                     @trangthai = 1          -- bit

--truy vấn 4:
EXEC dbo.sp_xemGio @maphieu = N'oilasdi' -- nvarchar(10)
EXEC dbo.sp_UpdatePhieuThanhToan @maphieu = N'oilasdi' -- nvarchar(10)

--truy vấn 5:
EXEC dbo.Them_hang @p_MATAIKHOAN = N'184ICW',         -- nvarchar(10)
                   @p_MASHOP = N'NSGAU6I8U',             -- nvarchar(10)
                   @p_TENMATHANG = N'laptop',         -- nvarchar(10)
                   @p_MOTASANPHAM = N'một chiếc máy tính',        -- nvarchar(10)
                   @p_KHOILUONGDONGGOI = 300.0,   -- float
                   @p_CHIEUDAI = 200.0,           -- float
                   @p_CHIEURONG = 170.0,          -- float
                   @p_CHIEUCAO = 40.0,           -- float
                   @p_GIAVANCHUYENDUKIEN = 2000.0, -- float
                   @p_DATHANGTRUOC = 1,      -- bit
                   @p_TINHTRANG = N'có nhiều',          -- nvarchar(50)
                   @p_SONGAYCANCHUANBI = 0      -- int
EXEC dbo.Them_thong_tin_van_chuyen @p_MAMATHANG = N'I9PYDH', -- nvarchar(10)
                                   @p_MADONVI = N'AVIBBB'    -- nvarchar(10)
EXEC dbo.Them_thong_tin_van_chuyen @p_MAMATHANG = N'I9PYDH', -- nvarchar(10)
                                   @p_MADONVI = N'WIAO44T9P8'    -- nvarchar(10)

-- truy vấn 6:
EXEC dbo.sp_KiemTraSoHuu @masp = N'I9PYDH',  -- nvarchar(10)
                         @mashop = N'AVIBBB' -- nvarchar(10)


CREATE CLUSTERED INDEX idx_mashop ON dbo.MATHANG(MASHOP)
	
--truy vấn 7:
EXEC dbo.sp_TimKiemMonHang @tensp = N'laptop',     -- nvarchar(20)
                           @phanloaisp = N'maytinh' -- nvarchar(20)
