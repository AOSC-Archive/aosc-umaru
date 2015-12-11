source extra/bash/ver.sh

source ./.config

source lib/kconfig_expr.sh

utils/downloader/downloader extra/bash/down/$bash_ver || exit 1

sysroot="$PWD"/out/sysroot
tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download
patches="$PWD"/extra/bash/patches

[ "$CONFIG_EXTRA_BASH_SHARED" = "y" ] || static="-static"

mkdir -p out/build/bash &&
cd out/build/bash &&

mkdir -p destdir &&

tar xvf "$downloads_prefix"/bash-${bash_ver}.tar.gz &&

cd bash-${bash_ver} &&

( [ -e $patches/patch-$bash_ver ] && source $patches/patch-$bash_ver || true ) &&
cp $patches/config.cache-$AOSC_EC_TRIPLET config.cache &&
PATH=$tools_prefix/bin:$PATH CFLAGS="$TARGET_CFLAGS" CPPFLAGS="$TARGET_CPPFLAGS" \
	LDFLAGS="$static" \
	./configure --host=$AOSC_EC_TRIPLET --prefix=/usr --includedir=$sysroot/usr/include \
	--cache-file=config.cache --bindir=/bin --without-bash-malloc \
	--$(kconfig_expr CONFIG_EXTRA_BASH_READLINE enable)-readline \
	--$(kconfig_expr CONFIG_EXTRA_BASH_DEBUNDLE_READLINE with)-installed-readline$( [ "$CONFIG_EXTRA_BASH_DEBUNDLE_READLINE" = "y" ] && echo "=$sysroot/usr") &&
PATH=$tools_prefix/bin:$PATH MAKEFLAGS=$PAR_MAKEFLAGS make SHLIB_LIBS=-lncurses &&
PATH=$tools_prefix/bin:$PATH make DESTDIR=$PKGDIR SHLIB_LIBS=-lncurses install
