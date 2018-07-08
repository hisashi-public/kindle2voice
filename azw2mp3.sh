#!/usr/bin/env bash

script_name=${0}
RED="\033[31m"
RST="\033[0m"
function fatal_error() {
    echo -e "${RED}fatal error in ${script_name} ${1}${RST}"
    exit -1
}

AZW_FILE="${1}"
MP3_FILE="${2}"

rm -rf tmp || fatal_error ${LINENO}
mkdir -p tmp || fatal_error ${LINENO}

ebook-meta \
    --to-opf=tmp/metadata.opf \
    --get-cover=tmp/cover.jpg \
    "${AZW_FILE}" || fatal_error ${LINENO}

ebook-convert \
    "${AZW_FILE}" \
    tmp/tmp.txt || fatal_error ${LINENO} 

./txt2mp3.sh tmp "${MP3_FILE}" || fatal_error ${LINENO}

exit 0

