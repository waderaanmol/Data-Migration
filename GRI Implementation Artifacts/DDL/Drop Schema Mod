------------------------------------------------------------------------------------------------------
-- Drop foreign key constraints first
------------------------------------------------------------------------------------------------------

-- Drop foreign key constraints referencing the event table
ALTER TABLE [mod].[attendance] DROP CONSTRAINT IF EXISTS FK_attendance_event;

-- Drop foreign key constraints referencing the venue table
ALTER TABLE [mod].[attendance] DROP CONSTRAINT IF EXISTS FK_attendance_venue;

-- Drop foreign key constraints referencing the company table
ALTER TABLE [mod].[attendance] DROP CONSTRAINT IF EXISTS FK_attendance_company;
ALTER TABLE [mod].[affiliation] DROP CONSTRAINT IF EXISTS FK_affiliation_company;

-- Drop foreign key constraints referencing the user table
ALTER TABLE [mod].[affiliation] DROP CONSTRAINT IF EXISTS FK_affiliation_user;
ALTER TABLE [mod].[tagging] DROP CONSTRAINT IF EXISTS FK_tagging_user;
ALTER TABLE [mod].[subscription] DROP CONSTRAINT IF EXISTS FK_subscription_user;

-- Drop foreign key constraints referencing the group table
ALTER TABLE [mod].[affiliation] DROP CONSTRAINT IF EXISTS FK_affiliation_group;

-- Drop foreign key constraints referencing the theme table
ALTER TABLE [mod].[event] DROP CONSTRAINT IF EXISTS FK_event_theme;

-- Drop foreign key constraints referencing the subtype table
ALTER TABLE [mod].[event] DROP CONSTRAINT IF EXISTS FK_event_subtype;

-- Drop foreign key constraints referencing the reporting table
ALTER TABLE [mod].[company] DROP CONSTRAINT IF EXISTS FK_company_reporting;

-- Drop foreign key constraints referencing the tag table
ALTER TABLE [mod].[tagging] DROP CONSTRAINT IF EXISTS FK_tagging_tag;

------------------------------------------------------------------------------------------------------
-- Now drop the tables
------------------------------------------------------------------------------------------------------

-- Drop the attendance table
DROP TABLE IF EXISTS [mod].[attendance];

-- Drop the subscription table
DROP TABLE IF EXISTS [mod].[subscription];

-- Drop the event table
DROP TABLE IF EXISTS [mod].[event];

-- Drop the theme table
DROP TABLE IF EXISTS [mod].[theme];

-- Drop the subtype table
DROP TABLE IF EXISTS [mod].[subtype];

-- Drop the venue table
DROP TABLE IF EXISTS [mod].[venue];

-- Drop the affiliation table
DROP TABLE IF EXISTS [mod].[affiliation];

-- Drop the company table
DROP TABLE IF EXISTS [mod].[company];

-- Drop the group table
DROP TABLE IF EXISTS [mod].[group];

-- Drop the reporting table
DROP TABLE IF EXISTS [mod].[reporting];

-- Drop the user table
DROP TABLE IF EXISTS [mod].[user];

-- Drop the tag table
DROP TABLE IF EXISTS [mod].[tag];

-- Drop the log table
DROP TABLE IF EXISTS [mod].[log];

-- Drop the tagging table
DROP TABLE IF EXISTS [mod].[tagging];

------------------------------------------------------------------------------------------------------
-- Drop the sequences
------------------------------------------------------------------------------------------------------
DROP SEQUENCE IF EXISTS [mod].[IdSequence_User];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Subscription];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Event];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Affiliation];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Company];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Reporting];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Tagging];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Log];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Tag];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Theme];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Subtype];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Venue];
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Group];

------------------------------------------------------------------------------------------------------
-- Drop the function
------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[mod].[fn_ValidateDateTimeColumn]') AND type IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    DROP FUNCTION [mod].[fn_ValidateDateTimeColumn];
END;

------------------------------------------------------------------------------------------------------
-- Drop the schema
------------------------------------------------------------------------------------------------------
DROP SCHEMA IF EXISTS [mod];
