CREATE TABLE online_sales (
  order_date DATETIME,
  order_id VARCHAR(20),
  product_id VARCHAR(255),
  amount DECIMAL(10,2)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_data.csv'
INTO TABLE online_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@order_date, @order_id, @product, @ean, @cat, @addr, @qty, @price, @cost, @turnover, @margin)
SET 
order_date = STR_TO_DATE(@order_date, '%Y-%m-%d %H:%i:%s'),
order_id = @order_id,
product_id = @product,
amount = @turnover;

SELECT
  YEAR(order_date) AS order_year,
  MONTH(order_date) AS order_month,
  SUM(amount) AS monthly_revenue,
  COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
WHERE order_date BETWEEN '2019-01-01' AND '2020-01-01'
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

SELECT 
  MIN(order_date) AS earliest_date, 
  MAX(order_date) AS latest_date
FROM online_sales;

WITH monthly AS (
  SELECT
    YEAR(order_date) AS yr,
    MONTH(order_date) AS mth,
    SUM(amount) AS revenue,
    COUNT(DISTINCT order_id) AS volume
  FROM online_sales
  WHERE order_date BETWEEN '2019-01-01' AND '2020-01-01'
  GROUP BY yr, mth
)
SELECT
  mth,
  SUM(CASE WHEN yr = 2019 THEN revenue END) AS revenue_2019,
  SUM(CASE WHEN yr = 2020 THEN revenue END) AS revenue_2020,
  SUM(CASE WHEN yr = 2019 THEN volume END) AS volume_2019,
  SUM(CASE WHEN yr = 2020 THEN volume END) AS volume_2020
FROM monthly
GROUP BY mth
ORDER BY mth;





