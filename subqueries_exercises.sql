-- Exercises
-- Exercise Goals
-- Author: Marc Aradillas
-- Date: 06-30-2023

# Use subqueries to find information in the employees database


/* Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria: */

# ✔️

USE employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a subquery.

# Initial query to find emp_no 101010
SELECT hire_date
FROM employees
WHERE emp_no = '101010';

# Now i will use previous as subquery to use as filter to match emp_no 101010 hire date with the restof the employees on that table.
SELECT *, CONCAT(employees.first_name, employees.last_name) AS Employees_similar_to_101010
FROM employees
WHERE hire_date = (
	SELECT hire_date
	FROM employees
	WHERE emp_no = '101010'
    )
ORDER BY emp_no DESC;



-- 2. Find all the titles ever held by all current employees with the first name Aamod.

# Initial queries
SELECT *
FROM dept_emp
WHERE to_date >= CURDATE()
AND emp_no;

SELECT *
FROM employees
WHERE first_name LIKE 'Aamod';

# Utilizing the previous querys to filter just first_name as Aamod.
SELECT DISTINCT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date >= CURDATE() AND emp_no IN (
		SELECT emp_no
		FROM employees
		WHERE first_name = 'Aamod')
);


-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

#Initial query
SELECT emp_no
FROM dept_emp
WHERE to_date < CURDATE();

#using previous query as subquery
SELECT COUNT(*) AS Previous_Employees
FROM employees
WHERE emp_no NOT IN
	(
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > CURDATE()
);
# resulted in 59900 no longer working for company

-- 4. Find all the current department managers that are female. List their names in a comment in your code.

#Initial query
SELECT emp_no
FROM dept_manager
WHERE to_date > CURDATE();

#Using previous query as subquery
SELECT CONCAT(first_name, ' ', last_name) AS Female_managers, gender
FROM employees
INNER JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
WHERE employees.emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE to_date >= CURDATE() AND gender = 'F'
);

#INSTRUCTOR EX (the subqueries lord)
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE to_date >= CURDATE()
)AND gender = 'F';

# List of current department managers that are female
/*
'Isamu Legleitner','F'
'Karsten Sigstam','F'
'Leon DasSarma','F'
'Hilary Kambil','F'
*/

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

# initial queries
SELECT emp_no
    FROM salaries
    WHERE to_date <= CURDATE()
    GROUP BY emp_no
    HAVING AVG(salary) > (

SELECT AVG(salary)
FROM salaries
WHERE to_date <= CURDATE()
);

# using previous query as subquery
SELECT CONCAT(first_name, ' ', last_name) AS 'Employee\'s salaries that are higher than companies overall, historical average salary'
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM salaries
    WHERE to_date <= CURDATE()
    GROUP BY emp_no
    HAVING AVG(salary) > (
			SELECT AVG(salary)
			FROM salaries
			WHERE to_date <= CURDATE()
	)
);

#INSTRUCTOR EX
SELECT COUNT(*) AS total
FROM salaries
WHERE salary > (
	SELECT AVG(salary)
    FROM salaries
) AND to_date > CURDATE();

#154543

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
/* 
Hint You will likely use multiple subqueries in a variety of ways

Hint It's a good practice to write out all of the small queries that you can. 
Add a comment above the query showing the number of rows returned. You will use 
this number (or the query that produced it) in other, larger queries.
*/

#MY ATTEMPT



-- BONUS -------------------------------

-- Find all the department names that currently have female managers.



-- Find the first and last name of the employee with the highest salary.



-- Find the department name that the employee with the highest salary works in.



-- Who is the highest paid employee within each department.


