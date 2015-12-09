source base/utils/busybox/ver.sh

source ./.config

mkdir -p $(dirname $CONFIG_BASE_UTILS_BUSYBOX_CONFIG) 2>/dev/null

[ ! -e $CONFIG_BASE_UTILS_BUSYBOX_CONFIG ] && {
	if [ -e base/utils/busybox/${AOSC_EC_TRIPLET}_defconfig ]; then
		cp base/utils/busybox/${AOSC_EC_TRIPLET}_defconfig $CONFIG_BASE_UTILS_BUSYBOX_CONFIG
	elif [ -e base/utils/busybox/${AOSC_EC_LIBC}_defconfig ]; then
		cp base/utils/busybox/${AOSC_EC_LIBC}_defconfig $CONFIG_BASE_UTILS_BUSYBOX_CONFIG
	else
		cp base/utils/busybox/defconfig $CONFIG_BASE_UTILS_BUSYBOX_CONFIG
	fi
}

fprint="$(mktemp)"

echo $AOSC_EC_ARCH $AOSC_EC_LIBC $AOSC_EC_TRIPLET > $fprint

cat $CONFIG_BASE_UTILS_BUSYBOX_CONFIG >> $fprint

echo $TARGET_CFLAGS >> $fprint
echo $TARGET_CPPFLAGS >> $fprint

sh base/utils/busybox/check_config.sh $CONFIG_BASE_UTILS_BUSYBOX_CONFIG

rm -rf $PWD/out/build/busybox
mkdir -p $PWD/out/build/busybox

utils/build_cache/cache_build busybox-$busybox_ver-$AOSC_EC_TRIPLET $fprint "$PWD"/out/build/busybox/destdir base/utils/busybox/busybox_build.sh

rm $fprint

cp -r "$PWD"/out/build/busybox/destdir/bin "$PWD"/out/sysroot/

mkdir -p out/target/bin
cp out/sysroot/bin/busybox out/target/bin/
