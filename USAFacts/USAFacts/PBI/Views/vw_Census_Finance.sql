﻿


CREATE VIEW [PBI].[vw_Census_Finance] 
AS
SELECT [ID_Code]
      ,[ID_Name]
      ,[County_Name]
      ,[FIPS_State]
      ,[FIPS_County]
      ,[FIPS_Place]
      ,[Population]
      ,[Population_Year]
      ,[Enrollment]
      ,[Enrollment_Year]
      ,[Function_Code_For_Special_Districts]
      ,[School_Level_Code]
      ,[Fiscal_Year_Ending]
      ,[Survey_Year]
      ,[Item_Code]
      ,[Amount_Thousands_Dollars]
      ,[Year_of_Data]
      ,[Imputation_Type_Item_Data_Flag]
      ,[ID_Code_State]
      ,[State]
      ,[Government_Type]
      ,[County_Type]
      ,[Unit_Identifier]
      ,[Government_Flag]
  FROM [Census].[Finance]