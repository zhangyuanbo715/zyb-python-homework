-- The Warehouse
-- lINK: The_warehouse
--3.1 Select all warehouses.

SELECT * FROM warehouses;

--3.2 Select all boxes with a value larger than $150.

SELECT * FROM boxes WHERE value>150;

--3.3 Select all distinct contents in all the boxes.

SELECT DISTINCT contents FROM boxes;

--3.4 Select the average value of all the boxes.

SELECT avg(value) FROM boxes;

--3.5 Select the warehouse code and the average value of the boxes in each warehouse.

SELECT warehouse,avg(value) FROM boxes GROUP BY warehouse;

--3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.

SELECT warehouse,avg(value) FROM boxes GROUP BY warehouse HAVING avg(value)>150;

--3.7 Select the code of each box, along with the name of the city the box is located in.

SELECT b.code,location FROM boxes b INNER JOIN warehouses w ON w.code=warehouse;

--3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
    -- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).

SELECT warehouse,count(code) FROM boxes GROUP BY warehouse ORDER BY warehouse;

--3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).

SELECT w.code FROM warehouses w INNER JOIN boxes b ON w.code=b.warehouse  GROUP BY w.code,capacity HAVING capacity<count(value);

--3.10 Select the codes of all the boxes located in Chicago.

SELECT b.code FROM boxes b INNER JOIN warehouses w ON b.warehouse=w.code WHERE location='Chicago';

--3.11 Create a new warehouse in New York with a capacity for 3 boxes.

INSERT INTO warehouses(code,location,capacity) VALUES(6,'New York',3); 

--3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.

INSERT INTO boxes(code,contents,value,warehouse) VALUES('H5RT','Papers',200,2);

--3.13 Reduce the value of all boxes by 15%.

UPDATE boxes SET value=value*0.85;

--3.14 Remove all boxes with a value lower than $100.

DELETE FROM boxes WHERE value<180;

-- 3.15 Remove all boxes from saturated warehouses.

DELETE FROM boxes WHERE warehouse=(SELECT w.code FROM warehouses w INNER JOIN boxes b ON w.code=b.warehouse  GROUP BY w.code,capacity HAVING capacity<count(value));

-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

CREATE INDEX warehouse_index ON boxes(warehouse);

-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

SELECT * FROM pg_indexes WHERE tablename='boxes';

-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

Drop Index warehouse_index Cascade;



-- 创建索引可以添加where条件
-- Create Unique Index idx_tb_user_UNQ On tb_user(login_name,group_id) WHERE delete_flag = '0';
-- 上面的sql表示delete_flag=0的数据才有唯一索引约束。