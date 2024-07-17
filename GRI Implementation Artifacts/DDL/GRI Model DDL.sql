/*
------------------------------------------------------------------------------------------------------
-- Create Mod Schema
------------------------------------------------------------------------------------------------------
-- Drop the schema if it exists
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'mod')
BEGIN
    DROP SCHEMA mod;
END
-- Recreate the schema
GO
CREATE SCHEMA mod;
GO
*/

------------------------------------------------------------------------------------------------------
-- Create Sequences for Tables 
------------------------------------------------------------------------------------------------------
-- Create sequences for User table
IF EXISTS (SELECT *
FROM sys.sequences
WHERE name = N'IdSequence_User' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_User];
END
GO
CREATE SEQUENCE [mod].IdSequence_User START WITH 1 INCREMENT BY 1;

-- Create sequences for Subscription table
IF EXISTS (SELECT *
FROM sys.sequences
WHERE name = N'IdSequence_Subscription' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Subscription];
END
GO
CREATE SEQUENCE [mod].IdSequence_Subscription START WITH 1 INCREMENT BY 1;

-- Create sequences for Event table
IF EXISTS (SELECT *
FROM sys.sequences
WHERE name = N'IdSequence_Event' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Event];
END
GO
CREATE SEQUENCE [mod].IdSequence_Event START WITH 1 INCREMENT BY 1;

-- Create sequences for Affiliation table
IF EXISTS (SELECT *
FROM sys.sequences
WHERE name = N'IdSequence_Affiliation' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Affiliation];
END
GO
CREATE SEQUENCE [mod].IdSequence_Affiliation START WITH 1 INCREMENT BY 1;

-- Create sequences for Company table
IF EXISTS (SELECT *
FROM sys.sequences
WHERE name = N'IdSequence_Company' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Company];
END
GO
CREATE SEQUENCE [mod].IdSequence_Company START WITH 1 INCREMENT BY 1;

-- Create sequences for Reporting table
IF EXISTS (SELECT *
FROM sys.sequences
WHERE name = N'IdSequence_Reporting' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Reporting];
END
GO
CREATE SEQUENCE [mod].IdSequence_Reporting START WITH 1 INCREMENT BY 1;

-- Create sequences for Tagging table
IF EXISTS (SELECT * FROM sys.sequences WHERE name = N'IdSequence_Tagging' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Tagging];
END
GO
CREATE SEQUENCE [mod].IdSequence_Tagging START WITH 1 INCREMENT BY 1;

-- Create sequences for Log table
IF EXISTS (SELECT * FROM sys.sequences WHERE name = N'IdSequence_Log' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Log];
END
GO
CREATE SEQUENCE [mod].IdSequence_Log START WITH 1 INCREMENT BY 1;

-- Create sequences for Tag table
IF EXISTS (SELECT * FROM sys.sequences WHERE name = N'IdSequence_Tag' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Tag];
END
GO
CREATE SEQUENCE [mod].IdSequence_Tag START WITH 1 INCREMENT BY 1;
GO

-- Create sequences for Theme table
IF EXISTS (SELECT * FROM sys.sequences WHERE name = N'IdSequence_Theme' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Theme];
END
GO
CREATE SEQUENCE [mod].IdSequence_Theme START WITH 1 INCREMENT BY 1;
GO

-- Create sequences for Subtype table
IF EXISTS (SELECT * FROM sys.sequences WHERE name = N'IdSequence_Subtype' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Subtype];
END
GO
CREATE SEQUENCE [mod].IdSequence_Subtype START WITH 1 INCREMENT BY 1;
GO

-- Create sequences for Venue table
IF EXISTS (SELECT * FROM sys.sequences WHERE name = N'IdSequence_Venue' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Venue];
END
GO
CREATE SEQUENCE [mod].IdSequence_Venue START WITH 1 INCREMENT BY 1;
GO

