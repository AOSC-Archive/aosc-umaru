source vendor/aosc/linux-pc/ver.sh

source ./.config

mkdir -p $(dirname $CONFIG_AOSC_LINUX_PC_CONFIG_PATH) 2>/dev/null

[ ! -e $CONFIG_AOSC_LINUX_PC_CONFIG_PATH ] && {
	if [ -e vendor/aosc/linux-pc/${AOSC_EC_TRIPLET}_defconfig ]; then
		cp vendor/aosc/linux-pc/${AOSC_EC_TRIPLET}_defconfig $CONFIG_AOSC_LINUX_PC_CONFIG_PATH
	elif [ -e vendor/aosc/linux-pc/${AOSC_EC_ARCH}_defconfig ]; then
		cp vendor/aosc/linux-pc/${AOSC_EC_ARCH}_defconfig $CONFIG_AOSC_LINUX_PC_CONFIG_PATH
	else
		cp vendor/aosc/linux-pc/defconfig $CONFIG_AOSC_LINUX_PC_CONFIG_PATH
	fi
}

fprint="$(mktemp)"

echo $AOSC_EC_ARCH > $fprint

cat $CONFIG_AOSC_LINUX_PC_CONFIG_PATH >> $fprint

rm -rf $PWD/out/build/aosc-linux-pc
mkdir -p $PWD/out/build/aosc-linuc-pc

utils/build_cache/cache_build aosc-linux-pc-$linux_pc_ver-$AOSC_EC_ARCH $fprint "$PWD"/out/build/aosc-linux-pc/destdir vendor/aosc/linux-pc/kbuild.sh

rm $fprint

cp -r "$PWD"/out/build/aosc-linux-pc/destdir/* "$PWD"/out/sysroot/
