source toolchain/binutils/ver.sh

utils/downloader/downloader toolchain/binutils/down/$binutils_ver || exit 1

tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download

rm -rf out/build/binutils-pass1 &&
mkdir -p out/build/binutils-pass1 &&
cd out/build/binutils-pass1 &&

mkdir -p destdir

tar xvf "$downloads_prefix"/binutils-${binutils_ver}.tar.bz2 &&

mkdir build &&
cd build &&
../binutils-${binutils_ver}/configure --prefix="$tools_prefix" --target=${AOSC_EC_TRIPLET} \
	--with-sysroot="$tools_prefix"/${AOSC_EC_TRIPLET} --disable-nls --disable-multilib &&
make configure-host &&
make &&
make DESTDIR=$PKGDIR install
