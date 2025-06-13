#!/bin/sh

# Current Release: walnascar
# Current LTS:     scarthgap
YOCTO_RELEASE=scarthgap
YOCTO_FOLDER=raspi-scarthgap-qemux86-64

SCRIPT_PATH=`pwd`

YOCTO_PATH=$SCRIPT_PATH/$YOCTO_FOLDER

echo "Moving to $YOCTO_PATH/build"
cd $YOCTO_PATH/build

bitbake pinktablet-dev-image

cd $SCRIPT_PATH
