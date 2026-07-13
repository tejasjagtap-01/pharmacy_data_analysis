-- 1. Create Product Dimension Table
CREATE TABLE DimProduct(
ProductId VARCHAR(50) PRIMARY KEY
);


-- 2. Create Date Dimension Table
CREATE TABLE DimDate(
DateKey INT PRIMARY KEY,
Date DATE,
DayName VARCHAR(15),
MonthName VARCHAR(15),
Quarter VARCHAR(5),
Year INT
)


-- 3. Create Fact Sales Table
CREATE TABLE FactSales(
SalesID VARCHAR(50) PRIMARY KEY,
DateKey INT REFERENCES DimDate(DateKey),
PharmacyID VARCHAR(50),
ProductID VARCHAR(50) REFERENCES DimProduct(ProductID),
UnitsSold INT,
RevenueEUR NUMERIC(10,2),
CostEUR NUMERIC(10,2),
MarginEUR NUMERIC(10,2),
PromoFlag VARCHAR(10)
)

-- 1. Clear out the old tables
DROP TABLE IF EXISTS FactSales;

SELECT * FROM factsales
LIMIT 10

SELECT * FROM dimdate
LIMIT 10

SELECT * FROM dimproduct
LIMIT 10




-- Business Queires And Solutions 

-- Q1. What is the total number of units (UnitsSold) the pharmacy has sold across the entire dataset?
SELECT 
	SUM(unitssold) AS Total_UnitsSold
FROM factsales


-- Q2. How many total customer transactions (SalesID) are recorded in our history?
SELECT 
	COUNT(salesid) AS Total_transactions
FROM factsales


-- Q3. How many unique products does the pharmacy actually stock in its registry?
SELECT 
	DISTINCT COUNT(*) Unique_Product
FROM dimproduct


-- Q4. List the details of the transactions where the revenue generated from a single sale was greater than €500.
SELECT
	salesid,
	productid,
	unitssold,
	revenueeur
FROM factsales
WHERE revenueeur > 500
ORDER BY revenueeur DESC


-- Q5. What is the total revenue and profit generated specifically by pharmacy branch 'PH0002'?
SELECT
	ROUND(SUM(revenueeur),0) AS total_revenue,
	ROUND(SUM(margineur),0) AS total_profit
FROM factsales
WHERE pharmacyid = 'PH0002'
GROUP BY pharmacyid


-- Q6. The Revenue Drivers: Which products are our top 5 absolute revenue drivers, and what is their actual profit margin percentage?
SELECT
	productid,
	SUM(unitssold) AS total_unit_sold,
	ROUND(SUM(revenueeur),0) AS total_revenue,
	ROUND(SUM(margineur),0) AS total_profit,
	ROUND((SUM(margineur) / NULLIF(SUM(revenueeur),0))* 100, 2) AS profit_margin_pct
FROM factsales
GROUP BY productid
ORDER BY total_revenue DESC


-- Q7. The Dead Weight: Which products have the lowest turnover? Show the top 10 items that have generated the least amount of total profit (MarginEUR).
SELECT
	productid,
	SUM(unitssold) AS total_unit_sold,
	ROUND(SUM(revenueeur),0) AS total_revenue,
	ROUND(SUM(margineur),0) AS total_profit
FROM factsales
GROUP BY productid
ORDER BY total_profit ASC
LIMIT 10


-- Q8. Peak Day Traffic: Which days of the week experience the highest volume of individual transactions (SalesID)?
SELECT 
	d.dayname,
	COUNT(f.salesid) AS total_transactions,
	SUM(f.unitssold) AS total_unit_sold
FROM factsales f
INNER JOIN dimdate d ON f.datekey = d.datekey
GROUP BY d.dayname
ORDER BY total_transactions DESC


