--Analysis Queries

Default Rate (Overall)
SELECT
    default_flag,
    COUNT(*) AS customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_total
FROM credit_features
GROUP BY default_flag
ORDER BY default_flag;

--Default Rate by Delinquency (Any Delinquency Flag)

SELECT
    any_delinquency_flag,
    COUNT(*) AS customers,
    ROUND(AVG(default_flag::numeric), 4) AS default_rate
FROM credit_features
GROUP BY any_delinquency_flag
ORDER BY any_delinquency_flag;

--Default Rate by Worst Pay Status

SELECT
    worst_pay_status,
    COUNT(*) AS customers,
    ROUND(AVG(default_flag::numeric), 4) AS default_rate
FROM credit_features
GROUP BY worst_pay_status
ORDER BY worst_pay_status;

--Average Balance and Payment by Default Flag

SELECT
    default_flag,
    ROUND(AVG(avg_monthly_bill_usd), 2) AS avg_monthly_bill_usd,
    ROUND(AVG(avg_monthly_pay_usd), 2) AS avg_monthly_pay_usd,
    ROUND(AVG(total_bill_amt_usd), 2) AS avg_total_bill_usd,
    ROUND(AVG(total_pay_amt_usd), 2) AS avg_total_pay_usd
FROM credit_features
GROUP BY default_flag
ORDER BY default_flag;

--Credit Utilization (Estimated)

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
