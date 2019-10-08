# Argos-USBGuard

This [Argos](https://github.com/p-e-w/argos) script shows by [USBGuard](https://usbguard.github.io/) blocked devices and allows the easy acceptance of them.

![Screenshot](https://raw.githubusercontent.com/bertschneider/argos-usbguard/master/screenshot.png)

## Features

- Easy acceptance of blocked USB devices
- Only show a tray icon if blocked USB devices are present

## Usage

1. Clone the repository

        > git clone git@github.com:bertschneider/argos-usbguard.git

2. Link the script to your Argos script directory

        argos-usbguard> ln ./usbguard.10s.sh ~/.config/argos

3. *USBGuard needs root access* and to elevate the current user rights `sudo` is
   used. The password will be read from the system key store using
   `secret-tools`. So you have to access your password to the key store with the
   following command:

        > secret-tool store --label='Password for Argos-USBGuard Script' argos-usbguard password
