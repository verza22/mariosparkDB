-- Crear la base de datos "MiLocal"
CREATE DATABASE MiLocal;
GO

-- Seleccionar la base de datos "MiLocal"
USE MiLocal;
GO

-- Crear una tabla llamada "USER_TYPES" con 'KY_USER_TYPE_ID' autoincrementable
CREATE TABLE USER_TYPES (
    KY_USER_TYPE_ID INT PRIMARY KEY IDENTITY(1,1),
    TX_USER_TYPE_NAME NVARCHAR(50)
);
GO

-- Crear una tabla llamada "USERS" con 'KY_USER_ID' autoincrementable
CREATE TABLE USERS (
    KY_USER_ID INT PRIMARY KEY IDENTITY(1,1),
    TX_USERNAME NVARCHAR(50),
    TX_NAME NVARCHAR(50),
    TX_PASSWORD NVARCHAR(255),
    CD_USER_TYPE_ID INT NOT NULL,
    FOREIGN KEY (CD_USER_TYPE_ID) REFERENCES USER_TYPES(KY_USER_TYPE_ID)
);
GO

-- Insertar datos en la tabla "USER_TYPES" sin especificar el 'KY_USER_TYPE_ID'
INSERT INTO USER_TYPES (TX_USER_TYPE_NAME)
VALUES 
('ADMIN'),
('CASHIER'),
('WAITER'),
('CHEF');
GO

-- Insertar datos en la tabla "USERS" sin especificar el 'KY_USER_ID' y sin el campo 'CD_USER_TYPE_ID'
INSERT INTO USERS (TX_USERNAME, TX_NAME, TX_PASSWORD, CD_USER_TYPE_ID)
VALUES 
('admin', 'administrador', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 1),
('caja1', 'Jamil Caja', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 2),
('mesero1', 'Mesero 1', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 3),
('mesero2', 'Mesero 2', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 3),
('chef1', 'Chef Tito', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 4);
GO

-- Crear una tabla llamada "STORES"
CREATE TABLE STORES (
    KY_STORE_ID INT PRIMARY KEY IDENTITY(1,1),
    TX_STORE_NAME NVARCHAR(100),
    TX_STORE_ADDRESS NVARCHAR(255),
	CD_OWNER_ID INT NOT NULL
);
GO

-- Crear una tabla llamada "CATEGORIES" con 'KY_CATEGORY_ID' autoincrementable y convención de nombres
CREATE TABLE CATEGORIES (
    KY_CATEGORY_ID INT PRIMARY KEY IDENTITY(1,1),
    TX_NAME NVARCHAR(50),
    TX_IMAGE NVARCHAR(255),
    CD_STORE_ID INT NOT NULL,
    FOREIGN KEY (CD_STORE_ID) REFERENCES STORES(KY_STORE_ID)
);
GO

-- Insertar datos en la tabla "STORES"
INSERT INTO STORES (TX_STORE_NAME, TX_STORE_ADDRESS, CD_OWNER_ID)
VALUES 
('Marios Park', 'Via Rioverde', 1);
GO

CREATE TABLE USER_STORES (
    CD_USER_ID INT,
    CD_STORE_ID INT,
    FOREIGN KEY (CD_USER_ID) REFERENCES USERS(KY_USER_ID),
    FOREIGN KEY (CD_STORE_ID) REFERENCES STORES(KY_STORE_ID)
);

GO

INSERT INTO USER_STORES (CD_USER_ID, CD_STORE_ID)
VALUES 
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 1);

GO


INSERT INTO CATEGORIES (TX_NAME, TX_IMAGE, CD_STORE_ID)
VALUES 
('Pizza 1', 'https://via.placeholder.com/50', 1),
('Sushi', 'https://via.placeholder.com/50', 1),
('Indian', 'https://via.placeholder.com/50', 1),
('Burgers', 'https://via.placeholder.com/50', 1),
('Pasta', 'https://via.placeholder.com/50', 1),
('Asian', 'https://via.placeholder.com/50', 1),
('Seafood', 'https://via.placeholder.com/50', 1),
('Drinks', 'https://via.placeholder.com/50', 1),
('Desserts', 'https://via.placeholder.com/50', 1),
('Wraps', 'https://via.placeholder.com/50', 1);
GO

