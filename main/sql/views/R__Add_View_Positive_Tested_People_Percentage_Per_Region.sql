-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE OR ALTER VIEW VWSDEST.V_POSITIVE_TESTED_PEOPLE_PERCENTAGE_PER_REGION AS
SELECT 
    DATE_OF_REPORT_UNIX AS WEEK_UNIX,
    dbo.CONVERT_DATETIME_TO_UNIX(DATEADD(week, DATEDIFF(week, 0, DATE_OF_REPORT - 1), 0)) as [WEEK_START_UNIX],
    dbo.CONVERT_DATETIME_TO_UNIX(dbo.WEEK_END(DATE_OF_REPORT)) as [WEEK_END_UNIX],
    VRCODE,
    DBO.NO_NEGATIVE_NUMBER_I(INFECTED_GGD) AS INFECTED,
    DBO.NO_NEGATIVE_NUMBER_F(PERCENTAGE_INFECTED_GGD) AS INFECTED_PERCENTAGE,
    DBO.NO_NEGATIVE_NUMBER_I(TOTAL_TESTED_GGD) AS TESTED_TOTAL,
    dbo.CONVERT_DATETIME_TO_UNIX(DATE_LAST_INSERTED) AS DATE_OF_INSERTION_UNIX
FROM VWSDEST.POSITIVE_TESTED_PEOPLE_PERCENTAGE_PER_REGION

WHERE DATE_LAST_INSERTED = (SELECT max(DATE_LAST_INSERTED) 
                            FROM VWSDEST.POSITIVE_TESTED_PEOPLE_PERCENTAGE_PER_REGION)