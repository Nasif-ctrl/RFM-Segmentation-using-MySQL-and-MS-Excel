-- ____________________________ Data Entry and Cleaning ____________________________

CREATE DATABASE IF NOT EXISTS project_rfm;
USE project_rfm;

CREATE TABLE `Superstore Sales Data`(
	Imaginary_ID INT AUTO_INCREMENT PRIMARY KEY
);

-- Bulk insert csv file
SELECT * FROM project_rfm.`superstore sales data`;
SELECT COUNT(*) FROM project_rfm.`superstore sales data`;

-- Adding new 'DATE' columns to convert integers as dates
ALTER TABLE `Superstore Sales Data`
ADD COLUMN `Order Date (Converted)` DATE,
ADD COLUMN `Ship Date (Converted)` DATE;

SET SQL_SAFE_UPDATES = 0;		-- Turning off (0 means off) safe updates so no error is shown when updating

-- Storing updated values in the new columns
UPDATE `Superstore Sales Data`
SET `Order Date (Converted)` = DATE_ADD('1899-12-30', INTERVAL `Order Date` DAY),
    `Ship Date (Converted)` = DATE_ADD('1899-12-30', INTERVAL `Ship Date` DAY);

-- ____________________________ Prliminary Data Analysis ____________________________

-- Overall Last Order Date
SELECT MAX(`Order Date (Converted)`) AS Latest_Order FROM `Superstore Sales Data`; -- 2013-12-31

-- Checking current date
SELECT curdate();

-- Customer Name and corresponding Last Order Dates
SELECT
	`Customer Name`,
	MAX(`Order Date (Converted)`) AS LAST_ORDER_DATE
    -- datediff((SELECT MAX(ORDERDATE) FROM SALES_SAMPLE_DATA), MAX(ORDERDATE)) AS RECENCY
FROM project_rfm.`superstore sales data`
GROUP BY `Customer Name`
ORDER BY MAX(`Order Date (Converted)`) DESC;



/* _______________________________ RFM Segmentation _______________________________ 
Segmenting the Customers based on their Recency (R), Frequency (F) & Monetary Value (M) */


-- Creating a view for individual and aggregated RFM Scores
CREATE OR REPLACE VIEW RFM_SCORE_DATA AS
WITH CUSTOMER_INSIGHTS AS	-- Referring to the following code snippet as CUSTOMER_INSIGHTS
(SELECT
	`Customer Name`,
    DATEDIFF((SELECT MAX(`Order Date (Converted)`) FROM project_rfm.`superstore sales data`), MAX(`Order Date (Converted)`)) AS Recency_Value,
    COUNT(DISTINCT `Order Date (Converted)`) AS Frequency_Value,
    ROUND(SUM(Sales), 0) AS Monetary_Value
FROM project_rfm.`superstore sales data`
GROUP BY `Customer Name`),

RFM_Score AS
(SELECT 
	CI.*,
    NTILE(4) OVER (ORDER BY RECENCY_VALUE DESC) AS R_Score,
    NTILE(4) OVER (ORDER BY FREQUENCY_VALUE ASC) AS F_Score,
    NTILE(4) OVER (ORDER BY MONETARY_VALUE ASC) AS M_Score
FROM CUSTOMER_INSIGHTS AS CI)

SELECT
	RFM.`Customer Name`,
    RFM.RECENCY_VALUE,
    R_SCORE,
    RFM.FREQUENCY_VALUE,
    F_SCORE,
    RFM.MONETARY_VALUE,
    M_SCORE,
	(R_SCORE + F_SCORE + M_SCORE) AS Total_RFM_Score,
    CONCAT_WS('', R_SCORE, F_SCORE, M_SCORE) AS Combined_RFM_Score
FROM RFM_Score AS RFM;


-- Manually searching specific combinations of RFM Scores
SELECT * FROM RFM_SCORE_DATA WHERE Combined_RFM_Score = '123';


-- Creating a view for Customer segments based on RFM Scores
CREATE OR REPLACE VIEW RFM_ANALYSIS AS
SELECT 
    RFM_SCORE_DATA.*,
    CASE
        WHEN Combined_RFM_Score IN (111, 112, 121, 132, 211, 211, 212, 114, 141) THEN 'CHURNED CUSTOMER'
        WHEN Combined_RFM_Score IN (133, 134, 143, 224, 334, 343, 344, 144) THEN 'SLIPPING AWAY, CANNOT LOSE'
        WHEN Combined_RFM_Score IN (311, 411, 331) THEN 'NEW CUSTOMERS'
        WHEN Combined_RFM_Score IN (222, 231, 221,  223, 233, 322) THEN 'POTENTIAL CHURNERS'
        WHEN Combined_RFM_Score IN (323, 333,321, 341, 422, 332, 432) THEN 'ACTIVE'
        WHEN Combined_RFM_Score IN (433, 434, 443, 444) THEN 'LOYAL'		
    ELSE 'OTHERS'
    END AS Customer_Segment
FROM RFM_SCORE_DATA;

SELECT
	Customer_Segment,
    COUNT(*) AS NUMBER_OF_CUSTOMERS,
    ROUND(AVG(MONETARY_VALUE),0) AS AVERAGE_MONETARY_VALUE
FROM RFM_ANALYSIS
GROUP BY CUSTOMER_SEGMENT
ORDER BY AVERAGE_MONETARY_VALUE;
