
# INSTALL PACKAGES
install.packages("DBI")
install.packages("odbc")
install.packages("RODBC")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("ggmap")
install.packages("sqldf")
install.packages("geosphere")

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

# ESTABLISH CONNECTION TO MY LOCAL DATABASE

connection <- odbcDriverConnect("driver={SQL Server};server=LAPTOP-76LHVPRQ\\SQLEXPRESS;database=UK_RoadSafety;trusted_connection=true")


# ASSIGN THE DATABASE TABLE AS A DATAFRAME (df) VARIABLE FOR EASIER RECALL

UK_AccidentData <- sqlFetch(connection, "dbo.uk_accidents")
write.csv(UK_AccidentData, "C:/Users/darre/My Drive (dwolfe.data@gmail.com)/!Datasets/Amplify_Interview_UKRoadSafety/CLEANED DATA/UK_AccidentData.csv", row.names = FALSE)


UK_CasualtyData <- sqlFetch(connection, "dbo.uk_casualties")
write.csv(UK_CasualtyData, "C:/Users/darre/My Drive (dwolfe.data@gmail.com)/!Datasets/Amplify_Interview_UKRoadSafety/CLEANED DATA/UK_CasualtyData.csv", row.names = FALSE)

UK_VehicleData <- sqlFetch(connection, "dbo.uk_vehicles")
write.csv(UK_VehicleData, "C:/Users/darre/My Drive (dwolfe.data@gmail.com)/!Datasets/Amplify_Interview_UKRoadSafety/CLEANED DATA/UK_VehicleData.csv", row.names = FALSE)


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















