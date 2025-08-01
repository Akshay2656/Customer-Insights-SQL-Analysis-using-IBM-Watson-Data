CREATE DATABASE marketing_data;

use marketing_data;

CREATE TABLE customer_value_data (
    Customer VARCHAR(20) PRIMARY KEY,
    State VARCHAR(50),
    Customer_Lifetime_Value DECIMAL(10,2),
    Response VARCHAR(5),
    Coverage VARCHAR(20),
    Education VARCHAR(50),
    Effective_To_Date DATE,
    EmploymentStatus VARCHAR(30),
    Gender CHAR(1),
    Income INT,
    Location_Code VARCHAR(20),
    Marital_Status VARCHAR(20),
    Monthly_Premium_Auto INT,
    Months_Since_Last_Claim INT,
    Months_Since_Policy_Inception INT,
    Number_of_Open_Complaints INT,
    Number_of_Policies INT,
    Policy_Type VARCHAR(50),
    Policy VARCHAR(50),
    Renew_Offer_Type VARCHAR(20),
    Sales_Channel VARCHAR(30),
    Total_Claim_Amount DECIMAL(10,2),
    Vehicle_Class VARCHAR(30),
    Vehicle_Size VARCHAR(20)
);



--  SQL ANALYSIS

-- QUESTION 1 - TOTAL CUSTOMERS
-- HOW MANY UNIQUE CUSTOMERS ARE IN THE DATASET OF IBM

SELECT DISTINCT COUNT(*) AS Total_Customer
FROM customer_value_data;

-- QUESTION 2 - AVERAGE INCOME
-- WHAT IS THE AVERAGE INCOME OF ALL CUSTOMERS

SELECT AVG(Income) AS Avg_income
FROM customer_value_data;


-- QUESTION 3 - CUSTOMER COUNT BY STATE
-- HOW MANY CUSTOMER ARE THERE IN EACH STATE?

SELECT 
	State,
    COUNT(*) AS Customer_Count 
FROM customer_value_data
GROUP BY State
ORDER BY Customer_Count desc;

-- QUESTION 4 - TOTAL CLAIMS BY COVERAGE
-- WHAT IS THE TOTAL CLAIM AMOUNT FOR EACH TYPE OF COVERAGE(BASIC, EXTENEDE , PREMIUM)

SELECT 
	Coverage,
    SUM(Total_Claim_Amount) AS Total_claim_amount
FROM customer_value_data
GROUP BY Coverage
ORDER BY Total_claim_amount;


-- QUESTION 5 - TOP STATE BY AVERAGE LIFETIME VALUES
-- WHICH STATE HAVE THE HIGHEST AVERAGE CUSTOMER LIFETIME values

SELECT 
	State,
	ROUND(AVG(Customer_Lifetime_Value), 2) AS AVG_Cust_lifetime_value
FROM customer_value_data
group by state
order by AVG_Cust_lifetime_value desc;


-- QUESTION 6 - RESPONSE RATE BY SALES CHANNEL
-- WHAT IS THE RESPONSE RATE (YES/NO) FOR EACH SALES CHANNEL?

SELECT 
	Sales_Channel,
    Response, COUNT(*) AS count 
FROM customer_value_data
GROUP BY Sales_Channel,Response
ORDER BY Sales_Channel,Response;


-- QUESTION 7 - POLICIES BY EMPLOYMENT STATUS
-- HOW MANY POLICIES DO CUSTOMERS HOLD ON AVERAGE, GROUPED BY EMPLOYEEMENT

SELECT 
	EmploymentStatus,
    AVG(Number_of_Policies) AS NO_of_policies
FROM customer_value_data
group by EmploymentStatus
Order by NO_of_policies;


-- question 8 - AVEGRAGE MONTHLY PREMIUM BY VEHICLE CLASS
-- WHAT IS THE AVERAAGE MONTHLY PREMIUM FOR EACH VEHICLE CLASS

SELECT 
	Vehicle_Class,
    ROUND(AVG(Monthly_Premium_Auto), 2) AS Avg_monthly_premium
FROM customer_value_data
group by Vehicle_Class 
order by Avg_monthly_premium desc;


-- QUESTION 9- RETENTION - CUSTOMERS WITH HIGH LIFETIME VALUE
-- WHAT PERCENTAGE OF CUSTOMER HAVE A CUSTOMER LIFETIME VALUE GREATER THAT $10000?

SELECT 
	ROUND(
		AVG(CASE WHEN 
					Customer_Lifetime_Value > 10000
				 THEN 1 
                 ELSE 0 END) * 100 , 2) AS High_CLV_Percentage
FROM customer_value_data;

SELECT 
  ROUND(
    (COUNT(CASE WHEN Customer_Lifetime_Value > 10000 THEN 1 END) / COUNT(*)) * 100, 
    2
  ) AS High_CLV_Percentage
FROM customer_value_data;
	

-- QUESTION 10 - CLAIM BEHAVIOR LONG-TIME CUSTOMERS
-- WHAT IS THE AVERAGE TOTAL CLAIM AMOUNT FOR CUSTOMERS WHO HAVE BEEN WITH THE COMPANY FOR MORE THAN  48 MONTHS SINCE POLICY INCEPTION?


SELECT 
    ROUND(AVG(Total_Claim_Amount), 2) AS Total_claim_amount
FROM customer_value_data
WHERE Months_Since_Policy_Inception > 48;


-- QUESTION 11- HIGH INCOME NON-RESPONDERS
-- HOW MANY HIGH-INCOME CUSTOMERS (INCOME > $ 50000) DID NOT RESPOND TO THE LATEST OFFERS?

SELECT 
	COUNT(*) AS High_income_non_responders
from customer_value_data
where income > 50000 and Response = 'no';


-- QUESTION 12 - MOST VALUABLE CUSTOMER SEGMENT
-- WHAT IS THE AVERAGE CUSTOMER LIFETIME VALUE GROUPED BY POLICY TYPE, AND RENEW OFFER TYPE ?WHICH COMBINATION IS THE HIGHEST?

SELECT
	round(AVG(Customer_Lifetime_Value),2) AS Avg_CLV,
    Policy_Type,
    Renew_Offer_Type
FROM customer_value_data
group by Policy_Type,Renew_Offer_Type
order by Avg_CLV desc;





