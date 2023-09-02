
--Step 1, create the table with date as text
CREATE TABLE uk_accidents (
    Accident_Index BIGINT PRIMARY KEY,
... UK_Date VARCHAR(10),

-- Step 2
UPDATE YourTable
SET UK_Date = CONVERT(DATETIME, UK_Date, 103);

-- Step 3
ALTER TABLE uk_accidents ADD US_Date DATETIME;
UPDATE uk_accidents
SET US_Date = CONVERT(DATETIME, UK_Date, 103);

 
/*
EXAMPLE, start by importing the date as text, then conver the date to the format native to the data set.

CREATE TABLE YourTable (
  ID INT PRIMARY KEY,
  EuropeanDate VARCHAR(10),
  ...
);


UPDATE YourTable
SET EuropeanDate = CONVERT(DATETIME, EuropeanDate, 103);
*/