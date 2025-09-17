-- 1. Find the total salary paid in each department.
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- 2. Get the average salary for each job title.
SELECT j.job_title, AVG(e.salary) AS average_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title;

-- 3. List the number of employees in each city.
SELECT l.city, COUNT(e.employee_id) AS num_employees
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city;

-- 4. Find the maximum salary for each department.
SELECT d.department_name, MAX(e.salary) AS max_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- 5. List the total number of dependents for each employee.
SELECT e.first_name, e.last_name, COUNT(d.dependent_id) AS num_dependents
FROM employees e
LEFT JOIN dependents d ON e.employee_id = d.employee_id
GROUP BY e.employee_id;

-- 6. Get the average salary for each location.
SELECT l.city, AVG(e.salary) AS avg_salary
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city;

-- 7. Find the number of employees for each job title.
SELECT j.job_title, COUNT(e.employee_id) AS num_employees
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title;

-- 8. List the number of employees in each country.
SELECT c.country_name, COUNT(e.employee_id) AS num_employees
FROM countries c
JOIN locations l ON c.country_id = l.country_id
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY c.country_name;

-- 9. Get the total number of employees hired in each year.
SELECT YEAR(hire_date) AS hire_year, COUNT(employee_id) AS num_employees
FROM employees
GROUP BY YEAR(hire_date);

-- 10. Find the minimum salary in each job title.
SELECT j.job_title, MIN(e.salary) AS min_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title;

-- 11. List the average salary for each region.
SELECT r.region_name, AVG(e.salary) AS avg_salary
FROM regions r
JOIN countries c ON r.region_id = c.region_id
JOIN locations l ON c.country_id = l.country_id
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY r.region_name;

-- 12. Find the total salary expenditure for each job title.
SELECT j.job_title, SUM(e.salary) AS total_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title;

-- 13. Get the average salary for each department with more than 5 employees.
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 5;

-- 14. List the number of dependents for each department.
SELECT d.department_name, COUNT(d2.dependent_id) AS num_dependents
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
LEFT JOIN dependents d2 ON e.employee_id = d2.employee_id
GROUP BY d.department_name;


-- 15. Find the total salary expenditure for each job title with an average salary above $10,000.
SELECT j.job_title, SUM(e.salary) AS total_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY e.job_id
HAVING AVG(e.salary) > 10000;


-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Find the departments with a total salary expenditure greater than $50,000.
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING SUM(e.salary) > 50000;

-- 2. List the job titles where the average salary exceeds $15,000.
SELECT j.job_title, AVG(e.salary) AS avg_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title
HAVING AVG(e.salary) > 15000;

-- 3. Show the cities with a total number of employees more than 10.
SELECT l.city, COUNT(e.employee_id) AS num_employees
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city
HAVING COUNT(e.employee_id) > 10;

-- 4. Find the regions where the maximum salary is greater than $10,000.
SELECT r.region_name, MAX(e.salary) AS max_salary
FROM regions r
JOIN countries c ON r.region_id = c.region_id
JOIN locations l ON c.country_id = l.country_id
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY r.region_name
HAVING MAX(e.salary) > 10000;

-- 5. Get the departments with an average salary lower than $5,000.
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) < 5000;

-- 6. List the locations where the total salary expenditure is more than $30,000.
SELECT l.city, SUM(e.salary) AS total_salary
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city
HAVING SUM(e.salary) > 30000;

-- 7. Find the locations where there are more than 10 employees.
SELECT l.city, COUNT(e.employee_id) AS num_employees
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city
HAVING COUNT(e.employee_id) > 10;

-- 8. Show the job titles where the minimum salary is greater than $12,000.
SELECT j.job_title, MIN(e.salary) AS min_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title
HAVING MIN(e.salary) > 12000;

-- 9. Get the cities where the number of employees is less than 5.
SELECT l.city, COUNT(e.employee_id) AS num_employees
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city
HAVING COUNT(e.employee_id) < 5;

-- 10. Find the regions with an average salary higher than $5,000 and a total number of employees above 30.
SELECT r.region_name, AVG(e.salary) AS avg_salary, COUNT(e.employee_id) AS num_employees
FROM regions r
JOIN countries c ON r.region_id = c.region_id
JOIN locations l ON c.country_id = l.country_id
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY r.region_name
HAVING AVG(e.salary) > 5000 AND COUNT(e.employee_id) > 30;

