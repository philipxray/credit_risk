# Credit Risk Analysis (SQL + PostgreSQL)
### Project Overview

This project analyzes a credit card default dataset to explore patterns that may help predict default risk. Using PostgreSQL, I cleaned and transformed the data, converted financial values from Taiwan Dollars (TWD) to U.S. Dollars (USD), engineered risk-focused features, and generated summary outputs that can be used for reporting and dashboarding.

The goal of this project is to demonstrate practical data analyst skills including:

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

### Dataset
Default of Credit Card Clients Dataset (Taiwan)

Source: UCI Machine Learning Respitory 
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


Negative Statement Balances

A small number of accounts have negative statement balances, which can occur due to refunds, charge reversals, or overpayments. These values were retained as valid credit account behavior.

SELECT COUNT(*) AS negative_total_bill_count
FROM credit_features
WHERE total_bill_amt_usd < 0;

Analysis Queries
Default Rate (Overall)
SELECT
    default_flag,
    COUNT(*) AS customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_total
FROM credit_features
GROUP BY default_flag
ORDER BY default_flag;

Default Rate by Delinquency (Any Delinquency Flag)
SELECT
    any_delinquency_flag,
    COUNT(*) AS customers,
    ROUND(AVG(default_flag::numeric), 4) AS default_rate
FROM credit_features
GROUP BY any_delinquency_flag
ORDER BY any_delinquency_flag;

Default Rate by Worst Pay Status
SELECT
    worst_pay_status,
    COUNT(*) AS customers,
    ROUND(AVG(default_flag::numeric), 4) AS default_rate
FROM credit_features
GROUP BY worst_pay_status
ORDER BY worst_pay_status;

Average Balance and Payment by Default Flag
SELECT
    default_flag,
    ROUND(AVG(avg_monthly_bill_usd), 2) AS avg_monthly_bill_usd,
    ROUND(AVG(avg_monthly_pay_usd), 2) AS avg_monthly_pay_usd,
    ROUND(AVG(total_bill_amt_usd), 2) AS avg_total_bill_usd,
    ROUND(AVG(total_pay_amt_usd), 2) AS avg_total_pay_usd
FROM credit_features
GROUP BY default_flag
ORDER BY default_flag;

Credit Utilization (Estimated)

This metric compares average monthly balance to credit limit.

SELECT
    id,
    limit_bal_usd,
    avg_monthly_bill_usd,
    CASE
        WHEN limit_bal_usd = 0 THEN NULL
        ELSE ROUND(avg_monthly_bill_usd / limit_bal_usd, 4)
    END AS utilization_rate,
    default_flag
FROM credit_features;

Visuals

Default rate (bar chart)

Default rate by worst pay status (bar chart)

Default rate by any delinquency flag (bar chart)

Average monthly bill vs average monthly payment by default flag (side-by-side bar chart)

Distribution of utilization rate (histogram)

Utilization rate vs default flag (boxplot)

Key Findings (Summary)

Customers with any delinquency history show higher default rates than customers with no delinquency history.

Default rates increase as repayment status worsens.

Average balances and payment behavior differ between default and non-default groups.

Negative statement balances exist in a small number of accounts and likely reflect refunds or overpayment behavior.
