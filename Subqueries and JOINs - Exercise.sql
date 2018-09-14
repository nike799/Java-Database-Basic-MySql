
   p01. Employee Address
   ---------------------
   SELECT employee_id, job_title, e.address_id, address_text FROM employees As e
   JOIN addresses a ON e.address_id = a.address_id
   ORDER BY e.address_id
   LIMIT 5;

   p02.	Addresses with Towns
   --------------------------
   SELECT first_name	,last_name,	t.name AS town,	a.address_text FROM employees AS e
   JOIN
   addresses AS a ON e.address_id = a.address_id
   JOIN towns t on a.town_id = t.town_id
   ORDER BY e.first_name ASC,e.last_name ASC
   LIMIT 5;

   p.03. Sales Employee
   ---------------------
   SELECT e.employee_id,	e.first_name,	e.last_name,	d.name AS department_name
    FROM employees AS e
    JOIN departments AS d ON e.department_id = d.department_id
    WHERE  d.name = 'Sales'
    ORDER BY e.employee_id DESC;

   p04.	Employee Departments
   -------------------------
   SELECT  e.employee_id, e.first_name, e.salary, d.name AS	 department_name FROM employees AS e
    JOIN departments d ON e.department_id = d.department_id
    WHERE e.salary > 15000
    ORDER BY d.department_id DESC
    LIMIT 5;

   p05.	Employees Without Project
   -------------------------------
   SELECT e.employee_id, first_name FROM employees AS e
   LEFT JOIN employees_projects e2 on e.employee_id = e2.employee_id
   WHERE project_id IS NULL
   ORDER BY e.employee_id DESC
   LIMIT 3;

   p06. Employees Hired After
   ---------------------------
   SELECT e.first_name,	e.last_name,	e.hire_date, d.name AS 	dept_name FROM employees AS e
    LEFT  JOIN departments AS d ON (e.department_id = d.department_id)
    WHERE (e.hire_date >= '1999-01-02') AND (d.name = 'Sales' OR d.name = 'Finance')
    ORDER BY e.hire_date ASC;
   
   p07.	Employees with Project
   ----------------------------
   SELECT e.employee_id,	e.first_name,	p.name FROM employees AS e
    JOIN employees_projects ep ON e.employee_id = ep.employee_id
    JOIN projects p ON ep.project_id = p.project_id
    WHERE p.start_date >= '2002-08-14' AND p.end_date IS NULL
    ORDER BY e.first_name,p.name ASC
    LIMIT 5;

   p08.	Employee 24
   ----------------
   SELECT e.employee_id,	e.first_name, IF(p.start_date >= '2005-01-01',p.name = NULL,p.name) AS project_name
    FROM employees AS e
    JOIN employees_projects ep ON e.employee_id = ep.employee_id
    JOIN projects p ON ep.project_id = p.project_id
    WHERE e.employee_id = 24
    ORDER BY project_name ASC;

   p09.	Employee Manager
   ----------------------
   SELECT e.employee_id,
       e.first_name,
       e.manager_id,
       IF(e2.employee_id = 7 OR e2.employee_id = 3, e2.first_name, NULL) AS manager_name
   FROM employees As e
       JOIN employees AS e2 ON e.manager_id = e2.employee_id
   WHERE e.manager_id = 3 OR e.manager_id = 7
   ORDER BY e.first_name;

   p10.	Employee Summary
   ----------------------
   SELECT e.employee_id,
       CONCAT(e.first_name,' ',e.last_name)   AS employee_name,
       CONCAT(e1.first_name,' ',e1.last_name) AS manager_name,
       d.name                                 AS department_name
     FROM employees AS e
       JOIN employees AS e1 ON e.manager_id = e1.employee_id
       JOIN departments AS d ON e.department_id = d.department_id
     ORDER BY employee_id
     LIMIT 5;

   p11.	Min Average Salary
   -----------------------
   SELECT AVG(salary) AS min_average_salary FROM employees AS e
    GROUP BY e.department_id
    ORDER BY salary
    LIMIT 1;

   p12.	Highest Peaks in Bulgaria
   --------------------------------
   SELECT c.country_code, m.mountain_range, p.peak_name, p.elevation
    FROM countries AS c
       JOIN mountains_countries AS mc ON c.country_code = mc.country_code
       JOIN mountains m on mc.mountain_id = m.id
       JOIN peaks p on m.id = p.mountain_id
    WHERE p.elevation > 2835 AND c.country_code = 'BG'
    ORDER BY p.elevation DESC;

   p13.	Count Mountain Ranges
   ----------------------------
   SELECT c.country_code	, COUNT(mc.country_code ) AS mountain_range
    FROM countries AS c
    JOIN mountains_countries mc on c.country_code = mc.country_code
    WHERE mc.country_code IN ('US','BG','RU')
    GROUP BY c.country_code
    ORDER BY mountain_range DESC;

   p14. Countries with Rivers
   ---------------------------
   SELECT c.country_name, r.river_name
   FROM countries AS c
       LEFT JOIN countries_rivers AS cr ON cr.country_code = c.country_code
       LEFT JOIN rivers AS r ON r.id = cr.river_id
       JOIN continents cont on c.continent_code = cont.continent_code
   WHERE cont.continent_name = 'Africa'
   ORDER BY c.country_name ASC
   LIMIT 5;

   p15.	*Continents and Currencies
   --------------------------------
   SELECT c.continent_code, c.currency_code, COUNT(c.country_name) AS currency_usage
   FROM countries AS c
   GROUP BY  continent_code,currency_code
   HAVING currency_usage = (SELECT COUNT(c1.country_code) AS currency_usage1
                         FROM countries AS c1
                         WHERE c1.continent_code = c.continent_code
                         GROUP BY currency_code
                         ORDER BY currency_usage1 DESC
                         LIMIT 1
                        ) AND currency_usage > 1
   ORDER BY continent_code, currency_code ASC;

   p16.	Countries without any Mountains
   -------------------------------------
   SELECT COUNT(c.country_name) AS country_count FROM countries AS c
        LEFT JOIN mountains_countries AS mc ON mc.country_code = c.country_code
        LEFT JOIN mountains m on mc.mountain_id = m.id
   WHERE m.mountain_range IS NULL;

   p17.	Highest Peak and Longest River by Country
   ----------------------------------------------

   SELECT c.country_name, MAX(p.elevation) AS highest_peak_elevation, MAX(r.length) AS longest_river_length
   FROM countries AS c
        JOIN countries_rivers cr on c.country_code = cr.country_code
        JOIN rivers r ON cr.river_id = r.id
        JOIN mountains_countries AS mc ON c.country_code = mc.country_code
        JOIN mountains m ON mc.mountain_id = m.id
        JOIN peaks p ON m.id = p.mountain_id
   GROUP BY country_name
   ORDER BY highest_peak_elevation DESC, longest_river_length DESC, c.country_name ASC
   LIMIT 5;










