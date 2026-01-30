-- convert currency value columns from Taiwan to USD
-- instead of converting table i decided to preserve the table by creating a new one "credit_usd"

DROP TABLE IF EXISTS credit_usd;

CREATE TABLE credit_usd AS
SELECT
    id,
    limit_bal * 0.032 AS limit_bal_usd,
    sex,
    education,
    marriage,
    age,
    pay_0,
    pay_2,
    pay_3,
    pay_4,
    pay_5,
    pay_6,
    bill_amt1 * 0.032 AS bill_amt1_usd,
    bill_amt2 * 0.032 AS bill_amt2_usd,
    bill_amt3 * 0.032 AS bill_amt3_usd,
    bill_amt4 * 0.032 AS bill_amt4_usd,
    bill_amt5 * 0.032 AS bill_amt5_usd,
    bill_amt6 * 0.032 AS bill_amt6_usd,
    pay_amt1 * 0.032 AS pay_amt1_usd,
    pay_amt2 * 0.032 AS pay_amt2_usd,
    pay_amt3 * 0.032 AS pay_amt3_usd,
    pay_amt4 * 0.032 AS pay_amt4_usd,
    pay_amt5 * 0.032 AS pay_amt5_usd,
    pay_amt6 * 0.032 AS pay_amt6_usd,
    default_flag
FROM credit_staging;

-- check/confirm that column was created and check column's data type
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'credit_staging'
