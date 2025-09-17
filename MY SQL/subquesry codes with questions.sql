-- 1. Employees earning above average salary
SELECT employee_id, first_name, last_name FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. Departments with all employees earning > $7000
SELECT d.department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id AND e.salary <= 7000
);
-- 3. Employees in the same department as 'Steven King'
SELECT employee_id, first_name, last_name FROM employees WHERE department_id = (SELECT department_id FROM employees WHERE first_name = 'Steven' AND last_name = 'King');

-- 4. Employees with dependents earning more than avg salary of those without dependents
SELECT employee_id, first_name, last_name FROM employees WHERE employee_id IN (SELECT employee_id FROM dependents) AND salary > (SELECT AVG(salary) FROM employees WHERE employee_id NOT IN (SELECT employee_id FROM dependents));

-- 5. Countries with > 5 locations
SELECT country_name FROM countries WHERE country_id IN (SELECT country_id FROM locations GROUP BY country_id HAVING COUNT(*) > 5);

-- 6. Employees in 'Sales' earning > $10000
SELECT employee_id, first_name, last_name FROM employees WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Sales') AND salary > 10000;

-- 7. Employees managed by 'Steven King'
SELECT employee_id, first_name, last_name FROM employees WHERE manager_id = (SELECT employee_id FROM employees WHERE first_name = 'Steven' AND last_name = 'King');

-- 8. Departments with no employees
SELECT department_name 
FROM departments 
WHERE department_id NOT IN (SELECT department_id FROM employees);
-- 9. Highest salary earners in each department
SELECT employee_id, first_name, last_name, department_id FROM employees e1 WHERE salary = (SELECT MAX(salary) FROM employees e2 WHERE e2.department_id = e1.department_id);

-- 10. Employees with the same job as 'Alexander Hunold'
SELECT employee_id, first_name, last_name FROM employees WHERE job_id = (SELECT job_id FROM employees WHERE first_name = 'Alexander' AND last_name = 'Hunold') AND employee_id != (SELECT employee_id FROM employees WHERE first_name = 'Alexander' AND last_name = 'Hunold');

-- 11. Second highest salary
SELECT MAX(salary) FROM employees WHERE salary < (SELECT MAX(salary) FROM employees);

-- 12. Employees working in a US location
SELECT employee_id, first_name, last_name FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE location_id IN (SELECT location_id FROM locations WHERE country_id = 'US'));

-- 13. Employee with the most dependents
SELECT employee_id, first_name, last_name FROM employees WHERE employee_id = (SELECT employee_id FROM dependents GROUP BY employee_id ORDER BY COUNT(*) DESC LIMIT 1);

-- 14. Departments with > 5 employees
SELECT department_name FROM departments WHERE department_id IN (SELECT department_id FROM employees GROUP BY department_id HAVING COUNT(*) > 10);

-- 15. Employees with higher salary than their manager
SELECT employee_id, first_name, last_name FROM employees e1 WHERE salary > (SELECT salary FROM employees e2 WHERE e2.employee_id = e1.manager_id);

-- 16. Job titles with average salary > $10000
SELECT job_title FROM jobs WHERE job_id IN (SELECT job_id FROM employees GROUP BY job_id HAVING AVG(salary) > 10000);

-- 17. Countries with average salary > $8000
SELECT country_name FROM countries WHERE country_id IN (SELECT country_id FROM locations WHERE location_id IN (SELECT location_id FROM departments WHERE department_id IN (SELECT department_id FROM employees GROUP BY department_id HAVING AVG(salary) > 8000)));

-- 18. Employee working in the same city as 'Nancy Greenberg'
SELECT employee_id, first_name, last_name FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE location_id IN (SELECT location_id FROM locations WHERE city = (SELECT city FROM locations WHERE location_id IN (SELECT location_id FROM departments WHERE department_id = (SELECT department_id FROM employees WHERE first_name = 'Nancy' AND last_name = 'Greenberg')))));

