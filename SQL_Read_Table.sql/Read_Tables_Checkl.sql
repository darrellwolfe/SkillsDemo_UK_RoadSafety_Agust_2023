Select *
From uk_accidents



VehicleNum_vs_Impact 
VehicleNum_vs_HitOnRoad
VehicleNum_vs_HitOffRoad

select 
Vehicle_Reference
, First_Point_of_Impact
, Hit_Object_in_Carriageway
, Hit_Object_off_Carriageway
from dbo.uk_accidents
where Vehicle_Reference in ('1','2')


VehicleNum_vs_Impact <- sqldf(
                        select 
                        Vehicle_Reference, 
                        First_Point_of_Impact, 
                        Hit_Object_in_Carriageway, 
                        Hit_Object_off_Carriageway
                        from 
                        where Vehicle_Reference in ('1','2')
                        )







