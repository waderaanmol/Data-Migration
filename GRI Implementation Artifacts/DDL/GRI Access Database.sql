-- USE [MARCOM_DEV]
GO
/****** Object:  Table [dbo].[affiliation]    Script Date: 5/27/2024 12:15:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[affiliation]
(
	[a_id] [int] IDENTITY(1,1) NOT NULL,
	[a_name_id] [nvarchar](255) NULL,
	[a_company_name] [nvarchar](255) NULL,
	[a_c_id] [int] NULL,
	[a_u_id] [int] NULL,
	[a_group] [nvarchar](255) NULL,
	[a_primary] [nvarchar](255) NULL,
	CONSTRAINT [affiliation$ID] PRIMARY KEY CLUSTERED 
(
	[a_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[attendance]    Script Date: 5/27/2024 12:15:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[attendance]
(
	[a_id] [int] IDENTITY(1,1) NOT NULL,
	[a_name_id] [nvarchar](255) NULL,
	[a_event_name] [nvarchar](255) NULL,
	[a_company] [nvarchar](255) NULL,
	[a_attendee] [nvarchar](255) NULL,
	[a_consecutive_attendance] [nvarchar](255) NULL,
	[a_media] [nvarchar](255) NULL,
	[a_staff] [nvarchar](255) NULL,
	[a_speaker] [nvarchar](255) NULL,
	[a_group] [nvarchar](255) NULL,
	[a_status] [nvarchar](255) NULL,
	[a_u_id] [int] NULL,
	[a_e_id] [int] NULL,
	[a_rating] [int] NULL,
	[a_r_id] [int] NULL,
	[a_venue] [nvarchar](255) NULL,
	CONSTRAINT [attendance$ID] PRIMARY KEY CLUSTERED 
(
	[a_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[company]    Script Date: 5/27/2024 12:15:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company]
(
	[c_id] [int] IDENTITY(1,1) NOT NULL,
	[c_name] [nvarchar](255) NULL,
	[c_umbrella] [nvarchar](255) NULL,
	[c_reporting] [nvarchar](255) NULL,
	[c_status] [nvarchar](255) NULL,
	[c_r_id] [int] NULL,
	CONSTRAINT [company$ID] PRIMARY KEY CLUSTERED 
(
	[c_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[events]    Script Date: 5/27/2024 12:15:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[events]
(
	[e_id] [int] IDENTITY(1,1) NOT NULL,
	[e_name] [nvarchar](255) NULL,
	[e_date] [datetime2](0) NULL,
	[e_type] [nvarchar](255) NULL,
	[e_subtype] [nvarchar](255) NULL,
	[e_theme] [nvarchar](255) NULL,
	[e_venue] [nvarchar](255) NULL,
	[e_hours] [float] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
	CONSTRAINT [events$ID] PRIMARY KEY CLUSTERED 
(
	[e_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Group]    Script Date: 5/27/2024 12:15:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Group]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[g_name] [nvarchar](255) NULL,
	CONSTRAINT [Group$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reporting]    Script Date: 5/27/2024 12:15:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reporting]
(
	[r_name] [nvarchar](255) NULL,
	[r_id] [int] IDENTITY(1,1) NOT NULL,
	[r_start] [nvarchar](255) NULL,
	[r_end] [datetime2](0) NULL,
	[r_status] [nvarchar](255) NULL,
	CONSTRAINT [reporting$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[r_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subtype]    Script Date: 5/27/2024 12:15:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subtype]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Subtype] [nvarchar](255) NULL,
	CONSTRAINT [Subtype$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tags]    Script Date: 5/27/2024 12:15:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Tags] [nvarchar](255) NULL,
	CONSTRAINT [Tags$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Theme]    Script Date: 5/27/2024 12:15:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Theme]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Field1] [nvarchar](255) NULL,
	CONSTRAINT [Theme$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 5/27/2024 12:15:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users]
(
	[u_id] [int] IDENTITY(1,1) NOT NULL,
	[u_display] [nvarchar](255) NULL,
	[u_name_id] [nvarchar](255) NULL,
	[u_first] [nvarchar](255) NULL,
	[u_last] [nvarchar](255) NULL,
	[u_email_1] [nvarchar](255) NULL,
	[u_email_2] [nvarchar](255) NULL,
	[u_title] [nvarchar](255) NULL,
	[u_time_stamp] [datetime2](0) NULL,
	[u_source] [nvarchar](255) NULL,
	[u_tag] [nvarchar](255) NULL,
	[u_notes] [nvarchar](255) NULL,
	[u_domain] [nvarchar](255) NULL,
	[u_status] [nvarchar](255) NULL,
	CONSTRAINT [users$ID] PRIMARY KEY CLUSTERED 
(
	[u_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venue]    Script Date: 5/27/2024 12:15:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venue]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Venue] [nvarchar](255) NULL,
	CONSTRAINT [Venue$PrimaryKey] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[affiliation] ADD  DEFAULT ((0)) FOR [a_c_id]
GO
ALTER TABLE [dbo].[affiliation] ADD  DEFAULT ((0)) FOR [a_u_id]
GO
ALTER TABLE [dbo].[attendance] ADD  DEFAULT ((0)) FOR [a_u_id]
GO
ALTER TABLE [dbo].[attendance] ADD  DEFAULT ((0)) FOR [a_e_id]
GO
ALTER TABLE [dbo].[attendance] ADD  DEFAULT ((0)) FOR [a_rating]
GO
ALTER TABLE [dbo].[attendance] ADD  DEFAULT ((0)) FOR [a_r_id]
GO
ALTER TABLE [dbo].[company] ADD  DEFAULT ((0)) FOR [c_r_id]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique numerical identifier for each user''s affiliation with a company, serving as the primary key.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[affiliation].[a_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Represents the full name of each user. It is a text field that combines the first and last names together.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_name_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[affiliation].[a_name_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_name_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the company the user is affiliated with.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_company_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[affiliation].[a_company_name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_company_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique numerical identifier serving as the foreign key, establishing a connection between affiliation table and company table.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_c_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[affiliation].[a_c_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_c_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique numerical identifier serving as the foreign key, establishing a connection between affiliation table and users table.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_u_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[affiliation].[a_u_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_u_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The designation of the person at the company they are affiliated with. Only certain desginations get assigned in this field. Refer Group table for more.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[affiliation].[a_group]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[affiliation].[a_primary]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'COLUMN',@level2name=N'a_primary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[affiliation].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation', @level2type=N'CONSTRAINT',@level2name=N'affiliation$ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[affiliation]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'affiliation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique numerical identifier for each attendee, acting as the primary key.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_name_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_name_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the event.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_event_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_event_name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_event_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the company where the attendee is employed.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_company'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_company]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_company'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_attendee]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_attendee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_consecutive_attendance]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_consecutive_attendance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_media]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_media'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_staff]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_staff'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_speaker]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_speaker'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_group]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indicates if the attendee is an employee of a member organisation with Global Risk Institute.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_status]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique numerical identifier serving as the foreign key, establishing a connection between users table and attendance table.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_u_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_u_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_u_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique numerical identifier serving as the foreign key, establishing a connection between users table and event table.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_e_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_e_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_e_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The rating given by attendee for the event on a scale of 1 to 5.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_rating'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_rating]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_rating'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique numerical identifier serving as the foreign key, establishing a connection between attendance table and reporting table.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_r_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_r_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_r_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'was the attendance recorded in-person or virtual' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_venue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[a_venue]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'COLUMN',@level2name=N'a_venue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance', @level2type=N'CONSTRAINT',@level2name=N'attendance$ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[attendance]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'attendance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique numerical identifier for each company, acting as the primary key.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[company].[c_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the company.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[company].[c_name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The official name of the company used outside of GRI''s reporting requirements.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_umbrella'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[company].[c_umbrella]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_umbrella'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The official and legal name of the company used in GRI''s reporting.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_reporting'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[company].[c_reporting]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_reporting'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Signifies the status of the membership with Global Risk Institute.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[company].[c_status]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique numerical identifier serving as the foreign key, establishing a connection between company table and reporting table.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_r_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[company].[c_r_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'COLUMN',@level2name=N'c_r_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[company].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company', @level2type=N'CONSTRAINT',@level2name=N'company$ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[company]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'company'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique numerical identifier for each event, acting as the primary key.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[events].[e_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the event.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[events].[e_name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The date that the event took place.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[events].[e_date]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The main category of the event - Event/Education/Summit.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[events].[e_type]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A detailed categorical type of the event.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_subtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[events].[e_subtype]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_subtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The topic of discussion at the event.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_theme'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[events].[e_theme]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_theme'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The place where the event took place.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_venue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[events].[e_venue]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_venue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The duration of the event in number of hours.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_hours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[events].[e_hours]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'COLUMN',@level2name=N'e_hours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[events].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events', @level2type=N'CONSTRAINT',@level2name=N'events$ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[events]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'events'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Group].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Group', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Group].[g_name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Group', @level2type=N'COLUMN',@level2name=N'g_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Group].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Group', @level2type=N'CONSTRAINT',@level2name=N'Group$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Group]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[reporting].[r_name]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reporting', @level2type=N'COLUMN',@level2name=N'r_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[reporting].[r_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reporting', @level2type=N'COLUMN',@level2name=N'r_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[reporting].[r_start]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reporting', @level2type=N'COLUMN',@level2name=N'r_start'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[reporting].[r_end]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reporting', @level2type=N'COLUMN',@level2name=N'r_end'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[reporting].[r_status]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reporting', @level2type=N'COLUMN',@level2name=N'r_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[reporting].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reporting', @level2type=N'CONSTRAINT',@level2name=N'reporting$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[reporting]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'reporting'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Subtype].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Subtype', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Subtype].[Subtype]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Subtype', @level2type=N'COLUMN',@level2name=N'Subtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Subtype].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Subtype', @level2type=N'CONSTRAINT',@level2name=N'Subtype$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Subtype]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Subtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Tags].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tags', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Tags].[Tags]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tags', @level2type=N'COLUMN',@level2name=N'Tags'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Tags].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tags', @level2type=N'CONSTRAINT',@level2name=N'Tags$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Tags]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tags'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Theme].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Theme', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Theme].[Field1]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Theme', @level2type=N'COLUMN',@level2name=N'Field1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Theme].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Theme', @level2type=N'CONSTRAINT',@level2name=N'Theme$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Theme]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Theme'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A unique numerical identifier for each user, acting as the primary key.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_display]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_display'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Represents the full name of each user. It is a text field that combines the first and last names together.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_name_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_name_id]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_name_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The first name of the user.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_first'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_first]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_first'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The last name of the user.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_last'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_last]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_last'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The primary email address of the user.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_email_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_email_1]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_email_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A secondary email address of the user which includes email address of the user''s executive assistant.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_email_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_email_2]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_email_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The job title of the user at the company they work.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_title]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Signifies the date when the most recent update was made to the user''s information.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_time_stamp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_time_stamp]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_time_stamp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indicates the origin of the user. Source could be internal or online.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_source'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_source]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_source'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_tag]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_tag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Any noteworthy points or remarks regarding the user.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_notes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_notes]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_notes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The domain of the user''s primary email address.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_domain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_domain]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_domain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[u_status]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'COLUMN',@level2name=N'u_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users', @level2type=N'CONSTRAINT',@level2name=N'users$ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[users]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'users'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Venue].[ID]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Venue', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Venue].[Venue]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Venue', @level2type=N'COLUMN',@level2name=N'Venue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Venue].[PrimaryKey]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Venue', @level2type=N'CONSTRAINT',@level2name=N'Venue$PrimaryKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'20240510_Database_Working_File.[Venue]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Venue'
GO
