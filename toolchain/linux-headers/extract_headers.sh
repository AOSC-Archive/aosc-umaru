source toolchain/linux-headers/ver.sh

case $AOSC_EC_ARCH in
	i386)
		karch=i386 ;;
	arm)
		karch=arm ;;
	*)
		echo UNSUPPORTED ARCHITECTURE; exit 1 ;;
esac

utils/downloader/downloader toolchain/linux-headers/down/$linux_headers_ver || exit 1

sysroot="$PWD"/out/sysroot
tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download

mkdir -p $PKGDIR/$sysroot/usr/include

cd out/build/linux-headers &&

mkdir -p destdir &&

tar xvf "$downloads_prefix"/linux-${linux_headers_ver}.tar.xz &&

cd linux-${linux_headers_ver} &&
make mrproper &&
make ARCH=${karch} headers_check &&
make ARCH=${karch} INSTALL_HDR_PATH=$PKGDIR/$sysroot/usr headers_install
