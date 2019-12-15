Generate INDIGO Raspberry PI Image
==============

Make sure you have installed required packages and docker as described in
[pi-gen README.md](https://github.com/RPi-Distro/pi-gen/blob/master/README.md).
```
./build.sh
```
The created image is named _*-indigo-lite.zip_ in directory _pi-gen-master/deploy_ and contains the following customization:

0. Filesystem is expanded.
1. User 'indigo' with password 'indigo' is created.
2. APT source list of INDIGO is added and latest INDIGO package is installed.
3. INDIGO process started via systemd as user indigo.
4. WiFi access point with SSID 'indigosky' and password 'indigosky' is created.
5. SSH daemon is started.
6. Sudo commands as user 'indigo' without password.
