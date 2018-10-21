#!/bin/bash

set -xe

BASEDIR=$PWD
SRC_DIR=src
OUT_DIR=Release
CHROMIUM_REL=71.0.3572.1


mkdir -p chromium
cd chromium


if [ ! -d depot_tools ]
then
	git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
fi


export PATH=$PWD/depot_tools:$PATH

if [ ! -d $SRC_DIR ]
then
    git clone --depth 1 --branch  $CHROMIUM_REL https://github.com/chromium/chromium.git src
fi


if [ ! -f .gclient ]
then
	gclient root
	gclient config --spec 'solutions = [
  {
	"url": "https://chromium.googlesource.com/chromium/src.git",
	"managed": False,
	"name": "src",
	"custom_deps": {},
  },
]
target_os = [ "android" ]
'
fi


gclient sync --nohooks --with_branch_heads

cd $SRC_DIR

if [ ! -f .stamp_patched ]
then
    git am $BASEDIR/patches/0001-star-commit.patch
    touch .stamp_patched
fi

build/install-build-deps-android.sh

gclient runhooks

gn gen --args='target_os="android" is_debug=false enable_nacl=false symbol_level=0 remove_webcore_debug_symbols=true is_official_build=true enable_resource_whitelist_generation=false' out/$OUT_DIR

ninja -C out/$OUT_DIR giga_order_apk

