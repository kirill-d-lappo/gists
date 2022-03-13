ln -s "$(pwd)/azurite.service" "/etc/systemd/system/azurite.service"
systemctl start azurite.service