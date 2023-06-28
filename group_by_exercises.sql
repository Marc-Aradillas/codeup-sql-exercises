-- Exercises
-- Exercise Goals
-- Author: Marc Aradillas
-- Date: 06-28-2023

-- # Use the GROUP BY clause to create more complex queries

-- 1. Create a new file named group_by_exercises.sql

# ✔️

USE employees;

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.

SELECT DISTINCT title
FROM titles;

# 7 unique titles

-- 3. Write a query to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE 'e%e';


-- 4. Write a query to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT first_name, last_name
FROM employees
GROUP BY first_name, last_name
HAVING last_name LIKE 'e%e';

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%';
    
					# last_name
				-- 	'Chleq'
				-- 	'Lindqvist'
				-- 	'Qiwen'


-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT COUNT(last_name)
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%';
    
					# COUNT(last_name)
				-- 	'189'
				-- 	'190'
				-- 	'168'


-- 7. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, gender, COUNT(*) AS count
FROM employees
WHERE first_name IN ( 'Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;
# you can add multiple features in GROUP BY to follow through aggregate functions.


-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username.

SELECT LOWER(
		CONCAT(
			SUBSTR(first_name, 1, 1), 
			SUBSTR(last_name, 1, 4), '_',
			SUBSTR(birth_date, 6, 2), 
            SUBSTR(birth_date, 3, 2))) AS user_name, COUNT(*)
FROM employees
GROUP BY user_name;


-- 9. From your previous query, are there any duplicate usernames? What is the higest number of times a username shows up? Bonus: How many duplicate usernames are 
-- there from your previous query?

SELECT LOWER(
		CONCAT(
			SUBSTR(first_name, 1, 1), 
			SUBSTR(last_name, 1, 4), '_',
			SUBSTR(birth_date, 6, 2), 
            SUBSTR(birth_date, 3, 2))) AS user_name, COUNT(*) AS number_usernames
FROM employees
GROUP BY user_name
HAVING number_usernames > 1
ORDER BY number_usernames DESC;

# I found that there are duplicate usernames.
# Most tines is 6
# 13251 duplicate usernames are duplicates 

-- Bonus: More practice with aggregate functions:

-- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.

select AVG(salary), COUNT(*)
FROM salaries 
GROUP BY salary;

-- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.

SELECT dept_no, COUNT(*)
FROM dept_emp
GROUP BY dept_no;

# 9 rows returned

-- Determine how many different salaries each employee has had. This includes both historic and current.



-- Find the maximum salary for each employee.



-- Find the minimum salary for each employee.

-- Find the standard deviation of salaries for each employee.

-- Now find the max salary for each employee where that max salary is greater than $150,000.

-- Find the average salary for each employee where that average salary is between $80k and $90k.