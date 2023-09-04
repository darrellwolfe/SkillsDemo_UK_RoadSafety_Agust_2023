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

UK_CasualtyData <- sqlFetch(connection, "dbo.uk_casualties")

UK_VehicleData <- sqlFetch(connection, "dbo.uk_vehicles")


attach(UK_VehicleData)
names(UK_VehicleData)
length(UK_VehicleData)
class()
length()
unique()
View(sort(table()), descreasing = TRUE)
barplot(sort(table()), decreasing = TRUE)


Browse[2]> names(UK_VehicleData) 23 Variables

"Accident_Index" IDs
"Vehicle_Reference" IDs (which vehicle)
"Vehicle_Type" Seld Expl
"Towing_and_Articulation" Was a tow needed?
"Vehicle_Manoeuvre" Parking, reversing, still, in motion, etc.
"Vehicle_Location_Restricted_Lane" Type of lane, or in road?
"Junction_Location" Intersection type, if any.
"Skidding_and_Overturning" If exists, skidding, jacknifed, etc.
"Hit_Object_in_Carriageway" Prevoius accident, road work, bridge, etc.
"Vehicle_Leaving_Carriageway" Did the vehicle leave the road? If so, where toward?
"Hit_Object_off_Carriageway" Sign, lamp post, tree, etc.
"First_Point_of_Impact" Front, Back, etc.
"Was_Vehicle_Left_Hand_Drive" Y/N
"Journey_Purpose_of_Driver" Could be interesting, but with most unknown, not helpful.
"Sex_of_Driver" M/F
"Age_of_Driver" Age
"Age_Band_of_Driver" Ages by grouping
"Engine_Capacity_CC" Size of engine
"Propulsion_Code" Type of gas/electric
"Age_of_Vehicle" Age of Car
"Driver_IMD_Decile" Poverty index
"Driver_Home_Area_Type" Urban, Rural, etc.
"Vehicle_IMD_Decile" Poverty index


Vehicles Table

How many of each vehicle type? We know cars are most common, but which are 2nd or 3rd?
  
  Which Manoeuvres are most common?
  
  Besides main roads, which other Locations are common?
  
  Explore variables, see what else sticks out.



UK_VehicleData 











