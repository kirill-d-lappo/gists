#requires -version 7

# Requires pwsh 7 or higher
# Add functions to your $PROFILE so they are always accessible

function Restart-ServiceParallel{
  [CmdletBinding()]
  param (
      [Parameter()]
      [string]
      $Name
  )

  Get-Service $Name | ForEach-Object -Parallel { Restart-Service $_ }
}

function Start-ServiceParallel{
  [CmdletBinding()]
  param (
      [Parameter()]
      [string]
      $Name
  )

  Get-Service $Name | ForEach-Object -Parallel { Start-Service $_ }
}

function Stop-ServiceParallel{
  [CmdletBinding()]
  param (
      [Parameter()]
      [string]
      $Name
  )

  Get-Service $Name | ForEach-Object -Parallel { Stop-Service $_ }
}

function Remove-ServiceParallel{
  [CmdletBinding()]
  param (
      [Parameter()]
      [string]
      $Name,

      [Parameter()]
      [switch]
      $Force
  )

  if (!$Force){
      $response = Read-Host -Prompt "Removed services can't be restored! Are you sure? (yes/no)"
      if ($response -eq 'y'){
          $response = Read-Host -Prompt "Type 'yes'"
      }

      if ($response -ne 'yes'){
          Write-Host "Aborted service removal."
          return
      }
  }

  Get-Service $Name | ForEach-Object -Parallel { Remove-Service $_ }
}