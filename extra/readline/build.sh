source extra/readline/ver.sh

source ./.config

fprint="$(mktemp)"

echo $AOSC_EC_ARCH $AOSC_EC_LIBC $AOSC_EC_TRIPLET / > $fprint

echo $TARGET_CFLAGS >> $fprint
echo $TARGET_CPPFLAGS >> $fprint

cat out/fprint_comps/libc >> $fprint
cat out/fprint_comps/ncurses >> $fprint

rm -rf $PWD/out/build/readline
mkdir -p $PWD/out/build/readline

utils/build_cache/cache_build readline-$readline_ver-$AOSC_EC_TRIPLET $fprint "$PWD"/out/build/readline/destdir extra/readline/readline_build.sh

rm $fprint

cp -r out/build/readline/destdir/usr out/sysroot/

if [ "$CONFIG_EXTRA_READLINE_INSTALL_SHARED" = "y" ]; then
	mkdir -p out/target/usr/lib/
	cp out/sysroot/usr/lib/libreadline.so.6 out/target/usr/lib/
	[ "$CONFIG_EXTRA_READLINE_INSTALL_SHARED_HISTORY" = "y" ] && cp out/sysroot/usr/lib/libhistory.so.6 out/target/usr/lib/
fi

mkdir -p out/fprint_comps

echo readline: > out/fprint_comps/readline
echo abi6 >> out/fprint_comps/readline
cat out/fprint_comps/libc >> out/fprint_comps/readline
cat out/fprint_comps/ncurses >> out/fprint_comps/readline
