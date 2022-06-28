CREATE TABLE [dbo].[Contacts]
(
	[Id] INT NOT NULL IDENTITY,
	[FirstName] NVARCHAR(255) NULL,
	[LastName] NVARCHAR(255) NOT NULL,
	[IsActive] BIT NOT NULL,
	[DepartmentId] INT,
    CONSTRAINT [PK_Contacts] PRIMARY KEY ([Id]), 
    CONSTRAINT [FK_Contacts_Deparments] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[Departments]([Id])
)
