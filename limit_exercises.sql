-- Exercises
-- Author: Marc Aradillas
-- Date: 06-27-2023

-- Exercise Goals
-- Add the LIMIT clause to our existing queries

-- 1. Create a new SQL script named limit_exercises.sql.

# ✔️

-- 2. MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, 
--    we could run the following query:
			# SELECT DISTINCT title FROM titles;
-- List the first 10 distinct last name sorted in descending order.

SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

/*
'Zykh'
'Zyda'
'Zwicker'
'Zweizig'
'Zumaque'
'Zultner'
'Zucker'
'Zuberek'
'Zschoche'
'Zongker'
*/

-- 3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting
--    your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

SELECT first_name, last_name
FROM employees
WHERE hire_date LIKE '199%' 
	AND birth_date LIKE '%12-25'
    ORDER BY hire_date
    LIMIT 5;

/*
'Alselm','Cappello'
'Utz','Mandell'
'Bouchung','Schreiter'
'Baocai','Kushner'
'Petter','Stroustrup'
*/

-- 4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update 
--    the query to find the tenth page of results.

SELECT first_name, last_name
FROM employees
WHERE hire_date LIKE '199%' 
	AND birth_date LIKE '%12-25'
    ORDER BY hire_date
    LIMIT 5 OFFSET 50;

-- 5. LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page),
--    and the page number?

# Answer response

/*
OFFSET: The OFFSET clause is used to specify the number of results to skip from the beginning of the result set. 
It determines the starting point of the data to be returned.

LIMIT: The LIMIT clause is used to limit the number of results returned in a query. It determines the maximum 
number of results to be included in the output.

Page Number: The page number represents the specific page of data that you want to retrieve from a larger result set.
It is typically an integer value that indicates which page of data you are interested in.
 
By adjusting the OFFSET and LIMIT values based on the page number and the desired number of results per page, you can
create multiple pages of data and paginate through a larger result set.
*/