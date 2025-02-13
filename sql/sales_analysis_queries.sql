-- Note:
-- Data Quality Issue
-- **Note:** There are 50,000 records with `NULL` values in `CustomerID` and `TransactionDate`.
-- **Impact:** These records significantly impact the analysis and should be investigated further for data quality issues.
-- **Action:** Exclude these records from the analysis and ensure to clean the data before further analysis.

-- below SQL query excluding the records with NULL values in CustomerID and TransactionDate and performing the analysis

-- Total Sales (excluding NULL values)
SELECT SUM(TransactionAmount) AS Total_Sales
FROM sales_data
WHERE CustomerID IS NOT NULL AND TransactionDate IS NOT NULL;

-- Output:
-- Total_Sales: 9177744106.77999

-- Average Sales (excluding NULL values)
SELECT AVG(TransactionAmount) AS Average_Sales
FROM sales_data
WHERE CustomerID IS NOT NULL AND TransactionDate IS NOT NULL;

-- Output:
-- Average_Sales: 20394.9869039555

-- Sales by Product Name (Top 5, excluding NULL values)
SELECT TOP 5 ProductName, SUM(TransactionAmount) AS Total_Sales
FROM sales_data
WHERE ProductName IS NOT NULL
GROUP BY ProductName
ORDER BY Total_Sales DESC;

-- Output:
-- ProductName    | Total_Sales
-- ----------------------------
-- Laptop         | 6231220430.24001
-- Sofa           | 3777022903.56
-- T-Shirt        | 102306079.47
-- Notebook       | 24079586.1199999
-- Apple          | 22300717.86

-- Sales by Region (excluding NULL values)
SELECT Region, ProductName, SUM(TransactionAmount) AS Sales_By_Product
FROM sales_data
WHERE Region IS NOT NULL
GROUP BY Region, ProductName
ORDER BY Region, Sales_By_Product DESC;

-- Output:
-- Region | ProductName | Sales_By_Product
-- ---------------------------------------
-- East   | Laptop      | 1627993804.44
-- East   | Sofa        | 986521458.05
-- East   | T-Shirt     | 26342544.76
-- East   | Notebook    | 6165187.28
-- East   | Apple       | 5798541.95
-- North  | Laptop      | 1335377966
-- North  | Sofa        | 804488994.91
-- North  | T-Shirt     | 21718847.78
-- North  | Notebook    | 5145518.29
-- North  | Apple       | 4771370.89
-- South  | Laptop      | 1943998743.27
-- South  | Sofa        | 1181920032.16
-- South  | T-Shirt     | 32226195.15
-- South  | Notebook    | 7542528.02
-- South  | Apple       | 7006138.42000001
-- West   | Laptop      | 1323849916.53
-- West   | Sofa        | 804092418.44
-- West   | T-Shirt     | 22018491.78
-- West   | Notebook    | 5226352.53
-- West   | Apple       | 4724666.6

-- Monthly Sales (excluding NULL values)
SELECT DATEPART(YEAR, TransactionDate) AS Year, DATEPART(MONTH, TransactionDate) AS Month, SUM(TransactionAmount) AS Monthly_Sales
FROM sales_data
WHERE TransactionDate IS NOT NULL
GROUP BY DATEPART(YEAR, TransactionDate), DATEPART(MONTH, TransactionDate)
ORDER BY Year, Month;

-- Output:
-- Year | Month | Monthly_Sales
-- ----------------------------
-- 2022 | 1     | 814518652.580001
-- 2022 | 2     | 744181785.06
-- 2022 | 3     | 818874213.270001
-- 2022 | 4     | 801872066.8
-- 2022 | 5     | 819562671.770001
-- 2022 | 6     | 790468924.130001
-- 2022 | 7     | 817029612.91
-- 2022 | 8     | 822157143.34
-- 2022 | 9     | 791350039.700001
-- 2022 | 10    | 815402571.54
-- 2022 | 11    | 799945427.92
-- 2022 | 12    | 342380997.76

-- Top Customers (excluding NULL values)
SELECT TOP 10 CustomerID, SUM(TransactionAmount) AS Total_Sales
FROM sales_data
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Total_Sales DESC;

