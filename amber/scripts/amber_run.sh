#!/bin/bash

# if INPUT_ONEDATA_TOKEN is set...
if [ ! -z ${INPUT_ONEDATA_TOKEN+x} ]; then
   
   mkdir -p /onedata/input
   ONECLIENT_AUTHORIZATION_TOKEN="$INPUT_ONEDATA_TOKEN" PROVIDER_HOSTNAME="$INPUT_ONEDATA_PROVIDERS" oneclient --no_check_certificate --authentication token -o ro /onedata/input || exit 1
   INPUTDIR="/onedata/input/$INPUT_ONEDATA_SPACE/$INPUT_PATH"

else
   INPUTDIR="$MESOS_SANDBOX"
fi

# read env
OUTPUT_ONEDATA_TOKEN=${OUTPUT_ONEDATA_TOKEN:-$ONEDATA_SERVICE_TOKEN}
OUTPUT_ONEDATA_PROVIDERS=${OUTPUT_ONEDATA_PROVIDERS:-$ONEDATA_PROVIDERS}
OUTPUT_ONEDATA_SPACE=${OUTPUT_ONEDATA_SPACE:-$ONEDATA_SPACE}
OUTPUT_PATH=${OUTPUT_PATH:-$ONEDATA_PATH}
OUTPUTDIR="/onedata/output/$OUTPUT_ONEDATA_SPACE/$OUTPUT_PATH"

echo $OUTPUT_ONEDATA_TOKEN
echo $OUTPUT_ONEDATA_SPACE

# mount onedata output space
mkdir -p /onedata/output
ONECLIENT_AUTHORIZATION_TOKEN="$OUTPUT_ONEDATA_TOKEN" PROVIDER_HOSTNAME="$OUTPUT_ONEDATA_PROVIDERS" oneclient --no_check_certificate --authentication token -o rw /onedata/output || exit 1

# prepare output dir
mkdir -p "$OUTPUTDIR" || exit 1
rm -rf "$OUTPUTDIR"/*

WORKDIR="$OUTPUTDIR"/tmp
mkdir "$WORKDIR" 

# Extract input
echo Extracting input
tar xvfz "$INPUTDIR/in.tgz" --no-same-owner -C "$WORKDIR" || exit 1

echo Start at $(date)

cd "$WORKDIR" || exit 1

echo Run amber
# Run Amber tool *sander*
$AMBERHOME/bin/sander -O -i sander0.in -o sander0.out -p prmtop -c prmcrd -r sander0.crd -ref  prmcrd
if [ $? -eq 0 ]; then echo 1st step ok; else exit 1; fi

$AMBERHOME/bin/ambpdb -p prmtop -c sander0.crd > amber_final0.pdb
if [ $? -eq 0 ]; then echo 2nd step ok; else exit 1; fi

sleep 3

# Collect output
tar cvfz pro.tgz ./*  --exclude amber_run.sh

echo "Copying output data to folder $OUTPUTDIR"
cp pro.tgz "$OUTPUTDIR"/

if [ -e "$OUTPUTDIR"/pro.tgz ]; then
   echo "Output data generated"
   ec=0
else
   ec=1
fi
cd -

rm -rf "$WORKDIR"/*
echo End at $(date)

sleep 5

if [ ! -z ${INPUT_ONEDATA_TOKEN+x} ]; then
   umount /onedata/input || exit 1
fi

umount /onedata/output || exit 1
exit $ec