-- 11. List the departments where there are more than 3 dependents.
SELECT d.department_name, COUNT(d2.dependent_id) AS num_dependents
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
LEFT JOIN dependents d2 ON e.employee_id = d2.employee_id
GROUP BY d.department_name
HAVING COUNT(d2.dependent_id) > 3;

-- 12. Show the job titles where the total salary expenditure is more than $30,000.
SELECT j.job_title, SUM(e.salary) AS total_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title
HAVING SUM(e.salary) > 30000;

-- 13. Find the locations where the average salary is greater than $5,000 and the total number of employees is over 5.
SELECT l.city, AVG(e.salary) AS avg_salary, COUNT(e.employee_id) AS num_employees
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city
HAVING AVG(e.salary) > 5000 AND COUNT(e.employee_id) > 5;

-- 14. Get the countries where the total number of employees is more than 50.
SELECT c.country_name, COUNT(e.employee_id) AS num_employees
FROM countries c
JOIN locations l ON c.country_id = l.country_id
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY c.country_name
HAVING COUNT(e.employee_id) > 5;

-- 15. Find the regions where the total salary expenditure exceeds $200,000.
SELECT r.region_name, SUM(e.salary) AS total_salary
FROM regions r
JOIN countries c ON r.region_id = c.region_id
JOIN locations l ON c.country_id = l.country_id
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY r.region_name
HAVING SUM(e.salary) > 200000;

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. List the names and salaries of employees who earn more than $10,000, ordered by salary in descending order.
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 10000
ORDER BY salary DESC;

-- 2. Find the top 5 highest salaries from the employees' table.
SELECT salary
FROM employees
ORDER BY salary DESC
LIMIT 5;

-- 3. Show the first 10 employees who were hired after January 1, 2000.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > '2000-01-01'
ORDER BY hire_date
LIMIT 10;

-- 4. Get the departments with a total salary expenditure less than $40,000, sorted by total salary in ascending order.
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING SUM(e.salary) < 40000
ORDER BY total_salary ASC;

-- 5. List the job titles where the maximum salary is greater than $20,000, ordered by job title alphabetically.
SELECT j.job_title, MAX(e.salary) AS max_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title
HAVING MAX(e.salary) > 20000
ORDER BY j.job_title;

-- 6. Find the locations where the number of employees is less than 8, sorted by city name in ascending order.
SELECT l.city, COUNT(e.employee_id) AS num_employees
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city
HAVING COUNT(e.employee_id) < 8
ORDER BY l.city;

-- 7. Retrieve the top 3 job titles with the highest average salary.
SELECT j.job_title, AVG(e.salary) AS avg_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title
ORDER BY avg_salary DESC
LIMIT 3;

-- 8. Get the details of employees who have been with the company for more than 5 years, ordered by hire date in descending order.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date < DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
ORDER BY hire_date DESC;

-- 9. List the top 10 departments by the total number of employees, from highest to lowest.
SELECT d.department_name, COUNT(e.employee_id) AS num_employees
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY num_employees DESC
LIMIT 10;

-- 10. Show the employees with salaries between $10,000 and $15,000, ordered by employee ID in ascending order.
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary BETWEEN 10000 and 15000
ORDER BY employee_id ASC;

-- 11. Find the top 5 countries with the most employees, ordered by the number of employees in descending order.
SELECT c.country_name, COUNT(e.employee_id) AS num_employees
FROM countries c
JOIN locations l ON c.country_id = l.country_id
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY c.country_name
ORDER BY num_employees DESC
LIMIT 5;

-- 12. Get the job titles where the minimum salary is greater than $15,000, ordered by minimum salary in ascending order.
SELECT j.job_title, MIN(e.salary) AS min_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_title
HAVING MIN(e.salary) > 15000
ORDER BY min_salary ASC;

-- 13. List the locations where the total salary expenditure is between $20,000 and $50,000, ordered by total salary in descending order.
SELECT l.city, SUM(e.salary) AS total_salary
FROM locations l
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY l.city
HAVING SUM(e.salary) BETWEEN 20000 AND 50000
ORDER BY total_salary DESC;

-- 14. Find the departments where the average salary is between $6,000 and $8,000, showing only the top 5 departments with the highest average salaries.
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) BETWEEN 6000 AND 8000
ORDER BY avg_salary DESC
LIMIT 5;

-- 15. Show the employees who have exactly 1 dependent, ordered by their last name in ascending order.
SELECT e.first_name, e.last_name
FROM employees e
JOIN dependents d ON e.employee_id = d.employee_id
GROUP BY e.employee_id
HAVING COUNT(d.dependent_id) = 1
ORDER BY e.last_name;

