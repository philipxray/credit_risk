# Credit Risk Analysis (SQL + PostgreSQL)

**Exploratory analysis of factors associated with credit card default risk to inform data-driven decision making.**

---

## Project Overview

This project analyzes a credit card default dataset to uncover behavioral and financial patterns associated with customer default. The objective is to demonstrate core data analyst skills — including data cleaning, SQL querying, feature engineering, segmentation, and insight communication — while identifying meaningful indicators of default risk.

This project was completed after finishing the Google Data Analytics Professional Certificate and represents an end-to-end exploratory analysis using SQL and Power BI.

---

## Dataset

**Source:** Taiwan Credit Card Default Dataset  
UCI Machine Learning Repository  

The dataset contains repayment history, bill amounts, and payment amounts over a six-month period for credit card clients. Each record represents one account.

### Key Variables Used

- `default_flag` — Binary indicator (1 = default, 0 = non-default)
- `late_months_count` — Number of months with late payments
- `worst_pay_status` — Most severe delinquency level observed
- `utilization_rate` — Credit balance divided by credit limit
- `payment_coverage_ratio` — Payment amount divided by outstanding balance
- `risk_score` — Composite metric engineered to prioritize high-risk accounts

---

## Tools Used

- PostgreSQL  
- SQL  
- Power BI  
- GitHub  

---

# Business Questions

1. Which customers exhibit higher default risk based on delinquency behavior?  
2. How does repayment history relate to default outcomes?  
3. How do balances and payments differ between default vs. non-default accounts?  
4. Which segments show the highest default rates?  
5. What factors seem most related to customers defaulting?  
6. Are there early warning signs before someone defaults?  
7. If we had to review only 20% of accounts, who should we focus on?

---

# Exploratory Analysis

---

## 1. Which customers exhibit higher default risk based on delinquency behavior?

Customers were segmented based on whether they experienced any delinquency during the six-month observation period.

![Default Rate by Delinquency vs No Delinquency](https://raw.githubusercontent.com/philipxray/credit_risk/refs/heads/credit_default_risk_eda/visuals/q1_default_rate_by_any_delinquency.png)

Accounts with at least one late payment show a substantially higher default rate compared to accounts with no recorded delinquency.

### Insight
Repayment behavior deterioration is a strong predictor of default.

### Business Implication
Even a single delinquency event should trigger enhanced monitoring, as behavioral repayment issues materially increase default probability.

---

## 2. How does repayment history relate to default outcomes?

Repayment history was analyzed using both frequency (`late_months_count`) and severity (`worst_pay_status`).

![Default Rate by Worst Pay Status](https://raw.githubusercontent.com/philipxray/credit_risk/refs/heads/credit_default_risk_eda/visuals/q2_default_rate_by_worst_status.png)

Higher delinquency severity levels correspond to progressively higher default rates.

### Insight
Both how often and how severely an account becomes delinquent are meaningful indicators of future default risk.

### Business Implication
Accounts reaching higher delinquency levels should be prioritized for intervention or review.

---

## 3. How do balances and payments differ between default vs. non-default accounts?

Balances and payments were compared between defaulting and non-defaulting customers.

![Balance Comparison Default vs Non-Default](https://raw.githubusercontent.com/philipxray/credit_risk/refs/heads/credit_default_risk_eda/visuals/q3_balance_comparison.png)

![Payment Coverage Comparison](https://raw.githubusercontent.com/philipxray/credit_risk/refs/heads/credit_default_risk_eda/visuals/q3_payment_comparison.png)

Defaulting customers generally exhibit:

- Higher credit utilization  
- Lower payment coverage ratios  
- Greater reliance on available credit  

### Insight
How customers manage their credit — particularly utilization and payment strength — appears more predictive of default than static balance amounts alone.

### Business Implication
Monitoring payment-to-balance ratios alongside utilization can improve early identification of financial stress.

---

## 4. Which segments show the highest default rates?

Customers were segmented by utilization levels to identify risk clusters.

![Default Rate by Utilization Level](https://raw.githubusercontent.com/philipxray/credit_risk/refs/heads/credit_default_risk_eda/visuals/q4_default_rate_by_utilization.png)

Default rates increase as utilization rises. Accounts above approximately 60% utilization show notably higher default rates compared to lower utilization groups.

### Insight
Risk is not evenly distributed across the portfolio; it clusters in identifiable behavioral segments.

### Business Implication
Utilization thresholds (e.g., >60%) can serve as monitoring triggers for proactive risk management.

---

## 5. What factors seem most related to customers defaulting?

Across all analyses, the factors most associated with default include:

- Any history of delinquency  
- Increasing number of late payment months  
- Higher delinquency severity  
- Elevated utilization  
- Lower payment coverage ratios  

When examined together, these risk factors show a compounding effect — customers with multiple high-risk indicators are far more likely to default.

### Insight
Default risk is behavioral and cumulative rather than driven by a single variable.

---

## 6. Are there early warning signs before someone defaults?

Several early warning patterns emerge from the data:

- Initial occurrence of delinquency  
- Rising utilization rates  
- Declining payment coverage ratios  
- Escalating delinquency severity  

### Insight
Risk escalation is progressive — small deteriorations in repayment behavior often precede default events.

### Business Implication
Monitoring trends, not just current status, can allow for earlier intervention before default occurs.

---

## 7. If we had to review only 20% of accounts, who should we focus on?

A composite `risk_score` was engineered using:

- Delinquency frequency  
- Delinquency severity  
- Utilization rate  
- Payment coverage ratio  

Accounts were ranked and segmented into the top 20% highest-risk cohort.

![Default Rate by Risk Segment](https://raw.githubusercontent.com/philipxray/credit_risk/refs/heads/credit_default_risk_eda/visuals/q7_risk_segment_default_comparison.png)

The top 20% segment captures a disproportionately higher share of defaults compared to the remaining 80%.

![Top 20% Risk Accounts Table](https://raw.githubusercontent.com/philipxray/credit_risk/refs/heads/credit_default_risk_eda/visuals/q7_top_20_percent_risk_table.png)

The highest-risk accounts generally exhibit:

- Multiple late months  
- High delinquency severity  
- Elevated utilization  
- Low payment coverage ratios  

### Insight
The composite risk score effectively concentrates default risk into a manageable review segment.

### Business Implication
If operational capacity is limited, prioritizing the top 20% highest-risk accounts would maximize review impact and resource efficiency.

---

# Key Takeaways

- Behavioral indicators (delinquency frequency and severity) are primary drivers of default risk.  
- High utilization and weak payment coverage signal financial stress.  
- Risk escalates progressively rather than appearing suddenly.  
- Composite risk segmentation effectively prioritizes accounts for review.  

---

# Limitations

- Dataset covers a limited six-month observation window.  
- No predictive modeling was performed.  
- Risk score is heuristic and not statistically optimized.  
- External economic factors are not included.  

---

# Conclusion

This project demonstrates an end-to-end exploratory data analysis workflow using SQL and Power BI. Through data cleaning, feature engineering, segmentation, and visualization, key behavioral and financial indicators of credit default risk were identified.

The findings support the idea that early behavioral signals — particularly delinquency patterns and utilization trends — are actionable indicators for proactive credit risk management.
