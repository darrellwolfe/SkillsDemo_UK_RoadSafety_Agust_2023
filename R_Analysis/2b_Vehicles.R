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

# Repeated from other analysis. 
# Most vehicles in accidents are in a one or two care accident.
# As expected, some accidents involve more than two cars, but far fewer.
UK_VehicleData %>% 
  count(Vehicle_Reference) %>% 
  arrange(-n) %>% 
  head(20)

# Cars most, then vans and motorcycles.
UK_VehicleData %>% 
  count(Vehicle_Type)

# The vast majority of vehicles were simply driving straight ahead
# I've heard about "Road Hypnosis", I wonder if this is at play?
# I think a visualization will tell more of the story for the others. 
UK_VehicleData %>% 
  count(Vehicle_Manoeuvre)

# Most accidents did not involve getting towed.
UK_VehicleData %>% 
  count(Towing_and_Articulation)

# Vast majority were on a Main road not in a restricted lane.
# Again, statistically, wouldn't this be expected?
UK_VehicleData %>% 
  count(Vehicle_Location_Restricted_Lane)

# A slight majority were not at an intersection
# The rest were doing some road change.
UK_VehicleData %>% 
  count(Junction_Location)

# Most did not skid
UK_VehicleData %>% 
  count(Skidding_and_Overturning)

# Most did not strike an object other than an in motion vehicle
# Of those that did strike an on-road object:
# 4 Parked Vehicle
# 10 Curb/Kerb
UK_VehicleData %>% 
  count(Hit_Object_in_Carriageway)

# Most did not strike an object other than an in motion vehicle
# Of those that4 did strike an off-road object:
# 4 Tree
# 10 "Other" Permanent Object
# 11 Wall or Fence
UK_VehicleData %>% 
  count(Hit_Object_off_Carriageway)

# The majority were not leaving the road,
# This aligns with the fact most were driving straigh ahead
# Oh those that did, the majority were
# Nearside (1)
# or Offside (7)
UK_VehicleData %>% 
  count(Vehicle_Leaving_Carriageway)

#Defining Unfamiliar Terms: 
# - **Nearside**: This is the side of the vehicle closest to the curb or side of the road. 

# In the UK, where driving is on the left-hand side of the road, 
#   the nearside would be the left side of the vehicle.

# - **Offside**: This is the side of the vehicle that is closest to the middle of the road. 
#     In the UK, this would be the right side of the vehicle.

# These terms are used to describe where a vehicle left the carriageway 
#   (i.e., the main part of the road). For example:
# - **"Nearside"**: The vehicle left the road and ended up on the side closest to the curb.
# - **"Offside"**: The vehicle left the road and ended up on the side closest to the middle of the road 
#   or possibly even crossed to the opposite side.

# Related to side, left-handed or not?
# Most were, in the UK where almost all cars were, no shockers here.
UK_VehicleData %>% 
  count(Was_Vehicle_Left_Hand_Drive)

# Most firs point of impact was front.
# This makes sense as there were a lot more vehicle one (529,172)
# than there were vehicle two (373,763) accidents.
# This means a significant amount were single car accidents striking something else.
UK_VehicleData %>% 
  count(First_Point_of_Impact)



#view(sqldf("sql here lower case"))
#variable_name <- sqldf("sql here lower case")
#view (variable_name)
# (Vehicle_Reference, First_Point_of_Impact, Hit_Object_in_Carriageway, Hit_Object_off_Carriageway) %>%
  

VehicleNum_vs_Impact 
VehicleNum_vs_HitOnRoad
VehicleNum_vs_HitOffRoad

VehicleNum_vs_Impact <- sqldf(
  "select 
  Vehicle_Reference,
  First_Point_of_Impact, 
  Hit_Object_in_Carriageway, 
  Hit_Object_off_Carriageway,
  Vehicle_Manoeuvre,
  count(Accident_Index) as count_of_incidents
  from UK_VehicleData
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
  
  
  order by Vehicle_Reference, count_of_incidents DESC;")


write.csv(VehicleNum_vs_Impact, "C:/Users/darre/My Drive (dwolfe.data@gmail.com)/!Datasets/Amplify_Interview_UKRoadSafety/CLEANED DATA/VehicleNum_vs_Impact.csv", row.names = FALSE)


# View SQL aggregates
View(VehicleNum_vs_Impact)
glimpse(VehicleNum_vs_Impact)
summarise(VehicleNum_vs_Impact)
summary(VehicleNum_vs_Impact)
head(VehicleNum_vs_Impact)
head.matrix(VehicleNum_vs_Impact)
skim(VehicleNum_vs_Impact)

