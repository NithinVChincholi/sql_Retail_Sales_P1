--SQL Reatil Sales Analysis--
CREATE DATABASE sql_project_yt_1;

--create table--
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
             (
				transactions_id	INT PRIMARY KEY,
				sale_date	DATE,
				sale_time	TIME,
				customer_id	INT,
				gender	VARCHAR(15),
				age	INT,
				category	VARCHAR(20),
				quantiy	INT,
				price_per_unit FLOAT,	
				cogs	FLOAT,
				total_sale FLOAT


			)
SELECT * FROM retail_sales LIMIT 10;
SELECT COUNT(*) FROM retail_sales 
;
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE customer_id IS NULL;

SELECT * FROM retail_sales
WHERE gender IS NULL;

SELECT * FROM retail_sales
WHERE 
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

DELETE FROM retail_sales 
WHERE 
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
SELECT * FROM retail_sales WHERE NOT (retail_sales IS NOT NULL);
	
--Data Exploration

--How many sales we have?
SELECT COUNT (*) total_sale FROM retail_sales;

--How many unique coustomer we have?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;


--How many Unique Category we have?
SELECT COUNT(DISTINCT category) as total_sale FROM retail_sales

--Names of the different category we have?
SELECT DISTINCT category FROM retail_sales

--Data Analysis & Business Key Problems & Answer


-- Q.1 Write a SQL query to retrive all colums for sales made on 2022-11-05
SELECT *
FROM retail_sales
WHERE sale_date='2022-11-05'

--Q.2 Write a SQL query to retrive all the trsnsations where the category is 'Clothing' and th quantity sold is more than 10 in the month of NOv-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
 AND 
 TO_CHAR(sale_date , 'YYYY-MM') = '2022-11'
 AND 
 quantiy >=4;

 --Q.3 Write a SQL qyery to calculate the total_sales (total_sales) frp each category
 
SELECT category , SUM(total_sale) AS net_sale,
COUNT (*) as total_orders
FROM retail_sales
GROUP BY 1

--Q.4 Write a SQL query to find the average age of customer who purchased items from the beauty category

SELECT ROUND(AVG(age) , 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

--Q.5 Write a SQL query to find all transaction where the total sales is greater than 1000
SELECT * AS total_count
FROM retail_sales
WHERE total_sale > 1000;

--Q.6 Write a SQL query to find the total number of transaction made by each gendre in each category
SELECT 
	category ,
	gender, count(*) AS total_tansaction
FROM retail_sales
GROUP BY category ,
	gender
ORDER BY 1;

--Q.7 Write a SQL query to calculate the average sale for each month , find out best selling month in each year
SELECT * FROM 
(
SELECT 
	EXTRACT (YEAR FROM sale_date) as year ,
	
	EXTRACT (MONTH FROM sale_date) as month,
	AVG(total_sale) as total_sale,
	RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
FROM retail_sales
GROUP BY 1 ,2) AS t1
WHERE RANK =1

--Q.8 Write a SQL query to find the top 5 customer based on the higest total sales
SELECT 
	customer_id,
	SUM(total_sale) as total_sale
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Q.9 Write a SQL query to find the number od unique customer who purchased items from each category
SELECT COUNT(DISTINCT customer_id) as unique_customer , category
FROM retail_sales
GROUP BY 2;

--Q.10 Write a SQl query to create each shift and number of orders
WITH hourly_sale
AS
(
SELECT * ,
	CASE 
	WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'Morning'
	WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 and 17 THEN 'Afternoon'
	ELSE 'Evening'
	END AS shift
FROM retail_sales
)
SELECT shift, COUNT(*) AS total_order FROM hourly_sale
GROUP BY shift







