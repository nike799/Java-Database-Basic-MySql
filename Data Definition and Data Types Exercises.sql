
/*
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

 */