-- Crear una tabla llamada "PRODUCTS" con 'KY_PRODUCT_ID' autoincrementable
CREATE TABLE PRODUCTS (
    KY_PRODUCT_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    TX_NAME NVARCHAR(100),
    TX_DESCRIPTION NVARCHAR(MAX),
    DB_PRICE DECIMAL(10, 2) NOT NULL,
    CD_CATEGORY_ID INT NOT NULL,
    TX_IMAGE NVARCHAR(255),
    CD_STORE_ID INT NOT NULL,
    FOREIGN KEY (CD_CATEGORY_ID) REFERENCES CATEGORIES(KY_CATEGORY_ID),
	FOREIGN KEY (CD_STORE_ID) REFERENCES STORES(KY_STORE_ID)
);
GO

-- Insertar datos en la tabla "PRODUCTS" sin especificar el 'KY_PRODUCT_ID' y 'CD_CATEGORY_ID'
INSERT INTO PRODUCTS (TX_NAME, TX_DESCRIPTION, DB_PRICE, CD_CATEGORY_ID, TX_IMAGE, CD_STORE_ID)
VALUES 
('Pizza Margherita 2', '', 10, 1, 'https://picsum.photos/200/300?food=1', 1),
('Sushi Combo', '', 20, 2, 'https://picsum.photos/200/300?food=2', 1),
('Chicken Tikka Masala', '', 15, 3, 'https://picsum.photos/200/300?food=3', 1),
('Burger and Fries', '', 12, 4, 'https://picsum.photos/200/300?food=4', 1),
('Pasta Carbonara', '', 14, 5, 'https://picsum.photos/200/300?food=5', 1),
('Veggie Stir Fry', '', 8, 6, 'https://picsum.photos/200/300?food=6', 1),
('Shrimp Scampi', '', 14, 7, 'https://picsum.photos/200/300?food=7', 1),
('Margarita Cocktail', '', 7, 8, 'https://picsum.photos/200/300?food=8', 1),
('Chocolate Brownie', '', 5, 9, 'https://picsum.photos/200/300?food=9', 1),
('Caesar Wrap', '', 9, 10, 'https://picsum.photos/200/300?food=10', 1),
('Shrimp Scampi', '', 14, 7, 'https://picsum.photos/200/300?food=7', 1),
('Margarita Cocktail', '', 7, 8, 'https://picsum.photos/200/300?food=8', 1),
('Chocolate Brownie', '', 5, 9, 'https://picsum.photos/200/300?food=9', 1),
('Caesar Wrap', '', 9, 10, 'https://picsum.photos/200/300?food=10', 1),
('Ice Cream Sundae', '', 6, 9, 'https://picsum.photos/200/300?food=30', 1);
GO


-- Crear una tabla llamada "CUSTOMERS" con 'KY_CUSTOMER_ID' autoincrementable
CREATE TABLE CUSTOMERS (
    KY_CUSTOMER_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    TX_NAME NVARCHAR(100) NOT NULL,
    TX_DNI NVARCHAR(20),
    TX_EMAIL NVARCHAR(100),
    TX_PHONE NVARCHAR(20),
    TX_ADDRESS NVARCHAR(255),
    CD_STORE_ID INT NOT NULL,
	FOREIGN KEY (CD_STORE_ID) REFERENCES STORES(KY_STORE_ID)
);
GO

-- Insertar datos en la tabla "CUSTOMERS" sin especificar el 'KY_CUSTOMER_ID'
INSERT INTO CUSTOMERS (TX_NAME, TX_DNI, TX_EMAIL, TX_PHONE, TX_ADDRESS, CD_STORE_ID)
VALUES 
('Customer 1', '0123456789', 'test@example.com', '0994512345', 'NA', 1),
('Customer 2', '0123456789', 'test@example.com', '0994512345', 'NA', 1),
('Customer 3', '0123456789', 'test@example.com', '0994512345', 'NA', 1),
('Customer 4', '0123456789', 'test@example.com', '0994512345', 'NA', 1),
('Customer 5', '0123456789', 'test@example.com', '0994512345', 'NA', 1),
('Customer 6', '0123456789', 'test@example.com', '0994512345', 'NA', 1),
('Customer 7', '0123456789', 'test@example.com', '0994512345', 'NA', 1),
('Customer 8', '0123456789', 'test@example.com', '0994512345', 'NA', 1),
('Customer 9', '0123456789', 'test@example.com', '0994512345', 'NA', 1),
('Customer 10', '0123456789', 'test@example.com', '0994512345', 'NA', 1);

