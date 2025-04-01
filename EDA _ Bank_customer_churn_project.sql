--Exploratory Data Analysis 
--Goal: Uncover Patterns and Insights
SELECT * FROM customers
LIMIT 5;

--Churn Rate
SELECT AVG(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churn_rate
FROM customers;

--Churn by Age_Group
SELECT 
FLOOR(age/10)*10 AS age_group,
COUNT(*) AS total,
SUM(churn) AS churned 
FROM customers
GROUP BY age_group
ORDER BY 1 DESC;

--Balance vs Churn
SELECT ROUND(AVG(balance),0) AS avg_balance, churn 
FROM customers
GROUP BY churn;

--Churn by Tenure
SELECT tenure, SUM(churn) AS churned
FROM customers
GROUP BY tenure
ORDER BY 1;

--Churn by Credit_core
SELECT FLOOR(credit_score/100)*100 AS cc_group, SUM(churn) AS churned
FROM customers
GROUP BY cc_group
ORDER BY 1 DESC;

SELECT MAX(balance), MIN(balance)
FROM customers;

--Churn by Balance
SELECT COUNT(*) customer_count, balance, SUM(churn) AS churned
FROM customers
WHERE balance = 0
GROUP BY balance;

--Predicting Churn
--Churn Risk Score
--Points range from 0-11. Customers with 6+ score are at high risk of churning.
SELECT
	customer_id,
	age,
	tenure,
	credit_score,
	balance,
	complain,
	(CASE
		WHEN age BETWEEN 40 AND 49 THEN 2 --high churn 
		WHEN age BETWEEN 50 AND 59 THEN 1 --moderate churn
		WHEN age BETWEEN 30 AND 39 THEN 1 --moderate churn
		ELSE 0 --low churn
	END +
	CASE
		WHEN tenure = 1 THEN 2
		WHEN tenure < 1 THEN 0
		ELSE 1
	END +
	CASE
		WHEN credit_score BETWEEN 600 AND 699 THEN 2
		WHEN credit_score BETWEEN 300 AND 499 THEN 0
		WHEN credit_score >= 800 THEN 0
		ELSE 1
	END +
	CASE
		WHEN balance = 0 THEN 2
		ELSE 0
	END +
	CASE
		WHEN complain = 1 THEN 3 --strongest predictor, higher weight
		ELSE 0
	END) AS churn_risk_score
FROM
	customers
ORDER BY 
	churn_risk_score DESC
LIMIT 10;

--Checking how many of the 2038 actual churners score high.
SELECT
	churn,
	COUNT(*) AS total,
	AVG(churn_risk_score) AS avg_score
FROM (
	SELECT
	customer_id,
	churn,
	age,
	tenure,
	credit_score,
	balance,
	complain,
	(CASE
		WHEN age BETWEEN 40 AND 49 THEN 2 --high churn 
		WHEN age BETWEEN 50 AND 59 THEN 1 --moderate churn
		WHEN age BETWEEN 30 AND 39 THEN 1 --moderate churn
		ELSE 0 --low churn
	END +
	CASE
		WHEN tenure = 1 THEN 2
		WHEN tenure < 1 THEN 0
		ELSE 1
	END +
	CASE
		WHEN credit_score BETWEEN 600 AND 699 THEN 2
		WHEN credit_score BETWEEN 300 AND 499 THEN 0
		WHEN credit_score >= 800 THEN 0
		ELSE 1
	END +
	CASE
		WHEN balance = 0 THEN 2
		ELSE 0
	END +
	CASE
		WHEN complain = 1 THEN 3 --strongest predictor, higher weight
		ELSE 0
	END) AS churn_risk_score
FROM
	customers
ORDER BY 
	churn_risk_score DESC
	
) AS scored_customers
GROUP BY churn;

--Creating View
CREATE VIEW high_risk_customers AS
SELECT customer_id, churn_risk_score
FROM (
	SELECT
	customer_id,
	age,
	tenure,
	credit_score,
	balance,
	complain,
	(CASE
		WHEN age BETWEEN 40 AND 49 THEN 2 --high churn 
		WHEN age BETWEEN 50 AND 59 THEN 1 --moderate churn
		WHEN age BETWEEN 30 AND 39 THEN 1 --moderate churn
		ELSE 0 --low churn
	END +
	CASE
		WHEN tenure = 1 THEN 2
		WHEN tenure < 1 THEN 0
		ELSE 1
	END +
	CASE
		WHEN credit_score BETWEEN 600 AND 699 THEN 2
		WHEN credit_score BETWEEN 300 AND 499 THEN 0
		WHEN credit_score >= 800 THEN 0
		ELSE 1
	END +
	CASE
		WHEN balance = 0 THEN 2
		ELSE 0
	END +
	CASE
		WHEN complain = 1 THEN 3 --strongest predictor, higher weight
		ELSE 0
	END) AS churn_risk_score
FROM
	customers
ORDER BY 
	churn_risk_score DESC
)
WHERE churn_risk_score >=6;

SELECT * FROM high_risk_customers 