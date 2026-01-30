CREATE TABLE credit_raw (
    id INTEGER,
    limit_bal INTEGER,
    sex INTEGER,
    education INTEGER,
    marriage INTEGER,
    age INTEGER,

    pay_0 INTEGER,
    pay_2 INTEGER,
    pay_3 INTEGER,
    pay_4 INTEGER,
    pay_5 INTEGER,
    pay_6 INTEGER,

    bill_amt1 INTEGER,
    bill_amt2 INTEGER,
    bill_amt3 INTEGER,
    bill_amt4 INTEGER,
    bill_amt5 INTEGER,
    bill_amt6 INTEGER,

    pay_amt1 INTEGER,
    pay_amt2 INTEGER,
    pay_amt3 INTEGER,
    pay_amt4 INTEGER,
    pay_amt5 INTEGER,
    pay_amt6 INTEGER,

    default_payment_next_month INTEGER
);

NULLIF(
  regexp_replace(id, '[^0-9]', '', 'g'),
  ''
)::INTEGER

-- check/confirm that column was created, check column's data type and add column 'limit_bal'
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'credit_raw'
  AND column_name = 'limit_bal';



