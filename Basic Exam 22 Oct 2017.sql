/*

               01. DDL - Table Design
               ----------------------
CREATE SCHEMA report_service;
USE report_service;

CREATE TABLE users (
  id         INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  username   VARCHAR(30) UNIQUE,
  `password` VARCHAR(50) NOT NULL,
  name       VARCHAR(50),
  gender     VARCHAR(1),
  birthdate  DATETIME,
  age        INT UNSIGNED,
  email      VARCHAR(50) NOT NULL
);

CREATE TABLE departments (
  id   INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
  id            INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  first_name    VARCHAR(25),
  last_name     VARCHAR(25),
  gender        VARCHAR(1),
  birthdate     DATETIME,
  age           INT UNSIGNED,
  department_id INT UNSIGNED,
  CONSTRAINT fk_departments_department_id FOREIGN KEY (department_id)
  REFERENCES departments (id)
);

CREATE TABLE categories (
  id            INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name          VARCHAR(50) NOT NULL,
  department_id INT UNSIGNED,
  CONSTRAINT fk_departments__department_id FOREIGN KEY (department_id)
  REFERENCES departments (id)
);

CREATE TABLE status (
  id    INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  label VARCHAR(30) NOT NULL
);

CREATE TABLE reports (
  id          INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  category_id INT UNSIGNED,
  status_id   INT UNSIGNED,
  open_date   DATETIME,
  close_date  DATETIME,
  description VARCHAR(200),
  user_id     INT UNSIGNED,
  employee_id INT UNSIGNED,
  CONSTRAINT fk_categories_category_id FOREIGN KEY (category_id)
  REFERENCES categories (id),
  CONSTRAINT fk_status_status_id FOREIGN KEY (status_id)
  REFERENCES status (id),
  CONSTRAINT fk_users_user_id FOREIGN KEY (user_id)
  REFERENCES users (id),
  CONSTRAINT fk_employees_employee_id FOREIGN KEY (employee_id)
  REFERENCES employees (id)


                  02. Insert
                  ----------
INSERT INTO employees (first_name, last_name, gender, birthdate, department_id)
  VALUES
        ('Marlo','O\'Maley','M','1958-09-21',	1),
        ('Niki','Stanaghan','F','1969-11-26',	4),
        ('Ayrton','Senna','M','1960-03-21',	9),
        ('Ronnie','Peterson','M','1944-02-14',	9),
        ('Giovanna','Amati','F','1959-07-20',	5);

INSERT INTO reports (category_id, status_id, open_date, close_date, description, user_id, employee_id)
   VALUES
         (1,	1,	'2017-04-13',NULL ,	'Stuck Road on Str.133',	6,	2),
         (6,	3,	'2015-09-05','2015-12-06' ,	'Charity trail running',	3,	5),
         (14,	2,	'2015-09-07',NULL ,	'Falling bricks on Str.58',	5,	2),
         (4,	3,	'2017-07-03','2017-07-03' ,	'Cut off streetlight on Str.11',	1,	1);

DELETE FROM employees
WHERE id IN (31,32,33,34,35);

DELETE FROM reports
WHERE id IN (41,42,43,44);


                  03. Update
                  ----------
UPDATE reports AS r
  SET r.status_id = 2
  WHERE r.status_id =1 AND r.category_id =4;
);

                  04. Delete
                  ----------
DELETE FROM reports
 WHERE status_id =4;

                  05.Users by Age
                  ---------------
SELECT username	,age FROM users
  ORDER BY age ASC ,username DESC;

                  06.Unassigned Reports
                  ---------------------
SELECT r.description,	r.open_date FROM reports AS r
  WHERE r.employee_id IS NULL
  ORDER BY r.open_date ASC,r.description ASC ;

                  07.Employees and Reports
                  ------------------------

SELECT e.first_name	,e.last_name,	r.description,	DATE (r.open_date) AS open_date FROM employees AS e
  JOIN reports r ON e.id = r.employee_id
  ORDER BY e.id ASC, r.open_date ASC, r.id ASC;

                  08. Most Reported Category
                  --------------------------
SELECT c.name, COUNT(r.id) AS reports_number FROM categories AS c
 JOIN reports r ON c.id = r.category_id
 GROUP BY c.name
 ORDER BY reports_number ASC, c.name ASC;

                  09. One Category Employees
                  --------------------------

SELECT c.name AS category_name, COUNT(e.id) AS employees_number
FROM categories AS c
       JOIN departments d ON c.department_id = d.id
       JOIN employees e ON d.id = e.department_id
GROUP BY c.name
ORDER BY category_name ASC;

                     11.Users per Employee
                     ----------------------
SELECT CONCAT(e.first_name, ' ', e.last_name) AS name,
       COUNT(r.employee_id) users_count
       FROM employees AS e
       LEFT JOIN reports AS r ON e.id = r.employee_id
       GROUP BY name
       ORDER BY users_count DESC, name ASC;

                    12. Emergency Patrol
                    --------------------
SELECT r.open_date, r.description, u.email AS reporter_email
  FROM reports AS r
       JOIN users u ON r.user_id = u.id
       JOIN categories c ON r.category_id = c.id
       JOIN departments d ON c.department_id = d.id
  WHERE r.close_date IS NULL
    AND char_length(r.description) > 20
    AND r.description LIKE ('%str%')
    AND d.name IN ('Infrastructure', 'Emergency', 'Roads Maintenance')
  ORDER BY r.open_date ASC, u.email ASC, r.id ASC;

*/

































