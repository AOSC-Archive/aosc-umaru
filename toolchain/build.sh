source ./.config

[ -e out/tools ] && rm -rf out/tools
mkdir -p out/tools

[ -e out/sysroot ] && rm -rf out/sysroot
mkdir -p out/sysroot

sh toolchain/binutils/pass1.sh
sh toolchain/gcc/pass1.sh
sh toolchain/linux-headers/build.sh
sh toolchain/libc/build.sh
sh toolchain/gcc/pass2.sh

# Below are optional toolchain packages
sh toolchain/pkg-config/build.sh
