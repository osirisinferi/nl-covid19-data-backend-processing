-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.

CREATE OR ALTER VIEW VWSDEST.V_INTENSIVE_CARE_ADMISSIONS_BACK_UP AS
SELECT
    ROW_NUMBER() OVER (ORDER BY DATE_OF_REPORT_UNIX ASC) AS ID,
    DATE_OF_REPORT,
	DATE_OF_REPORT_UNIX,
	MOVING_AVERAGE_IC,
	TOTAL_COUNT,
	DATE_LAST_INSERTED
FROM VWSDEST.INTENSIVE_CARE_ADMISSIONS 
WHERE DATE_LAST_INSERTED = (SELECT MAX(DATE_LAST_INSERTED)
                            FROM VWSDEST.INTENSIVE_CARE_ADMISSIONS);


                            	