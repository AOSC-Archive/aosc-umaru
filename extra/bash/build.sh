source extra/bash/ver.sh

source ./.config

source lib/ec_strip.sh

fprint="$(mktemp)"

echo $AOSC_EC_ARCH $AOSC_EC_LIBC $AOSC_EC_TRIPLET / > $fprint

echo $TARGET_CFLAGS >> $fprint
echo $TARGET_CPPFLAGS >> $fprint

cat out/fprint_comps/libc >> $fprint
cat out/fprint_comps/ncurses >> $fprint
[ "$CONFIG_EXTRA_BASH_READLINE" = "y" ] && echo readline used >> $fprint
[ "$CONFIG_EXTRA_BASH_DEBUNDLE_READLINE" = "y" ] && cat out/fprint_comps/readline >> $fprint

rm -rf $PWD/out/build/bash
mkdir -p $PWD/out/build/bash

utils/build_cache/cache_build bash-$bash_ver-$AOSC_EC_TRIPLET $fprint "$PWD"/out/build/bash/destdir extra/bash/bash_build.sh

rm $fprint

cp -r out/build/bash/destdir/* out/sysroot/

mkdir -p out/target/bin
cp out/sysroot/bin/bash out/target/bin/
