-- Exercises
-- Exercise Goals
-- Author: Marc Aradillas
-- Date: 06-29-2023



-- 1. Use join, left join, and right join statements on our Join Example DB

# Using join_example_db database
USE join_example_db;

# show tables
SHOW TABLES;

# selected from both users and roles tables
SELECT *
FROM roles; 

SELECT *
FROM users;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson.
-- Before you run each query, guess the expected number of results.

# INNER JOIN ex.
SELECT users.name, users.id, roles.name AS 'role name'
FROM roles
INNER JOIN users ON users.role_id = roles.id; # BE OBVIOUS/EXPLICIT

#INSTRUCTOR EX.
SELECT *
FROM users
INNER JOIN roles ON rusers.role_id = roles.id;

# LEFT JOIN ex.
SELECT users.id, email, roles.name AS 'role name'
FROM roles
LEFT JOIN users ON users.role_id = roles.id;

#INSTRUCTOR EX.
SELECT *
FROM users
LEFT JOIN roles ON rusers.role_id = roles.id;

# RIGHT JOIN ex.
SELECT users.name, email, roles.id AS rid
FROM roles
RIGHT JOIN users ON users.role_id = roles.id;

#INSTRUCTOR EX.
SELECT *
FROM users
RIGHT JOIN roles ON rusers.role_id = roles.id;

-- 3. Integrate aggregate functions and clauses into our queries with JOIN statements

/*
Use count and the appropriate join type to get a list of roles along with the number
of users that has the role. Hint: You will also need to use group by in the query.
*/

# First query
SELECT *
FROM roles, users
LIMIT 10;

SELECT users.role_id, roles.name AS role_name, COUNT(*) AS user_count # Tells us how many users are in the database grouped by role id and role name.
FROM users
INNER JOIN roles ON users.role_id = roles.id
GROUP BY users.role_id, roles.name;

# Second query
SELECT users.id, roles.name, COUNT(*) AS roles_count # Tells us how many users hold a specific role in the database grouped by name and id.
FROM roles
LEFT JOIN users ON users.role_id = roles.id
GROUP BY users.id, roles.name;

# Third query
SELECT users.name, email, COUNT(*) AS 'E-mail Count' # Tells us how many emails each user has in the database grouped by name and email.
FROM roles
RIGHT JOIN users ON users.role_id = roles.id
GROUP BY users.name, email;

#INSTRUCTOR EX.

SELECT roles.name, COUNT(*)
FROM roles
INNER JOIN users ON users.role_id = roles.id
GROUP BY roles.name;

-- Create a file named join_exercises.sql to do your work in.

# ✔️️


# WE ARE IN THE SECOND HALF NOW, WOOOOO! 06-29-2023_02:40:37 PM
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Use the employees database.

USE employees; # ✔️

SHOW TABLES;

SELECT *
FROM dept_emp
LIMIT 5;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


-- SELECT departments.dept_name AS Department_Name, 										# Failed attempt
-- 	CONCAT(employees.first_name, ' ', employees.last_name) AS Department_Manager, COUNT(*)
-- FROM employees
-- WHERE.....
-- INNER JOIN departments ON departments.dept_name = employees.first_name
-- GROUP BY Department_Name, Department_Manager;

-- SELECT d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'   # Aliases without ORDER BY (did not require group by) -- DO NOT DO THIS no pre-aliasing
-- FROM departments AS d
-- JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
-- JOIN employees AS e ON dm.emp_no = e.emp_no
-- WHERE dm.to_date = '9999-01-01'
-- ORDER BY d.dept_no ASC;

SELECT departments.dept_name AS Department_Name, 								# no alias on (departments, dept_manager, and employees)
CONCAT(employees.first_name, ' ', employees.last_name) AS Department_Manager
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date = '9999-01-01'
GROUP BY Department_Name, Department_Manager, employees.emp_no
ORDER BY Department_Name ASC;

#INSTRUCTOR EX

SELECT d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager' #Alias before setting alias
FROM employees as e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no # dept_emp ?
INNER JOIN departments AS d ON de.dept_no = d.dept_no
INNER JOIN dept_manager AS dm ON de.emp_no = dm.emp_no
WHERE dm.to_date > CURDATE()
ORDER BY d.dept_name ASC;

