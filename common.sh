#!/bin/bash

build_indigosky () {
	rm -rf ${work_dir}.zip ${work_dir} *lite-${arch}.zip
	curl -o ${work_dir}.zip -L ${src_repo}
	unzip ${work_dir}.zip
	cp -Rf config indigosky stage2 ${work_dir}
	docker rm -v pigen_work
	cd ${work_dir}
	./build-docker.sh
	cd ..
	src_file=$(ls ${work_dir}/deploy/*.zip)
	buf=$(basename "${src_file}" .zip)
	tgt_file="${buf#image_}"-${arch}.zip

	echo "Moving ${src_file} -> ${tgt_file}"
	mv ${src_file} ${tgt_file}
}

