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


summary(UK_AccidentData)

summary(UK_CasualtyData)

summary(UK_VehicleData)


glimpse(UK_AccidentData)

glimpse(UK_CasualtyData)

glimpse(UK_VehicleData)


View(UK_AccidentData)

View(UK_CasualtyData)

View(UK_VehicleData)


colnames(UK_AccidentData)

UK_AccidentData %>% 
  group_by(Number_of_Casualties,Number_of_Vehicles) %>% 
  summarise(Speed_limit = min(Speed_limit))
  
  
  select(Accident_Index, Speed_limit) %>% 
  View()

UK_AccidentData %>% 
  select(Number_of_Casualties,Speed_limit) %>% 
  group_by(Speed_limit) %>% 
  View()


UK_AccidentData %>% 
  select(Speed_limit) %>% 
  summarise(Speed_limit = min(Speed_limit))

mean(UK_AccidentData$Number_of_Vehicles)
mean(UK_AccidentData$Number_of_Casualties)
mean(UK_AccidentData$Accident_Severity)

median()

median(UK_AccidentData$Number_of_Vehicles)
median(UK_AccidentData$Number_of_Casualties)
median(UK_AccidentData$Accident_Severity)

UK_AccidentData %>% 
  drop_na(Speed_limit) %>% 
  mean(UK_AccidentData$Speed_limit)






