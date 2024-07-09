-- Stored Procedures To Create Users
CREATE PROCEDURE [mod].CreateUser
    @display VARCHAR(255),
    @first VARCHAR(255),
    @last VARCHAR(255),
    @source VARCHAR(255),
    @tag_id INT,
    @notes VARCHAR(255)
AS
BEGIN
    INSERT INTO [mod].[user] (
        [display],
        [first],
        [last],
        [source],
        [tag_id],
        [notes]
    )
    VALUES (
        @display,
        @first,
        @last,
        @source,
        @tag_id,
        @notes
    );
END
