## 📊 Task 6: Sales Trend Analysis Using SQL

### 🔍 Objective:

To analyze monthly revenue and order volume trends from an e-commerce sales dataset using SQL aggregation techniques.

### 🛠️ Tools Used:

* MySQL 8.0
* CSV dataset (`sales_data.csv`)

### 🧾 Dataset Overview:

The dataset contains sales order data with the following key fields:

* `order_date`: Date and time of order
* `order_id`: Unique order identifier
* `product_id`: Name or ID of the product
* `amount`: Sales turnover for the order (renamed from `turnover`)

### 📌 Tasks Performed:

1. **Data Cleaning & Import:**

   * Cleaned and reformatted `sales_data.csv` to match MySQL import requirements.
   * Loaded only relevant columns into the `online_sales` table.

2. **Data Transformation:**

   * Parsed date strings into MySQL `DATETIME` format using `STR_TO_DATE`.

3. **Monthly Sales Trend Query:**

   * Grouped by `YEAR(order_date)` and `MONTH(order_date)`
   * Aggregated:

     * `SUM(amount)` as `monthly_revenue`
     * `COUNT(DISTINCT order_id)` as `order_volume`

### 🧪 Sample Query:

SELECT
  YEAR(order_date) AS order_year,
  MONTH(order_date) AS order_month,
  SUM(amount) AS monthly_revenue,
  COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY order_year, order_month
ORDER BY order_year, order_month;


### 📈 Key Learnings:

* Efficient use of `GROUP BY`, `SUM()`, and `COUNT(DISTINCT)`
* Monthly trend extraction using `YEAR()` and `MONTHNAME()`
* Ranking results with `ORDER BY` and `LIMIT`
