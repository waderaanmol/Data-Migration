-- Stored Procedures To Create Affiliation
CREATE PROCEDURE [mod].[CreateAffiliation]
    @company_id INT,
    @user_id INT,
    @is_primary BIT,
    @email VARCHAR(255),
    @title VARCHAR(255),
    @group_id INT,
    @new_id INT OUTPUT -- Output parameter to hold the new ID 
                       -- To be used for logging?
AS
BEGIN
    INSERT INTO [mod].[affiliation] (
        [company_id],
        [user_id],
        [is_primary],
        [email],
        [title],
        [group_id]
    )
    VALUES (
        @company_id,
        @user_id,
        @is_primary,
        @email,
        @title,
        @group_id
    );

    -- Get the newly inserted ID and assign it to the output parameter
    SET @new_id = SCOPE_IDENTITY();
END
GO

