#!/usr/bin/env pwsh

param(
  [string]
  $DatabaseName,

  [string]
  $FilePath
)

$ErrorActionPreference = 'Stop'
$InformationPreference = 'Continue'

if (-Not $FilePath) {
  $FilePath = "$DatabaseName.bacpac"
}

$server = "localhost"

$user = "sa"
$password = "SuperAdmin1!"

Write-Information "Exporting $DatabaseName to file $FilePath"

sqlpackage /a:Export /ssn:tcp:$server /sdn:"$DatabaseName" /su:$user /sp:$password /tf:"$FilePath"
