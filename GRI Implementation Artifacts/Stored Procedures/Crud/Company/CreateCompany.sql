-- Stored Procedure To Create Company
CREATE PROCEDURE [mod].CreateCompany
    @name VARCHAR(255),
    @umbrella VARCHAR(255),
    @reporting_id INT
AS
BEGIN
    INSERT INTO [mod].[company] (
        [name],
        [umbrella],
        [reporting_id]
    )
    VALUES (
        @name,
        @umbrella,
        @reporting_id
    );
END
