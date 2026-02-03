-- Note: The original file contains an a header of variable names that is used for predictive models. 
-- this row needs to be removed prior to importing the file. The simplist method to do this is to open the file in excel and manually remove/delete the row.

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

-- check/confirm that column was created, check column's data type and add column 'limit_bal'
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'credit_raw'



