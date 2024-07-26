-- Declare source and target databases
--DECLARE @SourceDB NVARCHAR(100) = 'sandboxGRIOriginal';
--DECLARE @TargetDB NVARCHAR(100) = 'sandboxpersonal';

-- Declare source and target databases
DECLARE @SourceSchema NVARCHAR(100) = 'dbo';
DECLARE @TargetSchema NVARCHAR(100) = 'mod';

/*
-------------------------------------------------------
Begin With Reference Table Migrations
-------------------------------------------------------
*/

------- Tags Reference Table Migration ----------------
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[tag]') AND name = 'priorTagPrimaryKey')
BEGIN
    ALTER TABLE [mod].[tag]
    DROP COLUMN priorTagPrimaryKey;
END;
-- Add the new column
ALTER TABLE [mod].[tag]
ADD priorTagPrimaryKey INT;

GO -- Separate batches

INSERT INTO [mod].[tag]
    (tag_code, tag_description, priorTagPrimaryKey)
SELECT
    Tags AS tag_code,
    Tags AS tag_description,
    ID AS priorTagPrimaryKey
FROM [dbo].[Tags];


------- Themes Reference Table Migration ----------------
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[theme]') AND name = 'priorThemePrimaryKey')
BEGIN
    ALTER TABLE [mod].[theme]
    DROP COLUMN priorThemePrimaryKey;
END;

ALTER TABLE [mod].[theme]
ADD priorThemePrimaryKey INT;

GO

INSERT INTO [mod].[theme]
    (theme_code, theme_description, priorThemePrimaryKey)
SELECT
    theme_name AS theme_code,
    theme_name AS theme_description,
    ID AS priorThemePrimaryKey
FROM [dbo].[Theme];



------- Venue Reference Table Migration ----------------
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[venue]') AND name = 'priorVenuePrimaryKey')
BEGIN
    ALTER TABLE [mod].[venue]
    DROP COLUMN priorVenuePrimaryKey;
END;

ALTER TABLE [mod].[venue]
ADD priorVenuePrimaryKey INT;

GO

INSERT INTO [mod].[venue]
    (venue_code, venue_description, priorVenuePrimaryKey )
SELECT
    Venue AS venue_code,
    Venue AS venue_description,
    ID AS priorVenuePrimaryKey
FROM [dbo].[Venue];


------- Group Reference Table Migration ----------------
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[group]') AND name = 'priorGroupPrimaryKey')
BEGIN
    ALTER TABLE [mod].[group]
    DROP COLUMN priorGroupPrimaryKey;
END;

ALTER TABLE [mod].[group]
ADD priorGroupPrimaryKey INT;

GO

INSERT INTO [mod].[group]
    (group_code, group_description, priorGroupPrimaryKey)
SELECT
    g_name AS group_code,
    g_name AS group_description,
    ID AS priorGroupPrimaryKey
FROM [dbo].[Group];


------- SubTypes Reference Table (New Table) ----------------
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[subtype]') AND name = 'priorSubtypePrimaryKey')
BEGIN
    ALTER TABLE [mod].[subtype]
    DROP COLUMN priorSubtypePrimaryKey;
END;

ALTER TABLE [mod].[subtype]
ADD priorSubtypePrimaryKey INT;

GO

-- Insert data into [mod].[subtype] including old primary key values
INSERT INTO [mod].[subtype]
    (subtype_code, subtype_description, priorSubtypePrimaryKey)
VALUES
    ('Roundtable', 'Roundtable', 1),
    ('Webinar', 'Webinar', 2),
    ('ELP', 'ELP', 3),
    ('BROIP', 'BROIP', 4),
    ('Fintech', 'Fintech', 5),
    ('In Person', 'In Person', 6);
/*
-------------------------------------------------------
Migrate User Table 
-------------------------------------------------------
*/
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[user]') AND name = 'priorUserPrimaryKey')
BEGIN
    ALTER TABLE [mod].[user]
    DROP COLUMN priorUserPrimaryKey;
END;

ALTER TABLE [mod].[user]
ADD priorUserPrimaryKey INT;

GO -- Separate batches

INSERT INTO [mod].[user] 
    (display, first, last, source, notes, priorUserPrimaryKey, email_1, email_2, title, time_stamp)
SELECT
    sourceUserTable.u_display AS display,
    sourceUserTable.u_first AS first,
    sourceUserTable.u_last AS last,
    sourceUserTable.u_source AS source,
    --tagrefTable.id AS tag_id,
    sourceUserTable.u_notes AS notes, 
    sourceUserTable.u_id AS priorUserPrimaryKey,
    sourceUserTable.u_email_1 AS email_1,
    sourceUserTable.u_email_2 AS email_2,
    sourceUserTable.u_title AS title,
	sourceUserTable.u_time_stamp as time_stamp
