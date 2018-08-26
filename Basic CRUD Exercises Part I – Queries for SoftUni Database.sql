USE soft_uni;
/*
 p02_Find All Information About Departments
 ---------------------------------------------
 SELECT * FROM departments;

 p03_Find all Department Names
 -----------------------------
 SELECT name FROM departments;

 p04_Find salary of Each Employee
 ---------------------------------
 SELECT first_name,last_name,salary FROM employees
 ORDER BY employee_id ;
 
 p05_Find Full Name of Each Employee
 -----------------------------------
 SELECT first_name,middle_name,last_name FROM employees
 ORDER BY employee_id;

 p06_Find Email Address of Each Employee
 ----------------------------------------
 SELECT concat(first_name,'.',last_name,'@softuni.bg') 
 AS full_email_address
 FROM employees;

 p07_Find All Different Employee’s Salaries
 -------------------------------------------
 SELECT DISTINCT (salary) FROM employees
 ORDER BY employee_id
 
 p08_Find Names of All Employees by salary in Range
 ---------------------------------------------------
 SELECT first_name,last_name,job_title
  FROM employees
  WHERE salary BETWEEN 20000 AND 30000
  ORDER BY employee_id
  
 p09_Find Names of All Employees 
 --------------------------------
 SELECT CONCAT(first_name,' ',middle_name,' ',last_name)
 AS 'Full Name'
 FROM employees
 WHERE salary IN (25000, 14000, 12500, 23600);
 
 p10_Find All Employees Without Manager
 ----------------------------------------
 SELECT first_name,last_name
 FROM employees
 WHERE manager_id IS NULL;
 
 p11_Find All Employees with salary More Than 50000
 ------------------------------------------------------
 SELECT first_name,last_name,salary
 FROM employees
 WHERE salary >50000
 ORDER BY salary DESC;
 
 p12_Find 5 Best Paid Employees
 ------------------------
 SELECT first_name,last_name 
 FROM employees
 ORDER BY salary DESC 
 LIMIT 5
 
 p13_Find All Employees Except Marketing
 ----------------------------------------
 SELECT first_name,last_name 
 FROM employees
 WHERE department_id != 4
 
 p14_Sort Employees Table
 -----------------------------
 SELECT * 
 FROM employees
 ORDER by 
 salary DESC,
 first_name ,
 last_name DESC,
 middle_name;
 
 15_Create View Employees with Salaries
 ---------------------------------------
 CREATE VIEW v_employees_salaries
 AS
 SELECT first_name,last_name, salary
 FROM employees;
 
 p16_Create View Employees with Job Titles
 -----------------------------------------
 CREATE VIEW v_employees_job_titles 
 AS
 SELECT CONCAT(first_name,' ',IFNULL(middle_name,''),' ',last_name) AS 'full_name',job_title 
 FROM employees;

 p17_Distinct Job Titles
 ------------------------
 SELECT DISTINCT (job_title) FROM employees
 ORDER BY job_title

 p18_Find First 10 Started Projects
 ---------------------------------------
 SELECT * 
 FROM projects
 ORDER BY start_date,name,project_id
 LIMIT 10;
 
 p19_Last 7 Hired Employees
 --------------------------*
 SELECT first_name, last_name, hire_date
 FROM employees
 ORDER BY hire_date DESC
 LIMIT 7

 p20_Increase Salaries
 -------------------
 UPDATE employees 
 SET salary = salary*1.12
 WHERE department_id IN (1,2,4,11);
 SELECT salary
 FROM employees;
 
*/


 




