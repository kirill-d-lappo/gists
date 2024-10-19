
#region Function Definitions

function dev() {
  Set-Location "D:\workspace\vopty\src"
}

function clb() {
  git branch --merged | where-object { !($_ -match "(^\*|main|dev|release.*)") } | foreach-object { & git branch -d $_.Trim() }
}

function Regen-PSAssemblies() {
  $ngen = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ngen.exe"
  $originalPath = $env:PATH
  $env:PATH = [Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()
  try {
    [AppDomain]::CurrentDomain.GetAssemblies() | ForEach-Object {
      $path = $_.Location
      if ($path) {
        $name = Split-Path $path -Leaf
        Write-Host -ForegroundColor Yellow "`r`nRunning ngen.exe on '$name'"
        & "$ngen" install $path /nologo
      }
    }
  }
  finally {
    $env:PATH = $originalPath
  }
}

#endregion Function Definitions

Set-PSReadlineKeyHandler -Key Tab -Function Complete

. "$PSScriptRoot\PowerShell.AutoCompletion.ps1"

. "$PSScriptRoot\PowerShell.CoreUtils.EntryPoint.ps1"

Invoke-Expression (&starship init powershell)
