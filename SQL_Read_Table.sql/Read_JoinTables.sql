-- !preview conn=conn


-- UK_AccidentData <- sqlFetch(connection, "dbo.uk_accidents")
-- UK_CasualtyData <- sqlFetch(connection, "dbo.uk_casualties")
-- UK_VehicleData <- sqlFetch(connection, "dbo.uk_vehicles")

select *

from uk_accidents as a

join uk_vehicles as v
  on a.Accident_Index=v.Accident_Index

join uk_casualties as c 
  on a.Accident_Index=c.Accident_Index
  and v.Vehicle_Reference=c.Vehicle_Reference
  
  