-- Q9. Promotion Efficiency: Do promotional discounts (PromoFlag = 'Yes') drive significantly higher volumes and profits, or do they bleed margins compared to non-promo days?
SELECT 
	promoflag,
	COUNT(salesid) AS total_orders,
	ROUND(AVG(unitssold),2) AS avg_unit_per_order,
	ROUND(AVG(revenueeur),2) AS avg_revenue_per_order,
	ROUND((SUM(margineur) / NULLIF(SUM(revenueeur),0 )) * 100, 2) AS overall_margin
FROM factsales
GROUP BY promoflag


-- Q10. Seasonality Trends: How do our sales fluctuate month-over-month? Which months represent our peak seasons, and when do we hit a seasonal slump?
SELECT
	d.year,
	d.monthname,
	ROUND(SUM(f.revenueeur),2) AS monthly_revenue,
	ROUND(SUM(f.margineur),2) AS monthly_profit
FROM factsales f
INNER JOIN dimdate d ON f.datekey = d.datekey
GROUP BY d.year, d.monthname
ORDER BY d.year DESC, MIN(d.date) ASC


-- Q11. Low-Margin High-Volume Risk: Are there any products that we are selling in massive quantities (e.g., UnitsSold > 500) but making almost zero profit on (margin percentage under 5%)?
SELECT 
    ProductID,
    SUM(UnitsSold) AS Total_Units_Sold,
    ROUND(SUM(RevenueEUR), 2) AS Total_Revenue,
    ROUND((SUM(MarginEUR) / NULLIF(SUM(RevenueEUR), 0)) * 100, 2) AS Margin_Pct
FROM FactSales
GROUP BY ProductID
HAVING SUM(UnitsSold) > 500 
   AND (SUM(MarginEUR) / NULLIF(SUM(RevenueEUR), 0)) * 100 < 5.0
ORDER BY Total_Units_Sold DESC;


-- Q12. Quarter-over-Quarter Growth: What does our financial performance look like on a quarterly basis? Are we scaling up over time?
SELECT
	d.year,
	d.quarter,
	ROUND(SUM(f.revenueeur),2) AS quarterly_revenue,
	ROUND(SUM(f.margineur),2) AS quarterly_result
FROM factsales f
INNER JOIN dimdate d ON f.datekey = d.datekey
GROUP BY d.year, d.quarter
ORDER BY d.year ASC, d.quarter ASC


-- Q13. High-Value Transactions: What do our top 10 largest single sales (RevenueEUR) look like, and what products are driving these massive single orders?
SELECT 
	salesid,
	productid,
	unitssold,
	ROUND(revenueeur,2) AS transaction_value,
	ROUND(margineur,2) AS profit_earned
FROM factsales
ORDER BY revenueeur DESC
LIMIT 10


-- Q14. Multi-Branch Performance: Which pharmacy branches (PharmacyID) are running the most efficiently (highest total profit) vs. those trailing behind?
SELECT
	pharmacyid,
	COUNT(salesid) AS total_orders,
	SUM(unitssold) AS total_units,
	ROUND(SUM(revenueeur),2) AS total_revenue,
	ROUND(SUM(margineur),2) AS total_profit
FROM factsales
GROUP BY pharmacyid
ORDER BY total_profit DESC
LIMIT 10


-- Q15. Weekend vs. Weekday Behaviors: Do consumer shopping patterns fundamentally change on weekends (Saturday, Sunday) in terms of average transaction value?
SELECT
	CASE 
		WHEN d.dayname IN ('Saturday','Sunday') THEN 'WeekEnd'
		ELSE 'WeekDay'
	END AS day_type,
	COUNT(f.salesid) AS total_transaction,
	ROUND(AVG(f.revenueeur),2) AS avg_transaction_value,
	ROUND(SUM(f.margineur),2) AS total_net_profit
FROM factsales f
INNER JOIN dimdate d ON f.datekey = d.datekey
GROUP BY
	CASE 
		WHEN d.dayname IN ('Saturday','Sunday') THEN 'WeekEnd'
		ELSE 'WeekDay'
	END