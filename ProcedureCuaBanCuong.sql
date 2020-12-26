use test1
go

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
	IF (@p_CHIEUCAO <= 0 OR @p_CHIEUCAO > 1000000)
		BEGIN
			RAISERROR ('Chieu cao khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
	IF (@p_CHIEUDAI <= 0 OR @p_CHIEUDAI > 1000000)
		BEGIN
			RAISERROR ('Chieu dai khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
	IF (@p_CHIEURONG <= 0 OR @p_CHIEURONG > 1000000)
		BEGIN
			RAISERROR ('Chieu rong khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
	IF (@p_KHOILUONGDONGGOI <=0 OR @p_KHOILUONGDONGGOI > 100)
		BEGIN
			RAISERROR ('Khoi luong dong goi vuot qua gioi han hoac khong hop le.', 16, 1)
			ROLLBACK TRANSACTION
		END
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
	--kiểm tra đã thêm MATHANG thành công chưa
	IF (NOT EXISTS(SELECT MAMATHANG
					FROM MATHANG
					WHERE MAMATHANG = @p_MAMATHANG))
		BEGIN
			RAISERROR ('Khong tim thay mat hang.', 16, 1)
			ROLLBACK TRANSACTION
		END
	ELSE
		INSERT INTO NHOMNGANHHANG VALUES (@p_MANHOM, @p_MAMATHANG, @p_TENNHOMHANG)
END;
GO

--Thêm thông tin vận chuyển của MATHANG
CREATE PROCEDURE Them_thong_tin_van_chuyen
	@p_MAMATHANG nvarchar(10),
	@p_MADONVI nvarchar(10)
AS
BEGIN
	IF (NOT EXISTS(SELECT MAMATHANG
					FROM MATHANG
					WHERE MAMATHANG = @p_MAMATHANG))
		BEGIN
			RAISERROR ('Khong tim thay mat hang.', 16, 1)
			ROLLBACK TRANSACTION
		END
	ELSE
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
END;


--test 
SELECT CAST(NEWID() as nvarchar(40)) + 'test';
SELECT CONVERT(NVARCHAR(MAX), CONVERT(BINARY(8), SUBSTRING(CONVERT(timestamp, GETDATE()),3,20)), 2) + substring('testfunc', 1, 5);