-- Exercise Goals
-- Author: Marc Aradillas
-- Date: 06-27-2023

-- Use ORDER BY clauses to create more complex queries for our database

-- Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

# ✔️
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Content of previous exercise:

-- -- 1.

-- SHOW DATABASES;
-- SELECT * 
-- FROM employees
-- WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- /*
-- Top Three results:

-- #10200
-- #10397
-- #10610
-- */

-- -- 2.

-- SELECT * 
-- FROM employees
-- WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

-- /*
-- Top Three results:

-- #10200
-- #10397
-- #10610
-- */

-- # Yes they match

-- -- 3.

-- SELECT emp_no, first_name, gender
-- FROM employees
-- WHERE gender NOT LIKE ('%F%')
-- 	AND (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya'); # use force evaluation grouping using ()

-- /*
-- Top Three results:

-- #10200
-- #10397
-- #10821
-- */

-- -- 4.

-- SELECT DISTINCT last_name
-- FROM employees
-- WHERE last_name LIKE 'E%';

-- -- 5. 

-- SELECT DISTINCT last_name
-- FROM employees
-- WHERE last_name LIKE 'E%' OR last_name LIKE '%E';

-- -- 6. 

-- SELECT DISTINCT last_name
-- FROM employees
-- WHERE last_name NOT LIKE 'E%' OR last_name LIKE '%E';
-- # e%e also works

-- -- 7. 

-- SELECT DISTINCT last_name
-- FROM employees
-- WHERE last_name LIKE 'E%' AND last_name LIKE '%E'; 

-- -- 8. 

-- SELECT *
-- FROM employees
-- WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
-- # LIKE '199%' also works

-- /*
-- #10008
-- #10011
-- #10012
-- */

-- -- 9. 

-- SELECT *
-- FROM employees
-- WHERE birth_date LIKE '%-12-25';

-- /*
-- #10078
-- #10115
-- #10261
-- */
-- -- 10. 

-- SELECT *
-- FROM employees
-- WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
-- 	AND birth_date LIKE '%-12-25';

-- /*
-- #10261
-- #10438
-- #10681
-- */

-- -- 11.

-- SELECT DISTINCT last_name
-- FROM employees
-- WHERE last_name LIKE '%q%';

-- -- 12.

-- SELECT DISTINCT last_name
-- FROM employees
-- WHERE last_name LIKE '%q%'
-- 	AND last_name NOT LIKE '%qu%';

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, 
-- answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

/*
- Irena Reutenauer
- Vidya Simmen
*/

-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, 
-- answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC, last_name ASC;

/*
- Irena Acton
- Vidya Zweizig
*/

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, 
-- answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name ASC, first_name ASC;

/*
- Irena Acton
- Maya Zyda
*/

-- 4. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the
-- number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.

SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no ASC;

/*
- 899
- 10021 Ramzi Erde
- 499648 Tadahiro Erde
*/

-- 5. Write a query to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are
-- listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.

SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date DESC;

/*
- 899
- Teiji Elridge
- Sergi Erde
*/


-- 6. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a
--  comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.

SELECT *
FROM employees
WHERE hire_date LIKE '199%' 
	AND birth_date LIKE '%12-25' 
	ORDER BY birth_date ASC, hire_date DESC;

/*
- 362
- Khun Bernini
- Douadi Pettis
*/

