#Default Credit Risk analysis
## Project Background
## Executive Summary
1. What you analyzed

2. What tools you used

3. What you built (tables + features)

2–3 key findings (even if early)

## Business Questions + Objectives
Examples (keep it simple):

What behaviors are most associated with default?

How does delinquency relate to default?

Does utilization signal risk?
## Dataset Overview
### Data Pipeline
## Methodology
## Feature Engineering
| Feature                   | Description                              |
| ------------------------- | ---------------------------------------- |
| `limit_bal_usd`           | Credit limit in USD                      |
| `total_bill_amt_usd`      | Sum of six months of billing             |
| `total_pay_amt_usd`       | Sum of six months of payments            |
| `avg_monthly_balance_usd` | Average monthly balance                  |
| `avg_pay_amt_usd`         | Average payment per month                |
| `util_proxy_usd`          | Average balance relative to credit limit |
| `payment_coverage_ratio`  | Total paid vs total billed               |
| `worst_payment_status`    | Worst delinquency status over time       |
| `late_months_count`       | Count of months with late payments       |


## Analysis + Findings
## Reccommendations
### Limitations
Project Title

Credit Card Default Risk Analysis (SQL + Feature Engineering in PostgreSQL)

1. Executive Summary (5–8 lines)


2. Business Questions



3. Dataset Overview

Kaggle dataset name + source

Rows/columns

What the target is (default_flag)

What the main feature groups are (bills, payments, delinquency)

4. Data Pipeline

This is where you beat most entry-level analysts:

credit_raw (landing table)

credit_usd (cleaned + converted)

credit_features (engineered metrics)

5. Feature Engineering

List the features you created and why:

total bills / total payments

avg monthly balance

utilization proxy

late month count

worst payment status

6. Analysis + Findings

Use charts later if you want, but at minimum:

default rate overall

default rate by worst delinquency

default rate by utilization bucket

7. Recommendations

Example:

flag customers with 2+ late months

monitor high utilization + low payment coverage

8. Limitations

Example:

no true loss / recovery data

statement balances are snapshots, not charges

9. Appendix (SQL)

Include the key queries you used.