FROM [dbo].[users] AS sourceUserTable
--LEFT JOIN [mod].[tag] AS tagrefTable
--ON sourceUserTable.u_tag = tagrefTable.tag_code;

GO
UPDATE [mod].[user]
SET start_date = COALESCE(time_stamp, GETDATE());

/*
-------------------------------------------------------
Migrate Tagging Table 
-------------------------------------------------------
*/
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[tagging]') AND name = 'priorTaggingPrimaryKey')
BEGIN
    ALTER TABLE [mod].[tagging]
    DROP COLUMN priorTaggingPrimaryKey;
END;
-- Add prior primary key column to the new tagging table
ALTER TABLE [mod].[tagging]
ADD priorTaggingPrimaryKey INT;

GO

-- Insert data from old table to new table
INSERT INTO [mod].[tagging]
    (u_id, tag_id,priorTaggingPrimaryKey)
SELECT
    userTable.id AS u_id,
    tagTable.id AS tag_id,
    t_id AS priorTaggingPrimaryKey
FROM [dbo].[tagging] AS sourceTaggingTable
LEFT JOIN [mod].[user] AS userTable
ON sourceTaggingTable.u_id = userTable.priorUserPrimaryKey
LEFT JOIN [mod].[tag] AS tagTable
ON sourceTaggingTable.t_id = tagTable.priorTagPrimaryKey
;

GO
/*
-------------------------------------------------------
Migrate Reporting Table 
-------------------------------------------------------
*/
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[reporting]') AND name = 'priorReportingPrimaryKey')
BEGIN
    ALTER TABLE [mod].[reporting]
    DROP COLUMN priorReportingPrimaryKey;
END;

-- Add the new column
ALTER TABLE [mod].[reporting]
ADD priorReportingPrimaryKey INT;

GO

-- Insert data from the old table to the new table
INSERT INTO [mod].[reporting]
    (name, r_start, r_end, status, priorReportingPrimaryKey)
SELECT
    r_name AS name,
    r_start AS r_start,
    r_end AS r_end,
    r_status AS status,
    r_id AS priorReportingPrimaryKey
FROM [dbo].[reporting];
GO

-- Update the start_date in the new reporting table
UPDATE [mod].[reporting]
SET start_date = COALESCE(r_start, GETDATE())


--FROM [dbo].[reporting] AS sourceReportingTable

/*
-------------------------------------------------------
Migrate Compaany Table 
-------------------------------------------------------
*/
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[company]') AND name = 'priorCompanyPrimaryKey')
BEGIN
    ALTER TABLE [mod].[company]
    DROP COLUMN priorCompanyPrimaryKey;
END;

-- Add the new column
ALTER TABLE [mod].[company]
ADD priorCompanyPrimaryKey INT;

GO -- Separate batches

-- Insert data from old schema to new schema
INSERT INTO [mod].[company]
    (name, umbrella, reporting_id, status, priorCompanyPrimaryKey)
SELECT
    sourceCompanyTable.c_name AS name,
    sourceCompanyTable.c_umbrella AS umbrella, 
    reportingTable.id AS reporting_id,
    sourceCompanyTable.c_status AS status,
    sourceCompanyTable.c_id AS priorCompanyPrimaryKey
FROM [dbo].[company] AS sourceCompanyTable
LEFT JOIN [mod].[reporting] AS reportingTable
ON sourceCompanyTable.c_r_id = reportingTable.priorReportingPrimaryKey;


/*
-------------------------------------------------------
Migrate Affiliation Table 
-------------------------------------------------------
*/
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[affiliation]') AND name = 'priorAffiliationPrimaryKey')
BEGIN
    ALTER TABLE [mod].[affiliation]
    DROP COLUMN priorAffiliationPrimaryKey;
END;

ALTER TABLE [mod].[affiliation]
ADD priorAffiliationPrimaryKey INT;

GO

INSERT INTO [mod].[affiliation]
    (group_id, company_id, user_id, priorAffiliationPrimaryKey)
SELECT
    groupTable.id AS group_id,
    companyTable.id AS company_id, 
    usersTable.id AS user_id,
    sourceAffiliationTable.a_id AS priorAffiliationPrimaryKey
FROM [dbo].[affiliation] AS sourceAffiliationTable
LEFT JOIN [mod].[group] AS groupTable
ON sourceAffiliationTable.a_group = groupTable.group_code
LEFT JOIN [mod].[company] AS companyTable
ON sourceAffiliationTable.a_c_id = companyTable.priorCompanyPrimaryKey
LEFT JOIN [mod].[user] AS usersTable
ON sourceAffiliationTable.a_u_id = usersTable.priorUserPrimaryKey;


