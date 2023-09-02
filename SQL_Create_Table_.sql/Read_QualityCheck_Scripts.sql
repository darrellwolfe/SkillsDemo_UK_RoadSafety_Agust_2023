SELECT TOP 100 *
FROM uk_accidents


SELECT TOP 100 *
FROM uk_casualties

SELECT TOP 100 *
FROM uk_vehicles


SELECT Date
FROM uk_accidents
WHERE ISDATE(CONVERT(DATETIME, Date, 103)) = 0;

SELECT *
FROM uk_accidents
WHERE Accident_Index = '2017077118735'

SELECT *
FROM uk_casualties
WHERE Accident_Index = '2017077118735'


SELECT DISTINCT *
FROM uk_casualties c
LEFT JOIN uk_accidents a ON c.Accident_Index = a.Accident_Index
WHERE a.Accident_Index IS NOT NULL;

SELECT DISTINCT c.Accident_Index
FROM uk_casualties c
LEFT JOIN uk_accidents a ON c.Accident_Index = a.Accident_Index
WHERE a.Accident_Index IS NULL;


  SELECT 
    Accident_Index, 
    ROW_NUMBER() OVER (PARTITION BY Accident_Index ORDER BY (SELECT NULL)) AS rn
  FROM uk_vehicles


  WITH CTE_CheckDupsC AS (
    SELECT *
--    c.Accident_Index
--,   c.Casualty_Reference
,    ROW_NUMBER() OVER (PARTITION BY Accident_Index, Casualty_Reference ORDER BY (SELECT NULL)) AS rn
  FROM uk_casualties AS c
  )

  SELECT *
  FROM CTE_CheckDupsC
 WHERE Accident_Index = '201604ED16270'
 -- WHERE rn > 1
  ORDER BY CTE_CheckDupsC.Accident_Index



    WITH CTE_CheckDupsV AS (
    SELECT *
--    c.Accident_Index
--,   c.Casualty_Reference
,    ROW_NUMBER() OVER (PARTITION BY Accident_Index, Vehicle_Reference ORDER BY (SELECT NULL)) AS rn
  FROM uk_vehicles AS c
  )

  SELECT *
  FROM CTE_CheckDupsV
 -- WHERE Accident_Index = '201604ED16270'
  WHERE rn > 1
  ORDER BY CTE_CheckDupsV.Accident_Index

  SELECT DISTINCT
COUNT(a.Accident_Index) AS CountAccidents

FROM uk_accidents AS a

-- 325986 Without distinct
-- 325986 With distinct

