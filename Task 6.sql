SELECT 
    EXTRACT(YEAR FROM SaleDate) AS year,
    EXTRACT(MONTH FROM SaleDate) AS month,
    SUM(Amount) AS monthly_revenue,
    COUNT(*) AS order_volume
FROM sales
WHERE SaleDate BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY EXTRACT(YEAR FROM SaleDate), EXTRACT(MONTH FROM SaleDate)
ORDER BY year, month;
SELECT 
    EXTRACT(YEAR FROM SaleDate) AS year,
    EXTRACT(MONTH FROM SaleDate) AS month,
    SUM(Amount) AS monthly_revenue,
    COUNT(*) AS order_volume,
    SUM(Boxes) AS total_boxes_sold,
    SUM(Customers) AS total_customers
FROM sales
WHERE SaleDate BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY EXTRACT(YEAR FROM SaleDate), EXTRACT(MONTH FROM SaleDate)
ORDER BY year, month