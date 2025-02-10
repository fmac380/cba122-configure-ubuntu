#!/bin/bash

# Update the package list
sudo apt-get update
sudo apt-get full-upgrade -y
sudo apt-get upgrade -y

echo "Packages updated successfully"

# Install the required packages
sudo apt-get install minicom -y

echo "Packages installed successfully"

# Networkd Service Timout Fix
OVERRIDE_DIR="/etc/systemd/system/systemd-networkd-wait-online.service.d"
OVERRIDE_FILE="$OVERRIDE_DIR/override.conf"

sudo mkdir -p "$OVERRIDE_DIR"

sudo tee "$OVERRIDE_FILE" > /dev/null <<EOL
[Service]
ExecStart=
ExecStart=/usr/lib/systemd/system-networkd-wait-online
TimeoutSec=10
EOL

echo "Override configuration applied to systemd-networkd-wait-online.service"
