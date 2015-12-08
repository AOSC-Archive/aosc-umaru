source toolchain/binutils/ver.sh

fprint="$(mktemp)"

echo "$PWD"/out/tools $AOSC_EC_ARCH $AOSC_EC_LIBC $AOSC_EC_TRIPLET "$PWD"/out/sysroot > $fprint

rm -rf $PWD/out/build/musl
mkdir -p $PWD/out/build/musl

utils/build_cache/cache_build musl-$binutils_ver-$AOSC_EC_TRIPLET $fprint "$PWD"/out/build/musl/destdir toolchain/libc/musl/musl_build.sh

rm $fprint

cp -r "$PWD"/out/build/musl/destdir/"$PWD"/out/* "$PWD"/out/