-- Create sequences for Group table
IF EXISTS (SELECT * FROM sys.sequences WHERE name = N'IdSequence_Group' AND schema_id = SCHEMA_ID(N'mod'))
BEGIN
    DROP SEQUENCE [mod].[IdSequence_Group];
END
GO
CREATE SEQUENCE [mod].IdSequence_Group START WITH 1 INCREMENT BY 1;
GO


------------------------------------------------------------------------------------------------------
-- Create Function to Validate Date Time Columns
------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects 
           WHERE object_id = OBJECT_ID(N'[mod].[fn_ValidateDateTimeColumn]') 
           AND type IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    -- Drop the function
    DROP FUNCTION [mod].[fn_ValidateDateTimeColumn];
END;

-- Replace the following with your function definition
GO
CREATE FUNCTION [mod].[fn_ValidateDateTimeColumn]
    (
        @timestamp DATETIME
    )
    RETURNS BIT
    AS
    BEGIN
        DECLARE @isValid BIT;

        IF @timestamp IS NULL
            SET @isValid = 1;

        ELSE IF CONVERT(VARCHAR, @timestamp, 120) LIKE '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'
            SET @isValid = 1;
            
        ELSE
            SET @isValid = 0;

        RETURN @isValid;
    END;
GO

------------------------------------------------------------------------------------------------------
-- Create Log Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.log', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[log];
END;

CREATE TABLE [mod].[log]
(
    id_system INT IDENTITY(1,1) NOT NULL,
    procedure_name VARCHAR(128) NOT NULL,
    start_date DATETIME DEFAULT GETDATE(),
    end_date DATETIME DEFAULT NULL,
    rows_affected INT,
    status VARCHAR(255),
    comment NVARCHAR(255),
    username VARCHAR(100) NOT NULL
);

------------------------------------------------------------------------------------------------------
-- Create Tag Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.tag', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[tag];
END;

CREATE TABLE [mod].[tag]
(
    id INT IDENTITY(1,1) PRIMARY KEY DEFAULT (NEXT VALUE FOR [mod].IdSequence_Tag) NOT NULL,
    tag_code VARCHAR(255),
    CONSTRAINT CHK_Tag_Format CHECK (
    LEN(tag_code) <= 255 AND
        (tag_code IS NULL OR tag_code IN ('PRAC', 'VIP', 'GRI BOARD', 'SFAC', 'SVB23', 'EIR', 'EMERITI', 'RAC', 'PC'))
	),
    tag_description VARCHAR(255),
);

/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'tag',
   'trg_LogTableOperations_Tag'
GO
*/

------------------------------------------------------------------------------------------------------
-- Create Tagging Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.tagging', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[tagging];
END;

CREATE TABLE [mod].[tagging]
(
    t_id INT PRIMARY KEY DEFAULT (NEXT VALUE FOR [mod].IdSequence_Tagging) NOT NULL,
    u_id INT,
    tag_id INT,
    FOREIGN KEY (u_id) REFERENCES [mod].[user](id),
    FOREIGN KEY (tag_id) REFERENCES [mod].[tags](id)
);

------------------------------------------------------------------------------------------------------
-- Create User Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.user', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[user];
END;

CREATE TABLE [mod].[user]
(
    id_system INT IDENTITY(1,1) NOT NULL,
    id INT DEFAULT (NEXT VALUE FOR [mod].IdSequence_User) PRIMARY KEY NOT NULL,
    display VARCHAR(255),
    first VARCHAR(255),
    last VARCHAR(255),
    source VARCHAR(255),
    tag_id INT,
    --FOREIGN KEY (tag_id) REFERENCES [mod].[tag](id),
    notes VARCHAR(255),
    CONSTRAINT CHK_Notes_Format CHECK (
        LEN(notes) <= 255 AND
        notes NOT LIKE '%[!@#$%^&*()_+={}|:<>?~]%'
    ),
    is_current BIT DEFAULT 1,
    start_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT CHK_Timestamp_Format_StartDate CHECK (mod.fn_ValidateDateTimeColumn(start_date) = 1),
    end_date DATETIME DEFAULT NULL,
    CONSTRAINT CHK_Timestamp_Format_EndDate CHECK (mod.fn_ValidateDateTimeColumn(end_date) = 1)

);

