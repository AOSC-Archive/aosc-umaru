source extra/ncurses/ver.sh

source ./.config

utils/downloader/downloader extra/ncurses/down/$ncurses_ver || exit 1

sysroot="$PWD"/out/sysroot
tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download

mkdir -p out/build/ncurses &&
cd out/build/ncurses &&

mkdir -p destdir &&

tar xvf "$downloads_prefix"/ncurses-${ncurses_ver}.tar.gz &&

cd ncurses-${ncurses_ver} &&
PATH=$tools_prefix/bin:$PATH CFLAGS="$TARGET_CFLAGS" CXXFLAGS="$TARGET_CXXFLAGS" CPPFLAGS="$TARGET_CPPFLAGS" ./configure --host=$AOSC_EC_TRIPLET --prefix=/usr --mandir=/usr/share/man --with-shared --without-debug --enable-pc-files $([ "$CONFIG_EXTRA_NCURSES_WIDE" = "y" ] && echo --enable-widec ) $([ "$CONFIG_EXTRA_NCURSES_XX" != "y" ] && echo --without-cxx-binding ) &&
PATH=$tools_prefix/bin:$PATH MAKEFLAGS=$PAR_MAKEFLAGS make &&
PATH=$tools_prefix/bin:$PATH make DESTDIR=$PKGDIR install
