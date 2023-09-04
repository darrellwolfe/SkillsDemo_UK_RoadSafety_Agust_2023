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

attach(UK_AccidentData)
names(UK_AccidentData)
length(UK_AccidentData)
class()
length()
unique()
View(sort(table()), descreasing = TRUE)
barplot(sort(table()), decreasing = TRUE)


Browse[2]> names(UK_AccidentData)
[1] "Accident_Index"                             IDs
[2] "Location_Easting_OSGR"                      
[3] "Location_Northing_OSGR"                     
[4] "Longitude"                                  Tableau
[5] "Latitude"                                   Tableau
[6] "Police_Force" Which police dept                               Does this indicate anything useful?
[7] "Accident_Severity" Fatal, Serious, Slight (links with casualty table)                         Important Variable
[8] "Number_of_Vehicles"                         Important Variable
[9] "Number_of_Casualties"                       Important Variable
[10] "Day_of_Week"                               Does day or time matter?
[11] "Time"                                      Does day or time matter?
[12] "Local_Authority_District" Location Names  Are some authority areas worse?
[13] "Local_Authority_Highway"  Location Names                 
[14] "First_Road_Class"                          Maybe
[15] "First_Road_Number"                         Maybe
[16] "Road_Type" Roundabout, one way, etc.      How does the road type affect accidents?
[17] "Speed_limit"                               Do speed limits have any correlation with accidents or casualties?
[18] "Junction_Detail"                           Maybe
[19] "Junction_Control"                          Maybe
[20] "Second_Road_Class"                         Maybe
[21] "Second_Road_Number"                        Maybe
[22] "Pedestrian_Crossing_Human_Control" Types of crossings         Frequency?
[23] "Pedestrian_Crossing_Physical_Facilities" Types of crossings   Frequency?
[24] "Light_Conditions"                          Frequency?
[25] "Weather_Conditions"                        Frequency?
[26] "Road_Surface_Conditions"                   Frequency?
[27] "Special_Conditions_at_Site"                Could be interesting
[28] "Carriageway_Hazards"                       How often does this really happen?
[29] "Urban_or_Rural_Area"                       Which is greater and by how much?
[30] "Did_Police_Officer_Attend_Scene_of_Accident"Does this indicate anything useful?
[31] "LSOA_of_Accident_Location"                 Could be interesting
[32] "Date"                                     Does season matter?


  GPT-4 Explanations
The "1st Road Class" column in your UK Road Safety dataset likely indicates the classification of the primary road where the accident occurred. Each code refers to a type of road:
  
  - **1: Motorway**: These are high-speed roads with multiple lanes, generally designed for long-distance travel.
- **2: A(M)**: These are motorway-like roads that are technically part of the 'A' road network but meet motorway standards.
- **3: A**: These are major roads intended for large volumes of traffic, connecting cities and larger towns.
- **4: B**: These are secondary roads, usually connecting smaller towns and villages.
- **5: C**: These are tertiary roads, often serving local traffic.
- **6: Unclassified**: These are roads that haven't been classified within the standard system, typically residential or minor rural roads.

Understanding this variable can help you assess the types of roads that are more prone to accidents, which can be useful for your analysis.

Would you like to know more about how this variable could be useful in your analysis?
  
  
  The "Pedestrian_Crossing_Physical_Facilities" column in your UK Road Safety dataset refers to the types of physical crossing facilities available within 50 meters of where the accident occurred. Here's what each code means:
  
  - **0: No physical crossing facilities within 50 metres**: Indicates that there are no designated pedestrian crossing facilities near the accident site.
- **1: Zebra**: A zebra crossing, characterized by black and white stripes on the road and flashing yellow lights.
- **4: Pelican, puffin, toucan or similar non-junction pedestrian light crossing**: These are various types of controlled pedestrian crossings with traffic lights.
- **5: Pedestrian phase at traffic signal junction**: This means there's a traffic signal with a specific phase for pedestrian crossing.
- **7: Footbridge or subway**: Indicates an overpass or an underground passage for pedestrians.
- **8: Central refuge**: A safety island in the middle of the road where pedestrians can wait.
- **-1: Data missing or out of range**: Information is either not available or doesn't fit within the established categories.

This variable could be valuable for identifying patterns related to pedestrian safety and the effectiveness of different types of crossing facilities in preventing accidents.

Would you like to know more about how to incorporate this into your data analysis?
  
  
  
  
  
  
  Accidents Table

