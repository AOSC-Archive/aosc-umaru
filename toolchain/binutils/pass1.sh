source toolchain/binutils/ver.sh

fprint="$(mktemp)"

echo "$PWD"/out/tools $AOSC_EC_ARCH $AOSC_EC_LIBC $AOSC_EC_TRIPLET > $fprint

rm -rf $PWD/out/build/binutils-pass1
mkdir -p $PWD/out/build/binutils-pass1

utils/build_cache/cache_build binutils-pass1-$binutils_ver-$AOSC_EC_TRIPLET $fprint "$PWD"/out/build/binutils-pass1/destdir toolchain/binutils/pass1_build.sh

rm $fprint

cp -r "$PWD"/out/build/binutils-pass1/destdir/"$PWD"/out/tools/* "$PWD"/out/tools/
