REPLACE INTO cume_data OVERWRITE ALL
WITH ext AS (SELECT *
FROM TABLE(
  EXTERN(
    '{"type":"inline","data":"ts,customer,revenue\n2022-01-01,alice,10.50\n2022-01-01,bob,11.50\n2022-01-02,alice,12.50\n2022-01-02,bob,13.50\n2022-01-02,bob,14.00\n2022-01-03,alice,14.50\n2022-01-03,bob,15.50"}',
    '{"type":"csv","findColumnsFromHeader":true}',
    '[{"name":"ts","type":"string"},{"name":"customer","type":"string"},{"name":"revenue","type":"double"}]'
  )
))
SELECT
  TIME_PARSE(ts) AS __time,
  customer,
  revenue
FROM ext
PARTITIONED BY DAY
CLUSTERED BY 2
