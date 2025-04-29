-- Validates the given password for a user login.
-- Return 0 if the password is correct. In this case the Column "LastSuccesfulLogin" will be updated to the current timestamp.
-- Return 1 if the requested UserID doesn't exist.
-- Return 2 if the given password isn't valid. In this case the column "LastFailedLogin" will be updated to the current timestamp and the column "FailedLoginCounter" will be increased by 1.
-- Return 3 if the requested UserID is blocked.
-- Return 4 if the Login for the requested UserID is disabled.

CREATE PROCEDURE [dbo].[SEL_User_Validate] @ID AS INT,
@LoginPwd AS VARCHAR(50),
@PwdEncrypt AS VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @OriginPwd AS VARCHAR(50);
	DECLARE @LoginBlocked AS BIT;
	DECLARE @LoginActive AS BIT;

	-- Select the encrypted password and the blocked state from the database.
	SELECT
		@OriginPwd = CONVERT(VARCHAR(50), DECRYPTBYPASSPHRASE(@PwdEncrypt, [u].[LoginPwd]))
	   ,@LoginBlocked = [u].[LoginBlocked]
	   ,@LoginActive = [u].[LoginActive]
	FROM [dbo].[Users] [u]
	WHERE [u].[ID] = @ID;

	-- If no User with the given ID exists
	IF @@ROWCOUNT = 0
		RETURN 1;

	-- If the user is already blocked
	ELSE
	IF @LoginBlocked = 1
		RETURN 3;

	-- If the login is disabled
	ELSE
	IF @LoginActive = 0
		RETURN 4;

	-- Check if the given password is identical to the password in the database.
	ELSE
	IF @LoginPwd = @OriginPwd
	-- If the password is correct, set the actual timestamp to the "LastSuccesfulLogin"-column and reset the "FailedLoginCounter"-column.
	BEGIN
		UPDATE [dbo].[Users]
		SET [LastSuccesfulLogin] = GETDATE()
		   ,[FailedLoginCounter] = DEFAULT
		WHERE [ID] = @ID;

		RETURN 0;

	END;

	ELSE
	-- If the password isn't valid, set the actual timestamp to the "LastFailedLogin"-column and increment the "FailedLoginCounter"-column.
	BEGIN
		UPDATE [dbo].[Users]
		SET [LastFailedLogin] = GETDATE()
		   ,[FailedLoginCounter] += 1
		WHERE [ID] = @ID;

		RETURN 2;
	END;

END;