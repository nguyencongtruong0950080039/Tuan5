
Create database QLTH
go
use QLTH
go
CREATE TABLE Khoa (
    Makhoa INT PRIMARY KEY,
    Tenkhoa VARCHAR(50) NOT NULL,
    Dienthoai VARCHAR(20) NOT NULL
);

CREATE TABLE Lop (
    Malop INT PRIMARY KEY,
    Tenlop VARCHAR(50) NOT NULL,
    Khoa VARCHAR(50) NOT NULL,
    Hedt VARCHAR(50) NOT NULL,
    Namnhaphoc INT NOT NULL,
    Makhoa INT NOT NULL,
    FOREIGN KEY (Makhoa) REFERENCES Khoa(Makhoa)
);
-----cau1---------
go
CREATE PROCEDURE ThemKhoa
    @makhoa INT,
    @tenkhoa VARCHAR(50),
    @dienthoai VARCHAR(20)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Khoa WHERE Tenkhoa = @tenkhoa)
    BEGIN
        INSERT INTO Khoa (Makhoa, Tenkhoa, Dienthoai)
        VALUES (@makhoa, @tenkhoa, @dienthoai)
        PRINT N'Thêm khoa thành công.'
    END
    ELSE
    BEGIN
        PRINT N'Khoa đã tồn tại trong cơ sở dữ liệu.'
    END
END
EXEC ThemKhoa 1, 'Khoa Toan-Tin', '0987654321'
EXEC ThemKhoa 2, 'Khoa Khoa Hoc Tu Nhien', '0123456789'
--------cau2-------------
go
CREATE PROCEDURE ThemLop
    @malop INT,
    @tenlop VARCHAR(50),
    @khoa VARCHAR(50),
    @hedt VARCHAR(50),
    @namnhaphoc INT,
    @makhoa INT
AS
BEGIN
    DECLARE @count INT
    SELECT @count = COUNT(*) FROM Lop WHERE Tenlop = @tenlop
    IF (@count > 0)
    BEGIN
        PRINT N'Lớp đã tồn tại trong cơ sở dữ liệu.'
    END
    ELSE
    BEGIN
        SELECT @count = COUNT(*) FROM Khoa WHERE Makhoa = @makhoa
        IF (@count = 0)
        BEGIN
            PRINT N'Mã Khoa Không tồn tại trong cơ sở dữ liệu.'
        END
        ELSE
        BEGIN
            INSERT INTO Lop (Malop, Tenlop, Khoa, Hedt, Namnhaphoc, Makhoa)
            VALUES (@malop, @tenlop, @khoa, @hedt, @namnhaphoc, @makhoa)
            PRINT N'Thêm lớp thành công.'
        END
    END
END
go
DECLARE @malop INT, @tenlop VARCHAR(50), @khoa VARCHAR(50), @hedt VARCHAR(50), @namnhaphoc INT, @makhoa INT
SET @malop = 1
SET @tenlop = 'Lop 1A'
SET @khoa = 'Khoa Toan-Tin'
SET @hedt = 'Dai hoc'
SET @namnhaphoc = 2021
SET @makhoa = 1
EXEC ThemLop @malop, @tenlop, @khoa, @hedt, @namnhaphoc, @makhoa
-- cau 3---------------
go
CREATE PROCEDURE sp_InsertKhoa_CheckExists
    @MaKhoa NVARCHAR(10),
    @TenKhoa NVARCHAR(100),
    @DienThoai NVARCHAR(20),
    @Exists BIT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT * FROM KHOA WHERE TenKhoa = @TenKhoa)
    BEGIN
        SET @Exists = 0
        RETURN
    END
    
    INSERT INTO KHOA(MaKhoa, TenKhoa, DienThoai)
    VALUES (@MaKhoa, @TenKhoa, @DienThoai)
    
    SET @Exists = 1
END
DECLARE @MyExists BIT
EXEC sp_InsertKhoa_CheckExists 'K01', N'Khoa A', '0123456789', @MyExists OUTPUT
IF @MyExists = 1
BEGIN
    PRINT 'Thêm khoa thành công!'
END
ELSE
BEGIN
    PRINT N'Tên khoa đã tồn tại !'
END
-- cau 4--------------
go
CREATE PROCEDURE InsertLop
    @MaLop VARCHAR(10),
    @TenLop NVARCHAR(50),
    @Khoa NVARCHAR(10),
    @HeDT NVARCHAR(50),
    @NamNhapHoc INT,
    @MaKhoa VARCHAR(10)
AS
BEGIN
    -- Kiểm tra xem tên lớp đã có trước đó chưa nếu có thì trả về 0
    IF EXISTS (SELECT 1 FROM Lop WHERE Tenlop = @TenLop)
    BEGIN
        RETURN 0
    END

    -- Kiểm tra xem makhoa này có trong bảng khoa hay không nếu không có thì trả về 1
    IF NOT EXISTS (SELECT 1 FROM Khoa WHERE Makhoa = @MaKhoa)
    BEGIN
        RETURN 1
    END

    -- Nếu đầy đủ thông tin thì cho nhập và trả về 2
    INSERT INTO Lop(Malop, Tenlop, Khoa, Hedt, Namnhaphoc, Makhoa)
    VALUES(@MaLop, @TenLop, @Khoa, @HeDT, @NamNhapHoc, @MaKhoa)
    
    RETURN 2
END
DECLARE @Result INT

EXEC @Result = InsertLop 'L09', N'Lớp 9', 'K09', N'DH', 2021, 'K09'

IF @Result = 0
BEGIN
    PRINT N'Tên lớp đã có trước đó'
END
ELSE IF @Result = 1
BEGIN
    PRINT N'Mã khoa không tồn tại'
END
ELSE IF @Result = 2
BEGIN
    PRINT N'Nhập dữ liệu thành công'
END