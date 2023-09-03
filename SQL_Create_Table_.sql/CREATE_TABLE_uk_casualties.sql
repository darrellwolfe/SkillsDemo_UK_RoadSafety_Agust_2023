CREATE TABLE uk_casualties (
    Accident_Index VARCHAR(20),
    Vehicle_Reference INT,
    Casualty_Reference INT,
    Casualty_Class INT,
    Sex_of_Casualty INT,
    Age_of_Casualty INT,
    Age_Band_of_Casualty INT,
    Casualty_Severity INT,
    Pedestrian_Location INT,
    Pedestrian_Movement INT,
    Car_Passenger INT,
    Bus_or_Coach_Passenger INT,
    Pedestrian_Road_Maintenance_Worker INT,
    Casualty_Type INT,
    Casualty_Home_Area_Type INT,
    Casualty_IMD_Decile INT,
);


   -- FOREIGN KEY (Accident_Index) REFERENCES uk_accidents(Accident_Index)
