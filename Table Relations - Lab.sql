
 p01. Mountains and Peaks
 ------------------------
 CREATE TABLE mountains (
 id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(20) NOT NULL

 );

 CREATE TABLE peaks (
 id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(20) NOT NULL,
 mountain_id INT,
 CONSTRAINT fk_mountain_id FOREIGN KEY (mountain_id)
 REFERENCES mountains (id) 
 );
 
 p02. Books and Authors 
 ----------------------
 CREATE TABLE authors (
 id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(20) NOT NULL
 );

 CREATE TABLE books (
 id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(20) NOT NULL,
 author_id INT,
 CONSTRAINT fk_author_id FOREIGN KEY (author_id)
 REFERENCES authors (id)
 ON DELETE CASCADE
 );
 
 p03. Trip Organization 
 -----------------------
 SELECT driver_id,vehicle_type, CONCAT(first_name, ' ' ,last_name ) AS driver_name
 FROM vehicles AS v
 JOIN campers AS c ON
 v.driver_id = c.id
  
  p04. SoftUni Hiking 
  --------------------
  SELECT starting_point AS route_starting_point, end_point AS route_ending_point, leader_id,  CONCAT(first_name, ' ' ,last_name ) AS leader_name
  FROM routes AS r
  JOIN campers As c ON
  r.leader_id = c.id
 
 p05. Project Management DB
 -----------------------------
 CREATE TABLE clients (
  id INT PRIMARY KEY AUTO_INCREMENT,
  client_name VARCHAR(100) NOT NULL,
  project_id INT
 );

 CREATE TABLE projects (
  id INT PRIMARY KEY AUTO_INCREMENT,
  client_id INT,
  project_lead_id INT
 );
 
 
 
 

