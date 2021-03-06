-- Copyright (c) 2020 De Staat der Nederlanden, Ministerie van   Volksgezondheid, Welzijn en Sport. 
-- Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2 - see https://github.com/minvws/nl-contact-tracing-app-coordinationfor more information.


ALTER TABLE VWSARCHIVE.SEWER_MEASUREMENTS_PER_MUNICIPALITY ADD NUMBER_OF_MEASUREMENTS INT NULL;
ALTER TABLE VWSARCHIVE.SEWER_MEASUREMENTS_PER_MUNICIPALITY ADD NUMBER_OF_LOCATIONS INT NULL;
ALTER TABLE VWSARCHIVE.SEWER_MEASUREMENTS_PER_MUNICIPALITY ADD AVERAGE_RNA_FLOW_PER_100000 DECIMAL(16,2) NULL;