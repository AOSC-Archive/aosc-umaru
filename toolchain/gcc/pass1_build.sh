source toolchain/gcc/ver.sh

utils/downloader/downloader toolchain/gcc/down/$gcc_ver || exit 1

sysroot="$PWD"/out/sysroot
tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download

patch_prefix="$PWD"/toolchain/gcc/patches

cd out/build/gcc-pass1 &&

mkdir -p destdir &&

tar xvf "$downloads_prefix"/gcc-${gcc_ver}.tar.bz2 &&

cd gcc-${gcc_ver} &&
([ -e $patch_prefix/$gcc_ver-patch.sh ] && PATCHES=$patch_prefix sh $patch_prefix/$gcc_ver-patch.sh || true) &&
cd .. &&

mkdir build &&
cd build &&
../gcc-${gcc_ver}/configure --prefix="$tools_prefix" --target=${AOSC_EC_TRIPLET} \
	--with-sysroot="$sysroot" --disable-nls --disable-multilib \
	--without-headers --with-newlib --disable-decimal-float --disable-libgomp \
	--disable-libmudflap --disable-libssp --disable-libatomic --disable-libquadmath \
	--disable-threads --enable-languages=c --with-arch=$(echo $TARGET_MARCH | cut -d = -f 2) &&
MAKEFLAGS=$PAR_MAKEFLAGS make all-gcc all-target-libgcc&&
make DESTDIR=$PKGDIR install-gcc install-target-libgcc
