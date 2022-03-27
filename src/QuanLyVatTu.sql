CREATE DATABASE QuanLyVatTu12;
USE QuanLyVatTu12;

CREATE TABLE Material(
    id INT NOT NULL PRIMARY KEY ,
    code VARCHAR(20) NOT NULL ,
    name VARCHAR(50) NOT NULL ,
    unit VARCHAR(20),
    price DOUBLE
);
CREATE TABLE Inventory(
    inventoryId INT NOT NULL PRIMARY KEY ,
    material_id INT NOT NULL ,
    quantity INT,
    totalImport INT,
    totalExport INT,
    FOREIGN KEY (material_id) REFERENCES Material(id)
);
CREATE TABLE Supplier(
    id INT NOT NULL PRIMARY KEY ,
    code VARCHAR(20),
    name VARCHAR(50) NOT NULL ,
    address VARCHAR(30),
    phone VARCHAR(20)
);
CREATE TABLE Orders(
    id INT NOT NULL PRIMARY KEY ,
    code VARCHAR(20),
    date DATETIME,
    supplierId INT NOT NULL,
    FOREIGN KEY (supplierId) REFERENCES Supplier(id)
);
CREATE TABLE ImportBill(
    id INT NOT NULL PRIMARY KEY ,
    code VARCHAR(20),
    importDate DATE,
    ordersID INT NOT NULL ,
    FOREIGN KEY (ordersID) REFERENCES Orders(id)
);
CREATE TABLE ExportBill(
    id INT NOT NULL PRIMARY KEY ,
    code VARCHAR(20),
    exportDate DATE,
    customerName VARCHAR(50)
);
CREATE TABLE OdersDetail(
    id INT NOT NULL PRIMARY KEY ,
    ordersId INT NOT NULL ,
    materialId INT NOT NULL ,
    quantity INT,
    FOREIGN KEY (ordersId) REFERENCES Orders(id),
    FOREIGN KEY (materialId) REFERENCES Material(Id)
);
CREATE TABLE ImportBillDetail(
    id INT NOT NULL PRIMARY KEY ,
    importBill_id INT,
    materialId INT,
    quantity INT,
    price DOUBLE,
    note VARCHAR(255),
    FOREIGN KEY (importBill_id) REFERENCES ImportBill(id),
    FOREIGN KEY (materialId) REFERENCES Material(id)
);
CREATE TABLE ExportBillDetail(
    id INT NOT NULL PRIMARY KEY ,
    exportBill_id INT,
    materialId INT,
    quantity INT,
    price DOUBLE,
    note VARCHAR(255),
    FOREIGN KEY (exportBill_id) REFERENCES ExportBill(id),
    FOREIGN KEY (materialId) REFERENCES Material(id)
);
