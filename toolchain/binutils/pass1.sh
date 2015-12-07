mkdir -p out/build/binutils-pass1

source toolchain/binutils/ver.sh

utils/downloader/downloader toolchain/binutils/down/$binutils_ver || exit 1


