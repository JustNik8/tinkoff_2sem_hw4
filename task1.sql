CREATE TABLE counters
(
    id    String,
    count Int64
) engine = SummingMergeTree()
ORDER BY id;

CREATE MATERIALIZED VIEW counters_mv TO counters AS
SELECT
    simpleJSONExtractString(value, 'id') as id,
    SUM(simpleJSONExtractInt(value, 'value')) as count
FROM source
WHERE simpleJSONExtractString(value, 'type') == 'counter'
GROUP BY id