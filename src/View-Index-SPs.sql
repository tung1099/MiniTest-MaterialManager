USE quanlyvattu12;
# Câu 1. Tạo view có tên vw_CTPNHAP bao gồm các thông tin sau:
# số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
CREATE VIEW ImportBillDetail_View AS
    SELECT id,materialId,quantity,price,price*quantity AS 'Thanh tien' FROM importbilldetail;
SELECT * FROM ImportBillDetail_View;

# Câu 2. Tạo view có tên vw_CTPNHAP_VT bao gồm các thông tin sau:
# số phiếu nhập hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
CREATE VIEW ImportBillDetail_Material AS
    SELECT i.id,
           m.id AS 'Material ID',
           m.name,
           i.quantity,
           i.price,
           i.price*i.quantity AS 'Thanh tien'
    FROM importbilldetail i JOIN material m on m.id = i.materialId;
SELECT * FROM ImportBillDetail_Material;

# Câu 3. Tạo view có tên vw_CTPNHAP_VT_PN bao gồm các thông tin sau:
# số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng, mã vật tư, tên vật tư, số lượng nhập,
# đơn giá nhập, thành tiền nhập.
CREATE VIEW View_IBD_Material_TB AS
    SELECT i.id,
           i2.importDate,
           m.id AS 'Material ID',
           m.name,
           i.quantity,
           i.price,
           i.quantity*i.price AS 'Thanh tien'
    FROM importbilldetail i
        JOIN material m on m.id = i.materialId
        JOIN importbill i2 on i2.id = i.importBill_id;
SELECT * FROM View_IBD_Material_TB;

# Câu 4. Tạo view có tên vw_CTPNHAP_VT_PN_DH bao gồm các thông tin sau:
# số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng, mã nhà cung cấp, mã vật tư,
# tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
CREATE VIEW View_IBD_Material_IB_Orders AS
    SELECT i.id,
           i2.importDate,
           o2.quantity AS 'So don dat hang',
           m.id AS 'Material ID',
           m.code AS 'Material code',
           m.name AS 'Material name',
           i.quantity 'So luong nhap',
           i.price,
           i.price * i.quantity 'Thanh tien'
    FROM importbilldetail i
        JOIN importbill i2 on i2.id = i.importBill_id
        JOIN material m on m.id = i.materialId
        JOIN importbill i3 on i3.id = i.importBill_id
        JOIN orders o on o.id = i2.ordersID
        JOIN odersdetail o2 on m.id = o2.materialId;
SELECT * FROM View_IBD_Material_IB_Orders;

# Câu 5. Tạo view có tên vw_CTPNHAP_loc  bao gồm các thông tin sau:
# số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
# Và chỉ liệt kê các chi tiết nhập có số lượng nhập > 5.
CREATE VIEW View_IBD_loc AS
    SELECT id, materialId, quantity, price, price*quantity AS 'Thanh tien'
    FROM importbilldetail WHERE quantity > 5;
SELECT * FROM View_IBD_loc;

# Câu 6. Tạo view có tên vw_CTPNHAP_VT_loc bao gồm các thông tin sau:
# số phiếu nhập hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
# Và chỉ liệt kê các chi tiết nhập vật tư có đơn vị tính là kg.
CREATE VIEW View_IBD_Material_loc AS
    SELECT i.id, i.materialId, m.name, i.quantity, i.price, i.quantity*i.price AS 'Thanh tien'
    FROM importbilldetail i
        JOIN material m on m.id = i.materialId WHERE m.unit = 'kg';
SELECT * FROM View_IBD_Material_loc;

# Câu 7. Tạo view có tên vw_CTPXUAT bao gồm các thông tin sau:
# số phiếu xuất hàng, mã vật tư, số lượng xuất, đơn giá xuất, thành tiền xuất.
CREATE VIEW View_EBD AS
    SELECT id, materialId, quantity, price, price*quantity AS 'Thanh tien'
    FROM exportbilldetail;
SELECT * FROM View_EBD;

# Câu 9. Tạo view có tên vw_CTPXUAT_VT_PX bao gồm các thông tin sau:
# số phiếu xuất hàng, tên khách hàng, mã vật tư, tên vật tư, số lượng xuất, đơn giá xuất.
CREATE VIEW EBD_Material_EB AS
    SELECT e.id,
           e2.customerName,
           e.materialId,
           m.name,
           e.quantity,
           e.price
     FROM exportbilldetail e
         JOIN exportbill e2 on e2.id = e.exportBill_id
         JOIN material m on m.id = e.materialId;
SELECT * FROM EBD_Material_EB;

# Câu 1. Tạo Stored procedure (SP) cho biết tổng số lượng cuối của vật tư với mã vật tư là tham số vào.
DELIMITER //
CREATE PROCEDURE sp_getQuantity (IN materialCode varchar(20))
BEGIN
    SELECT (i.quantity + i.totalImport - i.totalExport) AS 'So luong cuoi'
    FROM inventory i JOIN material m on m.id = i.material_id
    WHERE m.id = id;
end //
DELIMITER ;

CALL sp_getQuantity('M1');

# Câu 2. Tạo SP cho biết tổng tiền xuất của vật tư với mã vật tư là tham số vào.
DELIMITER //
CREATE PROCEDURE sp_getTotalExport (IN materialCode varchar(20))
BEGIN
   SELECT SUM(e.price * e.quantity) AS 'Tong tien xuat'
   FROM exportbilldetail e JOIN material m on m.id = e.materialId
    GROUP BY materialId;
end //
DELIMITER ;
CALL sp_getTotalExport('M2')


