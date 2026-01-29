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

### Data Preparation Workflow
#### Step 1: Raw Table Creation

A raw landing table was created to store imported values in a structured format.

DROP TABLE IF EXISTS `credit_raw`;

CREATE TABLE `credit_raw` (
    `id` INTEGER,
    `limit_bal` INTEGER,
    sex INTEGER,
    education INTEGER,
    marriage INTEGER,
    age INTEGER,
    pay_0 INTEGER,
    pay_2 INTEGER,
    pay_3 INTEGER,
    pay_4 INTEGER,
    pay_5 INTEGER,
    pay_6 INTEGER,
    bill_amt1 INTEGER,
    bill_amt2 INTEGER,
    bill_amt3 INTEGER,
    bill_amt4 INTEGER,
    bill_amt5 INTEGER,
    bill_amt6 INTEGER,
    pay_amt1 INTEGER,
    pay_amt2 INTEGER,
    pay_amt3 INTEGER,
    pay_amt4 INTEGER,
    pay_amt5 INTEGER,
    pay_amt6 INTEGER,
    default_payment_next_month INTEGER
);

Step 2: CSV Import (pgAdmin 4)

The dataset was imported using pgAdmin’s Import tool with the Header option enabled, ensuring column names were not loaded as a data row.

Currency Conversion (TWD to USD)

The dataset financial values are recorded in Taiwan Dollars (TWD). For easier interpretation, the project converts monetary fields into USD using:

Conversion rate: 1 TWD = 0.032 USD

A USD-converted table was created so that all analysis can reference consistent currency fields.

DROP TABLE IF EXISTS credit_usd;

CREATE TABLE credit_usd AS
SELECT
    id,
    (limit_bal * 0.032)::numeric(12,3) AS limit_bal_usd,
    sex,
    education,
    marriage,
    age,
    pay_0, pay_2, pay_3, pay_4, pay_5, pay_6,

    (bill_amt1 * 0.032)::numeric(14,3) AS bill_amt1_usd,
    (bill_amt2 * 0.032)::numeric(14,3) AS bill_amt2_usd,
    (bill_amt3 * 0.032)::numeric(14,3) AS bill_amt3_usd,
    (bill_amt4 * 0.032)::numeric(14,3) AS bill_amt4_usd,
    (bill_amt5 * 0.032)::numeric(14,3) AS bill_amt5_usd,
    (bill_amt6 * 0.032)::numeric(14,3) AS bill_amt6_usd,

    (pay_amt1 * 0.032)::numeric(14,3) AS pay_amt1_usd,
    (pay_amt2 * 0.032)::numeric(14,3) AS pay_amt2_usd,
    (pay_amt3 * 0.032)::numeric(14,3) AS pay_amt3_usd,
    (pay_amt4 * 0.032)::numeric(14,3) AS pay_amt4_usd,
    (pay_amt5 * 0.032)::numeric(14,3) AS pay_amt5_usd,
    (pay_amt6 * 0.032)::numeric(14,3) AS pay_amt6_usd,

    default_payment_next_month AS default_flag
FROM credit_raw;

Feature Engineering

To support credit risk analysis, a feature table was created with metrics that reflect customer exposure, payment behavior, and delinquency risk.

Features Created

total_bill_amt_usd: total statement balance across 6 months

total_pay_amt_usd: total payments across 6 months

avg_monthly_bill_usd: average monthly statement balance

avg_monthly_pay_usd: average monthly payment

worst_pay_status: maximum delinquency value across repayment status columns

any_delinquency_flag: indicates whether the customer was ever delinquent

DROP TABLE IF EXISTS credit_features;

CREATE TABLE credit_features AS
SELECT
    id,
    limit_bal_usd,
    sex,
    education,
    marriage,
    age,
    default_flag,

    (bill_amt1_usd + bill_amt2_usd + bill_amt3_usd + bill_amt4_usd + bill_amt5_usd + bill_amt6_usd)
        AS total_bill_amt_usd,

    (pay_amt1_usd + pay_amt2_usd + pay_amt3_usd + pay_amt4_usd + pay_amt5_usd + pay_amt6_usd)
        AS total_pay_amt_usd,

    ((bill_amt1_usd + bill_amt2_usd + bill_amt3_usd + bill_amt4_usd + bill_amt5_usd + bill_amt6_usd) / 6.0)
        AS avg_monthly_bill_usd,

    ((pay_amt1_usd + pay_amt2_usd + pay_amt3_usd + pay_amt4_usd + pay_amt5_usd + pay_amt6_usd) / 6.0)
        AS avg_monthly_pay_usd,

    GREATEST(pay_0, pay_2, pay_3, pay_4, pay_5, pay_6)
        AS worst_pay_status,

    CASE
        WHEN GREATEST(pay_0, pay_2, pay_3, pay_4, pay_5, pay_6) >= 1 THEN 1
        ELSE 0
    END AS any_delinquency_flag

FROM credit_usd;

Data Validation and Quality Checks

Several checks were used to confirm the dataset loaded correctly and to understand value ranges.

Record Count
SELECT COUNT(*) AS row_count
FROM credit_raw;

Value Range Checks (Limits and Totals)
SELECT
    MIN(limit_bal_usd) AS min_limit,
    MAX(limit_bal_usd) AS max_limit
FROM credit_usd;

SELECT
    MIN(total_bill_amt_usd) AS min_total_bill,
    MAX(total_bill_amt_usd) AS max_total_bill,
    MIN(total_pay_amt_usd) AS min_total_pay,
    MAX(total_pay_amt_usd) AS max_total_pay
FROM credit_features;

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

Recommended Visuals

These visuals are ideal for a portfolio project and clearly communicate results:

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
