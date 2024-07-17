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

ALTER TABLE [mod].[theme]
ADD priorThemePrimaryKey INT;

INSERT INTO [mod].[theme]
    (theme_code, theme_description, ID)
SELECT
    theme_name AS theme_code,
    theme_name AS theme_description,
    ID AS priorThemePrimaryKey
FROM [dbo].[Theme];



------- Venue Reference Table Migration ----------------
ALTER TABLE [mod].[venue]
ADD priorVenuePrimaryKey INT;

INSERT INTO [mod].[venue]
    (venue_code, venue_description, priorVenuePrimaryKey )
SELECT
    Venue AS venue_code,
    Venue AS venue_description,
    ID AS priorVenuePrimaryKey
FROM [dbo].[Venue];


------- Group Reference Table Migration ----------------

ALTER TABLE [mod].[group]
ADD priorGroupPrimaryKey INT;

INSERT INTO [mod].[group]
    (group_code, group_description, priorGroupPrimaryKey)
SELECT
    g_name AS group_code,
    g_name AS group_description,
    ID AS priorGroupPrimaryKey
FROM [dbo].[Group];


------- SubTypes Reference Table (New Table) ----------------

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

ALTER TABLE [mod].[user]
ADD priorUserPrimaryKey INT;

GO -- Separate batches

ALTER TABLE [mod].[user]
ADD u_email_1 VARCHAR(255);

GO -- Separate batches

ALTER TABLE [mod].[user]
ADD u_email_2 VARCHAR(255);

GO -- Separate batches
    
ALTER TABLE [mod].[user]
ADD u_title VARCHAR(255);

GO -- Separate batches

INSERT INTO [mod].[user] 
    (display, first, last, source, notes, priorUserPrimaryKey, u_email_1, u_email_2, u_title)
SELECT
    sourceUserTable.u_display AS display,
    sourceUserTable.u_first AS first,
    sourceUserTable.u_last AS last,
    sourceUserTable.u_source AS source,
    --tagrefTable.id AS tag_id,
    sourceUserTable.u_notes AS notes, 
    sourceUserTable.u_id AS priorUserPrimaryKey,
    sourceUserTable.u_email_1 AS u_email_1,
    sourceUserTable.u_email_2 AS u_email_2,
    sourceUserTable.u_title AS u_title
FROM [dbo].[users] AS sourceUserTable
--LEFT JOIN [mod].[tag] AS tagrefTable
--ON sourceUserTable.u_tag = tagrefTable.tag_code;

/*
-------------------------------------------------------
Migrate Tagging Table 
-------------------------------------------------------
*/

-- Add prior primary key column to the new tagging table
ALTER TABLE [mod].[tagging]
ADD priorTaggingPrimaryKey INT;
GO

-- Insert data from old table to new table
INSERT INTO [mod].[tagging]
    (u_id, tag_id, priorTaggingPrimaryKey)
SELECT
    u_id,
    tag_id,
    t_id AS priorTaggingPrimaryKey
FROM [dbo].[tagging];
GO
/*
-------------------------------------------------------
Migrate Reporting Table 
-------------------------------------------------------
*/
-- Add prior primary key column to the new reporting table
ALTER TABLE [mod].[reporting]
ADD priorReportingPrimaryKey INT;
GO

-- Insert data from the old table to the new table
INSERT INTO [mod].[reporting]
    (name, r_start, r_end, status, priorReportingPrimaryKey)
SELECT
    r_name AS name,
    r_start,
    r_end,
    r_status AS status,
    r_id AS priorReportingPrimaryKey
FROM [dbo].[reporting];
GO
--FROM [dbo].[reporting] AS sourceReportingTable

/*
-------------------------------------------------------
Migrate Compaany Table 
-------------------------------------------------------
*/
ALTER TABLE [mod].[company]
ADD priorCompanyPrimaryKey INT;

-- Add a column to store the old foreign key
ALTER TABLE [mod].[company]
ADD priorReportingPrimaryKey INT;

GO -- Separate batches

-- Insert data from old schema to new schema
INSERT INTO [mod].[company]
    (name, umbrella, priorReportingPrimaryKey, priorCompanyPrimaryKey)
SELECT
    sourceCompanyTable.c_name AS name,
    sourceCompanyTable.c_umbrella AS umbrella, 
    sourceCompanyTable.c_r_id AS priorReportingPrimaryKey,
    sourceCompanyTable.c_id AS priorCompanyPrimaryKey
FROM [dbo].[company] AS sourceCompanyTable;

/*
-------------------------------------------------------
Migrate Affiliation Table 
-------------------------------------------------------
*/

ALTER TABLE [mod].[affiliation]
ADD priorAffiliationPrimaryKey INT;

INSERT INTO [mod].[affiliation]
    (group_id, company_id, user_id, title, priorAffiliationPrimaryKey)
SELECT
    groupTable.id AS group_id,
    companyTable.id AS company_id, 
    usersTable.id AS user_id,
    usersTable.u_title AS title
    sourceAffiliationTable.a_id AS priorAffiliationPrimaryKey
FROM [dbo].[affiliation] AS sourceAffiliationTable
LEFT JOIN [mod].[group] AS groupTable
ON sourceAffiliationTable.a_group = groupTable.group_code
LEFT JOIN [mod].[company] AS companyTable
ON sourceAffiliationTable.a_c_id = companyTable.priorCompanyPrimaryKey
LEFT JOIN [mod].[user] AS usersTable
ON sourceAffiliationTable.a_u_id = usersTable.priorUserPrimaryKey


/*
-------------------------------------------------------
Migrate Events Table 
-------------------------------------------------------
*/

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

ALTER TABLE [mod].[attendance]
ADD priorAttendancePrimaryKey INT;

INSERT INTO [mod].[attendance]
    (is_attendee, is_consecutive_attendance, is_media, is_staff, is_speaker,
    event_id, rating, reporting_id, priorAttendancePrimaryKey )
SELECT
    sourceAttendanceTable.a_attendee AS is_attendee,
    sourceAttendanceTable.a_consecutive_attendance AS is_consecutive_attendance,
    sourceAttendanceTable.a_media AS is_media,
    sourceAttendanceTable.a_staff AS is_staff,
    sourceAttendanceTable.a_speaker AS is_speaker,
    sourceAttendanceTable.a_e_id AS event_id,
    sourceAttendanceTable.a_rating AS rating,
    sourceAttendanceTable.a_r_id AS reporting_id
    sourceAttendanceTable.a_id AS priorAttendancePrimaryKey
FROM [dbo].[attendance] AS sourceAttendanceTable
LEFT JOIN [mod].[event] AS eventTable
ON sourceAttendanceTable.a_e_id = eventTable.priorEventPrimaryKey
LEFT JOIN [mod].[reporting] AS reportingTable
ON sourceAttendanceTable.a_r_id = reportingTable.priorReportingPrimaryKey


/*
-------------------------------------------------------
Drop Columns No Longer Needed
-------------------------------------------------------
ALTER TABLE [mod].[user]
DROP COLUMN u_email_1;

ALTER TABLE [mod].[user]
DROP COLUMN u_title;

ALTER TABLE [mod].[user]
DROP COLUMN priorUserPrimaryKey;

ALTER TABLE [mod].[company]
DROP COLUMN priorCompanyPrimaryKey;

ALTER TABLE [mod].[reporting]
DROP COLUMN priorReportingPrimaryKey;

ALTER TABLE [mod].[event]
DROP COLUMN priorEventPrimaryKey;
*/
