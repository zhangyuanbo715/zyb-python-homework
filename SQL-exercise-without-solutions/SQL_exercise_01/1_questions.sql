-- LINK: The_computer_store
-- 1.1 Select the names of all the products in the store.

SELECT name FROM products;

-- 1.2 Select the names and the prices of all the products in the store.

SELECT name,price FROM products; 

-- 1.3 Select the name of the products with a price less than or equal to $200.

SELECT name,price FROM products WHERE price<=200 ; 

-- 1.4 Select all the products with a price between $60 and $120.

SELECT name,price FROM products WHERE price BETWEEN 60 AND  120 ; 

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).

SELECT name,price FROM products WHERE price%100=0; 

-- 1.6 Compute the average price of all the products.

SELECT avg(price) FROM products; 

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.

SELECT avg(price) FROM products INNER JOIN manufacturers USING(code) WHERE code=2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.

SELECT count(price) FROM products WHERE price >= 180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).

SELECT name,price FROM products WHERE price >= 180 ORDER BY price DESC,name;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.

SELECT * FROM products LEFT JOIN manufacturers USING(code);

-- 1.11 Select the product name, price, and manufacturer name of all the products.

SELECT products.name products_name,price,manufacturers.name manufacturer_name FROM products LEFT JOIN manufacturers USING(code);

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.

SELECT code,avg(price) FROM products INNER JOIN manufacturers USING(code) GROUP BY code;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.

SELECT m.name,avg(price) FROM products INNER JOIN manufacturers m USING(code) GROUP BY m.name;

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.

SELECT m.name,avg(price) FROM products INNER JOIN manufacturers m USING(code) GROUP BY m.name HAVING avg(price)>=150;

-- 1.15 Select the name and price of the cheapest product.

SELECT name,price FROM products ORDER BY price LIMIT 1;

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.

SELECT m.name,p.name,max(price) FROM products p INNER JOIN manufacturers m USING(code) GROUP BY m.name,p.name;

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(11,'Loudspeakers',70,2); 

-- 1.18 Update the name of product 8 to "Laser Printer".

UPDATE products SET name = 'Laser Printer' WHERE code=8;

-- 1.19 Apply a 10% discount to all products.

SELECT name,price*0.9 price_discount FROM products;

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.

SELECT name,price*0.9 price_discount FROM products WHERE price >=120;





