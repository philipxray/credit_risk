# Credit Risk Analysis (SQL + PostgreSQL)
### Executive Summary

### Project Overview
----
This project analyzes a credit card default dataset to explore patterns that may help predict default risk. Using PostgreSQL, I cleaned and transformed the data, converted financial values from Taiwan Dollars (TWD) to U.S. Dollars (USD), engineered risk-focused features, and generated summary outputs that can be used for reporting and dashboarding.

The goal of this project is to demonstrate practical data analyst skills, including:

   * Data cleaning and validation in SQL
   * Feature engineering for real-world business questions
   * Credit risk metric design and interpretation
   * Preparing analysis-ready tables for visualization

### Business Questions
----
#### This project focuses on questions commonly asked in credit risk and lending analytics:
  
   * 1. Which customers exhibit higher default risk based on delinquency behavior? 
   * 2. How does repayment history relate to default outcomes? 
   * 3. How do balances and payments differ between default vs. non-default accounts?
   * 4. Which segments show the highest default rates?
   * 5. What customer characteristics are most associated with default risk?
   * 6. Are there early warning signs before someone defaults?
   * 7. If we had to review only 20% of accounts, who should we focus on?
  
### Dataset
----
### Default of Credit Card Clients Dataset (Taiwan)

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



### 1. Which customers exhibit higher default risk based on delinquency behavior?
   
#### Customers were first segmented based on whether they experienced any delinquency during the six-month observation period.

<img width="601" height="562" alt="image" src="https://github.com/user-attachments/assets/443e9043-0ee2-4fba-8f05-c84c7ca7d3fa" />

<img width="495" height="113" alt="image" src="https://github.com/user-attachments/assets/da61458e-474b-4331-9327-1154e0c632c9" />

Customers with no delinquency exhibited a default rate of approximately  **11.7%**, while customers with at least one delinquent month had a default rate of approximately **42.7%**. This represents nearly a **4x** **_increase_** in default risk, indicating that even a single late payment is a strong early warning signal.


### 2. How does the frequency of delinquency impact default risk?

Repayment history was further analyzed using two measures:

Number of late months during the six-month window

Maximum delinquency severity (worst_pay_status)

Although the dataset spans six months, severity values may exceed six because they reflect cumulative months past due at the time of reporting.

Default rates were calculated across both delinquency frequency and severity levels.

Visual to Reference

* 📊 Bar chart: Default rate by late_months_count
* 📊 Bar chart: Default rate by severity bucket
* 📊 Table: Frequency/Severity | Customers | Default Rate

Interpretation

Default rates increased progressively as the number of late months increased. Similarly, customers reaching higher delinquency severity levels exhibited substantially higher default rates.

This monotonic relationship indicates that repayment deterioration compounds risk over time rather than occurring suddenly.

### 3. How do balances and payments differ between default vs. non-default accounts?

Average balances, credit utilization, and payment coverage ratios were compared between defaulting and non-defaulting customers.

Reference your comparison chart.

Visual to Reference

* 📊 Table: Default vs Non-Default — Avg Balance, Utilization, Payment Coverage
* 📊 Bar chart: Utilization comparison

Interpretation

Defaulting customers generally exhibited:

  * Higher credit utilization

  * Lower payment coverage ratios

  * Greater reliance on available credit

However, repayment behavior differences were more pronounced than balance differences, reinforcing that behavior is more predictive than static exposure levels.

### 4. Which segments show the highest default rates?

Customers were segmented using:

Delinquency frequency tiers

Delinquency severity tiers

Utilization buckets

Default rates were ranked across these segments.

Reference your segment ranking table.

Visual to Reference

📊 Table: Segment | Customers | Default Rate (ranked highest to lowest)

Interpretation

The highest default rates were observed among customers with:

Multiple late months (3+)

Severe delinquency levels (5+ months past due)

Utilization above 60%

These segments represent concentrated risk pockets within the portfolio.


### 5. What customer characteristics are most associated with default risk?

Across all segment comparisons, the variables most strongly associated with elevated default risk were:

Any history of delinquency

Increasing number of late months

High delinquency severity

Utilization above 60%

Low payment coverage ratios

Visual to Reference

📊 Summary table: Variable | Low Risk Default | High Risk Default | Risk Multiple

Interpretation

Behavioral repayment variables demonstrated the largest increases in default probability, often producing 3–5× differences between low- and high-risk groups. Financial exposure variables added incremental predictive power but were secondary to behavioral deterioration.

