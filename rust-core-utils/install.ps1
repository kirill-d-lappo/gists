
##Requires -Version 7.0

[CmdletBinding()]
param (
  # Target path where binaries and bat files will be installed to.
  # The path must be a part of your PATH vairable.
  [Parameter()]
  [Alias("t")]
  [Alias("target")]
  [string]
  $TargetFolderPath = "$env:USERPROFILE\.local\bin",

  # Local path to Rust Core Utils source code.
  # GitHub: https://github.com/uutils/coreutils
  [Parameter()]
  [Alias("s")]
  [Alias("source")]
  [string]
  $CargoUtilsSourcePath = "C:\Users\klappo\workspace\remote\coreutils",

  # Skip build step
  [Parameter()]
  [Alias("no-build")]
  [switch]
  $NoBuild = $False,

  # Do not generate powershel completion file
  [Parameter()]
  [Alias("no-completion")]
  [switch]
  $NoAutocompletionRegen = $False,

  # Do not generate bat files
  [Parameter()]
  [Alias("no-bat")]
  [switch]
  $NoBatRegen = $False,

  # Do not wait, start immediatly
  [Parameter()]
  [Alias("no-wait")]
  [switch]
  $NoWait = $False
)

#region 3d party scripts

#https://www.powershellgallery.com/packages/start-countdowntimer/1.0.1
# -----------------------  - by stib from powershellgallery.com ------------------------------
# ----------------------------------countdown timer-------------------------------------------
function Start-CountdownTimer {
  <#

  .SYNOPSIS
  Displays a text-based countdown timer in the console.

  .DESCRIPTION
  Displays a timer counting down the seconds until the script terminates.
  Parameters control the length that it runs for.
  Only works in the console, because of some console tricks used to display the output.

  .EXAMPLE
  ./Start-CountdownTimer -Hours 1 -Minutes 2 -Seconds 3

  .PARAMETER Days
  Optional. The number of Days to wait before finishing

  .PARAMETER Hours
  Optional. The number of hours to wait before finishing

  .PARAMETER Minutes
  Optional. The number of Minutes to wait before finishing

  .PARAMETER Seconds
  Optional. The number of Seconds to wait before finishing

  .PARAMETER TickLength
  Optional. How long to wait before refreshing

  .LINK
  http://blob.pureandapplied.com.au/?p=875

  #>
  param (
    [string]$Text,
    [int]$Days = 0,
    [int]$Hours = 0,
    [int]$Minutes = 0,
    [int]$Seconds = 0,
    [int]$TickLength = 50
  )

  function Format-Time {
    param (
      [timespan]$Time
    )

    "$($Time.ToString("ss")) seconds"
  }

  $waitTime = New-TimeSpan -Days $Days -Hours $Hours -Minutes $Minutes -Seconds $Seconds
  # $spinner = @( '⠁', '⠂', '⠄', '⡀', '⢀', '⠠', '⠐', '⠈' )
  # $spinner = @( '⣷', '⣯', '⣟', '⡿', '⢿', '⣻', '⣽', '⣾' )
  # $spinner = @( '⠉', '⠈', '⠘' , '⠐', '⠰', '⠠' , '⠤', '⠄', '⠆', '⠂', '⠃', '⠁')
  $spinner = @( '⠉', '⠙', '⠘' , '⠸', '⠰', '⠴' , '⠤', '⠦', '⠆', '⠇', '⠃', '⠋')
  $completedChar = "✓";

  $spinnerPos = 0
  $spinnerLen = $spinner.Length

  $targetTime = (get-date) + $waitTime
  $remain = ($targetTime - (get-date))
  if ($Text) {
    $formattedText = "$Text in "
  }

  $origpos = $host.UI.RawUI.CursorPosition

  try {
    while ($remain.TotalSeconds -gt 0) {
      $formattedRemain = Format-Time $remain

      Write-Host (" {0} " -f $spinner[$spinnerPos % $spinnerLen]) -NoNewline
      write-host (" {0}{1}" -f $formattedText, $formattedRemain) -NoNewline
      Write-Host "`r" -NoNewline

      $spinnerPos += 1
      Start-Sleep -Milliseconds $TickLength
      $remain = ($targetTime - (get-date))
    }
  }
  finally {
    $host.UI.RawUI.CursorPosition = $origpos
  }

  $terminalWidth = $Host.UI.RawUI.WindowSize.Width
  Write-Host "$(' ' * $terminalWidth)`r" -NoNewline

  Write-Host " $completedChar " -NoNewline
  Write-Host " $Text now!"
}

