-- 1.List of Employees by department
-- Question: Write a query to list all employees along with their respective department names . Include employee number, first name, last name, department number and department name.
select e.emp_no, e.first_name, e.last_name, d.dept_name, d.dept_no 
from employees as e 
join dept_emp as de
ON e.emp_no = de.emp_no
join departments as d 
ON d.dept_no = de.dept_no;

-- 2. current and past salary of an employee
-- question: write a query to retrieve all the salary record of an given employee (by employee number) Include employee number, salary, from_date, to_date.
select * from salaries
where emp_no = '10001'
order by salary desc
limit 1;

-- 3. Employee with specific titles
-- Question : write a query to find all employees who have held a specific title (eg.'Engineer') Include employee number, first name, last name, and title
select e.emp_no, first_name, last_name, title from employees as e
join titles as t ON
t.emp_no = e.emp_no
where t.title = 'Engineer'

-- 4. Department with their manager
-- Question: Write a query to list all departments along with their current managers. Include department number, department name, manager's employee number, first name, last name
Select d.dept_no, d.dept_name, e.emp_no, e.first_name, e.last_name 
from departments as d join dept_emp as de
ON d.dept_no = de.dept_no
join employees as e ON
e.emp_no = de.emp_no

-- 5.Employee count by Department
-- Question: Write a query to count the number of employees in each department. Include department number, department name, and employee count
select d.dept_no, dept_name, count(de.emp_no) as emp_count from departments as d
join dept_emp as de ON
de.dept_no = d.dept_no
group by dept_name, dept_no

-- 6. Employee Birthdate in a given year
-- Question : write a query to find all employees born in a specific year(e.g 1953). Include employee number, first name, last name, and birth date
SELECT emp_no, first_name, last_name, birth_date FROM employees
where year(birth_date) = 1953  

-- 7. Employee hired in the Last 5 years 
-- Question write a query to find all employees hired in the last 50 year. Inlcude employee number, first name ,last name, hired date
select emp_no, first_name, last_name, hire_date from employees
WHERE hire_date >= date_sub(curdate(), interval 50 YEAR);

-- 8.Average salary by department
-- write a query to calculate the average salary for each department. Include deaprtment name , department number, average salary
select d.dept_no, d.dept_name, avg(s.salary) as avg_salary from departments as d
join dept_emp as de ON
d.dept_no = de.dept_no
join salaries as s ON
s.emp_no = de.emp_no
group by d.dept_no, d.dept_name

-- 9.Gender Distribution in each department
-- Question: write a query to find the gender distribution (number of males and females) in each deparment. Include department number, department name, count of males, coun of females.
select d.dept_no, d.dept_name,
SUM(CASE when e.gender = 'M' THEN 1 ELSE 0 END ) AS male_count,
SUM(CASE when e.gender = 'F' THEN 1 ELSE 0 END ) AS female_count
from departments as d join dept_emp as de ON
d.dept_no = de.dept_no
join employees as e ON e.emp_no = de.emp_no 
group by d.dept_no, d.dept_name

-- 10. Longest Serving Employees
-- Question: write a query to find the employees who have served the longest in the country. Include employee number, first name, last name and number of years served
select emp_no, first_name, last_name,
timestampdiff(YEAR,hire_date, curdate()) as year_served
from employees
order by year_served desc
limit 1
