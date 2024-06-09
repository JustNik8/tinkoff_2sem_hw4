CREATE TABLE payments_for_parents
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

CREATE MATERIALIZED VIEW payments_for_parents_mv TO payments_for_parents AS
SELECT payment_id,
       payment_date,
       purpose,
       category,
       money,
       idx
FROM payments
WHERE category != 'gaming' AND category != 'useless'
