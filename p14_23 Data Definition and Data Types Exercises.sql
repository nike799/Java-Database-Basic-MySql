
p15_Create Database softuni
----------------------------

CREATE TABLE towns (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

CREATE TABLE addresses (
id INT AUTO_INCREMENT PRIMARY KEY,
address_text TEXT NOT NULL,
town_id INT 
);

CREATE TABLE departments (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
id  INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL, 
middle_name VARCHAR(50) NOT NULL, 
last_name VARCHAR(50) NOT NULL, 
job_title VARCHAR(50) NOT NULL, 
department_id INT, 
hire_date DATE NOT NULL, 
salary DOUBLE NOT NULL, 
address_id INT
);
ALTER TABLE addresses 
ADD CONSTRAINT FOREIGN KEY fk_addresses_town_id (town_id) REFERENCES towns (id);
ALTER TABLE employees 
ADD CONSTRAINT FOREIGN KEY fk_employees_department_id (department_id) REFERENCES departments (id),
ADD CONSTRAINT FOREIGN KEY fk_employees_addresses_id (address_id) REFERENCES addresses (id);

p17_Basic Insert
-----------------

INSERT INTO towns (name) VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');
INSERT INTO departments (name) VALUES ('Engineering'), ('Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance');
INSERT INTO employees (first_name,middle_name,last_name,job_title, department_id,hire_date, salary)VALUES
('Ivan','Ivanov','Ivanov','.NET Developer',4,'2013-02-01',3500),
('Petar','Petrov','Petrov','Senior Engineer',1,'2004-03-02',4000),
('Maria','Petrova','Ivanova','Intern',5,'2016-08-28',525.25),
('Georgi','Terziev','Ivanov','CEO',2,'2007-12-09',3000),
('Peter','Pan','Pan','Intern',3,'2016-08-28',599.88);

p18_Basic Select All Fields
----------------------------

SELECT * 
FROM employees e
	JOIN departments d
	ON e.department_id = d.id 
WHERE d.name = 'Engineering' 

SELECT * FROM towns ;
SELECT * FROM departments;
SELECT * FROM employees;

p19_Basic Select All Fields and Order Them
-------------------------------------------
 
SELECT *
 FROM towns 
 ORDER BY name;
 
SELECT * 
 FROM departments 
 ORDER BY name;
 
SELECT * 
 FROM employees 
 ORDER BY salary DESC;
 
p20_Basic Select Some Fields
--------------------------------

SELECT name 
 FROM towns 
 ORDER BY name;

SELECT name 
 FROM departments
 ORDER BY name;
 
SELECT first_name, last_name, job_title, salary
 FROM employees
 ORDER BY salary DESC;
 
 p21_Increase Employees Salary
 ------------------------------
 
 UPDATE employees
SET salary = salary*1.1;

 SELECT salary 
 FROM employees
 
 p22_
 -----------------
 
 UPDATE payments
 SET tax_rate = tax_rate*0.97;
 SELECT tax_rate
 FROM payments
 
 USE hotel;
 TRUNCATE occupancies;




