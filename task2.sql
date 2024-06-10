CREATE TABLE payments
(
    payment_id   String,
    payment_date Date,
    purpose      String,
    category     String,
    money        Int64,
    idx          Int64
)
    ENGINE = ReplacingMergeTree(idx)
ORDER BY (payment_date, category, payment_id);

CREATE MATERIALIZED VIEW payments_mv TO payments AS
SELECT JSONExtractString(value, 'id')       as payment_id,
       JSONExtractString(value, 'date')     as payment_date,
       JSONExtractString(value, 'purpose')  as purpose,
       JSONExtractString(value, 'category') as category,
       JSONExtractInt(value, 'money')       as money,
       JSONExtractInt(value, 'index')       as idx
FROM source
WHERE JSONExtractString(value, 'type') == 'payment'
