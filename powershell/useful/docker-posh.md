# Docker Powershell Autocompletion

## Installation

1. Set your exectuion policy to Unrestricted for Current User

```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
```

1. Install posh-docker module

```powershell
Install-Module posh-docker
```

1. Import this module

```
Import-Module posh-docker
```

1. Add import module action to your powershell profile

```powershell
# Need -NoNewLine parameters as Out-File puts some ^M symbol in the end of the text
# Utf8 (with BOM) is used when writing to the file
"`nImport-Module posh-docker`n" | Out-File -Encoding utf8 -Append -NoNewLine $PROFILE
```