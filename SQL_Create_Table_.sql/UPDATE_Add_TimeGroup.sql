-- !preview conn=conn


SELECT TOP 100 *
FROM dbo.uk_accidents

/*
ALTER TABLE dbo.uk_accidents
ADD TimeGroup NVARCHAR(50);



UPDATE dbo.uk_accidents
SET TimeGroup = CASE
  WHEN Time >= '06:00:00.0000000' AND Time < '09:00:00.0000000' THEN 'Morning_Commute'
  WHEN Time >= '09:00:00.0000000' AND Time < '11:00:00.0000000' THEN 'Morning_Late'
  WHEN Time >= '11:00:00.0000000' AND Time < '13:00:00.0000000' THEN 'Lunch_Hours'
  WHEN Time >= '13:00:00.0000000' AND Time < '17:00:00.0000000' THEN 'Afternoon'
  WHEN Time >= '17:00:00.0000000' AND Time < '20:00:00.0000000' THEN 'Evening_Commute'
  WHEN Time >= '20:00:00.0000000' AND Time < '21:00:00.0000000' THEN 'Evening_Late'
  ELSE 'Late_Night'
END;
*/