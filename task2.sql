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
SELECT simpleJSONExtractString(value, 'id')       as payment_id,
       simpleJSONExtractString(value, 'date')     as payment_date,
       simpleJSONExtractString(value, 'purpose')  as purpose,
       simpleJSONExtractString(value, 'category') as category,
       simpleJSONExtractInt(value, 'money')       as money,
       simpleJSONExtractInt(value, 'index')       as idx
FROM source
WHERE simpleJSONExtractString(value, 'type') == 'payment'
