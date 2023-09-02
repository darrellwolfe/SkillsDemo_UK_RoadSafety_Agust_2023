

--DROP TABLE uk_vehicles
--DROP TABLE uk_casualties
--DROP TABLE uk_accidents


CREATE TABLE uk_accidents (
    Accident_Index VARCHAR(20),
    Location_Easting_OSGR INT,
    Location_Northing_OSGR INT,
    Longitude FLOAT,
    Latitude FLOAT,
    Police_Force INT,
    Accident_Severity INT,
    Number_of_Vehicles INT,
    Number_of_Casualties INT,
    Date VARCHAR(15),
    Day_of_Week INT,
    Time TIME,
    Local_Authority_District INT,
    Local_Authority_Highway VARCHAR(10),
    First_Road_Class INT,
    First_Road_Number INT,
    Road_Type INT,
    Speed_limit INT,
    Junction_Detail INT,
    Junction_Control INT,
    Second_Road_Class INT,
    Second_Road_Number INT,
    Pedestrian_Crossing_Human_Control INT,
    Pedestrian_Crossing_Physical_Facilities INT,
    Light_Conditions INT,
    Weather_Conditions INT,
    Road_Surface_Conditions INT,
    Special_Conditions_at_Site INT,
    Carriageway_Hazards INT,
    Urban_or_Rural_Area INT,
    Did_Police_Officer_Attend_Scene_of_Accident INT,
    LSOA_of_Accident_Location VARCHAR(20)
);

