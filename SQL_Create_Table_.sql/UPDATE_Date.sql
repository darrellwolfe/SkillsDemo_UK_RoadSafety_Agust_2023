







ALTER TABLE uk_accidents ADD Date_New DATE;

UPDATE uk_accidents SET Date_New = CAST(Date AS DATE);

--UPDATE uk_accidents SET Date_New = CONVERT(DATE, Date, 103);  -- 103 is for dd/mm/yyyy format

ALTER TABLE uk_accidents DROP COLUMN Date;


EXEC sp_rename 'uk_accidents.Date_New', 'Date', 'COLUMN';






SELECT Date 
FROM uk_accidents 
WHERE ISDATE(Date) = 0


-- Update the Date column to swap the day and month
UPDATE uk_accidents
SET Date = CONCAT(
    SUBSTRING(Date, 1, 4), '-', -- Year
    SUBSTRING(Date, 9, 2), '-', -- Day
    SUBSTRING(Date, 6, 2)      -- Month
)
WHERE ISDATE(Date) = 0;
