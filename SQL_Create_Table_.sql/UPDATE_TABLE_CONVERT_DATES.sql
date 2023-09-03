-- Started over in Power Query and re-imported. Saving for future Reference.

DELETE uk_accidents

DELETE uk_casualties

DELETE uk_vehicles

-- New VARCHAR length
ALTER TABLE uk_accidents
ALTER COLUMN LSOA_of_Accident_Location VARCHAR(20);

--Accidentally created a new column US DATE
ALTER TABLE uk_accidents
DROP COLUMN US_Date;




WITH CTE AS (
  SELECT
    Accident_Index
,    ROW_NUMBER() OVER (PARTITION BY Accident_Index ORDER BY (SELECT NULL)) AS rn
  FROM uk_accidents
)

SELECT *
FROM CTE
WHERE rn < 1



WITH CTE AS (
  SELECT
    Accident_Index
,   Number_of_Vehicles
,   Number_of_Casualties
,   Date
,   Time
,    ROW_NUMBER() OVER (PARTITION BY Accident_Index ORDER BY (SELECT NULL)) AS rn
  FROM uk_accidents
)

SELECT *
FROM CTE
WHERE rn > 1

-- Delete Duplicates
WITH CTE AS (
  SELECT 
    Accident_Index, 
    ROW_NUMBER() OVER (PARTITION BY Accident_Index ORDER BY (SELECT NULL)) AS rn
  FROM uk_accidents
)
DELETE FROM CTE WHERE rn > 1;
--    (203308 row(s) affected)


SELECT *
FROM uk_accidents 
WHERE Accident_Index IS NULL;


--Delete NULLs
DELETE FROM uk_accidents WHERE Accident_Index IS NULL;
--    (0 row(s) affected)

SELECT Accident_Index
FROM uk_accidents
WHERE ISNUMERIC(Accident_Index) = 0;


--Add Primary Key
-- Make the column non-nullable
ALTER TABLE uk_accidents
ALTER COLUMN Accident_Index VARCHAR(50) NOT NULL;

-- Add primary key
ALTER TABLE uk_accidents
ADD PRIMARY KEY (Accident_Index);

-- Make the column non-nullable
ALTER TABLE uk_vehicles
ALTER COLUMN Accident_Index VARCHAR(50) NOT NULL;

-- Make the column non-nullable
ALTER TABLE uk_casualties
ALTER COLUMN Accident_Index VARCHAR(50) NOT NULL;

ALTER TABLE uk_casualties
ADD CONSTRAINT FK_AccidentIndex_Casualties FOREIGN KEY (Accident_Index) REFERENCES uk_accidents(Accident_Index);

ALTER TABLE uk_vehicles
ADD CONSTRAINT FK_AccidentIndex_Vehicles FOREIGN KEY (Accident_Index) REFERENCES uk_accidents(Accident_Index);


SELECT DISTINCT *
FROM uk_casualties c
LEFT JOIN uk_accidents a ON c.Accident_Index = a.Accident_Index
WHERE a.Accident_Index IS NOT NULL;

SELECT DISTINCT c.Accident_Index
FROM uk_casualties c
LEFT JOIN uk_accidents a ON c.Accident_Index = a.Accident_Index
WHERE a.Accident_Index IS NULL;












--Before
30/09/2016
30/09/2017

--Update
UPDATE uk_accidents
SET Date = CONVERT(DATETIME, Date, 103);

--After
Sep 30 201

UPDATE uk_accidents
SET Date = FORMAT(CONVERT(DATETIME, Date, 103), 'MM dd yyyy')


-- New Attempt
UPDATE uk_accidents
SET Date = FORMAT(CONVERT(DATE, TRIM(Date), 103), 'dd/mm/yyyy')

ALTER TABLE uk_accidents
ALTER COLUMN Date DATETIME;





 
/*

-- Step 3
ALTER TABLE uk_accidents ADD US_Date DATETIME;
UPDATE uk_accidents
SET Date = CONVERT(DATETIME, Date, 103);


EXAMPLE, start by importing the date as text, then conver the date to the format native to the data set.

CREATE TABLE YourTable (
  ID INT PRIMARY KEY,
  EuropeanDate VARCHAR(10),
  ...
);


UPDATE YourTable
SET EuropeanDate = CONVERT(DATETIME, EuropeanDate, 103);

--Step 1, create the table with date as text
CREATE TABLE uk_accidents (
    Accident_Index BIGINT PRIMARY KEY,
... Date VARCHAR(10),

-- Step 2
UPDATE YourTable
SET Date = CONVERT(DATETIME, Date, 103);

-- Step 3
ALTER TABLE uk_accidents ADD US_Date DATETIME;
UPDATE uk_accidents
SET US_Date = CONVERT(DATETIME, Date, 103);



*/