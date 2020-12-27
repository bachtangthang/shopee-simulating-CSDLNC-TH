USE test1
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