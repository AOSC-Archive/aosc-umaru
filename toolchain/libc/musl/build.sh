source toolchain/libc/musl/ver.sh
source toolchain/linux-headers/ver.sh
source toolchain/binutils/ver.sh
source toolchain/gcc/ver.sh

fprint="$(mktemp)"

echo "$PWD"/out/tools $AOSC_EC_ARCH $AOSC_EC_LIBC $AOSC_EC_TRIPLET "$PWD"/out/sysroot > $fprint
echo $binutils_ver >> $fprint
echo $gcc_ver >> $fprint
echo $linux_headers_ver >> $fprint

echo $TARGET_CFLAGS_MACHINE >> $fprint
echo $TARGET_CXXFLAGS_MACHINE >> $fprint

rm -rf $PWD/out/build/musl
mkdir -p $PWD/out/build/musl

utils/build_cache/cache_build musl-$musl_ver-$AOSC_EC_TRIPLET $fprint "$PWD"/out/build/musl/destdir toolchain/libc/musl/musl_build.sh

rm $fprint

cp -r "$PWD"/out/build/musl/destdir/"$PWD"/out/* "$PWD"/out/
