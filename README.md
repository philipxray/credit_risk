# credit_risk
Default Credit Risk analysis
## Executive Summary
Project Title

Credit Card Default Risk Analysis (SQL + Feature Engineering in PostgreSQL)

1. Executive Summary (5–8 lines)

What you analyzed

What tools you used

What you built (tables + features)

2–3 key findings (even if early)

2. Business Questions

Examples (keep it simple):

What behaviors are most associated with default?

How does delinquency relate to default?

Does utilization signal risk?

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
