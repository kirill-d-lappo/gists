$var = 1;
#region RustCoreUtils

# Rust Core Utils init scripts:
# * removing default aliases from Powershell like ls, rm, etc.
#region RustCoreUtils

# Rust Core Utils init scripts:
# * removing default aliases from Powershell like ls, rm, etc.
# * adding autocompletions

$profileRoot = "$PSScriptRoot"
. "$profileRoot\PowerShell.CoreUtils.AliasRemoval.ps1"
. "$profileRoot\PowerShell.AutoCompletion.CoreUtils.ps1"

#endregion RustCoreUtils
