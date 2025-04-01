Bank Customer Churn Analysis


Overview

This project analyzes bank customer churn to predict and prevent customer loss, ensuring a stable and loyal customer base. Using a dataset of 10,000 customers, I identified key churn patterns and developed actionable retention strategies to reduce the churn rate from 20% to 15%. The analysis leverages Power Query for data cleaning, SQL for exploratory data analysis and churn prediction, and Tableau for visualization.


Dataset

Source: Bank customer churn dataset (simulated or sourced from public repositories like Kaggle).

Size: 10,000 rows, 17 columns.

Features: customer_id, surname, credit_score, country, gender, age, tenure, balance, number_of_products, credit_card, active_members, estimated_salary, churn, complain, card_type, satisfactory_score, point_earned.


Objectives

Predict Churn: Identify customers at high risk of leaving using a rule-based scoring system in SQL.

Prevent Churn: Propose data-driven retention strategies to retain at-risk customers and lower the churn rate.


Methodology

Data Cleaning: Used Power Query to handle missing values, remove duplicates, and standardize data.

Exploratory Data Analysis (EDA): Conducted in SQL to uncover churn patterns (e.g., age, tenure, complaints). See.


Churn Prediction: Built a rule-based scoring system in SQL:

Age 40-49: +2 points

Tenure 1 year: +2 points

Credit score 600-699: +2 points

Zero balance: +2 points

Complaints: +3 points

High-risk threshold: Score ≥ 5


Visualization: Created an interactive Tableau dashboard to present insights and strategies. Explore it here.


Retention Strategies: Developed targeted solutions based on EDA findings.


Key Findings

Churn Rate: 20% (2,038/10,000 customers).

High-Risk Groups:

Ages 40-49: 807 churns.

1-year tenure: 232 churns.

Credit score 600-699: 753 churns.

Zero balance: 500 churns (25% of total).

Complaints: Strong correlation with churn (2,044 complaints vs. 2,038 churns).


Retention Strategies

Resolve Complaints: VIP Support Program for high-risk customers (potential 20% churn reduction).

Reactivate Zero-Balance Accounts: Offer deposit bonuses for 3,617 customers (targeting 500 churns).

Engage Ages 40-49: Tailor products like mortgages (807 churns).

Reward 1-Year Tenure: Loyalty bonuses for 232 customers.

Support Credit Scores 600-699: Credit-building tools for 753 customers.

Goal: Retain ~677 customers, reducing churn to 15%.


Tools Used

Power Query: Data cleaning and preparation.

SQL: Data analysis and churn risk scoring ().

Tableau: Data visualization ([Dashboard](https://public.tableau.com/app/profile/olakunle.olanrewaju/viz/HistoricalStocksPerformance/Story1)).
