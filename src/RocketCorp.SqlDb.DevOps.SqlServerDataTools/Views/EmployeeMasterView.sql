CREATE VIEW [dbo].[EmployeeMasterView]
AS
SELECT C.FirstName, C.LastName, D.[Name] AS DepartmentName
FROM [dbo].[Contacts] C INNER JOIN 
[dbo].[Departments] D ON
C.DepartmentId = D.Id

