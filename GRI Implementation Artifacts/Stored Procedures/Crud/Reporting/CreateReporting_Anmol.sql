-- Stored Procedure To Create Reporting Company
-- Takes the two paramters name and status (0 or 1) and inserts new record in the reporting table
CREATE PROCEDURE [mod].CreateReporting
    @name VARCHAR(255), --Parameter #1
    @status BIT --Parameter #2
AS
BEGIN
    INSERT INTO [mod].[reporting] (
        [name]
       ,[status]
    )
    VALUES (
        @name,
        @status
    );
END
