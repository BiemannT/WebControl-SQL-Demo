-- Set a new Password for a login and reset the login timestamps.
-- DANGER: The client API has to safeguard the correct implementation of this procedures.
-- This procedure should be only available for authenticated users.

CREATE PROCEDURE [dbo].[UPD_User_Pwd] @ID AS INT,
@LoginPwd AS VARCHAR(50),
@PwdEncrypt AS VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @EncryptedPwd AS VARBINARY(MAX);

	BEGIN TRY
		-- Check encryption password
		IF LEN(TRIM(@PwdEncrypt)) < 8
			THROW 50003, 'The minimum required length of the encryption phrase is 8 characters!', 1;

		-- Encrypt Password
		SET @EncryptedPwd = ENCRYPTBYPASSPHRASE(TRIM(@PwdEncrypt), @LoginPwd);

		UPDATE [dbo].[Users]
		SET [LoginPwd] = @EncryptedPwd
		   ,[LastSuccesfulLogin] = NULL
		   ,[LastFailedLogin] = NULL
		   ,[FailedLoginCounter] = DEFAULT
		WHERE [ID] = @ID;

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		THROW;

	END CATCH;
END