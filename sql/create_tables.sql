
DROP TABLE IF EXISTS credit_features;

CREATE TABLE credit_features AS
SELECT
    id,
    limit_bal_usd,
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

    (
        bill_amt1_usd +
        bill_amt2_usd +
        bill_amt3_usd +
        bill_amt4_usd +
        bill_amt5_usd +
        bill_amt6_usd
    ) AS total_bill_amt_usd,

    (
        pay_amt1_usd +
        pay_amt2_usd +
        pay_amt3_usd +
        pay_amt4_usd +
        pay_amt5_usd +
        pay_amt6_usd
    ) AS total_pay_amt_usd,

    GREATEST(
        pay_0,
        pay_2,
        pay_3,
        pay_4,
        pay_5,
        pay_6
    ) AS worst_payment_status,

    default_flag

FROM credit_usd;
