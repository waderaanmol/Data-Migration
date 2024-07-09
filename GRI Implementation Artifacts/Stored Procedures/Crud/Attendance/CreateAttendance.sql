CREATE PROCEDURE [mod].[CreateAttendance]
AS
BEGIN
    DECLARE @entry_event_id INT, @entry_affiliation_id INT, @entry_company_id INT, @entry_reporting_id INT, 
    @entry_user_id INT, @entry_title VARCHAR(255), @entry_email VARCHAR (255),
    @entry_source_flag BIT, @entry_first_name VARCHAR(255), @entry_last_name VARCHAR(255);

    DECLARE cursor_attendance CURSOR FOR
    SELECT
        stagingAttendanceTable.e_id AS entry_event_id,
        stagingAttendanceTable.af_id AS entry_affiliation_id,
        stagingAttendanceTable.c_id AS entry_company_id, 
        companyTable.reporting_id AS entry_reporting_id, 
        stagingAttendanceTable.u_id AS entry_user_id,
        stagingAttendanceTable.title AS entry_title,
        stagingAttendanceTable.email AS entry_email,
        stagingAttendanceTable.sourceflag AS entry_source_flag,
        stagingAttendanceTable.first_name AS entry_first_name,
        stagingAttendanceTable.last_name AS entry_last_name
    FROM [stg].[attendance] AS stagingAttendanceTable
    LEFT JOIN [mod].[company] AS companyTable
    ON companyTable.id = stagingAttendanceTable.c_id;

    OPEN cursor_attendance;
    FETCH NEXT FROM cursor_attendance INTO @entry_event_id, @entry_affiliation_id, @entry_company_id,
    @entry_reporting_id, @entry_user_id, @entry_title, @entry_email,
    @entry_source_flag, @entry_first_name, @entry_last_name;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @entry_event_id IS NOT NULL AND @entry_affiliation_id IS NOT NULL AND @entry_company_id IS NOT NULL
        BEGIN
            -- Insert if all required columns are not null
            INSERT INTO [mod].[attendance] (event_id, affiliation_id, reporting_id)
            VALUES (@entry_event_id, @entry_affiliation_id, @entry_reporting_id);
        END
        ELSE IF @entry_event_id IS NOT NULL AND @entry_company_id IS NOT NULL AND @entry_affiliation_id IS NULL
        BEGIN
            -- Handle the case where affiliation_id is null
            DECLARE @RC int
            DECLARE @company_id int
            DECLARE @user_id int
            DECLARE @is_primary bit
            DECLARE @email varchar(255)
            DECLARE @title varchar(255)
            DECLARE @group_id int
            DECLARE @new_id INT;

            -- TODO: Set parameter values here.
            SET @company_id = @entry_company_id;
            SET @user_id = @entry_user_id
            SET @email = @entry_email
            SET @title = @entry_title

            EXECUTE @RC = [mod].[CreateAffiliation] 
             @company_id
            ,@user_id, 
            NULL, 
            @email,
            @title,
            NULL,
            @new_id = @new_id OUTPUT; -- Assign the output parameter to the variable

            -- Insert Entry After Affiliation Has Been Made
            INSERT INTO [mod].[attendance] (event_id, affiliation_id, reporting_id)
            VALUES (@entry_event_id, @new_id, @entry_reporting_id);
        
        END
        ELSE
        BEGIN
            -- Handle the case where event_id or reporting_id is null
            -- For now, let's just print a message
            PRINT 'Add new Cases Here';
        END

        FETCH NEXT FROM cursor_attendance INTO @entry_event_id, @entry_affiliation_id, @entry_company_id,
    @entry_reporting_id, @entry_user_id, @entry_title, @entry_email,
    @entry_source_flag, @entry_first_name, @entry_last_name;
    END

    CLOSE cursor_attendance;
    DEALLOCATE cursor_attendance;
END
GO
