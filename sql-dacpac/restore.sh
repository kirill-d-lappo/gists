
filePath=$1
filePathName=$(basename ${filePath%.*})

databaseName=${2:-$filePathName}

server="localhost"

user="sa"
password="SuperAdmin1!"

echo "Dropping existing database $databaseName"
# drop existing db
sqlcmd -S "$server" -d "master" -U "$user" -P "$password" -Q "DROP DATABASE IF EXISTS [$databaseName]; "

echo "Importing $databaseName from file $filePath"
# import
sqlpackage /a:Import /tsn:tcp:$server /tdn:"$databaseName" /tu:$user /tp:$password /sf:"$filePath"
