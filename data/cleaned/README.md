# Cleaned Data

This folder contains the cleaned and preprocessed transaction records used for cohort tracking.

### Cleaning Steps Applied:
- Dropped null/missing `CustomerID` records.
- Filtered out negative quantities and returns (`Quantity > 0`).
- Filtered out invalid zero unit prices (`UnitPrice > 0`).
- Derived `TotalSpend`, `InvoiceMonth`, `CohortMonth`, and `CohortIndex`.
