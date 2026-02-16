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
