BULK INSERT uk_accidents

FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Accident Tables\dftRoadSafetyData_Accidents_2015.csv'

WITH (
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   FIRSTROW = 2
);

DELETE uk_accidents


/*
uk_accidents
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Accident Tables\dftRoadSafetyData_Accidents_2015.csv'
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Accident Tables\dftRoadSafetyData_Accidents_2016.csv'
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Accident Tables\dftRoadSafetyData_Accidents_2017.csv'
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Accident Tables\dftRoadSafetyData_Accidents_2018.csv'

uk_vehicles
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Vehicle Tables\dftRoadSafetyData_Vehicles_2015.csv'
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Vehicle Tables\dftRoadSafetyData_Vehicles_2016.csv'
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Vehicle Tables\dftRoadSafetyData_Vehicles_2017.csv'
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Vehicle Tables\dftRoadSafetyData_Vehicles_2018.csv'

DELETE uk_casualties

uk_casualties
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Casualty Tables\dftRoadSafetyData_Casualties_2015.csv'
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Casualty Tables\dftRoadSafetyData_Casualties_2016.csv'
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Casualty Tables\dftRoadSafetyData_Casualties_2017.csv'
FROM 'C:\Users\darre\My Drive (dwolfe.data@gmail.com)\!Datasets\Amplify_Interview_UKRoadSafety\Casualty Tables\dftRoadSafetyData_Casualties_2018.csv'


*/