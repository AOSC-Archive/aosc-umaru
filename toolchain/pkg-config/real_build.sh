source toolchain/pkg-config/ver.sh

utils/downloader/downloader toolchain/pkg-config/down/$pkg_config_ver || exit 1

sysroot="$PWD"/out/sysroot
tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download

cd out/build/pkg-config &&

mkdir -p destdir &&

tar xvf "$downloads_prefix"/pkg-config-${pkg_config_ver}.tar.gz &&

mkdir build &&
cd build &&
../pkg-config-${pkg_config_ver}/configure --prefix="$tools_prefix" \
	$( [ "$CONFIG_TOOLCHAIN_PKG_CONFIG_BUILD_GLIB" != "y" ] && echo "--with-internal-glib" ) \
	--with-pc-path=$sysroot/usr/lib/pkgconfig:$sysroot/usr/share/pkgconfig --with-system-include-path=/usr/include \
	--with-system-library-path=/usr/lib --disable-host-tool &&
MAKEFLAGS=$PAR_MAKEFLAGS make &&
make DESTDIR=$PKGDIR install
