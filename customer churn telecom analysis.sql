-- 1. TOTAL CUSTOMERS

select count(*) as total_customers
from customer_churn;


-- 2. CHURN RATE

SELECT
	ROUND(
		100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*),2
	) AS churn_rate
FROM customer_churn;


-- 3. CONTRACT TYPE WISE CHURN

SELECT
	contract,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END ) AS churned_customers
FROM customer_churn
GROUP BY contract
ORDER BY churned_customers DESC;


-- 4. REVENUE LOSS DUE TO CHURN

ALTER TABLE customer_churn
ALTER COLUMN monthly_charges TYPE NUMERIC
USING monthly_charges::NUMERIC;

SELECT
    ROUND(SUM(monthly_charges),2) AS revenue_lost
FROM customer_churn
WHERE churn = 'Yes'


-- 5. PAYMENT METHOD WISE CHURN

SELECT 
	payment_method,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM customer_churn
GROUP BY payment_method
ORDER BY churned_customers DESC;


-- 6. HIGH VALUE CUSTOMERS LEAVING

SELECT 
	customer_id,
	monthly_charges,
	total_charges,
	contract
FROM customer_churn
WHERE churn = 'Yes'
AND monthly_charges > 80
ORDER BY monthly_charges DESC;


-- 7. TENURE WISE CHURN

SELECT 
	tenure_group,
	COUNT(*) AS total_customers, 
	SUM (CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM customer_churn
GROUP BY tenure_group
ORDER BY total_customers DESC;


-- 8. INTERNET SERVICE WISE CHURN
SELECT 
	internet_service,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END ) AS churned_customers
FROM customer_churn
GROUP BY internet_service;


-- 9. SENIOR CITIZEN CHURN

SELECT 
	senior_citizen,
	COUNT(*) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM customer_churn
GROUP BY senior_citizen;

-- 10. TOP HIGH RISK CUSTOMER
SELECT 
	customer_id,
	contract,
	monthly_charges,
	tenure,
	churn
FROM customer_churn
WHERE contract = 'Month-to-month'
AND monthly_charges >70
AND tenure < 12;








