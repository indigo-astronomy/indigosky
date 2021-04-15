#!/bin/bash

build_indigosky () {
	# start clean
	rm -rf ${work_dir}.zip ${work_dir} *-${arch}.zip

	# get the code and build the image
	curl -o ${work_dir}.zip -L ${src_repo}
	unzip ${work_dir}.zip
	cp -Rf config indigosky stage2 ${work_dir}
	docker rm -v pigen_work
	cd ${work_dir}
	./build-docker.sh
	cd deploy

	# unip the result and remove the zip
	zip_file=$(ls *-lite.zip)
	unzip "${zip_file}"
	rm "${zip_file}"

	# rename the image
	src_file=$(ls *.img)
	buf=$(basename "${src_file}" -lite.img)
	tgt_file="${buf}"-${arch}.img
	echo "Renaming: ${src_file} -> ${tgt_file}"
	mv "${src_file}" "${tgt_file}"

	# create the final zip for distribution
	final_zip=$(basename "${tgt_file}" .img).zip
	echo "Creating archive: ${final_zip}"
	zip ${final_zip} ${tgt_file}
	rm ${tgt_file}
	cd ../..
	mv ${work_dir}/deploy/${final_zip} .
}