/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'user',
   'trg_LogTableOperations_User'
GO
*/

------------------------------------------------------------------------------------------------------
-- Create Reporting Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.reporting', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[reporting];
END;

CREATE TABLE [mod].[reporting]
(
    id_system INT IDENTITY(1,1) NOT NULL,
    id INT DEFAULT (NEXT VALUE FOR [mod].IdSequence_Reporting) PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    r_start VARCHAR(255),
    r_end DATETIME,
    status VARCHAR(255),
    is_current BIT DEFAULT 1,
    start_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT CHK_Timestamp_Format_StartDate_Reporting CHECK (mod.fn_ValidateDateTimeColumn(start_date) = 1),
    end_date DATETIME DEFAULT NULL
        CONSTRAINT CHK_Timestamp_Format_EndDate_Reporting CHECK (mod.fn_ValidateDateTimeColumn(end_date) = 1)
);
/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'reporting',
   'trg_LogTableOperations_Reporting'
GO
*/

------------------------------------------------------------------------------------------------------
-- Create Group Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.group', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[group];
END;

CREATE TABLE [mod].[group]
(
    id INT IDENTITY(1,1) PRIMARY KEY DEFAULT (NEXT VALUE FOR [mod].IdSequence_Group) NOT NULL,
    group_code VARCHAR(255),
    CONSTRAINT CHK_Group_Format CHECK (
    LEN(group_code) <= 255 AND
        (group_code IS NULL OR group_code IN ('BOARD', 'EX-BOARD', 'VP', 'CEO', 'CRO', 'C-SUITE', 'DIRECTOR', 'MANAGER', 'GOV', 'EX-GOV', 'GRI BOARD'))
	),
    group_description VARCHAR(255),
);

/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'group',
   'trg_LogTableOperations_Group'
GO
*/

------------------------------------------------------------------------------------------------------
-- Create Company Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.company', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[company];
END;

CREATE TABLE [mod].[company]
(
    id_system INT IDENTITY(1,1) NOT NULL,
    id INT DEFAULT (NEXT VALUE FOR [mod].IdSequence_Company) PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    umbrella VARCHAR(255),
    reporting_id INT,
    FOREIGN KEY (reporting_id) REFERENCES [mod].[reporting](id),
    is_current BIT DEFAULT 1,
    start_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT CHK_Timestamp_Format_StartDate_Company CHECK (mod.fn_ValidateDateTimeColumn(start_date) = 1),
    end_date DATETIME DEFAULT NULL
        CONSTRAINT CHK_Timestamp_Format_EndDate_Company CHECK (mod.fn_ValidateDateTimeColumn(end_date) = 1)

);
/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'company',
   'trg_LogTableOperations_Company'
GO
*/

------------------------------------------------------------------------------------------------------
-- Create Affiliation Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.affiliation', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[affiliation];
END;

CREATE TABLE [mod].[affiliation]
(
    id_system INT IDENTITY(1,1) NOT NULL,
    id INT DEFAULT (NEXT VALUE FOR [mod].IdSequence_Affiliation) PRIMARY KEY NOT NULL,
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES [mod].[company](id),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES [mod].[user](id),
    is_primary BIT DEFAULT 1,
    email VARCHAR(255) NOT NULL,
    title VARCHAR(255),
    group_id INT,
    -- Remember to add foreign key check to Group Table
    FOREIGN KEY (group_id) REFERENCES [mod].[group](id),
    is_current BIT DEFAULT 1,
    start_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT CHK_Timestamp_Format_StartDate_Affiliation CHECK (mod.fn_ValidateDateTimeColumn(start_date) = 1),
    end_date DATETIME DEFAULT NULL
        CONSTRAINT CHK_Timestamp_Format_EndDate_Affiliation CHECK (mod.fn_ValidateDateTimeColumn(end_date) = 1)
);
/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'affiliation',
   'trg_LogTableOperations_Affiliation'
