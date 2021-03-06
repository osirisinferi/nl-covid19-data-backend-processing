-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE OR ALTER VIEW VWSDEST.V_SEWER_MEASUREMENTS_REGIONS AS
SELECT 
    WEEK_UNIX,
    WEEK_START_UNIX,
    WEEK_END_UNIX,
    VRCODE,
    AVERAGE,
    TOTAL_INSTALLATION_COUNT,
    DATE_OF_INSERTION_UNIX
FROM (
SELECT
        WEEK_UNIX
    ,   WEEK_START_UNIX
    ,   WEEK_END_UNIX
    ,   VRCODE
    ,   AVERAGE
    ,   TOTAL_INSTALLATION_COUNT
    ,   DATE_OF_INSERTION_UNIX
    ,   RANK() OVER (PARTITION BY VRCODE ORDER BY WEEK_UNIX DESC) RANKING
FROM VWSDEST.V_SEWER_MEASUREMENTS_PER_REGION
where VRCODE IS NOT NULL
AND VRCODE != ' ') T1
WHERE T1.RANKING =1
;