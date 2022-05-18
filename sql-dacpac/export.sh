
databaseName=$1
filePath=${2:-"$databaseName.bacpac"}

server="localhost"

user="sa"
password="SuperAdmin1!"


echo "Exporting $databaseName to file $filePath"

sqlpackage /a:Export /ssn:tcp:$server /sdn:"$databaseName" /su:$user /sp:$password /tf:"$filePath"
