-- Stored Procedures To Create Event
CREATE PROCEDURE [mod].CreateEvent
    @name VARCHAR(255),
    @date VARCHAR(255),
    @type VARCHAR(255),
    @subtype_id INT,
    @theme_id INT,
    @venue_id INT,
    @hours DECIMAL(5, 2) --2 after decimal, 5 digits in total
AS
BEGIN
    INSERT INTO [mod].[event] (
        [name],
        [date],
        [type],
        [subtype_id],
        [theme_id],
        [venue_id],
        [hours]
    )
    VALUES (
        @name,
        @date,
        @type,
        @subtype_id,
        @theme_id,
        @venue_id,
        @hours
    );
END
