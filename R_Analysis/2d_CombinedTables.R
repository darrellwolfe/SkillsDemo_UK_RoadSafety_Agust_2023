# LOAD LIBRARIES
library(DBI)
library(odbc)
library(RODBC)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(scales)
library(sqldf)
library(ggmap)
library(geosphere)
library(here)
library(skimr)
library(janitor)
library(Tmisc)

# ESTABLISH CONNECTION TO MY LOCAL DATABASE

connection <- odbcDriverConnect("driver={SQL Server};server=LAPTOP-76LHVPRQ\\SQLEXPRESS;database=UK_RoadSafety;trusted_connection=true")


# ASSIGN THE DATABASE TABLE AS A DATAFRAME (df) VARIABLE FOR EASIER RECALL

UK_AccidentData <- sqlFetch(connection, "dbo.uk_accidents")

UK_VehicleData <- sqlFetch(connection, "dbo.uk_vehicles")

UK_CasualtyData <- sqlFetch(connection, "dbo.uk_casualties")



All_Accident_Data <- sqldf(
                    "select *
                    from UK_AccidentData as a
                    join UK_VehicleData as v
                      on a.Accident_Index=v.Accident_Index
                    join UK_CasualtyData as c 
                      on a.Accident_Index=c.Accident_Index
                      and v.Vehicle_Reference=c.Vehicle_Reference;")

# View(All_Accident_Data)
head(All_Accident_Data)
summary(All_Accident_Data)
  
write.csv(All_Accident_Data, "C:/Users/darre/My Drive (dwolfe.data@gmail.com)/!Datasets/Amplify_Interview_UKRoadSafety/CLEANED DATA/All_Accident_Data.csv", row.names = FALSE)



Accidents_Vehicles_Casualties <- sqldf(
  "-- How many accidents had how many vehicles and casualties?
  select
  count(a.Accident_Index) AS Count_Incidents,
  v.Vehicle_Reference,
  c.Casualty_Reference
  
  from UK_AccidentData as a
  join UK_VehicleData as v
    on a.Accident_Index=v.Accident_Index
  join UK_CasualtyData as c 
    on a.Accident_Index=c.Accident_Index
    and v.Vehicle_Reference=c.Vehicle_Reference
  
  group by 
  v.Vehicle_Reference,
  c.Casualty_Reference
  
  order by
  v.Vehicle_Reference,
  c.Casualty_Reference")

# View(All_Accident_Data)
head(Accidents_Vehicles_Casualties)
summary(Accidents_Vehicles_Casualties)

write.csv(Accidents_Vehicles_Casualties, "C:/Users/darre/My Drive (dwolfe.data@gmail.com)/!Datasets/Amplify_Interview_UKRoadSafety/CLEANED DATA/Accidents_Vehicles_Casualties.csv", row.names = FALSE)




Accidents_Light_Weather <- sqldf(
  "-- How many accidents had how many vehicles and casualties?
select
  count(a.Accident_Index) AS Count_Incidents,
  a.Light_Conditions,
  a.Weather_Conditions,
  a.Road_Surface_Conditions,
  v.Vehicle_Reference,
  c.Casualty_Reference
  
  from UK_AccidentData as a
  join UK_VehicleData as v
    on a.Accident_Index=v.Accident_Index
  join UK_CasualtyData as c 
    on a.Accident_Index=c.Accident_Index
    and v.Vehicle_Reference=c.Vehicle_Reference
  
  where  a.Light_Conditions <> '-1'
  and a.Weather_Conditions <> '-1'
  and a.Road_Surface_Conditions <> '-1'
  
  group by 
  a.Light_Conditions,
  a.Weather_Conditions,
  a.Road_Surface_Conditions,
  v.Vehicle_Reference,
  c.Casualty_Reference
  
  order by
  v.Vehicle_Reference,
  c.Casualty_Reference")

# View(All_Accident_Data)
head(Accidents_Light_Weather)
summary(Accidents_Light_Weather)


write.csv(Accidents_Light_Weather, "C:/Users/darre/My Drive (dwolfe.data@gmail.com)/!Datasets/Amplify_Interview_UKRoadSafety/CLEANED DATA/Accidents_Light_Weather.csv", row.names = FALSE)

































