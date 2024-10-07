# Retail Sales Analysis  - SQL Project

## Project Overview

**Project Title**: Retail Sales Data Analysis Using SQL

This project showcases essential SQL skills and techniques used by data analysts to explore, clean, and analyze retail sales data. Through this project, I have simulated a real-world retail scenario where raw sales data is transformed into meaningful insights to help drive business decisions. The project involves setting up a retail sales database and performing Exploratory Data Analysis (EDA). Various SQL queries are employed to clean the data, extract valuable insights, and answer specific business questions.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Project`.
- **Table Creation**: I have imported CSV data into MySQL. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount. I have modified the column names and data types as required.

```sql
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

```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT count(*) from retail;
SELECT COUNT(DISTINCT Customer_id) as total_Customer FROM retail;;
SELECT COUNT(DISTINCT Customer_id) as total_Customer FROM retail;

SELECT * FROM retail
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM retail
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM retail
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT * FROM retail
WHERE category = 'Clothing' and quantity >=4 and YEAR(sale_date) = 2022 and MONTH(sale_date) = 11;

SELECT * FROM retail
WHERE category = 'Clothing' and quantity >=4 and DATE_FORMAT(sale_date, '%m-%Y') = '11-2022';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category, SUM(total_sale) as total_sale, COUNT(*) AS total_orders FROM retail
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT category, ROUND(AVG(age),2) AS Avg_age from retail
GROUP BY category 
HAVING category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail
WHERE total_sale >=1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT gender, category, count(*) AS total_transaction FROM retail
GROUP BY gender, category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT * FROM (
SELECT YEAR(sale_date) AS YEAR, MONTH(sale_date) AS MONTH, ROUND(AVG(total_sale),2) AS avg_sale, 
	RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY ROUND(AVG(total_sale),2) DESC) AS RK
FROM retail
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY YEAR, avg_sale DESC) AS T1 
WHERE RK = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id, SUM(total_sale)  as total_sale FROM retail
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category, COUNT(DISTINCT customer_id) AS customer_count FROM retail
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

