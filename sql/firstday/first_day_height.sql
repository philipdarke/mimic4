-- THIS SCRIPT IS AUTOMATICALLY GENERATED. DO NOT EDIT IT DIRECTLY.
DROP TABLE IF EXISTS derived.first_day_height; CREATE TABLE derived.first_day_height AS
SELECT
  ie.subject_id,
  ie.stay_id,
  ROUND(TRY_CAST(AVG(height) AS DECIMAL), 2) AS height
FROM icu.icustays AS ie
LEFT JOIN derived.height AS ht
  ON ie.stay_id = ht.stay_id
  AND ht.charttime >= ie.intime - INTERVAL '6' HOUR
  AND ht.charttime <= ie.intime + INTERVAL '1' DAY
GROUP BY
  ie.subject_id,
  ie.stay_id
