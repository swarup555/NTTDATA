
IF NOT EXISTS 
   (
     SELECT name FROM master.dbo.sysdatabases 
     WHERE name = N'TEST1'
    )
CREATE DATABASE [TEST1]

SET QUOTED_IDENTIFIER OFF;
GO
USE [TEST1];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Tbl_Employee_Tbl_Designation]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tbl_Employee] DROP CONSTRAINT [FK_Tbl_Employee_Tbl_Designation];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Tbl_Designation]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tbl_Designation];
GO
IF OBJECT_ID(N'[dbo].[Tbl_Employee]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tbl_Employee];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Tbl_Designation'
CREATE TABLE [dbo].[Tbl_Designation] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Dname] varchar(50)  NULL
);
GO

-- Creating table 'Tbl_Employee'
CREATE TABLE [dbo].[Tbl_Employee] (
    [EmpCode] int IDENTITY(1,1) NOT NULL,
    [Firstname] varchar(50)  NULL,
    [Lastname] varchar(50)  NULL,
    [Designation] int  NULL,
    [Salary] decimal(18,0)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ID] in table 'Tbl_Designation'
ALTER TABLE [dbo].[Tbl_Designation]
ADD CONSTRAINT [PK_Tbl_Designation]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [EmpCode] in table 'Tbl_Employee'
ALTER TABLE [dbo].[Tbl_Employee]
ADD CONSTRAINT [PK_Tbl_Employee]
    PRIMARY KEY CLUSTERED ([EmpCode] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Designation] in table 'Tbl_Employee'
ALTER TABLE [dbo].[Tbl_Employee]
ADD CONSTRAINT [FK_Tbl_Employee_Tbl_Designation]
    FOREIGN KEY ([Designation])
    REFERENCES [dbo].[Tbl_Designation]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Tbl_Employee_Tbl_Designation'
CREATE INDEX [IX_FK_Tbl_Employee_Tbl_Designation]
ON [dbo].[Tbl_Employee]
    ([Designation]);
GO

SET IDENTITY_INSERT [dbo].[Tbl_Designation] ON 

INSERT [dbo].[Tbl_Designation] ([ID], [Dname]) VALUES (1, N'se')
INSERT [dbo].[Tbl_Designation] ([ID], [Dname]) VALUES (2, N'sse')
INSERT [dbo].[Tbl_Designation] ([ID], [Dname]) VALUES (3, N'manager')
SET IDENTITY_INSERT [dbo].[Tbl_Designation] OFF
SET IDENTITY_INSERT [dbo].[Tbl_Employee] ON 

INSERT [dbo].[Tbl_Employee] ([EmpCode], [Firstname], [Lastname], [Designation], [Salary]) VALUES (1, N'swarup', N'mohanty', 3, CAST(200000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Tbl_Employee] OFF
GO
-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------