#endregion 3d part scripts


# Powershell Hall of Shame
$InformationPreference = "Continue"

if (-Not (Test-Path $TargetFolderPath)) {
  Write-Information "Missing folder, it will be created: '$TargetFolderPath'"
  New-Item $TargetFolderPath -ItemType Directory
}

$profileRoot = Split-Path "$PROFILE" -Parent
$AutocompletionCoreUtilsFilePath = "$profileRoot\PowerShell.CoreUtils.AutoCompletion.ps1"
$AliasRemovalFilePath = "$profileRoot\PowerShell.CoreUtils.AliasRemoval.ps1"

$EntryPointFileName = "PowerShell.CoreUtils.EntryPoint.ps1"
$EntryPointFilePath = "$profileRoot\$EntryPointFileName"

$ManifestPath = "$CargoUtilsSourcePath\Cargo.toml"

$coreutils = @(
  "["
  "b2sum"
  "b3sum"
  "base32"
  "base64"
  "basename"
  "basenc"
  "cat"
  "cksum"
  "comm"
  "cp"
  "csplit"
  "cut"
  "date"
  "dd"
  "df"
  "dir"
  "dircolors"
  "dirname"
  "du"
  "echo"
  "env"
  "expand"
  "expr"
  "factor"
  "false"
  "fmt"
  "fold"
  "hashsum"
  "head"
  "join"
  "link"
  "ln"
  "ls"
  "md5sum"
  "mkdir"
  "mktemp"
  "more"
  "mv"
  "nl"
  "numfmt"
  "od"
  "paste"
  "pr"
  "printenv"
  "printf"
  "ptx"
  "pwd"
  "readlink"
  "realpath"
  "rm"
  "rmdir"
  "seq"
  "sha1sum"
  "sha224sum"
  "sha256sum"
  "sha3-224sum"
  "sha3-256sum"
  "sha3-384sum"
  "sha3-512sum"
  "sha384sum"
  "sha3sum"
  "sha512sum"
  "shake128sum"
  "shake256sum"
  "shred"
  "shuf"
  "sleep"
  "sort"
  "split"
  "sum"
  "tac"
  "tail"
  "tee"
  "test"
  "touch"
  "tr"
  "true"
  "truncate"
  "tsort"
  "unexpand"
  "uniq"
  "unlink"
  "vdir"
  "wc"
  "yes"
)

# when you want to override some default utils with alternatives or specify default arguments
$utilOverrides = @{
  "ls"  = @{
    "command" = "eza"
    "args"    = "--color=auto --icons=auto"
  }
  "cat" = @{
    "command" = "bat"
  }
};

function Set-EscapeCharacters {
  Param(
    [parameter(Mandatory = $true, Position = 0)]
    [String]
    $string
  )
  $string = $string -replace '\*', '`*'
  $string = $string -replace '\\', '`\'
  $string = $string -replace '\~', '`~'
  $string = $string -replace '\;', '`;'
  $string = $string -replace '\(', '`('
  $string = $string -replace '\%', '`%'
  $string = $string -replace '\?', '`?'
  $string = $string -replace '\.', '`.'
  $string = $string -replace '\:', '`:'
  $string = $string -replace '\@', '`@'
  $string = $string -replace '\/', '`/'
  $string = $string -replace '\[', '`['
  $string = $string -replace '\]', '`]'
  $string
}

