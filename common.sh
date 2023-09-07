#!/bin/bash

build_indigosky () {
	# start clean
	rm -rf ${work_dir} *-indigosky-${arch}.zip

	# get the code and build the image
	git clone ${src_repo} ${work_dir}
	cd ${work_dir}
	git checkout ${used_commit}
	rm -rf export-image/01-user-rename
	sed -i 's@exit 1@mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc@g' scripts/dependencies_check
	cd ..
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
