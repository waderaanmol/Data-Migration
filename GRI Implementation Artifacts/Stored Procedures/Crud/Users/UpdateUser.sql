-- Update User Stored Procedure
CREATE PROCEDURE [mod].UpdateUser
    @id INT,
    @display VARCHAR(255) = NULL,
    @first VARCHAR(255) = NULL,
    @last VARCHAR(255) = NULL,
    @source VARCHAR(255) = NULL,
    @tag_id INT = NULL,
    @notes VARCHAR(255) = NULL
AS
BEGIN
    -- Declare variables to hold existing values
    DECLARE @existing_display VARCHAR(255),
            @existing_first VARCHAR(255),
            @existing_last VARCHAR(255),
            @existing_source VARCHAR(255),
            @existing_tag_id INT,
            @existing_notes VARCHAR(255);

    -- Step 1: Retrieve the current record's values
    SELECT @existing_display = [display],
           @existing_first = [first],
           @existing_last = [last],
           @existing_source = [source],
           @existing_tag_id = [tag_id],
           @existing_notes = [notes]
    FROM [mod].[user]
    WHERE [id] = @id AND [is_current] = 1;

    -- Use existing values if new values are not provided
    SET @display = COALESCE(@display, @existing_display);
    SET @first = COALESCE(@first, @existing_first);
    SET @last = COALESCE(@last, @existing_last);
    SET @source = COALESCE(@source, @existing_source);
    SET @tag_id = COALESCE(@tag_id, @existing_tag_id);
    SET @notes = COALESCE(@notes, @existing_notes);

    -- Step 2: Mark the current record as inactive and set the end date
    UPDATE [mod].[user]
    SET [is_current] = 0,
        [end_date] = GETDATE()
    WHERE [id] = @id AND [is_current] = 1;

    -- Step 3: Insert the new record with updated or existing information
    INSERT INTO [mod].[user] (
        [display],
        [first],
        [last],
        [source],
        [tag_id],
        [notes],
        [is_current],
        [start_date],
        [end_date]
    )
    VALUES (
        @display,
        @first,
        @last,
        @source,
        @tag_id,
        @notes,
        1,                -- New record is current
        GETDATE(),        -- Start date is now
        NULL              -- End date is null
    );
END;
