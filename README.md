# WebControl-SQL-Demo
Es handelt sich hierbei um ein einfaches SQL-Datenbankprojekt welches in Visual Studio erstellt wurde. Es dient in erster Linie dazu die Funktionalität des Repositorys **WebControl-PHP-SQLCom** zu demonstrieren.

In dieser Datenbank befindet sich eine Benutzer-Tabelle mit diversen Prozeduren, um Benutzer anzulegen, zu verwalten, zu löschen und die Zugriffsberechtigung zu validieren.

## Voraussetzungen
Die SQL-Datenbank wurde unter den Versionen MS SQL-Server 2017 / 2019 / 2022 getestet.

## Installation
Unter den Releases befindet sich die dacpac-Datei, mit der eine leere Instanz auf dem SQL-Server erzeugt werden kann. Diese dacpac-Datei kann entweder über das Microsoft SQL Server Management Studio (SSMS) oder über das Microsoft Tool SqlPackage installiert werden.

Mit der Installation der dacpac-Datei wird ein Login mit dem Namen **WebControl** erstellt, mit dem eine Verbindung zur Datenbank hergestellt werden kann. Standardmäßig lautet das Passwort: *WebControl1234*. Es wird dringend empfohlen dieses Passwort nach der Installation zu ändern.