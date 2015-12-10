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

if [ "$AOSC_EC_ARCH" = "arm" ]; then
	source lib/kconfig_enum.sh
	float_abi="--with-float=$AOSC_EC_ARM_FLOAT_ABI"
	[ "$AOSC_EC_ARM_FLOAT_ABI" = "hard" ] && hard_float="--with-hard-float"
	[ "$AOSC_EC_ARM_FLOAT_ABI" != "soft" ] && fpu="--with-fpu=$AOSC_EC_ARM_FPU"
fi

case $gcc_ver in
	4.7*) disabled_libs="--disable-libgomp --disable-libmudflap --disable-libssp --disable-libatomic --disable-libquadmath" ;;
	5.2*) disabled_libs="--disable-libgomp --disable-libssp --disable-libatomic --disable-libitm --disable-libsanitizer --disable-libquadmath --disable-libvtv --disable-libcilkrts --disable-libstdc++-v3 " ;;
esac

mkdir build &&
cd build &&
../gcc-${gcc_ver}/configure --prefix="$tools_prefix" --target=${AOSC_EC_TRIPLET} \
	--with-sysroot="$sysroot" --disable-nls --disable-multilib --disable-shared \
	--without-headers --with-newlib --disable-decimal-float $disabled_libs \
	--disable-threads --enable-languages=c --with-arch=$(echo $TARGET_MARCH | cut -d = -f 2) \
	$float_abi $fpu $hard_float &&
MAKEFLAGS=$PAR_MAKEFLAGS make all-gcc all-target-libgcc&&
make DESTDIR=$PKGDIR install-gcc install-target-libgcc
