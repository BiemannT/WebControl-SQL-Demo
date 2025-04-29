-- Creates a new user for this database.

CREATE PROCEDURE [dbo].[INS_User] @LoginName AS VARCHAR(50),
@LoginPwd AS VARCHAR(50),
@PwdEncrypt AS VARCHAR(20),
@FirstName AS VARCHAR(50) = NULL,
@LastName AS VARCHAR(50) = NULL,
@Department AS VARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @EncryptedPwd AS VARBINARY(MAX);
	DECLARE @NewUserID AS INT;

	BEGIN TRY
		-- Check encryption password
		IF LEN(TRIM(@PwdEncrypt)) < 8
			THROW 50000, 'The minimum required length of the encryption phrase is 8 characters!', 1;

		-- Encrypt Password
		SET @EncryptedPwd = ENCRYPTBYPASSPHRASE(TRIM(@PwdEncrypt), @LoginPwd);

		-- Insert main user-data into the Users-table
		INSERT INTO [dbo].[Users] ([LoginName], [LoginPwd], [FirstName], [LastName], [Department], [LoginActive])
			VALUES (TRIM(@LoginName), @EncryptedPwd, TRIM(@FirstName), TRIM(@LastName), TRIM(@Department), 1);

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;

		IF ERROR_MESSAGE() LIKE '%IX_Users%'
			THROW 50001, 'The selected Login Name already exists.', 1;

		ELSE
			THROW;

	END CATCH;
END;