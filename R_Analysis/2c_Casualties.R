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

View(UK_CasualtyData)
attach(UK_CasualtyData)
names(UK_CasualtyData)
length(UK_CasualtyData)
class()
length()
unique()
View(sort(table()), descreasing = TRUE)
barplot(sort(table()), decreasing = TRUE)


Browse[2]> names(UK_CasualtyData) 16 Variables
"Accident_Index" IDs
"Vehicle_Reference" IDs (which car)               
"Casualty_Reference" IDs (which casualty)                
"Casualty_Class" Driver Passenger, etc                     
"Sex_of_Casualty" M/F                    
"Age_of_Casualty" How old                   
"Age_Band_of_Casualty" Age Range for grouping               
"Casualty_Severity" Fatal, Serious, Slight                 
"Pedestrian_Location" Pedestrian interactions (sidewalk, crossing, etc)              
"Pedestrian_Movement" Pedestrian interaction, how they were moving in relation to vehicle               
"Car_Passenger" In car, where in care, out of car, etc.                     
"Bus_or_Coach_Passenger" In a large passenger vehicle?            
"Pedestrian_Road_Maintenance_Worker" Self explan
"Casualty_Type" < Informative, this one says pedestrian, cyclist, car occupant, etc.                      
"Casualty_Home_Area_Type" Urban, Rural, Small Town, etc.          
"Casualty_IMD_Decile" ?? Huh ?? Bascially a poverty index.
1	Most deprived 10%
2	More deprived 10-20%
3	More deprived 20-30%
4	More deprived 30-40%
5	More deprived 40-50%
6	Less deprived 40-50%
7	Less deprived 30-40%
8	Less deprived 20-30%
9	Less deprived 10-20%
10	Least deprived 10%
-1	Data missing or out of range

GPT-4 Explains Deprivation:
Deprivation generally refers to a lack of resources, opportunities, and services, leading to a lower quality of life. In the context of the UK's Index of Multiple Deprivation (IMD), it's a composite measure that considers a range of indicators across various domains such as:
  
  - Income
- Employment
- Health and Disability
- Education, Skills, and Training
- Crime
- Barriers to Housing and Services
- Living Environment

Areas are ranked based on these factors, and the ranks are then divided into deciles (10% segments) to easily categorize them from "most deprived" to "least deprived."

Understanding deprivation levels can provide valuable context when analyzing data, such as your UK Road Safety dataset. For instance, areas with higher deprivation might have different types of road safety issues compared to less deprived areas.

The "Casualty_IMD_Decile" column in your UK Road Safety dataset likely refers to the Index of Multiple Deprivation (IMD) decile for the area where the casualty (i.e., the person injured or killed in a road accident) resides. IMD is a measure used in the UK to identify the level of deprivation in different areas.

- 1: Most deprived 10% means that the casualty comes from an area that is among the 10% most deprived areas in the UK.
- 2-5: More deprived 10-50% indicates varying levels of deprivation, but still more deprived than the national average.
- 6-9: Less deprived 10-50% represents areas that are less deprived than the national average.
- 10: Least deprived 10% means the casualty comes from an area that is among the 10% least deprived in the UK.
- -1: Data missing or out of range indicates that the information is not available or does not fit within the established range.

Understanding this variable can help you analyze how road safety incidents might be correlated with socio-economic factors.

  
  


Casualty Table 

How many casualties for each sex/gender? 
  
  How many casualties for each age band? 
  
  How many casualties for each Home Areas? 
  
  How many casualties for each IMD?


UK_CasualtyData 
  
colnames(UK_CasualtyData)

# Roughly double M vs F
UK_CasualtyData %>% 
  count(Sex_of_Casualty)
  
# The data set is too long, using age bands is better.
# Unlike the Time in the Accident table, this one is already grouped.
#UK_CasualtyData %>% 
 # count(Age_of_Casualty)

# Probably a bell curve? 
# Highest at 6 (26-35) and 7 (36-45) with tapering on both sides.
# Probably a reflection of the age average among the general population.
UK_CasualtyData %>% 
  count(Age_Band_of_Casualty)

# Casualties roughly divided between Vehicle 1 & 2
# Some casualties in multi-car crashes, with fewer and fewere the more cars involved.
# As expected.
UK_CasualtyData %>% 
  count(Vehicle_Reference)

# Most casualties "Not Car Passenger"? 
# Does that mean they weren't in THIS car, or weren't in any car?
# Does that mean most were pedestrians? But that doesn't align with other data?
UK_CasualtyData %>% 
  count(Car_Passenger)

# Most (vast majority) not a Pedestrian, as stated above.
UK_CasualtyData %>% 
  count(Pedestrian_Location)

# Most (vast majority) not a Pedestrian, as stated above.
UK_CasualtyData %>% 
  count(Pedestrian_Movement)

# Vast majority not a bus or coach passenger, as expected.
UK_CasualtyData %>% 
  count(Bus_or_Coach_Passenger)

# Urban 485,508
# Small Town 52,300
# Rural 65,163
# Large number no data
UK_CasualtyData %>% 
  count(Casualty_Home_Area_Type)

# For those with data, seems evenly spread Poverty to Affluent
UK_CasualtyData %>% 
  count(Casualty_IMD_Decile)

# Driver 450,659
# Passenger 154,656
# Pedestrian 93,848
UK_CasualtyData %>% 
  count(Casualty_Class)

# Fatality 7,099
# Seriously Injured 96,587 
# Slight Injury 595,477
# This rings true to logic, but I actually thought fatalities would have been higher.
UK_CasualtyData %>% 
  count(Casualty_Severity)

# At least 347 road workers died 2015-2018
# While small, that's not nothing given the population size.
UK_CasualtyData %>% 
  count(Pedestrian_Road_Maintenance_Worker)

