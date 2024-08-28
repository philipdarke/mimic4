-- THIS SCRIPT IS AUTOMATICALLY GENERATED. DO NOT EDIT IT DIRECTLY.
DROP TABLE IF EXISTS derived.norepinephrine; CREATE TABLE derived.norepinephrine AS
SELECT
  stay_id,
  linkorderid,
  CASE
    WHEN rateuom = 'mg/kg/min' AND patientweight = 1
    THEN rate
    WHEN rateuom = 'mg/kg/min'
    THEN rate * 1000.0
    ELSE rate
  END AS vaso_rate,
  amount AS vaso_amount,
  starttime,
  endtime
FROM icu.inputevents
WHERE
  itemid = 221906
