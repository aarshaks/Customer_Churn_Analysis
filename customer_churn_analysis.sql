create database customer_churn;
use customer_churn;
show tables;
describe `wa_fn-usec_-telco-customer-churn`;

select * from `wa_fn-usec_-telco-customer-churn`;

SELECT DISTINCT Contract FROM `wa_fn-usec_-telco-customer-churn`;

SELECT DISTINCT InternetService FROM `wa_fn-usec_-telco-customer-churn`;

SELECT DISTINCT PaymentMethod FROM `wa_fn-usec_-telco-customer-churn`;

SELECT customerID, COUNT(*) AS duplicate_count FROM `wa_fn-usec_-telco-customer-churn` GROUP BY customerID HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS total_records,
    SUM(customerID IS NULL) AS missing_customer_id,
    SUM(gender IS NULL) AS missing_gender,
    SUM(tenure IS NULL) AS missing_tenure,
    SUM(MonthlyCharges IS NULL) AS missing_monthly_charges,
    SUM(TotalCharges IS NULL) AS missing_total_charges,
    SUM(Churn IS NULL) AS missing_churn
FROM `wa_fn-usec_-telco-customer-churn`;

#Find the total number of customers in the dataset.
select count(customerID) as total_customers from `wa_fn-usec_-telco-customer-churn`;

#Find the number of customers who churned and those who did not
Select Churn, COUNT(*) AS customer_count FROM `wa_fn-usec_-telco-customer-churn`GROUP BY Churn;

#Find the number of male and female customers
select gender,count(*) as customer_count from `wa_fn-usec_-telco-customer-churn`group by gender;

#Find the number of customers under each contract type
select Contract,count(*) as count from `wa_fn-usec_-telco-customer-churn`group by Contract ;

#Find the number of churned customers based on gender
SELECT gender, COUNT(*) AS churned_customers FROM `wa_fn-usec_-telco-customer-churn`WHERE Churn = 'Yes' GROUP BY gender;

#Calculate average monthly charges for churned and non-churned customers
select Churn,round(avg(MonthlyCharges),2) from`wa_fn-usec_-telco-customer-churn`group by Churn;

#Find the average tenure of churned and non-churned customers
SELECT Churn,ROUND(AVG(tenure), 2) AS avg_tenure FROM `wa_fn-usec_-telco-customer-churn`GROUP BY Churn;

#Identify customers whose monthly charges are higher than the overall average monthly charges
SELECT customerID,MonthlyCharges FROM `wa_fn-usec_-telco-customer-churn` WHERE MonthlyCharges >(SELECT AVG(MonthlyCharges) FROM `wa_fn-usec_-telco-customer-churn`) ORDER BY MonthlyCharges DESC;

#Categorize customers based on their monthly charges
SELECT customerID, MonthlyCharges,
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low Charges'
        WHEN MonthlyCharges <= 70 THEN 'Medium Charges'
        ELSE 'High Charges'
    END AS charge_category
FROM `wa_fn-usec_-telco-customer-churn`;

#Categorize customers based on their tenure
SELECT customerID,tenure,CASE WHEN tenure <= 12 THEN 'New Customer'WHEN tenure <= 36 THEN 'Medium Customer'ELSE 'Loyal Customer'END AS customer_category FROM `wa_fn-usec_-telco-customer-churn`;

#Rank the top 10 customers based on their monthly charges, from highest to lowest
SELECT customerID,MonthlyCharges,RANK() OVER (ORDER BY MonthlyCharges DESC) AS customer_rank FROM `wa_fn-usec_-telco-customer-churn`LIMIT 10;

#Rank customers based on their tenure, from highest to lowest
SELECT customerID,tenure,RANK() OVER (ORDER BY tenure DESC ) AS tenure_rank FROM `wa_fn-usec_-telco-customer-churn`;

#Display customers whose contract is not Month-to-month
SELECT customerID, Contract FROM `wa_fn-usec_-telco-customer-churn`WHERE NOT Contract = 'Month-to-month';

#Find the number of unique payment methods available
SELECT COUNT(DISTINCT PaymentMethod) AS unique_payment_methods FROM `wa_fn-usec_-telco-customer-churn`;

#Find customers who use either Fiber optic or DSL internet service
SELECT customerID, InternetService FROM `wa_fn-usec_-telco-customer-churn`WHERE InternetService IN ('Fiber optic', 'DSL');