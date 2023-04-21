
---------------------lab5-----------------------
-----------Cau 1--------------
go
CREATE FUNCTION Lab5_cau1()
RETURNS TABLE
AS
RETURN
SELECT *
FROM Sanpham;
go
SELECT * FROM Lab5_cau1();
 -----------Cau 2-------
go
CREATE FUNCTION Lab5_cau2(@x INT, @y INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @TongGiaTriNhap MONEY
    SELECT @TongGiaTriNhap = SUM(dongiaN * soluongN)
    FROM Nhap
    WHERE YEAR(ngaynhap) BETWEEN @x AND @y
    RETURN @TongGiaTriNhap
END
go
go
SELECT dbo.Lab5_cau2(2016,2018)
go


----------Cau 3-----------
go 
CREATE FUNCTION Lab5_cau3(@tenSP nvarchar(50), @nam int)
RETURNS int
AS
BEGIN
    DECLARE @soLuongNhap int, @soLuongXuat int, @soLuongThayDoi int;
    SELECT @soLuongNhap = SUM(soluongN) FROM Nhap n JOIN Sanpham sp ON n.masp = sp.masp WHERE sp.tensp = @tenSP AND YEAR(n.ngaynhap) = @nam;
    SELECT @soLuongXuat = SUM(soluongX) FROM Xuat x JOIN Sanpham sp ON x.masp = sp.masp WHERE sp.tensp = @tenSP AND YEAR(x.ngayxuat) = @nam;
    SET @soLuongThayDoi = @soLuongNhap - @soLuongXuat;
    RETURN @soLuongThayDoi;
END
go
go
SELECT dbo.Lab5_cau3('Galaxy V21',2020)
go

------------------Cau 4------------
go
CREATE FUNCTION dbo.Lab5_cau4(
    @ngay_bat_dau DATE,
    @ngay_ket_thuc DATE
)
RETURNS MONEY
AS
BEGIN
    DECLARE @tonggiatrinhap MONEY;
    SELECT @tonggiatrinhap = SUM(nhap.soluongN * sanpham.giaban)
    FROM Nhap AS nhap
    INNER JOIN Sanpham AS sanpham ON nhap.masp = sanpham.masp
    WHERE nhap.ngaynhap >= @ngay_bat_dau AND nhap.ngaynhap <= @ngay_ket_thuc;
    RETURN @tonggiatrinhap;
END;
go
go
SELECT dbo.Lab5_cau4('2019-01-01', '2020-12-31') AS TongGiaTriNhap;
go

------------------Cau 5------------
go
CREATE FUNCTION Lab5_cau5(@tenHang NVARCHAR(20), @nam INT)
RETURNS MONEY
AS
BEGIN
  DECLARE @tongGiaTriXuat MONEY;
  SELECT @tongGiaTriXuat = SUM(S.giaban * X.soluongX)
  FROM Xuat X
  JOIN Sanpham S ON X.masp = S.masp
  JOIN Hangsx H ON S.mahangsx = H.mahangsx
  WHERE H.tenhang = @tenHang AND YEAR(X.ngayxuat) = @nam;
  RETURN @tongGiaTriXuat;
END;
go
go
SELECT dbo.Lab5_cau5(N'OPPO', 2019) AS 'TongGiaTriXuat';
go

--------------Cau 6-------------
go
CREATE FUNCTION Lab5_cau6 (@tenPhong NVARCHAR(30))
RETURNS TABLE
AS
RETURN
    SELECT phong, COUNT(manv) AS soLuongNhanVien
    FROM Nhanvien
    WHERE phong = @tenPhong
    GROUP BY phong;
go
go
SELECT * FROM Lab5_cau6(N'Kế toán')
go

--------------Cau 7--------------
go
CREATE FUNCTION Lab5_cau7 (@ten_sp NVARCHAR(20), @ngay_xuat DATE)
RETURNS INT
AS
BEGIN
  DECLARE @so_luong_xuat INT
  SELECT @so_luong_xuat = SUM(soluongX)
  FROM Xuat x JOIN Sanpham sp ON x.masp = sp.masp
  WHERE sp.tensp = @ten_sp AND x.ngayxuat = @ngay_xuat
  RETURN @so_luong_xuat
END
go
go
SELECT	dbo.Lab5_cau7('Vinfone', '1-1-2020') as 'sản phẩm sản xuất trong ngày'
go
------------ Cau8-------------
go
CREATE FUNCTION Lab5_cau8 (@InvoiceNumber NCHAR(10))
RETURNS NVARCHAR(20)
AS
BEGIN
  DECLARE @EmployeePhone NVARCHAR(20)
  SELECT @EmployeePhone = Nhanvien.sodt
  FROM Nhanvien
  INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv
  WHERE Xuat.sohdx = @InvoiceNumber
  RETURN @EmployeePhone
END
go
go
SELECT dbo.Lab5_cau8('X03')
go
--------------Cau 9-------------
go
CREATE FUNCTION Lab5_cau9(@tenSP NVARCHAR(20), @nam INT)
RETURNS INT
AS
BEGIN
  DECLARE @tongNhapXuat INT;
  SET @tongNhapXuat = (SELECT COALESCE(SUM(nhap.soluongN), 0) + COALESCE(SUM(xuat.soluongX), 0) AS tongSoLuong
    FROM Sanpham sp
    LEFT JOIN Nhap nhap ON sp.masp = nhap.masp
    LEFT JOIN Xuat xuat ON sp.masp = xuat.masp
    WHERE sp.tensp = @tenSP AND YEAR(nhap.ngaynhap) = @nam AND YEAR(xuat.ngayxuat) = @nam
  );
  RETURN @tongNhapXuat;
END;
go
SELECT dbo.Lab5_cau9('Galaxy V21', 2020) AS TongNhapXuat;
--------------------Cau10---------------
go
CREATE FUNCTION Lab5_cau10(@tenhang NVARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @soluong INT;

    SELECT @soluong = SUM(soluong)
    FROM Sanpham sp JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
    WHERE hs.tenhang = @tenhang;

    RETURN @soluong;
END;
go
SELECT dbo.Lab5_cau10('Vinfone') AS 'Tổng số lượng sản phẩm của hãng'
go


