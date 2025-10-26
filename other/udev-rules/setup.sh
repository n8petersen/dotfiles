#!/bin/bash

if (( $EUID != 0 )); then
    echo "This script must be run as root."
    exit 1
fi

echo "Creating '/dev/udev/rules.d' directory"
sudo mkdir -p /etc/udev/rules.d

echo "Copying touchscreen rules file to directory"
sudo cp 80-touchscreen.rules /etc/udev/rules.d

echo "Reloading rules"
sudo udevadm control --reload-rules && sudo udevadm trigger

echo "Reboot PC to ensure apply!"