-- Output:
-- CustomerID | Total_Sales
-- ------------------------
-- 32460      | 800724.49
-- 39732      | 773331.78
-- 10494      | 773034.52
-- 17752      | 769126.59
-- 9502       | 763669.57
-- 17919      | 762414.23
-- 28140      | 750696.9
-- 18111      | 740229.76
-- 28256      | 732385.24
-- 1910       | 698656.27

-- Customer Age Distribution (excluding NULL values)
SELECT CustomerAge, COUNT(*) AS Customer_Count
FROM sales_data
WHERE CustomerAge IS NOT NULL
GROUP BY CustomerAge
ORDER BY CustomerAge;

-- Output:
-- CustomerAge | Customer_Count
-- ----------------------------
-- 18          | 7860
-- 19          | 7884
-- 20          | 7756
-- 21          | 7833
-- 22          | 7901

-- Customer Distribution by Gender (excluding NULL values)
SELECT CustomerGender, COUNT(*) AS Customer_Count
FROM sales_data
WHERE CustomerGender IS NOT NULL
GROUP BY CustomerGender;

-- Customer Distribution by Gender
-- Output:
-- CustomerGender   Customer_Count
-- Female   149,773
-- Male 149,970
-- Other    150,257


-- Sales by Payment Method
SELECT PaymentMethod, SUM(TransactionAmount) AS Sales_By_PaymentMethod
FROM sales_data
WHERE PaymentMethod IS NOT NULL
GROUP BY PaymentMethod;

-- Output:
-- PaymentMethod    Sales_By_PaymentMethod
-- Cash 2,556,679,197.41
-- Credit Card  2,517,706,935.56
-- Debit Card   2,552,366,143.98
-- UPI  2,530,177,440.30


-- Sales by Store Type (In-Store vs Online)
SELECT StoreType, SUM(TransactionAmount) AS Sales_By_StoreType
FROM sales_data
WHERE StoreType IS NOT NULL
GROUP BY StoreType;

-- Output:
-- StoreType    Sales_By_StoreType
-- In-Store 5,078,881,502.74
-- Online   5,078,048,214.51


-- Product Return Rate
SELECT ProductName, COUNT(*) AS Total_Sales, SUM(CASE WHEN Returned = 'Yes' THEN 1 ELSE 0 END) AS Returned_Count, 
       SUM(CASE WHEN Returned = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS Return_Rate
FROM sales_data
WHERE ProductName IS NOT NULL
GROUP BY ProductName;

-- Output:
-- ProductName  Total_Sales Returned_Count  Return_Rate
-- Apple    89,970  45,033  0
-- Laptop   89,809  44,904  0
-- Notebook 90,294  45,061  0
-- Sofa 89,740  44,696  0
-- T-Shirt  90,187  44,783  0


-- Sales Over Time (Daily)
SELECT CAST(TransactionDate AS DATE) AS Date, SUM(TransactionAmount) AS Daily_Sales
FROM sales_data
WHERE TransactionDate IS NOT NULL
GROUP BY CAST(TransactionDate AS DATE)
ORDER BY Date;

-- Output:
-- Date Daily_Sales
-- 2022-01-01   24,405,992.35
-- 2022-01-02   26,508,401.31
-- 2022-01-03   25,896,591.25
-- 2022-01-04   26,970,581.12
-- 2022-01-05   26,343,906.89
-- 2022-01-06   25,885,836.75


-- Average Delivery Time by Product
SELECT ProductName, AVG(DeliveryTimeDays) AS Average_Delivery_Time
FROM sales_data
WHERE ProductName IS NOT NULL
GROUP BY ProductName;

-- Output:
-- ProductName  Average_Delivery_Time
-- Apple    1
-- Laptop   4
-- Notebook 3
-- Sofa 10
-- T-Shirt  3


-- Total Loyalty Points by Customer
SELECT CustomerID, SUM(LoyaltyPoints) AS Total_Loyalty_Points
FROM sales_data
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Total_Loyalty_Points DESC;

-- Output:
-- CustomerID   Total_Loyalty_Points
-- 13497    132,369
-- 15834    131,318
-- 39402    130,699
-- 24925    128,162
-- 44185    123,424
-- 35173    122,054
-- 19243    119,030
