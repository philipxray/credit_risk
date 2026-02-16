
Negative Statement Balances

A small number of accounts have negative statement balances, which can occur due to refunds, charge reversals, or overpayments. These values were retained as valid credit account behavior.

SELECT COUNT(*) AS negative_total_bill_count
FROM credit_features
WHERE total_bill_amt_usd < 0;
