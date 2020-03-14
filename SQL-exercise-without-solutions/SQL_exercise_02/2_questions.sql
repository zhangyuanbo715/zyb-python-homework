-- LINK : Employee_management
-- 2.1 Select the last name of all employees.

SELECT lastname FROM employees;

-- 2.2 Select the last name of all employees, without duplicates.

SELECT DISTINCT lastname FROM employees;

-- 2.3 Select all the data of employees whose last name is "Smith".

SELECT * FROM employees WHERE lastname='Smith';

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".

SELECT * FROM employees WHERE lastname IN ('Smith','Doe');

-- 2.5 Select all the data of employees that work in department 14.

SELECT * FROM employees WHERE department=14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.

SELECT * FROM employees WHERE department IN (14,77);

-- 2.7 Select all the data of employees whose last name begins with an "S".

SELECT * FROM employees WHERE lastname LIKE 'S%';

-- 2.8 Select the sum of all the departments' budgets.

SELECT sum(budget) FROM departments;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).

SELECT code,count(lastname) FROM departments INNER JOIN employees ON code=department GROUP BY code;

-- 2.10 Select all the data of employees, including each employee's department's data.

SELECT ssn,e.name,lastname,code,d.name depart_name,budget FROM departments d INNER JOIN employees e ON code=department;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.

SELECT e.name,lastname,d.name depart_name,budget FROM departments d INNER JOIN employees e ON code=department;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.

SELECT e.name,lastname FROM departments INNER JOIN employees e ON code=department WHERE budget>60000;

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.

SELECT name FROM departments WHERE budget>(SELECT avg(budget) FROM departments);

-- 2.14 Select the names of departments with more than two employees.

SELECT d.name FROM departments d INNER JOIN employees e ON code=department GROUP BY code HAVING count(lastname)>2; 

-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.

SELECT name,lastname FROM employees WHERE department=(SELECT code FROM departments ORDER BY budget LIMIT 1 OFFSET 1); 

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 

INSERT INTO departments(code,name,budget) VALUES(11,'Quality Assurance',40000);

-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.

INSERT INTO employees(ssn,name,lastname,department) VALUES(847219811,'Mary','Moore',11);

-- 2.17 Reduce the budget of all departments by 10%.

UPDATE departments SET budget=budget*0.9;

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).

UPDATE employees SET department=14 WHERE department=77;

-- 2.19 Delete from the table all employees in the IT department (code 14).

DELETE FROM employees WHERE department=14;

-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.

DELETE FROM employees WHERE department IN (SELECT code FROM departments WHERE budget>=60000);

-- 2.21 Delete from the table all employees.

DELETE FROM employees;
