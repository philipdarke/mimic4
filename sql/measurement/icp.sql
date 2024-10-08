-- THIS SCRIPT IS AUTOMATICALLY GENERATED. DO NOT EDIT IT DIRECTLY.
DROP TABLE IF EXISTS derived.icp; CREATE TABLE derived.icp AS
WITH ce AS (
  SELECT
    ce.subject_id,
    ce.stay_id,
    ce.charttime,
    CASE WHEN valuenum > 0 AND valuenum < 100 THEN valuenum ELSE NULL END AS icp
  FROM icu.chartevents AS ce
  WHERE
    ce.itemid IN (220765, 227989)
)
SELECT
  ce.subject_id,
  ce.stay_id,
  ce.charttime,
  MAX(icp) AS icp
FROM ce
GROUP BY
  ce.subject_id,
  ce.stay_id,
  ce.charttime
