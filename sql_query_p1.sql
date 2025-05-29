SELECT TOP (100) [transactions_id]
      ,[sale_date]
      ,[sale_time]
      ,[customer_id]
      ,[gender]
      ,[age]
      ,[category]
      ,[quantiy]
      ,[price_per_unit]
      ,[cogs]
      ,[total_sale]
  FROM [sql_project_p1].[dbo].[retail_sales1]
   SELECT * FROM retail_sales;
    SELECT COUNT(*) FROM retail_sales1;
	--- DATA CLEANING--
	SELECT * FROM retail_sales1
	WHERE transactions_id IS NULL;


	SELECT * FROM retail_sales1
	WHERE sale_date IS NULL;

	SELECT * FROM retail_sales1
	WHERE sale_time IS NULL;

	SELECT * FROM retail_sales1
	WHERE transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR 
	category IS NULL
	OR 
	quantiy IS NULL
	OR cogs IS NULL
	OR
	total_sale IS NULL
	---
	DELETE FROM retail_sales1
	WHERE transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	gender IS NULL
	OR 
	category IS NULL
	OR 
	quantiy IS NULL
	OR cogs IS NULL
	OR
	total_sale IS NULL

	---DATA EXPLORATION--
	--- Now how many sales we have?
select COUNT(*) As total_sales FROM retail_sales1;

-- How many unique customers we have?--
SELECT COUNT( DISTINCT customer_id) As total_customers FROM retail_sales1;

SELECT  DISTINCT category FROM retail_sales1;


--DATA analysis & Business Key problem & answers

--MY Analysis and Findings
--Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales1 WHERE sale_date='2022-11-05';

--Q2 Write a SQL query to retrieve all transaction where the category is 'Clothing' and quantity is  sold more than 10 in the month of Nov-2022?
SELECT 
 category,
 SUM(quantiy) 
 FROM retail_sales1
 Where 
 category= 'Clothing'
  AND 
  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND
  quantiy >=4

  --Write a SQL query to calculate total sales(total_sales) for each category.
  SELECT 
    category,
	SUM(total_sale) As net_sales,
	COUNT(*) AS total_orders
	FROM retail_sales1
	GROUP BY category;

	--Q4 Write a SQL query to find the average age of customers who purchased item from the 'Beauty' category.
	SELECT 
	 AVG(age) AS Avg_age
	FROM retail_sales1
	WHERE category='Beauty'


--Q5 Write a SQL query to find all transaction  where the total_sales is greater than 1000.
 SELECT * FROM retail_sales1 
 WHERE total_sale > 1000

 --Q6 Write a SQL query to find the total number of transactions(transaction_id) made by each gender in each category.
 SELECT 
 category,
 gender, 
 COUNT(*) As total_transc
 FROM retail_sales1
 GROUP BY category, gender
 ORDER BY category;

 --Q7 Write a SQl Query to calculate the average sales for each month. Find out best selling month in each year.
 SELECT 
   year, 
   month, 
   avg_sale
 FROM
   (
 SELECT 
     EXTRACT(YEAR from sale_date) As year,
     EXTRACT(MONTH from sale_date) As month, 
    
	 RANK()OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
 FROM retail_sales1
 ORder BY year, month
 ) as t1
  WHERE Rank =1;

  --Q8 Write a SQL Query to find the top 5 Customers based on the highest total sales.
  SELECT Top 5
  customer_id, 
  SUM(total_sale) As total_sales 
  FROM retail_sales1 
  GROUP BY customer_id;
  
 --Q9 Write a SQL Query to find the number of unique customers who purchased item from each category.
 SELECT 
   category,
   COUNT( DISTINCT customer_id) As count_uniq_id
   FRom retail_sales1
   GROUP BY category;

--Q10 Write a SQl query to create each shift and number of orders( Eg. Morings <-12, Afternoon Between 12 & 17, Evening > 17)
 SELECT *,
     CASE
         WHEN EXTRACT( HOUR FROM sale_time) < 12THEN 'Morning'
         When EXTRACT(HOUR From sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS shift
   FROM retail_sales1;
 
 
