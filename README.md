# Credit Risk Analysis (SQL + PostgreSQL)
**Exploratory analysis of factors associated with credit card default risk to inform data-driven decision making.**
****
### Executive Summary

This analysis aims to explore patterns related to credit risk in consumer credit card data. Understanding which factors are associated with default can help lenders make better decisions about underwriting, pricing, and monitoring portfolios. The insights generated serve as a foundation for risk reporting and potential predictive modeling.

****

### Project Overview
This project analyzes a credit card default dataset to uncover behavioral and financial patterns associated with default. The goal is to demonstrate practical data analyst skills including data cleaning, feature engineering, metric design, and summary insights that can support risk reporting and decision-making.

### Business Questions

#### This project focuses on questions commonly asked in credit risk and lending analytics:

   * 1. Which customers exhibit higher default risk based on delinquency behavior?
   * 2. How does repayment history relate to default outcomes?
   * 3. How do balances and payments differ between default vs. non-default accounts?
   * 4. Which segments show the highest default rates?
   * 5. What factors seem most related to customers defaulting?
   * 6. Are there early warning signs before someone defaults?
   * 7. If we had to review only 20% of accounts, who should we focus on?

****

### Dataset
Default of Credit Card Clients Dataset (Taiwan)
#### Source: UCI Machine Learning Repository https://archive.ics.uci.edu/dataset/350/default+of+credit+card+clients
##### I. Yeh. "Default of Credit Card Clients," UCI Machine Learning Repository, 2009. [Online]. Available: https://doi.org/10.24432/C55S3H.

****

#### Dataset contents include:

* Credit limit (`limit_bal`)

* Demographics (`SEX`, `EDUCATION`, `MARRIAGE`, `AGE`)

* Repayment status history (`pay_0,`- `pay_6`)
 
* Monthly statement balances (`bill_amt1_usd`-`bill_amt6_usd`)

* Monthly payments (`pay_amt1_usd`)

* Default indicator (`default_payment_next_month`)

Target variable:

`default_flag` (1 = defaulted, 0 = did not default)

****
> Key Variables Used in Analysis

| Variable                 | Description                                    |
| ------------------------ | ---------------------------------------------- |
| `default_flag`           | Binary indicator (1 = default, 0 = no default) |
| `late_months_count`      | Total months with late payments                |
| `worst_pay_status`       | Most severe delinquency status observed        |
| `utilization_rate`       | Credit balance divided by credit limit         |
| `payment_coverage_ratio` | Payment amount divided by outstanding balance  |
| `any_delinquency_flag`   | Indicator if any late payment occurred         |
****
## Limitations
- Only 6 months of data; full payment history unknown
- Severity may reflect prior behavior predating dataset window
- No model building was performed
  
### Tools Used

* PostgreSQL (SQL)
* pgAdmin 4 (database administration + CSV import)
* Power BI + DAX
* Tableau
****
### Data Preparation

Data cleaning and feature engineering were performed in PostgreSQL and Power BI.

Steps Included:

* Handled NULL values using `COALESCE`

* Engineered `utilization_rate`

* Engineered `payment_coverage_ratio`

* Created a composite `risk_score`

* Ranked accounts and segmented top 20% highest risk cohort

#### Risk Formula

````
risk_score =
COALESCE(late_months_count, 0)
+ COALESCE(worst_pay_status, 0)
+ COALESCE(utilization_rate, 0)
- COALESCE(payment_coverage_ratio, 0)
````
# Analysis

The objective of this analysis is to identify behavioral and financial patterns associated with increased credit default risk. Using engineered features derived from six months of billing and repayment history (April–September 2005), customers were segmented across delinquency behavior, credit utilization, and payment coverage metrics. Default rates were then compared across these segments to determine which customer characteristics are most strongly associated with elevated risk.

Importantly, while the dataset contains six months of billing records, delinquency severity values may exceed six months because the `pay_status` variables reflect cumulative months past due at the time of reporting. Therefore, severity captures long-term distress, whereas `late_months_count` captures repayment behavior within the six-month observation window. These represent distinct dimensions of risk.
****
> 1. Which Customers Exhibit Higher Default Risk?
****
Customers were segmented based on whether they experienced any delinquency during the six-month observation period.
Accounts with any history of delinquency exhibit a significantly higher default rate compared to accounts with no delinquency.

