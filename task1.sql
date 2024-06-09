CREATE TABLE counters
(
    id    String,
    count Int64
) engine = SummingMergeTree()
ORDER BY id;

CREATE MATERIALIZED VIEW counters_mv TO counters AS
SELECT
    JSONExtractString(value, 'id') as id,
    SUM(JSONExtractInt(value, 'value')) as count
FROM source
WHERE JSONExtractString(value, 'type') == 'counter'
GROUP BY id