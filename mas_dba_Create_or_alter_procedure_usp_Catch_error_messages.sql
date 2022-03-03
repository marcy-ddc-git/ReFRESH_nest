USE [DAXAGReFRESH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROC [dbo].[usp_Catch_error_messages]
AS
  SELECT   
      GETDATE() AS Timestamp,    
	  ERROR_NUMBER() AS ErrorNumber,  
      ERROR_SEVERITY() AS ErrorSeverity,
      ERROR_STATE() AS ErrorState,
      ERROR_LINE () AS ErrorLine,
      ERROR_PROCEDURE() AS ErrorProcedure,
      ERROR_MESSAGE() AS ErrorMessage;  
GO


