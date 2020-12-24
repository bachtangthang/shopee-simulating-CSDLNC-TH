﻿--tính tổng giá trị gốc (bảng phiếu thanh toán)
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
	DECLARE @min_hang AS INT  = (SELECT SOHANGTOITHIEU FROM dbo.VOUCHERSHOP WHERE dbo.VOUCHERSHOP.MAVOUCHER = @mavoucher)
	DECLARE @min_tien AS FLOAT  = (SELECT SOTIENTOITHIEUYEUCAU FROM dbo.VOUCHERSHOP WHERE dbo.VOUCHERSHOP.MAVOUCHER = @mavoucher)
	IF ((SELECT GIAGOC * SOLUONG FROM Inserted WHERE Inserted.CONTRONGGIOHANG = 1) > @min_tien) Or ((SELECT soluong FROM Inserted WHERE Inserted.CONTRONGGIOHANG = 1) > @min_hang )
		BEGIN
			IF ((SELECT SOTIENGIAM FROM dbo.VOUCHERSHOP) IS NULL)
				BEGIN
					UPDATE dbo.SANPHAMCHON SET GIATRITHANHTOAN = GIAGOC*(1 - PHANTRAMGIAM /100) FROM dbo.VOUCHERSHOP WHERE SANPHAMCHON.MAVOUCHER = VOUCHERSHOP.MAVOUCHER
				END
			ELSE IF ((SELECT PHANTRAMGIAM FROM dbo.VOUCHERSHOP) IS NULL)
				BEGIN
					UPDATE dbo.SANPHAMCHON SET GIATRITHANHTOAN = GIAGOC - SOTIENGIAM FROM dbo.VOUCHERSHOP WHERE VOUCHERSHOP.MAVOUCHER = SANPHAMCHON.MAVOUCHER
                END
        END
END


GO

--tính giá vận chuyển của 1 mặt hàng (bảng MATHANG)
CREATE TRIGGER dbo.trg_GIAVANCHUYENDUKIEN
	ON dbo.MATHANG
	AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @khoiluong AS FLOAT =	(SELECT Inserted.KHOILUONGDONGGOI 
									FROM dbo.DONVIVANCHUYEN, dbo.VAN_CHUYEN_MAT_HANG, Inserted 
									WHERE Inserted.MAMATHANG = dbo.VAN_CHUYEN_MAT_HANG.MAMATHANG AND dbo.VAN_CHUYEN_MAT_HANG.MADONVI = dbo.DONVIVANCHUYEN.MADONVI)
	UPDATE dbo.MATHANG SET GIAVANCHUYENDUKIEN = @khoiluong * GIATHANHMOTDONVI FROM dbo.DONVIVANCHUYEN
END


go


--tính tổng giá vận chuyển của 1 phiếu (bảng PHIEUTHANHTOAN)
CREATE TRIGGER dbo.trg_GIAVANCHUYEN
	 ON dbo.SANPHAMCHON
	 AFTER INSERT, UPDATE	
AS
BEGIN
	DECLARE @maphieu AS NVARCHAR(10) = (SELECT Inserted.MAPHIEU FROM Inserted)
	UPDATE dbo.PHIEUTHANHTOAN SET GIAVANCHUYEN =	(SELECT SUM(GIAVANCHUYENDUKIEN) 
													FROM dbo.MATHANG, dbo.SANPHAMCHON 
													WHERE dbo.MATHANG.MAMATHANG = dbo.SANPHAMCHON.MAMATHANG AND dbo.SANPHAMCHON.MAPHIEU = dbo.PHIEUTHANHTOAN.MAPHIEU AND @maphieu = dbo.PHIEUTHANHTOAN.MAPHIEU)
END


GO