-- 19. Employees with at least one child dependent
SELECT employee_id, first_name, last_name FROM employees WHERE employee_id IN (SELECT employee_id FROM dependents WHERE relationship = 'Child');

-- 20. Locations with > 2 departments
SELECT street_address, city FROM locations WHERE location_id IN (SELECT location_id FROM departments GROUP BY location_id HAVING COUNT(*) > 2);

-- 21. Employees with salary > avg salary of 'IT' department
SELECT employee_id, first_name, last_name FROM employees WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'IT'));

-- 22. Employees with a dependent named 'Jennifer'
SELECT employee_id, first_name, last_name FROM employees WHERE employee_id IN (SELECT employee_id FROM dependents WHERE first_name = 'Jennifer');

-- 23. Departments in 'Southlake'
SELECT department_name FROM departments WHERE location_id IN (SELECT location_id FROM locations WHERE city = 'Southlake');

-- 24. Employees hired after '1995-01-01'
SELECT employee_id, first_name, last_name FROM employees WHERE hire_date > '1995-01-01';

-- 25. Employees with phone numbers starting with '515'
SELECT employee_id, first_name, last_name FROM employees WHERE phone_number LIKE '515%';

-- 26. Employees with last names starting with 'K'
SELECT employee_id, first_name, last_name FROM employees WHERE last_name LIKE 'K%';

-- 27. Employees with 'Manager' in their job title
SELECT employee_id, first_name, last_name FROM employees WHERE job_id IN (SELECT job_id FROM jobs WHERE job_title LIKE '%Manager%');

-- 28. Employees in departments located in the 'US'
SELECT employee_id, first_name, last_name FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE location_id IN (SELECT location_id FROM locations WHERE country_id = 'US'));

-- 29. Employees earning > $10000 with a dependent
SELECT employee_id, first_name, last_name FROM employees WHERE salary > 10000 AND employee_id IN (SELECT employee_id FROM dependents);

-- 30. Departments with at least one employee earning > $10000
SELECT department_name FROM departments WHERE department_id IN (SELECT department_id FROM employees WHERE salary > 10000);

-- 31. Employees and their department names
SELECT employee_id, first_name, last_name, (SELECT department_name FROM departments WHERE department_id = employees.department_id) AS department_name FROM employees;

-- 32. Average salary per department
SELECT d.department_name, avg_sal FROM (SELECT department_id, AVG(salary) AS avg_sal FROM employees GROUP BY department_id) AS emp_sal JOIN departments d ON emp_sal.department_id = d.department_id;

-- 33. Employees in the same location as 'Marketing'
SELECT employee_id, first_name, last_name FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE location_id = (SELECT location_id FROM departments WHERE department_name = 'Marketing'));

-- 34. Employees with salary between min and max salary of 'Programmer' jobs
SELECT employee_id, first_name, last_name FROM employees WHERE salary BETWEEN (SELECT min_salary FROM jobs WHERE job_title = 'Programmer') AND (SELECT max_salary FROM jobs WHERE job_title = 'Programmer');

-- 35. Job titles where max salary is greater than the average salary of all employees
SELECT job_title FROM jobs WHERE max_salary > (SELECT AVG(salary) FROM employees);

-- 36. Employees working in the same country as 'Lex De Haan'
SELECT employee_id, first_name, last_name FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE location_id IN (SELECT location_id FROM locations WHERE country_id = (SELECT country_id FROM locations WHERE location_id IN (SELECT location_id FROM departments WHERE department_id = (SELECT department_id FROM employees WHERE first_name = 'Lex' AND last_name = 'De Haan')))));

-- 37. Departments where the average salary is greater than the average salary of all departments
SELECT department_name
FROM departments
WHERE department_id IN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING AVG(salary) > (SELECT AVG(salary) FROM employees)  -- Corrected subquery
);
-- 38. Employees with more than one dependent
SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM dependents d
    WHERE d.employee_id = e.employee_id
    GROUP BY d.employee_id
    HAVING COUNT(*) > 1
);
-- 39. Departments with no employees earning more than $10000
SELECT department_name FROM departments WHERE department_id NOT IN (SELECT department_id FROM employees WHERE salary > 10000);

