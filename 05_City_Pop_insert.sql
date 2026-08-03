

--- Compare passenger numbers across origin cities to identify top-performing airports.
--Q4.Total Passengers and Total No. of Flights

SELECT 
    a.CITY_NAME AS ORIGIN_CITY,
    SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS,
    COUNT(f.FLIGHT_ID) AS TOTAL_FLIGHTS
FROM Flight f
JOIN Flightmetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
JOIN Airport a ON f.ORIGIN_AIRPORT_ID = a.AIRPORT_ID
GROUP BY a.CITY_NAME
ORDER BY Total_Flights DESC;


-- Destination City

SELECT
    a.CITY_NAME AS DEST_CITY,
    SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS,
    COUNT(f.FLIGHT_ID) AS TOTAL_FLIGHTS
FROM Flight f
JOIN FlightMetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
JOIN Airport a ON f.DEST_AIRPORT_ID = a.AIRPORT_ID
GROUP BY a.CITY_NAME
ORDER BY TOTAL_FLIGHTS DESC;


--Q5. Prepare city population data for analysis

SELECT
    LEFT(c.CITYNAME, CHARINDEX(',', c.CITYNAME + ',') - 1) AS CITY_NAME,
    c.STATE_ABR,
    c.STATE_NM,
    a.POPULATION
FROM city c
LEFT JOIN all_city_pop as a
ON a.CITY_NAME = c.CITYNAME;






SELECT
    c.CITYID,
    LEFT(c.CITYNAME, CHARINDEX(',', c.CITYNAME + ',') - 1) AS CITY_NAME,
    c.STATE_ABR,
    c.STATE_NM,
    a.POPULATION
INTO City_New
FROM City c
LEFT JOIN all_city_pop a
ON a.City_Name = c.CityName;



