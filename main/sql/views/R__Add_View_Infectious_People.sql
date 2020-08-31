-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

-- Create view for pulling infectious people
CREATE VIEW VWSDEST.V_INFECTIOUS_PEOPLE AS
SELECT
    [DATE_OF_REPORT_UNIX],
    dbo.WEEK_START([DATE_OF_REPORT]) WEEK_START_UNIX,
    dbo.WEEK_END([DATE_OF_REPORT]) WEEK_END_UNIX,
    DBO.NO_NEGATIVE_NUMBER_I([INFECTIOUS_LOW]) AS INFECTIOUS_LOW,
    DBO.NO_NEGATIVE_NUMBER_I([INFECTIOUS_AVG]) AS INFECTIOUS_AVG,
    DBO.NO_NEGATIVE_NUMBER_I([INFECTIOUS_HIGH]) AS INFECTIOUS_HIGH,
    dbo.CONVERT_DATETIME_TO_UNIX(DATE_LAST_INSERTED) AS DATE_OF_INSERTION_UNIX
FROM VWSDEST.INFECTIOUS_PEOPLE
WHERE DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED)
                            FROM VWSDEST.INFECTIOUS_PEOPLE);