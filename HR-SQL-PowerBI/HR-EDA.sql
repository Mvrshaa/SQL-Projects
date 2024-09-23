-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;

-- 2. What is the race breakdown of employees in the company?
SELECT race, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY COUNT(*) DESC;

-- 3. What is the age distribution of employees in the company?
SELECT MIN(age) AS youngest, 
MAX(age) AS oldest 
FROM HR 
WHERE age >= 18 AND termdate = '0000-00-00';

-- Calculate the age of employees and group by age rangess
SELECT
 CASE
  WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
 END AS age_group,
    COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;

-- To find the age distribution by gender
SELECT
 CASE
  WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
 END AS age_group,
    gender, count(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4. How many employees work at headquarters versus remote locations?
SELECT location, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT
 round(avg(datediff(termdate, hire_date))/365, 0) AS avg_length_of_employment
FROM HR
WHERE termdate <= curdate() AND termdate != '0000-00-00' AND age >= 18;

-- 6. How does the gender distribution vary across departments?
SELECT department,gender, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department, gender;

-- 7. What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest turnover rate?
-- Calculate turnover rate as (number of terminated employees / total employees) per department
SELECT department,
 total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
FROM (
 SELECT department,
  count(*) AS total_count,
        SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= curdate()THEN 1 ELSE 0 END) AS terminated_count
 FROM hr
    WHERE age >= 18
    GROUP BY department
    ) AS dept_stats
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state, count(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

-- Distribution of All Employees
SELECT location_state, count(*) AS employee_count
FROM hr
GROUP BY location_state
ORDER BY employee_count DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT
 YEAR,
 hires,
    terminations,
    hires - terminations AS net_change,
    round((hires - terminations)/hires*100, 2) AS percent_net_change
FROM (
 SELECT YEAR(hire_date) AS YEAR,
  count(*) AS hires,
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
 FROM HR
    WHERE age >= 18
    GROUP BY year(hire_date)
    ) AS hire_metrics
ORDER BY YEAR ASC;

-- 11. What is the tenure distribution for each department?
SELECT department, round(avg(datediff(termdate, hire_date)/365), 0) AS avg_tenure
FROM hr
WHERE age >= 18 AND termdate <= curdate() AND termdate <> '0000-00-00'
GROUP BY department
ORDER BY avg_tenure DESC;

SELECT Department, round(avg(datediff(Termdate, Hire_Date)/365),0) AS avg_tenure
FROM hr
WHERE Termdate <= curdate() AND Termdate<> '0000-00-00' AND age >= 18
GROUP BY Department;

-- 12. Which department has the highest number of employees?
SELECT department,count(*) AS employee_count
FROM hr
GROUP BY department
ORDER BY employee_count DESC
LIMIT 1;



