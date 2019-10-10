#!/bin/bash

# Before run add "argos-usbguard" to the system key-chain using:
# > secret-tool store --label='Password for Argos-USBGuard Script' argos-usbguard password

# Use a " " before sudo commands to prevent adding the password to the history

REGEX='(.*): (allow)?(block)? id (.*) serial "(.*)" name "(.*)" hash "(.*)" parent-hash "(.*)" with-interface (.*)'
PASSWORD=$(secret-tool lookup argos-usbguard password)
BLOCK_COUNT=$( sudo -Sk -p '' <<< $PASSWORD usbguard list-devices -b | wc -l)

if [ $BLOCK_COUNT != '0' ]; then
    echo "${BLOCK_COUNT} | iconName='usb' | color='red'"
    echo "---"
    BLOCKED=$( sudo -Sk -p '' <<< $PASSWORD usbguard list-devices -b)
    while read -r DEVICE; do
        if [[ $DEVICE =~ $REGEX ]]; then
            echo "\033[31;1;1m :no_entry: \033[0m ${BASH_REMATCH[6]}"
            echo "--ID: ${BASH_REMATCH[4]}"
            echo "--Serial: ${BASH_REMATCH[5]}"
            echo "--Name: ${BASH_REMATCH[6]}"
            echo "--Hash: ${BASH_REMATCH[7]}"

            ALLOW_COMMAND=" sudo -Sk -p '' <<< ${PASSWORD} usbguard allow-device -p ${BASH_REMATCH[1]}"
            echo "--:+1: ALLOW :+1:| emojize=true color='green' refresh=true terminal=false bash=\"${ALLOW_COMMAND}\""
        fi
    done <<< $BLOCKED
else
    echo "--"
fi;
