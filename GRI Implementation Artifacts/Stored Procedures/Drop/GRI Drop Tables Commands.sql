/*
Order To Drop Tables Acounting For FK Error 
Drop Any Stored Procedures and Functions Using Mod Schema
Drop All Sequence Records That Are Active 
*/

----------------------------------------------------------------------------
-- Drop Tables 
----------------------------------------------------------------------------
-- Drop the attendance table
DROP TABLE IF EXISTS [mod].[attendance];

-- Drop the subscription table
DROP TABLE IF EXISTS [mod].[subscription];

-- Drop the event table
DROP TABLE IF EXISTS [mod].[event];

-- Drop the theme, subtype, and venue tables
DROP TABLE IF EXISTS [mod].[theme];
DROP TABLE IF EXISTS [mod].[subtype];
DROP TABLE IF EXISTS [mod].[venue];

-- Drop the affiliation table
DROP TABLE IF EXISTS [mod].[affiliation];

-- Drop the company, group, and reporting tables
DROP TABLE IF EXISTS [mod].[company];
DROP TABLE IF EXISTS [mod].[group];
DROP TABLE IF EXISTS [mod].[reporting];

-- Drop the user and tag tables
DROP TABLE IF EXISTS [mod].[user];
DROP TABLE IF EXISTS [mod].[tag];

--Drop the log table 
DROP TABLE IF EXISTS [mod].[log];

----------------------------------------------------------------------------
-- Drop Functions & Stored Procedures 
----------------------------------------------------------------------------
DROP FUNCTION IF EXISTS [mod].[fn_ValidateDateTimeColumn];

----------------------------------------------------------------------------
-- Drop Sequences
----------------------------------------------------------------------------
-- Drop sequences for User table
DROP SEQUENCE IF EXISTS [mod].[IdSequence_User];

-- Drop sequences for Subscription table
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Subscription];

-- Drop sequences for Event table
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Event];

-- Drop sequences for Affiliation table
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Affiliation];

-- Drop sequences for Company table
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Company];

-- Drop sequences for Reporting table
DROP SEQUENCE IF EXISTS [mod].[IdSequence_Reporting];