GO
*/

------------------------------------------------------------------------------------------------------
-- Create Theme Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.theme', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[theme];
END;

CREATE TABLE [mod].[theme]
(
    id INT IDENTITY(1,1) PRIMARY KEY DEFAULT (NEXT VALUE FOR [mod].IdSequence_Theme) NOT NULL,
    theme_code VARCHAR(255),
    CONSTRAINT CHK_Theme_Format CHECK (
    LEN(theme_code) <= 255 AND
        (theme_code IS NULL OR theme_code IN ('Technology', 'Sustainable Fianace', 'Macroeconomics', 'CSB', 'Climate', 'Geopolitical Risk', 'Pension', 'Cyber Risk'))
	),
    theme_description VARCHAR(255),
);

/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'theme',
   'trg_LogTableOperations_Theme'
GO
*/

------------------------------------------------------------------------------------------------------
-- Create Sub Type Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.subtype', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[subtype];
END;

CREATE TABLE [mod].[subtype]
(
    id INT IDENTITY(1,1) PRIMARY KEY DEFAULT (NEXT VALUE FOR [mod].IdSequence_Subtype) NOT NULL,
    subtype_code VARCHAR(255),
    CONSTRAINT CHK_SubType_Format CHECK (
    LEN(subtype_code) <= 255 AND
        (subtype_code IS NULL OR subtype_code IN ('Roundtable', 'Webinar','ELP', 'BROIP', 'Fintech', 'In Person'))
	),
    subtype_description VARCHAR(255),
);

/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'subtype',
   'trg_LogTableOperations_Subtype'
GO
*/

------------------------------------------------------------------------------------------------------
-- Create Venue Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.venue', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[venue];
END;

CREATE TABLE [mod].[venue]
(
    id INT IDENTITY(1,1) PRIMARY KEY DEFAULT (NEXT VALUE FOR [mod].IdSequence_Venue) NOT NULL,
    venue_code VARCHAR(255),
    CONSTRAINT CHK_Venue_Format CHECK (
    LEN(venue_code) <= 255 AND
        (venue_code IS NULL OR venue_code IN ('In Person', 'Virtual', 'Hybrid'))
	),
    venue_description VARCHAR(255),
);

/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'venue',
   'trg_LogTableOperations_Venue'
GO
*/ 

------------------------------------------------------------------------------------------------------
-- Create Event Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.event', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[event];
END;

CREATE TABLE [mod].[event]
(
    id_system INT IDENTITY(1,1) NOT NULL,
    id INT DEFAULT (NEXT VALUE FOR [mod].IdSequence_Event) PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    date DATETIME,
    type VARCHAR(255),
    CONSTRAINT CHK_Event_Type CHECK (
        -- Ensure the text is no more than 255 characters long
        LEN(type) <= 255 AND

        -- Disallow characters such as !, @, #, $, %, etc.
        type NOT LIKE '%[!@#$%^&*()_+={}|:<>?~]%' AND

        -- Allow only specific values
        type IN ('Events', 'Education', 'Summit')
    ),
    subtype_id INT,
    FOREIGN KEY (subtype_id) REFERENCES [mod].[subtype](id),
    theme_id INT,
    FOREIGN KEY (theme_id) REFERENCES [mod].[theme](id),
    venue_id INT,
    FOREIGN KEY (venue_id) REFERENCES [mod].[venue](id),
    hours DECIMAL(5, 2),
    CONSTRAINT CHK_Hours_Format CHECK (
    hours >= 0 AND hours <= 24 AND
        hours = ROUND(hours, 2)
	),
    is_current BIT DEFAULT 1,
    start_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT CHK_Timestamp_Format_StartDate_Event CHECK (mod.fn_ValidateDateTimeColumn(start_date) = 1),
    end_date DATETIME DEFAULT NULL
        CONSTRAINT CHK_Timestamp_Format_EndDate_Event CHECK (mod.fn_ValidateDateTimeColumn(end_date) = 1)
);

