SELECT 
    p.Salesperson,
    p.Team,
    SUM(s.Amount) as TotalSales
FROM sales s
JOIN people p ON s.SPID = p.SPID
GROUP BY p.Salesperson, p.Team
ORDER BY TotalSales DESC
LIMIT 5;

SELECT 
    p.Salesperson,
    p.Team,
    g.Geo as Country,
    g.Region,
    pr.Product,
    pr.Category,
    s.SaleDate,
    s.Amount,
    s.Boxes,
    s.Customers
FROM sales s
INNER JOIN people p ON s.SPID = p.SPID
INNER JOIN geo g ON s.GeoID = g.GeoID
INNER JOIN products pr ON s.PID = pr.PID
WHERE YEAR(s.SaleDate) = 2021
ORDER BY s.SaleDate DESC;

SELECT 
    p.Salesperson,
    p.Team,
    COUNT(s.SPID) as TotalSales,
    SUM(s.Amount) as TotalRevenue
FROM people p
JOIN sales s ON p.SPID = s.SPID
GROUP BY p.Salesperson, p.Team
HAVING TotalRevenue > (
    SELECT AVG(TotalRev) 
    FROM (
        SELECT SUM(Amount) as TotalRev 
        FROM sales 
        GROUP BY SPID
    ) as avg_sales
)
ORDER BY TotalRevenue DESC;
SELECT 
    pr.Category,
    COUNT(s.PID) as NumberOfSales,
    SUM(s.Amount) as TotalRevenue,
    AVG(s.Amount) as AverageSaleAmount,
    SUM(s.Boxes) as TotalBoxesSold,
    SUM(s.Customers) as TotalCustomers
FROM sales s
JOIN products pr ON s.PID = pr.PID
GROUP BY pr.Category
ORDER BY TotalRevenue DESC;
CREATE VIEW SalesPerformance AS
SELECT 
    s.SPID,
    p.Salesperson,
    p.Team,
    p.Location,
    g.Geo as Country,
    g.Region,
    pr.Product,
    pr.Category,
    pr.Size,
    s.SaleDate,
    s.Amount,
    s.Boxes,
    s.Customers,
    (s.Amount / NULLIF(s.Boxes, 0)) as RevenuePerBox,
    pr.Cost_per_box,
    (s.Amount - (s.Boxes * pr.Cost_per_box)) as GrossProfit
FROM sales s
JOIN people p ON s.SPID = p.SPID
JOIN geo g ON s.GeoID = g.GeoID
JOIN products pr ON s.PID = pr.PID;

SELECT 
    p.Team,
    COUNT(DISTINCT p.SPID) as TeamMembers,
    COUNT(s.SPID) as TotalSales,
    SUM(s.Amount) as TotalRevenue,
    AVG(s.Amount) as AvgSaleValue,
    SUM(s.Boxes) as TotalBoxes,
    (SUM(s.Amount) / COUNT(DISTINCT p.SPID)) as RevenuePerPerson
FROM people p
LEFT JOIN sales s ON p.SPID = s.SPID
WHERE p.Team IS NOT NULL AND p.Team != ''
GROUP BY p.Team
ORDER BY TotalRevenue DESC;