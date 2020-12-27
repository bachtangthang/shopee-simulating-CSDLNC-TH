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