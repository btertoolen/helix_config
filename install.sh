#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ -z "${HX_CONFIG_DIR}" ]]; then
    HX_CONFIG_DIR=~/.config/helix
fi
mkdir -p ${HX_CONFIG_DIR}
cp ${SCRIPT_DIR}/config.toml ${HX_CONFIG_DIR}/
cp ${SCRIPT_DIR}/languages.toml ${HX_CONFIG_DIR}/
