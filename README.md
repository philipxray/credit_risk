# Credit Risk Analysis (SQL + PostgreSQL)
### Executive Summary

### Project Overview

This project analyzes a credit card default dataset to explore patterns that may help predict default risk. Using PostgreSQL, I cleaned and transformed the data, converted financial values from Taiwan Dollars (TWD) to U.S. Dollars (USD), engineered risk-focused features, and generated summary outputs that can be used for reporting and dashboarding.

The goal of this project is to demonstrate practical data analyst skills, including:

   * Data cleaning and validation in SQL
   * Feature engineering for real-world business questions
   * Credit risk metric design and interpretation
   * Preparing analysis-ready tables for visualization

### Business Questions

#### This project focuses on questions commonly asked in credit risk and lending analytics:

   * What customer characteristics are most associated with default risk?
   * How does repayment history relate to default outcomes?
   * How do balances and payments differ between default vs. non-default accounts?
   * Which segments show the highest default rates?
   * What factors seem most related to customers defaulting?
   * Are there early warning signs before someone defaults?
   * Which customer groups are higher risk?
   * If we had to review only 20% of accounts, who should we focus on?

### Dataset
Default of Credit Card Clients Dataset (Taiwan)

Source: UCI Machine Learning Repository 
##### I. Yeh. "Default of Credit Card Clients," UCI Machine Learning Repository, 2009. [Online]. Available: https://doi.org/10.24432/C55S3H.

#### Dataset contents include:

Credit limit (`limit_bal`)

Demographics (`SEX`, `EDUCATION`, `MARRIAGE`, `AGE`)

Repayment status history (`pay_0,`- `pay_6`)

Monthly statement balances (`bill_amt1_usd`-`bill_amt6_usd)

Monthly payments (`pay_amt1_usd)

Default indicator (`default_payment_next_month`)

Target variable:

`default_flag` (1 = defaulted, 0 = did not default)

### Tools Used

* PostgreSQL (SQL)
* pgAdmin 4 (database administration + CSV import)
* Power BI
* Tableau

# Analysis

The objective of this analysis is to identify behavioral and usage patterns associated with increased credit default risk. Using engineered features derived from six months of billing and payment history, customers were segmented based on delinquency behavior, credit utilization, and payment coverage. Default rates were then compared across these segments to determine which customer groups exhibit elevated risk.

1. Which customers exhibit higher default risk based on delinquency behavior?
Customers were first segmented based on whether they experienced any delinquency during the six-month observation period.
````
    SELECT
    any_delinquency_flag,
    COUNT(*) AS customers,
    ROUND(AVG(default_flag)::numeric, 4) AS default_rate
FROM credit_features
GROUP BY any_delinquency_flag;
````

Across all analyses, delinquency behavior emerged as the strongest predictor of default risk, followed by credit utilization levels. Customers exhibiting repeated late payments or high utilization consistently demonstrated elevated default rates. These findings suggest that early behavioral signals can be used to identify high-risk customers before default occurs, supporting proactive credit risk monitoring and intervention.
