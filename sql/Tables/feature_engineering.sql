--1. Average Monthly Balance (USD)

ALTER TABLE credit_features
ADD COLUMN avg_monthly_balance_usd NUMERIC;

UPDATE credit_features
SET avg_monthly_balance_usd = total_bill_amt_usd / 6;

--2. Average Payment Amount (USD)
ALTER TABLE credit_features
ADD COLUMN avg_pay_amt_usd NUMERIC;

UPDATE credit_features
SET avg_pay_amt_usd = total_pay_amt_usd / 6;

--3. Utilization Proxy

ALTER TABLE credit_features
ADD COLUMN util_proxy_usd NUMERIC;

UPDATE credit_features
SET util_proxy_usd = avg_monthly_balance_usd / NULLIF(limit_bal_usd, 0);

--4. Payment Coverage Ratio

ALTER TABLE credit_features
ADD COLUMN payment_coverage_ratio NUMERIC;

UPDATE credit_features
SET payment_coverage_ratio = 
    NULLIF(total_pay_amt_usd, 0) / NULLIF(total_bill_amt_usd, 0);

--5. Late Month Count
ALTER TABLE credit_features
ADD COLUMN late_months_count INTEGER;

UPDATE credit_features
SET late_months_count =
    (pay_0 > 0)::int +
    (pay_2 > 0)::int +
    (pay_3 > 0)::int +
    (pay_4 > 0)::int +
    (pay_5 > 0)::int +
    (pay_6 > 0)::int;

-- (for the above script) 
--Values:
--1 = paid more than owed
--≈1 = paid what was owed
--<1 = paid less than owed