-- Crear una tabla llamada "ORDER_STATUS" con 'KY_ORDER_STATUS_ID' autoincrementable
CREATE TABLE ORDER_STATUS (
    KY_ORDER_STATUS_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    TX_STATUS_NAME NVARCHAR(50) NOT NULL
);
GO

-- Insertar datos en la tabla "ORDER_STATUS"
INSERT INTO ORDER_STATUS (TX_STATUS_NAME)
VALUES 
('PENDIENTE'),
('ENTREGADO'),
('CANCELADO');
GO

-- Crear una tabla llamada "ORDERS" con las columnas especificadas
CREATE TABLE ORDERS (
    KY_ORDER_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    CD_CASHIER_ID INT NOT NULL,
    CD_TABLE_NUMBER INT NOT NULL,
    CD_WAITER_ID INT NOT NULL,
    CD_CHEF_ID INT NOT NULL,
    CD_TOTAL DECIMAL(10, 2) NOT NULL,
    DT_DATE DATETIME NOT NULL,
    TX_PAYMENT_METHOD NVARCHAR(50),
    CD_ORDER_STATUS INT NOT NULL,
    CD_STORE_ID INT NOT NULL,
    JS_CUSTOMER NVARCHAR(MAX),
    JS_PRODUCTS NVARCHAR(MAX),
    FOREIGN KEY (CD_ORDER_STATUS) REFERENCES ORDER_STATUS(KY_ORDER_STATUS_ID),
	FOREIGN KEY (CD_STORE_ID) REFERENCES STORES(KY_STORE_ID)
);
GO

-- Insertar datos en la tabla "ORDERS"
INSERT INTO ORDERS (CD_CASHIER_ID, CD_TABLE_NUMBER, CD_WAITER_ID, CD_CHEF_ID, CD_TOTAL, DT_DATE, TX_PAYMENT_METHOD, CD_ORDER_STATUS, CD_STORE_ID, JS_CUSTOMER, JS_PRODUCTS)
VALUES 
(2, 1, 3, 5, 20, '2023-01-01 00:00:00', 'Efectivo', 1, 1, 
'{
    "id": 1,
    "dni": "0123456789",
    "name": "Customer 1",
    "email": "test@example.com",
    "phone": "0994512345",
    "address": "NA"
}',
'[
    {
        "id": 1,
        "name": "Pizza Margherita 2",
        "description": "",
        "price": 10,
        "quantity": 2
    }
]');

-- Crear una tabla llamada "HOTEL_ORDER_TYPE" con 'KY_HOTEL_ORDER_TYPE_ID' autoincrementable y clave foránea CD_STORE_ID
CREATE TABLE HOTEL_ORDER_TYPE (
    KY_HOTEL_ORDER_TYPE_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    TX_ORDER_TYPE_NAME NVARCHAR(50) NOT NULL
);
GO

-- Insertar datos en la tabla "HOTEL_ORDER_TYPE"
INSERT INTO HOTEL_ORDER_TYPE (TX_ORDER_TYPE_NAME)
VALUES 
('RESERVADO'),
('HOSPEDADO'),
('TERMINADO');
GO

-- Crear una tabla llamada "HOTEL_ROOM_TYPES" con 'KY_ROOM_TYPE_ID' autoincrementable y clave foránea CD_STORE_ID
CREATE TABLE HOTEL_ROOM_TYPES (
    KY_ROOM_TYPE_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    TX_TYPE_NAME NVARCHAR(50) NOT NULL,
    CD_STORE_ID INT NOT NULL,
    FOREIGN KEY (CD_STORE_ID) REFERENCES STORES(KY_STORE_ID)
);
GO

-- Insertar datos en la tabla "HOTEL_ROOM_TYPES"
INSERT INTO HOTEL_ROOM_TYPES (TX_TYPE_NAME, CD_STORE_ID)
VALUES 
('Playa', 1),
('Cemento', 1),
('Cemento B', 1),
('Cabaña', 1);
GO

