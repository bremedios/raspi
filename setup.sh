#!/bin/sh

# Current Release: walnascar
# Current LTS:     scarthgap
YOCTO_RELEASE=scarthgap
YOCTO_PLATFORM=qemux86-64
YOCTO_FOLDER=raspi-$YOCTO_RELEASE-$YOCTO_PLATFORM

SCRIPT_PATH=`pwd`

YOCTO_PATH=$SCRIPT_PATH/$YOCTO_FOLDER

#
#   Clone any repos that are missing
#
if [ ! -d "$YOCTO_PATH" ]; then
    git clone -b $YOCTO_RELEASE https://git.yoctoproject.org/poky $YOCTO_FOLDER
fi

cd $YOCTO_PATH

if [ ! -d "meta-raspberrypi" ]; then
    git clone -b $YOCTO_RELEASE https://github.com/agherzan/meta-raspberrypi
fi

if [ ! -d "meta-openembedded" ]; then
    git clone -b $YOCTO_RELEASE git://git.openembedded.org/meta-openembedded

    if [ -f "../patches/$YOCTO_RELEASE-meta-openembedded.patch" ] ; then
        cd meta-openembedded
        patch -p1 < ../../$YOCTO_RELEASE-meta-openembedded.patch
        cd $YOCTO_PATH
    fi
fi

if [ ! -d "meta-pinkraspi" ]; then
    git clone -b $YOCTO_RELEASE git@github.com:bremedios/meta-pinkraspi.git
fi

cd $YOCTO_PATH
git pull
cd $YOCTO_PATH/meta-raspberrypi
git pull
cd $YOCTO_PATH/meta-openembedded
git pull
cd $YOCTO_PATH/meta-pinkraspi
git pull

cd $YOCTO_PATH
./oe-init-build-env

cd $YOCTO_PATH/build

bitbake-layers add-layer ../meta-raspberrypi
bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-openembedded/meta-python
bitbake-layers add-layer ../meta-openembedded/meta-networking
bitbake-layers add-layer ../meta-openembedded/meta-multimedia
bitbake-layers add-layer ../meta-openembedded/meta-gnome
bitbake-layers add-layer ../meta-openembedded/meta-xfce
bitbake-layers add-layer ../meta-pinkraspi

cd $SCRIPT_PATH
