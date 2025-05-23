/*
Vorlage für ein Skript nach der Bereitstellung							
--------------------------------------------------------------------------------------
 Diese Datei enthält SQL-Anweisungen, die an das Buildskript angefügt werden.		
 Schließen Sie mit der SQLCMD-Syntax eine Datei in das Skript nach der Bereitstellung ein.			
 Beispiel:   :r .\myfile.sql								
 Verwenden Sie die SQLCMD-Syntax, um auf eine Variable im Skript nach der Bereitstellung zu verweisen.		
 Beispiel:   :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

SET XACT_ABORT ON;

-- Fill Base-Tables

-- Errors-Table
:R ..\Latest\Basedata\Errors.sql

-- Set current version number into VersionHistory-table
INSERT INTO [dbo].[VersionHistory] ([MajorVers], [MinorVers], [PatchVers])
	VALUES (1, 1, 0);