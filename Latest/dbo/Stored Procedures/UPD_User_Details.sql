-- Update the user data in this database.

CREATE PROCEDURE [dbo].[UPD_User_Details] @ID AS INT,
@LoginName AS VARCHAR(50),
@FirstName AS VARCHAR(50) = NULL,
@LastName AS VARCHAR(50) = NULL,
@Department AS VARCHAR(50) = NULL,
@LoginActive AS BIT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY

		UPDATE [dbo].[Users]
		SET [LoginName] = @LoginName
		   ,[FirstName] = @FirstName
		   ,[LastName] = @LastName
		   ,[Department] = @Department
		   ,[LoginActive] = @LoginActive
		WHERE [ID] = @ID;

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		IF ERROR_MESSAGE() LIKE '%IX_Users%'
			THROW 50002, 'The selected Login Name already exists.', 1;

		ELSE
			THROW;

	END CATCH;
END;