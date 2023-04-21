go
CREATE VIEW Lab_2_cau1_Sanpham AS
SELECT masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota
FROM Sanpham;
go
go
Select * from Lab_2_cau1_Sanpham
go

go
CREATE VIEW Lab_2_1_Nhanvien as
SELECT *
FROM Nhanvien;
go

go
Select * from Lab_2_1_Nhanvien
go

go
CREATE VIEW Lab_2_1_Hangsx as
SELECT *
FROM Hangsx;
go

go
Select * from Lab_2_1_Hangsx
go

go
CREATE VIEW Lab_2_1_Nhap as
SELECT *
FROM Nhap;
go

go
Select * from Lab_2_1_Nhap
go

go
CREATE VIEW Lab_2_1_Xuat as
SELECT *
FROM Xuat;
go

go
Select * from Lab_2_1_Xuat
go

create view Lab_2_cau2 as
SELECT Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
go
go
Select * from Lab_2_cau2 ORDER BY Lab_2_cau2.giaban DESC;
go

go
Create view Lab_2_cau3 as
SELECT Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung'
go
go
Select * from Lab_2_cau3
go

go
create view Lab_2_cau4 as
SELECT * FROM nhanvien
WHERE gioitinh = 'Nữ' AND phong = 'Kế toán'
go
go
Select * from Lab_2_cau4
go


go
create view Lab_2_cau_5 as
SELECT Nhap.sohdn, Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Nhap.soluongN, Nhap.dongiaN, 
Nhap.soluongN*Nhap.dongiaN AS tiennhap, Sanpham.mausac, Sanpham.donvitinh, Nhap.ngaynhap, Nhanvien.tennv, Nhanvien.phong
FROM Nhap
JOIN Sanpham ON Nhap.masp = Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
;
go
go
Select * from Lab_2_cau_5 ORDER BY Lab_2_cau_5.sohdn
go

go
create view Lab_2_cau_6 as
SELECT Xuat.sohdx, Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Xuat.soluongX, Sanpham.giaban, 
       Xuat.soluongX*Sanpham.giaban AS tienxuat, Sanpham.mausac, Sanpham.donvitinh, Xuat.ngayxuat, 
       Nhanvien.tennv, Nhanvien.phong
FROM Xuat
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
INNER JOIN Nhanvien ON Xuat.manv = Nhanvien.manv
WHERE MONTH(Xuat.ngayxuat) = 10 AND YEAR(Xuat.ngayxuat) = 2018
;
go
Select * from Lab_2_cau_6 order by Lab_2_cau_6.sohdx
go

go
create view Lab_2_cau_7 as
SELECT sohdn, Sanpham.masp, tensp, soluongN, dongiaN, ngaynhap, tennv, phong
FROM Nhap 
JOIN Sanpham ON Nhap.masp = Sanpham.masp 
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(ngaynhap) = 2017;
go
go
select * from Lab_2_cau_7
go

go
create view Lab_2_cau_8 as
SELECT TOP 10 Xuat.sohdx, Sanpham.tensp, Xuat.soluongX
FROM Xuat 
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
WHERE YEAR(Xuat.ngayxuat) = '2023' 
go
go
Select * from Lab_2_cau_8 ORDER BY Lab_2_cau_8.soluongX
go


go
create view Lab_2_cau_9 as
SELECT TOP 10 tenSP, giaBan
FROM SanPham
go
go
select * from Lab_2_cau_9 order by Lab_2_cau_9.giaban
go

go
create view Lab_2_cau_10 as
SELECT masp, tensp, tenhang, soluong, mausac, giaban, donvitinh, mota
FROM Sanpham
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000
go
go
select * from Lab_2_cau_10 
go

go 
create view Lab_2_cau_11 as
SELECT SUM(soluongN * dongiaN) AS tongtien
FROM Nhap
JOIN Sanpham ON Nhap.masp = Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(ngaynhap) = 2018
go
go
select * from Lab_2_cau_11 
go

go 
create view Lab_2_cau_12 as

SELECT SUM(Xuat.soluongX * Sanpham.giaban) AS Tongtien
FROM Xuat
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
WHERE Xuat.ngayxuat = '2018-09-02'
go
go
select * from Lab_2_cau_12
go

go
 create view Lab_2_cau_13 as
 SELECT TOP 1 sohdn, ngaynhap, dongiaN
FROM Nhap
go
go
select * from Lab_2_cau_13 order by Lab_2_cau_13.dongiaN
go

go
create view Lab_2_cau_14 as
SELECT TOP 10 Sanpham.tensp, SUM(Nhap.soluongN) AS TongSoLuongN 
FROM Sanpham 
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp 
WHERE YEAR(Nhap.ngaynhap) = 2019 
GROUP BY Sanpham.tensp 
ORDER BY TongSoLuongN DESC
go
go
select * from Lab_2_cau_14
go

