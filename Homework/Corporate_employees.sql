-- Create table
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(20) NOT NULL,
	CONSTRAINT pk_departments PRIMARY KEY (dept_no)
);

-- Import data from csv file

-- View the table to confirm import results
SELECT *
From departments;

-- Create table
CREATE TABLE employees (
    emp_no INT NOT NULL,
    birth_date DATE,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    gender CHAR(1) CHECK (gender IN ('M','F')),
    hire_date DATE,
    CONSTRAINT pk_employees PRIMARY KEY (emp_no)
);

-- Import data from csv file

-- View the table to confirm import results
SELECT *
FROM employees;

-- Create table
CREATE TABLE dept_manager (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE,
    to_date DATE,
    CONSTRAINT fk_dept_manager_dept FOREIGN KEY (dept_no)
    REFERENCES departments (dept_no),
    CONSTRAINT fk_dept_manager_emp FOREIGN KEY (emp_no)
    REFERENCES employees (emp_no)
);

-- Import data from csv file


-- View the table to confirm import results
SELECT *
FROM dept_manager;

-- Create table
CREATE TABLE dept_emp (
     emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
     from_date DATE,
    to_date DATE,
    CONSTRAINT fk_dept_emp_dept FOREIGN KEY (dept_no)
        REFERENCES departments (dept_no),
    CONSTRAINT fk_dept_emp_emp FOREIGN KEY (emp_no)
        REFERENCES employees (emp_no)
);

-- Import data from csv file

--View the table to confirm import results
SELECT *
FROM dept_emp;

-- Create table
CREATE TABLE salaries (
     emp_no INT NOT NULL,
    salary INT,
    from_date DATE,
    to_date DATE,
    CONSTRAINT fk_salaries FOREIGN KEY (emp_no)
        REFERENCES employees (emp_no)
);

-- Import data from csv data

--View the table to confirm import results
SELECT *
FROM salaries;

-- Create table
CREATE TABLE titles (
     emp_no INT NOT NULL,
     title character varying(30) NOT NULL,
    from_date DATE,
    to_date DATE,
    CONSTRAINT fk_titles FOREIGN KEY (emp_no)
        REFERENCES employees (emp_no)
);

-- Import data from Csv file

--View the table to confirm import results
SELECT *
FROM titles;

---1)List the following details of each employee: employee number, last name, first name, gender, and salary.

CREATE VIEW employee_name_gender_salary AS
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON
e.emp_no = s.emp_no;

SELECT * FROM employee_name_gender_salary

---2)List employees who were hired in 1986.
CREATE VIEW employees_1986
SELECT * FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date;

---3)List the manager of each department with the following information:
---department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
CREATE VIEW department_manager AS
SELECT d.dept_no,d.dept_name, e.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM employees AS e
INNER JOIN dept_manager AS dm on
e.emp_no = dm.emp_no
INNER JOIN  departments AS d
ON dm.dept_no = d.dept_no
ORDER BY d.dept_name,e.last_name;

SELECT * FROM department_manager

--4)List the department of each employee with the following information: employee number, last name, first name, and department name.

CREATE VIEW department_employees AS
SELECT e.emp_no, e.last_name, e.first_name,d.dept_name
FROM employees AS e
INNER JOIN dept_manager AS dm on
e.emp_no = dm.emp_no
INNER JOIN  departments AS d
ON dm.dept_no = d.dept_no
ORDER BY d.dept_name,e.last_name;
--5)List all employees whose first name is "Hercules" and last names begin with "B."

CREATE VIEW hercules AS
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'
ORDER BY emp_no;


SELECT * FROM hercules

SElECT * FROM department_employees

--6)List all employees in the Sales department, including their employee number, last name, first name, and department name.
CREATE VIEW employees_sales_dept AS
SELECT e.emp_no, e.last_name, e.first_name,d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de on
e.emp_no = de.emp_no
INNER JOIN  departments AS d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

SElECT * FROM employees_sales_dept

---7)List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

CREATE VIEW employees_sales_development AS
SELECT e.emp_no, e.last_name, e.first_name,d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de on
e.emp_no = de.emp_no
INNER JOIN  departments AS d
ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development')
ORDER BY d.dept_name, e.last_name, e.emp_no;

SElECT * FROM employees_sales_development

--8)In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.


CREATE VIEW employees_freq_lastname AS
SELECT last_name, COUNT(*) how_many
FROM employees
GROUP BY last_name
ORDER BY  how_many DESC;

SELECT *FROM employees_freq_lastname



--------------- Bonus

