DROP TABLE IF EXISTS credit_features;

CREATE TABLE credit_features AS
SELECT
    id,
    limit_bal_usd,
    sex,
    education,
    marriage,
    age,
    default_flag,

    (bill_amt1_usd + bill_amt2_usd + bill_amt3_usd + bill_amt4_usd + bill_amt5_usd + bill_amt6_usd)
        AS total_bill_amt_usd,

    (pay_amt1_usd + pay_amt2_usd + pay_amt3_usd + pay_amt4_usd + pay_amt5_usd + pay_amt6_usd)
        AS total_pay_amt_usd,

    ((bill_amt1_usd + bill_amt2_usd + bill_amt3_usd + bill_amt4_usd + bill_amt5_usd + bill_amt6_usd) / 6.0)
        AS avg_monthly_bill_usd,

    ((pay_amt1_usd + pay_amt2_usd + pay_amt3_usd + pay_amt4_usd + pay_amt5_usd + pay_amt6_usd) / 6.0)
        AS avg_monthly_pay_usd,

    GREATEST(pay_0, pay_2, pay_3, pay_4, pay_5, pay_6)
        AS worst_pay_status,

    CASE
        WHEN GREATEST(pay_0, pay_2, pay_3, pay_4, pay_5, pay_6) >= 1 THEN 1
        ELSE 0
    END AS any_delinquency_flag

FROM credit_usd;


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

-- overlimit months
