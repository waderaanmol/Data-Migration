-- Stored Procedures To Create Users
CREATE PROCEDURE [mod].CreateReporting
    @name VARCHAR(255),
    @status BIT
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