--   Department Name    | Department Manager
--  --------------------+--------------------
--   Customer Service   | Yuchang Weedman
--   Development        | Leon DasSarma
--   Finance            | Isamu Legleitner
--   Human Resources    | Karsten Sigstam
--   Marketing          | Vishwani Minakawa
--   Production         | Oscar Ghazalie
--   Quality Management | Dung Pesch
--   Research           | Hilary Kambil
--   Sales              | Hauke Zhang



-- 3. Find the name of all departments currently managed by women.

SELECT departments.dept_name AS 'Department Name', 
	CONCAT(employees.first_name, ' ', employees.last_name) AS 'Manager Name'   # used previous query structure added where condition and changed employee namen features as 'Manager Name'
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
WHERE employees.gender IN ('F')
	AND dept_manager.to_date = '9999-01-01'
ORDER BY departments.dept_name ASC;


#INSTRUCTOR EX

SELECT d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager' #Alias before setting alias
FROM employees as e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no # dept_emp ?
INNER JOIN departments AS d ON de.dept_no = d.dept_no
INNER JOIN dept_manager AS dm ON de.emp_no = dm.emp_no
WHERE dm.to_date > CURDATE()
AND e.gender = 'F'
ORDER BY d.dept_name ASC;


-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil



-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT titles.title, COUNT(departments.dept_name)
FROM titles
JOIN employees ON employees.emp_no = titles.emp_no
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no # joined departments table; dept_no column with dept_emp table; dept_no column
WHERE departments.dept_name IN ('Customer Service')
	AND titles.to_date = '9999-01-01' 
    AND dept_emp.to_date > CURDATE()
GROUP BY titles.title
ORDER BY titles.title ASC;

#INSTRUCTOR EX

SELECT t.title, COUNT(*) AS count
FROM employees as e
INNER JOIN dept_emp AS de ON de.emp_no = e.emp_no
INNER JOIN departments AS d ON d.dept_no = de.dept_no
INNER JOIN titles AS t ON e.emp_no = t.emp_no
WHERE t.to_date > CURDATE()
AND de.to_date > CURDATE()
AND d.dept_name = 'Customer Service'
GROUP BY t.title
ORDER BY t.title ASC;


-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241



-- 5.  Find the current salary of all current managers.

SELECT departments.dept_name AS 'Department Name', CONCAT(employees.first_name, ' ', employees.last_name) AS 'Name', salaries.salary AS 'Salary'
FROM departments
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01' # ADD filter with WHERE TO GET expected outcome
ORDER BY departments.dept_name ASC;

#INSTRUCTOR EX

SELECT d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager', s.salary AS 'Salary'
FROM employees as e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no # dept_emp ?
INNER JOIN departments AS d ON de.dept_no = d.dept_no
INNER JOIN dept_manager AS dm ON de.emp_no = dm.emp_no
INNER JOIN salaries AS s on s.emp_no = dm.emp_no
WHERE dm.to_date > CURDATE()
AND s.to_date > CURDATE()
ORDER BY d.dept_name ASC;

-- Department Name    | Name              | Salary
-- -------------------+-------------------+-------
-- Customer Service   | Yuchang Weedman   |  58745
-- Development        | Leon DasSarma     |  74510
-- Finance            | Isamu Legleitner  |  83457
-- Human Resources    | Karsten Sigstam   |  65400
-- Marketing          | Vishwani Minakawa | 106491
-- Production         | Oscar Ghazalie    |  56654
-- Quality Management | Dung Pesch        |  72876
-- Research           | Hilary Kambil     |  79393
-- Sales              | Hauke Zhang       | 101987



-- 6. Find the number of current employees in each department.

SELECT dept_emp.dept_no AS dept_no, departments.dept_name AS dept_name, COUNT(*) AS num_employees
FROM dept_emp
JOIN departments ON dept_emp.emp_no = departments.emp_no
JOIN employees ON departments.emp_no = employees.emp_no
WHERE dept_emp.to_date = '9999-01-01'
GROUP BY dept_name
ORDER BY dept_name DESC;


#INSTRUCTOR EX

SELECT d.dept_no, d.dept_name, COUNT(*) AS num_employees
FROM employees as e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no 
INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE de.to_date > CURDATE()
GROUP BY d.dept_no, d.dept_name
ORDER BY d.dept_no ASC;