/*
-------------------------------------------------------
Migrate Events Table 
-------------------------------------------------------
*/
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[event]') AND name = 'priorEventPrimaryKey')
BEGIN
    ALTER TABLE [mod].[event]
    DROP COLUMN priorEventPrimaryKey;
END;

ALTER TABLE [mod].[event]
ADD priorEventPrimaryKey INT;

GO -- Separate batches

INSERT INTO [mod].[event]
    (name, date, type, subtype_id, theme_id, venue_id, hours, priorEventPrimaryKey)
SELECT
    sourceEventsTable.e_name AS name,
    sourceEventsTable.e_date AS date, 
    sourceEventsTable.e_type AS type, 
    subTypeTable.id AS subtype_id,
    themeTable.id AS theme_id, 
    venueTable.id AS venue_id, 
    sourceEventsTable.e_hours AS hours, 
    sourceEventsTable.e_id AS priorEventPrimaryKey
FROM [dbo].[events] AS sourceEventsTable
LEFT JOIN [mod].[subtype] AS subTypeTable
ON sourceEventsTable.e_subtype = subTypeTable.subtype_code
LEFT JOIN [mod].[theme] AS themeTable
ON sourceEventsTable.e_theme = themeTable.theme_code
LEFT JOIN [mod].[venue] AS venueTable
ON sourceEventsTable.e_venue = venueTable.venue_code

/*
-------------------------------------------------------
Migrate Attendance Table 
-------------------------------------------------------
*/
-- Drop the existing column if it exists
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[mod].[attendance]') AND name = 'priorAttendancePrimaryKey')
BEGIN
    ALTER TABLE [mod].[attendance]
    DROP COLUMN priorAttendancePrimaryKey;
END;

ALTER TABLE [mod].[attendance]
ADD priorAttendancePrimaryKey INT;

GO

INSERT INTO [mod].[attendance]
    (user_id, is_attendee, is_consecutive_attendance, is_media, is_staff, is_speaker,
    event_id, rating, company_id, priorAttendancePrimaryKey, group_id, venue_id )
SELECT
    CASE WHEN sourceAttendanceTable.a_attendee = 'TRUE' THEN 1 ELSE 0 END AS is_attendee,
    CASE WHEN sourceAttendanceTable.a_consecutive_attendance = 'TRUE' THEN 1 ELSE 0 END AS is_consecutive_attendance,
    CASE WHEN sourceAttendanceTable.a_media = 'TRUE' THEN 1 ELSE 0 END AS is_media,
    CASE WHEN sourceAttendanceTable.a_staff = 'TRUE' THEN 1 ELSE 0 END AS is_staff,
    CASE WHEN sourceAttendanceTable.a_speaker = 'TRUE' THEN 1 ELSE 0 END AS is_speaker,
    eventTable.id AS event_id,
    sourceAttendanceTable.a_rating AS rating,
	userTable.id AS user_id,
    sourceAttendanceTable.a_id AS priorAttendancePrimaryKey,
	companyTable.id AS company_id,
	groupTable.id AS group_id,
	venueTable.id AS venue_id
FROM [dbo].[attendance] AS sourceAttendanceTable
LEFT JOIN [mod].[user] AS userTable
ON sourceAttendanceTable.a_u_id = userTable.priorUserPrimaryKey
LEFT JOIN [mod].[event] AS eventTable
ON sourceAttendanceTable.a_e_id = eventTable.priorEventPrimaryKey
LEFT JOIN [mod].[company] AS companyTable
ON sourceAttendanceTable.a_company = companyTable.name
LEFT JOIN [mod].[venue] AS venueTable
ON sourceAttendanceTable.a_venue = venueTable.venue_code
LEFT JOIN [mod].[group] AS groupTable
ON sourceAttendanceTable.a_group = groupTable.group_code
;

-- Update the affiliation_id in [mod].[attendance] based on user_id from [mod].[users] and [mod].[affiliation]
UPDATE a
SET a.affiliation_id = aff.id
FROM [mod].[attendance] AS a
INNER JOIN [mod].[user] AS u
    ON a.user_id = u.id  -- Join on user_id in [mod].[attendance] and [mod].[users]
INNER JOIN [mod].[affiliation] AS aff
    ON u.id = aff.user_id  -- Join on user_id in [mod].[affiliation]
WHERE a.affiliation_id IS NULL;  -- Update only records where affiliation_id is NULL
