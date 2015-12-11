source extra/readline/ver.sh

source ./.config

utils/downloader/downloader extra/readline/down/$readline_ver || exit 1

sysroot="$PWD"/out/sysroot
tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download
patches="$PWD"/extra/readline/patches

mkdir -p out/build/readline &&
cd out/build/readline &&

mkdir -p destdir &&

tar xvf "$downloads_prefix"/readline-${readline_ver}.tar.gz &&

cd readline-${readline_ver} &&

( [ -e $patches/patch-$readline_ver ] && source $patches/patch-$readline_ver || true ) &&
cp $patches/config.cache-$AOSC_EC_TRIPLET config.cache &&
PATH=$tools_prefix/bin:$PATH CFLAGS="$TARGET_CFLAGS" CPPFLAGS="$TARGET_CPPFLAGS" ./configure --host=$AOSC_EC_TRIPLET --prefix=/usr --includedir=$sysroot/usr/include --cache-file=config.cache &&
PATH=$tools_prefix/bin:$PATH MAKEFLAGS=$PAR_MAKEFLAGS make SHLIB_LIBS=-lncurses &&
PATH=$tools_prefix/bin:$PATH make DESTDIR=$PKGDIR SHLIB_LIBS=-lncurses install &&
cp -r $PKGDIR/$sysroot/usr/ $PKGDIR/ &&
rm -rf $PKGDIR/$sysroot/
