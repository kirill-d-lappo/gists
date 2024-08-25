SQL DACPAC notes:

* use simple .net core project
* use special sdk: MSBuild.Sdk.SQLProj/1.15.0 or higher: [GitHub](https://github.com/rr-wfm/MSBuild.Sdk.SqlProj#msbuildsdksqlproj)
* all properties works for the projec, use CamelCase version of them (in most cases):
  [LINK](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sqlserver.dac.dacdeployoptions.dropobjectsnotinsource?view=sql-dacfx-150)
* DropObjectsNotInSource
* seems like publish profile can be used as well
* use `dotnet publish` to... publish
  ```bash
  > dotnet publish /p:TargetServerName="(localdb)\MSSQLLocalDB" /p:TargetDatabaseName=DatabaseNameHere
  ```


|Property                 |Default          |Description|
|-------------------------|-----------------|------------|
|TargetServerName	        |(local)	        |Controls the name of the server to which the project is published|
|TargetDatabaseName	      |Project name	    |Controls the name of the database published by dotnet publish|
|TargetPort		            |                 |Specifies an alternate port for connecting to the target server (only necessary if using a non-standard port|
|TargetUser		            |                 |Username used to connect to the server. If empty, Windows authentication is used|
|TargetPassword		        |                 |Password used to connect to the server. If empty, but TargetUser is set you will be prompted for the password|
|IncludeCompositeObjects	|True	            |Controls whether objects from referenced packages are deployed to the same database|
|TargetName	              |Project name	    |Controls the name of the .dacpac created by dotnet build. The default name for the .dacpac file is the name of the project file, e.g. MyProject.csproj produces MyProject.dacpac.|


Command Example:

```bash
sqlpackage.exe
  /Action:Publish
  /SourceFile:"C:\project\bin\debug\project.dacpac"
  /Profile:"C:\project\project.publish.xml"
  /TargetServerName:"(localdb)\MSSQLLocalDB"
  /TargetDatabaseName:ProjectDatabaseNameHere
```