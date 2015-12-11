source extra/ncurses/ver.sh

source ./.config

source lib/ec_strip.sh

fprint="$(mktemp)"

echo $AOSC_EC_ARCH $AOSC_EC_LIBC $AOSC_EC_TRIPLET / > $fprint

echo $TARGET_CFLAGS >> $fprint
echo $TARGET_CPPFLAGS >> $fprint

cat out/fprint_comps/libc >> $fprint

[ "$CONFIG_EXTRA_NCURSES_XX" = "y" ] && echo c++ $LIBSTDCXX_ABI_VER $TARGET_CXXFLAGS >> $fprint

[ "$CONFIG_EXTRA_NCURSES_WIDE" = "y" ] && echo w >> $fprint

rm -rf $PWD/out/build/ncurses
mkdir -p $PWD/out/build/ncurses

utils/build_cache/cache_build ncurses-$ncurses_ver-$AOSC_EC_TRIPLET $fprint "$PWD"/out/build/ncurses/destdir extra/ncurses/ncurses_build.sh

rm $fprint

cp -r out/build/ncurses/destdir/usr out/sysroot/
mkdir -p out/sysroot/usr/lib/pkgconfig
cp -r out/build/ncurses/destdir/lib/pkgconfig out/sysroot/usr/lib/

if [ "$CONFIG_EXTRA_NCURSES_WIDE" = "y" ]; then
	for i in ncurses form menu panel
	do
		ln -sv lib${i}w.a out/sysroot/usr/lib/lib${i}.a
		ln -sv lib${i}w.so out/sysroot/usr/lib/lib${i}.so
	done
	[ "$CONFIG_EXTRA_NCURSES_XX" = "y" ] && ln -sv libncurses++w.a out/sysroot/usr/lib/libncurses++.a
fi

if [ "$CONFIG_EXTRA_NCURSES_INSTALL_SHARED" = "y" ]; then
	[ "$CONFIG_EXTRA_NCURSES_WIDE" = "y" ] && w=w
	mkdir -p out/target/usr/lib/
	cp out/sysroot/usr/lib/libncurses${w}.so.6 out/target/usr/lib/
	[ "$CONFIG_EXTRA_NCURSES_INSTALL_SHARED_FORM" = "y" ] && cp out/sysroot/usr/lib/libform${w}.so.6 out/target/usr/lib/
	[ "$CONFIG_EXTRA_NCURSES_INSTALL_SHARED_MENU" = "y" ] && cp out/sysroot/usr/lib/libmenu${w}.so.6 out/target/usr/lib/
	[ "$CONFIG_EXTRA_NCURSES_INSTALL_SHARED_PANEL" = "y" ] && cp out/sysroot/usr/lib/libpanel${w}.so.6 out/target/usr/lib/
	for i in ncurses form menu panel
	do
		ec_strip out/target/usr/lib/lib${i}${w}.so.6
	done
fi

if [ "$CONFIG_EXTRA_NCURSES_TERMINFO" ]; then
	mkdir -p out/target/usr/share/terminfo out/target/usr/lib
	ln -sfv ../share/terminfo out/target/usr/lib/
	for i in $CONFIG_EXTRA_NCURSES_TERMINFO
	do
		subdir=$(echo $i | cut -c 1)
		mkdir -p out/target/usr/share/terminfo/$subdir
		cp out/{sysroot,target}/usr/share/terminfo/$subdir/$i
	done
fi

mkdir -p out/fprint_comps

echo ncurses: > out/fprint_comps/ncurses
echo abi6 >> out/fprint_comps/ncurses
[ "$CONFIG_EXTRA_NCURSES_WIDE" = "y" ] && echo w >> out/fprint_comps/ncurses
cat out/fprint_comps/libc >> out/fprint_comps/ncurses
