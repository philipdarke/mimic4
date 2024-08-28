-- THIS SCRIPT IS AUTOMATICALLY GENERATED. DO NOT EDIT IT DIRECTLY.
DROP TABLE IF EXISTS derived.urine_output; CREATE TABLE derived.urine_output AS
WITH uo AS (
  SELECT
    oe.stay_id,
    oe.charttime,
    CASE WHEN oe.itemid = 227488 AND oe.value > 0 THEN -1 * oe.value ELSE oe.value END AS urineoutput
  FROM icu.outputevents AS oe
  WHERE
    itemid IN (226559, 226560, 226561, 226584, 226563, 226564, 226565, 226567, 226557, 226558, 227488, 227489)
)
SELECT
  stay_id,
  charttime,
  SUM(urineoutput) AS urineoutput
FROM uo
GROUP BY
  stay_id,
  charttime
