-- Create Main User for the connection to the database.

CREATE USER [Demo]
FOR LOGIN [WebControl]
WITH DEFAULT_SCHEMA = dbo;
GO

GRANT CONNECT TO [Demo]