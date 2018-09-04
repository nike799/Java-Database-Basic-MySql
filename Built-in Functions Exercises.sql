  Part I – Queries for SoftUni Database
  
  p01. Find Names of All Employees by First Name
  -----------------------------------------------
  SELECT first_name,last_name 
  FROM employees
  WHERE first_name LIKE('Sa%')
  ORDER BY employee_id;
  
  p02. Find Names of All Employees by Last Name
  ----------------------------------------------
  SELECT  first_name,last_name 
  FROM employees
  WHERE last_name LIKE('%ei%')
  ORDER BY employee_id
 
  po03. Find First Names of All Employess
  ----------------------------------------
  SELECT first_name
  FROM employees
  WHERE department_id IN (3,10) AND hire_date 
  BETWEEN '1995-01-01' AND '2005-12-31'
  ORDER BY employee_id;
  
  p04. Find All Employees Except Engineers
  -----------------------------------------
  SELECT first_name,last_name
  FROM employees
  WHERE job_title NOT LIKE ('%engineer%')
  ORDER BY employee_id;
  
  05. Find Towns with Name Length
  --------------------------------
  SELECT name 
  FROM towns
  WHERE LENGTH(name) BETWEEN 5 AND 6
  ORDER BY name;
  
  p06. Find Towns Starting With 
  -------------------------------
  SELECT *
  FROM towns
  WHERE (name LIKE 'm%' OR name LIKE 'k%'OR name LIKE 'b%'OR name LIKE 'e%')
  ORDER BY name
  
  
  p07. Find Towns Not Starting With
  ----------------------------------
  SELECT *
  FROM towns
  WHERE !(name LIKE 'r%' OR name LIKE 'b%'OR name LIKE 'd%')
  ORDER BY name
  
  08. Create View Employees Hired After
  --------------------------------------
  CREATE VIEW v_employees_hired_after_2000
  AS
  SELECT first_name,last_name
  FROM employees
  WHERE hire_date > '2000-12-31';
  
  p09. Length of Last Name
  -------------------------
  SELECT first_name,last_name 
  FROM employees
  WHERE  LENGTH(last_name) =5;
  
  Part II – Queries for Geography Database
  
   p10. Countries Holding 'A'
 --------------------------
 SELECT country_name,iso_code
  FROM countries
   WHERE country_name LIKE('%a%a%a%')
    ORDER BY iso_code ASC
    
 p11. Mix of Peak and River Names
 ---------------------------------
 SELECT peak_name, river_name,
  LOWER(CONCAT(peak_name,SUBSTRING(river_name,2))) AS mix
   FROM Peaks AS p, rivers AS r
    WHERE RIGHT(p.peak_name,1) = LEFT(r.river_name,1)
     ORDER BY mix
  
  Part III – Queries for Diablo Database
  
   p12. Games From 2011 and 2012 Year 
 -----------------------------------
 SELECT name, DATE_FORMAT(`start`,'%Y-%m-%d') AS `start`
  FROM games
   WHERE YEAR(`start`) >= 2011 AND YEAR(`start`) <= 2012
    ORDER BY `start` ASC
 	  LIMIT 50
	 
 p13. User Email Providers	
 --------------------------
  SELECT user_name,SUBSTRING(email,LOCATE('@',email)+1) AS `Email Provider`
   FROM users
    ORDER BY `Email Provider` ASC,user_name ASC
  
  p14. Get Users with IP Address Like Pattern
  --------------------------------------------
  SELECT user_name, ip_address 
   FROM users
    WHERE ip_address LIKE '___.1%.%.___'
     ORDER BY user_name
     
  p15. Show All Games with Duration
  ----------------------------------
   SELECT name AS game,
    CASE
    WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
    WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN HOUR(`start`) BETWEEN 18 AND 23 THEN 'Evening'
    END  AS `Part of the Day`,
    CASE
    WHEN duration BETWEEN 0 AND 3  THEN 'Extra Short'
    WHEN duration BETWEEN 4 AND 6  THEN 'Short'
    WHEN duration BETWEEN 7 AND 11 THEN 'Long'
    ELSE 'Extra Long'
    END AS `Duration`
    FROM games
    ORDER BY name; 
   
   p16. Orders Table
   -------------------
   SELECT product_name,order_date,
    DATE_ADD(order_date,INTERVAL 3 DAY) AS pay_due, 
    DATE_ADD(order_date, INTERVAL 1 MONTH) AS deliver_due
    FROM orders;
  
  

 

 
  


  
  
