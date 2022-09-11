WITH qngr AS (
SELECT DATE_TRUNC('MONTH', __time) AS mm, brand, SUM(ngr) AS sum_ngr
FROM ngr
GROUP BY 1, 2),
qnrc AS (
SELECT DATE_TRUNC('MONTH', __time) AS mm, brand, SUM(nrc) AS sum_nrc
FROM nrc
GROUP BY 1, 2)
SELECT qngr.mm, qngr.brand, sum_ngr, sum_nrc FROM qngr JOIN qnrc
ON qngr.mm = qnrc.mm
AND qngr.brand = qnrc.brand
