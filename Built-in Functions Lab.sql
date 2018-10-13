

       01. Find Book Titles
       --------------------
SELECT title FROM books AS b
WHERE b.title LIKE 'the%';

       02. Replace Titles
       ------------------
SELECT REPLACE(title,'The','***') FROM books
  WHERE title LIKE 'the%';

       03. Sum Cost of All Books
       -------------------------
SELECT TRUNCATE(SUM(b.cost),2) FROM books AS b;

       04. Days Lived
       --------------
SELECT CONCAT(a.first_name,' ', a.last_name) Full_Name,
       TIMESTAMPDIFF(DAY,a.born,a.died) AS Days_Lived FROM authors AS a;

       05. Harry Potter Books
       -----------------------
SELECT b.title FROM books AS b
   WHERE b.title LIKE 'Harry Potter%'
   ORDER BY b.id