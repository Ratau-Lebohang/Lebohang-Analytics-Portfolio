-- Exploratory Data Analysis for Retail Sales and Customer Demographics Dataset

-- 1. Temporary staging table for Backup
CREATE TABLE retail_sales
LIKE retail_sales_raw;

INSERT retail_sales
SELECT * 
FROM retail_sales_raw;

DESCRIBE retail_sales;

SELECT *
FROM retail_sales;


-- 1. Do people of different ages and genders shop differently?
SELECT Gender,
    FLOOR(Age / 10) * 10 AS Age_Group,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    SUM(Total_Amount) AS Total_Spend,
    AVG(Total_Amount) AS Avg_Spend_Per_Transaction 
FROM retail_sales
GROUP BY Gender, Age_Group
ORDER BY Age_Group, Gender;


-- 2. Are there certain times when sales go up or down?
SELECT 
  DATE_FORMAT(transaction_date, '%Y-%m') AS month,
  SUM(Total_Amount) AS total_sales,
  COUNT(DISTINCT Transaction_ID) AS total_transactions
FROM retail_sales
GROUP BY month
ORDER BY month;

ALTER TABLE retail_sales
CHANGE Date transaction_date date;

SELECT *
FROM retail_sales;



-- 3. Which product categories are the most popular?
SELECT 
    Product_Category,
    COUNT(*) AS Transactions,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(Total_Amount) AS Revenue
FROM retail_sales
GROUP BY Product_Category
ORDER BY Revenue DESC;



-- 4. Does age affect what people buy and how much they spend?
SELECT 
  FLOOR(Age / 10) * 10 AS Age_Group,
  Product_Category,
  SUM(Quantity) AS Total_Quantity,
  SUM(Total_Amount) AS Total_Spent,
  AVG(Total_Amount) AS Avg_Spent
FROM retail_sales
GROUP BY Age_Group, Product_Category
ORDER BY Age_Group, Total_Spent DESC;



-- 5. Do shopping habits change during holidays or certain times of the year?
SELECT 
    EXTRACT(MONTH FROM transaction_date) AS Sales_Month,
    Product_Category,
    SUM(Quantity) AS Units_Sold,
    SUM(Total_Amount) AS Revenue
FROM retail_sales
GROUP BY Sales_Month, Product_Category
ORDER BY Sales_Month, Revenue DESC;


-- 6. Does the number of items someone buys change how they shop?
SELECT 
    CASE 
        WHEN Quantity = 1 THEN 'Single Item'
        WHEN Quantity BETWEEN 2 AND 4 THEN 'Small Bundle'
        WHEN Quantity >= 5 THEN 'Bulk Buyer'
    END AS Purchase_Type,
    COUNT(*) AS Num_Transactions,
    AVG(Total_Amount) AS Avg_Spend
FROM retail_sales
GROUP BY Purchase_Type;



-- 7. How are product prices spread out within each category?
SELECT 
    Product_Category,
    MIN(Price_per_Unit) AS Min_Price,
    MAX(Price_per_Unit) AS Max_Price,
    AVG(Price_per_Unit) AS Avg_Price
FROM retail_sales
GROUP BY Product_Category
ORDER BY Avg_Price DESC;
