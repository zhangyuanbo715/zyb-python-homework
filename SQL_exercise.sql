-- *************第一部分 查询***************

/*查询customer表中的名字dd*/
SELECT first_name FROM customer;

/*查询city表中的城市名称（过滤重复值）*/
SELECT DISTINCT city FROM city;

/*查询customer表中的名字和姓氏，按照名字升序排列*/
SELECT first_name,last_name FROM customer ORDER BY first_name;

/*查询customer表中的名字和姓氏，按照名字升序排列,当名字相同时，姓氏降序排列*/
SELECT first_name,last_name FROM customer ORDER BY first_name,last_name DESC;

/*连接customer表中的名字和姓氏，以空格隔开，并重命名为"full_name"*/
SELECT concat(first_name,' ',last_name) as full_name FROM customer;

-- *************第二部分 筛选***************
SELECT * FROM address LIMIT 5;
/*查询customer表中名字为Aaron的名字和姓氏*/
SELECT first_name,last_name FROM customer WHERE first_name LIKE 'Aaron';

/*查询customer表中没有去1号店的顾客的邮箱*/
SELECT email FROM customer WHERE store_id <> 1; -- 也可以用!=

/*查询支付租金的金额小于1美元或大于8美元的顾客编号，金额以及付款日期*/
SELECT customer_id,amount,payment_date FROM payment WHERE amount NOT BETWEEN 1 AND 8; -- 或者用and连接两个条件

/*查询电影的租赁时长不等于5并且电影时长少于100或者租赁时长等于5并且电影时长大于100的电影编号和名称*/
SELECT film_id,title FROM film WHERE (rental_duration<>5 AND length<100) OR (rental_duration=5 AND length>100);

/*查询customer表中名字为Alan或Alex的名字和姓氏和邮箱*/
SELECT first_name,last_name,email FROM customer WHERE first_name IN ('Alan','Alex');

/*查询payment表中付款日期在2007-02-20-2007-02-21之间的顾客编号*/
SELECT customer_id FROM payment WHERE payment_date BETWEEN '2007-02-20' AND '2007-02-21';

/*查询address表中以Man开头的街区名称*/
SELECT district FROM address WHERE district LIKE 'Man%';

/*查询customer表中名字含有"er"的名字和姓氏*/
SELECT first_name,last_name FROM customer WHERE first_name LIKE '%er%';

/*查询customer表中名字以任一字符开头，中间为"her"的名字和姓氏*/
SELECT first_name,last_name FROM customer WHERE first_name LIKE '_her%';

/*查询customer表中名字不以"Jen"开头的名字和姓氏*/
SELECT first_name,last_name FROM customer WHERE first_name NOT LIKE 'Jen%';

/*查询customer表中名字以"BAR"或者"Bar"或者“BaR"开头的名字和姓氏（ILIKE运算符不区分大小写的值）*/
SELECT first_name,last_name FROM customer WHERE first_name ILIKE 'BAR%';

/*查询address表中电话号码不为空的街区名称*/
SELECT district FROM address WHERE phone IS NOT NULL;

/*查询film表中按标题排序的前五部电影*/
SELECT * FROM film ORDER BY title LIMIT 5;

/*查询film表中从第3行之后（即第4行）开始的4行数据*/
SELECT * FROM film LIMIT 4 OFFSET 3;


-- *************第三部分 连接***************

/*查询客户ID 2的客户租赁数据（两表内连接）*/
SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a INNER JOIN payment b USING(customer_id) WHERE a.customer_id = 2;

/*查询客户ID 2的客户租赁数据（三表内连接）*/
SELECT a.customer_id,a.first_name customer_first_name,a.last_name customer_last_name,a.email,b.first_name staff_first_name,b.last_name staff_last_name,c.amount,c.payment_date FROM payment c INNER JOIN customer a ON c.customer_id = a.customer_id INNER JOIN staff b ON c.staff_id = b.staff_id WHERE a.customer_id = 2;

-- SELECT 要连接显示的属性 FROM 表 INNER JOIN table ON 两表相同的属性



/*查找具有相同长度的所有电影对（自连接）
自联接对于比较同一表中的一列行中的值很有用。
要形成自连接，请使用不同的别名指定同一个表两次，设置比较，并消除值等于自身的情况。*/
SELECT a.title,b.title FROM film a INNER JOIN film b USING(length) WHERE a.title <> b.title;


/*查询客户ID 2的客户租赁数据（完整外连接）*/
SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a FULL JOIN payment b USING(customer_id) WHERE a.customer_id = 2;


/*查询客户ID 2的客户租赁数据（完全外连接,,不包括a,b的交集部分）*/
SELECT a.customer_id, a.email, b.amount, b.payment_date FROM customer a FULL JOIN payment b USING(customer_id) WHERE a.customer_id = 2 AND (a.customer_id IS NULL OR b.customer_id IS NULL);


