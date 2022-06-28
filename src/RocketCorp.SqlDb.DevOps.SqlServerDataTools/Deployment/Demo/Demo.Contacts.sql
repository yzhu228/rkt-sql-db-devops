SET IDENTITY_INSERT [RocketCorp].[Contacts] ON 
GO

IF NOT EXISTS (SELECT * FROM [RocketCorp].[Contacts] WHERE [Id] = 1)
BEGIN
    INSERT [RocketCorp].[Contacts] ([Id], [FirstName], [LastName], [IsActive], [DepartmentId])
    VALUES (1, N'John', N'Smith', 1, 3)
END

IF NOT EXISTS (SELECT * FROM [RocketCorp].[Contacts] WHERE [Id] = 2)
BEGIN
    INSERT [RocketCorp].[Contacts] ([Id], [FirstName], [LastName], [IsActive], [DepartmentId])
    VALUES (2, N'Anne', N'Marian', 1, 2)
END

IF NOT EXISTS (SELECT * FROM [RocketCorp].[Contacts] WHERE [Id] = 3)
BEGIN
    INSERT [RocketCorp].[Contacts] ([Id], [FirstName], [LastName], [IsActive], [DepartmentId])
    VALUES (3, N'Ash', N'Oliver', 1, 1)
END

SET IDENTITY_INSERT [RocketCorp].[Contacts] OFF
GO