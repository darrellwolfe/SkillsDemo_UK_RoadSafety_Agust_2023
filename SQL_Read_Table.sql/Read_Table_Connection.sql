-- !preview conn=conn


-- UK_AccidentData <- sqlFetch(connection, "dbo.uk_accidents")
-- UK_CasualtyData <- sqlFetch(connection, "dbo.uk_casualties")
-- UK_VehicleData <- sqlFetch(connection, "dbo.uk_vehicles")


select 
Vehicle_Reference,
First_Point_of_Impact, 
Hit_Object_in_Carriageway, 
Hit_Object_off_Carriageway,
Vehicle_Manoeuvre,
count(Accident_Index) as count_of_incidents
from dbo.uk_vehicles
where Vehicle_Reference in ('1','2')
and First_Point_of_Impact <> '-1'
and Hit_Object_in_Carriageway  <> '-1'
and Hit_Object_off_Carriageway  <> '-1'

group by 
Vehicle_Reference,
First_Point_of_Impact, 
Hit_Object_in_Carriageway, 
Hit_Object_off_Carriageway,
Vehicle_Manoeuvre

--having count(Accident_Index) = '1'


order by Vehicle_Reference, count_of_incidents DESC;