# Analysis

The objective of this analysis is to identify behavioral and financial patterns associated with increased credit default risk. Using engineered features derived from six months of billing and repayment history (April–September 2005), customers were segmented across delinquency behavior, credit utilization, and payment coverage metrics. Default rates were then compared across these segments to determine which customer characteristics are most strongly associated with elevated risk.

Importantly, while the dataset contains six months of billing records, delinquency severity values may exceed six months because the `pay_status` variables reflect cumulative months past due at the time of reporting. Therefore, severity captures long-term distress, whereas late_months_count captures repayment behavior within the six-month observation window. These represent distinct dimensions of risk.
****
> 1. Which Customers Exhibit Higher Default Risk?
****
Customers were first segmented based on whether they experienced any delinquency during the observation window.
<img width="691" height="118" alt="image" src="https://github.com/user-attachments/assets/f63bf330-e87b-43e5-9f06-67295a14124e" />

Customers with no late payments demonstrated substantially lower default rates compared to customers with at least one late month. The presence of even a single delinquency corresponded with a sharp increase in default probability, indicating that repayment behavior deterioration is an early and meaningful risk signal.

This suggests that behavioral repayment history is more predictive of default than static balance levels alone.
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
<img width="1832" height="326" alt="late_months_monotonic_trend" src="https://github.com/user-attachments/assets/baae8648-98ba-4945-a3ce-f59623646bea" />

Severity of Delinquency

Customers were also segmented based on the maximum delinquency severity reached during any billing cycle. Severity values (e.g., 5+ months past due) represent cumulative delinquency duration at that time and may reflect distress that began prior to the observation period.


<img width="665" height="391" alt="image" src="https://github.com/user-attachments/assets/cf4b7a55-9862-477c-8416-0bc8a4e2f668" />

Default rates increased sharply among customers reaching higher delinquency severity tiers, suggesting that prolonged repayment failure is one of the strongest predictors of eventual default.

Together, frequency and severity capture both short-term instability and deeper financial distress.
****
> 3. How Do Balances and Payments Differ Between Default and Non-Default Accounts?
****
To evaluate financial exposure, average balances, bill amounts, and payment amounts were compared between defaulting and non-defaulting customers.

Defaulting customers generally exhibited:

* Higher credit utilization rates

* Lower payment coverage ratios

* Greater reliance on available credit
<img width="758" height="118" alt="image" src="https://github.com/user-attachments/assets/969e0a6d-826d-41ef-9fa5-cc1fd34620ea" />
However, absolute balance size alone was not as predictive as repayment behavior metrics. Customers with moderate balances but deteriorating payment patterns were often riskier than customers with higher balances who consistently paid on time.

This suggests that how customers manage their credit is more informative than how much credit they hold.
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

Default rates increased as utilization rose, particularly above the 60% threshold. Customers in high utilization tiers exhibited meaningfully elevated default rates relative to lower-utilization segments.

When high utilization coincided with repeated delinquency, default risk was significantly amplified.

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

Behavioral variables consistently showed larger differences in default rates than static balance measures.

This suggests that repayment deterioration is the dominant driver of default in this portfolio.
****
> 6. Are There Early Warning Signs Before Default?
****
Default rarely occurred without prior behavioral signals.

* Early indicators observed include:

* First instance of delinquency

* Rising utilization above 30%

* Increasing frequency of late payments

* Declining payment coverage ratio
<img width="894" height="118" alt="image" src="https://github.com/user-attachments/assets/e600d599-99af-4dde-ac2a-db5ea357c4ba" />

Customers often transitioned from mild delinquency to repeated lateness before reaching severe default states. Monitoring early-stage deterioration may allow for proactive intervention before accounts become deeply distressed.

This highlights the value of early behavioral monitoring in credit risk management.
****
> 7. If Only 20% of Accounts Could Be Reviewed, Where Should Focus Be Placed?
****
Given limited operational capacity, risk review efforts should concentrate on the highest-risk segments.

The top 20% highest-risk accounts would likely include:

* Customers with 3+ late months

* Customers reaching 5+ months past due severity

* Customers with utilization above 60%

* Customers with low payment coverage ratios

Prioritizing these segments would concentrate review resources on accounts exhibiting the strongest observed risk signals, maximizing potential default mitigation impact.
****
Final Summary
****
Across all analyses, delinquency behavior emerged as the strongest predictor of default risk, followed by credit utilization and payment coverage metrics. Customers exhibiting repeated or severe delinquency consistently demonstrated materially higher default rates.

These findings suggest that early behavioral signals — particularly first-time delinquency and rising utilization — can serve as actionable indicators for proactive risk management.

By combining behavioral and financial indicators, institutions can better identify high-risk customers and allocate monitoring resources more effectively.