Analysis Question 6
6. Are there early warning signs before someone defaults?

Why this matters?
Credit risk management focuses on prevention, not just prediction.

What to Write

Customers with:

One late month

Moderate utilization (30–60%)

Declining payment coverage

were analyzed relative to baseline default rates.

Visual to Reference

📊 Comparison table: Baseline Default vs Early Warning Group

Interpretation

Even early-stage delinquency produced materially higher default rates than the portfolio average, indicating that default risk escalates gradually and can be detected before severe delinquency occurs.

Analysis Question 7 (Final Section)
7. If we had to review only 20% of accounts, who should we focus on?

Why end here?
This translates analysis into operational strategy.

What to Write

Accounts were prioritized based on combined risk indicators:

3+ late months

Severe delinquency levels

Utilization above 60%

Low payment coverage

The top 20% highest-risk accounts were evaluated for default concentration.

Visual to Reference

📊 Table: Top 20% Risk Segment | Default Rate | % of Total Defaults Captured

Interpretation

Concentrating review efforts on the highest-risk behavioral segments would disproportionately capture a large share of expected defaults, improving the efficiency of monitoring and intervention resources.

---------------------



Repayment behavior was analyzed using two measures:

Delinquency frequency (late_months_count)

Delinquency severity (worst_pay_status)

Frequency of Late Payments

Customers were grouped by the number of months they were late during the six-month window. Default rates increased progressively as the number of late months increased. Customers with multiple late months exhibited materially higher default rates compared to those with only one or no late payments.

This monotonic trend indicates that repeated delinquency reflects escalating financial instability.

<img width="1832" height="326" alt="image" src="https://github.com/user-attachments/assets/5ed2d839-4a1d-4e9b-865c-6d84eeaf50e8" />

Severity of Delinquency

Customers were also segmented based on the maximum delinquency severity reached during any billing cycle. Severity values (e.g., 5+ months past due) represent cumulative delinquency duration at that time and may reflect distress that began prior to the observation period.

Default rates increased sharply among customers reaching higher delinquency severity tiers, suggesting that prolonged repayment failure is one of the strongest predictors of eventual default.

Together, frequency and severity capture both short-term instability and deeper financial distress.

To further refine delinquency risk, customers were segmented by the number of months in which they were late.
  
<img width="1832" height="326" alt="image" src="https://github.com/user-attachments/assets/5ed2d839-4a1d-4e9b-865c-6d84eeaf50e8" />

   Default rates increased consistently as the number of late months increased, suggesting that delinquency frequency captures escalating risk beyond a simple binary flag.
   

### 3. Does the severity of delinquency matter?

   In addition to frequency, delinquency severity was analyzed using the worst recorded repayment status.

| Value | Months Past Due |
|-------|:---------------:| 
|   0   |   0 months past due /  Revolving / paid normally              |
|   1    |   1 month past due              |
|    2   |       2 months past due          |
|   3    |    3 months past due             |
|   4    |     4 months past due            |
|    5   |      5 months past due           |
|   6    |    6 months past due             |
|    7   |     7 months past due            |
|    8   |      8 months past due           |
|   -1    |     Paid in full            |
|  -2     |       No consumption / no bill activity / paid on time         |

````
#### Negative values (not delinquent)
-2 = No consumption / no bill activity (often means no balance used that month)
-1 = Paid in full / paid on time (no delinquency)
0 = Revolving / paid normally (not past due)
Positive values (delinquent)
1 = 1 month past due
2 = 2 months past due
3 = 3 months past due
4 = 4 months past due
5 = 5 months past due
6 = 6 months past due
7 = 7 months past due
8 = 8 months past due
````
### 4. How does credit utilization relate to default risk?

Customers were segmented using industry-aligned credit utilization thresholds to assess whether higher reliance on credit corresponded with increased default risk.

<img width="608" height="209" alt="worst_pay_status_buckets" src="https://github.com/user-attachments/assets/7ec67a36-72f8-4f9b-89e5-1b0fbd70ea31" />

Customers whose worst observed delinquency severity reached 7–8 months past due

Across all analyses, delinquency behavior emerged as the strongest predictor of default risk, followed by credit utilization levels. Customers exhibiting repeated late payments or high utilization consistently demonstrated elevated default rates. These findings suggest that early behavioral signals can be used to identify high-risk customers before default occurs, supporting proactive credit risk monitoring and intervention.
