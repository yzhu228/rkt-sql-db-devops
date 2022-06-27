SET IDENTITY_INSERT [RocketCorp].[Contacts] ON 

INSERT [RocketCorp].[Contacts] ([Id], [FirstName], [LastName], [IsActive], [DepartmentId]) VALUES (1, N'John', N'Smith', 1, 3)
INSERT [RocketCorp].[Contacts] ([Id], [FirstName], [LastName], [IsActive], [DepartmentId]) VALUES (2, N'Anne', N'Marian', 1, 2)
INSERT [RocketCorp].[Contacts] ([Id], [FirstName], [LastName], [IsActive], [DepartmentId]) VALUES (3, N'Ash', N'Oliver', 1, 1)

SET IDENTITY_INSERT [RocketCorp].[Contacts] OFF
GO
