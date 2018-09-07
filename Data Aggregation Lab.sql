
 p1. Departments Info
 --------------------
 SELECT department_id, COUNT(salary) AS total_salary 
  FROM employees AS e
   GROUP BY e.department_id
    ORDER BY e.department_id
 
 p2. Average Salary
 -------------------
 SELECT department_id, ROUND(AVG(salary),2) AS avg_salary
  FROM employees AS e
   GROUP BY e.department_id
    ORDER BY e.department_id
 
 p3. Minimum Salary
 -------------------
 
 SELECT department_id, MIN(salary) AS min_salary
  FROM employees AS e
   GROUP BY e.department_id
    ORDER BY e.department_id ASC
     LIMIT 1
 
 p4. Appetizers Count
 ---------------------
  SELECT COUNT(price) 
   FROM products AS p 
    WHERE p.category_id =2 AND p.price>8
  
  p5. Menu Prices 
  ---------------

   SELECT category_id, 
    ROUND(AVG(price),2) AS `Average Price`, 
     ROUND(MIN(price),2) AS `Cheapest Product`,
      ROUND(MAX(price),2) AS `Most Expensive Product`
       FROM products AS p
         GROUP BY p.category_id;




 
