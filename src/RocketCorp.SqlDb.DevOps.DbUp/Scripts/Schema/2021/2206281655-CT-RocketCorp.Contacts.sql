SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [RocketCorp].[Contacts]
(
	[Id] INT NOT NULL IDENTITY,
	[FirstName] NVARCHAR(255) NULL,
	[LastName] NVARCHAR(255) NOT NULL,
	[IsActive] BIT NOT NULL,
	[DepartmentId] INT,
    CONSTRAINT [PK_Contacts] PRIMARY KEY ([Id]), 
    CONSTRAINT [FK_Contacts_Deparments] FOREIGN KEY ([DepartmentId]) REFERENCES [RocketCorp].[Departments]([Id])
)
GO