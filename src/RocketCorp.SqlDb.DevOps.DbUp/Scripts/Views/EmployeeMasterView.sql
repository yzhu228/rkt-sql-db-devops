SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [RocketCorp].[EmployeeMasterView]
AS
SELECT C.FirstName, C.LastName, D.[Name] AS DepartmentName
FROM [RocketCorp].[Contacts] C INNER JOIN 
[RocketCorp].[Departments] D ON
C.DepartmentId = D.Id