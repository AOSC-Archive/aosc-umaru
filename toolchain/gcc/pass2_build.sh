source toolchain/gcc/ver.sh

utils/downloader/downloader toolchain/gcc/down/$gcc_ver || exit 1

sysroot="$PWD"/out/sysroot
tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download

patch_prefix="$PWD"/toolchain/gcc/patches

cd out/build/gcc-pass2 &&

mkdir -p destdir &&

tar xvf "$downloads_prefix"/gcc-${gcc_ver}.tar.bz2 &&

cd gcc-${gcc_ver} &&
([ -e $patch_prefix/$gcc_ver-patch.sh ] && PATCHES=$patch_prefix sh $patch_prefix/$gcc_ver-patch.sh || true) &&
cd .. &&

mkdir build &&
cd build &&
../gcc-${gcc_ver}/configure --prefix="$tools_prefix" --target=${AOSC_EC_TRIPLET} \
	--with-sysroot="$sysroot" --disable-nls --disable-multilib \
	--enable-c99 --enable-long-long \
	--enable-languages=c,c++ --with-arch=$(echo $TARGET_MARCH | cut -d = -f 2) &&
MAKEFLAGS=$PAR_MAKEFLAGS make &&
make DESTDIR=$PKGDIR install
