rm -rf pi-gen-master.zip pi-gen-master
curl -o pi-gen-master.zip -L https://github.com/RPi-Distro/pi-gen/archive/master.zip
unzip pi-gen-master.zip
cp -Rf config indigosky stage2 pi-gen-master
docker rm -v pigen_work
cd pi-gen-master;./build-docker.sh