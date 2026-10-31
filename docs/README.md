# Documentation & Data Dictionary

## Dataset Schema (UCI Online Retail Dataset ID: 352)
- `InvoiceNo`: 6-digit integral number uniquely assigned to each transaction.
- `StockCode`: 5-digit integral number uniquely assigned to each distinct product.
- `Description`: Product name / item description.
- `Quantity`: Number of units purchased per transaction line.
- `InvoiceDate`: Timestamp of invoice generation.
- `UnitPrice`: Unit price of item in Sterling (£).
- `CustomerID`: 5-digit integral number uniquely assigned to each customer.
- `Country`: Customer residency country.

## Derived Cohort Metrics
- `InvoiceMonth`: Normalized start date of purchase month (`YYYY-MM-01`).
- `CohortMonth`: First observed purchase month for a specific `CustomerID`.
- `CohortIndex`: Difference in elapsed months from first purchase ($CohortIndex \ge 0$).
