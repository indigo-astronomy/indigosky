# Install INDIGO Sky on a Raspberry Pi

## Install INDIGO Sky on SD Card

NDIGO Sky is a free Raspbian based image customized for running INDIGO easily and seamlessly
on a Raspberry Pi.

We provide 32 and 64-bit OS images. The images work with Raspberry Pi generations:

* Raspberry Pi 2 Mod. B runs with 32-bit image only (requires an external WiFi USB dongle when operated in WiFi mode)
* Raspberry Pi 3 Mod. A+ runs with 32 and 64-bit images (32-bit image recommeded)
* Raspberry Pi 3 Mod. B runs with 32 and 64-bit images (32-bit image recommeded)
* Raspberry Pi 3 Mod. B+ runs with 32 and 64-bit images (32-bit image recommeded)
* Raspberry Pi 4 Mod. B runs with 32 and 64-bit images

Download the appropriate image:

* 2021-04-29-indigosky-armhf.zip - 32-bit Operating system for Raspberry Pi 2, 3 and 4
* 2021-04-29-indigosky-arm64.zip - 64-bit Operating system for Raspberry Pi 3 and 4

Unpack it, copy it to SD card following the instructions at Raspberry Pi [site](https://www.raspberrypi.org/documentation/installation/installing-images) and boot from it.
First boot will take longer (several minutes) as INDIGO Sky will automatically
expand the file system to the size of the SD card and after that it will start INDIGO and provide a WiFi access point.

INDIGO Sky WiFi access point has the following default credentials:
```
SSID: indigosky
password: indigosky
```

INDIGO Sky can be configured via the web GUI running at http://indigosky.local:7624.
However this URL may not work on Windows, in this case please use http://192.168.235.1:7624.
If the device is connected via Ethernet cable to your home network, you must use the IP address
assigned by your router and the same port as above to access the web GUI.

You can access the system console using SSH or just plug keyboard and screen with the credentials:
```
username: indigo
password: indigo
```

## Use INDIGO Sky on SD Card
No additional actions are needed. You are all set.

## Use INDIGO Sky on External USB Drive
There are 2 benefits using this approach, USB 3 connected SSD drives will
give you ~10x faster disk I/O, and it gives you more disk space.

The downsides are that is takes one USB port and it is bulkier.

To do so you need to configure your RPi device to boot from USB.

### Enabling Raspberry Pi to Boot from USB
Enabling Raspberry Pi to Boot from USB is one time procedure. Once completed it will be able to boot from any bootable USB device.

To complete it you need an SD card. It is needed only to reconfigure the RPi firmware:

1. Prepare a bootable SD card as explained above.

2. Boot from it and login to the system console.

3. Instruct the firmware to boot from USB and reboot:
```
$ echo program_usb_boot_mode=1 | sudo tee -a /boot/config.txt
$ sudo reboot
```

4. Once booted your RPi firmware should be reprogrammed, shutdown, unplug the power and remove the SD card.
Most likely the SD card is no longer needed - you may need it for some troubleshooting.

### Install INDIGO Sky on USB drive
Using the same instructions as for the SD card, you can prepare your USB drive. Then plug it in to the USB port (preferably USB 3) of the RPi and it should boot from the USB when powered up.

#### Troubleshootong

If the device refuses to boot from the SSD drive you many be running old RPi Firmware.
This is easy to fix:

1. Boot from the already prepared SD card and install possible updates and rpi-update tool:
```
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get install rpi-update
```

2. Then update the firmware using:
```
$ sudo BRANCH=next rpi-update
```
and answer the Y/N questions asked in the process.

3. When ready, reboot and wait for the device to boot. This will reprogram the RPi to boot from USB.

4. Now we are ready to boot from the SSD. Shutdown, unplug the power, remove the SD card, plug the SSD drive and power up. Now it should boot from the SSD.