-- 40. Employees working in the same city as their manager
SELECT e1.employee_id, e1.first_name, e1.last_name FROM employees e1 WHERE e1.department_id IN (SELECT department_id FROM departments WHERE location_id IN (SELECT location_id FROM locations WHERE city = (SELECT city FROM locations WHERE location_id IN (SELECT location_id FROM departments WHERE department_id = (SELECT department_id FROM employees e2 WHERE e2.employee_id = e1.manager_id)))));

-- 41. Employees with a dependent with the same last name
SELECT employee_id, first_name, last_name FROM employees WHERE employee_id IN (SELECT employee_id FROM dependents WHERE last_name = (SELECT last_name FROM employees WHERE employee_id = dependents.employee_id));

-- 42. Departments with at least one employee who has a dependent
SELECT department_name FROM departments WHERE department_id IN (SELECT department_id FROM employees WHERE employee_id IN (SELECT employee_id FROM dependents));

-- 43. Employees working in a location in the same region as their manager
SELECT e1.employee_id, e1.first_name, e1.last_name FROM employees e1 WHERE e1.department_id IN (SELECT department_id FROM departments WHERE location_id IN (SELECT location_id FROM locations WHERE country_id IN (SELECT country_id FROM countries WHERE region_id = (SELECT region_id FROM countries WHERE country_id IN (SELECT country_id FROM locations WHERE location_id IN (SELECT location_id FROM departments WHERE department_id = (SELECT department_id FROM employees e2 WHERE e2.employee_id = e1.manager_id)))))));

-- 44. Employees with salary within $1000 of their manager's salary
SELECT e1.employee_id, e1.first_name, e1.last_name FROM employees e1 WHERE ABS(e1.salary - (SELECT salary FROM employees e2 WHERE e2.employee_id = e1.manager_id)) <= 1000;

-- 45. Employees working in the same department as at least one employee earning > $10000
SELECT employee_id, first_name, last_name FROM employees WHERE department_id IN (SELECT department_id FROM employees WHERE salary > 10000);

-- 46. Departments where all employees have the same job
SELECT department_name FROM departments WHERE department_id IN (SELECT department_id FROM employees GROUP BY department_id HAVING COUNT(DISTINCT job_id) = 1);

-- 47. Employees with salary greater than the average salary of all employees in their country
SELECT e1.employee_id, e1.first_name, e1.last_name FROM employees e1 WHERE e1.salary > (SELECT AVG(salary) FROM employees e2 WHERE e2.department_id IN (SELECT department_id FROM departments WHERE location_id IN (SELECT location_id FROM locations WHERE country_id = (SELECT country_id FROM locations WHERE location_id IN (SELECT location_id FROM departments WHERE department_id = e1.department_id)))));

-- 48. Employees with a dependent with the same relationship as at least one other dependent
SELECT employee_id, first_name, last_name FROM employees WHERE employee_id IN (SELECT employee_id FROM dependents GROUP BY employee_id HAVING COUNT(DISTINCT relationship) < COUNT(*));

-- 49. Departments where the maximum salary is less than the minimum salary of all other departments
SELECT department_name FROM departments d1 WHERE (SELECT MAX(salary) FROM employees WHERE department_id = d1.department_id) < ALL (SELECT MIN(salary) FROM employees WHERE department_id != d1.department_id);

-- 50. Employees with salary greater than the salary of all employees who work in the same location as their manager
SELECT e1.employee_id, e1.first_name, e1.last_name FROM employees e1 WHERE e1.salary > ALL (SELECT salary FROM employees e2 WHERE e2.department_id IN (SELECT department_id FROM departments WHERE location_id = (SELECT location_id FROM departments WHERE department_id = (SELECT department_id FROM employees e3 WHERE e3.employee_id = e1.manager_id))));