<img width="691" height="118" alt="image" src="https://github.com/user-attachments/assets/f63bf330-e87b-43e5-9f06-67295a14124e" />

Further analysis of:

* `late_months_count`

* `worst_pay_status`

shows that both the frequency and severity of missed payments are strongly associated with default.

<img width="601" height="562" alt="default_rate_by_delinquency_flag" src="https://github.com/user-attachments/assets/ccafe75e-44af-4667-932d-98974b8b9ef9" />

Customers with no late payments demonstrated substantially lower default rates compared to customers with at least one late month. The presence of even a single delinquency corresponded with a sharp increase in default probability, indicating that repayment behavior deterioration is an early and meaningful risk signal. This suggests that repayment behavior deterioration is a stronger predictor of default than static financial characteristics alone. Any delinquency is a strong early warning signal and should trigger enhanced monitoring or credit limit review.

****
> 2. How Does Repayment History Relate to Default Outcomes?
****
Repayment behavior was analyzed using two measures:

* Delinquency frequency (`late_months_count`)

* Delinquency severity (`worst_pay_status`)

* Frequency of Late Payments

 
<img width="674" height="278" alt="late_months_count_table" src="https://github.com/user-attachments/assets/4b546c71-5291-4c8d-95aa-1d32e71e0e78" />

Customers were grouped by the number of months they were late during the six-month window. Default rates increased progressively as the number of late months increased. Customers with multiple late months exhibited materially higher default rates compared to those with only one or no late payments.

This monotonic trend indicates that repeated delinquency reflects escalating financial instability.

<img width="679" height="455" alt="image" src="https://github.com/user-attachments/assets/2e0a72a7-0a63-4702-a567-aad262299db2" />


### Severity of Delinquency

Customers were also segmented based on the maximum delinquency severity reached during any billing cycle. Severity values (e.g., 5+ months past due) reflect the deepest level of repayment delinquency observed, and can capture broader financial stress beyond the six-month window.

<img width="665" height="391" alt="image" src="https://github.com/user-attachments/assets/cf4b7a55-9862-477c-8416-0bc8a4e2f668" />

<img width="629" height="429" alt="image" src="https://github.com/user-attachments/assets/72ac12f9-a612-4a9c-a8fe-a2c872f47729" />

Severity is often a stronger predictor than frequency alone. More severe delinquency statuses show materially higher default rates. As well default rates increased sharply among customers reaching higher delinquency severity tiers, suggesting that prolonged repayment failure is one of the strongest predictors of eventual default.
Together, frequency and severity capture both short-term instability and deeper financial distress. This indicates that both how often and how severely an account becomes delinquent are meaningful indicators of future default risk.
****
> 3. How Do Balances and Payments Differ Between Default and Non-Default Accounts?
****
To evaluate financial exposure, average balances, bill amounts, and payment amounts were compared between defaulting and non-defaulting customers.
Defaulting customers generally exhibited higher credit utilization and lower payment coverage ratios, which indicates a greater reliance on available credit and difficulty covering balances through payment.
These differences suggest that how customers manage their credit (behavior) is more predictive of default than simply the amount of credit they hold.
  
<img width="758" height="118" alt="image" src="https://github.com/user-attachments/assets/969e0a6d-826d-41ef-9fa5-cc1fd34620ea" />

<img width="770" height="722" alt="image" src="https://github.com/user-attachments/assets/e054fc45-5702-4cf5-9b1f-e984a21f91f7" />

However, absolute balance size alone was not as predictive as repayment behavior metrics. Customers with moderate balances but deteriorating payment patterns were often riskier than customers with higher balances who consistently paid on time. Defaulting customers appear to experience liquidity strain, reflected in high balances and insufficient payments. This suggests that how customers manage their credit is more informative than how much credit they hold and that payment to balance ratios may serve as early stress indicators, especially when paired with rising utilization.
****
> 4. Which Segments Show the Highest Default Rates?
****
Customers were segmented using industry-aligned utilization thresholds:

* Non-Users (0%)

* Optimal (1–10%)

* Healthy (11–30%)

* Moderate Risk (31–60%)

* High Risk (61–90%)

* Maxed Out (91%+)
  
