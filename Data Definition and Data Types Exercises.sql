
USE minions;

p02_Create Tables
-------------------
CREATE TABLE minions(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
age INT
);

CREATE TABLE towns(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL
);

p03_Alter Table Minions
--------------------------
ALTER TABLE minions
ADD COLUMN town_id INT;

ALTER TABLE minions
ADD CONSTRAINT fk_minions_town_id_towns_id
FOREIGN KEY (town_id) REFERENCES towns(id);

p04_Insert Records in Both Tables
----------------------------------
INSERT INTO minions(name,age) VALUES('Kevin',22),('Bob',15),('Steward',NULL);
INSERT INTO towns (name) VALUES('Sofia'),('Plovdiv'),('Varna');

p05_Truncate Table Minions
---------------------------
TRUNCATE TABLE minions;

p06_Drop All Tables
--------------------
DROP TABLE minions;
DROP TABLE towns;

p07_Create Table People
------------------------
CREATE TABLE people(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(200) NOT NULL,
picture BLOB,
height DOUBLE(3,2),
weight DOUBLE(5,2),
gender ENUM('m','f') NOT NULL,
birthdate DATE NOT NULL,
biography TEXT
);
INSERT INTO people(name,picture,weight,height,gender,birthdate,biography)
 VALUES('Pesho Peshev','image1',78.50,1.96,'m','1981-09-18','Everythig is gona be allright'),
 ('Gosho Goshov','image2',99.50,1.96,'m','1979-03-10','Everythig is gona be allright'),
 ('Sasho Sashev','image3',50.50,1.96,'m','1981-05-03','Everythig is gona be allright'),
 ('Emo Emev','image4',78.50,1.96,'m','1979-04-28','Everythig is gona be allright'),
 ('Pavel DonPavlito','image5',98.50,1.96,'m','1980-01-04','Everythig is gona be allright');
 
 p08_Create table Users
 -----------------------
  CREATE TABLE users(
`id` BIGINT AUTO_INCREMENT PRIMARY KEY,
`username` VARCHAR(30) UNIQUE NOT NULL,
`password` VARCHAR(26) NOT NULL,
`profile_picture` BLOB,
`last_login_time` TIME,
`is_deleted` TINYINT(1)
);

INSERT INTO users (username,`password`,profile_picture,last_login_time,is_deleted) VALUES 
('nike7','123456','image1','17:05:25',1),
('nike81','1235456','image2','18:05:25',0),
('nike95','11232456','image3','19:05:25',0),
('nike101','123496','image4','20:05:25',1),
('nike111','1823456','image5','21:05:25',1);

p09_Change Primaty Key
-----------------------
ALTER TABLE users MODIFY id INT NOT NULL;
ALTER TABLE users DROP PRIMARY KEY;

p10_Set Default Value of a Field
---------------------------------
ALTER TABLE users MODIFY COLUMN last_login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

p11_Set Unique Field
--------------------
ALTER TABLE users DROP PRIMARY KEY, ADD PRIMARY KEY (id);
ALTER TABLE users ADD CONSTRAINT UNIQUE pk_users (id,username);

p12_Movies Database
--------------------
CREATE DATABASE movies;
USE movies;

CREATE TABLE directors(
id INT AUTO_INCREMENT PRIMARY KEY,
director_name VARCHAR(50) NOT NULL,
notes TEXT
);

CREATE TABLE genres (
id INT AUTO_INCREMENT PRIMARY KEY,
genre_name VARCHAR(50) NOT NULL,
notes TEXT
);