-- +---------+--------------------+---------------+
-- | dept_no | dept_name          | num_employees |
-- +---------+--------------------+---------------+
-- | d001    | Marketing          | 14842         |
-- | d002    | Finance            | 12437         |
-- | d003    | Human Resources    | 12898         |
-- | d004    | Production         | 53304         |
-- | d005    | Development        | 61386         |
-- | d006    | Quality Management | 14546         |
-- | d007    | Sales              | 37701         |
-- | d008    | Research           | 15441         |
-- | d009    | Customer Service   | 17569         |
-- +---------+--------------------+---------------+



-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT departments.dept_name AS 'Department Name',
	AVG(salaries.salary) AS average_salary
FROM departments
JOIN salaries ON departments.to_date = salaries.to_date
WHERE salaries.to_date = '9999-01-01'
GROUP BY department.dept_name
ORDER BY department.dept_name DESC;

#INSTRUCTOR EX

SELECT d.dept_name, AVG(s.salary) AS average_salary
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no 
INNER JOIN departments AS d ON d.dept_no = de.dept_no
INNER JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE de.to_date > CURDATE()
AND s.to_date < CURDATE()
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;


-- +-----------+----------------+
-- | dept_name | average_salary |
-- +-----------+----------------+
-- | Sales     | 88852.9695     |
-- +-----------+----------------+


-- 8. Who is the highest paid employee in the Marketing department?

SELECT employees.first_name AS first_name, employees.last_name AS last_name
FROM employees
JOIN salaries ON salary.emp_no = employees.emp_no
JOIN department ON department.to_date = salaries.to_date
WHERE dept_name IN ('Marketing department') 
AND MAX(salaries.salary)
GROUP BY employee.first_name;
    

#INSTRUCTOR EX

SELECT e.first_name, e.last_name
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no 
INNER JOIN departments AS d ON d.dept_no = de.dept_no
INNER JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE de.to_date > CURDATE()
AND s.to_date > CURDATE()
AND d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+



-- 9.  Which current department manager has the highest salary?

SELECT employees.first_name, employees.last_name, salaries.salary, departments.dept_name
FROM salaries
JOIN departments ON salaries.to_date = departments.to_date
JOIN employees ON employees.emp_no = salaries.emp_no 
WHERE MAX(salaries.salary)
	AND dept_manager.to_date = '9999-01-01'
GROUP by first_name;


#INSTRUCTOR EX

SELECT d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager', s.salary AS 'Salary'
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no 
INNER JOIN departments AS d ON d.dept_no = de.dept_no
INNER JOIN dept_manager AS dm ON de.emp_no = dm.emp_no
INNER JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE dm.to_date > CURDATE()
AND s.to_date > CURDATE()
AND d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;

-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+



-- 10. Determine the average salary for each department. Use all salary information and round your results.

SELECT departments.dept_name AS dept_name, ROUND(AVG(salaries.salary)) AS average_salary
FROM departments
JOIN salaries ON salaries.to_date = departments.to_date
GROUP BY dept_name
ORDER BY average_salary DESC;


#INSTRUCTOR EX

SELECT d.dept_name, ROUND(AVG(s.salary)) as average_salary
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no 
INNER JOIN departments AS d ON d.dept_no = de.dept_no
INNER JOIN salaries AS s ON s.emp_no = e.emp_no
GROUP BY d.dept_name
ORDER BY average_salary DESC;


-- +--------------------+----------------+
-- | dept_name          | average_salary | 
-- +--------------------+----------------+
-- | Sales              | 80668          | 
-- +--------------------+----------------+
-- | Marketing          | 71913          |
-- +--------------------+----------------+
-- | Finance            | 70489          |
-- +--------------------+----------------+
-- | Research           | 59665          |
-- +--------------------+----------------+
-- | Production         | 59605          |
-- +--------------------+----------------+
-- | Development        | 59479          |
-- +--------------------+----------------+
-- | Customer Service   | 58770          |
-- +--------------------+----------------+
-- | Quality Management | 57251          |
-- +--------------------+----------------+
-- | Human Resources    | 55575          |
-- +--------------------+----------------+

-- 11. (BONUS!) Find the names of all current employees, their department name, and their current manager's name.

SELEC

-- 240,124 Rows

-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
--  Huan Lortz   | Customer Service | Yuchang Weedman

--  .....