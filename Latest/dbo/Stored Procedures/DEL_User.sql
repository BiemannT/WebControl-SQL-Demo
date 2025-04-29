-- Deletes an user from the database, based on the internal ID.

CREATE PROCEDURE [dbo].[DEL_User] @ID AS INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		-- Delete the User
		DELETE FROM [dbo].[Users]
		WHERE [ID] = @ID;

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		THROW;

	END CATCH;
END;