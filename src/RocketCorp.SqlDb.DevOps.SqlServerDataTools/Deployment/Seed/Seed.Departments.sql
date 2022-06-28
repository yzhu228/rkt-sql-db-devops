SET IDENTITY_INSERT [RocketCorp].[Departments] ON

IF NOT EXISTS (SELECT * FROM [RocketCorp].[Departments] WHERE [Id] = 1)
BEGIN
    INSERT [RocketCorp].[Departments] ([Id], [Name])
    VALUES (1, N'Admin (SSDT)')
END

IF NOT EXISTS (SELECT * FROM [RocketCorp].[Departments] WHERE [Id] = 2)
BEGIN
    INSERT [RocketCorp].[Departments] ([Id], [Name])
    VALUES (2, N'Finance (SSDT)')
END

IF NOT EXISTS (SELECT * FROM [RocketCorp].[Departments] WHERE [Id] = 3)
BEGIN
    INSERT [RocketCorp].[Departments] ([Id], [Name])
    VALUES (3, N'Human Resources (SSDT)')
END

SET IDENTITY_INSERT [RocketCorp].[Departments] OFF
GO
