-- THIS SCRIPT IS AUTOMATICALLY GENERATED. DO NOT EDIT IT DIRECTLY.
DROP TABLE IF EXISTS derived.phenylephrine; CREATE TABLE derived.phenylephrine AS
SELECT
  stay_id,
  linkorderid,
  CASE WHEN rateuom = 'mcg/min' THEN rate / patientweight ELSE rate END AS vaso_rate,
  amount AS vaso_amount,
  starttime,
  endtime
FROM icu.inputevents
WHERE
  itemid = 221749
