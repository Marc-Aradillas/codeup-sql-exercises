-- Exercises
-- Author: Marc Aradillas
-- Date: 07-05-2023


--  1. Create a file named temporary_tables.sql to do your work for this exercise.

# ✔️

--  2. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

SHOW DATABASES;

USE somerville_2273;

SHOW TABLES;

USE employees;

-- Specify the db where you have permissions and add the temp table name.
-- Replace "my_database_with_permissions"" with the database name where you have appropriate permissions. It should match your username.
CREATE TEMPORARY TABLE somerville_2273.employees_with_departments AS 
SELECT * FROM employees JOIN dept_emp USING(emp_no);

DROP TABLES somerville_2273.employees_with_departments;
-- Change the current db.
USE somerville_2273;
SELECT * FROM employees_with_salaries;

	-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
ALTER TABLE somerville_2273.employees_with_departments
ADD full_name VARCHAR(110);

	-- b. Update the table so that the full_name column contains the correct data.
USE somerville_2273;
SELECT * FROM somerville_2273.employees_with_departments;

UPDATE somerville_2273.employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name)
    
	-- c. Remove the first_name and last_name columns from the table.
    
	-- d. What is another way you could have ended up with this same table?
    
    
-- Create a temporary table based on the payment table from the sakila database.

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

-- Go back to the employees database. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?

-- Finding and using the z-score
-- A z-score is a way to standardize data and compare a data point to the mean of the sample.

-- Formula for the z-score
-- z
-- =
-- x
-- −
-- μ
-- σ

-- Notation	Description
-- z
-- the z-score for a data point
-- x
-- a data point
-- μ
-- the average of the sample
-- σ
-- the standard deviation of the sample
-- Hint The following code will produce the z-score for current salaries. Compare this to the formula for z-score shown above.


--     -- Returns the current z-scores for each salary
--     -- Notice that there are 2 separate scalar subqueries involved
--     SELECT salary,
--         (salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
--         /
--         (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
--     FROM salaries
--     WHERE to_date > now();
-- BONUS Determine the overall historic average department average salary, the historic overall average, and the historic z-scores for salary. Do the z-scores for current department average salaries (from exercise 3) tell a similar or a different story than the historic department salary z-scores?

-- Hint: How should the SQL code used in exercise 3 be altered to instead use historic salary values?