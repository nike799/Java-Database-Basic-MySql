/*
  p01. Records’ Count
  -------------------
  SELECT COUNT(id) AS `count`
   FROM wizzard_deposits AS wd
  
  p02. Longest Magic Wand
  ----------------------
   SELECT MAX(magic_wand_size) AS magic_wand_size
    FROM wizzard_deposits;
   
   p03.Longest Magic Wand per Deposit Groups
   ------------------------------------------
   SELECT deposit_group,MAX(magic_wand_size) AS longest_magic_wand
    FROM wizzard_deposits
     GROUP BY deposit_group
      ORDER BY longest_magic_wand ASC, deposit_group;
   
   p04.Smallest Deposit Group per Magic Wand Size
   ----------------------------------------------
   SELECT deposit_group
    FROM wizzard_deposits AS wd
	  GROUP BY wd.deposit_group
   	ORDER BY AVG(magic_wand_size)
     	 LIMIT 1;
  p05. Deposits Sum
  -------------------------
   SELECT deposit_group, SUM(deposit_amount) AS total_sum
    FROM wizzard_deposits wd
     GROUP BY wd.deposit_group
      ORDER BY total_sum	
		
  p06. Deposits Sum for Ollivander Family
  ----------------------------------------- 
 SELECT deposit_group, SUM(deposit_amount) AS total_sum
   FROM wizzard_deposits wd
    WHERE wd.magic_wand_creator = 'Ollivander family'
     GROUP BY wd.deposit_group
      ORDER BY wd.deposit_group ASC
      
  p07. Deposits Filter
  -----------------------
 SELECT deposit_group, SUM(deposit_amount) AS total_sum
   FROM wizzard_deposits wd
    WHERE wd.magic_wand_creator = 'Ollivander family'
     GROUP BY wd.deposit_group
      HAVING total_sum < 150000
       ORDER BY total_sum DESC
     
  p08. Deposit Charge
  ---------------------- 
   SELECT deposit_group, magic_wand_creator, MIN(deposit_charge) AS min_deposit_charge
    FROM wizzard_deposits wd
     GROUP BY wd.deposit_group,wd.magic_wand_creator
      ORDER BY wd.magic_wand_creator ASC,wd.deposit_group ASC	 
      
  p09. Age Groups
  ------------------
  SELECT
   CASE 
    WHEN age BETWEEN 0  AND 10 THEN '[0-10]'
    WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
    WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
    WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
    WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
    WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
    WHEN age > 60 THEN '[61+]'
    END  AS age_group,
    COUNT(*) AS wizzard_count
     FROM wizzard_deposits AS wd
      GROUP BY age_group;  
      
   p10. First Letter 
	------------------------
	first solution
	--------------
  SELECT DISTINCT LEFT(first_name,1) AS first_letter
   FROM wizzard_deposits AS wd
    WHERE wd.deposit_group = 'Troll Chest' 
    ORDER BY first_letter
	  
	second solution
	-----------------
  SELECT  LEFT(first_name,1) AS first_letter
   FROM wizzard_deposits AS wd
    WHERE wd.deposit_group = 'Troll Chest' 
     GROUP BY first_letter
      ORDER BY first_letter
      
    p11. Average Interest  ?????
    ----------------------------------
   SELECT deposit_group, is_deposit_expired, AVG(deposit_interest) AS average_interest
    FROM wizzard_deposits wd
     WHERE wd.deposit_start_date > '1985-01-01'
      GROUP BY wd.deposit_interest
       ORDER BY wd.deposit_group DESC, wd.is_deposit_expired ASC;
       
   p12. Rich Wizard, Poor Wizard   !!!!!!!!!!!!!!!!
   -------------------------------
   SELECT SUM(diff.next) AS sum_difference
    FROM (
    SELECT deposit_amount -
	          (SELECT deposit_amount
	          FROM wizzard_deposits
	           WHERE id = wd.id +1) AS next
	         FROM wizzard_deposits AS wd) AS diff;
	         
  p13. Employees Minimum Salaries 
  ---------------------------------
  SELECT department_id, MIN(salary) AS minimum_salary
  FROM employees AS e
  GROUP BY e.department_id
  HAVING e.department_id IN(2,5,7);
  
  p14. Employees Average Salaries
  ----------------------------------
  CREATE TEMPORARY TABLE IF NOT EXISTS empl (
  SELECT * 
   FROM employees 
    WHERE salary > 30000);
  
 DELETE  
  FROM empl 
   WHERE employee_id = 42;
  
 UPDATE empl 
  SET salary = salary + 5000
   WHERE department_id =1;
 
 SELECT department_id, AVG(salary) AS avg_salary
  FROM empl AS e
   GROUP BY e.department_id 
	 ORDER BY e.department_id ASC;
	 
  p.15. Employees Maximum Salaries 
  ----------------------------------
  SELECT department_id,MAX(salary) AS max_salary
   FROM employees AS e
    WHERE salary NOT BETWEEN 30000 AND 70000
     GROUP BY e.department_id
	   ORDER BY e.department_id;
	   
  p17. 3rd Highest Salary
  ------------------------
  SELECT e.department_id,MAX(e.salary) AS third_highest_salary FROM employees AS e
  JOIN
   (SELECT e1.department_id, MAX(e1.salary) AS second_highest_salary FROM employees AS e1
    JOIN
    (SELECT e2.department_id, MAX(e2.salary) AS first_highest_salary FROM employees AS e2
     GROUP BY e2.department_id) AS max_salaries
     ON e1.department_id = max_salaries.department_id AND e1.salary < max_salaries.first_highest_salary
   GROUP BY department_id) AS second_highest_salary
   ON e.department_id = second_highest_salary.department_id AND e.salary < second_highest_salary.second_highest_salary
   GROUP BY e.department_id;
	 
  p18. Salary Challenge
  ------------------------	  
  SELECT first_name, last_name,department_id 
   FROM employees AS e
    WHERE salary >= (SELECT AVG(salary) FROM employees AS e1
     WHERE e.department_id = e1.department_id)
    GROUP BY e.employee_id
     ORDER BY department_id
      LIMIT 10	  
	   
  p19.Departments Total Salaries
  -------------------------------
  SELECT department_id, SUM(salary) AS total_salary
 FROM employees AS e
  GROUP BY department_id
   	   
*/ 
  