go
create view Lab_2_cau_15 as
SELECT Sanpham.masp, Sanpham.tensp
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
INNER JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
WHERE Hangsx.tenhang = 'Samsung' AND Nhanvien.manv = 'NV01';
go
go
Select * from Lab_2_cau_15
go

go
create view Lab_2_cau_16 as
SELECT sohdn, masp, soluongN, ngaynhap
FROM Nhap
WHERE masp = 'SP02' AND manv = 'NV02'
go
go
select * from Lab_2_cau_16
go

go
create view Lab_2_cau_17 as
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Xuat.masp = 'SP02' AND Xuat.ngayxuat = '2020-03-02'
go
go
select * from Lab_2_cau_17
go


-----------lab3-------------
go 
create view Lab_3_cau_1 as
SELECT Hangsx.tenhang, COUNT(*) as 'So luong san pham'
FROM Sanpham
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
GROUP BY Hangsx.tenhang;
go
go
select * from Lab_3_cau_1
go

go
create view Lab_3_cau_2 as
SELECT Sanpham.tensp, SUM(Nhap.soluongN * Nhap.dongiaN) as 'Tong tien nhap'
FROM Sanpham
JOIN Nhap ON Sanpham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Sanpham.tensp;
go
go
select * from Lab_3_cau_2
go

go
create view Lab_3_cau_3 as
SELECT Sanpham.tensp, SUM(Xuat.soluongX) as 'Tong so luong xuat'
FROM Sanpham
JOIN Xuat ON Sanpham.masp = Xuat.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(Xuat.ngayxuat) = 2018
GROUP BY Sanpham.tensp
HAVING SUM(Xuat.soluongX) > 10000;
go
go
select * from Lab_3_cau_3
go

	go
	create view Lab_3_cau_4 as
	SELECT Nhanvien.phong, COUNT(*) as 'So luong nhan vien Nam'
	FROM Nhanvien
	WHERE Nhanvien.gioitinh = N'Nam'
	GROUP BY Nhanvien.phong
	go
	go
	select * from Lab_3_cau_4
	go

go 
create view Lab_3_cau_5 as
SELECT Hangsx.tenhang, SUM(Nhap.soluongN) as 'Tong so luong nhap'
FROM Sanpham
JOIN Nhap ON Sanpham.masp = Nhap.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Hangsx.tenhang;
go
go
select * from Lab_3_cau_5
go


go
create view Lab_3_cau_6 as
SELECT Nhanvien.tennv, SUM(Xuat.soluongX * Sanpham.giaban) as 'Tong tien xuat'
FROM Xuat
JOIN Sanpham ON Xuat.masp = Sanpham.masp
JOIN Nhanvien ON Xuat.manv = Nhanvien.manv
WHERE YEAR(Xuat.ngayxuat) = 2018
GROUP BY Nhanvien.tennv;
go
go
select * from Lab_3_cau_6
go

go
create view Lab_3_cau_7 as
SELECT Nhanvien.tennv, SUM(Nhap.soluongN * Nhap.dongiaN) as 'Tong tien nhap'
FROM Nhap
JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
WHERE YEAR(Nhap.ngaynhap) = 2018 AND MONTH(Nhap.ngaynhap) = 8
GROUP BY Nhanvien.tennv
HAVING SUM(Nhap.soluongN * Nhap.dongiaN) > 100000;
go
go
select * from Lab_3_cau_7
go

go
create view Lab_3_cau_8 as
SELECT Sanpham.tensp
FROM Sanpham
LEFT JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE Xuat.masp IS NULL;
go
go
select * from Lab_3_cau_8
go


go
create view Lab_3_cau_9 as
SELECT sp.masp, sp.tensp
FROM Sanpham sp
JOIN Nhap n ON sp.masp = n.masp
JOIN Xuat x ON n.masp = x.masp AND YEAR(n.ngaynhap) = 2018 AND YEAR(x.ngayxuat) = 2018
go
go
select * from Lab_3_cau_9
go

go
 create view Lab_3_cau_10 as
SELECT DISTINCT n.manv, nv.tennv
FROM Nhap n
JOIN Xuat x ON n.manv = x.manv AND n.ngaynhap = x.ngayxuat
JOIN Nhanvien nv ON n.manv = nv.manv
go
go
select * from Lab_3_cau_10 
go

go 
create view Lab_3_cau_11 as
SELECT nv.manv, nv.tennv
FROM Nhanvien nv
WHERE nv.manv NOT IN (
    SELECT DISTINCT manv FROM Nhap
    UNION
    SELECT DISTINCT manv FROM Xuat
	)
go
Select * from Lab_3_cau_11
go