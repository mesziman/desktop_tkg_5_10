#!/bin/bash
dpkg --add-architecture amd64
apt-get -qq update > /dev/null ;
apt-get -qq install -y  dialog apt-utils > /dev/null ;
apt-get remove -y clang;
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get -qq install -y lz4 git llvm clang lld build-essential wget tar kernel-package fakeroot libncurses5-dev libssl-dev ccache bison flex qtbase5-dev wget rsync kmod cpio libelf-dev
export LOFASZ=$PWD;

mkdir -p /pipeline/build/root/toolchain/gcc;
cd /pipeline/build/root/toolchain/gcc;
wget https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/10.1.0/x86_64-gcc-10.1.0-nolibc-x86_64-linux.tar.xz
tar xf x86_64-gcc-10.1.0-nolibc-x86_64-linux.tar.xz
cd $LOFASZ
bash builder.sh
