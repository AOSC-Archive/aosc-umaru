source toolchain/libc/musl/ver.sh

utils/downloader/downloader toolchain/libc/musl/down/$musl_ver || exit 1

sysroot="$PWD"/out/sysroot
tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download

cd out/build/musl &&

mkdir -p destdir &&

tar xvf "$downloads_prefix"/musl-${musl_ver}.tar.bz2 &&

cd musl-${musl_ver} &&
PATH=$tools_prefix/bin:$PATH CC=$tools_prefix/bin/${AOSC_EC_TRIPLET}-gcc \
	./configure --prefix=/usr --host=${AOSC_EC_TRIPLET} &&
MAKEFLAGS=$PAR_MAKEFLAGS make &&
make DESTDIR=$PKGDIR/$sysroot install
