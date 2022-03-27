USE quanlyvattu12;

INSERT INTO material (id, code, name, unit, price) VALUES
(1,'M1','Cat', 'm3',20),
(2,'M2','Da', 'm3',15),
(3,'M3','Dinh', 'kg',10),
(4,'M4','Bot mau', 'kg',20),
(5,'M5','Banh xe', 'cai',200);

INSERT INTO inventory (inventoryId, material_id, quantity, totalImport, totalExport) VALUES
(1,1,20,200,60),
(2,3,50,40,10),
(3,2,14,200,70),
(4,5,80,200,100),
(5,4,100,200,60);

INSERT INTO supplier (id, code, name, address, phone) VALUES
(1,'S1','Tran Duy Tung', 'Ha Noi','0123456789'),
(2,'S2','Tran Xuan Chien', 'Thai Binh','0987654321'),
(3,'S3','Cao Yen Phi', 'Ha Noi','011122335588');

INSERT INTO orders (id, code, date, supplierId) VALUES
(1,'OD1','2022-03-24',2),
(2,'OD2','2022-03-13',1),
(3,'OD3','2022-03-03',3);

INSERT INTO importbill (id, code, importDate, ordersID) VALUES
(1,'I1','2022-02-02',1),
(2,'I2','2022-02-02',2),
(3,'I3','2022-02-02',3);

INSERT INTO exportbill (id, code, exportDate, customerName) VALUES
(1,'E1','2022-04-02','Hoang Van Nam'),
(2,'E2','2022-04-02','Hoang Van Binh'),
(3,'E3','2022-04-02','Nguyen Thi Linh');

INSERT INTO odersdetail (id, ordersId, materialId, quantity) VALUES
(1,2,4,5),
(2,2,1,5),
(3,1,2,5),
(4,2,2,5),
(5,3,4,5),
(6,2,4,5);

INSERT INTO exportbilldetail (id, exportBill_id, materialId, quantity, price, note) VALUES
(1,1,5,10,200,NULL),
(2,3,4,10,20,NULL),
(3,1,5,10,200,NULL),
(4,1,2,10,15,NULL),
(5,2,3,10,10,NULL),
(6,1,1,10,20,NULL);

INSERT INTO importbilldetail (id, importBill_id, materialId, quantity, price, note) VALUES
(1,1,3,5,10,NULL),
(2,1,2,4,10,NULL),
(3,3,1,4,10,NULL),
(4,2,3,4,10,NULL),
(5,3,4,1,10,NULL),
(6,1,5,2,10,NULL);