function Generate-RustCoreUtilsBats() {

  $coreutils | ForEach-Object {
    $utilName = $_

    $utilOverride = $utilOverrides[$_]

    $utilCommand = ""
    $utilArgs = ""

    if ($utilOverride) {
      $utilCommand = $utilOverride.command
      $utilArgs = $utilOverride.args
    }

    if (-Not($utilCommand)) {
      $utilCommand = "`"coreutils.exe`" $utilName"
    }

    $script = @"
@echo off
$utilCommand $utilArgs %*
"@


    $scriptName = Set-EscapeCharacters $utilName
    $scriptPath = "$TargetFolderPath/$scriptName.bat"
    $script > "$scriptPath"
  }
}

function Generate-RustCoreUtilsAutocompletion() {
  $imports = @"
# Generated at: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

"@

  $imports > $AutocompletionCoreUtilsFilePath

  $autocompletions = @();
  $coreutils | ForEach-Object {
    $tool = $_
    $script = $(cargo run --release --manifest-path "$ManifestPath" completion $tool powershell)
    $script = $script -replace "^using namespace.*$", ""

    $autocompletions += $script

  }

  $autocompletions >> $AutocompletionCoreUtilsFilePath
}

function Generate-AliasRemovalScript {
  $scriptText = ""

  $scriptText > $AliasRemovalFilePath

  $coreutils | ForEach-Object {
    $scriptText += "Remove-Alias `"$($_)`" -Force -ErrorAction SilentlyContinue -Scope Global `n"
  }

  $scriptText >> $AliasRemovalFilePath
}

function Build-InstallRustUtils {
  cargo build --release --manifest-path "$ManifestPath" --locked

  Copy-Item -Path "$CargoUtilsSourcePath\target\release\coreutils.exe" -Destination "$TargetFolderPath\coreutils.exe"
}

function Update-CoreUtilsEntrypoint {
  if (-Not (Test-Path "$EntryPointFilePath")) {
    New-Item "$EntryPointFilePath" -ItemType File -Force
  }

  $entryPointLines = @"
#region RustCoreUtils
# Generated at: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

# Rust Core Utils init scripts:
# * removing default aliases from Powershell like ls, rm, etc.
# * adding autocompletions

`$profileRoot = "`$PSScriptRoot"
$(if (Test-Path "$profileRoot\PowerShell.CoreUtils.AliasRemoval.ps1") { '. "$profileRoot\PowerShell.CoreUtils.AliasRemoval.ps1"'})
$(if (Test-Path "$profileRoot\PowerShell.AutoCompletion.CoreUtils.ps1") { '. "$profileRoot\PowerShell.AutoCompletion.CoreUtils.ps1"'})

#endregion RustCoreUtils
"@

  $entryPointLines > $EntryPointFilePath
}

function Test-PathVariable {
  $pathValue = $env:Path

  if (-Not($pathValue -like "*$TargetFolderPath*")) {
    Write-Warning "Can't find '$TargetFolderPath' in PATH variable. Make sure it is added to PATH."
  }
}

function Generate-RustCoreUtils() {

  Write-Information "Building and installing Rust Core Utils by uutils teams"
  Write-Information "Project: https://github.com/uutils/coreutils"

  if (! $NoWait) {
    Start-CountdownTimer -Text "Installing" -Seconds 5
  }

  if (! $NoBuild) {
    Write-Information "Building and installing Rust Core Utils..."
    Build-InstallRustUtils
  }

  if (! $NoBatRegen) {
    Write-Information "Generating bat files per each command..."
    Generate-RustCoreUtilsBats
  }

  if (! $NoAutocompletionRegen) {
    Write-Information "Generating powershell autocompletion file for each command..."
    Generate-RustCoreUtilsAutocompletion
  }

  Write-Information "Generating Alias removal script..."
  Generate-AliasRemovalScript

  Update-CoreUtilsEntrypoint

  Test-PathVariable

  Write-Information "Done."

  Write-Information "Please, add the next line to your `$PROFILE: '$PROFILE'"
  Write-Information ""
  Write-Information ". `$PSScriptRoot\$EntryPointFileName"
  Write-Information ""
}

Generate-RustCoreUtils

