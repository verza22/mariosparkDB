DECLARE @startDate DATE = '2024-05-01';
DECLARE @endDate DATE = '2024-07-14';
DECLARE @numRecords INT = 10;

-- Variables para el bucle
DECLARE @i INT = 0;
DECLARE @date DATETIME;
DECLARE @cd_cashier_id INT;
DECLARE @cd_table_number INT;
DECLARE @cd_waiter_id INT;
DECLARE @cd_chef_id INT;
DECLARE @cd_total DECIMAL(10, 2);
DECLARE @tx_payment_method NVARCHAR(50);
DECLARE @cd_order_status INT;
DECLARE @cd_store_id INT;
DECLARE @js_customer NVARCHAR(MAX);
DECLARE @js_products NVARCHAR(MAX);

WHILE @i < @numRecords
BEGIN
    -- Generar fecha aleatoria entre @startDate y @endDate
    SET @date = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % (DATEDIFF(DAY, @startDate, @endDate) + 1), @startDate);

    -- Generar datos aleatorios
    SET @cd_cashier_id = 2;
    SET @cd_table_number = ABS(CHECKSUM(NEWID())) % 10 + 1; -- Números de mesa entre 1 y 10
    SET @cd_waiter_id = CASE ABS(CHECKSUM(NEWID())) % 2
                             WHEN 0 THEN 3
                             ELSE 4
                             END; -- IDs de mesero entre 1 y 10
    SET @cd_chef_id = 5; -- IDs de chef entre 1 y 10
    SET @cd_total = CAST(ABS(CHECKSUM(NEWID())) % 100 + 10 AS DECIMAL(10, 2)); -- Total entre 10 y 109
    SET @tx_payment_method = CASE ABS(CHECKSUM(NEWID())) % 3
                             WHEN 0 THEN 'Efectivo'
                             WHEN 1 THEN 'Tarjeta de credito'
                             ELSE 'Tarjeta de debito'
                             END;
    SET @cd_order_status = 1;
    SET @cd_store_id = 1;
    SET @js_customer = N'{
        "id": ' + CAST(@i + 1 AS NVARCHAR) + N',
        "dni": "0123456789' + CAST(@i + 1 AS NVARCHAR) + N'",
        "name": "Customer ' + CAST(@i + 1 AS NVARCHAR) + N'",
        "email": "customer' + CAST(@i + 1 AS NVARCHAR) + N'@example.com",
        "phone": "099451234' + CAST(@i + 1 AS NVARCHAR) + N'",
        "address": "Address ' + CAST(@i + 1 AS NVARCHAR) + N'"
    }';
    SET @js_products = N'[
        {
            "id": ' + CAST(@i + 1 AS NVARCHAR) +',
            "name": "Product ' + CAST(@i + 1 AS NVARCHAR) + N'",
            "description": "",
            "price": ' + CAST(@cd_total / 2 AS NVARCHAR) + N',
            "quantity": 2
        }
    ]';

    -- Insertar registro
    INSERT INTO ORDERS (CD_CASHIER_ID, CD_TABLE_NUMBER, CD_WAITER_ID, CD_CHEF_ID, CD_TOTAL, DT_DATE, TX_PAYMENT_METHOD, CD_ORDER_STATUS, CD_STORE_ID, JS_CUSTOMER, JS_PRODUCTS)
    VALUES (@cd_cashier_id, @cd_table_number, @cd_waiter_id, @cd_chef_id, @cd_total, @date, @tx_payment_method, @cd_order_status, @cd_store_id, @js_customer, @js_products);

    -- Incrementar contador
    SET @i = @i + 1;
END;

GO

DECLARE @startDate DATE = '2024-05-01';
DECLARE @endDate DATE = '2024-07-14';
DECLARE @numRecords INT = 10;

-- Variables para el bucle
DECLARE @i INT = 0;
DECLARE @dateIn DATETIME;
DECLARE @dateOut DATETIME;
DECLARE @cd_user_id INT;
DECLARE @dec_total DECIMAL(10, 2);
DECLARE @tx_payment_method NVARCHAR(50);
DECLARE @int_people INT;
DECLARE @js_room NVARCHAR(MAX);
DECLARE @js_customer NVARCHAR(MAX);
DECLARE @cd_store_id INT;

WHILE @i < @numRecords
BEGIN
    -- Generar fecha de entrada aleatoria entre @startDate y @endDate
    SET @dateIn = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % (DATEDIFF(DAY, @startDate, @endDate) + 1), @startDate);

    -- Generar fecha de salida aleatoria después de la fecha de entrada
    SET @dateOut = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 7 + 1, @dateIn); -- Estancia de entre 1 y 7 días

    -- Generar datos aleatorios
    SET @cd_user_id = ABS(CHECKSUM(NEWID())) % 10 + 1; -- IDs entre 1 y 10
    SET @dec_total = CAST(ABS(CHECKSUM(NEWID())) % 1000 + 100 AS DECIMAL(10, 2)); -- Total entre 100 y 1099
    SET @tx_payment_method = CASE ABS(CHECKSUM(NEWID())) % 3
                             WHEN 0 THEN 'Efectivo'
                             WHEN 1 THEN 'Tarjeta de credito'
                             ELSE 'Tarjeta de debito'
                             END;
    SET @int_people = ABS(CHECKSUM(NEWID())) % 4 + 1; -- Número de personas entre 1 y 4
    SET @cd_store_id = 1;
    SET @js_room = N'{
        "id": ' + CAST(@i + 1 AS NVARCHAR) + N',
        "name": "Room ' + CAST(@i + 1 AS NVARCHAR) + N'",
        "type": ' + CAST((ABS(CHECKSUM(NEWID())) % 3 + 1) AS NVARCHAR) + N',
        "capacity": ' + CAST((ABS(CHECKSUM(NEWID())) % 4 + 1) AS NVARCHAR) + N'
    }';
    SET @js_customer = N'{
        "id": ' + CAST(@i + 1 AS NVARCHAR) + N',
        "dni": "0123456789' + CAST(@i + 1 AS NVARCHAR) + N'",
        "name": "Customer ' + CAST(@i + 1 AS NVARCHAR) + N'",
        "email": "customer' + CAST(@i + 1 AS NVARCHAR) + N'@example.com",
        "phone": "099451234' + CAST(@i + 1 AS NVARCHAR) + N'",
        "address": "Address ' + CAST(@i + 1 AS NVARCHAR) + N'"
    }';

    -- Insertar registro
    INSERT INTO HOTEL_ORDERS (CD_USER_ID, DEC_TOTAL, DT_DATE_IN, DT_DATE_OUT, TX_PAYMENT_METHOD, INT_PEOPLE, JS_ROOM, JS_CUSTOMER, CD_STORE_ID)
    VALUES (@cd_user_id, @dec_total, @dateIn, @dateOut, @tx_payment_method, @int_people, @js_room, @js_customer, @cd_store_id);

    -- Incrementar contador
    SET @i = @i + 1;
END;
GO
