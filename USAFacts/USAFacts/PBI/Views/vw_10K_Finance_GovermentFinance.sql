﻿CREATE VIEW PBI.[vw_10K_Finance_GovermentFinance]
AS
	SELECT [GovernmentType]
		  ,[StateCode]
		  ,[Type]
		  ,[Source]
		  ,[Grant]
		  ,[CensusCode]
		  ,[CensusDescription]
		  ,[Segment1]
		  ,[Segment2]
		  ,[Segment3]
		  ,[Segment4]
		  ,[Year]
		  ,[Measure]
		  ,[Unit]
		  ,[Value]
	  FROM [Finance].[GovermentFinance]
  WHERE FileVersionId = 20180320;