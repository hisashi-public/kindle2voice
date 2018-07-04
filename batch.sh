#!/usr/bin/env bash

test -d ${1} || exit -1;
txtfile="`ls ${1}/*.txt | sort`"

rm 00????.*
rm *.wav

NUM=1
currfile=`printf "%06d" ${NUM}`
test -f ${currfile}.txt && rm ${currfile}.txt
total=0
test -f list.txt && rm list.txt
cat "${txtfile}" | while read line; do
    echo "${line}" >> ${currfile}.txt
    nchars=`echo ${line} | wc -m`
    total=`echo "${total} + ${nchars}" | bc`

    if test ${total} -gt 3000; then
        ./gcp_tts.py ${currfile}.txt ${currfile}.mp3 j &
        echo ${currfile}.mp3 >> list.txt
        NUM=`echo "${NUM} + 1" | bc`
        currfile=`printf "%06d" ${NUM}`
        total=0
    fi
done
echo ${LINENO}

currfile=`ls 00????.txt | sort | tail -n 1`
currfile=`basename ${currfile} .txt`
added=`grep ${currfile}.mp3 list.txt`
if test -z "${added}" ; then
    ./gcp_tts.py ${currfile}.txt ${currfile}.mp3 j &
    echo ${currfile}.mp3 >> list.txt
fi

echo ${LINENO}
while true; do
    tts_complete="true"
    for f in $(cat list.txt); do
        if test ! -f ${f}; then
            tts_complete="false"
            break;
        fi
    done
    if test "${tts_complete}" = "true"; then
        break;
    fi
    sleep 0.5
done
sleep 5

#af="atempo=1.25, atempo=2" # speed x2.5
af="atempo=2" # speed x2

for f in $(cat list.txt); do
    bn=`basename ${f} .mp3`
    wavfile=${bn}.wav
    ffmpeg -i ${f} -af "${af}" ${wavfile} > /dev/null
done
sox `ls *.wav | sort` 000000.wav


METAFILE=${1}/metadata.opf
TITLE="`./parse_metadata.py ${METAFILE} t`"
ARTIST=`./parse_metadata.py ${METAFILE} c`
ALBUM="${TITLE}"
CART="${1}/cover.jpg"

#sox 000000.wav -r 44100 -c 1 "${TITLE}.wav" echo  1.0 0.75 100 0.3 reverb
sox -v 3 000000.wav -r 44100 -c 1 "${TITLE}.wav" echo  1.0 0.3 100 0.05
lame --tt "${TITLE}" --tl "${ALBUM}" --ta "${ARTIST}" --ti "${CART}" "${TITLE}.wav" "${TITLE}.mp3"

rm list.txt
rm 00????.*
rm *.wav

