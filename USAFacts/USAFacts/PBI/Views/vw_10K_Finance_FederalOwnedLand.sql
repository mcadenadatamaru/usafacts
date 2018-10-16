﻿CREATE VIEW PBI.[vw_10K_Finance_FederalOwnedLand]
AS
SELECT [StateName]
			,[State]
			,[StateCode]
			,[BLM]
			,[FS]
			,[FWS]
			,[NPS]
			,[DOD]
			,[TotalFederalAcreage]
			,[TotalAcreageInState]
		FROM Property.FederalLand
  WHERE FileVersionId = 20180320;