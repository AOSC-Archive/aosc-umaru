source vendor/aosc/linux-pc/ver.sh

source ./.config

case $AOSC_EC_ARCH in
	i386)
		karch=i386 ;;
	*)
		echo UNSUPPORTED ARCHITECTURE; exit 1 ;;
esac

utils/downloader/downloader vendor/aosc/linux-pc/down/$linux_pc_ver || exit 1

sysroot="$PWD"/out/sysroot
tools_prefix="$PWD"/out/tools
downloads_prefix="$PWD"/out/download

config_file=$(readlink -m $CONFIG_AOSC_LINUX_PC_CONFIG_PATH)

mkdir -p out/build/aosc-linux-pc &&
cd out/build/aosc-linux-pc &&

mkdir -p destdir &&

tar xvf "$downloads_prefix"/linux-${linux_pc_ver}.tar.xz &&

cd linux-${linux_pc_ver} &&
cp $config_file .config &&
MAKEFLAGS=$PAR_MAKEFLAGS make CROSS_COMPILE=$tools_prefix/bin/$AOSC_EC_TRIPLET- ARCH=$karch &&
make INSTALL_MOD_PATH=$PKGDIR modules_install &&
mkdir -p $PKGDIR/boot &&
cp arch/x86/boot/bzImage $PKGDIR/boot/vmlinuz