CREATE TABLE categories(
id INT AUTO_INCREMENT PRIMARY KEY,
category_name VARCHAR(50) NOT NULL,
notes TEXT
);

 CREATE TABLE movies (
 id INT AUTO_INCREMENT PRIMARY KEY,
 title VARCHAR(50) NOT NULL,
 director_id INT,
 copyright_year YEAR,
 `length` DOUBLE,
 genre_id INT,
 category_id INT,
 rating DOUBLE,
 notes TEXT
 );
  INSERT INTO directors (director_name) VALUES ('pesho'),('gosho'),('stamat'),('kiro'),('spiro');
  INSERT INTO genres (genre_name) VALUES ('comedy'),('drama'),('action'),('triller'),('fiction');
  INSERT INTO categories (category_name) VALUES ('1'),('2'), ('3'),('4'), ('5');
  INSERT INTO movies (title,copyright_year,`length`,rating) VALUES ('Vchera','1979',2.56,5.9);
  ALTER TABLE movies
  ADD CONSTRAINT fk_movies_director_id FOREIGN KEY(director_id)REFERENCES directors(id),
  ADD CONSTRAINT fk_movies_genre_id FOREIGN KEY(genre_id)REFERENCES genres(id),
  ADD CONSTRAINT fk_movies_category_id FOREIGN KEY(category_id)REFERENCES categories(id);
  
  p13_Car Rental_Database
  ------------------------
  
CREATE TABLE categories(
id INT AUTO_INCREMENT PRIMARY KEY,
category CHAR NOT NULL,
daily_rate DOUBLE(4,2) NOT NULL,
weekly_rate DOUBLE(4,2) NOT NULL,
monthly_rate DOUBLE(4,2) NOT NULL,
weekend_rate DOUBLE(4,2) NOT NULL
);

CREATE TABLE cars(
id INT AUTO_INCREMENT PRIMARY KEY,
plate_number VARCHAR(20) NOT NULL,
make  VARCHAR(20) NOT NULL,
model  VARCHAR(20) NOT NULL,
car_year YEAR NOT NULL,
category_id INT,
doors INT NOT NULL,
picture BLOB NOT NULL,
car_condition VARCHAR(50) NOT NULL,
available INT NOT NULL
);

CREATE TABLE employees(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
title VARCHAR(20) NOT NULL,
notes TEXT
);

CREATE TABLE customers (
id INT AUTO_INCREMENT PRIMARY KEY,
driver_licence VARCHAR(50) NOT NULL,
full_name VARCHAR(50) NOT NULL,
address VARCHAR(50) NOT NULL,
city VARCHAR(20) NOT NULL,
zip_code VARCHAR(20) NOT NULL,
notes TEXT
);

CREATE TABLE rental_orders(
id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT,
car_id INT,
car_condition VARCHAR(50),
tank_level VARCHAR(20) NOT NULL,
kilometrage_start INT NOT NULL,
kilometrage_end INT NOT NULL,
start_date DATE NOT NULL,
end_date  DATE NOT NULL,
total_days INT NOT NULL,
rate_applied DOUBLE NOT NULL,
tax_rate DOUBLE NOT NULL,
order_status BOOL NOT NULL,
notes TEXT
);

INSERT INTO categories(category,daily_rate,weekly_rate,monthly_rate,weekend_rate) VALUES
('A',40.50,90.50,10.60,70.50),('B',40.50,90.50,10.60,70.50),('C',40.50,90.50,10.60,70.50);

INSERT INTO cars (plate_number,make,model,car_year,doors,`picture`,car_condition,available) VALUES 
('CA2568HG','Pegaut','5008',2006,5,'image','good',1),
('CA2568HG','Pegaut','5008',2006,5,'image','good',1),
('CA2568HG','Pegaut','5008',2006,5,'image','good',1);

INSERT INTO employees(first_name,last_name,title) VALUES('Pesho','Peshev','Manager'),('Pesho','Pesh','Mlad Merinj'),('Pes','Pesh','Merinj');

INSERT INTO customers(driver_licence,full_name,address,city,zip_code)VALUES
('B','Gosho Goshov', 'Wall Street 55','New York','1231'),
('C','Gosho Gosh', 'Wall Street 56','New York','1231'),
('D','Gosh Goshov', 'Wall Street 57','New York','1231');

