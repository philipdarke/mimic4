-- THIS SCRIPT IS AUTOMATICALLY GENERATED. DO NOT EDIT IT DIRECTLY.
DROP TABLE IF EXISTS derived.first_day_urine_output; CREATE TABLE derived.first_day_urine_output AS
SELECT
  ie.subject_id,
  ie.stay_id,
  SUM(urineoutput) AS urineoutput
FROM icu.icustays AS ie
LEFT JOIN derived.urine_output AS uo
  ON ie.stay_id = uo.stay_id
  AND uo.charttime >= ie.intime
  AND uo.charttime <= ie.intime + INTERVAL '1' DAY
GROUP BY
  ie.subject_id,
  ie.stay_id
