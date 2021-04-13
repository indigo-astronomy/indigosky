rm -rf pi-gen-arm64.zip pi-gen-arm64
curl -o pi-gen-arm64.zip -L https://github.com/RPi-Distro/pi-gen/archive/refs/heads/arm64.zip
unzip pi-gen-arm64.zip
cp -Rf config indigosky stage2 pi-gen-arm64
docker rm -v pigen_work
cd pi-gen-arm64;./build-docker.sh
