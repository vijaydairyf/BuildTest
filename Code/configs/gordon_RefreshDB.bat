REM THIS FILE SHOULD BE RUN IN ADMIN MODE AND POWERSHELL SHOULD BE INSTALLED
d:
cd\Work-stuff\distributr\configs
REM
REM UPDATE CONFIG FILES 
CALL gordon_setup.bat
cd..
cd rebuilddb
C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild /verbosity:m rebuilddb.csproj
cd..
cd configs
@powershell -file "jgitauRestartSQL.ps1"
@powershell -file "jgitauRestartSQL.ps1"
C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild setup/setup.xml /t:RefreshDatabases /p:Environment=gordon
cd..
cd RebuildDB\bin\Debug
rebuilddb.exe 
cd ..\..\..\configs
PAUSE