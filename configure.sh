#!/bin/bash

OVERRIDE_DIR="/etc/systemd/system/systemd-networkd-wait-online.service.d"
OVERRIDE_FILE="$OVERRIDE_DIR/override.conf"
COMMAND_FILE="/usr/local/bin/configure-122b"

# Update the package list
sudo apt-get update
sudo apt-get full-upgrade -y
sudo apt-get upgrade -y

echo "Packages updated successfully"

# Install the required packages
sudo apt-get install minicom yersinia -y

echo "Packages installed successfully"

# Networkd Service Timout Fix


sudo mkdir -p "$OVERRIDE_DIR"

sudo tee "$OVERRIDE_FILE" > /dev/null <<EOL
[Service]
ExecStart=
ExecStart=/usr/lib/systemd/system-networkd-wait-online
TimeoutSec=10
EOL

echo "Override configuration applied to systemd-networkd-wait-online.service"

# install command for easier use

sudo tee "$COMMAND_FILE" > /dev/null <<EOL
bash -c "\$(curl -fsSL https://raw.githubusercontent.com/fmac380/cba122-configure-ubuntu/master/configure.sh)"
EOL


sudo chmod +x $COMMAND_FILE

echo "Command installed successfully. Next time run 'sudo configure-122b' to configure the system"
