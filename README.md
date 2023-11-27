# Financial Quarterly Report - Business Summary

Goal is to provide a medium-size internation retailer with a comprehensive quarterly report for insights with multi-page insights into highest value customers, top-performing product categories, KPI measures and visual insight into different specific territories. 

The sources for this information are disparate and are extracted from Azure SQL Database, Bulk CSV Files, Azure Blob Storage and base CSV.

This report involves:
1. Extract Transform Load (ETL) using various sources - Azure SQL Database, Bulk CSV Files, Azure Blob Storage and base CSV.
2. Cleaning the data using analysis into column profile, distribution and quality.
3. Seperating the tables into dimensions and forming relationships with the Fact table (Star Schema).
4. Creating financial measures using DAX (profitability, YTD values, revenue, margins).
5. Using M Language and Dax to split specific columns and create Time Series tables. 
