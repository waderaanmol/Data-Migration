-- Declare source and target databases
DECLARE @SourceDB NVARCHAR(100) = 'sandboxGRIOriginal';
DECLARE @TargetDB NVARCHAR(100) = 'sandboxpersonal';

-- Declare source and target databases
DECLARE @SourceSchema NVARCHAR(100) = 'dbo';
DECLARE @TargetSchema NVARCHAR(100) = 'mod';

/*
-------------------------------------------------------
Begin With Reference Table Migrations
-------------------------------------------------------
*/

------- Tags Reference Table Migration ----------------
INSERT INTO [mod].[tag]
    (tag_code, tag_description)
SELECT
    Tags AS tag_code,
    Tags AS tag_description
FROM [dbo].[Tags];


------- Themes Reference Table Migration ----------------
INSERT INTO [mod].[theme]
    (theme_code, theme_description)
SELECT
    Field1 AS theme_code,
    Field1 AS theme_description
FROM [dbo].[Theme];



------- Venue Reference Table Migration ----------------
INSERT INTO [mod].[venue]
    (venue_code, venue_description)
SELECT
    Venue AS venue_code,
    Venue AS venue_description
FROM [dbo].[Venue];


------- Group Reference Table Migration ----------------
INSERT INTO [mod].[group]
    (group_code, group_description)
SELECT
    g_name AS group_code,
    g_name AS group_description
FROM [dbo].[Group];


------- SubTypes Reference Table (New Table) ----------------
INSERT INTO [mod].[subtype]
    (subtype_code, subtype_description)
VALUES
    ('Roundtable', 'Roundtable'),
    ('Webinar', 'Webinar'),
    ('ELP',  'ELP'),
    ('BROIP',  'BROIP'),
    ('Fintech',  'Fintech'),
    ('In Person', 'In Person');

/*
-------------------------------------------------------
Migrate User Table 
-------------------------------------------------------
*/
DECLARE @display VARCHAR(255),
        @first VARCHAR(255),
        @last VARCHAR(255),
        @source VARCHAR(255),
        @tag_id INT,
        @notes VARCHAR(255);

DECLARE user_cursor CURSOR FOR
SELECT
    u_display,
    u_first,
    u_last,
    u_source,
    u_tag,
    u_notes
FROM [dbo].[users];

OPEN user_cursor;
FETCH NEXT FROM user_cursor INTO @display, @first, @last, @source, @tag_id, @notes;

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC [mod].CreateUser
        @display = @display,
        @first = @first,
        @last = @last,
        @source = @source,
        @tag_id = @tag_id,
        @notes = @notes;

    FETCH NEXT FROM user_cursor INTO @display, @first, @last, @source, @tag_id, @notes;
END;

CLOSE user_cursor;
DEALLOCATE user_cursor;


/*
-------------------------------------------------------
Migrate Recording Table 
-------------------------------------------------------
*/
Go
DECLARE @name VARCHAR(255),
        @status VARCHAR(255);

DECLARE reporting_cursor CURSOR FOR
SELECT
    r_name,
    r_status
FROM [dbo].[reporting];

OPEN reporting_cursor;
FETCH NEXT FROM reporting_cursor INTO @name, @status;

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC [mod].CreateReporting
        @name = @name,
        @status = @status;

    FETCH NEXT FROM reporting_cursor INTO @name, @status;
END;

CLOSE reporting_cursor;
DEALLOCATE reporting_cursor;
Go

/*
-------------------------------------------------------
Migrate Compaany Table 
-------------------------------------------------------
*/
Go
DECLARE @name VARCHAR(255),
        @umbrella VARCHAR(255),
        @reporting_id INT;

DECLARE company_cursor CURSOR FOR
SELECT
    c_name,
    c_umbrella, 
    c_reporting
FROM [dbo].[company];

OPEN company_cursor;
FETCH NEXT FROM company_cursor INTO @name, @umbrella, @reporting_id;

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC [mod].CreateCompany
        @name = @name,
        @umbrella = @umbrella,
        @reporting_id = @reporting_id;

    FETCH NEXT FROM company_cursor INTO @name, @umbrella, @reporting_id;
END;

CLOSE company_cursor;
DEALLOCATE company_cursor;
Go


/*
-------------------------------------------------------
Migrate Affiliation Table 
-------------------------------------------------------
*/
Go
DECLARE @company_id INT,
    @user_id INT,
    @is_primary BIT,
    @email VARCHAR(255),
    @title VARCHAR(255),
    @group_id INT

DECLARE affiliation_cursor CURSOR FOR
SELECT
    a_c_id,
    a_u_id,
    u_email_1, 
    u_title, 
    a_group
FROM [dbo].[affiliation] 
LEFT JOIN [dbo].[users] 
ON  [dbo].[users].u_id =  [dbo].[affiliation].a_u_id

OPEN affiliation_cursor;
FETCH NEXT FROM affiliation_cursor INTO @company_id, @user_id, @is_primary, @email, @title, @group_id

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC [mod].CreateAffiliation
        @company_id = @company_id,
        @user_id = @user_id,
        @is_primary = @is_primary,
        @email = @email,
        @title = @title,
        @group_id = @group_id;

    FETCH NEXT FROM affiliation_cursor INTO  @company_id, @user_id, @is_primary, @email, @title, @group_id;

END;

CLOSE affiliation_cursor;
DEALLOCATE affiliation_cursor;
Go


/*
-------------------------------------------------------
Migrate Events Table 
-------------------------------------------------------
*/
Go
DECLARE @name VARCHAR(255),
    @date VARCHAR(255),
    @type VARCHAR(255),
    @subtype_id INT,
    @theme_id INT,
    @venue_id INT,
    @hours DECIMAL(5, 2)

DECLARE events_cursor CURSOR FOR
SELECT
    e_name,
    e_date,
    e_type, 
    e_subtype,
    e_theme,
    e_venue, 
    e_hours
FROM [dbo].[events] 

OPEN events_cursor;
FETCH NEXT FROM events_cursor INTO  @name, @date, @type, @subtype_id, @theme_id, @venue_id, @hours

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC [mod].CreateEvent
        @name = @name,
        @date = @date,
        @type = @type,
        @subtype_id = @subtype_id,
        @theme_id = @theme_id,
        @venue_id = @venue_id,
        @hours = @hours;
    
    FETCH NEXT FROM events_cursor INTO @name, @date, @type, @subtype_id, @theme_id, @venue_id, @hours;

END;

CLOSE events_cursor;
DEALLOCATE events_cursor;
Go

