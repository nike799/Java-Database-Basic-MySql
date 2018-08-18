USE gamebar;

/*
p02_Create Tables

CREATE TABLE `employees` (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(15) NOT NULL,
last_name VARCHAR(15) NOT NULL
);

CREATE TABLE `categories`(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30) NOT NULL
);

CREATE TABLE `products`(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30) NOT NULL,
category_id INT NOT NULL 
);

p03_Insert Data into Tables

INSERT INTO `employees`(`first_name`,`last_name`) VALUES('Nikolay','Grozdanov'),
('Pesho','Peshev'),
('Gosho','Goshov');

p04_Alter Table

ALTER TABLE employees
ADD middle_name VARCHAR(15);

p05_Adding constraints

ALTER TABLE products
ADD CONSTRAINT fk_products_category_id
FOREIGN KEY (category_id) REFERENCES categories(id);

p06_Modifying columns

ALTER TABLE employees
MODIFY COLUMN middle_name VARCHAR(100);

*/







