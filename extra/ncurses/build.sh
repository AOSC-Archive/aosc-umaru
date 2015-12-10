source extra/ncurses/ver.sh

source ./.config

fprint="$(mktemp)"

echo $AOSC_EC_ARCH $AOSC_EC_LIBC $AOSC_EC_TRIPLET > $fprint

echo $TARGET_CFLAGS >> $fprint
echo $TARGET_CPPFLAGS >> $fprint

[ "$CONFIG_EXTRA_NCURSES_XX" = "y" ] && echo c++ $LIBSTDCXX_ABI_VER $TARGET_CXXFLAGS >> $fprint

rm -rf $PWD/out/build/ncurses
mkdir -p $PWD/out/build/ncurses

utils/build_cache/cache_build ncurses-$ncurses_ver-$AOSC_EC_TRIPLET $fprint "$PWD"/out/build/ncurses/destdir extra/ncurses/ncurses_build.sh

rm $fprint