<img width="695" height="239" alt="image" src="https://github.com/user-attachments/assets/fd046983-6d7e-49cd-9945-2c6d4376c3dc" />

<img width="590" height="451" alt="image" src="https://github.com/user-attachments/assets/925b2ede-b088-4160-8c5f-fbea3d717279" />

Segmenting by utilization levels shows default rates increasing with utilization. Accounts above ~60% utilization exhibit notably higher default rates compared to lower utilization groups.
Risk is not evenly distributed across the portfolio, it clusters in identifiable behavioral segments. Customers in high utilization tiers exhibited meaningfully elevated default rates relative to lower-utilization segments. When high utilization coincided with repeated delinquency, default risk was significantly amplified. This pattern suggests using utilization thresholds (e.g., >60%) for monitoring and early intervention triggers.
This indicates that credit reliance and repayment deterioration interact to compound risk.
****
> 5. What Factors Appear Most Related to Default?
****
Across all segmentation analyses, the strongest associations with default were:

* Any history of delinquency

* Increasing number of late months

* High delinquency severity (5+ months past due)

* Utilization rates above 60%

* Low payment coverage ratios

<img width="823" height="116" alt="image" src="https://github.com/user-attachments/assets/761c60e7-64d2-4f0e-a375-a64580fbacf8" />

When examined together, these risk factors show a compounding effect — customers with multiple high-risk indicators are far more likely to default. Behavioral variables consistently showed larger differences in default rates than static balance measures. Default risk appears behavioral and cumulative, not driven by a single factor. A composite scoring framework better captures default risk than any single metric in isolation.
This suggests that repayment deterioration is the dominant driver of default in this portfolio.
****
> 6. Are There Early Warning Signs Before Default?
****
Default rarely occurred without prior behavioral signals.

Early indicators observed include:

* First instance of delinquency

* Rising utilization above 30%

* Increasing frequency of late payments

* Declining payment coverage ratio
  
<img width="894" height="118" alt="image" src="https://github.com/user-attachments/assets/e600d599-99af-4dde-ac2a-db5ea357c4ba" />

<img width="565" height="572" alt="image" src="https://github.com/user-attachments/assets/6bf30e2f-62c4-4f0a-87c0-7ee5265c80c9" />


These patterns often appear before default occurs.This suggests that risk escalation is progressive — small deteriorations in repayment behavior often precede default events.
Customers often transitioned from mild delinquency to repeated lateness before reaching severe default states. Monitoring early-stage deterioration and trend shifts (not just current status) can enable earlier intervention and loss mitigation. This highlights the value of early behavioral monitoring in credit risk management.
****
> 7. If Only 20% of Accounts Could Be Reviewed, Where Should Focus Be Placed?
****
Given limited operational capacity, risk review efforts should concentrate on the highest-risk segments.

The top 20% highest-risk accounts by composite risk score include accounts with multiple late months, high delinquency severity, elevated utilization, and low payment coverage ratios.

<img width="784" height="644" alt="image" src="https://github.com/user-attachments/assets/d31b6c2d-6ff3-4def-9218-c961fb681f95" />

A composite `risk_score` was engineered using:

* Delinquency frequency

* Delinquency severity

* Utilization rate

* Payment coverage ratio

Accounts were ranked and segmented into:

* Top 20% highest risk

* Bottom 80% remaining accounts

The Top 20% segment exhibits a significantly higher default rate compared to the rest of the portfolio. The composite score effectively concentrates default risk into a manageable review segment. Prioritizing these segments would concentrate review resources on accounts exhibiting the strongest observed risk signals, maximizing potential default mitigation impact. If operational resources are limited, focusing on the top 20% highest risk accounts would maximize risk mitigation impact.
****
> Practical Recommendation

This segmentation approach can support resource prioritization for risk teams by focusing efforts where default probability is highest.
****
Final Summary
****
Across all analyses, delinquency behavior emerged as the strongest predictor of default risk, followed by credit utilization and payment coverage metrics. Customers exhibiting repeated or severe delinquency consistently demonstrated materially higher default rates.
Together, the analysis shows that early behavioral signals — particularly delinquency and utilization trends — are actionable indicators for proactive risk management.
By combining behavioral and financial indicators, institutions can better identify high-risk customers and allocate monitoring resources more effectively.