How many accidents involve 0, 1, 2, or more vehicles?
  
  How many accidents involve a casualty/injury of any kind? 
  
  How many accidents occur at various speed limit ranges? 
  
  How many accidents occur on which days of the week? 
  
  How many accidents occur at various light conditions? 
  
  How many accidents occur at various weather conditions? 
  
  How many accidents for each IMD?
  
  
  
  UK_AccidentData 


# As expected, most accidents involved two vehicles, then one, then three.
# Numbers drop off significantly after this.
UK_AccidentData %>% 
  count(Number_of_Vehicles)

# At first glance, this doesn't appear to say much. Weekends are fewer.
UK_AccidentData %>% 
  count(Day_of_Week)

# There are a LOT more accidents at 30 MPH than at any other speed limit.
UK_AccidentData %>% 
  count(Speed_limit)

# The vast majority of accidents occur during the day (when most are driving)
# Next is darkness in well lit aready (again, where most people are driving)
UK_AccidentData %>% 
  count(Light_Conditions)

# The lion share of accidents occur when weather is fine (when most people are driving)
# Of the remaining, the most occur in rain.
UK_AccidentData %>% 
  count(Weather_Conditions)

# Not useful, needs better grouping. 
#UK_AccidentData %>% 
#  count(Time)

# This will be very useful for Visualization in Tableau, 
# added this new column to table in SQL

UK_AccidentData %>% 
  mutate(TimeGroup = case_when(
    Time >= "06:00:00.0000000" & Time < "9:00:00.0000000" ~ "Morning_Commute",
    Time >= "09:00:00.0000000" & Time < "11:00:00.0000000" ~ "Morning_Late",
    Time >= "11:00:00.0000000" & Time < "13:00:00.0000000" ~ "Lunch_Hours",
    Time >= "13:00:00.0000000" & Time < "17:00:00.0000000" ~ "Afternoon",
    Time >= "17:00:00.0000000" & Time < "20:00:00.0000000" ~ "Evening_Commute",
    Time >= "20:00:00.0000000" & Time < "21:00:00.0000000" ~ "Evening_Late",
    TRUE ~ "Late_Night"
  )) %>% 
  count(TimeGroup)

# Most accidents occur in the Afternoon (1p-5p)
# Second most occur during the evening commute (5p-8p)

UK_AccidentData %>% 
  count(TimeGroup)


# Seems fairly evenly dispersed?
UK_AccidentData %>% 
  count(Police_Force)

# Seems fairly evenly dispersed?

UK_AccidentData %>% 
  count(Local_Authority_District)

# Seems fairly evenly dispersed?
UK_AccidentData %>% 
  count(Local_Authority_Highway)

# The following three seem evenly dispersed. 
# Maybe let's get a dashboard with these?
# See if anything pops out visually?

# Seems fairly evenly dispersed?
UK_AccidentData %>% 
  count(Police_Force) %>% 
  arrange(-n) %>% 
  head(10)

# Seems fairly evenly dispersed?

UK_AccidentData %>% 
  count(Local_Authority_District) %>%
  arrange(-n) %>%
  head(10)


# Seems fairly evenly dispersed?
UK_AccidentData %>% 
  count(Local_Authority_Highway) %>%
  arrange(-n) %>%
  head(10)



# Maybe let's get a dashboard with these and see if anything pops out visually?


# No Intersection & T Intersections are most common accident types.
# That is surprising, given the MPH 30 thing? Let's look at MPH, Junctions, and Time. 

UK_AccidentData %>% 
  count(Junction_Detail)

# Mostly missing data (-1)
UK_AccidentData %>% 
  count(Junction_Control)

# Mostly missing data (-1), filter these out.
# With (-1, missing data) filtered out, these show a strong preference for 4.
# Uncontroled intersections lead the way.
UK_AccidentData %>% 
  filter(Junction_Control != -1) %>% 
  count(Junction_Control)

# One lane roads dominate
UK_AccidentData %>% 
  count(Road_Type)

# Most accidents (383,735) occurred on dry roads.
# 2nd Most (131,236) on wet roads.
# As these are the two most common road conditions, that is only so helpful to know.
UK_AccidentData %>% 
  count(Road_Surface_Conditions)

# Roughly 3/4 of accidents had a Police Officer
# Roughly 1/4 did not
# A fraction had no police officer but did self-report via a form.
UK_AccidentData %>% 
  count(Did_Police_Officer_Attend_Scene_of_Accident)
































