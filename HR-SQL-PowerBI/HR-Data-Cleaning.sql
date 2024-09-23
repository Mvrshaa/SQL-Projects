-- Create and Use Database --
CREATE DATABASE hr_project;
USE hr_project;
-- ==================================================================================
-- Explore the table and table structure
SELECT * FROM HR;

-- Check data type of all columns
DESCRIBE HR;

-- Total rows --
SELECT COUNT(*) AS total_records
FROM HR;

-- ==================================================================================
-- Data Cleaning
-- Rename id column to emp_id 
ALTER TABLE HR
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

SELECT 
    COUNT(*) AS total_records,
    SUM(CASE WHEN emp_id IS NULL THEN 1 ELSE 0 END) AS null_id,
    SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS null_first_name,
    SUM(CASE WHEN last_name IS NULL THEN 1 ELSE 0 END) AS null_last_name,
    SUM(CASE WHEN birthdate IS NULL THEN 1 ELSE 0 END) AS null_birthdate,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS null_gender,
    SUM(CASE WHEN race IS NULL THEN 1 ELSE 0 END) AS null_race,
    SUM(CASE WHEN department IS NULL THEN 1 ELSE 0 END) AS null_department,
    SUM(CASE WHEN jobtitle IS NULL THEN 1 ELSE 0 END) AS null_jobtitle,
    SUM(CASE WHEN location IS NULL THEN 1 ELSE 0 END) AS null_location,
    SUM(CASE WHEN hire_date IS NULL THEN 1 ELSE 0 END) AS null_hire_date,
    SUM(CASE WHEN termdate IS NULL THEN 1 ELSE 0 END) AS null_termdate,
    SUM(CASE WHEN location_city IS NULL THEN 1 ELSE 0 END) AS null_location_city,
    SUM(CASE WHEN location_state IS NULL THEN 1 ELSE 0 END) AS null_location_state
FROM HR;

-- ==================================================================================
-- Ensure safe updates are turned off for the update to work
 SET sql_safe_updates = 0; 

-- Convert birthdate to standard format
SELECT birthdate FROM HR;

UPDATE HR
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'), '%Y-%m-%d')
ELSE NULL
END;

-- Modify birthdate column to DATE type
ALTER TABLE HR
MODIFY COLUMN birthdate DATE;

-- Verify the update
SELECT birthdate FROM HR;

-- Date Formatting for hire_date
SELECT hire_date FROM HR;

UPDATE HR
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'), '%Y-%m-%d')
ELSE NULL
END;

ALTER TABLE HR
MODIFY COLUMN hire_date DATE;

SELECT hire_date FROM HR;

-- Handle Date Formatting for termdate
SELECT termdate FROM HR;

UPDATE HR
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

-- Changing sql_mode value
SET SQL_MODE = 'ALLOW_INVALID_DATES'; 

SELECT termdate FROM hr;

UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate = ' ';

-- Modify the column type to DATE
ALTER TABLE HR
MODIFY COLUMN termdate DATE;

-- Verify the changes
SELECT termdate FROM HR;

DESCRIBE HR;
-- ==================================================================================
-- Add and Populate age Column
ALTER TABLE HR 
ADD COLUMN age INT;

-- Update age based on birthdate
UPDATE HR
SET age = timestampdiff(YEAR, birthdate,CURDATE());

SELECT * FROM HR;

-- Verify age calculation
SELECT birthdate, age FROM HR;

-- Analyze Age
-- Find the youngest and oldest ages
SELECT MIN(age) AS youngest, 
MAX(age) AS oldest  
FROM HR;

-- Count records where age is less than 18
SELECT COUNT(*) 
FROM HR 
WHERE age < 18;

-- Count the frequency of gender
SELECT count(distinct gender) AS gender_count
FROM HR;
 
-- Count records where termdate is in the future
SELECT COUNT(*) AS future_termdate
FROM HR
WHERE termdate > CURDATE();

-- Number of employees currently working
SELECT COUNT(*) FROM HR WHERE termdate = '0000-00-00';

-- Check location data
SELECT location FROM HR;

SELECT DISTINCT location
FROM HR;

-- Check for duplicates
SELECT emp_id, COUNT(*) AS Duplicates
FROM HR
GROUP BY emp_id
HAVING COUNT(*) > 1;

-- Check records with future dates
SELECT * FROM HR
WHERE birthdate > CURDATE() OR hire_date > CURDATE();

-- All records by gender
SELECT gender, COUNT(*) AS count
FROM HR
GROUP BY gender;
-- DROP TABLE IF EXISTS hr;

-- Count the frequency of race
SELECT count(distinct race) AS race_count
FROM hr;

-- What is the average age of employees?
SELECT round(avg(age)) AS avg_age
FROM hr;

 SET sql_safe_updates = 1;