create database project;

use project;

select * from retail;

ALTER TABLE retail
ADD PRIMARY KEY (transactions_id);

ALTER TABLE retail
MODIFY price_per_unit float;

ALTER TABLE retail
MODIFY cogs float;

ALTER TABLE retail
MODIFY total_sale float;

ALTER TABLE retail
CHANGE ï»¿transactions_id transactions_id INT;

ALTER TABLE retail
CHANGE quantiy quantity INT;

DESCRIBE retail;
select * from retail;

select count(*) from retail;

select * from retail
where transactions_id is null
    or 
    sale_date is null
    or 
    sale_time is null
    or 
    customer_id is null
    or
    gender is null 
    or 
    age is null
    or 
    category is null
    or
    quantity is null
    or 
    price_per_unit is null
    or 
    cogs is null
    or 
    total_sale is null;
    
SET SQL_SAFE_UPDATES = 0;

Delete from retail
where transactions_id is null
    or 
    sale_date is null
    or 
    sale_time is null
    or 
    customer_id is null
    or
    gender is null 
    or 
    age is null
    or 
    category is null
    or
    quantity is null
    or 
    price_per_unit is null
    or 
    cogs is null
    or 
    total_sale is null;

select count(*) from retail;
 # Data Exploration
 #How many sales we have?
 SELECT COUNT(*) as total_sale FROM retail;
 
 #How many unique customers we have?
 SELECT COUNT(DISTINCT Customer_id) as total_Customer FROM retail;

#How many unique category we have?
SELECT DISTINCT category as total_category FROM retail;

# Data Analysis & Bussiness key problems & Answer
# Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail
WHERE sale_date = '2022-11-05';

#Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail
WHERE category = 'Clothing' and quantity >=4 and YEAR(sale_date) = 2022 and MONTH(sale_date) = 11;

SELECT * FROM retail
WHERE category = 'Clothing' and quantity >=4 and DATE_FORMAT(sale_date, '%m-%Y') = '11-2022';

#Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category, SUM(total_sale) as total_sale, COUNT(*) AS total_orders FROM retail
GROUP BY category;

#Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select category, ROUND(AVG(age),2) AS Avg_age from retail
GROUP BY category 
HAVING category = 'Beauty';

#Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM retail
WHERE total_sale >=1000;

#Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT gender, category, count(*) AS total_transaction FROM retail
GROUP BY gender, category;

#Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT * FROM (
SELECT YEAR(sale_date) AS YEAR, MONTH(sale_date) AS MONTH, ROUND(AVG(total_sale),2) AS avg_sale, 
	RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY ROUND(AVG(total_sale),2) DESC) AS RK
FROM retail
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY YEAR, avg_sale DESC) AS T1 
WHERE RK = 1;

#Write a SQL query to find the top 5 customers based on the highest total sales:
SELECT customer_id, SUM(total_sale)  as total_sale FROM retail
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

#Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category, COUNT(DISTINCT customer_id) AS customer_count FROM retail
GROUP BY category;

#Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH CTE AS (
SELECT *,
	CASE 
		WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS shifts
FROM retail
)
SELECT shifts, COUNT(*) AS number_of_orders FROM CTE
GROUP BY shifts;




























































