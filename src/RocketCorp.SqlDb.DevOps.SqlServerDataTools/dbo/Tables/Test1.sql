CREATE TABLE [dbo].[Test1] (
    [C1] INT          NULL,
    [C2] INT          NULL,
    [C3] VARCHAR (50) NULL
);


GO
CREATE CLUSTERED INDEX [idx_c1]
    ON [dbo].[Test1]([C1] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_c2]
    ON [dbo].[Test1]([C2] ASC);

