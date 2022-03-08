USE [DAXAGReFRESH]
GO

/****** Object:  StoredProcedure [dbo].[usp_Catch_error_messages]    Script Date: 3/6/2022 5:50:39 PM ******/
DROP PROCEDURE [dbo].[usp_Catch_error_messages]
GO

/****** Object:  StoredProcedure [dbo].[usp_Catch_error_messages]    Script Date: 3/6/2022 5:50:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER  PROC [dbo].[usp_Catch_error_messages]
AS

DECLARE @Timestamp DATETIME
;
SET @Timestamp = GETDATE()

  SELECT   
    @Timestamp,    
	ERROR_NUMBER() AS ErrorNumber,  
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_LINE () AS ErrorLine,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_MESSAGE() AS ErrorMessage
	;

  INSERT INTO dbo.tb_AG_script_error_log
    VALUES
    (SUSER_SNAME(),
	 ERROR_NUMBER(),
     ERROR_STATE(),
     ERROR_SEVERITY(),
     ERROR_LINE(),
     ERROR_PROCEDURE(),
     ERROR_MESSAGE(),
     @Timestamp
	);  

GO


