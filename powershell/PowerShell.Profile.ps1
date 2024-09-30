# Todo [2024-09-30 klappo] needs to be tested and corrected

#region Function Definitions

function source(
    [string]
    $Path,
    [Alias("verify")]
    [switch]
    $ShouldVerifyPath = $false
) {
    if (-Not($ShouldVerifyPath) -or (Test-Path $Path)) {
        . $Path
    }
}

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

function Show-Jwt($jwt) {
    $jwt | jq -R 'split(".") | .[0],.[1] | @base64d | fromjson'
}

#endregion Function Definitions

#Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine

    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
}

source --verify "$PSScriptRoot\PowerShell.AutoCompletion.ps1"

source --verify "$PSScriptRoot\PowerShell.CoreUtils.EntryPoint.ps1"

Invoke-Expression (&starship init powershell)