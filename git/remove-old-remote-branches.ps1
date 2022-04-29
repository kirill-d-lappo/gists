#!/usr/bin/env pwsh
#requires -version 5
<#
.SYNOPSIS
  Remove old branches on remote Git server

.DESCRIPTION
  The script is created for manual run only.
  The script will ask you if you REALLY want to proceed.
  The script removes old merged remote branches.
  It ignores popular important branches (main, dev, trunk, release, HEAD, etc.).
  It has DryRun mode.
  Negative points: it does a lot of requests to remote server on each branch, it slows down script execution
  and sends big amount of git requests to git server (by amount of found branches)
  NO WARANTY, YOU ARE ON YOUR OWN WITH THIS SCRIPT

.NOTES
  Version:        1.0
  Author:         <kirill-lappo@outlook.com>
  Creation Date:  2020/10/01
  Purpose/Change: Initial script development

.EXAMPLE
  Run with default configuration in current git repo:
  ./Remove-OldRemoteBranches.ps1

  Run for particular repo :
  ./Remove-OldRemoteBranches.ps1 -GitRoot "D:\repos\repo"

  DryRun mode. Script doesn't modify any branch:
  ./Remove-OldRemoteBranches.ps1 -DryRun

  Remove branches older than 2 years (730 days):
  ./Remove-OldRemoteBranches.ps1 -OlderThanDaysAgo 730

  Remove branches, but keep some branches including default ones:
  ./Remove-OldRemoteBranches.ps1 -IgnoreBranchNames "feature/special-feature","fix/do-not-delete-me"
#>

param(
    [string]
    $GitRoot,

    [int]
    [ValidateRange("Positive")]
    $OlderThanDaysAgo = 360,

    [string[]]
    $IgnoreBranchNames = @(),

    [switch]
    $DoDelete
)

#Set Error Action to Stop At First Error
$ErrorActionPreference = "Stop"

if ($OlderThanDaysAgo -le 0) {
    throw "OlderThanDaysAgo can't be 0 or lesser than 0"
}

if ($GitRoot -eq $NULL -or $GitRoot -eq "") {
    $GitRoot = Get-Location
}

$GitSysDir = "$GitRoot/.git"

$DryRun = !$DoDelete
if ($DryRun) {
    Write-Host "DryRun: no data will be modified" -ForegroundColor yellow
}

$defaultIgnoreBranches = @("master", "main", "dev", "release", "trunk", "main", "HEAD")

function Get-IgnoreBranchRegex {
    $branchNames = $IgnoreBranchNames + $defaultIgnoreBranches
    $ignoreBranchRegex = ".*(\*|$($branchNames -join "|")).*"
    return $ignoreBranchRegex
}

function Get-OlderThanDate {
    return  $(Get-Date).AddDays(-$OlderThanDaysAgo)
}

function Get-RemoteBranches {
    $(& git --git-dir "$GitSysDir" branch -r --merged) | ForEach-Object { $_.Trim() }
}

function Get-BrnachLatestCommitDate {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $BranchName
    )

    $(git --git-dir "$GitSysDir" show --format="%ci" "$BranchName") | Select-Object -First 1
}

function Select-BranchesToDelete {
    param (
        [string[]]
        $BranchNames,

        [datetime]
        $OlderThanDate
    )

    $ignoreBranchRegex = Get-IgnoreBranchRegex

    $BranchNames `
    | Where-Object { -not ($_ -match $ignoreBranchRegex) }  `
    | Where-Object {
        $branchName = $_
        $dateValue = Get-BrnachLatestCommitDate -BranchName $branchName
        $latestCommitDate = [DateTime]::Parse($dateValue)

        return $latestCommitDate -lt $OlderThanDate
    }
}

function Read-UserWantsContinue {
    if ($DryRun) {
        return $True
    }

    $answer = Read-Host -Prompt "ARE YOU SURE? THIS OPERATION CAN'T BE UNDONE! ('yes' to confirm, 'no' to stop)"

    if ($answer -eq "y") {
        $answer = Read-Host -Prompt "Please, type 'yes'"
    }

    return $answer -eq "yes"
}

function Remove-OldBranches {
    $olderThanDate = Get-OlderThanDate
    Write-Host "Removing branches older than $olderThanDate" -ForegroundColor yellow

    $branches = Get-RemoteBranches

    $branches = Select-BranchesToDelete  `
        -BranchNames $branches  `
        -OlderThanDate $olderThanDate

    if ($branches.Length -le 0) {
        Write-Host "There are no branches to delete by specified criterias, no branch will be deleted." -ForegroundColor yellow
        return
    }
    else {
        Write-Host "Branches to delete: $($branches.Length)" -ForegroundColor yellow
    }

    if (-Not $(Read-UserWantsContinue)) {
        return
    }

    $branches | ForEach-Object {
        $fullBranchName = $_.Trim();

        $remote, $branchName = $fullBranchName -split '/', 2
        Write-Host "Deleting on $($remote): $branchName" -ForegroundColor Red

        if ($DryRun) {
            return
        }

        git  --git-dir "$GitSysDir" push -d $remote $branchName
    }
}

Remove-OldBranches