

--Creating Views

CREATE VIEW Pass_Pop_Des AS
SELECT
    c.CITY_NAME,
    c.POPULATION,
    SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS,
    COUNT(f.FLIGHT_ID) AS TOTAL_FLIGHTS,
    ROUND(SUM(fm.PASSENGERS) / c.POPULATION, 2) AS PASS_POP_RATIO
FROM City_New c
JOIN Airport a ON a.CITY_NAME = c.CITY_NAME
JOIN Flight f ON f.DEST_AIRPORT_ID = a.AIRPORT_ID
JOIN FlightMetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
GROUP BY c.CITY_NAME, c.POPULATION;



create view Pass_Pop_Ori as
SELECT
    c.CITY_NAME,
    c.POPULATION,
    SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS,
    COUNT(f.FLIGHT_ID) AS TOTAL_FLIGHTS,
    ROUND(SUM(fm.PASSENGERS) / c.POPULATION, 2) AS PASS_POP_RATIO
FROM City_New c
JOIN Airport a ON a.CITY_NAME = c.CITY_NAME
JOIN Flight f ON f.ORIGIN_AIRPORT_ID = a.AIRPORT_ID
JOIN FlightMetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
GROUP BY c.CITY_NAME, c.POPULATION;







--Create Stored procedures


CREATE PROCEDURE traffic
AS
BEGIN
    SELECT
        a.CITY_NAME AS DEST_CITY,
        SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS,
        COUNT(f.FLIGHT_ID) AS TOTAL_FLIGHTS
    FROM Flight f
    JOIN FlightMetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
    JOIN Airport a ON f.DEST_AIRPORT_ID = a.AIRPORT_ID
    GROUP BY a.CITY_NAME
    ORDER BY TOTAL_FLIGHTS DESC;
END;
GO

EXEC traffic; 



CREATE PROCEDURE State_level_traffic(
    @State VARCHAR(30))
AS
BEGIN
    SELECT
        a.CITY_NAME AS ORIGIN_CITY,
        SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS,
        COUNT(f.FLIGHT_ID) AS TOTAL_FLIGHTS
    FROM Flight f
    JOIN FlightMetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
    JOIN Airport a ON f.ORIGIN_AIRPORT_ID = a.AIRPORT_ID
    WHERE a.STATE_NM = @state
    GROUP BY a.CITY_NAME
    ORDER BY TOTAL_FLIGHTS DESC;
END;
GO


EXEC State_level_traffic @State = 'California';



CREATE PROCEDURE sp_top_routes_by_passenger
    @Threshold INT
AS
BEGIN
    SELECT
        a1.CITY_NAME AS ORIGIN_CITY,
        a2.CITY_NAME AS DEST_CITY,
        SUM(fm.PASSENGERS) AS TOTAL_PASSENGERS
    FROM Flight f
    JOIN FlightMetrics fm ON f.FLIGHT_ID = fm.FLIGHT_ID
    JOIN Airport a1 ON f.ORIGIN_AIRPORT_ID = a1.AIRPORT_ID
    JOIN Airport a2 ON f.DEST_AIRPORT_ID = a2.AIRPORT_ID
    GROUP BY a1.CITY_NAME, a2.CITY_NAME
    HAVING SUM(fm.PASSENGERS) > @Threshold
    ORDER BY TOTAL_PASSENGERS DESC;
END;
GO

EXEC sp_top_routes_by_passenger 100000;
