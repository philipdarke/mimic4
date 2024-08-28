-- THIS SCRIPT IS AUTOMATICALLY GENERATED. DO NOT EDIT IT DIRECTLY.
DROP TABLE IF EXISTS derived.vasopressin; CREATE TABLE derived.vasopressin AS
SELECT
  stay_id,
  linkorderid,
  CASE WHEN rateuom = 'units/min' THEN rate * 60.0 ELSE rate END AS vaso_rate,
  amount AS vaso_amount,
  starttime,
  endtime
FROM icu.inputevents
WHERE
  itemid = 222315