INSERT INTO rental_orders(tank_level,kilometrage_start,kilometrage_end,start_date,end_date,total_days,rate_applied,tax_rate,order_status)VALUES
('80',50000,55000,'2018-05-18','2018-08-31',81,20.58,58.58,1),
('81',50000,55000,'2018-05-18','2018-08-31',81,20.58,58.58,1),
('82',50000,55000,'2018-05-18','2018-08-31',81,20.58,58.58,1);

p14_Hotel Database
------------------
CREATE DATABASE hotel;

CREATE TABLE employees(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(20) NOT NULL, 
last_name VARCHAR(20) NOT NULL, 
title VARCHAR(30) NOT NULL,
notes TEXT
);

CREATE TABLE customers (
account_number VARCHAR(20) NOT NULL,
first_name VARCHAR(20) NOT NULL, 
last_name VARCHAR(20) NOT NULL,
phone_number VARCHAR(20) NOT NULL, 
emergency_name VARCHAR(50) NOT NULL,
emergency_number VARCHAR(20) NOT NULL,
notes TEXT
);

CREATE TABLE room_status (
room_status VARCHAR(20) NOT NULL,
notes TEXT
);

CREATE TABLE room_types(
room_type VARCHAR (20) NOT NULL,
notes TEXT
);

CREATE TABLE bed_types (
bed_type VARCHAR(20) NOT NULL,
notes TEXT
);

CREATE TABLE rooms(
room_number VARCHAR(10) NOT NULL, 
room_type VARCHAR(20) NOT NULL,
bed_type VARCHAR(20) NOT NULL, 
rate DOUBLE(2,1), 
room_status VARCHAR(20) NOT NULL,
notes TEXT
);

CREATE TABLE payments (
id INT AUTO_INCREMENT PRIMARY KEY, 
employee_id INT,
payment_date DATE NOT NULL, 
account_number VARCHAR(20), 
first_date_occupied DATE NOT NULL, 
last_date_occupied DATE NOT NULL, 
total_days INT NOT NULL, 
amount_charged DOUBLE NOT NULL, 
tax_rate DOUBLE NOT NULL, 
tax_amount DOUBLE NOT NULL, 
payment_total DOUBLE NOT NULL,
notes TEXT
);

CREATE TABLE occupancies (
id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT,
date_occupied DATE,
account_number VARCHAR(20),
room_number VARCHAR(10),
rate_applied DOUBLE , 
phone_charge DOUBLE NOT NULL, 
notes TEXT
);

INSERT INTO employees(first_name,last_name,title) VALUES
('Pesho','Peshev','driver'),('Pesho','Peshev','driver'),('Pesho','Peshev','driver');

INSERT INTO customers(account_number,first_name,last_name,phone_number,emergency_name,emergency_number) VALUES
('123456789','Pesho','Peshev','55665255555','Father','555555555'),
('123456789','Pesho','Peshev','55665255555','Father','555555555'),
('123456789','Pesho','Peshev','55665255555','Father','555555555');

INSERT INTO room_status(`room_status`) VALUES ('free'),('free'),('free');
INSERT INTO room_types (room_type) VALUES ('double'),('single'),('double');
INSERT INTO bed_types(bed_type)VALUES ('double'), ('double'), ('tripple');

INSERT INTO rooms (room_number,room_type,bed_type,`room_status`) VALUES
('123','double','huge','free'),
('123','double','huge','free'),
('123','double','huge','free');

INSERT INTO payments (first_date_occupied,last_date_occupied,total_days, amount_charged,tax_rate,tax_amount,payment_total)VALUES
('2018-05-15','2018-06-15',100,2000.00,10.58,58.25,2589.25),
('2018-05-15','2018-06-15',100,2000.00,10.58,58.25,2589.25),
('2018-05-15','2018-06-15',100,2000.00,10.58,58.25,2589.25);

INSERT INTO occupancies (phone_charge) VALUES (25.25),(25.25),(25.25);


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


