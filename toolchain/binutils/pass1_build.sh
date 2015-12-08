source toolchain/binutils/ver.sh

utils/downloader/downloader toolchain/binutils/down/$binutils_ver || exit 1

sysroot="$PWD"/out/sysroot
tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download

cd out/build/binutils-pass1 &&

mkdir -p destdir &&

tar xvf "$downloads_prefix"/binutils-${binutils_ver}.tar.bz2 &&

mkdir build &&
cd build &&
../binutils-${binutils_ver}/configure --prefix="$tools_prefix" --target=${AOSC_EC_TRIPLET} \
	--with-sysroot="$sysroot" --disable-nls --disable-multilib &&
make configure-host &&
MAKEFLAGS=$PAR_MAKEFLAGS make &&
make DESTDIR=$PKGDIR install
