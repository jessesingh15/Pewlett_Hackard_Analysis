-- Create Retirement Titles table
SELECT emp.emp_no, emp.first_name, emp.last_name, ti.title, ti.from_date, ti.to_date 
INTO retirement_titles
FROM employees AS emp 
INNER JOIN titles AS ti
ON emp.emp_no = ti.emp_no
WHERE emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;

-- Create Unique Titles table
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

-- Create Retiring Titles table
SELECT count(emp_no),title 
INTO retiring_titles
FROM public.unique_titles
group by title
order by count(emp_no) desc;

-- Create Mentorship Eligibility table
SELECT DISTINCT ON (emp.emp_no) emp.emp_no, emp.first_name, emp.last_name, emp.birth_date, demp.from_date, demp.to_date, ti.title
INTO mentorship_eligibilty	
FROM employees AS emp 
INNER JOIN dept_emp AS demp    
ON emp.emp_no = demp.emp_no
INNER JOIN titles AS ti
ON emp.emp_no = ti.emp_no
WHERE (emp.birth_date between '1965-01-01' and '1965-12-31')
AND (demp.to_date = '9999-01-01')
ORDER BY emp.emp_no ASC, ti.to_date DESC;