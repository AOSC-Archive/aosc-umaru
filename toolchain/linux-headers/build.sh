source toolchain/linux-headers/ver.sh

fprint="$(mktemp)"

echo "$PWD"/out/tools $AOSC_EC_ARCH $AOSC_EC_LIBC $AOSC_EC_TRIPLET "$PWD"/out/sysroot > $fprint

rm -rf $PWD/out/build/linux-headers
mkdir -p $PWD/out/build/linux-headers

utils/build_cache/cache_build linux-headers-$linux_headers_ver-$AOSC_EC_TRIPLET $fprint "$PWD"/out/build/linux-headers/destdir toolchain/linux-headers/extract_headers.sh

rm $fprint

cp -r "$PWD"/out/build/linux-headers/destdir/"$PWD"/out/* "$PWD"/out/
