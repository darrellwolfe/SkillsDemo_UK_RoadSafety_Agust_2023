-- !preview conn=conn


-- UK_AccidentData <- sqlFetch(connection, "dbo.uk_accidents")
-- UK_CasualtyData <- sqlFetch(connection, "dbo.uk_casualties")
-- UK_VehicleData <- sqlFetch(connection, "dbo.uk_vehicles")


-- How many accidents had how many vehicles and casualties?
select
  count(a.Accident_Index) AS Count_Incidents,
  a.Light_Conditions,
  a.Weather_Conditions,
  a.Road_Surface_Conditions,
  v.Vehicle_Reference,
  c.Casualty_Reference
  
  from uk_accidents as a
  join uk_vehicles as v
    on a.Accident_Index=v.Accident_Index
  join uk_casualties as c 
    on a.Accident_Index=c.Accident_Index
    and v.Vehicle_Reference=c.Vehicle_Reference
  
  group by 
  a.Light_Conditions,
  a.Weather_Conditions,
  a.Road_Surface_Conditions,
  v.Vehicle_Reference,
  c.Casualty_Reference
  
  order by
  v.Vehicle_Reference,
  c.Casualty_Reference