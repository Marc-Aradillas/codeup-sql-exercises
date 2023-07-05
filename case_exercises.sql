-- Exercises
-- Exercise Goals
-- Author: Marc Aradillas	
-- Date: 07-05-2023

# Use CASE statements or IF() function to explore information in the employees database
/*  Create a file named case_exercises.sql and craft queries to return the results for the following criteria:  */

# ✔️

-- Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
USE employees;

SELECT CONCAT(first_name, ' ', last_name) AS employees, dept_no AS 'department number', from_date AS 'start date', to_date AS 'end date', 
IF(to_date >= CURDATE(), '1', '0') AS 'is_current_employee'
FROM dept_emp
JOIN employees 
	ON dept_emp.emp_no = employees.emp_no;

# NIKKI INSTRUCTOR EX.

-- SELECT CONCAT(first_name, ' ', last_name), dept_no, from_date, to_date,
-- IF(to_date > CURDATE(), true, false) AS is_current_employee
-- FROM employees
-- JOIN dept_emp ON employees.emp_no = dept_emp.emp_no;

-- Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

# used BETWEEN to go through all first letter in last names by letter range ask for from the questions
-- SELECT CONCAT(first_name, ' ', last_name) AS employee_names, 
-- 	CASE 
-- 		WHEN last_name BETWEEN 'A' AND 'H' THEN 'A-H'
-- 		WHEN last_name BETWEEN 'I' AND 'Q' THEN 'I-Q'
-- 		WHEN last_name BETWEEN 'R' AND 'Z' THEN 'R-Z'
-- 		ELSE 'beta_group'
-- 	END AS alpha_group
-- FROM employees
-- JOIN dept_emp
-- 	ON employees.emp_no = dept_emp.emp_no AND dept_emp.to_date > CURDATE();
    
    
    # added SUBSTR to last_name and set index, lenght to 1, 1 in order to capture first letter in last name for ewach range.
    SELECT CONCAT(first_name, ' ', last_name) AS employee_names, 
	CASE 
		WHEN SUBSTR(last_name, 1, 1) BETWEEN 'A' AND 'H' THEN 'A-H'
		WHEN SUBSTR(last_name, 1, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
		WHEN SUBSTR(last_name, 1, 1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
		ELSE 'beta_group'
	END AS alpha_group
FROM employees
JOIN dept_emp
	ON employees.emp_no = dept_emp.emp_no AND dept_emp.to_date > CURDATE();
    


-- How many employees (current or previous) were born in each decade?

SELECT COUNT(*) AS num_employees,
	CASE
		WHEN YEAR(birth_date) BETWEEN 1960 AND 1969 THEN '60s'
        WHEN YEAR(birth_date) BETWEEN 1950 AND 1959 THEN '50s'
        ELSE 'Too Old'
	END AS Decade_born
FROM employees
GROUP BY Decade_born;

-- SELECT birth_date
-- FROM employees; 
# checked to see birthdays in employees table


-- What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT AVG(salary) AS current_average_salary,
	CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
       WHEN dept_name = 'Customer Service' THEN 'Customer Service'
       ELSE 'Unknown'
   END AS dept_group
FROM departments
LEFT JOIN dept_emp
	ON departments.dept_no = dept_emp.dept_no
LEFT JOIN salaries
	ON dept_emp.emp_no = salaries.emp_no AND salaries.to_date > CURDATE()
GROUP BY dept_group;


----------------------------------


-- BONUS

-- Remove duplicate employees from exercise 1.

# used DISTINCT clause to filter out duplicates on the referenced column's information.

-- SELECT employees.emp_no, CONCAT(first_name, ' ', last_name) AS employees, dept_no AS 'department number', from_date AS 'start date', to_date AS 'end date', 
-- IF(to_date >= CURDATE(), '1', '0') AS 'is_current_employee'
-- FROM dept_emp
-- JOIN employees 
-- 	ON dept_emp.emp_no = employees.emp_no
-- GROUP BY employees.emp_no;

-- SELECT DISTINCT employees.emp_no, CONCAT(first_name, ' ', last_name) AS employees, dept_no AS 'department number', from_date AS 'start date', to_date AS 'end date', 
-- IF(to_date >= CURDATE(), '1', '0') AS 'is_current_employee'
-- FROM dept_emp
-- JOIN employees 
-- 	ON dept_emp.emp_no = employees.emp_no
-- GROUP BY employees.emp_no, CONCAT(first_name, ' ', last_name), dept_no, from_date, to_date, IF(to_date >= CURDATE(), '1', '0');

# added MIN and MAX functions to appropriate features to arrive to a result with no duplicates.

SELECT DISTINCT CONCAT(first_name, ' ', last_name) AS employees, MIN(dept_no) AS 'department number', MIN(from_date) AS 'start date', MAX(to_date) AS 'end date', 
IF(MAX(to_date) >= CURDATE(), '1', '0') AS 'is_current_employee'
FROM dept_emp
JOIN employees 
	ON dept_emp.emp_no = employees.emp_no
GROUP BY employees;



