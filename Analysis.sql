﻿-- Question 1: Total Sales and Profit by Category.
SELECT Category,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Category
ORDER BY TotalSales DESC;


-- Question 2: Top 5 Customers by Total Profit.
SELECT TOP 5 Customer_Name,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Customer_Name
ORDER BY TotalProfit DESC;


-- Question 3: Monthly Sales Trend.
SELECT
    FORMAT(Order_Date, 'yyyy-MM') AS OrderMonth,
    SUM(Sales) AS TotalSales
FROM Superstore
GROUP BY FORMAT(Order_Date, 'yyyy-MM')
ORDER BY OrderMonth;


-- Question 4: Profit by Region.
SELECT Region,
    SUM(Profit) AS TotalProfit
FROM Superstore
GROUP BY Region
ORDER BY TotalProfit DESC;


-- Question 5: Top 5 Products by Quantity Sold.
SELECT TOP 5  Product_Name,
    SUM(Quantity) AS TotalQuantitySold
FROM Superstore
GROUP BY Product_Name
ORDER BY TotalQuantitySold DESC;


-- Question 6: Find the top 5 customers with the highest total sales.
SELECT TOP 5 Customer_Name,
    SUM(Sales) AS TotalSales
FROM   Superstore
GROUP BY Customer_Name
ORDER BY TotalSales DESC;


-- Question 7: Monthly Sales Trend.
SELECT 
    FORMAT(Order_Date, 'yyyy-MM') AS Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY FORMAT(Order_Date, 'yyyy-MM')
ORDER BY Month;


-- Question 8: YoY Growth in Sales.
SELECT 
    YEAR(Order_Date) AS Year,
    SUM(Sales) AS Total_Sales,
    LAG(SUM(Sales)) OVER (ORDER BY YEAR(Order_Date)) AS Prev_Year_Sales,
    (SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY YEAR(Order_Date))) * 100.0 
        / LAG(SUM(Sales)) OVER (ORDER BY YEAR(Order_Date)) AS YoY_Growth_Percent
FROM Superstore
GROUP BY YEAR(Order_Date)
ORDER BY Year;


-- Question 9: Top 5 Profitable Products.
SELECT TOP 5 Product_Name, SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY Product_Name
ORDER BY Total_Profit DESC;


-- Question 10: Loss-Making Products (High Sales but Negative Profit).
SELECT Product_Name, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY Product_Name
HAVING SUM(Sales) > 10000 AND SUM(Profit) < 0
ORDER BY Total_Profit ASC;


-- Question 11:Regional Performance with Ranking.
SELECT 
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    RANK() OVER (ORDER BY SUM(Profit) DESC) AS Profit_Rank
FROM Superstore
GROUP BY Region;


--Question 12: Customer Segmentation (High Value vs Low Value).
SELECT 
    Customer_Name,
    SUM(Sales) AS Total_Sales,
    CASE 
        WHEN SUM(Sales) > 5000 THEN 'High Value'
        ELSE 'Low Value'
    END AS Customer_Type
FROM Superstore
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;



--Question 13: Shipping Speed Impact on Profit.
SELECT Ship_Mode, 
       AVG(DATEDIFF(DAY, Order_Date, Ship_Date)) AS Avg_Delivery_Days,
       SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY Ship_Mode;



--Question 14: Top 3 Customers in Each Region
WITH RankedCustomers AS (
    SELECT 
        Region,
        Customer_Name,
        SUM(Sales) AS Total_Sales,
        RANK() OVER (PARTITION BY Region ORDER BY SUM(Sales) DESC) AS RankNo
    FROM Superstore
    GROUP BY Region, Customer_Name
)
SELECT Region, Customer_Name, Total_Sales
FROM RankedCustomers
WHERE RankNo <= 3;


--Question 15: Second Highest Sales per Region.
SELECT Region, Sales
FROM (
    SELECT Region, Sales,
           DENSE_RANK() OVER (PARTITION BY Region ORDER BY Sales DESC) AS rnk
    FROM Superstore
) t
WHERE rnk = 2;


--Question 16: Second Highest Product by Total Sales.
SELECT Product_Name, SUM(Sales) AS Total_Sales
FROM Superstore
GROUP BY Product_Name
ORDER BY Total_Sales DESC
OFFSET 1 ROW FETCH NEXT 1 ROW ONLY;







/*
Step 7: README.md Likhe
# Superstore SQL Server Project

## Overview
Analyzing Superstore dataset using SQL Server to explore sales, profit, and trends.

## Dataset
Superstore.csv (Kaggle open dataset)

## Steps to Run
1. Run `sql/schema.sql` in SQL Server.
2. Import data (`Superstore.csv`) using Import Wizard or `sql/load_data.sql`.
3. Run queries from `sql/analysis_queries.sql`.

## Sample Output
- Top 10 Customers by Profit  

![Profit Screenshot](images/top_customers.png)
*/

/*📝 README.md (for GitHub)

Your README.md should look like this:

# 🛍 Retail Sales SQL Case Study

## 📌 Overview
This project analyzes an **Online Retail Store dataset** using SQL.  
The goal is to showcase SQL skills by solving real-world business problems such as:
- Customer analysis
- Product performance
- Sales trends
- Retention metrics

## 📂 Project Files
- `schema.sql` → Database schema (tables)
- `data.sql` → Sample dataset
- `queries.sql` → Analysis queries
- `insights.md` → Final business insights
- `screenshots/` → (Optional) query outputs

## 📊 Insights
1. **Electronics generated the highest revenue.**
2. **Rahul Gupta is the top customer with total spend of ₹34,000+.**
3. **Repeat customers account for 40% of sales.**
4. **Sales grew 20% month-on-month between June and July 2022.**

## 🚀 Skills Demonstrated
- SQL Joins, Group By, Aggregations
- Window Functions (RANK, ROW_NUMBER)
- Business Intelligence queries
- Data Modeling

## 📎 How to Run
1. Create a database in MySQL/PostgreSQL/SQL Server
2. Run `schema.sql` and `data.sql`
3. Execute queries from `queries.sql`*/

