Generate INDIGO Sky Raspberry PI Image
==============

Make sure you have installed required packages and docker as described in
[pi-gen README.md](https://github.com/RPi-Distro/pi-gen/blob/master/README.md).
```
./build_arm64.sh
```
The created image is named <DATE>-indigosky-arm64.zip

```
./build_armhf.sh
```
The created image is named <DATE>-indigosky-armhf.zip

Images contain several customizations:
0. Filesystem is expanded.
1. User 'indigo' with password 'indigo' is created.
2. APT source list of INDIGO is added and latest INDIGO package is installed.
3. INDIGO process started via systemd as user indigo.
4. WiFi access point with SSID 'indigosky' and password 'indigosky' is created.
5. SSH daemon is started.
6. Sudo commands as user 'indigo' without password.
