#!/bin/bash
git submodule init scripts
git submodule update scripts

KERNEL_DIR=$PWD
CCACHEDIR=../CCACHE/kernel
TOOLCHAINDIR=/pipeline/build/root/toolchain/gcc/gcc-10.1.0-nolibc/x86_64-linux
DATE=$(date +"%d%m%Y")
VER=$(git rev-parse --short HEAD)
FINAL_ZIP="tkg-notebook-"$VER"".zip
corenumber=$( nproc --all )
buildspeed=$(( $corenumber + 2 ))

export PATH="/usr/lib/ccache/bin/:$PATH"
export CCACHE_SLOPPINESS="file_macro,locale,time_macros"
export CCACHE_NOHASHDIR="true"
export PATH="${TOOLCHAINDIR}/bin:${TOOLCHAINDIR}/lib:${TOOLCHAINDIR}/include:${PATH}"
export KBUILD_BUILD_USER="mesziman"
export KBUILD_BUILD_HOST="github"


PATH="${TOOLCHAINDIR}/bin:${TOOLCHAINDIR}/lib:${TOOLCHAINDIR}/include:${PATH}" \
make -j ${buildspeed} deb-pkg CROSS_COMPILE=${TOOLCHAINDIR}/bin/x86_64-linux- LOCALVERSION=-"tkg-gcc" -s;

echo "======================VERIFY CLANG==============================="
cat ./include/generated/compile.h
echo "======================VERIFY CLANG==============================="
zip -r9 $FINAL_ZIP ../*.deb
cp $FINAL_ZIP ${WERCKER_REPORT_ARTIFACTS_DIR}/
mv $FINAL_ZIP /pipeline/output/$FINAL_ZIP