/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'event',
   'trg_LogTableOperations_Event'
GO
*/

------------------------------------------------------------------------------------------------------
-- Create Attendance Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.attendance', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[attendance];
END;

CREATE TABLE [mod].[attendance]
(
    id_system INT IDENTITY(1,1) NOT NULL,
    affiliation_id INT,
    FOREIGN KEY (affiliation_id) REFERENCES [mod].[affiliation](id),
    is_attendee BIT DEFAULT 1,
    is_consecutive_attendance BIT DEFAULT 0,
    is_media BIT DEFAULT 0,
    is_staff BIT DEFAULT 0,
    is_speaker BIT DEFAULT 0,
    event_id INT,
    FOREIGN KEY (event_id) REFERENCES [mod].[event](id),
    rating DECIMAL(5, 2),
    CONSTRAINT CHK_Rating_Format CHECK (
    rating >= 1 AND rating <= 5 AND
        rating = ROUND(rating, 2) AND
        rating > 0
	),
    reporting_id INT,
    FOREIGN KEY (reporting_id) REFERENCES [mod].[reporting](id),
    venue VARCHAR(255)
);

/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'attendance',
   'trg_LogTableOperations_Attendance'
GO
*/

------------------------------------------------------------------------------------------------------
-- Create Subscription Table 
------------------------------------------------------------------------------------------------------
IF OBJECT_ID('mod.subscription', 'U') IS NOT NULL
BEGIN
    DROP TABLE [mod].[subscription];
END;

CREATE TABLE [mod].[subscription]
(
    id_system INT IDENTITY(1,1) NOT NULL,
    id INT DEFAULT (NEXT VALUE FOR [mod].IdSequence_Subscription) PRIMARY KEY NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES [mod].[user](id),
    optin_time DATETIME,
    CONSTRAINT CHK_Timestamp_Format_OptInTime_Subscription CHECK (mod.fn_ValidateDateTimeColumn(optin_time) = 1),
    unsub_time DATETIME,
    CONSTRAINT CHK_Timestamp_Format_UnSubTime_Subscription CHECK (mod.fn_ValidateDateTimeColumn(unsub_time) = 1),
    unsub_reason VARCHAR(255),
    unsub_reason_other VARCHAR(255),
    clean_time DATETIME,
    CONSTRAINT CHK_Timestamp_Format_CleanTime_Subscription CHECK (mod.fn_ValidateDateTimeColumn(clean_time) = 1),
    name VARCHAR(255),
    status BIT,
    is_current BIT DEFAULT 1,
    start_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT CHK_Timestamp_Format_StartDate_Subscription CHECK (mod.fn_ValidateDateTimeColumn(start_date) = 1),
    end_date DATETIME DEFAULT NULL
        CONSTRAINT CHK_Timestamp_Format_EndDate_Subscription CHECK (mod.fn_ValidateDateTimeColumn(end_date) = 1)
);

/*
-- Add Logging Trigger
EXECUTE [mod].[AddLoggingTriggerToTable] 
   'subscription',
   'trg_LogTableOperations_Subscription'
GO


------------------------------------------------------------------------------------------------------
-- Create Staging Tables for Special Use Cases
------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'stg')
BEGIN
    DROP SCHEMA stg;
END
-- Recreate the schema
GO
CREATE SCHEMA stg;
GO


------------------------------------------------------------------------------------------------------
-- Create Staging Table for Attendance Entry
------------------------------------------------------------------------------------------------------
CREATE TABLE [stg].[attendance] (
    sourceflag BIT,
    email NVARCHAR(255),
    e_id INT,
    first_name NVARCHAR(255),
    last_name NVARCHAR(255),
    u_id INT,
    af_id INT,
    c_id INT,
	title NVARCHAR(255)


);

*/