-- *************第四部分 分组***************

/*按顾客编号分组，计算总金额，并按总金额降序排列*/
SELECT customer_id,sum(amount) FROM payment GROUP BY customer_id ORDER BY sum(amount) DESC; 

/*按顾客编号分组,查询总金额超过200的顾客编号*/
SELECT customer_id,sum(amount) FROM payment GROUP BY customer_id HAVING sum(amount)>200; 

-- *************第五部分 集合***************

/*并集（UNION ALL包括重复值）*/
SELECT first_name,last_name FROM customer WHERE first_name = 'Aaron' UNION SELECT first_name,last_name FROM customer WHERE first_name = 'Rene';

/*交集*/
SELECT first_name,last_name FROM customer WHERE first_name = 'Aaron' INTERSECT SELECT first_name,last_name FROM customer WHERE first_name = 'Rene';

/*差集（查询不在库存中的影片）*/
SELECT film_id,title FROM film EXCEPT SELECT DISTINCT inventory.film_id,title FROM inventory INNER JOIN film USING(film_id) ORDER BY title;



-- *************第六部分 子查询*************

/*查找租金率高于平均租金率的前3部电影*/
SELECT rental_rate FROM film WHERE rental_rate > (SELECT AVG(rental_rate) FROM film) LIMIT 3;


/*查询按电影类别分组的所有电影的最大长度
最小值为178*/
SELECT max(length) FROM film INNER JOIN film_category USING(film_id) GROUP BY category_id;


/*查询按电影评级分组的所有电影的平均长度
最大值为120.44*/
SELECT avg(length) FROM film GROUP BY rating;

/*查询返回所有长度大于子查询返回的平均长度列表中最大值的影片
ALL表示全部都满足才返回TRUE,即大于平均长度的最大值120.44才可*/
SELECT film_id,title,length FROM film WHERE length > ALL (SELECT ROUND(AVG (length),2) FROM film GROUP BY rating) ORDER BY length;

/*查找至少有一笔金额大于11的付款的客户
EXISTS运算符来测试子查询中是否存在行*/
SELECT first_name,last_name FROM customer c WHERE EXISTS (SELECT 1 FROM payment p WHERE p.customer_id = c.customer_id AND amount > 11 ) ORDER BY first_name,last_name;



-- *************第七部分 修改数据*************

/*一次向表中添加多行*/
INSERT INTO t2 (score) VALUES (10);

/*插入来自另一个表的数据*/
INSERT INTO t2 (score) SELECT payment_id FROM payment WHERE amount BETWEEN 5 AND 6;

/*更改表中列的值*/
UPDATE t2 SET score = 4 WHERE score=1;
UPDATE t2 SET score = 1 WHERE score=4;
/*根据另一个表中的值更新表的数据*/
UPDATE A SET A.c1 = expresion FROM B WHERE A.c2 = B.c2;

/*从表中删除数据*/
DELETE FROM t2 WHERE score>=10;

/*检查引用另一个表中的一个或多个列的条件来删除数据*/
DELETE FROM table WHERE table.id = (SELECT id FROM another_table);


-- *************第八部分 管理表*************

/*创建表*/
SELECT film_id,title,rental_rate INTO TABLE film_r FROM film WHERE rating = 'R' AND rental_duration = 5 ORDER BY title;

/*验证表*/
SELECT * FROM film_r;

/*向表中添加新列*/
ALTER TABLE film_r ADD COLUMN ar int NOT NULL DEFAULT 1; 

/*删除现有列*/
ALTER TABLE film_r DROP COLUMN ar;

/*重命名现有列*/
ALTER TABLE film_r RENAME COLUMN title TO name;

/*将film_r表中name列的数据类型更改为VARCHAR*/
ALTER TABLE film_r ALTER COLUMN name TYPE VARCHAR;

/*重命名表*/
ALTER TABLE film_r RENAME TO film_p;

/*删除表*/
DROP TABLE IF EXISTS film_p;

/*创建临时表*/
CREATE TEMP TABLE film_r(a int PRIMARY KEY,b varchar(10));

/*删除表中所有数据*/
TRUNCATE TABLE t2;
INSERT INTO t2(score) VALUES(1),(2),(3);

-- *************第九部分 约束*************

/*主键约束方式一：创建表时定义主键*/
CREATE TABLE TABLE (
 column_1 data_type PRIMARY KEY,
 column_2 data_type,
 …
);

/*主键约束方式二：如果主键由两列或更多列组成*/
CREATE TABLE TABLE (
 column_1 data_type,
 column_2 data_type,
 … 
PRIMARY KEY (column_1, column_2)
);

/*主键约束方式三：更改现有表结构时定义主键*/
ALTER TABLE table_name ADD PRIMARY KEY (column_1, column_2);

