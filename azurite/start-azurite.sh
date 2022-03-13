echo "Set Azure Storage connection string to UseDevelopmentStorage=true" 
#azurite --silent --location /home/klappo/.azurite-data --debug /home/klappo/.azurite-data/debug.log --loose --skipApiVersionCheck
azurite --silent --location /home/klappo/.azurite-data --loose --skipApiVersionCheck
