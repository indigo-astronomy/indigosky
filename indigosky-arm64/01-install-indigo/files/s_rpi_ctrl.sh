#!/bin/bash

LSB_RELEASE_EXE=$(which lsb_release)

__get_release() {
    local key='Release'
    echo $(${LSB_RELEASE_EXE} -r 2>/dev/null | grep -oPm1 "(?<=${key}:).*")
}

RELEASE=$(__get_release)

if [ "${RELEASE}" -lt "12" ]; then
    sudo rpi_ctrl.sh "$@"
else
    sudo rpi_ctrl_v2.sh "$@"
fi
