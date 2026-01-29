


--Record Count
SELECT COUNT(*) AS row_count
FROM credit_raw;

--Value Range Checks (Limits and Totals)
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
