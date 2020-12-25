CREATE PROC sp_DangNhap(@tendangnhap NVARCHAR(50), @matkhau NVARCHAR(50))
AS
	BEGIN
		SELECT * FROM dbo.TAIKHOAN WHERE dbo.TAIKHOAN.TENDANGNHAP = @tendangnhap AND dbo.TAIKHOAN.MATKHAU = @matkhau
	END
