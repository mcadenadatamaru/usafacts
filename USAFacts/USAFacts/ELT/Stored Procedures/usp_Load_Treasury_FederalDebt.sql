﻿/*====================================================================================================================================
 PURPOSE:	        Used in ELT Process to load, process and load data from staging
 PARAMETERS:		None.
 USAGE:				EXEC [ELT].[usp_Load_Treasury_FederalDebt] 20180320
 
 HISTORY: 
 Date           Description
----------------------------------------------
03/13/2018		Created
======================================================================================================================================
*/
CREATE   PROCEDURE [ELT].[usp_Load_Treasury_FederalDebt]
@FileVersionId INT 
AS
BEGIN 

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRY

-- Prepare destination tables
IF OBJECT_ID(N'[Treasury].[FederalDebt]', N'U') IS NULL
	CREATE TABLE Treasury.FederalDebt(
		[RowId] [int] IDENTITY(1,1) NOT NULL,
		[FileVersionId] [int] NOT NULL,
	  [Federal debt securities held by the public and accrued interest ] [nvarchar](255) NULL,
	  [Category] [nvarchar](255) NULL,
	  [GovernmentType] [nvarchar](255) NULL,
	  [2009] [float] NULL,
	  [2010] [float] NULL,
	  [2011] [float] NULL,
	  [2012] [float] NULL,
	  [2013] [float] NULL,
	  [2014] [float] NULL,
	  [2015] [float] NULL,
	  [2016] [float] NULL,
	  [RowHash] [varbinary](MAX) NULL,
 CONSTRAINT [PK_Note20] PRIMARY KEY CLUSTERED 
(
	[RowId] ASC, FileVersionId
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


-- Load data from Staging

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20)); 

	MERGE Treasury.FederalDebt AS Target
	USING ( SELECT [Federal debt securities held by the public and accrued interest ]
            ,[Category]
            ,[Government Type]
            ,[2009]
            ,[2010]
            ,[2011]
            ,[2012]
            ,[2013]
            ,[2014]
            ,[2015]
            ,[2016]
            ,[FileVersionId]
            ,HASHBYTES ('SHA2_256', ISNULL(RTRIM([Federal debt securities held by the public and accrued interest ]),'')+ISNULL(RTRIM([Category]),'')+ISNULL(RTRIM([Government Type]),'')+ISNULL(RTRIM([2009]),'')+ISNULL(RTRIM([2010]),'')+ISNULL(RTRIM([2011]),'')+ISNULL(RTRIM([2012]),'')+ISNULL(RTRIM([2013]),'')+ISNULL(RTRIM([2014]),'')+ISNULL(RTRIM([2015]),'')+ISNULL(RTRIM([2016]),'')) AS RowHash
          FROM [Staging].[Note 11]
		   ) AS Source
		ON (Target.FileVersionId = Source.FileVersionId
				AND Target.RowHash = Source.RowHash)
		
	WHEN MATCHED THEN UPDATE SET 
	    Target.[Federal debt securities held by the public and accrued interest ] = Source.[Federal debt securities held by the public and accrued interest ]
     ,Target.[Category] = SOURCE.[Category]
	   ,Target.[GovernmentType] = Source.[Government Type]
     ,Target.[2009] = Source.[2009]
	   ,Target.[2010] = Source.[2010]
	   ,Target.[2011] = Source.[2011]
	   ,Target.[2012] = Source.[2012]
     ,Target.[2013] = Source.[2013]
     ,Target.[2014] = Source.[2014]
     ,Target.[2015] = Source.[2015]
     ,Target.[2016] = Source.[2016]
	   ,Target.FileVersionId = Source.FileVersionId
	 
	WHEN NOT MATCHED BY TARGET THEN INSERT
		([Federal debt securities held by the public and accrued interest ]
		,[Category]
    ,[GovernmentType]
		,[2009]
		,[2010]
		,[2011]
		,[2012]
    ,[2013]
    ,[2014]
    ,[2015]
    ,[2016]
		,[FileVersionId]
		,[RowHash]
		)
		VALUES (
		 Source.[Federal debt securities held by the public and accrued interest ]
    ,Source.Category
		,Source.[Government Type]
		,Source.[2009]
		,Source.[2010]
		,Source.[2011]
		,Source.[2012]
    ,Source.[2013]
		,Source.[2014]
		,Source.[2015]
		,Source.[2016]
		,Source.[FileVersionId]
		,Source.[RowHash]
		)

	OUTPUT $action INTO @SummaryOfChanges;
  
	SELECT Change, COUNT(*) AS CountPerChange
	FROM @SummaryOfChanges
	GROUP BY Change;
	
END TRY 
BEGIN CATCH
	EXEC dbo.usp_GetErrorInfo;
END CATCH
END