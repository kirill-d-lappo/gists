getScriptDirectory() {
  scriptName=$0
  echo $(dirname "$(realpath ${scriptName})")
}

# add execute permission to all scripts in source folder
grantExectuionPermission() {
  sourcesDir=${1:-${pwd}}
  find $sourcesDir -type f -regex '.*\.\(py\|sh\|bash\|ps1\)$' -exec chmod +x {} +
}