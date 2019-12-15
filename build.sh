rm -rf pi-gen-master.zip pi-gen-master
curl -o pi-gen-master.zip -L https://github.com/RPi-Distro/pi-gen/archive/master.zip
unzip pi-gen-master.zip
cp -R config stage0-indigo stage2-indigo pi-gen-master
docker rm -v pigen_work
cd pi-gen-master;./build-docker.sh