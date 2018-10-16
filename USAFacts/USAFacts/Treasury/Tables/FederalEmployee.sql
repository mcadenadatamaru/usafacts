﻿CREATE TABLE [Treasury].[FederalEmployee] (
    [RowId]                                                            INT            IDENTITY (1, 1) NOT NULL,
    [FileVersionId]                                                    INT            NULL,
    [Federal employee and veteran benefits payable (In billions of do] NVARCHAR (255) NULL,
    [Category]                                                         NVARCHAR (255) NULL,
    [GovernmentType]                                                  NVARCHAR (255) NULL,
    [2009]                                                             FLOAT (53)     NULL,
    [2010]                                                             FLOAT (53)     NULL,
    [2011]                                                             FLOAT (53)     NULL,
    [2012]                                                             FLOAT (53)     NULL,
    [2013]                                                             FLOAT (53)     NULL,
    [2014]                                                             FLOAT (53)     NULL,
    [2015]                                                             FLOAT (53)     NULL,
    [2016]                                                             FLOAT (53)     NULL,
    [RowHash] VARBINARY(MAX) NULL, 
    CONSTRAINT [PK_Note12] PRIMARY KEY CLUSTERED ([RowId] ASC)
);