-- Crear una tabla llamada "HOTEL_ROOMS" con las columnas especificadas y clave foránea CD_STORE_ID
CREATE TABLE HOTEL_ROOMS (
    KY_ROOM_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    TX_ROOM_NAME NVARCHAR(50) NOT NULL,
    INT_CAPACITY INT NOT NULL,
    TX_ROOM_TYPE NVARCHAR(50) NOT NULL,
    CD_STORE_ID INT NOT NULL,
    FOREIGN KEY (CD_STORE_ID) REFERENCES STORES(KY_STORE_ID)
);
GO

-- Insertar datos en la tabla "HOTEL_ROOMS"
INSERT INTO HOTEL_ROOMS (TX_ROOM_NAME, INT_CAPACITY, TX_ROOM_TYPE, CD_STORE_ID)
VALUES 
('1', 4, 'Cemento', 1),
('2', 5, 'Playa', 1),
('3', 6, 'Cemento B', 1);
GO


-- Crear una tabla llamada "HOTEL_ORDERS" con las columnas especificadas y clave foránea CD_STORE_ID
CREATE TABLE HOTEL_ORDERS (
    KY_ORDER_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    CD_USER_ID INT NOT NULL,
    DEC_TOTAL DECIMAL(10, 2) NOT NULL,
    DT_DATE_IN DATETIME NOT NULL,
    DT_DATE_OUT DATETIME NOT NULL,
    TX_PAYMENT_METHOD NVARCHAR(50),
    INT_PEOPLE INT NOT NULL,
    JS_ROOM NVARCHAR(MAX),
    JS_CUSTOMER NVARCHAR(MAX),
    CD_STORE_ID INT NOT NULL,
    FOREIGN KEY (CD_STORE_ID) REFERENCES STORES(KY_STORE_ID)
);
GO

-- Insertar datos en la tabla "HOTEL_ORDERS"
INSERT INTO HOTEL_ORDERS (CD_USER_ID, DEC_TOTAL, DT_DATE_IN, DT_DATE_OUT, TX_PAYMENT_METHOD, INT_PEOPLE, JS_ROOM, JS_CUSTOMER, CD_STORE_ID)
VALUES 
(2, 20, '2023-01-01 00:00:00', '2023-01-03 00:00:00', 'Efectivo', 6, 
'{
    "id": 1,
    "name": "1",
    "type": "Cemento",
    "capacity": 4
}', 
'{
    "id": 1,
    "dni": "0123456789",
    "name": "Customer 1",
    "email": "test@example.com",
    "phone": "0994512345",
    "address": "NA"
}', 
1);


--SP

CREATE OR ALTER PROCEDURE GetStoresByOwnerId
    @owner_id INT
AS
BEGIN
    SELECT *
    FROM STORES
    WHERE CD_OWNER_ID = @owner_id;
END;

GO

CREATE OR ALTER PROCEDURE Login
    @UserName NVARCHAR(50),
    @Password NVARCHAR(255)
AS
BEGIN

    SELECT 
	[KY_USER_ID]
    ,[TX_USERNAME]
    ,[TX_NAME]
    ,[CD_USER_TYPE_ID]
	,ISNULL((SELECT TOP 1 [KY_STORE_ID] FROM [STORES] WHERE [CD_OWNER_ID] = USERS.[KY_USER_ID]),0) as DEFAULT_STORE_ID
	FROM USERS 
	WHERE TX_USERNAME = @UserName 
	AND TX_PASSWORD = @Password
END;

GO

CREATE OR ALTER PROCEDURE GetCategoriesByStoreId
    @store_id INT
AS
BEGIN
    SELECT 
        KY_CATEGORY_ID,
        TX_NAME,
        TX_IMAGE,
        CD_STORE_ID
    FROM 
        CATEGORIES
    WHERE 
        CD_STORE_ID = @store_id;
END

GO

CREATE OR ALTER PROCEDURE GetProducts
    @store_id INT,
    @category_id INT
