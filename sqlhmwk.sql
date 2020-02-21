---------------------------------------------------------------

----- import info for employees.csv

-- Drop 

DROP TABLE employees CASCADE;



-- Create 

CREATE TABLE employees(

	emp_no INT NOT NULL,

	birth_date VARCHAR(30) NOT NULL,

	first_name VARCHAR(30) NOT NULL,

	last_name VARCHAR(30) NOT NULL,

	gender VARCHAR(30) NOT NULL,

	hire_date VARCHAR(30) NOT NULL,

	PRIMARY KEY (emp_no)

);



-- View 

SELECT * FROM employees;



-- Import data

COPY employees from '/Applications/PostgreSQL 12/Data/data_hw/employees.csv'

with (format csv, header);



-- View 

SELECT * FROM employees;



---------------------------------------------------------------

----- import info for departments.csv 

-- Drop table if exists

DROP TABLE departments CASCADE;



-- Create new table

CREATE TABLE departments (

	dept_no VARCHAR(30) NOT NULL,

	dept_name VARCHAR(30) NOT NULL,

	PRIMARY KEY (dept_no)

);



-- View table columns and datatypes

SELECT * FROM departments;



-- Import data

COPY departments from '/Applications/PostgreSQL 12/Data/data_hw/departments.csv'

with (format csv, header);



-- View table columns and datatypes

SELECT * FROM departments;

---------------------------------------------------------------

----- import info for dept_emp.csv

-- Drop 

DROP TABLE dept_emp;



-- Create 

CREATE TABLE dept_emp (

	emp_no INT NOT NULL,

	dept_no VARCHAR(30) NOT NULL,

	from_date VARCHAR(30) NOT NULL,

	to_date VARCHAR(30) NOT NULL,

	PRIMARY KEY (emp_no, dept_no),

	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),

	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)

);



-- View 

SELECT * FROM dept_emp;



-- Import data

COPY dept_emp from '/Applications/PostgreSQL 12/Data/data_hw/dept_emp.csv'

with (format csv, header);



-- View 

SELECT * FROM dept_emp;

-------------------------------------------------------------------------

----- import info for dept_manager.csv

-- Drop 

DROP TABLE dept_manager;



-- Create 

CREATE TABLE dept_manager(

	dept_no VARCHAR(30) NOT NULL,

	emp_no INT NOT NULL,

	from_date VARCHAR(30) NOT NULL,

	to_date VARCHAR(30) NOT NULL,

	PRIMARY KEY (dept_no, emp_no),

	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),

	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)

);



-- View 

SELECT * FROM dept_manager;



-- Import data

COPY dept_manager from '/Applications/PostgreSQL 12/Data/data_hw/dept_manager.csv'

with (format csv, header);



-- View 

SELECT * FROM dept_manager;

---------------------------------------------------------------

----- import info for salaries.csv

-- Drop 

DROP TABLE salaries;



-- Create 

CREATE TABLE salaries(

	emp_no INT NOT NULL,

	salary INT NOT NULL,

	from_date VARCHAR(30) NOT NULL,

	to_date VARCHAR(30) NOT NULL,

	PRIMARY KEY (emp_no),

	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)

);



-- View 

SELECT * FROM salaries;



-- Import data

COPY salaries from '/Applications/PostgreSQL 12/Data/data_hw/salaries.csv'

with (format csv, header);



-- View 

SELECT * FROM salaries;

---------------------------------------------------------------

----- import info for titles.csv

-- Drop 

DROP TABLE titles;



-- Create 

CREATE TABLE titles(

	emp_no INT NOT NULL,

	title VARCHAR(30) NOT NULL,

	from_date VARCHAR(30) NOT NULL,

	to_date VARCHAR(30) NOT NULL,

	PRIMARY KEY (emp_no, title, from_date),

	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)

);



-- View 

SELECT * FROM titles;



-- Import data

COPY titles from '/Applications/PostgreSQL 12/Data/data_hw/titles.csv'

with (format csv, header);



-- View 

SELECT * FROM titles;

---------------------------------------------------------------

-- DATA ANALYSIS 

-- 1. List the following details of each employee: employee number, 

-- last name, first name, gender, and salary.



SELECT * FROM employees;

SELECT * FROM salaries;

-- A join statement to query both tables

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary

FROM employees AS e

INNER JOIN salaries AS s

ON s.emp_no = e.emp_no;



-- 2. List employees who were hired in 1986.

SELECT * FROM employees;



SELECT hire_date FROM employees

WHERE hire_date LIKE '1986%';



-- 3. List the manager of each department with the following information: 

-- department number, department name, the manager's employee number, 

-- last name, first name, and start and end employment dates.

SELECT * FROM dept_manager; --dm

SELECT * FROM employees;  --e

SELECT * FROM departments;  --d

-- A join statement to query tables

SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date 

FROM dept_manager AS dm

JOIN departments AS d

ON d.dept_no = dm.dept_no

JOIN employees AS e

ON e.emp_no = dm.emp_no;



-- 4. List the department of each employee with the following information: 

-- employee number, last name, first name, and department name.

SELECT * FROM dept_emp; --de

SELECT * FROM employees;  --e

SELECT * FROM departments;  --d

-- A join statement to query tables

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name

FROM dept_emp AS de

JOIN departments AS d

ON d.dept_no = de.dept_no

JOIN employees AS e

ON e.emp_no = de.emp_no;



-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM employees;  --e

SELECT e.first_name, e.last_name

FROM employees AS e

WHERE e.first_name LIKE 'Hercules' 

AND e.last_name LIKE 'B%';



-- 6. List all employees in the Sales department, including their 

-- employee number, last name, first name, and department name.

SELECT * FROM dept_emp; --de

SELECT * FROM employees;  --e

SELECT * FROM departments;  --d

-- A join statement to query tables

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name

FROM dept_emp AS de

JOIN departments AS d

ON d.dept_no = de.dept_no

JOIN employees AS e

ON e.emp_no = de.emp_no

WHERE d.dept_name LIKE 'Sales';



-- 7. List all employees in the Sales and Development departments, 

-- including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name

FROM dept_emp AS de

JOIN departments AS d

ON d.dept_no = de.dept_no

JOIN employees AS e

ON e.emp_no = de.emp_no

WHERE d.dept_name LIKE 'Sales'

OR d.dept_name LIKE 'Development';



-- 8. In descending order, list the frequency count of employee last names, 

-- i.e., how many employees share each last name.

SELECT e.last_name, COUNT(e.last_name) AS eln_count

FROM employees AS e

GROUP BY e.last_name

ORDER BY eln_count DESC;



------