/*删除主键*/
ALTER TABLE table_name DROP CONSTRAINT primary_key_constraint;
-- 删除主键或者其他约束要知道name，可通过\d table_name 查看


/*UNIQUE约束方式一：添加UNIQUE约束，确保存储在列或列组中的值在整个表中是唯一*/
CREATE TABLE person (
 id serial PRIMARY KEY,
 first_name VARCHAR (50),
 last_name VARCHAR (50),
 email VARCHAR (50) UNIQUE
);

/*UNIQUE约束方式二：列c2和c3中的值组合在整个表中是唯一的。列c2或c3的值不必是唯一的*/
CREATE TABLE table (
    c1 data_type,
    c2 data_type,
    c3 data_type,
    UNIQUE (c2, c3)
);


/*NOT NULL约束方式一：在创建新表时，将PostgreSQL非空约束添加到列*/
CREATE TABLE invoice(
  id serial PRIMARY KEY,
  product_id int NOT NULL,
  qty numeric NOT NULL CHECK(qty > 0),
  net_price numeric CHECK(net_price > 0) 
);

/*NOT NULL约束方式二：将PostgreSQL非空约束添加到现有表的列*/
ALTER  TABLE table_name ALTER COLUMN column_name SET NOT NULL;


/*CHECK约束，该约束根据布尔表达式约束表中列的值
一个CHECK约束是一种约束，使您可以指定是否在列中的值必须满足特定的要求。的CHECK约束使用布尔表达式插入或更新到列之前评估值。如果值通过检查，PostgreSQL将在列中插入或更新这些值。
首先，birth_date员工的出生日期（）必须大于01/01/1900。如果您之前尝试插入出生日期01/01/1900，您将收到一条错误消息。
其次，联合日期（joined_date）必须大于出生日期（birth_date）。此检查将阻止根据其语义含义更新无效日期。
第三，薪水必须大于零*/


-- *************第十部分 条件表达式和运算符*************

/*为电影分配价格段：如果租金率为0.99，则为普通；如果租金率是1.99，则为经济；如果出租率是4.99，则为豪华*/
SELECT CASE WHEN rental_rate<=0.99 THEN '普通' WHEN rental_rate<=1.99 THEN '经济' WHEN rental_rate<=4.99 THEN '豪华' END FROM film;


/*从左到右计算参数，直到找到第一个非null参数*/
SELECT COALESCE (NULL, 2 , 1);


/*将字符串常量转换为整数*/
SELECT CAST ('10' AS INT);


-- *************第十一部分 习题*************
/*1.将姓中含有“oo”的演员参演的电影的租赁期增加三天
Al Garland参演的电影的租赁期增加一天，
其他姓“Garland”的演员参演的电影的租赁期减两天，
展示所有演员的名字，过去的租赁期和当前最新的租赁期
问题出在把新的租赁期不知道往SELECT里面放*/
SELECT first_name,last_name,rental_duration AS old_rental_duration,(CASE WHEN last_name LIKE '%oo%' THEN rental_duration+3 WHEN last_name='Garland' THEN rental_duration-2 WHEN last_name='Garland' AND first_name='Al' THEN rental_duration+3 END) AS new_rental_duration FROM film INNER JOIN film_actor USING(film_id) INNER JOIN actor USING(actor_id) WHERE last_name='Garland' OR last_name LIKE '%oo%';


/*2.展示播放时长为115分钟到125分钟的电影名称及时长,
并按播放时长排序,相同时长的电影按名字排序，但A开头
和名字中含有c（另一个字母）r的电影必须最后排列，即
该条件为第一满足的条件，即第一排序*/
SELECT title,length FROM film WHERE length BETWEEN 115 AND 125 ORDER BY title IN (SELECT title FROM film WHERE title LIKE 'A%' OR title LIKE '%c_r%'),length,title;


/*3.展示不同语言种类的电影数量，并按从小到大的顺序排列*/
SELECT name,count(film_id) FROM film INNER JOIN language USING(language_id) GROUP BY name ORDER BY count(film_id);


/*4.展示英语类电影的电影类型及相应数目*/
SELECT name,count(film_id) FROM film INNER JOIN language USING(language_id) WHERE language_id=1 GROUP BY name;


/*5.展示有支付行为的每个城市的支付笔数*/
SELECT country,city,SUM(CASE WHEN amount>0 THEN 1 ELSE 0 END) FROM payment JOIN customer USING(customer_id) JOIN address USING(address_id) JOIN city USING (city_id) JOIN country USING (country_id) GROUP BY country,city;


/*6.找出每个国家按字母排序是排末位的城市中最高的支付金额*/
SELECT country,city,MAX(amount) FROM payment JOIN customer USING(customer_id) JOIN address USING(address_id) JOIN city USING (city_id) JOIN country USING (country_id) WHERE city IN (SELECT MAX(city) FROM city INNER JOIN country USING(country_id) GROUP BY country) GROUP BY country,city;  



