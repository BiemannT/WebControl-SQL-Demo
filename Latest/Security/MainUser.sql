-- Create Main User for the connection to the database.

CREATE USER [Demo]
FOR LOGIN [WebControl]
WITH DEFAULT_SCHEMA = dbo;
GO

GRANT CONNECT TO [Demo];
GO

GRANT EXECUTE ON [dbo].[DEL_User] TO [Demo];
GO

GRANT EXECUTE ON [dbo].[INS_User] TO [Demo];
GO

GRANT EXECUTE ON [dbo].[SEL_User_Details] TO [Demo];
GO

GRANT EXECUTE ON [dbo].[SEL_User_Validate] TO [Demo];
GO

GRANT EXECUTE ON [dbo].[SEL_Users] TO [Demo];
GO

GRANT EXECUTE ON [dbo].[UPD_User_Details] TO [Demo];
GO

GRANT EXECUTE ON [dbo].[UPD_User_Pwd] TO [Demo];
GO