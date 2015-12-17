source toolchain/pkg-config/ver.sh

fprint="$(mktemp)"

echo "$PWD"/out/tools  $AOSC_EC_TRIPLET "$PWD"/out/sysroot > $fprint

grep '^CONFIG_TOOLCHAIN_PKG_CONFIG_BUILD_GLIB=' ./.config >> $fprint

rm -rf $PWD/out/build/pkg-config
mkdir -p $PWD/out/build/pkg-config

utils/build_cache/cache_build pkg-config-$pkg-config_ver-$AOSC_EC_TRIPLET $fprint "$PWD"/out/build/pkg-config/destdir toolchain/pkg-config/real_build.sh

rm $fprint

cp -r "$PWD"/out/build/pkg-config/destdir/"$PWD"/out/* "$PWD"/out/
