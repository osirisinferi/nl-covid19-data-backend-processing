-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE OR ALTER PROCEDURE DBO.SP_POSITIVE_TESTED_PEOPLE_PER_MUNICIPALITY
AS
BEGIN
-- Move positively tested persons data from intermediate table to destination table. 
-- Main select and insert statement for people tested positively. Calculation per date of report.  
    INSERT INTO VWSDEST.POSITIVE_TESTED_PEOPLE_PER_MUNICIPALITY
    (DATE_OF_REPORT, DATE_OF_REPORT_UNIX, MUNICIPALITY_CODE, MUNICIPALITY_NAME, INFECTED_DAILY_TOTAL, INFECTED_DAILY_INCREASE)
    SELECT
        [DATE_OF_REPORT]
    ,   dbo.CONVERT_DATETIME_TO_UNIX(DATE_OF_REPORT) AS [DATE_OF_REPORT_UNIX]
    ,   MUNICIPALITY_CODE
    ,   MUNICIPALITY_NAME
    ,   [REPORTED_NL] - ISNULL(LAG(REPORTED_NL) OVER (PARTITION BY MUNICIPALITY_CODE ORDER BY DATE_OF_REPORT), 0) AS [INCREASE_ABSOLUTE]
    ,   [REPORTED_NL_PER_100000] - ISNULL(LAG(REPORTED_NL_PER_100000) OVER (PARTITION BY MUNICIPALITY_CODE ORDER BY DATE_OF_REPORT), 0) AS [INCREASE]
    FROM(
        SELECT
            DATE_OF_REPORT
        ,   MUNICIPALITY_CODE
        ,   b.GMNAAM AS MUNICIPALITY_NAME
        ,   SUM(CAST(Total_reported AS FLOAT)) AS [REPORTED_NL]
        ,   SUM(CAST(Total_reported AS FLOAT))/dbo.NORMALIZATION(CAST(c.INHABITANTS AS FLOAT)) AS [REPORTED_NL_PER_100000]
        FROM
           VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY_CUMULATIVE a
        LEFT JOIN VWSSTATIC.SAFETY_REGIONS_PER_MUNICIPAL b
               ON a.MUNICIPALITY_CODE  = b.GMCODE
        LEFT JOIN VWSSTATIC.INHABITANTS_PER_MUNICIPALITY c
               ON a.MUNICIPALITY_CODE = c.GMCODE
        WHERE a.DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED) FROM VWSINTER.RIVM_COVID_19_NUMBER_MUNICIPALITY_CUMULATIVE)
        GROUP BY DATE_OF_REPORT, MUNICIPALITY_CODE, GMNAAM, INHABITANTS
    ) AS SubqueryA
    WHERE MUNICIPALITY_CODE != ''
END;