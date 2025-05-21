-- This trigger blocks all direct transactions to the users-table.
-- It is only allowed to modify the table by procedures.

CREATE TRIGGER [dbo].[Users_BlockDirect]
ON [dbo].[Users]
FOR DELETE, INSERT, UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	IF @@NESTLEVEL <= 1
	BEGIN
		IF @@TRANCOUNT > 0
			ROLLBACK;
		THROW 50004, 'No direct modifications allowed on the users-table!', 1;

	END;
END;