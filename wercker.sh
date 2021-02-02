#!/bin/bash
dpkg --add-architecture amd64
apt-get -qq update > /dev/null ;
apt-get -qq install -y  dialog apt-utils > /dev/null ;
apt-get remove -y clang;
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get -qq install -y lz4 git llvm-11 clang-11 lld-11 build-essential wget tar kernel-package fakeroot libncurses5-dev libssl-dev ccache bison flex qtbase5-dev wget rsync kmod cpio libelf-dev
export LOFASZ=$PWD;
update-alternatives --remove-all clang
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-11 100
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-11 100
update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-11 100
update-alternatives --remove-all lld
update-alternatives --install /usr/bin/ld.lld ld.lld /usr/bin/ld.lld-11 100
update-alternatives --remove-all llvm
update-alternatives --install /usr/bin/llvm-as llvm-as /usr/bin/llvm-as-11 100
update-alternatives --install /usr/bin/llvm-ar llvm-ar /usr/bin/llvm-ar-11 100
update-alternatives --install /usr/bin/llvm-nm llvm-nm /usr/bin/llvm-nm-11 100
update-alternatives --install /usr/bin/llvm-objcopy llvm-objcopy /usr/bin/llvm-objcopy-11 100
update-alternatives --install /usr/bin/llvm-objdump llvm-objdump /usr/bin/llvm-objdump-11 100
update-alternatives --install /usr/bin/llvm-strip llvm-strip /usr/bin/llvm-strip-11 100

mkdir -p /pipeline/build/root/toolchain/gcc;
cd /pipeline/build/root/toolchain/gcc;
wget https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/10.1.0/x86_64-gcc-10.1.0-nolibc-x86_64-linux.tar.xz
tar xf x86_64-gcc-10.1.0-nolibc-x86_64-linux.tar.xz
cd $LOFASZ
bash builder.sh
