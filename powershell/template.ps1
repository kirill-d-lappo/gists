#!/usr/bin/env pwsh
<#
.SYNOPSIS
  Short description for your script.
.DESCRIPTION
  More descriptive notes about the script.
  May contain several lines for readability.
  Must not be an esse on "How I spent this summer"
.NOTES
  Version:        1.0
  Author:         Kirill Lappo<kirill-lappo@outlook.com>
  Creation Date:  $(Get-Date -f yyyy/MM/dd)
  Purpose/Change: Initial script development. Update in the next releases.

.EXAMPLE
  ./PowershellTemplate.ps1
  Run with default settings. Also you can type multiple lines.

.EXAMPLE
  ./PowershellTemplate.ps1 -Force
  Run without prompts. More examples for a god of exmaples.
#>

# Up to you
##Requires -RunAsAdministrator
##Requires -Version 7.0

param (
  # Super-duper descriptive notes about parameter. It is used in docs at Get-Help
  [Parameter()]
  [string]
  $SourceRoot = $PSScriptRoot,

  # No wait or press key prompts.
  [Parameter()]
  [Switch]
  $Force
)

# Up to you, I prefer to see all messages and break on first error message by default
$ErrorActionPreference = 'Stop'
$InformationPreference = 'Continue'

# Just in case, you may not use it
$PSScriptFileName = $MyInvocation.MyCommand.Name

function Main {

  # Main entrypoint
  # Create all sub-function beneath this method
  # The file should be ended with a single Main call

  Write-LogoBanner

  # Use here all script parameters as is, for ex:
  if ($Force) {
    # Do awesome things
    Write-Banner "Forced Event"
    Write-Warning "Forced event has been started"
    Write-Information "Forced event is completed"
  }

  Write-Banner "Typical Flow"
}

# Some kind of pretty header writing
# I guess it is overcomplicated but who cares
function Write-Banner {
  param (
    [string]
    $Content
  )

  $margin = "   "
  $separatorLength = 2 * $margin.Length  `
    + ($Content -split "`n" | Measure-Object -Property length -Maximum).Maximum

  $separator = "=" * $separatorLength
  $marginContent = $Content -split "`n" | Select-Object @{ Name = "Value"; Expression = { "$margin$($_)$margin" } }  `
  | Join-String -Property "Value" -Separator "`n"

  Write-Information $separator
  Write-Information $marginContent
  Write-Information $separator
}

# Google or install any text-to-ascii art generator and have fun
function Write-LogoBanner {
  $logo = @"
   ███████  ██████ ██████  ██ ██████  ████████     ██ ███████
   ██      ██      ██   ██ ██ ██   ██    ██        ██ ██
   ███████ ██      ██████  ██ ██████     ██        ██ ███████
        ██ ██      ██   ██ ██ ██         ██        ██      ██
   ███████  ██████ ██   ██ ██ ██         ██        ██ ███████


   █████  ██     ██ ███████ ███████  ██████  ███    ███ ███████
  ██   ██ ██     ██ ██      ██      ██    ██ ████  ████ ██
  ███████ ██  █  ██ █████   ███████ ██    ██ ██ ████ ██ █████
  ██   ██ ██ ███ ██ ██           ██ ██    ██ ██  ██  ██ ██
  ██   ██  ███ ███  ███████ ███████  ██████  ██      ██ ███████
"@

  Write-Banner $logo
}

Main

# Ideally you should use just a Main call,
# but you can write logs by default here as well
# Always use try-finally

# Start-Transcript -Path "$PSScriptRoot/$PSScriptName.log" -Append -IncludeInvocationHeader
# try {
#   Main
# }
# finally {
#   Stop-Transcript
# }