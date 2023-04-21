---------------Lab8----------------
---------cau1--------
go
CREATE PROCEDURE Cau1
    @manv NVARCHAR(10),
    @gioitinh NVARCHAR(3),
    @diachi NVARCHAR(50),
    @email NVARCHAR(50),
    @phong NVARCHAR(50),
    @flag INT
AS
BEGIN
   
    IF (@gioitinh <> N'Nam' AND @gioitinh <> N'Nữ')
    BEGIN
        SELECT 1 AS 'MaLoi', 'Giới tính không hợp lệ' AS 'MoTaLoi'
        RETURN
    END
    
  
    IF (@flag = 0)
    BEGIN
        INSERT INTO nhanvien (manv, gioitinh, diachi, email, phong)
        VALUES (@manv, @gioitinh, @diachi, @email, @phong)
        SELECT 0 AS 'MaLoi', 'Thêm mới nhân viên thành công' AS 'MoTaLoi'
    END
    -- Ngược lại, flag = 1 thì cập nhật thông tin nhân viên
    ELSE
    BEGIN
        UPDATE nhanvien
        SET gioitinh = @gioitinh,
            diachi = @diachi,
            email = @email,
            phong = @phong
        WHERE manv = @manv
        SELECT 0 AS 'MaLoi', 'Cập nhật thông tin nhân viên thành công' AS 'MoTaLoi'
    END
END
go

--cau2--
go
CREATE PROCEDURE Cau2
    @masp INT,
    @tenhang NVARCHAR(50),
    @tensp NVARCHAR(50),
    @soluong INT,
    @mausac NVARCHAR(20),
    @giaban FLOAT,
    @donvitinh NVARCHAR(10),
    @mota NVARCHAR(MAX),
    @flag INT
AS
BEGIN
    DECLARE @mahangsx INT

    -- Kiểm tra xem tenhang có tồn tại trong bảng hangsx hay không
    SELECT @mahangsx = mahangsx FROM hangsx WHERE tenhang = @tenhang
    IF @mahangsx IS NULL
    BEGIN
        -- Trả về mã lỗi 1 nếu tenhang không tồn tại trong bảng hangsx
        SELECT 1 AS [ErrorCode], 'Tên hàng không tồn tại' AS [Message]
        RETURN
    END

    -- Kiểm tra số lượng sản phẩm
    IF @soluong < 0
    BEGIN
        -- Trả về mã lỗi 2 nếu soluong < 0
        SELECT 2 AS [ErrorCode], 'Số lượng không hợp lệ' AS [Message]
        RETURN
    END

    IF @flag = 0 -- Thêm mới sản phẩm
    BEGIN
        INSERT INTO sanpham(masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        VALUES(@masp, @mahangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)

        SELECT 0 AS [ErrorCode], 'Thêm sản phẩm thành công' AS [Message]
    END
    ELSE -- Cập nhật thông tin sản phẩm
    BEGIN
        UPDATE sanpham
        SET mahangsx = @mahangsx,
            tensp = @tensp,
            soluong = @soluong,
            mausac = @mausac,
            giaban = @giaban,
            donvitinh = @donvitinh,
            mota = @mota
        WHERE masp = @masp

        SELECT 0 AS [ErrorCode], 'Cập nhật thành công' AS [Message]
    END
END
go
--cau3--
CREATE PROCEDURE sp_XoaNhanVien
    @manv NVARCHAR(10)
AS
BEGIN
    -- Kiểm tra xem mã nhân viên có tồn tại trong bảng nhanvien hay không
    IF NOT EXISTS (SELECT * FROM nhanvien WHERE manv = @manv)
    BEGIN
        -- Nếu không tồn tại, trả về mã lỗi 1
        SELECT 1 AS 'Lỗi'
        RETURN
    END
    
    -- Xóa dữ liệu của nhân viên trong bảng Nhập và Xuat
    DELETE FROM Nhap WHERE manv = @manv
    DELETE FROM Xuat WHERE manv = @manv
    
    -- Xóa dữ liệu của nhân viên trong bảng nhanvien
    DELETE FROM nhanvien WHERE manv = @manv
    
    -- Trả về mã lỗi 0 để cho biết xóa thành công
    SELECT 0 AS 'Lỗi'
END