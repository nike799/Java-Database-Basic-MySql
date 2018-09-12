
 p01. Managers
 --------------
 SELECT e.employee_id,
       CONCAT(e.first_name,' ',e.last_name) AS full_name,
       d.department_id,
       d.name AS department_name
 FROM employees AS e
 INNER JOIN departments d on e.employee_id = d.manager_id
 ORDER BY e.employee_id
 LIMIT 5;

 p02. Towns and Addresses
 -------------------------
 SELECT t.town_id, t.name,a.address_text
 FROM towns AS t
       JOIN addresses As a ON t.town_id = a.town_id
 WHERE t.name = 'San Francisco' || t.name = 'Sofia' || t.name ='Carnation'
 ORDER BY t.town_id ASC , a.address_id ASC ;

 p03. Employees Without Managers
 --------------------------------
 SELECT employee_id, first_name, last_name, department_id, salary
 FROM employees AS e
 WHERE e.manager_id IS NULL;

 p04. High Salary
 -----------------
 SELECT COUNT(e.employee_id) AS count_of_employees FROM employees AS e
 WHERE e.salary > (SELECT AVG(salary) AS avg_salary FROM employees);

