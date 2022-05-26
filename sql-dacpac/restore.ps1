#!/usr/bin/env pwsh

param(
	[string]
	$FilePath,

	[string]
	$DatabaseName = $Null
)

$ErrorActionPreference = 'Stop'
$InformationPreference = 'Continue'

$FilePathName = [System.IO.Path]::GetFileNameWithoutExtension($FilePath)

# use filename as database name if it is not specified as a second parameter
if (-Not $DatabaseName) {
	$DatabaseName = $FilePathName
}

$server = "localhost"

$user = "sa"
$password = "SuperAdmin1!"

Write-Information "Dropping existing database $DatabaseName"

sqlcmd -S "$server" -d "master" -U "$user" -P "$password" -Q "DROP DATABASE IF EXISTS [$DatabaseName]; "

Write-Information "Importing $DatabaseName from file $FilePath"

sqlpackage /a:Import /tsn:tcp:$server /tdn:"$DatabaseName" /tu:$user /tp:$password /sf:"$FilePath"
