-- THIS SCRIPT IS AUTOMATICALLY GENERATED. DO NOT EDIT IT DIRECTLY.
DROP TABLE IF EXISTS derived.dopamine; CREATE TABLE derived.dopamine AS
SELECT
  stay_id,
  linkorderid,
  rate AS vaso_rate,
  amount AS vaso_amount,
  starttime,
  endtime
FROM icu.inputevents
WHERE
  itemid = 221662
