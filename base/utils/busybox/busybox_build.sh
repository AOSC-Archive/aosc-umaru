source base/utils/busybox/ver.sh

source ./.config

utils/downloader/downloader base/utils/busybox/down/$busybox_ver || exit 1

sysroot="$PWD"/out/sysroot
tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download

config_file=$(readlink -m $CONFIG_BASE_UTILS_BUSYBOX_CONFIG)

mkdir -p out/build/busybox &&
cd out/build/busybox &&

mkdir -p destdir &&

tar xvf "$downloads_prefix"/busybox-${busybox_ver}.tar.bz2 &&

cd busybox-${busybox_ver} &&
cp $config_file .config &&
sed -i 's@^CONFIG_SYSROOT=@CONFIG_SYSROOT="'"$sysroot"'" \n# @g' .config &&
MAKEFLAGS=$PAR_MAKEFLAGS make CFLAGS="$TARGET_CFLAGS" CXXFLAGS="$TARGET_CXXFLAGS" CROSS_COMPILE=$tools_prefix/bin/$AOSC_EC_TRIPLET- &&
mkdir -p $PKGDIR/bin &&
cp busybox $PKGDIR/bin/