AS
BEGIN

    IF @category_id > 0
    BEGIN
        SELECT KY_PRODUCT_ID,
               TX_NAME,
               TX_DESCRIPTION,
               DB_PRICE,
               CD_CATEGORY_ID,
               TX_IMAGE,
               CD_STORE_ID
        FROM PRODUCTS
        WHERE CD_STORE_ID = @store_id
          AND CD_CATEGORY_ID = @category_id;
    END
    ELSE
    BEGIN
        
        SELECT KY_PRODUCT_ID,
               TX_NAME,
               TX_DESCRIPTION,
               DB_PRICE,
               CD_CATEGORY_ID,
               TX_IMAGE,
               CD_STORE_ID
        FROM PRODUCTS
        WHERE CD_STORE_ID = @store_id;
    END
END;

GO

CREATE OR ALTER PROCEDURE GetCustomers
    @store_id INT
AS
BEGIN
    SELECT 
        KY_CUSTOMER_ID,
        TX_NAME,
        TX_DNI,
        TX_EMAIL,
        TX_PHONE,
        TX_ADDRESS,
        CD_STORE_ID
    FROM 
        CUSTOMERS
    WHERE 
        CD_STORE_ID = @store_id;
END;
GO

CREATE OR ALTER PROCEDURE GetUsers
    @store_id INT
AS
BEGIN

    SELECT
        KY_USER_ID,
        TX_USERNAME,
        TX_NAME,
        CD_USER_TYPE_ID
    FROM
        USERS
    WHERE
        KY_USER_ID IN (SELECT CD_USER_ID FROM USER_STORES WHERE CD_STORE_ID = @store_id);
END;

GO

CREATE OR ALTER PROCEDURE GetOrders
    @store_id INT
AS
BEGIN
    SELECT 
        KY_ORDER_ID,
        CD_CASHIER_ID,
        CD_TABLE_NUMBER,
        CD_WAITER_ID,
        CD_CHEF_ID,
        CD_TOTAL,
        DT_DATE,
        TX_PAYMENT_METHOD,
        CD_ORDER_STATUS,
        CD_STORE_ID,
        JS_CUSTOMER,
        JS_PRODUCTS
    FROM 
        ORDERS
    WHERE 
        CD_STORE_ID = @store_id;
END;

GO

CREATE OR ALTER PROCEDURE GetHotelRooms
    @store_id INT
AS
BEGIN
    SELECT 
        KY_ROOM_ID,
        TX_ROOM_NAME,
        INT_CAPACITY,
        TX_ROOM_TYPE,
        CD_STORE_ID
    FROM 
        HOTEL_ROOMS
    WHERE 
        CD_STORE_ID = @store_id;
END;

GO

CREATE OR ALTER PROCEDURE GetHotelOrders
    @store_id INT
AS
BEGIN
    SELECT 
        KY_ORDER_ID,
        CD_USER_ID,
        DEC_TOTAL,
        DT_DATE_IN,
        DT_DATE_OUT,
        TX_PAYMENT_METHOD,
        INT_PEOPLE,
        JS_ROOM,
        JS_CUSTOMER,
        CD_STORE_ID
    FROM 
        HOTEL_ORDERS
    WHERE 
        CD_STORE_ID = @store_id;
END;

GO

CREATE OR ALTER PROCEDURE GetUserTypes
AS
BEGIN
    SELECT KY_USER_TYPE_ID, TX_USER_TYPE_NAME
    FROM USER_TYPES;
END;

GO

CREATE OR ALTER PROCEDURE GetOrderStatus
AS
BEGIN
    SELECT KY_ORDER_STATUS_ID, TX_STATUS_NAME
    FROM ORDER_STATUS;
END;
GO

CREATE OR ALTER PROCEDURE GetHotelOrderTypes
AS
BEGIN
    SELECT KY_HOTEL_ORDER_TYPE_ID, TX_ORDER_TYPE_NAME
    FROM HOTEL_ORDER_TYPE;
END;
GO

CREATE OR ALTER PROCEDURE GetHotelRoomTypes
    @store_id INT
AS
BEGIN
    SELECT KY_ROOM_TYPE_ID, TX_TYPE_NAME, CD_STORE_ID
    FROM HOTEL_ROOM_TYPES
    WHERE CD_STORE_ID = @store_id;
END
GO