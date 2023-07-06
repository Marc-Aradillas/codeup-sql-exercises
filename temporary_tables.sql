-- Exercises
-- Author: Marc Aradillas
-- Date: 07-05-2023


-- Create a file named temporary_tables.sql to do your work for this exercise.

# ✔️

--  1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

SHOW DATABASES;
USE somerville_2273;
SHOW TABLES;
SELECT DATABASE();
USE employees;

-- Specify the db where you have permissions and add the temp table name.
-- Replace "my_database_with_permissions"" with the database name where you have appropriate permissions. It should match your username.
CREATE TEMPORARY TABLE somerville_2273.employees_with_departments AS 
SELECT * FROM employees JOIN dept_emp USING(emp_no);

DROP TABLES somerville_2273.employees_with_departments;
-- Change the current db.
USE somerville_2273;
SELECT * FROM employees_with_departments;

	-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
ALTER TABLE somerville_2273.employees_with_departments
ADD full_name VARCHAR(110);

	-- b. Update the table so that the full_name column contains the correct data.
USE somerville_2273;
SELECT * FROM somerville_2273.employees_with_departments;

UPDATE somerville_2273.employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

SELECT * FROM somerville_2273.employees_with_departments;
    
	-- c. Remove the first_name and last_name columns from the table.
    
ALTER TABLE somerville_2273.employees_with_departments
DROP COLUMN first_name, DROP COLUMN last_name;

SELECT * FROM somerville_2273.employees_with_departments;

	-- d. What is another way you could have ended up with this same table?

# An alternate way to end up with the same table employees_with_departments is to use a subquery to fetch the necessary data from the employees, dept_emp, and departments tables. 

/*
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT
	employees.first_name,
    employees.last_name,
    departments.dept_name
FROM
	(SELECT emp_no FROM dept_emp WHERE to_date = '9999-01-01') dept_emp
JOIN employees on dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no;
*/

    
--  2. Create a temporary table based on the payment table from the sakila database.
--     Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

SHOW DATABASES;
USE sakila;
SELECT DATABASE();

CREATE TEMPORARY TABLE somerville_2273.temp_payments AS
SELECT payment_id, customer_id, ROUND(amount * 100) AS amount_in_cents,payment_date
FROM payment;

SELECT * FROM somerville_2273.temp_payments;

--  3. Go back to the employees database. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. For this comparison, you will calculate the  --     z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?

USE employees;

-- Calculated the average salary and standard deviation for the entire company
SELECT AVG(salary) AS overall_average_salary, STDDEV(salary) AS overall_salary_stddev
FROM salaries
WHERE to_date >= CURDATE();

-- Calculated the average salary and z-score for each department
SELECT departments.dept_name, AVG(salaries.salary) AS department_average_salary, (AVG(salaries.salary) - overall_avg.avg_salary) / overall_avg.std_dev AS z_score
FROM salaries
INNER JOIN dept_emp on salaries.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
INNER JOIN (
  -- Subquery to get the overall average salary and standard deviation
  SELECT AVG(salary) AS avg_salary, STDDEV(salary) AS std_dev
  FROM salaries
  WHERE to_date >= CURDATE()
) overall_avg ON 1 = 1
WHERE dept_emp.to_date >= CURDATE()
GROUP BY departments.dept_name, overall_avg.avg_salary -- included the non-aggregated column
ORDER BY z_score DESC;

# Sales is best to work for
# Human Resources is the worst

---------------------------------------------------------------------------------------

# Finding and using the z-score
-- A z-score is a way to standardize data and compare a data point to the mean of the sample.

-- Notation	Description:
-- z - the z-score for a data point  
-- x - a data point. 
-- μ - the average of the sample. 
-- σ - the standard deviation of the sample

-- Hint The following code will produce the z-score for current salaries. Compare this to the formula for z-score shown above.


    -- Returns the current z-scores for each salary
    -- Notice that there are 2 separate scalar subqueries involved
    SELECT salary,
        (salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
        /
        (SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
    FROM salaries
    WHERE to_date > now();


-- *** BONUS Determine the overall historic average department average salary, the historic overall average, and the historic z-scores for salary. Do the z-scores for current department average salaries (from exercise 3) tell a similar or a different story than the historic department salary z-scores? ***
-- Hint: How should the SQL code used in exercise 3 be altered to instead use historic salary values?


# It tells us almosta similary story where sales is still top dept salary average historically, but customer service has the lowest department salary average. The historic z_scres calculated were all zeros and did not help in determining any differences to draw conclusions.


-- Calculated the historic overall average and standard deviation for salaries
SELECT AVG(salary) AS historic_overall_average_salary, STDDEV(salary) AS historic_overall_salary_stddev
FROM salaries;

-- Calculated the historic average salary and z-score for each department
WITH historic_avg AS (
  -- Subquery to calculate the historic average salary for each department
  SELECT d.dept_name, AVG(s.salary) AS historic_department_average_salary
  FROM salaries s
  -- set joins to join salaries, dept_emp, and departments tables. The historic_avg subquery retrieves the historic average salary for each department. It groups the salaries by department name. 
  INNER JOIN dept_emp de ON s.emp_no = de.emp_no
  INNER JOIN departments d ON de.dept_no = d.dept_no
  GROUP BY d.dept_name
)
SELECT
  d.dept_name,
  AVG(s.salary) AS department_average_salary,
  (AVG(s.salary) - ha.historic_department_average_salary) / historic_overall.avg_salary AS historic_z_score
FROM
  salaries s
INNER JOIN dept_emp de ON s.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
INNER JOIN historic_avg ha ON ha.dept_name = d.dept_name
INNER JOIN (
  -- Subquery to get the historic overall average salary
  SELECT AVG(salary) AS avg_salary
  FROM salaries
) historic_overall ON 1 = 1
GROUP BY d.dept_name, ha.historic_department_average_salary, historic_overall.avg_salary
ORDER BY historic_z_score DESC;