SELECT *
FROM uk_accidents


SELECT DISTINCT
COUNT(a.Accident_Index) AS CountAccidents
FROM uk_accidents AS a
-- 325986 Without distinct
-- 325986 With distinct


SELECT DISTINCT
	a.Date
,	COUNT(a.Accident_Index) AS CountAccidents
FROM uk_accidents AS a
--WHERE a.Date LIKE '30/09%'
GROUP BY a.Date
ORDER BY a.Date DESC


30/09/2016
30/09/2017

Sep 30 201

