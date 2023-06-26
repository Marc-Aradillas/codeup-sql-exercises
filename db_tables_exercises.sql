-- EXERCISES
-- Author: Marc Aradillas
-- Date: 06-26-2023

-- 1. Open MySQL Workbench and login to the database server

-- ✔️

-- 2. Save your work in a file named db_tables_exercises.sql

-- ✔️

-- 3. List all the databases

SHOW DATABASES;

-- 4. Write the SQL code necessary to use the albums_db database

USE albums_db;

-- 5. Show the currently selected database

SELECT database();

-- 6. List all tables in the database

SHOW TABLES;

-- 7. Write the SQL code to switch the employees database

USE employees;

-- 8. Show the currently selected database

SELECT DATABASE();

-- 9. List all the tables in the database

SHOW TABLES;

-- 10. Explore the employees table. What different data types are present on this table?


	-- varchar/string, int/number, date/number, enum/character


-- 11. Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)


	-- The dept_emp, dept_manager, employees, salaries, and titles have int values which would have a numeric type of column


-- 12. Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)


	-- variable character is a variable length string data type and char store character strings. Each table in the column have either a varchar or char datatype; string value column.
    -- ** departments, dept_emp, dept_manager, employees, titles


-- 13. Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)


	-- All the tables have date types except for the department table (dept_emp, dept_manager, employees, salaries, titles)


-- 14. What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)


	-- The tables would correlate number of employees that work in respective departments and tell how long they have been emnployed there.
    -- ** There is no direct relationship between the employees and department tables, but they do have a relationship on the dept_emp table throughout the dept_emp table.


-- 15. Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.

SHOW CREATE TABLE dept_manager;

-- **
-- CREATE TABLE `dept_manager` (
--   `emp_no` int NOT NULL,
--   `dept_no` char(4) NOT NULL,
--   `from_date` date NOT NULL,
--   `to_date` date NOT NULL,
--   PRIMARY KEY (`emp_no`,`dept_no`),
--   KEY `dept_no` (`dept_no`),
--   CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
--   CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1