﻿CREATE TABLE [bls].[LNS12600000] (
    [Series_Id]  NVARCHAR (50) NOT NULL,
    [Year]       INT           NOT NULL,
    [Period]     NVARCHAR (50) NOT NULL,
    [Value]      NVARCHAR (50) NOT NULL,
    [Modified]   DATETIME2 (0) CONSTRAINT [DF_LNS12600000_Modified] DEFAULT (sysutcdatetime()) NOT NULL,
    [ModifiedBy] NVARCHAR (50) CONSTRAINT [DF_LNS12600000_ModifiedBy] DEFAULT (suser_sname()) NOT NULL,
    [Created]    DATETIME2 (0) CONSTRAINT [DF_LNS12600000_Created] DEFAULT (sysutcdatetime()) NOT NULL,
    [CreatedBy]  NVARCHAR (50) CONSTRAINT [DF_LNS12600000_CreatedBy] DEFAULT (suser_sname()) NOT NULL
);




GO

CREATE TRIGGER bls.trg_LNS12600000_After_Update ON bls.LNS12600000
FOR UPDATE AS 
BEGIN 
  SET NOCOUNT ON 

  IF (( SELECT TRIGGER_NESTLEVEL()) > 1 )
    RETURN

  UPDATE bls.LNS12600000
  SET Created = deleted.Created,
      CreatedBy = deleted.CreatedBy,
      Modified = SYSUTCDATETIME(),
      ModifiedBy = SUSER_SNAME()
  FROM bls.LNS12600000
  INNER JOIN deleted
    ON bls.LNS12600000.[Year] = deleted.[Year]
        AND bls.LNS12600000.[Period] = deleted.[Period];
END
GO

-- Triggers
CREATE TRIGGER bls.trg_LNS12600000_After_Insert ON bls.LNS12600000
FOR INSERT AS
  BEGIN 
    SET NOCOUNT ON

    UPDATE bls.LNS12600000
    SET Created = SYSUTCDATETIME(),
        CreatedBy = SUSER_SNAME(),
        Modified = SYSUTCDATETIME(),
        ModifiedBy = SUSER_SNAME()
    FROM bls.LNS12600000
    INNER JOIN inserted 
      ON bls.LNS12600000.[Year] = inserted.[Year]
        AND bls.LNS12600000.[Period] = inserted.[Period];
  END