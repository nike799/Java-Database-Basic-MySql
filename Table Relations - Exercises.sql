
 p01. One-To-One Relationship
 ----------------------------
 CREATE TABLE passports (
  passport_id INT PRIMARY KEY AUTO_INCREMENT,
  passport_number VARCHAR(20) NOT NULL
 );

 CREATE TABLE persons (
  person_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL,
  salary DECIMAL (10,2),
  passport_id INT UNIQUE ,
  CONSTRAINT fk_person_id FOREIGN KEY (passport_id)
  REFERENCES passports (passport_id)
 );

 INSERT INTO passports (passport_id,passport_number) VALUES (101,'N34FG21B'),(102,'K65LO4R7'),(103,'ZE657QP2');

 INSERT INTO persons (person_id, first_name, salary, passport_id) VALUES (1,'Roberto',43300.00,102),
                                                              (2,'Tom',56100.00,103),
                                                             (3,'Yana',60200.00,101);

 p02.	One-To-Many Relationship
 -----------------------------
 CREATE TABLE manufacturers (
  manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  established_on DATE
 );

 CREATE TABLE models (
  model_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL,
  manufacturer_id INT,
  CONSTRAINT fk_manufacturers_id FOREIGN KEY (manufacturer_id)
    REFERENCES manufacturers (manufacturer_id)
 );

 INSERT INTO manufacturers (name, established_on) VALUES ('BMW','1916-03-01'),
                                                        ('Tesla','2003-01-01'),
                                                        ('Lada','1966-05-01');
 INSERT INTO models (model_id, name, manufacturer_id) VALUES (101,'X1',1),
                                                            (102,'i6',1),
                                                            (103,'Model S',2),
                                                            (104,'Model X',2),
                                                            (105,'Model 3',2),
                                                            (106,'Nova',3);
 p03. Many-To-Many Relationship
 ------------------------------
 CREATE TABLE students (
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL
);
CREATE TABLE exams (
  exam_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL
 );
 CREATE TABLE students_exams (
  student_id INT,
  exam_id INT,
  PRIMARY KEY (student_id,exam_id)
 );

  INSERT INTO students (name) VALUES ('Mila'),('Toni'),('Ron');
  INSERT INTO exams (exam_id, name) VALUES (101,'Spring MVC'),(102,'Neo4j'),(103,'Oracle 11g');
  INSERT INTO students_exams (student_id, exam_id) VALUES (1,101),(1,102),(2,101),(3,103),(2,102),(2,103);

  p04. Self-Referencing
  ----------------------
CREATE TABLE teachers (
  teacher_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL,
  manager_id INT,
  CONSTRAINT fk_teacher_id_manager_id FOREIGN KEY (manager_id)
    REFERENCES teachers (teacher_id)
 );
 INSERT INTO teachers (teacher_id,name, manager_id) VALUES (101,'John'),
                                                          (102,'Maya',106),
                                                          (103,'Silvia',106),
                                                          (104,'Ted',105),
                                                          (105,'Mark',101),
                                                          (106,'Greta',101);
 p05. Online Store Database
 --------------------------
 CREATE TABLE item_types (
  item_type_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL
 );

 CREATE TABLE items (
  item_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  item_type_id INT,
  CONSTRAINT fk_item_type_id FOREIGN KEY (item_type_id)
    REFERENCES item_types (item_type_id)
 );
 CREATE TABLE cities (
  city_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50)
 );
 CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  birthday DATE,
  city_id INT,
  CONSTRAINT fk_city_id FOREIGN KEY (city_id)
    REFERENCES cities (city_id)
 );
 CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT,
  CONSTRAINT fk_customer_id FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id)
 );
 CREATE TABLE  order_items (
  order_id INT,
  item_id INT,
  CONSTRAINT pk_order_item_id PRIMARY KEY (order_id,item_id),
  CONSTRAINT fk_order_id FOREIGN KEY (order_id)
    REFERENCES orders (order_id),
  CONSTRAINT fk_item_id FOREIGN KEY (item_id)
    REFERENCES items (item_id)
 );

 06.	University Database
 -------------------------
 CREATE TABLE majors (
  major_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL
 );
 CREATE TABLE students (
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  student_number VARCHAR(12) NOT NULL ,
  student_name VARCHAR(50) NOT NULL,
  major_id INT,
  CONSTRAINT fk_major_id FOREIGN KEY (major_id)
    REFERENCES majors (major_id)
);

CREATE  TABLE payments (
  payment_id INT PRIMARY KEY AUTO_INCREMENT,
  payment_date DATE,
  payment_amount DECIMAL (8,2),
  student_id INT,
  CONSTRAINT fk_student_id FOREIGN KEY (student_id)
    REFERENCES students (student_id)
 );
 CREATE TABLE subjects (
  subject_id INT PRIMARY KEY AUTO_INCREMENT,
  subject_name VARCHAR(50) NOT NULL
 );

 CREATE TABLE agenda (
  student_id INT,
  subject_id INT,
  CONSTRAINT pk_student_subject_id PRIMARY KEY (student_id,subject_id),
  CONSTRAINT fk_student_id_agenda FOREIGN KEY (student_id)
    REFERENCES students (student_id),
  CONSTRAINT fk_subject_id_agenda FOREIGN KEY (subject_id)
    REFERENCES subjects (subject_id)
 );

 p09.	Peaks in Rila
 -------------------
 SELECT mountain_range, peak_name, elevation AS peak_elevation
 FROM mountains AS m
 JOIN peaks AS p
 ON m.id = p.mountain_id
 WHERE m.mountain_range = 'Rila'
 ORDER BY p.elevation DESC ;


