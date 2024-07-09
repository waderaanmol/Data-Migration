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
    ('ELP', 'ELP'),
    ('BROIP', 'BROIP'),
    ('Fintech', 'Fintech'),
    ('In Person', 'In Person');

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
ADD u_title VARCHAR(255);

GO -- Separate batches

INSERT INTO [mod].[user] 
    (display, first, last, source, tag_id, notes, priorUserPrimaryKey, u_email_1, u_title)
SELECT
    sourceUserTable.u_display AS display,
    sourceUserTable.u_first AS first,
    sourceUserTable.u_last AS last,
    sourceUserTable.u_source AS source,
    tagrefTable.id AS tag_id,
    sourceUserTable.u_notes AS notes, 
    sourceUserTable.u_id AS priorUserPrimaryKey,
    sourceUserTable.u_email_1 AS u_email_1,
    sourceUserTable.u_title AS u_title
FROM [dbo].[users] AS sourceUserTable
LEFT JOIN [mod].[tag] AS tagrefTable
ON sourceUserTable.u_tag = tagrefTable.tag_code;

/*
-------------------------------------------------------
Migrate Reporting Table 
-------------------------------------------------------
*/
ALTER TABLE [mod].[reporting]
ADD priorReportingPrimaryKey INT;

GO -- Separate batches

INSERT INTO [mod].[reporting]
    (name, status, priorReportingPrimaryKey)
SELECT
    r_name AS name,
    r_status AS status,
    r_id AS priorReportingPrimaryKey
FROM [dbo].[reporting] AS sourceReportingTable

/*
-------------------------------------------------------
Migrate Compaany Table 
-------------------------------------------------------
*/
ALTER TABLE [mod].[company]
ADD priorCompanyPrimaryKey INT;

GO -- Separate batches

INSERT INTO [mod].[company]
    (name, umbrella, reporting_id, priorCompanyPrimaryKey)
SELECT
    sourceCompanyTable.c_name AS name,
    sourceCompanyTable.c_umbrella AS umbrella, 
    reportingTable.id AS reporting_id, 
    sourceCompanyTable.c_id AS priorCompanyPrimaryKey
FROM [dbo].[company] AS sourceCompanyTable
LEFT JOIN [mod].[reporting] AS reportingTable
ON sourceCompanyTable.c_r_id = reportingTable.priorReportingPrimaryKey


/*
-------------------------------------------------------
Migrate Affiliation Table 
-------------------------------------------------------
*/
INSERT INTO [mod].[affiliation]
    (group_id, company_id, user_id, email, title)
SELECT
    groupTable.id AS group_id,
    companyTable.id AS company_id, 
    usersTable.id AS user_id, 
    usersTable.u_email_1 AS email,
    usersTable.u_title AS title
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
INSERT INTO [mod].[attendance]
    (is_attendee, is_consecutive_attendance, is_media, is_staff, is_speaker,
    event_id, rating, reporting_id )
SELECT
    sourceAttendanceTable.a_attendee AS is_attendee,
    sourceAttendanceTable.a_consecutive_attendance AS is_consecutive_attendance,
    sourceAttendanceTable.a_media AS is_media,
    sourceAttendanceTable.a_staff AS is_staff,
    sourceAttendanceTable.a_speaker AS is_speaker,
    sourceAttendanceTable.a_e_id AS event_id,
    sourceAttendanceTable.a_rating AS rating,
    sourceAttendanceTable.a_r_id AS reporting_id
FROM [dbo].[attendance] AS sourceAttendanceTable
LEFT JOIN [mod].[event] AS eventTable
ON sourceAttendanceTable.a_e_id = eventTable.priorEventPrimaryKey
LEFT JOIN [mod].[reporting] AS reportingTable
ON sourceAttendanceTable.a_r_id = reportingTable.priorReportingPrimaryKey


/*
-------------------------------------------------------
Drop Columns No Longer Needed
-------------------------------------------------------
*/
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