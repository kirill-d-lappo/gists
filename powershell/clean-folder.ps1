#!/usr/bin/env pwsh
<#
.SYNOPSIS
  Cleans up files in folder
.DESCRIPTION
  Cleans up files in folder, created any days ago.
  No file size check support. It can search recursively in sub-directories.
  Use it everywhere you want, it's not a rocket science.
  Inspired by Thomas Maurer: https://www.thomasmaurer.ch/2010/12/powershell-delete-files-older-than/
.PARAMETER <Parameter_Name>
    // Todo =) Parameters are self-explained
.INPUTS
  <Inputs if any, otherwise state None>
  // Todo
.OUTPUTS
  <Outputs if any, otherwise state None - example: Log file stored in C:\Windows\Temp\<name>.log>
  // Todo
.NOTES
  Version:        1.0
  Author:         Kirill Lappo<kirill-lappo@outlook.com>
  Creation Date:  <Date>
  Purpose/Change: Initial script development

.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>

param (
  [Parameter(Mandatory = $true)]
  [string]
  $Path = "C:\Temp",

  [Parameter(Mandatory = $true)]
  [int]
  $OlderThanDays = 7,

  [Switch]
  $Recurse = $false,

  [Switch]
  $DoDelete = $false
)

function Remove-OldFiles {
  param (
    [Parameter(Mandatory = $true)]
    [String]
    $Path,

    [Parameter(Mandatory = $true)]
    [int]
    $OlderThanDays,

    [Switch]
    $Recurse,

    [Switch]
    $DryRun
  )

  if ($DryRun) {
    Write-Warning "Dry run mode, no files will be deleted"
  }

  $OlderThanDate = $(Get-Date).AddDays(-$OlderThanDays)

  Write-Host "Removing files older than $OlderThanDate ($OlderThanDays+ days ago)"

  $itemsToDelete = Get-ChildItem $Path -Attributes !Directory+!System -Recurse:$Recurse  `
  | Where-Object { $_.LastWriteTime -lt $OlderThanDate }

  if ($itemsToDelete.Count -le 0) {
    Write-Host "No files were found."
    return
  }

  $itemsToDelete | ForEach-Object {
    Write-Host "Remove: $($_.Name)"
    if (-Not $DoDelete) {
      return
    }

    Remove-Item $_.FullName
  }
}

Remove-OldFiles -Path $Path -OlderThanDays $OlderThanDays -Recurse:$Recurse -DryRun:$DryRun