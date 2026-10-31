-- 1. Ingestion & Base Cleaning: Remove invalid IDs and cancelled orders
WITH cleaned_retail AS (
    SELECT 
        InvoiceNo,
        StockCode,
        Description,
        Quantity,
        InvoiceDate,
        UnitPrice,
        CustomerID,
        Country,
        (Quantity * UnitPrice) AS TotalSpend,
        DATE_TRUNC('month', InvoiceDate) AS InvoiceMonth
    FROM online_retail_raw
    WHERE CustomerID IS NOT NULL
      AND Quantity > 0
      AND UnitPrice > 0
),

-- 2. Customer Cohort Assignment: Find first purchase month
cohort_assignment AS (
    SELECT 
        CustomerID,
        MIN(InvoiceMonth) AS CohortMonth
    FROM cleaned_retail
    GROUP BY CustomerID
),

-- 3. Calculate Cohort Index (Months Elapsed)
cohort_index_calc AS (
    SELECT 
        c.InvoiceMonth,
        ca.CohortMonth,
        c.CustomerID,
        c.TotalSpend,
        (EXTRACT(YEAR FROM c.InvoiceMonth) - EXTRACT(YEAR FROM ca.CohortMonth)) * 12 +
        (EXTRACT(MONTH FROM c.InvoiceMonth) - EXTRACT(MONTH FROM ca.CohortMonth)) AS CohortIndex
    FROM cleaned_retail c
    JOIN cohort_assignment ca ON c.CustomerID = ca.CustomerID
)

-- 4. Final Cohort Retention Aggregate
SELECT 
    CohortMonth,
    CohortIndex,
    COUNT(DISTINCT CustomerID) AS ActiveCustomers,
    SUM(TotalSpend) AS TotalRevenue,
    ROUND(AVG(TotalSpend), 2) AS AvgCustomerSpend
FROM cohort_index_calc
GROUP BY CohortMonth, CohortIndex
ORDER BY CohortMonth, CohortIndex;
